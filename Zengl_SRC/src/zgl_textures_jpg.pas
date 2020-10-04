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
unit zgl_textures_jpg;

{$I zgl_config.cfg}
{$IFDEF iOS}
  {$modeswitch objectivec1}
{$ENDIF}

{$IFNDEF FPC}
  {$UNDEF USE_LIBJPEG}
{$ENDIF}

{$IFDEF ANDROID}
  {$DEFINE USE_LIBJPEG}
{$ENDIF}

{$IFNDEF USE_LIBJPEG}
  {$IFDEF WINDOWS}
    {$DEFINE USE_OLEPICTURE}
  {$ENDIF}
  {$IFDEF iOS}
    {$DEFINE USE_UIIMAGE}
  {$ENDIF}
{$ENDIF}

interface
uses
  {$IFDEF WINDOWS}
  Windows,
  zgl_lib_msvcrt,
  {$ENDIF}
  {$IFDEF USE_UIIMAGE}
  iPhoneAll,
  CGContext,
  CGGeometry,
  CGImage,
  CGBitmapContext,
  CGColorSpace,
  {$ENDIF}
  zgl_types,
  zgl_memory;

const
  JPG_EXTENSION : UTF8String = 'JPG';
  JPEG_EXTENSION: UTF8String = 'JPEG';

{$IFDEF USE_LIBJPEG}
  {$IFNDEF ANDROID}
    {$L jpeg_helper}
    {$L jaricom}
    {$L jcomapi}
    {$L jdapimin}
    {$L jdapistd}
    {$L jdarith}
    {$L jdatasrc}
    {$L jdcoefct}
    {$L jdcolor}
    {$L jddctmgr}
    {$L jdhuff}
    {$L jdinput}
    {$L jdmainct}
    {$L jdmarker}
    {$L jdmaster}
    {$L jdmerge}
    {$L jdpostct}
    {$L jdsample}
    {$L jerror}
    {$L jidctflt}
    {$L jidctfst}
    {$L jidctint}
    {$L jmemmgr}
    {$L jmemnobs}
    {$L jquant1}
    {$L jquant2}
    {$L jutils}
  {$ENDIF}
  {$IFDEF MACOSX}
    {$LINKLIB libgcc.a}
  {$ENDIF}
{$ENDIF}

procedure jpg_LoadFromFile(const FileName: UTF8String; out Data: PByteArray; out W, H, Format: Word);
procedure jpg_LoadFromMemory(const Memory: zglTMemory; out Data: PByteArray; out W, H, Format: Word);

implementation
uses
  zgl_window,
  zgl_textures;

{$IFDEF USE_LIBJPEG}
type
  zglTJPGData = record
    Memory : Pointer;
    MemSize: LongWord;
    Width  : Word;
    Height : Word;
    GetMem : function(Size: Integer): PByte; cdecl;
  end;

  procedure jpgturbo_Load(var jpgData: zglTJPGData; out Data: Pointer); cdecl; external {$IFDEF ANDROID} 'zenjpeg' {$ENDIF};
{$ENDIF}

