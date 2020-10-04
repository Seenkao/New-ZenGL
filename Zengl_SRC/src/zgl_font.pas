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

 !!! modification from Serge 04.08.2020
}
unit zgl_font;

{$I zgl_config.cfg}

interface
uses
  zgl_textures,
  zgl_math_2d,
  zgl_file,
  zgl_memory;

const
  ZGL_FONT_INFO: array[0..13] of AnsiChar = ('Z', 'G', 'L', '_', 'F', 'O', 'N', 'T', '_', 'I', 'N', 'F', 'O', #0);

type
  zglPCharDesc = ^zglTCharDesc;
  zglTCharDesc = record
    Page     : Word;
    Width    : Byte;
    Height   : Byte;
    ShiftX   : Integer;
    ShiftY   : Integer;
    ShiftP   : Integer;
    TexCoords: array[0..3] of zglTPoint2D;
end;

type
  zglPFont = ^zglTFont;
  zglTFont = record
    Count     : record
      Pages: Word;
      Chars: Word;
                 end;

    Pages     : array of zglPTexture;
    CharDesc  : array[0..65535] of zglPCharDesc;
    MaxHeight : Integer;
    MaxShiftY : Integer;
    Padding   : array[0..3] of Byte;

    prev, next: zglPFont;
end;

type
  zglPFontManager = ^zglTFontManager;
  zglTFontManager = record
    Count: Integer;
    First: zglTFont;
end;

function  font_Add: zglPFont;
procedure font_Del(var Font: zglPFont);

function font_LoadFromFile(const FileName: UTF8String): zglPFont;
function font_LoadFromMemory(const Memory: zglTMemory): zglPFont;
{$IFDEF ANDROID}
procedure font_RestoreFromFile(var Font: zglPFont; const FileName: UTF8String);
{$ENDIF}

procedure font_Load(var fnt: zglPFont; var fntMem: zglTMemory);

var
  managerFont: zglTFontManager;

implementation
uses
  zgl_window,
  zgl_resources,
  zgl_log,
  zgl_text,
  zgl_utils;

function font_Add;
begin
  Result := @managerFont.First;
  while Assigned(Result.next) do
    Result := Result.next;

  zgl_GetMem(Pointer(Result.next), SizeOf(zglTFont));
  Result.next.prev := Result;
  Result.next.next := nil;
  Result           := Result.next;
  INC(managerFont.Count);
end;

procedure font_Del(var Font: zglPFont);
  var
    i: Integer;
begin
  if not Assigned(Font) Then exit;

  for i := 0 to Font.Count.Pages - 1 do
    tex_Del(Font.Pages[i]);
  log_Add('Font to free');
  for i := 0 to 65535 do
    if Assigned(Font.CharDesc[i]) Then
      FreeMem(Font.CharDesc[i]);
  if Assigned(Font.prev) Then
    Font.prev.next := Font.next;
  if Assigned(Font.next) Then
    Font.next.prev := Font.prev;
  SetLength(Font.Pages, 0);
  FreeMem(Font);
  Font := nil;

  DEC(managerFont.Count);
end;

function font_LoadFromFile(const FileName: UTF8String): zglPFont;
  var
    fntMem: zglTMemory;
    i, j  : Integer;
    dir   : UTF8String;
    name  : UTF8String;
    tmp   : UTF8String;
    res   : zglTFontResource;
begin
  Result := nil;

  if resUseThreaded Then
  begin
    Result       := font_Add();
    res.FileName := FileName;
    res.Font     := Result;
    res_AddToQueue(RES_FONT, TRUE, @res);
    exit;
  end;

  if not file_Exists(FileName) Then
  begin
    log_Add('Cannot read "' + FileName + '"');
    exit;
  end;

  mem_LoadFromFile(fntMem, FileName);
  font_Load(Result, fntMem);
  mem_Free(fntMem);

  if not Assigned(Result) Then
  begin
    log_Add('Unable to load font: "' + FileName + '"');
    exit;
  end;

  dir  := file_GetDirectory(FileName);
  name := file_GetName(FileName);
  for i := 0 to Result.Count.Pages - 1 do
    for j := managerTexture.Count.Formats - 1 downto 0 do
    begin
      tmp := dir + name + '-page' + u_IntToStr(i) + '.' + u_StrDown(managerTexture.Formats[j].Extension);
      if file_Exists(tmp) Then
      begin
        Result.Pages[i] := tex_LoadFromFile(tmp, $FF000000, TEX_DEFAULT_2D);
        break;
      end;
    end;
  TextScaleStandart := TextScaleStandart / 16 * (16 / (trunc(_textureWidth / (TextScaleStandart))));
  TextScaleNormal := 1 / TextScaleStandart ;
  textScale := TextScaleNormal;
end;

function font_LoadFromMemory(const Memory: zglTMemory): zglPFont;
  var
    fntMem: zglTMemory;
    res   : zglTFontResource;
begin
  Result := nil;

  if resUseThreaded Then
  begin
    Result     := font_Add();
    res.Memory := Memory;
    res.Font   := Result;
    res_AddToQueue(RES_FONT, FALSE, @res);
    exit;
  end;

  fntMem := Memory;
  font_Load(Result, fntMem);

  if not Assigned(Result) Then
    log_Add('Unable to load font: From Memory');
end;

{$IFDEF ANDROID}
procedure font_RestoreFromFile(var Font: zglPFont; const FileName: UTF8String);
  var
    fntMem: zglTMemory;
    i, j  : Integer;
    dir   : UTF8String;
    name  : UTF8String;
    tmp   : UTF8String;
    res   : zglTFontResource;
begin
  if resUseThreaded Then
  begin
    res.FileName := FileName;
    res.Font     := Font;
    res_AddToQueue(RES_FONT_RESTORE, TRUE, @res);
    exit;
  end;

  if not file_Exists(FileName) Then
  begin
    log_Add('Cannot read "' + FileName + '"');
    exit;
  end;

  dir  := file_GetDirectory(FileName);
  name := file_GetName(FileName);
  for i := 0 to Font.Count.Pages - 1 do
    for j := managerTexture.Count.Formats - 1 downto 0 do
    begin
      tmp := dir + name + '-page' + u_IntToStr(i) + '.' + u_StrDown(managerTexture.Formats[j].Extension);
      if file_Exists(tmp) Then
      begin
        tex_RestoreFromFile(Font.Pages[i], tmp, TEX_NO_COLORKEY, TEX_DEFAULT_2D);
        break;
      end;
    end;
end;
{$ENDIF}

procedure font_Load(var fnt: zglPFont; var fntMem: zglTMemory);
  var
    i    : Integer;
    c    : LongWord;
    fntID: array[0..13] of AnsiChar;
begin
  TextScaleStandart := 0;
  fntID[13] := #0;
  mem_Read(fntMem, fntID, 13);
  if fntID <> ZGL_FONT_INFO Then
  begin
    if Assigned(fnt) Then
      FreeMemory(fnt);
    fnt := nil;
    exit;
  end;

  if not Assigned(fnt) Then
    fnt := font_Add();
  mem_Read(fntMem, fnt.Count.Pages,  2);
  mem_Read(fntMem, fnt.Count.Chars,  2);
  mem_Read(fntMem, fnt.MaxHeight,    4);
  mem_Read(fntMem, fnt.MaxShiftY,    4);
  mem_Read(fntMem, fnt.Padding[0], 4);
  SetLength(fnt.Pages, fnt.Count.Pages);
  for i := 0 to fnt.Count.Pages - 1 do
    fnt.Pages[i] := nil;
  for i := 0 to fnt.Count.Chars - 1 do
  begin
    mem_Read(fntMem, c, 4);
    zgl_GetMem(Pointer(fnt.CharDesc[c]), SizeOf(zglTCharDesc));
    {$IFDEF ENDIAN_BIG}
    forceNoSwap := TRUE;
    {$ENDIF}
    mem_Read(fntMem, fnt.CharDesc[c].Page, 4);
    {$IFDEF ENDIAN_BIG}
    forceNoSwap := FALSE;
    {$ENDIF}
    mem_Read(fntMem, fnt.CharDesc[c].Width, 1);
    mem_Read(fntMem, fnt.CharDesc[c].Height, 1);
    if TextScaleStandart < fnt.CharDesc[c].Width then
    begin
      TextScaleStandart := fnt.CharDesc[c].Width;
    end;
    mem_Read(fntMem, fnt.CharDesc[c].ShiftX, 4);
    mem_Read(fntMem, fnt.CharDesc[c].ShiftY, 4);
    mem_Read(fntMem, fnt.CharDesc[c].ShiftP, 4);
    {$IFDEF ENDIAN_BIG}
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[0].X, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[0].Y, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[1].X, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[1].Y, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[2].X, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[2].Y, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[3].X, 4);
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[3].Y, 4);
    {$ELSE}
    mem_Read(fntMem, fnt.CharDesc[c].TexCoords[0], SizeOf(zglTPoint2D) * 4);
    {$ENDIF}
  end;
  TextScaleStandart := TextScaleStandart + fnt.Padding[0] + fnt.Padding[2];
end;

end.
