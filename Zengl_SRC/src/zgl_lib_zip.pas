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

********************************************************************************
|                          Zlib                                                |
|                                                                              |
| Copyright (C) 1995-2010 Jean-loup Gailly and Mark Adler                      |
|                                                                              |
| This software is provided 'as-is', without any express or implied            |
| warranty.  In no event will the authors be held liable for any damages       |
| arising from the use of this software.                                       |
|                                                                              |
| Permission is granted to anyone to use this software for any purpose,        |
| including commercial applications, and to alter it and redistribute it       |
| freely, subject to the following restrictions:                               |
|                                                                              |
| 1. The origin of this software must not be misrepresented; you must not      |
|    claim that you wrote the original software. If you use this software      |
|    in a product, an acknowledgment in the product documentation would be     |
|    appreciated but is not required.                                          |
| 2. Altered source versions must be plainly marked as such, and must not be   |
|    misrepresented as being the original software.                            |
| 3. This notice may not be removed or altered from any source distribution.   |
|                                                                              |
| Jean-loup Gailly        Mark Adler                                           |
| jloup@gzip.org          madler@alumni.caltech.edu                            |
|                                                                              |
|                                                                              |
| The data format used by the zlib library is described by RFCs (Request for   |
| Comments) 1950 to 1952 in the files http://www.ietf.org/rfc/rfc1950.txt      |
| (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format).   |
********************************************************************************
// modification by Serg
}
unit zgl_lib_zip;
{$mode delphi}
{$I zgl_config.cfg}

// Данный файл требует дальнейшей модификации и исправлений всех ошибок.
{$IfNDef MAC_COCOA}
{$IFDEF USE_ZIP}
  {$IfNDef NOT_OLD_ARM}
  {$L libzip}
  {$EndIf}
{$EndIf}

{$ENDIF}

  {$IfDef WINDOWS}
  {$IFDEF USE_ZLIB_FULL}
    {$L deflate}
    {$L infback}
    {$L inffast}
    {$L inflate}
    {$L inftrees}
    {$L zutil}
    {$L trees}
    {$L compress}
    {$L adler32}
    {$L crc32}
  {$ELSE}
    {$L infback}
    {$L inffast}
    {$L inflate}
    {$L inftrees}
    {$L zutil}
    {$L adler32}
    {$L crc32}
  {$ENDIF}
  {$EndIf}
  {$IF DEFINED(LINUX) and ( not DEFINED(ANDROID) )}
    {$LINKLIB libz.so.1}
  {$IFEND}
  {$IFDEF ANDROID}
    {$LINKLIB libz.so}
  {$ENDIF}
  {$IFDEF DARWIN}
    {/$LINKLIB libz.dylib}
  {$ENDIF}

interface
uses
  {$IFDEF WINDOWS}
  zgl_lib_msvcrt,
  {$ENDIF}
//  zgl_memory,            CPUARMV7A
//  zgl_utils,
  zgl_types;

// Rus: для процессоров ARMv5 и ARMv6 отключите DEFINE CPUARMV7A в zgl_config.cfg.
//      Это работает только для новых архитектур ARM и для всех архитектур X86.
// Eng: for ARMv5 and ARMv6 processors, disable DEFINE CPUARMV7A in zgl_config.cfg.
//      This only works for newer ARM architectures and for all X86 architectures.
{$IfDef NOT_OLD_ARM}
const
  libz = 'libz.so';
  libzip = 'libzip.so';
{$EndIf}

{$IFDEF USE_ZIP}
const
  ZIP_FL_NOCASE     = 1;  // ignore case on name lookup
  ZIP_FL_NODIR      = 2;  // ignore directory component
  ZIP_FL_COMPRESSED = 4;  // read compressed data
  ZIP_FL_UNCHANGED  = 8;  // use original data, ignoring changes
  ZIP_FL_RECOMPRESS = 16; // force recompression of data
  ZIP_FL_ENCRYPTED  = 32; // read encrypted data

