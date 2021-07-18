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

 !!! modification from Serge 16.07.2021
}
unit zgl_utils;

{$I zgl_config.cfg}
{$IFDEF iOS}
  {$modeswitch objectivec1}
{$ENDIF}

interface
uses
  {$IFDEF UNIX}
  UnixType, sysutils,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF MACOSX}
  MacOSAll,
  {$ENDIF}
  {$IFDEF iOS}
  iPhoneAll, CFString,
  {$ENDIF}
  zgl_types;

const
  LIB_ERROR  = {$IFDEF UNIX} nil {$ELSE} 0 {$ENDIF};

function u_IntToStr(Value: Integer): UTF8String;
function u_StrToInt(const Value: UTF8String): Integer;
function u_FloatToStr(Value: Single; Digits: Integer = 2): UTF8String;
function u_StrToFloat(const Value: UTF8String): Single;
function u_BoolToStr(Value: Boolean): UTF8String;
function u_StrToBool(const Value: UTF8String): Boolean;

// Only for latin symbols in range 0..127
function u_StrUp(const Str: UTF8String): UTF8String;
function u_StrDown(const Str: UTF8String): UTF8String;

function utf8_Copy(const Str: UTF8String): UTF8String; overload;
function utf8_Copy(const Str: UTF8String; FromPosition, Count: Integer): UTF8String; overload;
procedure utf8_Delete(var Str: UTF8String; FromPosition, Count: Integer);
procedure utf8_Backspace(var Str: UTF8String);
function  utf8_Length(const Str: UTF8String): Integer;
procedure utf8_GetShift(const Text: UTF8String; Pos: Integer; out NewPos: Integer; Chars: Integer = 1);
function utf8_toUnicode(const Text: UTF8String; Pos: Integer; Shift: PInteger): LongWord;

function Unicode_toUTF8(Symb: LongWord): UTF8String;

function utf8_GetPAnsiChar(const Str: UTF8String): PAnsiChar;
{$IFDEF WINDOWS}
function utf8_GetPWideChar(const Str: UTF8String): PWideChar;
function utf16_GetUTF8String(const Str: PWideChar): UTF8String;
{$ENDIF}
{$IFDEF iOS}
function utf8_GetNSString(const Str: UTF8String): NSString;
{$ENDIF}
//
procedure u_SortList(var List: zglTStringList; iLo, iHi: Integer);
//
function u_Hash(const Str: UTF8String): LongWord;

procedure u_Error(const ErrStr: UTF8String);
procedure u_Warning(const ErrStr: UTF8String);

(* дополнение до ближайшего верхнего 2^ (2, 4, 8, 16, 32 и т. д.) *)
function u_GetPOT(Value: Integer): Integer;

procedure u_Sleep(Milliseconds: LongWord);

{$IFDEF UNIX}
function dlopen (Name: PAnsiChar; Flags: longint): Pointer; cdecl; external 'dl';
function dlclose(Lib: Pointer): Longint; cdecl; external 'dl';
function dlsym  (Lib: Pointer; Name: PAnsiChar): Pointer; cdecl; external 'dl';

function select(n: longint; readfds, writefds, exceptfds: Pointer; var timeout: timeVal): longint; cdecl; external 'libc';

function printf(format: PAnsiChar; const args: array of const): Integer; cdecl; external 'libc';

{$ENDIF}
{$IF DEFINED(LINUX) and DEFINED(CPUx86_64)}
// GLIBC 2.14 is too new, so replace memcpy with Pascal implementation via hack
function memcpy(destination, source: Pointer; num: csize_t): Pointer; cdecl; public name 'memcpy';
{$IFEND}
{$IFDEF ANDROID}
function __android_log_write(prio: LongInt; tag, text: PAnsiChar): LongInt; cdecl; external 'liblog.so' name '__android_log_write';
{$ENDIF}
{$IFDEF WINDOWS}
function dlopen (lpLibFileName: PAnsiChar): HMODULE; stdcall; external 'kernel32.dll' name 'LoadLibraryA';
function dlclose(hLibModule: HMODULE): Boolean; stdcall; external 'kernel32.dll' name 'FreeLibrary';
function dlsym  (hModule: HMODULE; lpProcName: PAnsiChar): Pointer; stdcall; external 'kernel32.dll' name 'GetProcAddress';
{$ENDIF}

implementation
uses
  zgl_log;

function u_IntToStr(Value: Integer): UTF8String;
begin
  Str(Value, Result);
end;

function u_StrToInt(const Value: UTF8String): Integer;
  var
    e: Integer;
begin
  Val(Value, Result, e);
  if e <> 0 Then
    Result := 0;
end;

function u_FloatToStr(Value: Single; Digits: Integer = 2): UTF8String;
begin
  Str(Value:0:Digits, Result);
end;

