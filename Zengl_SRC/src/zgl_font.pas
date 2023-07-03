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

 !!! modification from Serge 28.10.2021
}
unit zgl_font;

{$I zgl_config.cfg}

interface
uses
  zgl_textures,
  zgl_types,
  zgl_file,
  zgl_log,
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
    xx1, xx2, yy1, yy2: Single;
    _x1, _x2, _y1, _y2: Single;
  end;

type
  zglPFont = ^zglTFont;
  zglTFont = record
    Count     : record
      Pages: Word;
      Chars: Word;
                 end;

    Flags     : LongWord;
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
    Count: Cardinal;
    Font: array[1..MAX_USE_FONT] of zglPFont;
  end;

// Rus: добавить шрифт.
// Eng: add a font.
function  font_Add: LongWord;
// Rus: удалить шрифт под данным номером.
// Eng: delete the font under this number.
procedure font_Del(var Font: LongWord);
// Rus: уничтожить все шрифты. Вызывать не надо, происходит автоматически.
// Eng: destroy all fonts. There is no need to call, it happens automatically.
procedure allFont_Destroy;

// Rus: загрузка шрифта из файла.
// Eng: loading a font from a file.
function font_LoadFromFile(const FileName: UTF8String): LongWord;
// Rus: загрузка шрифта из памяти.
// Eng: loading a font from memory.
function font_LoadFromMemory(const Memory: zglTMemory): LongWord;
{$IFDEF ANDROID}
procedure font_RestoreFromFile(var Font: LongWord; const FileName: UTF8String);
{$ENDIF}
// Rus: непосредственно загрузка шрифта из памяти, куда он был загружен.
// Eng: directly loading the font from the memory where it was loaded.
procedure font_Load(var fnt: LongWord; var fntMem: zglTMemory);

var
  managerFont: zglTFontManager;

implementation
uses
  zgl_application,
  zgl_window,
  zgl_resources,
  zgl_text,
  zgl_utils;

function font_Add: LongWord;
var
  i: LongWord;
  newFont: zglPFont;
begin
  i := 1;
  Result := 255;
  if managerFont.Count = MAX_USE_FONT then Exit;
  while i <= MAX_USE_FONT do
  begin
    newFont := managerFont.Font[i];
    if not Assigned(newFont) then
      Break;
    if (newFont.Flags and UseFnt) = 0 then
      Break;
    inc(i);
  end;
  if i > MAX_USE_FONT then
  begin
    newFont := nil;
    Exit;
  end;

  if not Assigned(newFont) then
  begin
    zgl_GetMem(Pointer(newFont), SizeOf(zglTFont));
    managerFont.Font[i] := newFont;
  end;
  newFont.Flags := newFont.Flags or Enable or UseFnt;
  Result := i;
  INC(managerFont.Count);
  newFont := nil;
end;

procedure font_Del(var Font: LongWord);
var
  useFont: zglPFont;
label
  toExit;
begin
  if Font = 0 then
  begin
    Font := 255;
    exit;
  end;
  useFont := managerFont.Font[Font];
  if not Assigned(useFont) then
    goto toExit;
  if (useFont.Flags and Enable) = 0 then
    goto toExit;
  if (useFont.Flags and UseFnt) = 0 then
    goto toExit;
  useFont.Flags := useFont.Flags and (255 - UseFnt);
  DEC(managerFont.Count);
  Font := 0;
toExit:
  useFont := nil;
end;

procedure allFont_Destroy;
var
  j, i: Integer;
  destroyFont: zglPFont;
begin
  for j := 1 to MAX_USE_FONT do
  begin
    destroyFont := managerFont.Font[j];
    if Assigned(destroyFont) then
    begin
      if (destroyFont.Flags and Enable) > 0 then
      begin
        for i := 0 to destroyFont.Count.Pages - 1 do
          tex_Del(destroyFont.Pages[i]);
        log_Add('Font to free');
        for i := 0 to 65535 do
          if Assigned(destroyFont.CharDesc[i]) Then
            FreeMem(destroyFont.CharDesc[i]);
        SetLength(destroyFont.Pages, 0);
      end;
      Freemem(destroyFont);
      managerFont.Font[j] := nil;
    end;
  end;
  destroyFont := nil;
end;

