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
  {$IFDEF LINUX}
  X, XLib, XRender,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF USE_PNG}
  SysUtils,
  Imaging,
  ImagingTypes,
  {$ENDIF}
  zgl_types,
  zgl_math_2d,
  zgl_font;

type
  zglPSymbolNode = ^zglTSymbolNode;
  zglTSymbolNode = record
    leaf  : Boolean;
    ID    : Integer;
    rect  : zglTRect;
    child : array[0..1] of zglPSymbolNode;
  end;

function  fontgen_Init: Boolean;
procedure fontgen_BuildFont(var Font: Byte; const FontName: String );
procedure fontgen_SaveFont(Font: Byte; const FileName: String );

var
  fg_Font        : Byte;
  fg_FontNodes   : array of zglTSymbolNode;                     // походу перепись страниц, где существует фонт
  fg_CharsUse    : array[ 0..65535 ] of Boolean;
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
  fg_FontPadding : array[ 0..3 ] of Byte = (2, 2, 2, 2);
  fg_PageSize    : Integer = 256;
  fg_PageChars   : Integer = 17;

{$IFDEF LINUX}
const
  libxft = 'libXft';
  libfontconfig = 'libfontconfig';

  FC_FAMILY  = 'family';

  FC_ANTIALIAS  = 'antialias';
  FC_SIZE       = 'size';
  FC_SLANT      = 'slant';
  FC_WEIGHT     = 'weight';

  FC_WEIGHT_LIGHT = 50;
  FC_WEIGHT_BLACK = 210;
  FC_SLANT_ROMAN  = 0;
  FC_SLANT_ITALIC = 100;

type
  PFcResult = ^TFcResult;
  TFcResult = (FcResultMatch, FcResultNoMatch, FcResultTypeMismatch, FcResultNoId, FcResultOutOfMemory);

  PFcConfig = ^TFcConfig;
  TFcConfig = record
    //dummy
  end;

  PFcCharset = ^TFcCharset;
  TFcCharset =  record
    //dummy
  end;

  PFcPattern  = ^TFcPattern;
  PPFcPattern = ^PFcPattern;
  TFcPattern  =  record
    //dummy
  end;

  PFcFontSet = ^TFcFontSet;
  TFcFontSet =  record
    nfont : integer;
    sfont : integer;
    fonts : array of PFcPattern;
  end;

  PFcObjectSet = ^TFcObjectSet;
  TFcObjectSet = record
    nobject : longint;
    sobject : longint;
    objects : ppchar;
  end;

  PXftFont = ^TXftFont;
  TXftFont =  record
    ascent            : longint;
    descent           : longint;
    height            : longint;
    max_advance_width : longint;
    charset           : ^TFcCharSet;
    pattern           : ^TFcPattern;
  end;

  PXftDraw  = ^TXftDraw;
  TXftDraw =  record
    //dummy
  end;

  PXRenderColor = ^TXRenderColor;
  TXRenderColor = record
    red   : word;
    green : word;
    blue  : word;
    alpha : word;
  end;

  PXftColor  = ^TXftColor;
  TXftColor =  record
    pixel : dword;
    color : TXRenderColor;
  end;

function  XftInitFtLibrary: LongBool; cdecl; external libxft;
function  XftListFonts(dpy: PDisplay; screen: longint; args: array of const): PFcFontSet; cdecl; external libXft;
function  XftFontOpenPattern(dpy: PDisplay; pattern: PFcPattern): PXftFont; cdecl; external libXft;
procedure XftFontClose(dpy: PDisplay; pub: PXftFont); cdecl; external libXft;
function  XftFontMatch(dpy: PDisplay; screen: longint; pattern: PFcPattern; result: PFcResult): PFcPattern; cdecl; external libXft;
function  XftCharExists(dpy: PDisplay; pub: PXftFont; ucs4: DWORD): LongBool; cdecl; external libXft;
procedure XftTextExtents16(dpy: PDisplay; pub: PXftFont; _string: PByte; len: longint; extents: PXGlyphInfo); cdecl; external libXft;
procedure XftDrawString16(draw: PXftDraw; color: PXftColor; pub: PXftFont; x, y: longint; _string: PByte; len: longint); cdecl; external libXft;

function  XftColorAllocValue(dpy: PDisplay; visual: PVisual; cmap: TColormap; color: PXRenderColor; result: PXftColor): LongBool; cdecl; external libXft;
procedure XftColorFree(dpy: PDisplay; visual: PVisual; cmap: TColormap; color: PXftColor); cdecl; external libXft;
function  XftDrawCreate(dpy: PDisplay; drawable: TDrawable; visual: PVisual; colormap: TColormap): PXftDraw; cdecl; external libXft;
procedure XftDrawDestroy(draw: PXftDraw); cdecl; external libXft;
procedure XftDrawRect(draw: PXftDraw; color: PXftColor; x, y: longint; width, height: dword); cdecl; external libXft;