function u_StrToFloat(const Value: UTF8String): Single;
  var
    e: Integer;
begin
  Val(Value, Result, e);
  if e <> 0 Then
    Result := 0;
end;

function u_BoolToStr(Value: Boolean): UTF8String;
begin
  if Value Then
    Result := 'TRUE'
  else
    Result := 'FALSE';
end;

function u_StrToBool(const Value: UTF8String): Boolean;
begin
  if Value = '1' Then
    Result := TRUE
  else
    if u_StrUp(Value) = 'TRUE' Then
      Result := TRUE
    else
      Result := FALSE;
end;


function u_StrUp(const Str: UTF8String): UTF8String;
var
  i, l: Integer;
begin
  l := Length(Str);
  SetLength(Result, l);
  for i := 1 to l do
    if (Byte(Str[i]) >= 97) and (Byte(Str[i]) <= 122) Then
      Result[i] := AnsiChar(Byte(Str[i]) - 32)
    else
      Result[i] := Str[i];
end;

function u_StrDown(const Str: UTF8String): UTF8String;
  var
    i, l: Integer;
begin
  l := Length(Str);
  SetLength(Result, l);
  for i := 1 to l do
    if (Byte(Str[i]) >= 65) and (Byte(Str[i]) <= 90) Then
      Result[i] := AnsiChar(Byte(Str[i]) + 32)
    else
      Result[i] := Str[i];
end;

function utf8_Copy(const Str: UTF8String): UTF8String;
  var
    len: Integer;
begin
  len := Length(Str);
  SetLength(Result, len);
  if len > 0 Then
    System.Move(Str[1], Result[1], len);
end;

function utf8_Copy(const Str: UTF8String; FromPosition, Count: Integer): UTF8String;
  var
    i, j, len: Integer;
begin
  len := utf8_Length(Str);
  if FromPosition < 1 Then FromPosition := 1;
  if (FromPosition > len) or (Count < 1) Then
    begin
      Result := '';
      exit;
    end;
  if FromPosition + Count > len + 1 Then Count := len - FromPosition + 1;

  i := 1;
  utf8_GetShift(Str, i, i, FromPosition - 1);
  utf8_GetShift(Str, i, j, Count);
  SetLength(Result, j - i);
  System.Move(Str[i], Result[1], j - i);
end;

procedure utf8_Delete(var Str: UTF8String; FromPosition, Count: Integer);
  var
    i, j, len: Integer;
    Result   : UTF8String;
begin
  len := utf8_Length(Str);
  if FromPosition < 1 Then
    FromPosition := 1;
  if (FromPosition > len) or (Count < 1) Then
    exit;
  if FromPosition + Count > len + 1 Then
    Count := len - FromPosition + 1;
  if (FromPosition = 1) and (Count = len) Then
  begin
    Str := '';
    exit;
  end;

  len := Length(Str);
  i := 1;
  utf8_GetShift(Str, i, i, FromPosition - 1);
  utf8_GetShift(Str, i, j, Count);
  SetLength(Result, len - j + i);
  System.Move(Str[1], Result[1], i - 1);
  if j <= len Then
    System.Move(Str[j], Result[i], len - (j - 1));

  Str := Result;
end;

procedure utf8_Backspace(var Str: UTF8String);
  var
    i, last: Integer;
begin
  i := 1;
  last := 1;
  while i <= Length(Str) do
    begin
      last := i;
      utf8_GetShift(Str, last, i);
    end;

  SetLength(Str, last - 1)
end;

function utf8_Length(const Str: UTF8String): Integer;
  var
    i: Integer;
begin
  Result := 0;
  i := 1;
  while i <= Length(Str) do
    begin
      INC(Result);
      utf8_GetShift(Str, i, i);
    end;
end;

procedure utf8_GetShift(const Text: UTF8String; Pos: Integer; out NewPos: Integer; Chars: Integer = 1);
  var
    i: Integer;
begin
  NewPos := Pos;
  for i := 1 to Chars do
    case Byte(Text[NewPos]) of
      0..127: INC(NewPos);
      192..223: INC(NewPos, 2);
      224..239: INC(NewPos, 3);
      240..247: INC(NewPos, 4);
      248..251: INC(NewPos, 5);
      252..253: INC(NewPos, 6);
      254..255: INC(NewPos);
    else
      INC(NewPos);
    end;
end;

