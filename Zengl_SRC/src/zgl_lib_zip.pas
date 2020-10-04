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
unit zgl_lib_zip;

{$I zgl_config.cfg}

{$IFDEF USE_ZIP}
  {$L libzip}
{$ENDIF}

{$L zlib_helper}
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
    {$LINKLIB libz.dylib}
  {$ENDIF}

interface
uses
  {$IFDEF WINDOWS}
  zgl_lib_msvcrt,
  {$ENDIF}
  zgl_memory,
  zgl_types;

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
{$ENDIF}

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

    data_type : Integer;   // best guess about the data type: ascii or binary
    adler     : culong;    // adler32 value of the uncompressed data
    reserved  : culong;    // reserved for future use
  end;

procedure zlib_Init( out strm : z_stream_s ); cdecl; external;
procedure zlib_Free( var strm : z_stream_s ); cdecl; external;
function png_DecodeIDAT( var pngMem : zglTMemory; var pngZStream : z_stream_s; out pngIDATEnd : LongWord; Buffer : Pointer; Bytes : Integer ) : Integer; cdecl; external;

{$IFDEF USE_ZIP}
threadvar
  zipCurrent : Pzip;
{$ENDIF}

implementation

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

end.
