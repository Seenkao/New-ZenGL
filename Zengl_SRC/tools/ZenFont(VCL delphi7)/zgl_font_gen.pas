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
unit zgl_font_gen;

{.$DEFINE USE_PNG}

interface
uses
  Windows,
  {$IFDEF USE_PNG}
  SysUtils,
  Imaging,
  ImagingTypes,
  {$ENDIF}
  zgl_types,
  zgl_math_2d,
  zgl_font
  ;

type
  zglPSymbolNode = ^zglTSymbolNode;
  zglTSymbolNode = record
    leaf  : Boolean;
    ID    : Integer;
    rect  : zglTRect;
    child : array[0..1] of zglPSymbolNode;
  end;

function  fontgen_Init: Boolean;
procedure fontgen_BuildFont(var Font: Byte; const FontName: String);
procedure fontgen_SaveFont(Font: Byte; const FileName: String);

var
  fg_Font        : Byte = 0;
  fg_FontNodes   : array of zglTSymbolNode;
  fg_CharsUse    : array[0..65535] of Boolean;
  fg_CharsUID    : array of WORD;
  fg_CharsSize   : array of zglTRect;
  fg_CharsP      : array of Integer;
  fg_CharsImage  : array of array of Byte;
  fg_FontList    : zglTStringList;
  fg_FontSize    : Integer = 10;
  fg_FontBold    : Boolean;
  fg_FontItalic  : Boolean;
  fg_FontPack    : Boolean = TRUE;
  fg_FontAA      : Boolean = TRUE;
  fg_FontPadding : array[0..3] of Byte = (2, 2, 2, 2);
  fg_PageSize    : Integer = 256;
  fg_PageChars   : Integer = 17;

implementation
uses
  zgl_log,
  zgl_screen,
  zgl_window,
  zgl_textures,
  zgl_textures_tga,
  zgl_file,
  zgl_utils,
  math;

procedure image_FlipVertically(var Data : Pointer; w, h, pixelSize : Integer);
  var
    i        : Integer;
    scanLine : array of Byte;
begin
  SetLength(scanLine, w * pixelSize);

  for i := 0 to h shr 1 - 1 do
  begin
    Move(Pointer(Ptr(Data) + i * w * pixelSize)^, scanLine[0], w * pixelSize);
    Move(Pointer(Ptr(Data) + (h - i - 1) * w * pixelSize)^, Pointer(Ptr(Data) + i * w * pixelSize)^, w * pixelSize);
    Move(scanLine[0], Pointer(Ptr(Data) + (h - i - 1) * w * pixelSize)^, w * pixelSize);
  end;
end;

function fontgen_InsertSymbol(node : zglPSymbolNode; const r : zglTRect; ID : Integer): zglPSymbolNode;
var
  dw, dh : Single;
  c1, c2 : zglPSymbolNode;
begin
  if not node.leaf Then
  begin
    Result := fontgen_InsertSymbol(node.child[0], r, ID);
    if not Assigned(Result) Then
      Result := fontgen_InsertSymbol(node.child[1], r, ID);
  end else
  begin
    if node.ID <> -1 Then
    begin
      Result := nil;
      exit;
    end;

    if (r.W > node.rect.W) or (r.H > node.rect.H) Then
    begin
      Result := nil;
      exit;
    end;

    if (r.W = node.rect.W) and (r.H = node.rect.H) Then
    begin
      Result := node;
      node.ID := ID;
      exit;
    end;

    zgl_GetMem(Pointer(node.child[0]), SizeOf(zglTSymbolNode));
    zgl_GetMem(Pointer(node.child[1]), SizeOf(zglTSymbolNode));
    node.leaf := FALSE;

    c1 := node.child[0];
    c2 := node.child[1];

    dw := node.rect.w - r.w;
    dh := node.rect.h - r.h;

    if dw > dh Then
    begin
      c1.leaf   := TRUE;
      c1.ID     := -1;
      c1.rect.X := node.rect.X;
      c1.rect.Y := node.rect.Y;
      c1.rect.W := r.W;
      c1.rect.H := node.rect.H;

      c2.leaf   := TRUE;
      c2.ID     := -1;
      c2.rect.X := node.rect.X + r.W;
      c2.rect.Y := node.rect.Y;
      c2.rect.W := node.rect.W - r.W;
      c2.rect.H := node.rect.H;
    end else
    begin
      c1.leaf   := TRUE;
      c1.ID     := -1;
      c1.rect.X := node.rect.X;
      c1.rect.Y := node.rect.Y;
      c1.rect.W := node.rect.W;
      c1.rect.H := r.H;

      c2.leaf   := TRUE;
      c2.ID     := -1;
      c2.rect.X := node.rect.X;
      c2.rect.Y := node.rect.Y + r.H;
      c2.rect.W := node.rect.W;
      c2.rect.H := node.rect.H - r.H;
    end;

    Result := fontgen_InsertSymbol(Pointer(node.child[0]), r, ID);
  end;