// получение "номера" символа
function utf8_toUnicode(const Text: UTF8String; Pos: Integer; Shift: PInteger): LongWord;
begin
  case Byte(Text[Pos]) of
    0..$7F:
      begin
        Result := Byte(Text[Pos]);
        if Assigned(Shift) Then
          Shift^ := Pos + 1;
      end;

    $C0..$DF:
      begin
        Result := (Byte(Text[Pos]) - $C0) * $40 + (Byte(Text[Pos + 1]) - $80);
        if Assigned(Shift) Then
          Shift^ := Pos + 2;
      end;

    $E0..$EF:
      begin
        Result := (Byte(Text[Pos]) - $E0) * $1000 + (Byte(Text[Pos + 1]) - $80) * $40 + (Byte(Text[Pos + 2]) - $80);
        if Assigned(Shift) Then
          Shift^ := Pos + 3;
      end;

    $F0..$F7:
      begin
        Result := (Byte(Text[Pos]) - $F0) * $40000 + (Byte(Text[Pos + 1]) - $80) * $1000 + (Byte(Text[Pos + 2]) - $80) * $40 +
                  (Byte(Text[Pos + 3]) - $80);
        if Assigned(Shift) Then
          Shift^ := Pos + 4;
      end;

    $F8..$FB:
      begin
        Result := (Byte(Text[Pos]) - $F8) * $1000000 + (Byte(Text[Pos + 1]) - $80) * $40000 + (Byte(Text[Pos + 2]) - $80) * $1000 +
                  (Byte(Text[Pos + 3]) - $80) * $40 + (Byte(Text[Pos + 4]) - $80);
        if Assigned(Shift) Then
          Shift^ := Pos + 5;
      end;

    $FC..$FD:
      begin
        Result := (Byte(Text[Pos]) - $FC) * $40000000 + (Byte(Text[Pos + 1]) - $80) * $1000000 + (Byte(Text[Pos + 2]) - $80) * $40000 +
                  (Byte(Text[Pos + 3]) - $80) * $1000 + (Byte(Text[Pos + 4]) - $80) * 64 + (Byte(Text[Pos + 5]) - $80);
        if Assigned(Shift) Then
          Shift^ := Pos + 6;
      end;

    $FE..$FF:
      begin
        Result := 0;
        if Assigned(Shift) Then
          Shift^ := Pos + 1;
      end;
  else
    Result := 0;
    if Assigned(Shift) Then
      Shift^ := Pos + 1;
  end;
end;

function Unicode_toUTF8(Symb: LongWord): UTF8String;
begin
  if Symb <= $7F then
  begin
{1}    Result := chr(Symb);
    Exit;
  end;
  if Symb <= $7FF then
  begin
{2}    Result := chr($C0 or (Symb shr 6)) + chr($80 or (Symb and $3F));
    Exit;
  end;
  if Symb <= $FFFF then
  begin
{3}    Result := chr($E0 or (Symb shr 12)) + chr($80 or (Symb and $FC0) shr 6) + chr($80 or (Symb and $3F));
    Exit;
  end;
  if Symb <= $1FFFFF then
  begin
{4}    Result := chr($F0 or (Symb shr 18)) + chr($80 or (Symb and $3F000) shr 12) + chr($80 or (Symb and $FC0) shr 6) + chr($80 or (Symb and $3F));
    Exit;
  end;
  if Symb <= $3FFFFFF then
  begin
{5}    Result := chr($F8 or (Symb shr 24)) + chr($80 or (Symb and $FC0000) shr 18) + chr($80 or (Symb and $3F000) shr 12) + chr($80 or (Symb and $FC0) shr 6) + chr($80 or (Symb and $3F));
    Exit;
  end;
  if Symb <= $7FFFFFFF then
{6}    Result := chr($FC or (Symb shr 30)) + chr($80 or (Symb and $3F000000) shr 24) + chr($80 or (Symb and $FC0000) shr 18) + chr($80 or (Symb and $3F000) shr 12) + chr($80 or (Symb and $FC0) shr 6) + chr($80 or (Symb and $3F));
end;

function utf8_GetPAnsiChar(const Str: UTF8String): PAnsiChar;
  var
    len: Integer;
begin
  len := Length(Str);
  GetMem(Result, len + 1);
  Result[len] := #0;
  if len > 0 Then
    System.Move(Str[1], Result^, len);
end;

{$IFDEF WINDOWS}
function utf8_GetPWideChar(const Str: UTF8String): PWideChar;
  var
    len: Integer;
begin
  len := MultiByteToWideChar(CP_UTF8, 0, @Str[1], Length(Str), nil, 0);
  GetMem(Result, len * 2 + 2);
  Result[len] := #0;
  MultiByteToWideChar(CP_UTF8, 0, @Str[1], Length(Str), Result, len);
end;

function utf16_GetUTF8String(const Str: PWideChar): UTF8String;
  var
    len: Integer;
begin
  len := WideCharToMultiByte(CP_UTF8, 0, Str, Length(Str), nil, 0, nil, nil);
  SetLength(Result, len);
  if len > 0 Then
    WideCharToMultiByte(CP_UTF8, 0, Str, Length(Str), @Result[1], len, nil, nil);
end;
{$ENDIF}