type
  Pzip      = ^Tzip;
  Pzip_stat = ^Tzip_stat;
  Pzip_file = ^Tzip_file;

  Tzgl_error = record
  end;

  Tzip_stat = record
    valid             : cuint64;   // which fields have valid values
    name              : PAnsiChar; // name of the file
    index             : cuint64;   // index within archive
    size              : cuint64;   // size of file (uncompressed)
    comp_size         : cuint64;   // size of file (compressed)
    mtime             : cint;      // time_t // modification time
    crc               : cuint32;   // crc of file data */
    comp_method       : cuint16;   // compression method used
    encryption_method : cuint16;   // encryption method used
    flags             : cuint32;   // reserved for future use
  end;

  Tzip = record
    zn               : PAnsiChar;  // file name
    zp               : Pointer;    // file
    error            : Tzgl_error; // error information
    flags            : cuint;      // archive global flags
    ch_flags         : cuint;      // changed archive global flags
    default_password : PAnsiChar;  // password used when no other supplied
    cdir             : Pointer;    // zip_cdir; // central directory
    ch_comment       : PAnsiChar;  // changed archive comment
    ch_comment_len   : cint;       // length of changed zip archive * comment, -1 if unchanged
    nentry           : cuint64;    // number of entries
    nentry_alloc     : cuint64;    // number of entries allocated
    entry            : Pointer;    // zip_entry // entries
    nfile            : cint;       // number of opened files within archive
    nfile_alloc      : cint;       // number of files allocated
    file_            : array of Pzip_file; // opened files within archive
  end;

  Tzip_file = record
    za    : Pzip;       // zip archive containing this file
    error : Tzgl_error; // error information
    eof   : cint;
    src   : Pointer;    // zip_source; // data source
  end;

type
  zglPZipFile = ^zglZipFile;
  zglZipFile  = record
    file_ : Pzip_file;
    name  : PAnsiChar;
  end;
{$EndIf}

type
  TAlloc = function( AppData : Pointer; Items, Size : cuint ): Pointer; cdecl;
  TFree = procedure( AppData, Block : Pointer ); cdecl;

  z_stream_s = record
    next_in   : PByte;     // next input byte
    avail_in  : cuint;     // number of bytes available at next_in
    total_in  : culong;    // total nb of input bytes read so far

    next_out  : PByte;     // next output byte should be put here
    avail_out : cuint;     // remaining free space at next_out
    total_out : culong;    // total nb of bytes output so far

    msg       : PAnsiChar; // last error message, NULL if no error
    state     : Pointer;   // not visible by applications

    zalloc    : TAlloc;    // used to allocate the internal state
    zfree     : TFree;     // used to free the internal state
    opaque    : Pointer;   // private data object passed to zalloc and zfree

    data_type : cint;      // best guess about the data type: ascii or binary
    adler     : culong;    // adler32 value of the uncompressed data
    reserved  : culong;    // reserved for future use
  end;

{$IFDEF USE_ZIP}
{$If defined(MAC_COCOA) or (defined(ANDROID) and defined(NOT_OLD_ARM))}
var
  zip_open: function(path: PAnsiChar; flags: Integer; out error: cint): Pzip; cdecl;
  zip_close: function( archive : Pzip ): cint; cdecl;
  zip_set_default_password: function( archive : Pzip; password : PAnsiChar ) : cint; cdecl;
  zip_stat: function( archive : Pzip; fname : PAnsiChar; flags : cint; out sb : Tzip_stat ) : Integer; cdecl;

  zip_fopen: function( archive : Pzip; fname : PAnsiChar; flags : cint ) : Pzip_file; cdecl;
  zip_fread: function( file_ : Pzip_file; out buf; nbytes : cuint64 ) : cint; cdecl;
  zip_fclose: function( file_ : Pzip_file ) : cint; cdecl;

  zip_get_num_entries: function( archive : Pzip; flags : cint ) : cuint64; cdecl;
  zip_get_name: function( archive : Pzip; index : cuint64; flags : cint ) : PAnsiChar; cdecl;

  inflateInit_: function(var strm: z_stream_s; version: PChar; stream_size: cint): cint; cdecl;
  inflateEnd: function(var strm: z_stream_s): cint; cdecl;
  inflate: function(var strm: z_stream_s; flush: cint): cint; cdecl;

  // hack for compression functions which will be never used, but which are needed on linking stage
  deflate: function: Integer; cdecl;
  deflateEnd: function: Integer; cdecl;
  deflateInit2_: function: Integer; cdecl;
  zlibVersion: function: Char; cdecl;
{$Else}
function zip_open( path : PAnsiChar; flags : Integer; out errorp : cint ) : Pzip; cdecl; external;
function zip_close( archive : Pzip ) : cint; cdecl; external;
function zip_set_default_password( archive : Pzip; password : PAnsiChar ) : cint; cdecl; external;
function zip_stat( archive : Pzip; fname : PAnsiChar; flags : cint; out sb : Tzip_stat ) : Integer; cdecl; external;

