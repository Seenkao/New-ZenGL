{
 *  Copyright (c) 2012 Andrey Kemka
 *
 *  This software is provided 'as-is', without any express or
 *  implied warranty. In no event will the authors be held
 *  liable for any damages arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute
 *  it freely, subject to the following restrictions:
 *
 *  1. The origin of this software must not be misrepresented;
 *     you must not claim that you wrote the original software.
 *     If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but
 *     is not required.
 *
 *  2. Altered source versions must be plainly marked as such,
 *     and must not be misrepresented as being the original software.
 *
 *  3. This notice may not be removed or altered from any
 *     source distribution.
}
unit zgl_ini;

{$I zgl_config.cfg}

interface
uses
  zgl_memory;

function  ini_LoadFromFile(const FileName: UTF8String): Boolean;
procedure ini_SaveToFile(const FileName: UTF8String);
procedure ini_Free;
procedure ini_Add(const Section, Key: UTF8String);
procedure ini_Del(const Section, Key: UTF8String);
procedure ini_Clear(const Section: UTF8String);
function  ini_IsSection(const Section: UTF8String): Boolean;
function  ini_IsKey(const Section, Key: UTF8String): Boolean;
function  ini_ReadKeyStr(const Section, Key: UTF8String): UTF8String;
function  ini_ReadKeyInt(const Section, Key: UTF8String): Integer;
function  ini_ReadKeyFloat(const Section, Key: UTF8String): Single;
function  ini_ReadKeyBool(const Section, Key: UTF8String): Boolean;
function  ini_WriteKeyStr(const Section, Key, Value: UTF8String): Boolean;
function  ini_WriteKeyInt(const Section, Key: UTF8String; Value: Integer): Boolean;
function  ini_WriteKeyFloat(const Section, Key: UTF8String; Value: Single; Digits: Integer = 2): Boolean;
function  ini_WriteKeyBool(const Section, Key: UTF8String; Value: Boolean): Boolean;

function _ini_ReadKeyStr(const Section, Key: UTF8String): PAnsiChar;

implementation
uses
  zgl_types,
  zgl_file,
  zgl_utils;

type
  zglPINIKey = ^zglTINIKey;
  zglTINIKey = record
    Hash: LongWord;
    Name: UTF8String;
    Value: UTF8String;
end;

type
  zglPINISection = ^zglTINISection;
  zglTINISection = record
    Hash: LongWord;
    Name: UTF8String;
    Keys: LongWord;
    Key: array of zglTINIKey;
end;

type
  zglPINI = ^zglTINI;
  zglTINI = record
    FileName: UTF8String;
    Sections: Integer;
    Section: array of zglTINISection;
end;

var
  iniRec: zglTINI;
  iniMem: zglTMemory;

function delSpaces(const str: UTF8String): UTF8String;
  var
    i, b, e: Integer;
begin
  b := 1;
  e := Length(str);
  for i := 1 to Length(str) do
    if str[i] = ' ' Then
      INC(b)
    else
      break;

  for i := Length(str) downto 1 do
    if str[i] = ' ' Then
      DEC(e)
    else
      break;

  Result := copy(str, b, e - b + 1);
end;

procedure addData(const str: UTF8String);
  var
    i, j, s, k, len: Integer;