end;

procedure fontgen_FreeSymbolNode(node : zglPSymbolNode; root : Boolean);
begin
  if Assigned(node.child[0]) Then
    fontgen_FreeSymbolNode(node.child[0], FALSE);

  if Assigned(node.child[1]) Then
    fontgen_FreeSymbolNode(node.child[1], FALSE);

  if not root Then
    FreeMem(node);
end;

{$IFDEF WIN32}
{$IFNDEF FPC}
type NEWTEXTMETRICEX = NEWTEXTMETRICEXW;
{$ENDIF}
function FontEnumProc(var _para1:ENUMLOGFONTEX;var _para2:NEWTEXTMETRICEX; _para3:longint; _para4:LPARAM):longint;stdcall;
begin
  if not (_para1.elfLogFont.lfFaceName[0] in ['A'..'Z', 'a'..'z', '0'..'9']) Then exit;

  INC(fg_FontList.Count);
  SetLength(fg_FontList.Items, fg_FontList.Count);
  fg_FontList.Items[fg_FontList.Count - 1] := _para1.elfLogFont.lfFaceName;
  if fg_FontList.Count - 2 >= 0 Then
    if fg_FontList.Items[fg_FontList.Count - 1] = fg_FontList.Items[fg_FontList.Count - 2] Then
    begin
      SetLength(fg_FontList.Items, fg_FontList.Count - 1);
      DEC(fg_FontList.Count);
    end;
  Result := 1;
end;

procedure FontGetSize(pData : Pointer; W, H : Integer; var nW, nH, mX, mY : Integer);
  var
    i, j       : Integer;
    maxX, minX : Integer;
    maxY, minY : Integer;
begin
  maxX := 0;
  minX := W;
  maxY := 0;
  minY := H;
  for i := 0 to W - 1 do
    for j := 0 to H - 1 do
      if PByte(Ptr(pData) +  i * 4 + j * W * 4)^ > 0 Then
      begin
        if i < minX Then minX := i;
        if i > maxX Then maxX := i;

        if j < minY Then minY := j;
        if j > maxY Then maxY := j;
      end;
  nW     := maxX - minX;
  nH     := maxY - minY;
  if nW < 0 Then nW := 0;
  if nH < 0 Then nH := 0;
  mX := minX;
  mY := minY;
  if mX = W Then mX := 0;
  if mY = H Then mY := 0;
end;
{$ENDIF}

function fontgen_Init : Boolean;
  var
    i : Integer;
    LFont : LOGFONT;
begin
  Result := FALSE;

  FillChar(LFont, SizeOf(LFont), 0);
  LFont.lfCharSet := DEFAULT_CHARSET;
  EnumFontFamiliesEx(wndDC, LFont, @FontEnumProc, 0, 0);

  u_SortList(fg_FontList, 0, fg_FontList.Count - 1);

  Result := TRUE;
end;

procedure fontgen_PutChar(var pData : Pointer; X, Y, ID : Integer);
  var
    i, j   : Integer;
    fw, fh : Integer;
    pixel  : PByte;
