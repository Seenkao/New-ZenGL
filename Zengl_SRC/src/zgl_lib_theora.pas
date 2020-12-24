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
unit zgl_lib_theora;

{$I zgl_config.cfg}

{$IFDEF USE_THEORA_STATIC}
  {$LINKLIB libtheoradec.a}
{$ENDIF}

interface
uses
  {$IFDEF WINDOWS}
  zgl_lib_msvcrt,
  {$ENDIF}
  zgl_lib_ogg,
  zgl_types
  {$IFNDEF USE_THEORA_STATIC}
  , zgl_utils
  {$ENDIF}
  ;

{$IFNDEF USE_THEORA_STATIC}
const
{$IFDEF LINUX}
  libtheoradec  = 'libtheoradec.so.1';
{$ENDIF}
{$IFDEF ANDROID}
  libtheoradec  = 'libtheoradec.so';
{$ENDIF}
{$IFDEF WINDOWS}
  libtheoradec  = 'libtheoradec-1.dll';
{$ENDIF}
{$IFDEF MACOSX}
  libtheoradec  = 'libtheoradec.1.dylib';
{$ENDIF}
{$ENDIF}

type
  ppcchar = ^pcchar;

  th_colorspace = (TH_CS_UNSPECIFIED, TH_CS_ITU_REC_470M, TH_CS_ITU_REC_470BG, TH_CS_NSPACES);
  th_pixel_fmt  = (TH_PF_420, TH_PF_RSVD, TH_PF_422, TH_PF_444, TH_PF_NFORMATS);

  th_img_plane = record
    width: cint;
    height: cint;
    stride: cint;
    data : pcuchar;
  end;

  pth_ycbcr_buffer = ^th_ycbcr_buffer;
  th_ycbcr_buffer  = array[0..2] of th_img_plane;

  pth_info = ^th_info;
  th_info  = record
    version_major        : cuchar;
    version_minor        : cuchar;
    version_subminor     : cuchar;

    frame_width          : ogg_uint32_t;
    frame_height         : ogg_uint32_t;
    pic_width            : ogg_uint32_t;
    pic_height           : ogg_uint32_t;
    pic_x                : ogg_uint32_t;
    pic_y                : ogg_uint32_t;
    fps_numerator        : ogg_uint32_t;
    fps_denominator      : ogg_uint32_t;
    aspect_numerator     : ogg_uint32_t;
    aspect_denominator   : ogg_uint32_t;

    colorspace           : th_colorspace;
    pixel_fmt            : th_pixel_fmt;
    target_bitrate       : cint;
    quality              : cint;
    keyframe_granule_shift: cint;
  end;

  pth_comment = ^th_comment;
  th_comment  = record
    user_comments : ppcchar;
    comment_lengths: pcint;
    comments      : cint;
    vendor        : pcchar;
  end;

  ppth_setup_info = ^pth_setup_info;
  pth_setup_info  = ^th_setup_info;
  th_setup_info   = record
  end;

  pth_dec_ctx = ^th_dec_ctx;
  th_dec_ctx  = record
  end;

const
  TH_DECCTL_SET_GRANPOS = 5;

{$IFDEF USE_THEORA_STATIC}
  procedure th_info_init(_info: pth_info); cdecl; external;
  procedure th_info_clear(_info: pth_info); cdecl; external;
  procedure th_comment_init(_tc: pth_comment); cdecl; external;
  procedure th_comment_clear(_tc: pth_comment); cdecl; external;
  procedure th_setup_free(_setup: pth_setup_info); cdecl; external;
  function th_granule_frame(_encdec: Pointer; _granpos: ogg_int64_t): ogg_int64_t; cdecl; external;
  function th_granule_time(_encdec: Pointer; _granpos: ogg_int64_t): cdouble; cdecl; external;
  function th_decode_headerin(_info: pth_info; _tc: pth_comment; _setup: ppth_setup_info; _op: pogg_packet): cint; cdecl; external;
  function th_decode_alloc(const _info: pth_info; const _setup: pth_setup_info): pth_dec_ctx; cdecl; external;
  function th_decode_ctl(_dec: pth_dec_ctx; _req: cint; _buf: Pointer; _buf_sz: csize_t): cint; cdecl; external;
  procedure th_decode_free(_dec: pth_dec_ctx); cdecl; external;
  function th_decode_packetin(_dec: pth_dec_ctx; const _op: pogg_packet; _granpos: pogg_int64_t): cint; cdecl; external;
  function th_decode_ycbcr_out(_dec: pth_dec_ctx; _ycbcr: pth_ycbcr_buffer): cint; cdecl; external;
{$ELSE}
  var
    th_info_init      : procedure(_info: pth_info); cdecl;
    th_info_clear     : procedure(_info: pth_info); cdecl;
    th_comment_init   : procedure(_tc: pth_comment); cdecl;
    th_comment_clear  : procedure(_tc: pth_comment); cdecl;
    th_setup_free     : procedure(_setup: pth_setup_info); cdecl;
    th_granule_frame  : function(_encdec: Pointer; _granpos: ogg_int64_t): ogg_int64_t; cdecl;
    th_granule_time   : function(_encdec: Pointer; _granpos: ogg_int64_t): cdouble; cdecl;
    th_decode_headerin: function(_info: pth_info; _tc: pth_comment; _setup: ppth_setup_info; _op: pogg_packet): cint; cdecl;
    th_decode_alloc   : function(const _info: pth_info; const _setup: pth_setup_info): pth_dec_ctx; cdecl;
    th_decode_ctl     : function(_dec: pth_dec_ctx; _req: cint; _buf: Pointer; _buf_sz: csize_t): cint; cdecl;
    th_decode_free    : procedure(_dec: pth_dec_ctx); cdecl;
    th_decode_packetin: function(_dec: pth_dec_ctx; const _op: pogg_packet; _granpos: pogg_int64_t): cint; cdecl;
    th_decode_ycbcr_out: function(_dec: pth_dec_ctx; _ycbcr: pth_ycbcr_buffer): cint; cdecl;
{$ENDIF}