begin
  if str = '' Then exit;
  if str[1] = ';' Then exit;
  len := Length(str);

  if (str[1] = '[') and (str[len] = ']') Then
    begin
      INC(iniRec.Sections);
      s := iniRec.Sections - 1;

      SetLength(iniRec.Section, iniRec.Sections);

      iniRec.Section[s].Name := copy(str, 2, len - 2);
      iniRec.Section[s].Name := delSpaces(iniRec.Section[s].Name);
      iniRec.Section[s].Hash := u_Hash(iniRec.Section[s].Name);
    end else
      begin
        s := iniRec.Sections - 1;
        if s < 0 Then exit;
        INC(iniRec.Section[s].Keys);
        k := iniRec.Section[s].Keys - 1;

        j := 0;
        SetLength(iniRec.Section[s].Key, iniRec.Section[s].Keys);
        for i := 1 to len do
          if str[i] = '=' Then
            begin
              iniRec.Section[s].Key[k].Name := copy(str, 1, i - 1);
              j := i;
              break;
            end;
        iniRec.Section[s].Key[k].Name := delSpaces(iniRec.Section[s].Key[k].Name);
        iniRec.Section[s].Key[k].Hash := u_Hash(iniRec.Section[s].Key[k].Name);

        iniRec.Section[s].Key[k].Value := copy(str, j + 1, len - j);
        iniRec.Section[s].Key[k].Value := delSpaces(iniRec.Section[s].Key[k].Value);
      end;
end;

procedure ini_CopyKey(var k1, k2: zglTINIKey);
begin
  k1.Hash  := k2.Hash;
  k1.Name  := k2.Name;
  k1.Value := k2.Value;
end;

procedure ini_CopySection(var s1, s2: zglTINISection);
  var
    i: Integer;
begin
  s1.Hash := s2.Hash;
  s1.Name := s2.Name;
  s1.Keys := s2.Keys;
  SetLength(s1.Key, s1.Keys);
  for i := 0 to s1.Keys - 1 do
    ini_CopyKey(s1.Key[i], s2.Key[i]);
end;

function ini_GetID(const S, K: UTF8String; out idS, idK: Integer): Boolean;
  var
    h1, h2: LongWord;
    i, j : Integer;
begin
  idS := -1;
  idK := -1;
  h1  := u_Hash(S);
  h2  := u_Hash(K);

  Result := FALSE;
  for i := 0 to iniRec.Sections - 1 do
    if h1 = iniRec.Section[i].Hash Then
      begin
        idS := i;
        for j := 0 to iniRec.Section[i].Keys - 1 do
          if h2 = iniRec.Section[i].Key[j].Hash Then
            begin
              idK := j;
              Result := TRUE;
              exit;
            end;
        exit;
      end;
end;

procedure ini_Process;
  var
    lineEnd   : PByte;
    iniEnd    : Ptr;
    lastPos   : Ptr;
    newLine   : Boolean;
    newLineSize: Integer;
    str       : UTF8String;
    len       : Integer;
begin
  lineEnd := iniMem.Memory;
  iniEnd  := Ptr(iniMem.Memory) + iniMem.Size;
  lastPos := Ptr(lineEnd);
  str     := '';

  while Ptr(lineEnd) < iniEnd do
    begin
      newLine     := lineEnd^ = 10;
      newLineSize := 0;
      if (not newLine) and (lineEnd^ = 13) Then
        begin
          INC(lineEnd);
          newLine     := lineEnd^ = 10;
          newLineSize := 1;
        end;

      if newLine Then
        begin
          len := Ptr(lineEnd) - lastPos - newLineSize;
          if len <= 0 Then
            begin
              INC(lineEnd);
              lastPos := Ptr(lineEnd);
              continue;
            end;
          SetLength(str, len);
          Move(PByte(lastPos)^, str[1], len);
          addData(str);

          lastPos := Ptr(lineEnd) + 1;
        end;

      INC(lineEnd);
    end;

  len := Ptr(lineEnd) - lastPos;
  if len > 0 Then
    begin
      SetLength(str, len);
      Move(PByte(lastPos)^, str[1], len);
      addData(str);
    end;
end;

function ini_LoadFromFile(const FileName: UTF8String): Boolean;
begin
  Result := FALSE;
  ini_Free();
  if not file_Exists(FileName) Then exit;
  iniRec.FileName := utf8_Copy(FileName);

  mem_LoadFromFile(iniMem, FileName);
  ini_Process();
  mem_Free(iniMem);
  Result := TRUE;
end;

