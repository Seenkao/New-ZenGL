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

 !!! modification from Serge 15.12.2020
}
unit zgl_font;

{$I zgl_config.cfg}

interface
uses
  zgl_textures,
  zgl_types,
  zgl_file,
  zgl_memory;

const
  ZGL_FONT_INFO: array[0..13] of AnsiChar = ('Z', 'G', 'L', '_', 'F', 'O', 'N', 'T', '_', 'I', 'N', 'F', 'O', #0);
  MAX_USE_FONT = 5;
  Enable       = 1;
  UseFnt       = 2;

  PaddingX1    = 0;
  PaddingX2    = 2;
  PaddingY1    = 1;
  PaddingY2    = 3;

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

    Flags     : Byte;
    Scale     : Single;
    ScaleNorm : Single;
    Pages     : array of zglPTexture;
    CharDesc  : array[0..65535] of zglPCharDesc;
    MaxHeight : Integer;
    MaxShiftY : Integer;
    Padding   : array[0..3] of Byte;
end;

type
  zglPFontManager = ^zglTFontManager;
  zglTFontManager = record
    Count: Integer;
    Font: array[1..MAX_USE_FONT] of zglTFont;
end;

function  font_Add: Byte;
procedure font_Del(var Font: Byte);
procedure allFont_Destroy;

function font_LoadFromFile(const FileName: UTF8String): Byte;
function font_LoadFromMemory(const Memory: zglTMemory): Byte;
{$IFDEF ANDROID}
procedure font_RestoreFromFile(var Font: Byte; const FileName: UTF8String);
{$ENDIF}

procedure font_Load(var fnt: Byte; var fntMem: zglTMemory);

var
  managerFont: zglTFontManager;

implementation
uses
  zgl_window,
  zgl_resources,
  zgl_log,
  zgl_text,
  zgl_utils;

function font_Add: Byte;
var
  i: Byte;
begin
  i := 1;
  Result := 255;
  if managerFont.Count = MAX_USE_FONT then Exit;
  while i <= MAX_USE_FONT do
  begin
    if (managerFont.Font[i].Flags and UseFnt) = 0 then
      Break;
    inc(i);
  end;
  if i > MAX_USE_FONT then
    Exit;
  managerFont.Font[i].Flags := managerFont.Font[i].Flags or Enable or UseFnt;
  Result := i;
  INC(managerFont.Count);
end;

procedure font_Del(var Font: Byte);
begin
  if Font = 0 then
  begin
    Font := 255;
    exit;
  end;
  if (managerFont.Font[Font].Flags and Enable) = 0 then
    Exit;
  if (managerFont.Font[Font].Flags and UseFnt) = 0 then
    Exit;
  managerFont.Font[Font].Flags := managerFont.Font[Font].Flags and (255 - UseFnt);
  DEC(managerFont.Count);
  Font := 0;
end;

procedure allFont_Destroy;
var
  j, i: Word;
begin
  for j := 1 to MAX_USE_FONT do
  begin
    if (managerFont.Font[j].Flags and Enable) > 0 then
    begin
      for i := 0 to managerFont.Font[j].Count.Pages - 1 do
        tex_Del(managerFont.Font[j].Pages[i]);
      log_Add('Font to free');
      for i := 0 to 65535 do
        if Assigned(managerFont.Font[j].CharDesc[i]) Then
          FreeMem(managerFont.Font[j].CharDesc[i]);
      SetLength(managerFont.Font[j].Pages, 0);
//      FreeMem(managerFont.Font[j]);
//      Font := nil;
    end;

  end;
end;

function font_LoadFromFile(const FileName: UTF8String): Byte;
  var
    fntMem: zglTMemory;
    i, j  : Integer;
    dir   : UTF8String;
    name  : UTF8String;
    tmp   : UTF8String;
    res   : zglTFontResource;
begin
  Result := 255;

  if resUseThreaded Then
  begin
    Result       := font_Add();
    if Result = 255 then
      exit;
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

  if Result = 255 Then
  begin
    log_Add('Unable to load font: "' + FileName + '"');
    exit;
  end;

  dir  := file_GetDirectory(FileName);
  name := file_GetName(FileName);
  for i := 0 to managerFont.Font[Result].Count.Pages - 1 do
    for j := managerTexture.Count.Formats - 1 downto 0 do
    begin
      tmp := dir + name + '-page' + u_IntToStr(i) + '.' + u_StrDown(managerTexture.Formats[j].Extension);
      if file_Exists(tmp) Then
      begin
        managerFont.Font[Result].Pages[i] := tex_LoadFromFile(tmp, $FF000000, TEX_DEFAULT_2D);
        break;
      end;
    end;

  managerFont.Font[Result].ScaleNorm := 16 / TextScaleStandart ;
  managerFont.Font[Result].Scale := managerFont.Font[Result].ScaleNorm;
end;

function font_LoadFromMemory(const Memory: zglTMemory): Byte;
  var
    fntMem: zglTMemory;
    res   : zglTFontResource;
begin
  Result := 255;

  if resUseThreaded Then
  begin
    Result     := font_Add();
    if Result = 255 then
      Exit;
    res.Memory := Memory;
    res.Font   := Result;
    res_AddToQueue(RES_FONT, FALSE, @res);
    exit;
  end;

  fntMem := Memory;
  font_Load(Result, fntMem);

  if Result = 255 Then
    log_Add('Unable to load font: From Memory');
end;

{$IFDEF ANDROID}
procedure font_RestoreFromFile(var Font: Byte; const FileName: UTF8String);
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
  for i := 0 to managerFont.Font[Font].Count.Pages - 1 do
    for j := managerTexture.Count.Formats - 1 downto 0 do
    begin
      tmp := dir + name + '-page' + u_IntToStr(i) + '.' + u_StrDown(managerTexture.Formats[j].Extension);
      if file_Exists(tmp) Then
      begin
        tex_RestoreFromFile(managerFont.Font[Font].Pages[i], tmp, TEX_NO_COLORKEY, TEX_DEFAULT_2D);
        break;
      end;
    end;
end;
{$ENDIF}

procedure font_Load(var fnt: Byte; var fntMem: zglTMemory);
  var
    i    : Integer;
    c    : LongWord;
    fntID: array[0..13] of AnsiChar;
begin
  TextScaleStandart := 0;
  if fnt <> 255 then
    exit;
  fntID[13] := #0;
  mem_Read(fntMem, fntID, 13);
  if fntID <> ZGL_FONT_INFO Then
  begin
    exit;
  end;
  fnt := font_Add;
  if fnt = 255 then
    exit;
  mem_Read(fntMem, managerFont.Font[fnt].Count.Pages,  2);
  mem_Read(fntMem, managerFont.Font[fnt].Count.Chars,  2);
  mem_Read(fntMem, managerFont.Font[fnt].MaxHeight,    4);
  mem_Read(fntMem, managerFont.Font[fnt].MaxShiftY,    4);
  mem_Read(fntMem, managerFont.Font[fnt].Padding[0], 4);
  SetLength(managerFont.Font[fnt].Pages, managerFont.Font[fnt].Count.Pages);

  for i := 0 to managerFont.Font[fnt].Count.Pages - 1 do
    managerFont.Font[fnt].Pages[i] := nil;
  for i := 0 to managerFont.Font[fnt].Count.Chars - 1 do
  begin
    mem_Read(fntMem, c, 4);
    zgl_GetMem(Pointer(managerFont.Font[fnt].CharDesc[c]), SizeOf(zglTCharDesc));
    {$IFDEF ENDIAN_BIG}
    forceNoSwap := TRUE;
    {$ENDIF}
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].Page, 4);
    {$IFDEF ENDIAN_BIG}
    forceNoSwap := FALSE;
    {$ENDIF}
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].Width, 1);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].Height, 1);
    if TextScaleStandart < managerFont.Font[fnt].CharDesc[c].Width then
    begin
      TextScaleStandart := managerFont.Font[fnt].CharDesc[c].Width;
    end;
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].ShiftX, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].ShiftY, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].ShiftP, 4);
    {$IFDEF ENDIAN_BIG}
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[0].X, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[0].Y, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[1].X, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[1].Y, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[2].X, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[2].Y, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[3].X, 4);
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[3].Y, 4);
    {$ELSE}
    mem_Read(fntMem, managerFont.Font[fnt].CharDesc[c].TexCoords[0], SizeOf(zglTPoint2D) * 4);
    {$ENDIF}
  end;
end;

end.