begin
  if length(fg_CharsImage[ID]) = 0 Then
    exit;

  fw := Round(fg_CharsSize[ID].W);
  fh := Round(fg_CharsSize[ID].H);

  for i := 0 to fw - 1 do
    for j := 0 to fh - 1 do
    begin
      pixel  := PByte(Ptr(pData) + (i + X) * 4 + (j + Y) * fg_PageSize * 4);
      pixel^ := 255; INC(pixel);
      pixel^ := 255; INC(pixel);
      pixel^ := 255; INC(pixel);
      pixel^ := fg_CharsImage[ID, i + j * fw];
    end;
end;

procedure fontgen_BuildFont(var Font: Byte; const FontName: String);
  var
    pData    : Pointer;
    i, j     : Integer;
    CharID   : Integer;
    CharUID  : WORD;
    cx, cy   : Integer;
    sx, sy   : Integer;
    cs       : Integer;
    u, v     : Single;
    MaxWidth : Integer;
    sn       : zglPSymbolNode;
    sr       : zglTRect;

    WDC        : HDC;
    WFont      : HFONT;
    Bitmap     : BITMAPINFO;
    DIB        : DWORD;
    CharSize   : TSize;
    TextMetric : TTextMetricW;
    Rect       : TRect;
    minX, minY : Integer;
begin
  if (managerFont.Font[Font].Flags and Enable) > 0 then
  begin
    for i := 0 to Length(managerFont.Font[Font].Pages) - 1 do
      tex_Del(managerFont.Font[Font].Pages[i]);

    for i := 0 to 65535 do
      if Assigned(managerFont.Font[Font].CharDesc[i]) then
      begin
        Freememory(managerFont.Font[Font].CharDesc[i]);
        managerFont.Font[Font].CharDesc[i] := nil;
      end;
    SetLength(managerFont.Font[Font].Pages, 0);
  end;        

  MaxWidth := 0;

  // установка размерностей
  SetLength(fg_CharsSize,  managerFont.Font[Font].Count.Chars);
  SetLength(fg_CharsUID,   managerFont.Font[Font].Count.Chars);
  SetLength(fg_CharsImage, managerFont.Font[Font].Count.Chars);
  SetLength(fg_CharsP,     managerFont.Font[Font].Count.Chars);

  j := 0;
  for i := 0 to 65535 do
    if fg_CharsUse[i] Then                        // "определяем" конкретное число символов.
    begin
      SetLength(fg_CharsUID, j + 1);
      fg_CharsUID[j] := i;
      INC(j);
    end;