{$IFDEF USE_OLEPICTURE}
type
  OLE_HANDLE = LongWord;
  OLE_XPOS_HIMETRIC  = Longint;
  OLE_YPOS_HIMETRIC  = Longint;
  OLE_XSIZE_HIMETRIC = Longint;
  OLE_YSIZE_HIMETRIC = Longint;

  PCLSID = PGUID;
  TCLSID = TGUID;

  POleStr  = PWideChar;
  Largeint = Int64;

  PStatStg = ^TStatStg;
  tagSTATSTG = record
    pwcsName: POleStr;
    dwType: Longint;
    cbSize: Largeint;
    mtime: TFileTime;
    ctime: TFileTime;
    atime: TFileTime;
    grfMode: Longint;
    grfLocksSupported: Longint;
    clsid: TCLSID;
    grfStateBits: Longint;
    reserved: Longint;
  end;
  TStatStg = tagSTATSTG;
  {$EXTERNALSYM STATSTG}
  STATSTG = TStatStg;

  ISequentialStream = interface(IUnknown)
    ['{0c733a30-2a1c-11ce-ade5-00aa0044773d}']
    function Read(pv: Pointer; cb: Longint; pcbRead: PLongint): HResult;
      stdcall;
    function Write(pv: Pointer; cb: Longint; pcbWritten: PLongint): HResult;
      stdcall;
  end;

  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function Seek(dlibMove: Largeint; dwOrigin: Longint;
      out libNewPosition: Largeint): HResult; stdcall;
    function SetSize(libNewSize: Largeint): HResult; stdcall;
    function CopyTo(stm: IStream; cb: Largeint; out cbRead: Largeint;
      out cbWritten: Largeint): HResult; stdcall;
    function Commit(grfCommitFlags: Longint): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; stdcall;
    function UnlockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; stdcall;
    function Stat(out statstg: TStatStg; grfStatFlag: Longint): HResult;
      stdcall;
    function Clone(out stm: IStream): HResult; stdcall;
  end;

  IPicture = interface
    ['{7BF80980-BF32-101A-8BBB-00AA00300CAB}']
    function get_Handle(out handle: OLE_HANDLE): HResult;  stdcall;
    function get_hPal(out handle: OLE_HANDLE): HResult; stdcall;
    function get_Type(out typ: Smallint): HResult; stdcall;
    function get_Width(out width: OLE_XSIZE_HIMETRIC): HResult; stdcall;
    function get_Height(out height: OLE_YSIZE_HIMETRIC): HResult; stdcall;
    function Render(dc: HDC; x, y, cx, cy: Longint;
      xSrc: OLE_XPOS_HIMETRIC; ySrc: OLE_YPOS_HIMETRIC;
      cxSrc: OLE_XSIZE_HIMETRIC; cySrc: OLE_YSIZE_HIMETRIC;
      rcWBounds: Pointer): HResult; stdcall;
    function set_hPal(hpal: OLE_HANDLE): HResult; stdcall;
    function get_CurDC(out dcOut: HDC): HResult; stdcall;
    function SelectPicture(dcIn: HDC; out hdcOut: HDC;
      out bmpOut: OLE_HANDLE): HResult; stdcall;
    function get_KeepOriginalFormat(out fkeep: BOOL): HResult; stdcall;
    function put_KeepOriginalFormat(fkeep: BOOL): HResult; stdcall;
    function PictureChanged: HResult; stdcall;
    function SaveAsFile(const stream: IStream; fSaveMemCopy: BOOL;
      out cbSize: Longint): HResult; stdcall;
    function get_Attributes(out dwAttr: Longint): HResult; stdcall;
  end;

  function OleLoadPicture(stream: IStream; lSize: Longint; fRunmode: BOOL;
    const iid: TGUID; var vObject): HResult; stdcall external 'olepro32.dll' name 'OleLoadPicture';

  function CreateStreamOnHGlobal(hglob: HGlobal; fDeleteOnRelease: BOOL;
    var stm: IStream): HResult; stdcall external 'ole32.dll' name 'CreateStreamOnHGlobal';

type
  zglPJPGData = ^zglTJPGData;
  zglTJPGData = record
    Buffer   : IPicture;
    Stream   : IStream;
    Width    : Word;
    Height   : Word;
  end;
{$ENDIF}

{$IFDEF USE_UIIMAGE}
type
  zglPJPGData = ^zglTJPGData;
  zglTJPGData = record
    Image  : UIImage;
    Color  : CGColorSpaceRef;
    Context: CGContextRef;
    Data   : NSData;
    Width  : Word;
    Height : Word;
  end;
{$ENDIF}

{$IFDEF USE_LIBJPEG}
function getmem_f(Size: Integer): PByte; cdecl;
begin
  GetMem(Pointer(Result), Size);
end;
{$ENDIF}

{$IFDEF USE_OLEPICTURE}
procedure jpg_FillData(var jpg: zglTJPGData; out Data: PByteArray);
  var
    bi    : BITMAPINFO;
    bmp   : HBITMAP;
    mainDC: HDC;
    DC    : HDC;
    p     : PByteArray;
    W, H  : Longint;
    i     : Integer;
begin
  mainDC := GetDC(0);
  DC := CreateCompatibleDC(mainDC);
  jpg.Buffer.get_Width (W);
  jpg.Buffer.get_Height(H);
  jpg.Width  := MulDiv(W, GetDeviceCaps(DC, LOGPIXELSX), 2540);
  jpg.Height := MulDiv(H, GetDeviceCaps(DC, LOGPIXELSY), 2540);

  FillChar(bi, SizeOf(bi), 0);
  bi.bmiHeader.biSize        := SizeOf(BITMAPINFOHEADER);
  bi.bmiHeader.biBitCount    := 32;
  bi.bmiHeader.biWidth       := jpg.Width;
  bi.bmiHeader.biHeight      := jpg.Height;
  bi.bmiHeader.biCompression := BI_RGB;
  bi.bmiHeader.biPlanes      := 1;
  bmp := CreateDIBSection(DC, bi, DIB_RGB_COLORS, Pointer(p), 0, 0);
  SelectObject(DC, bmp);
  jpg.Buffer.Render(DC, 0, 0, jpg.Width, jpg.Height, 0, H, W, -H, nil);

  GetMem(Data, jpg.Width * jpg.Height * 4);

  for i := 0 to jpg.Width * jpg.Height - 1 do
    begin
      Data[i * 4]     := p[i * 4 + 2];
      Data[i * 4 + 1] := p[i * 4 + 1];
      Data[i * 4 + 2] := p[i * 4];
      Data[i * 4 + 3] := 255;
    end;

  DeleteObject(bmp);
  ReleaseDC(0, mainDC);
  DeleteDC(DC);