function  InitTheora: Boolean;
procedure FreeTheora;

var
  theoraInit: Boolean;

implementation
{$IFDEF MACOSX}
{$IFNDEF USE_THEORA_STATIC}
uses
  zgl_application;
{$ENDIF}
{$ENDIF}

{$IFNDEF USE_THEORA_STATIC}
var
  theoraLibrary: {$IFDEF UNIX} Pointer {$ENDIF} {$IFDEF WINDOWS} HMODULE {$ENDIF};
{$ENDIF}

function InitTheora: Boolean;
begin
  if theoraInit Then
  begin
    Result := TRUE;
    exit;
  end;

  if not InitOgg() Then
  begin
    theoraInit := FALSE;
    Result     := FALSE;
    exit;
  end;

{$IFDEF USE_THEORA_STATIC}
  Result := TRUE;
{$ELSE}
  {$IFDEF UNIX}{$IfNDef MACOSX}
  theoraLibrary := dlopen(libtheoradec, $001);
  {$ENDIF}{$EndIf}
  {$IFDEF WINDOWS}
  theoraLibrary := dlopen(libtheoradec);
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  {$IfDef NO_USE_STATIC_LIBRARY}
  theoraLibrary := dlopen(PAnsiChar(libtheoradec), $001);
  {$Else}
  theoraLibrary := dlopen(PAnsiChar('/usr/local/lib/' + libtheoradec), $001);
  {$EndIf}
  {$Else}
  theoraLibrary := dlopen(PAnsiChar(appWorkDir + 'Contents/Frameworks/' + libtheoradec), $001);
  {$ENDIF}{$EndIf}

  if theoraLibrary <> LIB_ERROR Then
  begin
    th_info_init        := dlsym(theoraLibrary, 'th_info_init');
    th_info_clear       := dlsym(theoraLibrary, 'th_info_clear');
    th_comment_init     := dlsym(theoraLibrary, 'th_comment_init');
    th_comment_clear    := dlsym(theoraLibrary, 'th_comment_clear');
    th_setup_free       := dlsym(theoraLibrary, 'th_setup_free');
    th_granule_frame    := dlsym(theoraLibrary, 'th_granule_frame');
    th_granule_time     := dlsym(theoraLibrary, 'th_granule_time');
    th_decode_headerin  := dlsym(theoraLibrary, 'th_decode_headerin');
    th_decode_alloc     := dlsym(theoraLibrary, 'th_decode_alloc');
    th_decode_ctl       := dlsym(theoraLibrary, 'th_decode_ctl');
    th_decode_free      := dlsym(theoraLibrary, 'th_decode_free');
    th_decode_packetin  := dlsym(theoraLibrary, 'th_decode_packetin');
    th_decode_ycbcr_out := dlsym(theoraLibrary, 'th_decode_ycbcr_out');
    Result              := TRUE;
  end else
    Result := FALSE;
{$ENDIF}

  theoraInit := Result;
end;

procedure FreeTheora;
begin
{$IFNDEF USE_THEORA_STATIC}
  if not theoraInit Then exit;

  dlclose(theoraLibrary);
  theoraInit := FALSE;
{$ENDIF}
end;

end.