procedure ini_SaveToFile(const FileName: UTF8String);
  var
    f  : zglTFile;
    i, j: Integer;
    s  : UTF8String;
begin
  file_Open(f, FileName, FOM_CREATE);
  for i := 0 to iniRec.Sections - 1 do
    begin
      s := '[' + iniRec.Section[i].Name + ']' + #13#10;
      file_Write(f, s[1], Length(s));
      for j := 0 to iniRec.Section[i].Keys - 1 do
        begin
          s := iniRec.Section[i].Key[j].Name + ' = ';
          file_Write(f, s[1], Length(s));
          s := iniRec.Section[i].Key[j].Value + #13#10;
          file_Write(f, s[1], Length(s));
        end;
      if i = iniRec.Sections - 1 Then break;
        begin
          s := #13#10;
          file_Write(f, s[1], 2);
        end;
    end;
  file_Close(f);
end;

procedure ini_Free;
begin
  iniRec.Sections := 0;
  SetLength(iniRec.Section, 0);
end;

procedure ini_Add(const Section, Key: UTF8String);
  var
    s, k : UTF8String;
    ns, nk: Integer;
begin
  s := utf8_Copy(Section);
  k := utf8_Copy(Key);

  ini_GetID(s, k, ns, nk);

  if ns = -1 Then
    begin
      INC(iniRec.Sections);
      ns := iniRec.Sections - 1;

      SetLength(iniRec.Section, iniRec.Sections);
      iniRec.Section[ns].Hash := u_Hash(s);
      iniRec.Section[ns].Name := s;
    end;

  if nk = -1 Then
    begin
      INC(iniRec.Section[ns].Keys);
      nk := iniRec.Section[ns].Keys - 1;

      SetLength(iniRec.Section[ns].Key, iniRec.Section[ns].Keys);
      iniRec.Section[ns].Key[nk].Hash := u_Hash(k);
      iniRec.Section[ns].Key[nk].Name := k;
    end;
end;

procedure ini_Del(const Section, Key: UTF8String);
  var
    s, k: UTF8String;
    i, ns, nk: Integer;
begin
  s := Section;
  k := Key;

  if (k <> '') and ini_IsKey(s, k) and ini_GetID(s, k, ns, nk) Then
    begin
      DEC(iniRec.Section[ns].Keys);
      for i := nk to iniRec.Section[ns].Keys - 1 do
        ini_CopyKey(iniRec.Section[ns].Key[i], iniRec.Section[ns].Key[i + 1]);
      SetLength(iniRec.Section[ns].Key, iniRec.Section[ns].Keys + 1);
    end else
      if ini_IsSection(s) Then
        begin
          ini_GetID(s, k, ns, nk);

          DEC(iniRec.Sections);
          for i := ns to iniRec.Sections - 1 do
            ini_CopySection(iniRec.Section[i], iniRec.Section[i + 1]);
          iniRec.Section[iniRec.Sections].Keys := 0;
          SetLength(iniRec.Section, iniRec.Sections + 1);
        end;
end;

procedure ini_Clear(const Section: UTF8String);
  var
    s: UTF8String;
    ns, nk: Integer;
begin
  s := Section;

  if s = '' Then
    begin
      for ns := 0 to iniRec.Sections - 1 do
        begin
          iniRec.Section[ns].Name := '';
          for nk := 0 to iniRec.Section[ns].Keys - 1 do
            begin
              iniRec.Section[ns].Key[nk].Name  := '';
              iniRec.Section[ns].Key[nk].Value := '';
            end;
          iniRec.Section[ns].Keys := 0;
          SetLength(iniRec.Section[ns].Key, 0);
        end;
      iniRec.Sections := 0;
      SetLength(iniRec.Section, 0);
    end else
      if ini_IsSection(s) Then
        begin
          ini_GetID(s, '', ns, nk);

          for nk := 0 to iniRec.Section[ns].Keys - 1 do
            begin
              iniRec.Section[ns].Key[nk].Name  := '';
              iniRec.Section[ns].Key[nk].Value := '';
            end;
          iniRec.Section[ns].Keys := 0;
          SetLength(iniRec.Section[ns].Key, 0);
        end;