{$IFDEF WIN32}
  if fg_FontBold Then
    cs := FW_BOLD
  else
    cs := FW_NORMAL;
  WFont := CreateFont(- MulDiv(fg_FontSize, GetDeviceCaps(wndDC, LOGPIXELSY), 72), 0, 0, 0,
                       cs, Byte(fg_FontItalic), 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                       5 * Byte(fg_FontAA) or ANTIALIASED_QUALITY * Byte(not fg_FontAA),
                       DEFAULT_PITCH, PChar(FontName));

  WDC := CreateCompatibleDC(0);
  SelectObject(WDC, WFont);
  SetTextAlign(WDC, TA_LEFT or TA_TOP or TA_NOUPDATECP);
  SetTextColor(WDC, $FFFFFF);
  SetBkColor  (WDC, $000000);

  GetTextMetricsW(WDC, TextMetric);

  FillChar(Bitmap, SizeOf(BITMAPINFO), 0);
  Bitmap.bmiHeader.biWidth       := TextMetric.tmMaxCharWidth * 2;
  Bitmap.bmiHeader.biHeight      := -TextMetric.tmHeight * 2;
  Bitmap.bmiHeader.biBitCount    := 32;
  Bitmap.bmiHeader.biCompression := BI_RGB;
  Bitmap.bmiHeader.biPlanes      := 1;
  Bitmap.bmiHeader.biSize        := Sizeof(BITMAPINFOHEADER);

  DIB := CreateDIBSection(WDC, Bitmap, DIB_RGB_COLORS, pData, 0, 0);
  SelectObject(WDC, DIB);
  SetRect(Rect, 0, 0, Bitmap.bmiHeader.biWidth, -Bitmap.bmiHeader.biHeight);

  for i := 0 to managerFont.Font[Font].Count.Chars - 1 do
  begin
    Windows.FillRect(WDC, Rect, GetStockObject(BLACK_BRUSH));
    TextOutW(WDC, TextMetric.tmMaxCharWidth div 2, TextMetric.tmHeight div 2, @fg_CharsUID[i], 1);

    GetTextExtentPoint32W(WDC, @fg_CharsUID[i], 1, CharSize);
    // Microsoft Sucks...
    FontGetSize(pData, Bitmap.bmiHeader.biWidth, -Bitmap.bmiHeader.biHeight, cx, cy, minX, minY);
    INC(cx, 1 + Byte(fg_FontAA));
    INC(cy, 1 + Byte(fg_FontAA));

    fg_CharsSize[i].X := minX - TextMetric.tmMaxCharWidth div 2;
    fg_CharsSize[i].Y := cy - (TextMetric.tmAscent - (minY - TextMetric.tmHeight div 2));
    fg_CharsSize[i].W := cx;
    fg_CharsSize[i].H := cy;
    fg_CharsP   [i]   := CharSize.cx;
    SetLength(fg_CharsImage[i], cx * cy);
    FillChar(fg_CharsImage[i, 0], cx * cy, $FF);
    MaxWidth := Trunc(Max(MaxWidth, fg_CharsSize[i].W + fg_FontPadding[0] + fg_FontPadding[2] + Byte(fg_FontAA)));
    MaxWidth := Trunc(Max(MaxWidth, fg_CharsSize[i].H + fg_FontPadding[1] + fg_FontPadding[3] + Byte(fg_FontAA)));

    for sx := minX to cx + minX - 1 do
      for sy := minY to cy + minY - 1 do
        fg_CharsImage[i, sx - minX + (sy - minY) * cx] :=
            (PByte(Ptr(pData) + sx * 4 + sy * Bitmap.bmiHeader.biWidth * 4 + 0)^ +
            PByte(Ptr(pData) + sx * 4 + sy * Bitmap.bmiHeader.biWidth * 4 + 1)^ +
            PByte(Ptr(pData) + sx * 4 + sy * Bitmap.bmiHeader.biWidth * 4 + 2)^) div 3;
  end;
  DeleteObject(DIB);
  DeleteDC(WDC);
  DeleteObject(WFont);
{$ENDIF}
  if fg_FontPack Then
  begin
    for i := 0 to length(fg_FontNodes) - 1 do
      fontgen_FreeSymbolNode(@fg_FontNodes[i], TRUE);

    managerFont.Font[Font].Count.Pages := 1;
    zgl_GetMem(pData, sqr(fg_PageSize) * 4);
    SetLength(managerFont.Font[Font].Pages, managerFont.Font[Font].Count.Pages);
    managerFont.Font[Font].Pages[0]        := tex_Add;
    managerFont.Font[Font].Pages[0].Format := TEX_FORMAT_RGBA;
    managerFont.Font[Font].Pages[0].Width  := fg_PageSize;
    managerFont.Font[Font].Pages[0].Height := fg_PageSize;
    managerFont.Font[Font].Pages[0].U      := 1;
    managerFont.Font[Font].Pages[0].V      := 1;
    managerFont.Font[Font].Pages[0].Flags  := TEX_CLAMP or TEX_FILTER_LINEAR;

    SetLength(fg_FontNodes, managerFont.Font[Font].Count.Pages);
    fg_FontNodes[0].leaf   := TRUE;
    fg_FontNodes[0].ID     := -1;
    fg_FontNodes[0].rect.X := 0;
    fg_FontNodes[0].rect.Y := 0;
    fg_FontNodes[0].rect.W := fg_PageSize;
    fg_FontNodes[0].rect.H := fg_PageSize;

    u := 1 / fg_PageSize;
    v := 1 / fg_PageSize;

    managerFont.Font[Font].MaxHeight := 0;
    managerFont.Font[Font].MaxShiftY := 0;

    i    := 0;
    sr.X := 0;
    sr.Y := 0;
    while i < managerFont.Font[Font].Count.Chars do
    begin
      CharUID := fg_CharsUID[i];

      sr.W := fg_CharsSize[i].W + fg_FontPadding[0] + fg_FontPadding[2];
      sr.H := fg_CharsSize[i].H + fg_FontPadding[1] + fg_FontPadding[3];

      sn := fontgen_InsertSymbol(@fg_FontNodes[managerFont.Font[Font].Count.Pages - 1], sr, CharUID);
      if not Assigned(sn) Then
      begin
        image_FlipVertically(pData, fg_PageSize, fg_PageSize, 4);
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1] := tex_Create(PByteArray(pData), fg_PageSize, fg_PageSize, TEX_FORMAT_RGBA, TEX_DEFAULT_2D);
        zgl_FreeMem(pData);

        zgl_GetMem(pData, sqr(fg_PageSize) * 4);
        INC(managerFont.Font[Font].Count.Pages);
        SetLength(managerFont.Font[Font].Pages, managerFont.Font[Font].Count.Pages);
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1]        := tex_Add();
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1].Format := TEX_FORMAT_RGBA;
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1].Width  := fg_PageSize;
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1].Height := fg_PageSize;
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1].U      := 1;
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1].V      := 1;
        managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1].Flags  := TEX_CLAMP or TEX_FILTER_LINEAR;

        SetLength(fg_FontNodes, managerFont.Font[Font].Count.Pages);
        fg_FontNodes[managerFont.Font[Font].Count.Pages - 1].leaf   := TRUE;
        fg_FontNodes[managerFont.Font[Font].Count.Pages - 1].ID     := -1;
        fg_FontNodes[managerFont.Font[Font].Count.Pages - 1].rect.X := 0;
        fg_FontNodes[managerFont.Font[Font].Count.Pages - 1].rect.Y := 0;
        fg_FontNodes[managerFont.Font[Font].Count.Pages - 1].rect.W := fg_PageSize;
        fg_FontNodes[managerFont.Font[Font].Count.Pages - 1].rect.H := fg_PageSize;
      end else
      begin
        fontgen_PutChar(pData, Round(sn.rect.X + fg_FontPadding[0]), Round(sn.rect.Y + fg_FontPadding[1]), i);
        SetLength(fg_CharsImage[i], 0);

        zgl_GetMem(Pointer(managerFont.Font[Font].CharDesc[CharUID]), SizeOf(zglTCharDesc));
        managerFont.Font[Font].CharDesc[CharUID].Page   := managerFont.Font[Font].Count.Pages - 1;
        managerFont.Font[Font].CharDesc[CharUID].Width  := Round(fg_CharsSize[i].W);
        managerFont.Font[Font].CharDesc[CharUID].Height := Round(fg_CharsSize[i].H);
        managerFont.Font[Font].CharDesc[CharUID].ShiftX := Round(fg_CharsSize[i].X);
        managerFont.Font[Font].CharDesc[CharUID].ShiftY := Round(fg_CharsSize[i].Y);
        managerFont.Font[Font].CharDesc[CharUID].ShiftP := fg_CharsP[i];

        managerFont.Font[Font].CharDesc[CharUID].TexCoords[0].X := (sn.rect.X) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[0].Y := 1 - (sn.rect.Y) * v;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[1].X := (sn.rect.X + sn.rect.W) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[1].Y := 1 - (sn.rect.Y) * v;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[2].X := (sn.rect.X + sn.rect.W) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[2].Y := 1 - (sn.rect.Y + sn.rect.H) * v;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[3].X := (sn.rect.X) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[3].Y := 1 - (sn.rect.Y + sn.rect.H) * v;

        managerFont.Font[Font].MaxHeight := Round(Max(managerFont.Font[Font].MaxHeight, fg_CharsSize[i].H));
        managerFont.Font[Font].MaxShiftY := Round(Max(managerFont.Font[Font].MaxShiftY, managerFont.Font[Font].CharDesc[CharUID].ShiftY));
        INC(i);
      end;
    end;
    image_FlipVertically(pData, fg_PageSize, fg_PageSize, 4);
    managerFont.Font[Font].Pages[managerFont.Font[Font].Count.Pages - 1] := tex_Create(PByteArray(pData), fg_PageSize, fg_PageSize, TEX_FORMAT_RGBA, TEX_DEFAULT_2D);
    zgl_FreeMem(pData);
  end else
  begin
    if MaxWidth = 0 Then
      MaxWidth := 1;
    fg_PageChars := fg_PageSize div MaxWidth;
    cs := fg_PageSize div fg_PageChars;

    managerFont.Font[Font].Count.Pages := managerFont.Font[Font].Count.Chars div sqr(fg_PageChars) + 1;
    SetLength(managerFont.Font[Font].Pages, managerFont.Font[Font].Count.Pages);
    managerFont.Font[Font].MaxHeight := 0;
    managerFont.Font[Font].MaxShiftY := 0;
    for i := 0 to managerFont.Font[Font].Count.Pages - 1 do
    begin
      u := 1 / fg_PageSize;
      v := 1 / fg_PageSize;

      zgl_GetMem(pData, sqr(fg_PageSize) * 4);
      for j := 0 to sqr(fg_PageChars) - 1 do
      begin
        CharID := j + i * sqr(fg_PageChars);
        if CharID > managerFont.Font[Font].Count.Chars - 1 Then
          break;
        cy  := j div fg_PageChars;
        cx  := j - cy * fg_PageChars;
        fontgen_PutChar(pData, cx * cs + (cs - Round(fg_CharsSize[CharID].W)) div 2,
                    cy * cs + (cs - Round(fg_CharsSize[CharID].H)) div 2, CharID);
        SetLength(fg_CharsImage[CharID], 0);

        CharUID := fg_CharsUID[CharID];
        zgl_GetMem(Pointer(managerFont.Font[Font].CharDesc[CharUID]), SizeOf(zglTCharDesc));
        managerFont.Font[Font].CharDesc[CharUID].Page   := i;
        managerFont.Font[Font].CharDesc[CharUID].Width  := Round(fg_CharsSize[CharID].W);
        managerFont.Font[Font].CharDesc[CharUID].Height := Round(fg_CharsSize[CharID].H);
        managerFont.Font[Font].CharDesc[CharUID].ShiftX := Round(fg_CharsSize[CharID].X);
        managerFont.Font[Font].CharDesc[CharUID].ShiftY := Round(fg_CharsSize[CharID].Y);
        managerFont.Font[Font].CharDesc[CharUID].ShiftP := fg_CharsP[CharID];

        sx := Round(fg_CharsSize[CharID].W);
        sy := Round(fg_CharsSize[CharID].H);
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[0].X := (cx * cs + (cs - sx) div 2 - fg_FontPadding[0]) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[0].Y := 1 - (cy * cs + (cs - sy) div 2 - fg_FontPadding[1]) * v;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[1].X := (cx * cs + (cs - sx) div 2 + sx + fg_FontPadding[2]) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[1].Y := 1 - (cy * cs + (cs - sy) div 2 - fg_FontPadding[1]) * v;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[2].X := (cx * cs + (cs - sx) div 2 + sx + fg_FontPadding[2]) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[2].Y := 1 - (cy * cs + (cs - sy) div 2 + sy + fg_FontPadding[3]) * v;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[3].X := (cx * cs + (cs - sx) div 2 - fg_FontPadding[0]) * u;
        managerFont.Font[Font].CharDesc[CharUID].TexCoords[3].Y := 1 - (cy * cs + (cs - sy) div 2 + sy + fg_FontPadding[3]) * v;

        managerFont.Font[Font].MaxHeight := Round(Max(managerFont.Font[Font].MaxHeight, fg_CharsSize[CharID].H));
        managerFont.Font[Font].MaxShiftY := Round(Max(managerFont.Font[Font].MaxShiftY, managerFont.Font[Font].CharDesc[CharUID].ShiftY));
      end;
      image_FlipVertically(pData, fg_PageSize, fg_PageSize, 4);
      managerFont.Font[Font].Pages[i] := tex_Create(PByteArray(pData), fg_PageSize, fg_PageSize, TEX_FORMAT_RGBA, TEX_DEFAULT_2D);
      zgl_FreeMem(pData);
    end;
  end;
  managerFont.Font[Font].Padding[0] := fg_FontPadding[0];
  managerFont.Font[Font].Padding[1] := fg_FontPadding[1];
  managerFont.Font[Font].Padding[2] := fg_FontPadding[2];
  managerFont.Font[Font].Padding[3] := fg_FontPadding[3];