// FontSet
procedure FcFontSetDestroy(s: PFcFontSet); cdecl; external libfontconfig;
// Pattern
function  FcPatternCreate: PFcPattern; cdecl; external libfontconfig;
procedure FcPatternDestroy(p: PFcPattern); cdecl; external libfontconfig;
function  FcPatternAddBool(p: PFcPattern; _object: PChar; b: LongBool): LongBool; cdecl; external libfontconfig;
function  FcPatternGetBool(const p: PFcPattern; const _object: PChar; n: Integer; b: PLongBool): TFcResult; cdecl; external libfontconfig;
function  FcPatternAddInteger(p: PFcPattern; _object: PChar; i: LongInt): LongBool; cdecl; external libfontconfig;
function  FcPatternAddString(p: PFcPattern; _object: PChar; s: PAnsiChar): LongBool; cdecl; external libfontconfig;
function  FcPatternGetString(const p: PFcPattern; const _object: PChar; n: Integer; s: PPChar): TFcResult; cdecl; external libfontconfig;
// ObjectSet
function  FcObjectSetCreate: PFcObjectSet; cdecl; external libfontconfig;
procedure FcObjectSetDestroy(os: PFcObjectSet); cdecl; external libfontconfig;
function  FcObjectSetAdd(os: PFcObjectSet; _object: PChar): LongBool; cdecl; external libfontconfig;
// FontList
function  FcFontList(config: PFcConfig; p: PFcPattern; os: PFcObjectSet): PFcFontSet; cdecl; external libfontconfig;
{$ENDIF}

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

procedure image_FlipVertically(var Data: Pointer; w, h, pixelSize: Integer);
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

function fontgen_InsertSymbol(node: zglPSymbolNode; const r: zglTRect; ID: Integer) : zglPSymbolNode;
  var
    dw, dh : Single;
    c1, c2 : zglPSymbolNode;
begin
  if not node^.leaf Then
  begin
    Result := fontgen_InsertSymbol(node^.child[0], r, ID);
    if not Assigned(Result) Then
      Result := fontgen_InsertSymbol(node^.child[1], r, ID);
  end else
  begin
    if node^.ID <> -1 Then
    begin
      Result := nil;
      exit;
    end;

    if (r.W > node^.rect.W) or (r.H > node^.rect.H) Then
    begin
      Result := nil;
      exit;
    end;

    if (r.W = node^.rect.W) and (r.H = node^.rect.H) Then
    begin
      Result := node;
      node^.ID := ID;
      exit;
    end;

    zgl_GetMem(Pointer(node^.child[0]), SizeOf(zglTSymbolNode));
    zgl_GetMem(Pointer(node^.child[1]), SizeOf(zglTSymbolNode));
    node^.leaf := FALSE;

    c1 := node^.child[0];
    c2 := node^.child[1];

    dw := node^.rect.w - r.w;
    dh := node^.rect.h - r.h;

    if dw > dh Then
    begin
      c1^.leaf   := TRUE;
      c1^.ID     := -1;
      c1^.rect.X := node^.rect.X;
      c1^.rect.Y := node^.rect.Y;
      c1^.rect.W := r.W;
      c1^.rect.H := node^.rect.H;

      c2^.leaf   := TRUE;
      c2^.ID     := -1;
      c2^.rect.X := node^.rect.X + r.W;
      c2^.rect.Y := node^.rect.Y;
      c2^.rect.W := node^.rect.W - r.W;
      c2^.rect.H := node^.rect.H;
    end else
    begin
      c1^.leaf   := TRUE;
      c1^.ID     := -1;
      c1^.rect.X := node^.rect.X;
      c1^.rect.Y := node^.rect.Y;
      c1^.rect.W := node^.rect.W;
      c1^.rect.H := r.H;

      c2^.leaf   := TRUE;
      c2^.ID     := -1;
      c2^.rect.X := node^.rect.X;
      c2^.rect.Y := node^.rect.Y + r.H;
      c2^.rect.W := node^.rect.W;
      c2^.rect.H := node^.rect.H - r.H;
    end;

    Result := fontgen_InsertSymbol(Pointer(node^.child[0]), r, ID);
  end;
end;