function zip_fopen( archive : Pzip; fname : PAnsiChar; flags : cint ) : Pzip_file; cdecl; external;
function zip_fread( file_ : Pzip_file; out buf; nbytes : cuint64 ) : cint; cdecl; external;
function zip_fclose( file_ : Pzip_file ) : cint; cdecl; external;

function zip_get_num_entries( archive : Pzip; flags : cint ) : cuint64; cdecl; external;
function zip_get_name( archive : Pzip; index : cuint64; flags : cint ) : PAnsiChar; cdecl; external;

// hack for compression functions which will be never used, but which are needed on linking stage
{$IFDEF FPC}
function deflate_fake : Integer; cdecl; public name '_deflate'; public name 'deflate';
function deflateEnd_fake : Integer; cdecl; public name '_deflateEnd'; public name 'deflateEnd';
function deflateInit2_fake : Integer; cdecl; public name '_deflateInit2_'; public name 'deflateInit2_';
{$ELSE}
function deflate : Integer; cdecl;
function deflateEnd : Integer; cdecl;
function deflateInit2_ : Integer; cdecl;
{$ENDIF}
{$IfEnd}
{$ENDIF}

procedure zlib_Init(out strm: z_stream_s ); cdecl;
procedure zlib_Free(var strm: z_stream_s ); cdecl;
function png_DecodeIDAT( var pngMem: zglTMemory; var pngZStream: z_stream_s; out pngIDATEnd: LongWord; Buffer: Pointer;
     Bytes: Integer): Integer; cdecl;
{/$IfDef CEGCC}
function udimodsi4(num, den: LongWord; modwanted: Integer): LongWord; cdecl;
function __umodsi3(a, b: clong): clong; cdecl;
{/$EndIf}

{$If Not (defined (ANDROID) and defined(NOT_OLD_ARM))}
function inflateInit_(var strm: z_stream_s; version: pchar; stream_size: cint): cint; cdecl; external
  {$ifdef DYNAMICZLIB}libz name 'inflateInit_'{$endif};
function inflateEnd(var strm: z_stream_s): cint; cdecl; external
  {$ifdef DYNAMICZLIB}libz name 'inflateEnd'{$endif};
function inflate(var strm: z_stream_s; flush: cint): cint; cdecl; external
  {$ifdef DYNAMICZLIB}libz name 'inflate'{$endif};
{$IfEnd}

{$IFDEF USE_ZIP}
threadvar
  zipCurrent : Pzip;

{$If defined(MAC_COCOA) or (defined(ANDROID) and defined(NOT_OLD_ARM))}
procedure LoadLibZip(const zDLL, zlDLL: String);
procedure UnloadLibZip;
{$IfEnd}
{$EndIf}

implementation

{$If defined(MAC_COCOA) or (defined(ANDROID) and defined(NOT_OLD_ARM))}
uses
  zgl_log,
  zgl_utils,
  zgl_application;