end;

function ini_IsSection(const Section: UTF8String): Boolean;
  var
    s: UTF8String;
    i, j: Integer;
begin
  s := Section;

  i := -1;
  ini_GetID(s, '', i, j);
  Result := i <> -1;
end;

function ini_IsKey(const Section, Key: UTF8String): Boolean;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  s := Section;
  k := Key;

  Result := ini_GetID(s, k, i, j);
end;

function ini_ReadKeyStr(const Section, Key: UTF8String): UTF8String;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  Result := '';
  s := Section;
  k := Key;

  if ini_GetID(s, k, i, j) Then
    Result := iniRec.Section[i].Key[j].Value;
end;

function ini_ReadKeyInt(const Section, Key: UTF8String): Integer;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  Result := 0;
  s := UTF8String(Section);
  k := UTF8String(Key);

  if ini_GetID(s, k, i, j) Then
    Result := u_StrToInt(iniRec.Section[i].Key[j].Value);
end;

function ini_ReadKeyFloat(const Section, Key: UTF8String): Single;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  Result := 0;
  s := Section;
  k := Key;

  if ini_GetID(s, k, i, j) Then
    Result := u_StrToFloat(iniRec.Section[i].Key[j].Value);
end;

function ini_ReadKeyBool(const Section, Key: UTF8String): Boolean;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  Result := FALSE;
  s := UTF8String(Section);
  k := UTF8String(Key);

  if ini_GetID(s, k, i, j) Then
    Result := u_StrToBool(iniRec.Section[i].Key[j].Value);
end;

function ini_WriteKeyStr(const Section, Key, Value: UTF8String): Boolean;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  s := Section;
  k := Key;

  if ini_GetID(s, k, i, j) Then
    begin
      iniRec.Section[i].Key[j].Value := utf8_Copy(Value);
      Result := TRUE;
    end else
      begin
        ini_Add(Section, Key);
        ini_WriteKeyStr(Section, Key, Value);
        Result := FALSE;
      end;
end;

function ini_WriteKeyInt(const Section, Key: UTF8String; Value: Integer): Boolean;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  s := Section;
  k := Key;

  if ini_GetID(s, k, i, j) Then
    begin
      iniRec.Section[i].Key[j].Value := u_IntToStr(Value);
      Result := TRUE;
    end else
      begin
        ini_Add(Section, Key);
        ini_WriteKeyInt(Section, Key, Value);
        Result := FALSE;
      end;
end;

function ini_WriteKeyFloat(const Section, Key: UTF8String; Value: Single; Digits: Integer = 2): Boolean;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  s := Section;
  k := Key;

  if ini_GetID(s, k, i, j) Then
    begin
      iniRec.Section[i].Key[j].Value := u_FloatToStr(Value, Digits);
      Result := TRUE;
    end else
      begin
        ini_Add(Section, Key);
        ini_WriteKeyFloat(Section, Key, Value, Digits);
        Result := FALSE;
      end;
end;

function ini_WriteKeyBool(const Section, Key: UTF8String; Value: Boolean): Boolean;
  var
    s, k: UTF8String;
    i, j: Integer;
begin
  s := Section;
  k := Key;

  if ini_GetID(s, k, i, j) Then
    begin
      iniRec.Section[i].Key[j].Value := u_BoolToStr(Value);
      Result := TRUE;
    end else
      begin
        ini_Add(Section, Key);
        ini_WriteKeyBool(Section, Key, Value);
        Result := FALSE;
      end;
end;

function _ini_ReadKeyStr(const Section, Key: UTF8String): PAnsiChar;
begin
  Result := utf8_GetPAnsiChar(ini_ReadKeyStr(Section, Key));
end;

end.