procedure fontgen_FreeSymbolNode(node: zglPSymbolNode; root: Boolean );
begin
  if Assigned(node^.child[0]) Then
    fontgen_FreeSymbolNode(node^.child[0], FALSE );

  if Assigned(node^.child[1]) Then
    fontgen_FreeSymbolNode(node^.child[1], FALSE);

  if not root Then
    FreeMem(node);
end;

{$IFDEF WINDOWS}
{$IFNDEF FPC}
type NEWTEXTMETRICEX = NEWTEXTMETRICEXW;
{$ENDIF}
function FontEnumProc(var _para1: ENUMLOGFONTEX; var _para2: NEWTEXTMETRICEX; _para3: longint; _para4: LPARAM): longint; stdcall;
begin
  if not (_para1.elfLogFont.lfFaceName[0] in ['A'..'Z', 'a'..'z', '0'..'9']) Then
    exit;

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

procedure FontGetSize(pData: Pointer; W, H: Integer; var nW, nH, mX, mY: Integer);
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
        if i < minX Then
          minX := i;
        if i > maxX Then
          maxX := i;

        if j < minY Then
          minY := j;
        if j > maxY Then
          maxY := j;
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

function fontgen_Init: Boolean;
  var
    i : Integer;
    {$IFDEF LINUX}
    Fonts     : PFcFontSet;
    Pattern   : PFcPattern;
    ObjectSet : PFcObjectSet;
    Family    : PChar;
    {$ENDIF}
    {$IFDEF WIN32}
    LFont : LOGFONT;
    {$ENDIF}
begin
  Result := FALSE;
{$IFDEF LINUX}
  if not XftInitFtLibrary Then
    begin
      log_Add('ERROR: XftInitFtLibrary');
      exit;
    end;

  Pattern   := FcPatternCreate;
  ObjectSet := FcObjectSetCreate;
  FcObjectSetAdd(ObjectSet, FC_FAMILY);

  Fonts := FcFontList(nil, Pattern, ObjectSet);
  fg_FontList.Count := 0;
  SetLength(fg_FontList.Items, 0);
  for i := 0 to Fonts^.nfont - 1 do
    begin
      FcPatternGetString(Fonts^.fonts[i], FC_FAMILY, 0, @Family);
      INC(fg_FontList.Count);
      SetLength(fg_FontList.Items, fg_FontList.Count);
      fg_FontList.Items[fg_FontList.Count - 1] := Family;

      Family := nil;
    end;
  FcFontSetDestroy(Fonts);
  FcObjectSetDestroy(ObjectSet);
  FcPatternDestroy(Pattern);
{$ENDIF}
{$IFDEF WIN32}
  FillChar(LFont, SizeOf(LFont), 0);
  LFont.lfCharSet := DEFAULT_CHARSET;
  EnumFontFamiliesEx(wndDC, LFont, @FontEnumProc, 0, 0);
{$ENDIF}

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
        pixel^ := 255;
        INC(pixel);
        pixel^ := 255;
        INC(pixel);
        pixel^ := 255;
        INC(pixel);
        pixel^ := fg_CharsImage[ ID, i + j * fw ];
      end;
end;

procedure fontgen_BuildFont( var Font : Byte; const FontName : String );
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
    {$IFDEF LINUX}
    scrVisual  : PVisual;
    Family     : array[ 0..255 ] of Char;
    Pattern    : PFcPattern;
    XFont      : PXftFont;
    XFontMatch : PFcPattern;
    XGlyphInfo : TXGlyphInfo;
    FcResult   : TFcResult;

    pixmap  : TPixmap;
    draw    : PXftDraw;
    rWhite  : TXftColor;
    rBlack  : TXftColor;
    cWhite  : TXRenderColor = ( red: $FFFF; green: $FFFF; blue: $FFFF; alpha: $FFFF );
    cBlack  : TXRenderColor = ( red: $0000; green: $0000; blue: $0000; alpha: $FFFF );
    image   : PXImage;
    color   : DWORD;
    r, g, b : DWORD;
    {$ENDIF}
    {$IFDEF WINDOWS}
    WDC        : HDC;
    WFont      : HFONT;
    Bitmap     : BITMAPINFO;
    DIB        : DWORD;
    CharSize   : TSize;
    TextMetric : TTextMetricW;
    Rect       : TRect;
    minX, minY : Integer;
    {$ENDIF}
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
  SetLength(fg_CharsSize,  managerFont.Font[Font].Count.Chars);
  SetLength(fg_CharsUID,   managerFont.Font[Font].Count.Chars);
  SetLength(fg_CharsImage, managerFont.Font[Font].Count.Chars);
  SetLength(fg_CharsP,     managerFont.Font[Font].Count.Chars);
  j := 0;
  for i := 0 to 65535 do
    if fg_CharsUse[ i ] Then
    begin
      SetLength( fg_CharsUID, j + 1 );