var
  zipDLL: Pointer;
{$IfEnd}

{$IFDEF USE_ZIP}
{$IFDEF FPC}
function deflate_fake : Integer;
begin
  Result := 0;
end;

function deflateEnd_fake : Integer;
begin
  Result := 0;
end;

function deflateInit2_fake : Integer;
begin
  Result := 0;
end;

{$If defined(MAC_COCOA) or (defined(ANDROID) and defined(NOT_OLD_ARM))}
procedure LoadLibZip(const zDLL, zlDLL: String);
begin
  UnloadLibZip;

  zipDLL := dlopen(PChar(zDLL), 1);
  if zipDLL = nil then
  begin
    log_Add('Could not load Zip');
    exit;
  end;
  @zip_open := dlsym(zipDLL, 'zip_open');
  if not Assigned(zip_open) then
  begin
    log_Add('Could not load zip_open from ' + zDLL);
    Exit;
  end;
  @zip_close := dlsym(zipDLL, 'zip_close');
  @zip_set_default_password := dlsym(zipDLL, 'zip_set_default_password');
  @zip_stat := dlsym(zipDLL, 'zip_stat');

  @zip_fopen := dlsym(zipDLL, 'zip_fopen');
  @zip_fread := dlsym(zipDLL, 'zip_fread');
  @zip_fclose := dlsym(zipDLL, 'zip_fclose');

  @zip_get_num_entries := dlsym(zipDLL, 'zip_get_num_entries');
  @zip_get_name := dlsym(zipDLL, 'zip_get_name');

  zipDLL := dlopen(PChar(zlDLL), 1);
  if zipDLL = nil then
  begin
    log_Add('Could not load Zip');
    exit;
  end;

  // hack for compression functions which will be never used, but which are needed on linking stage
  @deflate := dlsym(zipDLL, 'deflate');
  @deflateEnd := dlsym(zipDLL, 'deflateEnd');
  @deflateInit2_ := dlsym(zipDLL, 'deflateInit2_');
  @inflateInit_ := dlsym(zipDLL, 'inflateInit_');
  @inflateEnd := dlsym(zipDLL, 'inflateEnd');
  @inflate := dlsym(zipDLL, 'inflate');
  @zlibVersion := dlsym(zipDLL, 'zlibVersion');
end;

procedure UnloadLibZip;
begin
  if zipDLL <> nil then
    dlclose(zipDLL);

  @zip_open := nil;
  @zip_close := nil;
  @zip_set_default_password := nil;
  @zip_stat := nil;

  @zip_fopen := nil;
  @zip_fread := nil;
  @zip_fclose := nil;

  @zip_get_num_entries := nil;
  @zip_get_name := nil;

  // hack for compression functions which will be never used, but which are needed on linking stage
  @deflate := nil;
  @deflateEnd := nil;
  @deflateInit2_ := nil;
  @inflateInit_ := nil;
  @inflateEnd := nil;
  @inflate := nil;
  @zlibVersion := nil;
end;
{$IfEnd}
{$ELSE}
function deflate : Integer;
begin
  Result := 0;
end;

function deflateEnd : Integer;
begin
  Result := 0;
end;

function deflateInit2_ : Integer;
begin
  Result := 0;
end;
{$ENDIF}
{$ENDIF}

procedure zlib_Init( out strm : z_stream_s );
begin
  FillChar(strm, sizeof(strm), 0);
  inflateInit_(strm, {$IfDef MAC_COCOA}'1.2.11'{$Else}'1.2.5'{$EndIf}, sizeof(strm));      // version??? macos 1.2.11
end;

procedure zlib_Free( var strm : z_stream_s );
begin
  inflateEnd(strm);
end;

function png_DecodeIDAT(var pngMem: zglTMemory; var pngZStream: z_stream_s; out pngIDATEnd: LongWord; Buffer: Pointer;
     Bytes: Integer): Integer;
var
  b: {$IfDef USE_INLINE}PByte{$Else}array[0..3] of Byte{$EndIf};
  IDATHeader: PChar;