function font_LoadFromFile(const FileName: UTF8String): LongWord;
var
  fntMem  : zglTMemory;
  i, j    : Integer;
  dir     : UTF8String;
  name    : UTF8String;
  texFont : UTF8String;
  res     : zglTFontResource;
  useFont : zglPFont;
begin
  Result := 255;                             // error

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
    log_Add('Cannot read "' + FileName + '" - program terminate');
    winOn := False;
    exit;
  end;

  mem_LoadFromFile(fntMem, FileName);
  font_Load(Result, fntMem);
  mem_Free(fntMem);


  if Result = 255 Then
  begin
    log_Add('Unable to load font: "' + FileName + '" - program terminate');
    winOn := False;
    exit;
  end;

  dir  := file_GetDirectory(FileName);
  name := file_GetName(FileName);
  useFont := managerFont.Font[Result];
  for i := 0 to useFont.Count.Pages - 1 do
    for j := managerTexture.Count.Formats - 1 downto 0 do
    begin
      texFont := dir + name + '-page' + u_IntToStr(i) + '.' + u_StrDown(managerTexture.Formats[j].Extension);
      if file_Exists(texFont) Then
      begin
        useFont.Pages[i] := tex_LoadFromFile(texFont, $FF000000, TEX_DEFAULT_2D);
        break;
      end;
    end;

  useFont.ScaleNorm := 16 / TextScaleStandart ;

  setFontTextScale(15, Result);
  setTextScaleEx(useFont.Scale);

//  useScaleEx := useFont.Scale;
  useFont := nil;
end;

function font_LoadFromMemory(const Memory: zglTMemory): LongWord;
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

  managerFont.Font[Result].ScaleNorm := 16 / TextScaleStandart;

  setFontTextScale(15, Result);
end;

{$IFDEF ANDROID}
procedure font_RestoreFromFile(var Font: LongWord; const FileName: UTF8String);
var
  fntMem: zglTMemory;
  i, j  : Integer;
  dir   : UTF8String;
  name  : UTF8String;
  tmp   : UTF8String;
  res   : zglTFontResource;
  useFont: zglPFont;
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

  useFont := managerFont.Font[Font];
  dir  := file_GetDirectory(FileName);
  name := file_GetName(FileName);
  for i := 0 to useFont.Count.Pages - 1 do
    for j := managerTexture.Count.Formats - 1 downto 0 do
    begin
      tmp := dir + name + '-page' + u_IntToStr(i) + '.' + u_StrDown(managerTexture.Formats[j].Extension);
      if file_Exists(tmp) Then
      begin
        tex_RestoreFromFile(useFont.Pages[i], tmp, TEX_NO_COLORKEY, TEX_DEFAULT_2D);
        break;
      end;
    end;

  useFont.ScaleNorm := 16 / TextScaleStandart ;

  setFontTextScale(15, Font);
  useScaleEx := useFont.Scale;
  useFont := nil;
end;
{$ENDIF}