//      log_Add(u_IntToStr(i) + ' ' + u_IntToStr(j));
      fg_CharsUID[ j ] := i;
      INC( j );
    end;

{$IFDEF LINUX}
  scrVisual := DefaultVisual( scrDisplay, scrDefault );

  Family  := FontName;

  Pattern := FcPatternCreate;
  FcPatternAddString( Pattern, FC_FAMILY, @Family[ 0 ] );

  FcPatternAddInteger( Pattern, FC_SIZE, fg_FontSize );
  FcPatternAddInteger( Pattern, FC_WEIGHT, ( FC_WEIGHT_BLACK * Byte( fg_FontBold ) ) or ( FC_WEIGHT_LIGHT * Byte( not fg_FontBold ) ) );
  FcPatternAddInteger( Pattern, FC_SLANT, ( FC_SLANT_ITALIC * Byte( fg_FontItalic ) ) or ( FC_SLANT_ROMAN * Byte( not fg_FontItalic ) ) );
  FcPatternAddBool( Pattern, FC_ANTIALIAS, fg_FontAA );

  XFontMatch := XftFontMatch( scrDisplay, scrDefault, Pattern, @FcResult );
  XFont := XftFontOpenPattern( scrDisplay, XFontMatch );

  XftColorAllocValue( scrDisplay, scrVisual, DefaultColormap( scrDisplay, scrDefault ), @cWhite, @rWhite );
  XftColorAllocValue( scrDisplay, scrVisual, DefaultColormap( scrDisplay, scrDefault ), @cBlack, @rBlack );

  for i := 0 to managerFont.Font[Font].Count.Chars - 1 do
    if XftCharExists( scrDisplay, XFont, fg_CharsUID[ i ] ) Then
      begin
        XftTextExtents16( scrDisplay, XFont, @fg_CharsUID[ i ], 1, @XGlyphInfo );

        cx := XGlyphInfo.width;
        cy := XGlyphInfo.height;
        sx := XGlyphInfo.xOff;
        sy := XFont^.ascent - XGlyphInfo.y + XGlyphInfo.height;
        if cx > sx Then sx := cx;
        if cy > sy Then sy := cy;
        fg_CharsSize[ i ].X := -XGlyphInfo.x;
        fg_CharsSize[ i ].Y := XGlyphInfo.height - XGlyphInfo.y;
        fg_CharsSize[ i ].W := cx;
        fg_CharsSize[ i ].H := cy;
        fg_CharsP   [ i ]   := XGlyphInfo.xOff;
        MaxWidth := Trunc( Max( MaxWidth, fg_CharsSize[ i ].W + fg_FontPadding[ 0 ] + fg_FontPadding[ 2 ] ) );
        MaxWidth := Trunc( Max( MaxWidth, fg_CharsSize[ i ].H + fg_FontPadding[ 1 ] + fg_FontPadding[ 3 ] ) );

        if ( sx = 0 ) or ( sy = 0 ) Then continue;

        pixmap := XCreatePixmap( scrDisplay, wndRoot, sx, sy, DefaultDepth( scrDisplay, scrDefault ) );
        draw   := XftDrawCreate( scrDisplay, pixmap, scrVisual, DefaultColormap( scrDisplay, scrDefault ) );

        XftDrawRect( draw, @rBlack, 0, 0, sx, sy );
        XftDrawString16( draw, @rWhite, XFont, XGlyphInfo.x, XGlyphInfo.y, @fg_CharsUID[ i ], 1 );
        image := XGetImage( scrDisplay, pixmap, 0, 0, sx, sy, AllPlanes, ZPixmap );
        SetLength( fg_CharsImage[ i ], cx * cy );

        for sx := 0 to cx - 1 do
          for sy := 0 to cy - 1 do
            begin
              color := image^.f.get_pixel( image, sx, sy );
              r := color and scrVisual^.red_mask;
              g := color and scrVisual^.green_mask;
              b := color and scrVisual^.blue_mask;
              while r > $FF do r := r shr 8;
              while g > $FF do g := g shr 8;
              while b > $FF do b := b shr 8;
              fg_CharsImage[ i, sx + sy * cx ] := ( r + g + b ) div 3;
            end;
        image^.f.destroy_image( image );

        XftDrawDestroy( draw );
        XFreePixmap( scrDisplay, pixmap );
      end;

  XftColorFree( scrDisplay, scrVisual, DefaultColormap( scrDisplay, scrDefault ), @rWhite );
  XftColorFree( scrDisplay, scrVisual, DefaultColormap( scrDisplay, scrDefault ), @rBlack );

  XftFontClose( scrDisplay, XFont );
  FcPatternDestroy( Pattern );
{$ENDIF}
{$IFDEF WINDOWS}
  if fg_FontBold Then
    cs := FW_BOLD
  else
    cs := FW_NORMAL;
  WFont := CreateFont( -MulDiv( fg_FontSize, GetDeviceCaps( wndDC, LOGPIXELSY ), 72 ), 0, 0, 0,
                       cs, Byte( fg_FontItalic ), 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                       5 * Byte( fg_FontAA ) or ANTIALIASED_QUALITY * Byte( not fg_FontAA ),
                       DEFAULT_PITCH, PChar( FontName ) );

  WDC := CreateCompatibleDC( 0 );
  SelectObject( WDC, WFont );
  SetTextAlign( WDC, TA_LEFT or TA_TOP or TA_NOUPDATECP );
  SetTextColor( WDC, $FFFFFF );
  SetBkColor  ( WDC, $000000 );

  {$IFDEF FPC}
  GetTextMetricsW( WDC, @TextMetric );
  {$ELSE}
  GetTextMetricsW( WDC, TextMetric );
  {$ENDIF}

  FillChar( Bitmap, SizeOf( BITMAPINFO ), 0 );
  Bitmap.bmiHeader.biWidth       := TextMetric.tmMaxCharWidth * 2;
  Bitmap.bmiHeader.biHeight      := -TextMetric.tmHeight * 2;
  Bitmap.bmiHeader.biBitCount    := 32;
  Bitmap.bmiHeader.biCompression := BI_RGB;
  Bitmap.bmiHeader.biPlanes      := 1;
  Bitmap.bmiHeader.biSize        := Sizeof( BITMAPINFOHEADER );

  DIB := CreateDIBSection( WDC, Bitmap, DIB_RGB_COLORS, pData, 0, 0 );
  SelectObject( WDC, DIB );
  SetRect( Rect, 0, 0, Bitmap.bmiHeader.biWidth, -Bitmap.bmiHeader.biHeight );

  for i := 0 to managerFont.Font[Font].Count.Chars - 1 do
    begin
      Windows.FillRect( WDC, Rect, GetStockObject( BLACK_BRUSH ) );

      if (i >= 71) and (i <= 75) then
        log_Add(u_IntToStr(fg_CharsUID[i]));
      TextOutW( WDC, TextMetric.tmMaxCharWidth div 2, TextMetric.tmHeight div 2, @fg_CharsUID[ i ], 1 );

      GetTextExtentPoint32W( WDC, @fg_CharsUID[ i ], 1, CharSize );        // в CharSize возвращаются значения символа
      // Microsoft Sucks...
      FontGetSize( pData, Bitmap.bmiHeader.biWidth, -Bitmap.bmiHeader.biHeight, cx, cy, minX, minY );
      INC( cx, 1 + Byte( fg_FontAA ) );
      INC( cy, 1 + Byte( fg_FontAA ) );
      if (i >= 71) and (i <= 75) then
        log_Add('cx = ' + u_IntToStr(cx) + '; cy = ' + u_IntToStr(cy) + '; minX = ' + u_IntToStr(minX) + '; minY = ' + u_IntToStr(minY));

      fg_CharsSize[ i ].X := minX - TextMetric.tmMaxCharWidth div 2;
      fg_CharsSize[ i ].Y := cy - ( TextMetric.tmAscent - ( minY - TextMetric.tmHeight div 2 ) );
      fg_CharsSize[ i ].W := cx;
      fg_CharsSize[ i ].H := cy;
      if (i >= 71) and (i <= 75) then
        log_Add('x = ' + u_FloatToStr(fg_CharsSize[ i ].X) + '; y = ' + u_FloatToStr(fg_CharsSize[ i ].Y) + '; width = ' + u_FloatToStr(fg_CharsSize[ i ].W) + '; height = ' + u_FloatToStr(fg_CharsSize[ i ].H));
      if cx - minX > CharSize.cx then
        fg_CharsP[i] := cx - minX
      else
        fg_CharsP[i] := CharSize.cx;
      if (i >= 71) and (i <= 75) then
        log_Add(u_IntToStr(CharSize.cx));

      SetLength( fg_CharsImage[ i ], cx * cy );
      FillChar( fg_CharsImage[ i, 0 ], cx * cy, $FF );

      // максимальное значение ширины или высоты
      MaxWidth := Trunc( Max( MaxWidth, fg_CharsSize[ i ].W + fg_FontPadding[ 0 ] + fg_FontPadding[ 2 ] + Byte( fg_FontAA ) ) );
      MaxWidth := Trunc( Max( MaxWidth, fg_CharsSize[ i ].H + fg_FontPadding[ 1 ] + fg_FontPadding[ 3 ] + Byte( fg_FontAA ) ) );

      for sx := minX to cx + minX - 1 do
        for sy := minY to cy + minY - 1 do
          fg_CharsImage[ i, sx - minX + ( sy - minY ) * cx ] :=
          ( PByte( Ptr( pData ) + sx * 4 + sy * Bitmap.bmiHeader.biWidth * 4 + 0 )^ +
            PByte( Ptr( pData ) + sx * 4 + sy * Bitmap.bmiHeader.biWidth * 4 + 1 )^ +
            PByte( Ptr( pData ) + sx * 4 + sy * Bitmap.bmiHeader.biWidth * 4 + 2 )^ ) div 3;
   end;
  DeleteObject( DIB );
  DeleteDC( WDC );
  DeleteObject( WFont );
{$ENDIF}
  if fg_FontPack Then
    begin
      for i := 0 to length( fg_FontNodes ) - 1 do
        fontgen_FreeSymbolNode( @fg_FontNodes[ i ], TRUE );

      managerFont.Font[Font].Count.Pages := 1;
      zgl_GetMem( pData, sqr( fg_PageSize ) * 4 );
      SetLength( managerFont.Font[Font].Pages , managerFont.Font[Font].Count.Pages  );
      managerFont.Font[Font].Pages[0]         := tex_Add;
      managerFont.Font[Font].Pages[0]^.Format := TEX_FORMAT_RGBA;
      managerFont.Font[Font].Pages[0]^.Width  := fg_PageSize;
      managerFont.Font[Font].Pages[0]^.Height := fg_PageSize;
      managerFont.Font[Font].Pages[0]^.U      := 1;
      managerFont.Font[Font].Pages[0]^.V      := 1;
      managerFont.Font[Font].Pages[0]^.Flags  := TEX_CLAMP or TEX_FILTER_LINEAR;

      SetLength( fg_FontNodes, managerFont.Font[Font].Count.Pages );
      fg_FontNodes[ 0 ].leaf   := TRUE;
      fg_FontNodes[ 0 ].ID     := -1;
      fg_FontNodes[ 0 ].rect.X := 0;
      fg_FontNodes[ 0 ].rect.Y := 0;
      fg_FontNodes[ 0 ].rect.W := fg_PageSize;
      fg_FontNodes[ 0 ].rect.H := fg_PageSize;

      u := 1 / fg_PageSize;
      v := 1 / fg_PageSize;

      managerFont.Font[Font].MaxHeight := 0;
      managerFont.Font[Font].MaxShiftY := 0;

      i    := 0;
      sr.X := 0;
      sr.Y := 0;
      while i < managerFont.Font[Font].Count.Chars do
        begin
          CharUID := fg_CharsUID[ i ];

          sr.W := fg_CharsSize[ i ].W + fg_FontPadding[ 0 ] + fg_FontPadding[ 2 ];
          sr.H := fg_CharsSize[ i ].H + fg_FontPadding[ 1 ] + fg_FontPadding[ 3 ];

          sn := fontgen_InsertSymbol( @fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ], sr, CharUID );
          if not Assigned( sn ) Then
            begin
              image_FlipVertically( pData, fg_PageSize, fg_PageSize, 4 );
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ] := tex_Create( pData, fg_PageSize, fg_PageSize, TEX_FORMAT_RGBA, TEX_DEFAULT_2D );
              zgl_FreeMem( pData );

              zgl_GetMem( pData, sqr( fg_PageSize ) * 4 );
              inc(managerFont.Font[Font].Count.Pages);
              SetLength(managerFont.Font[Font].Pages, managerFont.Font[Font].Count.Pages);
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]         := tex_Add();
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]^.Format := TEX_FORMAT_RGBA;
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]^.Width  := fg_PageSize;
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]^.Height := fg_PageSize;
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]^.U      := 1;
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]^.V      := 1;
              managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ]^.Flags  := TEX_CLAMP or TEX_FILTER_LINEAR;

              SetLength( fg_FontNodes, managerFont.Font[Font].Count.Pages );
              fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ].leaf   := TRUE;
              fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ].ID     := -1;
              fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ].rect.X := 0;
              fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ].rect.Y := 0;
              fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ].rect.W := fg_PageSize;
              fg_FontNodes[ managerFont.Font[Font].Count.Pages - 1 ].rect.H := fg_PageSize;
            end else
              begin
                fontgen_PutChar( pData, Round( sn^.rect.X + fg_FontPadding[ 0 ] ), Round( sn^.rect.Y + fg_FontPadding[ 1 ] ), i );
                SetLength( fg_CharsImage[ i ], 0 );

                zgl_GetMem( Pointer( managerFont.Font[Font].CharDesc[ CharUID ] ), SizeOf( zglTCharDesc ) );
                managerFont.Font[Font].CharDesc[ CharUID ]^.Page   := managerFont.Font[Font].Count.Pages - 1;
                managerFont.Font[Font].CharDesc[ CharUID ]^.Width  := Round( fg_CharsSize[ i ].W );
                managerFont.Font[Font].CharDesc[ CharUID ]^.Height := Round( fg_CharsSize[ i ].H );
                managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftX := Round( fg_CharsSize[ i ].X );
                managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftY := Round( fg_CharsSize[ i ].Y );
                managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftP := fg_CharsP[ i ];

                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 0 ].X := ( sn^.rect.X ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 0 ].Y := 1 - ( sn^.rect.Y ) * v;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 1 ].X := ( sn^.rect.X + sn^.rect.W ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 1 ].Y := 1 - ( sn^.rect.Y ) * v;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 2 ].X := ( sn^.rect.X + sn^.rect.W ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 2 ].Y := 1 - ( sn^.rect.Y + sn^.rect.H ) * v;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 3 ].X := ( sn^.rect.X ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 3 ].Y := 1 - ( sn^.rect.Y + sn^.rect.H ) * v;

                managerFont.Font[Font].MaxHeight := Round( Max( managerFont.Font[Font].MaxHeight, fg_CharsSize[ i ].H ) );
                managerFont.Font[Font].MaxShiftY := Round( Max( managerFont.Font[Font].MaxShiftY, managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftY ) );
                INC( i );
              end;
        end;
      image_FlipVertically( pData, fg_PageSize, fg_PageSize, 4 );
      managerFont.Font[Font].Pages[ managerFont.Font[Font].Count.Pages - 1 ] := tex_Create( pData, fg_PageSize, fg_PageSize, TEX_FORMAT_RGBA, TEX_DEFAULT_2D );
      zgl_FreeMem( pData );
    end else
      begin
        if MaxWidth = 0 Then MaxWidth := 1;
        fg_PageChars := fg_PageSize div MaxWidth;
        cs := fg_PageSize div fg_PageChars;

        managerFont.Font[Font].Count.Pages := managerFont.Font[Font].Count.Chars div sqr( fg_PageChars ) + 1;
        SetLength( managerFont.Font[Font].Pages, managerFont.Font[Font].Count.Pages );
        managerFont.Font[Font].MaxHeight := 0;
        managerFont.Font[Font].MaxShiftY := 0;
        for i := 0 to managerFont.Font[Font].Count.Pages - 1 do
          begin
            u := 1 / fg_PageSize;
            v := 1 / fg_PageSize;

            zgl_GetMem( pData, sqr( fg_PageSize ) * 4 );
            for j := 0 to sqr( fg_PageChars ) - 1 do
              begin
                CharID := j + i * sqr( fg_PageChars );
                if CharID > managerFont.Font[Font].Count.Chars - 1 Then break;
                cy  := j div fg_PageChars;
                cx  := j - cy * fg_PageChars;

                sx := Round( fg_CharsSize[ CharID ].W );
                sy := Round( fg_CharsSize[ CharID ].H );

                fontgen_PutChar( pData, cx * cs + ( cs - sx ) div 2, cy * cs + ( cs - sy ) div 2, CharID );
                SetLength( fg_CharsImage[ CharID ], 0 );

                CharUID := fg_CharsUID[ CharID ];
                zgl_GetMem( Pointer( managerFont.Font[Font].CharDesc[ CharUID ] ), SizeOf( zglTCharDesc ) );
                managerFont.Font[Font].CharDesc[ CharUID ]^.Page   := i;
                managerFont.Font[Font].CharDesc[ CharUID ]^.Width  := sx;
                managerFont.Font[Font].CharDesc[ CharUID ]^.Height := sy;
                managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftX := Round( fg_CharsSize[ CharID ].X );
                managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftY := Round( fg_CharsSize[ CharID ].Y );
                managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftP := fg_CharsP[ CharID ];


                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 0 ].X := ( cx * cs + ( cs - sx ) div 2 - fg_FontPadding[ 0 ] ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 0 ].Y := 1 - ( cy * cs + ( cs - sy ) div 2 - fg_FontPadding[ 1 ] ) * v;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 1 ].X := ( cx * cs + ( cs - sx ) div 2 + sx + fg_FontPadding[ 2 ] ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 1 ].Y := 1 - ( cy * cs + ( cs - sy ) div 2 - fg_FontPadding[ 1 ] ) * v;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 2 ].X := ( cx * cs + ( cs - sx ) div 2 + sx + fg_FontPadding[ 2 ] ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 2 ].Y := 1 - ( cy * cs + ( cs - sy ) div 2 + sy + fg_FontPadding[ 3 ] ) * v;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 3 ].X := ( cx * cs + ( cs - sx ) div 2 - fg_FontPadding[ 0 ] ) * u;
                managerFont.Font[Font].CharDesc[ CharUID ]^.TexCoords[ 3 ].Y := 1 - ( cy * cs + ( cs - sy ) div 2 + sy + fg_FontPadding[ 3 ] ) * v;

                managerFont.Font[Font].MaxHeight := Round( Max( managerFont.Font[Font].MaxHeight, fg_CharsSize[ CharID ].H ) );
                managerFont.Font[Font].MaxShiftY := Round( Max( managerFont.Font[Font].MaxShiftY, managerFont.Font[Font].CharDesc[ CharUID ]^.ShiftY ) );
            end;
          image_FlipVertically( pData, fg_PageSize, fg_PageSize, 4 );
          managerFont.Font[Font].Pages[i] := tex_Create( pData, fg_PageSize, fg_PageSize, TEX_FORMAT_RGBA, TEX_DEFAULT_2D );
          zgl_FreeMem( pData );
        end;
    end;

  managerFont.Font[Font].Padding[ 0 ] := fg_FontPadding[ 0 ];
  managerFont.Font[Font].Padding[ 1 ] := fg_FontPadding[ 1 ];
  managerFont.Font[Font].Padding[ 2 ] := fg_FontPadding[ 2 ];
  managerFont.Font[Font].Padding[ 3 ] := fg_FontPadding[ 3 ];