end;

procedure fontgen_SaveFont(Font: Byte; const FileName: String);
  type
    zglPTGAHeader = ^zglTTGAHeader;
    zglTTGAHeader = packed record
      IDLength  : Byte;
      CPalType  : Byte;
      ImageType : Byte;
      CPalSpec  : packed record
        FirstEntry : Word;
        Length     : Word;
        EntrySize  : Byte;
                  end;
      ImgSpec   : packed record
        X      : Word;
        Y      : Word;
        Width  : Word;
        Height : Word;
        Depth  : Byte;
        Desc   : Byte;
                  end;
  end;
  var
    TGA  : zglTTGAHeader;
    F    : zglTFile;
    i, c : Integer;
    Data : Pointer;
    {$IFDEF USE_PNG}
    Image : TImageData;
    {$ENDIF}
begin
  file_Open(F, FileName + '.zfi', FOM_CREATE);
  file_Write(F, ZGL_FONT_INFO, 13);
  file_Write(F, managerFont.Font[Font].Count.Pages, 2);
  file_Write(F, managerFont.Font[Font].Count.Chars, 2);
  file_Write(F, managerFont.Font[Font].MaxHeight,   4);
  file_Write(F, managerFont.Font[Font].MaxShiftY,   4);
  file_Write(F, fg_FontPadding[0],  4);
  // сохраняем .zfi
  for i := 0 to managerFont.Font[Font].Count.Chars - 1 do
  begin
    c := fg_CharsUID[i];
    file_Write(F, c, 4);
    file_Write(F, managerFont.Font[Font].CharDesc[c].Page, 4);
    file_Write(F, managerFont.Font[Font].CharDesc[c].Width, 1);
    file_Write(F, managerFont.Font[Font].CharDesc[c].Height, 1);
    file_Write(F, managerFont.Font[Font].CharDesc[c].ShiftX, 4);
    file_Write(F, managerFont.Font[Font].CharDesc[c].ShiftY, 4);
    file_Write(F, managerFont.Font[Font].CharDesc[c].ShiftP, 4);
    file_Write(F, managerFont.Font[Font].CharDesc[c].TexCoords[0], SizeOf(zglTPoint2D) * 4);
  end;
  file_Close(F);
  // сохраняем сам фонт
  for i := 0 to managerFont.Font[Font].Count.Pages - 1 do
  begin
    FillChar(TGA, SizeOf(zglTTGAHeader), 0);
    TGA.ImageType      := 2;
    TGA.ImgSpec.Width  := fg_PageSize;
    TGA.ImgSpec.Height := fg_PageSize;
    TGA.ImgSpec.Depth  := 32;
    TGA.ImgSpec.Desc   := 8;

    tex_GetData(managerFont.Font[Font].Pages[i], PByteArray(Data));

    file_Open(F, FileName + '-page' + u_IntToStr(i) + '.tga', FOM_CREATE);
    file_Write(F, TGA, SizeOf(zglTTGAHeader));
    file_Write(F, Data^, sqr(fg_PageSize) * 4);
    file_Close(F);
    FreeMemory(Data);

    {$IFDEF USE_PNG}
    LoadImageFromFile(FileName + '-page' + u_IntToStr(i) + '.tga', Image);
    ConvertImage(Image, ifA8R8G8B8);
    SaveImageToFile(FileName + '-page' + u_IntToStr(i) + '.png', Image);
    DeleteFile(FileName + '-page' + u_IntToStr(i) + '.tga');
    {$ENDIF}
  end;
end;

end.