// (fnt <> 255) - Error
procedure font_Load(var fnt: LongWord; var fntMem: zglTMemory);
var
  i    : Integer;
  c    : LongWord;
  fntID: array[0..13] of AnsiChar;
  useFont: zglPFont;
  charDesc9, charDesc32, charDescC: zglPCharDesc;
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
  useFont := managerFont.Font[fnt];
  mem_Read(fntMem, useFont.Count.Pages,  2);
  mem_Read(fntMem, useFont.Count.Chars,  2);
  mem_Read(fntMem, useFont.MaxHeight,    4);
  mem_Read(fntMem, useFont.MaxShiftY,    4);
  mem_Read(fntMem, useFont.Padding[0], 4);
  SetLength(useFont.Pages, useFont.Count.Pages);

  for i := 0 to useFont.Count.Pages - 1 do
    useFont.Pages[i] := nil;
  for i := 0 to useFont.Count.Chars - 1 do
  begin
    mem_Read(fntMem, c, 4);
    zgl_GetMem(Pointer(useFont.CharDesc[c]), SizeOf(zglTCharDesc));
    charDescC := useFont.CharDesc[c];
    {$IFDEF ENDIAN_BIG}
    forceNoSwap := TRUE;
    {$ENDIF}
    mem_Read(fntMem, charDescC.Page, 4);
    {$IFDEF ENDIAN_BIG}
    forceNoSwap := FALSE;
    {$ENDIF}
    mem_Read(fntMem, charDescC.Width, 1);
    mem_Read(fntMem, charDescC.Height, 1);
    if TextScaleStandart < charDescC.Width then
    begin
      TextScaleStandart := charDescC.Width;
    end;
    mem_Read(fntMem, charDescC.ShiftX, 4);
    mem_Read(fntMem, charDescC.ShiftY, 4);
    mem_Read(fntMem, charDescC.ShiftP, 4);
    {$IFDEF ENDIAN_BIG}
    mem_Read(fntMem, charDescC.TexCoords[0].X, 4);
    mem_Read(fntMem, charDescC.TexCoords[0].Y, 4);
    mem_Read(fntMem, charDescC.TexCoords[1].X, 4);
    mem_Read(fntMem, charDescC.TexCoords[1].Y, 4);
    mem_Read(fntMem, charDescC.TexCoords[2].X, 4);
    mem_Read(fntMem, charDescC.TexCoords[2].Y, 4);
    mem_Read(fntMem, charDescC.TexCoords[3].X, 4);
    mem_Read(fntMem, charDescC.TexCoords[3].Y, 4);
    {$ELSE}
    mem_Read(fntMem, charDescC.TexCoords[0], SizeOf(zglTPoint2D) * 4);
    {$ENDIF}
    charDescC._x1 := charDescC.ShiftX - useFont.Padding[PaddingX1];
    charDescC._x2 := charDescC.ShiftX + charDescC.Width + useFont.Padding[PaddingX2];
    charDescC._y1 := charDescC.ShiftY + useFont.MaxHeight - charDescC.Height - useFont.Padding[PaddingY1];
    charDescC._y2 := charDescC.ShiftY + useFont.MaxHeight + useFont.Padding[PaddingY2];
  end;
  charDesc32 := useFont.CharDesc[32];
  charDescC := useFont.CharDesc[33];
  charDesc32.Width := charDescC.Width;
  charDesc32.Height := charDescC.Height;
  charDesc32.ShiftX := charDescC.ShiftX;
  charDesc32.ShiftY := charDescC.ShiftY;
  charDesc32.ShiftP := charDescC.ShiftP;
  // "tab"
  zgl_GetMem(Pointer(useFont.CharDesc[9]), SizeOf(zglTCharDesc));
  charDesc9 := useFont.CharDesc[9];
  charDesc9^.Page := charDesc32.Page;
  charDesc9^.Width := charDesc32.Width * 4;
  charDesc9^.Height := charDesc32.Height;
  charDesc9^.ShiftX := charDesc32.ShiftX;
  charDesc9^.ShiftY := charDesc32.ShiftY;
  charDesc9^.ShiftP := charDesc32.ShiftP * 4;
  charDesc9.TexCoords[0] := charDesc32.TexCoords[0];
  charDesc9.TexCoords[1] := charDesc32.TexCoords[1];
  charDesc9.TexCoords[2] := charDesc32.TexCoords[2];
  charDesc9.TexCoords[3] := charDesc32.TexCoords[3];
  charDesc9._x1 := charDesc9.ShiftX - useFont.Padding[PaddingX1];
  charDesc9^._x2 := charDesc9^.ShiftX + charDesc9^.Width + useFont^.Padding[PaddingX2];
  charDesc9._y1 := charDesc9.ShiftY + useFont.MaxHeight - charDesc9.Height - useFont.Padding[PaddingY1];
  charDesc9._y2 := charDesc9.ShiftY + useFont.MaxHeight + useFont.Padding[PaddingY2];
  charDesc32._x1 := charDesc32.ShiftX - useFont.Padding[PaddingX1];
  charDesc32._x2 := charDesc32.ShiftX + charDesc32.Width + useFont.Padding[PaddingX2];
  charDesc32._y1 := charDesc32.ShiftY + useFont.MaxHeight - charDesc32.Height - useFont.Padding[PaddingY1];
  charDesc32._y2 := charDesc32.ShiftY + useFont.MaxHeight + useFont.Padding[PaddingY2];
  if useFont.MaxHeight > TextScaleStandart then
    TextScaleStandart := useFont.MaxHeight;
  useFont := nil;
end;

end.