begin
  pngZStream.next_out := Buffer;
  pngZStream.avail_out := Bytes;
  while pngZStream.avail_out > 0 do
  begin
    if ((pngMem.Position = pngIDATEnd) and (pngZStream.avail_out > 0) and (pngZStream.avail_in = 0)) then
    begin
      inc(pngMem.Position, 4);
      {$IfDef USE_INLINE}
      b := PByte(Ptr(pngMem.Memory) + pngMem.Position);
      pngIDATEnd := b[3] + (b[2] shl 8) + (b[1] shl 16) + (b[0] shl 24);
      inc(pngMem.Position, 4);
      {$Else}
      mem_Read(pngMem, b, 4);
      pngIDATEnd := b[3] + (b[2] shl 8) + (b[1] shl 16) + (b[0] shl 24);
      {$EndIf}

      IDATHeader := PChar(Ptr(pngMem.Memory) + pngMem.Position);
      if ((IDATHeader[0] <> 'I') and (IDATHeader[1] <> 'D') and (IDATHeader[2] <> 'A') and (IDATHeader[3] <> 'T')) then
      begin
        Result := - 1;
        Exit;
      end;
      inc(pngMem.Position, 4);
      inc(pngIDATEnd, pngMem.Position);
    end;
    if (pngZStream.avail_in = 0) then
    begin
      if (pngMem.Size - pngMem.Position > 0) then
      begin
        if (pngMem.Position + 65535 > pngIDATEnd) then
        begin
          if (pngMem.Position + (pngIDATEnd - pngMem.Position) > pngMem.Size) then
            pngZStream.avail_in := pngMem.Size - pngMem.Position
          else
            pngZStream.avail_in := pngIDATEnd - pngMem.Position;
        end
        else begin
          if (pngMem.Position + 65535 > pngMem.Size) then
            pngZStream.avail_in := pngMem.Size - pngMem.Position
          else
            pngZStream.avail_in := 65535;
        end;
        inc(pngMem.Position, pngZStream.avail_in);
      end
      else
        pngZStream.avail_in := 0;
      if (pngZStream.avail_in = 0) then
      begin
        Result := Bytes - pngZStream.avail_out;
        exit;
      end;
      pngZStream.next_in := PByte(Ptr(Ptr(pngMem.Memory) + pngMem.Position - pngZStream.avail_in));
    end;
    Result := inflate(pngZStream, 0);
    if Result < 0 then
      Result := -1
    else
      Result := pngZStream.avail_in;
  end;
end;

{/$IfDef CEGCC}
function udimodsi4(num, den: LongWord; modwanted: Integer): LongWord;
var
  bit: LongWord;
  res: LongWord;
begin
  bit := 1;
  res := 0;
  while (den < (num and bit and not(den and $80000000))) do
  begin
    den := den shl 1;
    bit := bit shl 1
  end;
  while bit > 0 do
  begin
    if num >= den then
    begin
      num := num - den;
      res := res or bit;
    end;
    bit := bit shr 1;
    den := den shr 1;
  end;
  if modwanted > 0 then
    Result := num
  else
    Result := res;
end;

function __umodsi3(a, b: clong): clong;
begin
  Result := udimodsi4(a, b, 1);
end;
{.$EndIf}

{$IfDef USE_ZIP}{$IfDef MAC_COCOA}
initialization
  {$IfDef NO_USE_STATIC_LIBRARY}
  LoadLibZip('libzip.dylib', 'libz.dylib');
  {$Else}
  LoadLibZip('/usr/local/lib/libzip.dylib', '/usr/local/Cellar/zlib/1.2.11/lib/libz.dylib');
  {$EndIf}

finalization

  UnloadLibZip;
{$EndIf}{$EndIf}
{$IfDef ANDROID}{$IfDef NOT_OLD_ARM}
initialization
  LoadLibZip(libzip, libz);

finalization
  UnloadLibZip;
{$EndIf}{$EndIf}

end.