end;
{$ENDIF}

procedure jpg_LoadFromFile(const FileName: UTF8String; out Data: PByteArray; out W, H, Format: Word);
  var
    jpgMem: zglTMemory;
begin
  mem_LoadFromFile(jpgMem, FileName);
  jpg_LoadFromMemory(jpgMem, Data, W, H, Format);
  mem_Free(jpgMem);
end;

procedure jpg_LoadFromMemory(const Memory: zglTMemory; out Data: PByteArray; out W, H, Format: Word);
  var
    jpg: zglTJPGData;
  {$IFDEF USE_OLEPICTURE}
    m: Pointer;
    g: HGLOBAL;
  {$ENDIF}
begin
{$IFDEF USE_LIBJPEG}
  jpg.Memory  := Memory.Memory;
  jpg.MemSize := Memory.Size;
  jpg.GetMem  := getmem_f;
  jpgturbo_Load(jpg, Data);
{$ENDIF}

{$IFDEF USE_OLEPICTURE}
  g := 0;
  try
    g := GlobalAlloc(GMEM_FIXED, Memory.Size - Memory.Position);
    m := GlobalLock(g);
    Move(PByteArray(Memory.Memory)[Memory.Position], PByte(m)^, Memory.Size - Memory.Position);
    GlobalUnlock(g);
    if CreateStreamOnHGlobal(HGLOBAL(m), FALSE, jpg.Stream) = S_OK Then
      if OleLoadPicture(jpg.Stream, 0, FALSE, IPicture, jpg.Buffer) = S_OK Then jpg_FillData(jpg, Data);
  finally
    if g <> 0 Then GlobalFree(g);
    jpg.Buffer := nil;
    jpg.Stream := nil;
  end;
{$ENDIF}

{$IFDEF USE_UIIMAGE}
  jpg.Data    := NSData.alloc().init();
  jpg.Data.initWithBytesNoCopy_length_freeWhenDone(Memory.Memory, Memory.Size, FALSE);
  jpg.Image   := UIImage.imageWithData(jpg.Data);
  jpg.Width   := Round(jpg.Image.size.width);
  jpg.Height  := Round(jpg.Image.size.height);
  jpg.Color   := CGImageGetColorSpace(jpg.Image.CGImage());
  GetMem(Data, jpg.Width * jpg.Height * 4);
  jpg.Context := CGBitmapContextCreate(Data, jpg.Width, jpg.Height, 8, jpg.Width * 4, jpg.Color, kCGImageAlphaPremultipliedLast);
  CGContextTranslateCTM(jpg.Context, 0, jpg.Height);
  CGContextScaleCTM(jpg.Context, 1, -1);
  CGContextDrawImage(jpg.Context, CGRectMake(0, 0, jpg.Width, jpg.Height), jpg.Image.CGImage());
  CGContextRelease(jpg.Context);
{$ENDIF}

  W      := jpg.Width;
  H      := jpg.Height;
  Format := TEX_FORMAT_RGBA;
end;

{$IFDEF USE_JPG}
initialization
  // jpg
  zgl_Reg(TEXTURE_FORMAT_EXTENSION,   @JPG_EXTENSION[1]);
  zgl_Reg(TEXTURE_FORMAT_FILE_LOADER, @jpg_LoadFromFile);
  zgl_Reg(TEXTURE_FORMAT_MEM_LOADER,  @jpg_LoadFromMemory);
  // jpeg
  zgl_Reg(TEXTURE_FORMAT_EXTENSION,   @JPEG_EXTENSION[1]);
  zgl_Reg(TEXTURE_FORMAT_FILE_LOADER, @jpg_LoadFromFile);
  zgl_Reg(TEXTURE_FORMAT_MEM_LOADER,  @jpg_LoadFromMemory);
{$ENDIF}

end.