{$IFDEF iOS}
function utf8_GetNSString(const Str: UTF8String): NSString;
begin
  Result := NSString.stringWithUTF8String(PAnsiChar(Str));
end;
{$ENDIF}

procedure u_SortList(var List: zglTStringList; iLo, iHi: Integer);
  var
    lo, hi: Integer;
    mid, t: UTF8String;
begin
  lo  := iLo;
  hi  := iHi;
  mid := List.Items[(lo + hi) shr 1];

  repeat
    while List.Items[lo] < mid do INC(lo);
    while List.Items[hi] > mid do DEC(hi);
    if lo <= hi then
      begin
        t                := List.Items[lo];
        List.Items[lo] := List.Items[hi];
        List.Items[hi] := t;
        INC(lo);
        DEC(hi);
      end;
  until lo > hi;

  if hi > iLo Then u_SortList(List, iLo, hi);
  if lo < iHi Then u_SortList(List, lo, iHi);
end;

function u_Hash(const Str: UTF8String): LongWord;
  var
    data     : PAnsiChar;
    hash, tmp: LongWord;
    rem, len : Integer;
begin
  Result := 0;
  if Str = '' Then exit;
  len  := Length(Str);
  hash := len;
  data := @Str[1];

  rem := len and 3;
  len := len shr 2;

  while len > 0 do
    begin
      hash := hash + PWord(data)^;
      INC(data, 2);
      tmp  := (PWord(data)^ shl 11) xor hash;
      hash := (hash shl 16) xor tmp;
      INC(data, 2);
      hash := hash + (hash shr 11);
      dec(len);
    end;

  case rem of
    3:
      begin
        hash := hash + PWord(data)^;
        hash := hash xor (hash shl 16);
        hash := hash xor (Byte(data[2]) shl 18);
        hash := hash + (hash shr 11);
      end;
    2:
      begin
        hash := hash + PWord(data)^;
        hash := hash xor (hash shl 11);
        hash := hash + (hash shr 17);
      end;
    1:
      begin
        hash := hash + PByte(data)^;
        hash := hash xor (hash shl 10);
        hash := hash + (hash shr 1);
      end;
  end;

  hash := hash xor (hash shl 3);
  hash := hash +   (hash shr 5);
  hash := hash xor (hash shl 4);
  hash := hash +   (hash shr 17);
  hash := hash xor (hash shl 25);
  hash := hash +   (hash shr 6);

  Result := hash;
end;

procedure u_Error(const ErrStr: UTF8String);
  {$IFDEF MACOSX}
  var
    outItemHit: SInt16;
  {$ENDIF}
  {$IFDEF WINDOWS}
  var
    wideStr: PWideChar;
  {$ENDIF}
begin
{$IF DEFINED(LINUX) or DEFINED(iOS) }
  printf(PAnsiChar('ERROR: ' + ErrStr), [nil]);
{$IFEND}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(ErrStr);
  MessageBoxW(0, wideStr, 'ERROR!', MB_OK or MB_ICONERROR);
  FreeMem(wideStr);
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  StandardAlert(kAlertNoteAlert, 'ERROR!', ErrStr, nil, outItemHit);
{$ENDIF}{$EndIf}

  log_Add('ERROR: ' + ErrStr);
end;

procedure u_Warning(const ErrStr: UTF8String);
  {$IFDEF MACOSX}
  var
    outItemHit: SInt16;
  {$ENDIF}
  {$IFDEF WINDOWS}
  var
    wideStr: PWideChar;
  {$ENDIF}
begin
{$IF DEFINED(LINUX) or DEFINED(iOS)}         
  printf(PAnsiChar('WARNING: ' + ErrStr), [nil]);
{$IFEND}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(ErrStr);
  MessageBoxW(0, wideStr, 'WARNING!', MB_OK or MB_ICONWARNING);
  FreeMem(wideStr);
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  StandardAlert(kAlertNoteAlert, 'WARNING!', ErrStr, nil, outItemHit);
{$ENDIF}{$EndIf}

  log_Add('WARNING: ' + ErrStr);
end;

function u_GetPOT(Value: Integer): Integer;
begin
  Result := Value - 1;
  Result := Result or (Result shr 1);
  Result := Result or (Result shr 2);
  Result := Result or (Result shr 4);
  Result := Result or (Result shr 8);
  Result := Result or (Result shr 16);
  Result := Result + 1;
end;

// пауза
procedure u_Sleep(Milliseconds: LongWord);
begin
  Sleep(Milliseconds);
end;

{$IF DEFINED(LINUX) and DEFINED(CPUx86_64)}
{$S-} // Don't know WTF is going on when stack check is enabled...
function memcpy(destination, source: Pointer; num: csize_t): Pointer;
begin
  Move(source^, destination^, num);
  Result := destination;
end;
{$IFEND}

end.