end;

procedure fontgen_SaveFont( Font: Byte; const FileName : String );
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
  file_Open( F, FileName + '.zfi', FOM_CREATE );
  file_Write( F, ZGL_FONT_INFO, 13 );
  file_Write( F, managerFont.Font[Font].Count.Pages, 2 );
  file_Write( F, managerFont.Font[Font].Count.Chars, 2 );
  file_Write( F, managerFont.Font[Font].MaxHeight,   4 );
  file_Write( F, managerFont.Font[Font].MaxShiftY,   4 );
  file_Write( F, fg_FontPadding[ 0 ],  4 );
  for i := 0 to managerFont.Font[Font].Count.Chars - 1 do
    begin
      c := fg_CharsUID[ i ];
      file_Write( F, c, 4 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.Page, 4 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.Width, 1 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.Height, 1 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.ShiftX, 4 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.ShiftY, 4 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.ShiftP, 4 );
      file_Write( F, managerFont.Font[Font].CharDesc[ c ]^.TexCoords[ 0 ], SizeOf( zglTPoint2D ) * 4 );
    end;
  file_Close( F );
  for i := 0 to managerFont.Font[Font].Count.Pages - 1 do
    begin
      FillChar( TGA, SizeOf( zglTTGAHeader ), 0 );
      TGA.ImageType      := 2;
      TGA.ImgSpec.Width  := fg_PageSize;
      TGA.ImgSpec.Height := fg_PageSize;
      TGA.ImgSpec.Depth  := 32;
      TGA.ImgSpec.Desc   := 8;

      tex_GetData( managerFont.Font[Font].Pages[i], Data );

      file_Open( F, FileName + '-page' + u_IntToStr( i ) + '.tga', FOM_CREATE );
      file_Write( F, TGA, SizeOf( zglTTGAHeader ) );
      file_Write( F, Data^, sqr( fg_PageSize ) * 4 );
      file_Close( F );
      FreeMemory( Data );

      {$IFDEF USE_PNG}
      LoadImageFromFile( FileName + '-page' + u_IntToStr( i ) + '.tga', Image );
      ConvertImage( Image, ifA8R8G8B8 );
      SaveImageToFile( FileName + '-page' + u_IntToStr( i ) + '.png', Image );
      DeleteFile( FileName + '-page' + u_IntToStr( i ) + '.tga' );
      {$ENDIF}
    end;
end;

end.
