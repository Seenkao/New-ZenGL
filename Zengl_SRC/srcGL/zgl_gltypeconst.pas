(*******************************************************************************
*  вынесено в отдельный файл, для удобства и возможности использовать везде
*  константы и типы не занимают в исполняемом файле места, потому можно создавать
*  миллионы констант
*  метки в файле стоят, потому поиск по константам можно проводить по меткам.
*
*  Для типов требуется "разбить" по определёнию для определённых платформ.
*  Какие-то определения могут не подходить по типам. Смотрите файлы кроноса.
*******************************************************************************)

(*
 *  Copyright (c) 2022-2023 Serge - SSW
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
 *)

// Copyright 2013-2020 The Khronos Group Inc.
// SPDX-License-Identifier: MIT
//
// This header is generated from the Khronos OpenGL / OpenGL ES XML
// API Registry. The current version of the Registry, generator scripts
// used to make the header, and the header can be found at
//   https://github.com/KhronosGroup/OpenGL-Registry

unit zgl_gltypeconst;
{$I zgl_config.cfg}
{$I GLdefine.cfg}

interface

  {$IfDef LINUX}
uses
  X;
  {$EndIf}
  {$IfDef WINDOWS}
uses
  Windows;
  {$EndIf}

  {$IFDEF LINUX}
const
  libGL  = 'libGL.so.1';
  libGLU = 'libGLU.so.1';
  {$ENDIF}
  {$IFDEF WINDOWS}
const
  libGL  = 'opengl32.dll';
  libGLU = 'glu32.dll';
  {$ENDIF}
  {$IFDEF MAC_COCOA}
const
  libGL  = '/System/Library/Frameworks/OpenGL.framework/Libraries/libGL.dylib';
  libGLU = '/System/Library/Frameworks/OpenGL.framework/Libraries/libGLU.dylib';
  {$EndIf}


Type
  P_cl_context  = ^_cl_context;
  _cl_context   = record end;
  P_cl_event    = ^_cl_event;
  _cl_event     = record end;

  PPGLchar      = ^PGLChar;
  PPGLcharARB   = ^PGLcharARB;

  PGLboolean    = ^GLboolean;
  PGLbyte       = ^GLbyte;
  PGLchar       = ^GLchar;
  PGLdouble     = ^GLdouble;
  PGLenum       = ^GLenum;
  PGLfloat      = ^GLfloat;
  PGLint        = ^GLint;
  PGLint64      = ^GLint64;
  PGLint64EXT   = ^GLint64EXT;
  PGLintptr     = ^GLintptr;
  PGLshort      = ^GLshort;
  PGLsizei      = ^GLsizei;
  PGLsizeiptr   = ^GLsizeiptr;
  PGLubyte      = ^GLubyte;
  PGLuint       = ^GLuint;
  PGLuint64     = ^GLuint64;
  PGLuint64EXT  = ^GLuint64EXT;
  PGLushort     = ^GLushort;

  PGLcharARB    = ^GLcharARB;
  PGLclampf     = ^GLclampf;
  PGLfixed      = ^GLfixed;
  PGLhalfNV     = ^GLhalfNV;
  PGLhandleARB  = ^GLhandleARB;
  PGLvdpauSurfaceNV  = ^GLvdpauSurfaceNV;

  GLvoid = pointer;
  GLenum = Cardinal;
  GLfloat = Single;     // khronos_float_t;
  GLint = longint;
  GLsizei = longint;
  GLbitfield = Cardinal;
  GLdouble = double;
  GLuint = Cardinal;
  GLboolean = byte;
  GLubyte = Byte;       // khronos_uint8_t;
  GLclampf = Single;    // khronos_float_t;
  GLclampd = double;
  {$IfDef CPU64}
  GLsizeiptr = Int64;      // khronos_ssize_t;
  GLintptr = Int64;        // khronos_intptr_t;
  GLuint64 = QWord;        // khronos_uint64_t;
  GLint64 = Int64;         // khronos_int64_t;
  GLuint64EXT = QWord;     // khronos_uint64_t;
  GLint64EXT = Int64;      // khronos_int64_t;
  GLsizeiptrARB = Int64;   // khronos_ssize_t;
  GLintptrARB = Int64;     // khronos_intptr_t;
  {$Else}
  GLsizeiptr = LongInt;    // khronos_ssize_t;
  GLintptr = LongInt;      // khronos_intptr_t;
  GLuint64 = Cardinal;     // khronos_uint64_t;
  GLint64 = LongInt;       // khronos_int64_t;
  GLuint64EXT = Cardinal;  // khronos_uint64_t;
  GLint64EXT = LongInt;
  GLsizeiptrARB = LongInt; // khronos_ssize_t;
  GLintptrARB = LongInt;   // khronos_intptr_t;
  {$EndIf}
  GLchar = char;
  GLshort = SmallInt;   // khronos_int16_t;
  GLbyte = Byte;        // khronos_int8_t;
  GLushort = Word;      // khronos_uint16_t;
  GLhalf = Word;        //  khronos_uint16_t;
  GLsync = Pointer;     // ^__GLsync;

  GLeglImageOES = pointer;

  GLhalfARB = Word;     // khronos_uint16_t;
  GLfixed = LongInt;    // khronos_int32_t;
  GLeglClientBufferEXT = pointer;

  PPGLvoid = ^PGLvoid;
  PGLvoid = Pointer;

  {$ifdef __APPLE__}
  GLhandleARB = pointer;
  {$else}
  GLhandleARB = Cardinal;
  {$EndIf}
  GLcharARB = char;

  GLhalfNV = word;
  GLvdpauSurfaceNV = GLintptr;

{$IfDef WINDOWS}
(*******************************************************************************
*                                   begin WGL                                  *
*******************************************************************************)
type
  // WGL_NV_present_video
  PHVIDEOOUTPUTDEVICENV = ^HVIDEOOUTPUTDEVICENV;
  HVIDEOOUTPUTDEVICENV = THandle;

  // WGL_NV_video_output
  PHPVIDEODEV = ^HPVIDEODEV;
  HPVIDEODEV = THandle;

  // WGL_NV_gpu_affinity
  PHPGPUNV = ^HPGPUNV;
  HPGPUNV = THandle;
  PHGPUNV = ^HGPUNV;
  HGPUNV = THandle;

  // WGL_NV_video_capture
  PHVIDEOINPUTDEVICENV = ^HVIDEOINPUTDEVICENV;
  HVIDEOINPUTDEVICENV = THandle;

  {$IFDEF FPC}
    PWGLSwap = ^TWGLSwap;
    {$EXTERNALSYM _WGLSWAP}
      _WGLSWAP = packed record
        hdc: HDC;
        uiFlags: UINT;
      end;

    TWGLSwap = _WGLSWAP;
    {$EXTERNALSYM WGLSWAP}
    WGLSWAP = _WGLSWAP;
  {$ENDIF}

  PGPU_DEVICE = ^GPU_DEVICE;
  GPU_DEVICE = record
    cb: DWORD;
    DeviceName: array [0..31] of AnsiChar;
    DeviceString: array [0..127] of AnsiChar;
    Flags: DWORD;
    rcVirtualScreen: TRect;
  end;

const
  {WGL_ARB_buffer_region}
  WGL_FRONT_COLOR_BUFFER_BIT_ARB = $00000001;
  WGL_BACK_COLOR_BUFFER_BIT_ARB = $00000002;
  WGL_DEPTH_BUFFER_BIT_ARB = $00000004;
  WGL_STENCIL_BUFFER_BIT_ARB = $00000008;

  // WGL_3DFX_multisample
  WGL_SAMPLE_BUFFERS_3DFX = $2060;
  WGL_SAMPLES_3DFX = $2061;

  // WGL_3DL_stereo_control
  WGL_STEREO_EMITTER_ENABLE_3DL = $2055;
  WGL_STEREO_EMITTER_DISABLE_3DL = $2056;
  WGL_STEREO_POLARITY_NORMAL_3DL = $2057;
  WGL_STEREO_POLARITY_INVERT_3DL = $2058;

  // WGL_ARB_context_flush_control
  WGL_CONTEXT_RELEASE_BEHAVIOR_ARB = $2097;
  WGL_CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;
  WGL_CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = $2098;

  // WGL_ARB_make_current_read
  ERROR_INVALID_PIXEL_TYPE_ARB = $2043;
  ERROR_INCOMPATIBLE_DEVICE_CONTEXTS_ARB = $2054;

  // WGL_ARB_multisample
  WGL_SAMPLE_BUFFERS_ARB = $2041;
  WGL_SAMPLES_ARB = $2042;

  // WGL_ARB_pbuffer
  WGL_DRAW_TO_PBUFFER_ARB = $202D;
  WGL_MAX_PBUFFER_PIXELS_ARB = $202E;
  WGL_MAX_PBUFFER_WIDTH_ARB = $202F;
  WGL_MAX_PBUFFER_HEIGHT_ARB = $2030;
  WGL_PBUFFER_LARGEST_ARB = $2033;
  WGL_PBUFFER_WIDTH_ARB = $2034;
  WGL_PBUFFER_HEIGHT_ARB = $2035;
  WGL_PBUFFER_LOST_ARB = $2036;

  // WGL_ARB_pixel_format
  WGL_NUMBER_PIXEL_FORMATS_ARB = $2000;
  WGL_DRAW_TO_WINDOW_ARB = $2001;
  WGL_DRAW_TO_BITMAP_ARB = $2002;
  WGL_ACCELERATION_ARB = $2003;
  WGL_NEED_PALETTE_ARB = $2004;
  WGL_NEED_SYSTEM_PALETTE_ARB = $2005;
  WGL_SWAP_LAYER_BUFFERS_ARB = $2006;
  WGL_SWAP_METHOD_ARB = $2007;
  WGL_NUMBER_OVERLAYS_ARB = $2008;
  WGL_NUMBER_UNDERLAYS_ARB = $2009;
  WGL_TRANSPARENT_ARB = $200A;
  WGL_TRANSPARENT_RED_VALUE_ARB = $2037;
  WGL_TRANSPARENT_GREEN_VALUE_ARB = $2038;
  WGL_TRANSPARENT_BLUE_VALUE_ARB = $2039;
  WGL_TRANSPARENT_ALPHA_VALUE_ARB = $203A;
  WGL_TRANSPARENT_INDEX_VALUE_ARB = $203B;
  WGL_SHARE_DEPTH_ARB = $200C;
  WGL_SHARE_STENCIL_ARB = $200D;
  WGL_SHARE_ACCUM_ARB = $200E;
  WGL_SUPPORT_GDI_ARB = $200F;
  WGL_SUPPORT_OPENGL_ARB = $2010;
  WGL_DOUBLE_BUFFER_ARB = $2011;
  WGL_STEREO_ARB = $2012;
  WGL_PIXEL_TYPE_ARB = $2013;
  WGL_COLOR_BITS_ARB = $2014;
  WGL_RED_BITS_ARB = $2015;
  WGL_RED_SHIFT_ARB = $2016;
  WGL_GREEN_BITS_ARB = $2017;
  WGL_GREEN_SHIFT_ARB = $2018;
  WGL_BLUE_BITS_ARB = $2019;
  WGL_BLUE_SHIFT_ARB = $201A;
  WGL_ALPHA_BITS_ARB = $201B;
  WGL_ALPHA_SHIFT_ARB = $201C;
  WGL_ACCUM_BITS_ARB = $201D;
  WGL_ACCUM_RED_BITS_ARB = $201E;
  WGL_ACCUM_GREEN_BITS_ARB = $201F;
  WGL_ACCUM_BLUE_BITS_ARB = $2020;
  WGL_ACCUM_ALPHA_BITS_ARB = $2021;
  WGL_DEPTH_BITS_ARB = $2022;
  WGL_STENCIL_BITS_ARB = $2023;
  WGL_AUX_BUFFERS_ARB = $2024;
  WGL_NO_ACCELERATION_ARB = $2025;
  WGL_GENERIC_ACCELERATION_ARB = $2026;
  WGL_FULL_ACCELERATION_ARB = $2027;
  WGL_SWAP_EXCHANGE_ARB = $2028;
  WGL_SWAP_COPY_ARB = $2029;
  WGL_SWAP_UNDEFINED_ARB = $202A;
  WGL_TYPE_RGBA_ARB = $202B;
  WGL_TYPE_COLORINDEX_ARB = $202C;

  // WGL_ARB_pixel_format_float
  WGL_TYPE_RGBA_FLOAT_ARB = $21A0;
  // ниже устаревшие константы???
  WGL_RGBA_FLOAT_MODE_ARB = $8820;
  WGL_CLAMP_VERTEX_COLOR_ARB = $891A;
  WGL_CLAMP_FRAGMENT_COLOR_ARB = $891B;
  WGL_CLAMP_READ_COLOR_ARB = $891C;
  WGL_FIXED_ONLY_ARB = $891D;

  // WGL_ARB_render_texture
  WGL_BIND_TO_TEXTURE_RGB_ARB = $2070;
  WGL_BIND_TO_TEXTURE_RGBA_ARB = $2071;
  WGL_TEXTURE_FORMAT_ARB = $2072;
  WGL_TEXTURE_TARGET_ARB = $2073;
  WGL_MIPMAP_TEXTURE_ARB = $2074;
  WGL_TEXTURE_RGB_ARB = $2075;
  WGL_TEXTURE_RGBA_ARB = $2076;
  WGL_NO_TEXTURE_ARB = $2077;
  WGL_TEXTURE_CUBE_MAP_ARB = $2078;
  WGL_TEXTURE_1D_ARB = $2079;
  WGL_TEXTURE_2D_ARB = $207A;
  WGL_MIPMAP_LEVEL_ARB = $207B;
  WGL_CUBE_MAP_FACE_ARB = $207C;
  WGL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = $207D;
  WGL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = $207E;
  WGL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = $207F;
  WGL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = $2080;
  WGL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = $2081;
  WGL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = $2082;
  WGL_FRONT_LEFT_ARB = $2083;
  WGL_FRONT_RIGHT_ARB = $2084;
  WGL_BACK_LEFT_ARB = $2085;
  WGL_BACK_RIGHT_ARB = $2086;
  WGL_AUX0_ARB = $2087;
  WGL_AUX1_ARB = $2088;
  WGL_AUX2_ARB = $2089;
  WGL_AUX3_ARB = $208A;
  WGL_AUX4_ARB = $208B;
  WGL_AUX5_ARB = $208C;
  WGL_AUX6_ARB = $208D;
  WGL_AUX7_ARB = $208E;
  WGL_AUX8_ARB = $208F;
  WGL_AUX9_ARB = $2090;

  // WGL_ARB_robustness_application_isolation
  WGL_CONTEXT_RESET_ISOLATION_BIT_ARB = $00000008;

  // WGL_ARB_create_context
  WGL_CONTEXT_DEBUG_BIT_ARB = $00000001;
  WGL_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = $00000002;
  WGL_CONTEXT_MAJOR_VERSION_ARB = $2091;
  WGL_CONTEXT_MINOR_VERSION_ARB = $2092;
  WGL_CONTEXT_LAYER_PLANE_ARB = $2093;
  WGL_CONTEXT_FLAGS_ARB = $2094;
  ERROR_INVALID_VERSION_ARB = $2095;

  // WGL_ARB_create_context_no_error
  WGL_CONTEXT_OPENGL_NO_ERROR_ARB = $31B3;

  // WGL_ARB_create_context_profile
  WGL_CONTEXT_PROFILE_MASK_ARB = $9126;
  WGL_CONTEXT_CORE_PROFILE_BIT_ARB = $00000001;
  WGL_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = $00000002;
  ERROR_INVALID_PROFILE_ARB = $2096;

  // WGL_ARB_framebuffer_sRGB
  WGL_FRAMEBUFFER_SRGB_CAPABLE_ARB = $20A9;

  // WGL_ARB_create_context_robustness
  WGL_CONTEXT_ROBUST_ACCESS_BIT_ARB = $00000004;
  WGL_LOSE_CONTEXT_ON_RESET_ARB = $8252;
  WGL_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  WGL_NO_RESET_NOTIFICATION_ARB = $8261;

  // WGL_ATI_pixel_format_float
  WGL_TYPE_RGBA_FLOAT_ATI = $21A0;
  // опять устаревшая константа???
  GL_TYPE_RGBA_FLOAT_ATI = $8820;
//  GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI = $8835;

  // WGL_ATI_render_texture_rectangle
  WGL_TEXTURE_RECTANGLE_ATI = $21A5;

  // WGL_EXT_colorspace
  WGL_COLORSPACE_EXT = $309D;
  WGL_COLORSPACE_SRGB_EXT = $3089;
  WGL_COLORSPACE_LINEAR_EXT = $308A;

  // WGL_AMD_gpu_association
  WGL_GPU_VENDOR_AMD = $1F00;
  WGL_GPU_RENDERER_STRING_AMD = $1F01;
  WGL_GPU_OPENGL_VERSION_STRING_AMD = $1F02;
  WGL_GPU_FASTEST_TARGET_GPUS_AMD = $21A2;
  WGL_GPU_RAM_AMD = $21A3;
  WGL_GPU_CLOCK_AMD = $21A4;
  WGL_GPU_NUM_PIPES_AMD = $21A5;
  WGL_GPU_NUM_SIMD_AMD = $21A6;
  WGL_GPU_NUM_RB_AMD = $21A7;
  WGL_GPU_NUM_SPI_AMD = $21A8;

  // WGL_EXT_depth_float
  WGL_DEPTH_FLOAT_EXT = $2040;

  // WGL_EXT_framebuffer_sRGB
  WGL_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20A9;

  // WGL_EXT_make_current_read
  ERROR_INVALID_PIXEL_TYPE_EXT = $2043;

  // WGL_EXT_multisample
  WGL_SAMPLE_BUFFERS_EXT = $2041;
  WGL_SAMPLES_EXT = $2042;

  // WGL_EXT_pbuffer
  WGL_DRAW_TO_PBUFFER_EXT = $202D;
  WGL_MAX_PBUFFER_PIXELS_EXT = $202E;
  WGL_MAX_PBUFFER_WIDTH_EXT = $202F;
  WGL_MAX_PBUFFER_HEIGHT_EXT = $2030;
  WGL_OPTIMAL_PBUFFER_WIDTH_EXT = $2031;
  WGL_OPTIMAL_PBUFFER_HEIGHT_EXT = $2032;
  WGL_PBUFFER_LARGEST_EXT = $2033;
  WGL_PBUFFER_WIDTH_EXT = $2034;
  WGL_PBUFFER_HEIGHT_EXT = $2035;

  // WGL_EXT_pixel_format
  WGL_NUMBER_PIXEL_FORMATS_EXT = $2000;
  WGL_DRAW_TO_WINDOW_EXT = $2001;
  WGL_DRAW_TO_BITMAP_EXT = $2002;
  WGL_ACCELERATION_EXT = $2003;
  WGL_NEED_PALETTE_EXT = $2004;
  WGL_NEED_SYSTEM_PALETTE_EXT = $2005;
  WGL_SWAP_LAYER_BUFFERS_EXT = $2006;
  WGL_SWAP_METHOD_EXT = $2007;
  WGL_NUMBER_OVERLAYS_EXT = $2008;
  WGL_NUMBER_UNDERLAYS_EXT = $2009;
  WGL_TRANSPARENT_EXT = $200A;
  WGL_TRANSPARENT_VALUE_EXT = $200B;
  WGL_SHARE_DEPTH_EXT = $200C;
  WGL_SHARE_STENCIL_EXT = $200D;
  WGL_SHARE_ACCUM_EXT = $200E;
  WGL_SUPPORT_GDI_EXT = $200F;
  WGL_SUPPORT_OPENGL_EXT = $2010;
  WGL_DOUBLE_BUFFER_EXT = $2011;
  WGL_STEREO_EXT = $2012;
  WGL_PIXEL_TYPE_EXT = $2013;
  WGL_COLOR_BITS_EXT = $2014;
  WGL_RED_BITS_EXT = $2015;
  WGL_RED_SHIFT_EXT = $2016;
  WGL_GREEN_BITS_EXT = $2017;
  WGL_GREEN_SHIFT_EXT = $2018;
  WGL_BLUE_BITS_EXT = $2019;
  WGL_BLUE_SHIFT_EXT = $201A;
  WGL_ALPHA_BITS_EXT = $201B;
  WGL_ALPHA_SHIFT_EXT = $201C;
  WGL_ACCUM_BITS_EXT = $201D;
  WGL_ACCUM_RED_BITS_EXT = $201E;
  WGL_ACCUM_GREEN_BITS_EXT = $201F;
  WGL_ACCUM_BLUE_BITS_EXT = $2020;
  WGL_ACCUM_ALPHA_BITS_EXT = $2021;
  WGL_DEPTH_BITS_EXT = $2022;
  WGL_STENCIL_BITS_EXT = $2023;
  WGL_AUX_BUFFERS_EXT = $2024;
  WGL_NO_ACCELERATION_EXT = $2025;
  WGL_GENERIC_ACCELERATION_EXT = $2026;
  WGL_FULL_ACCELERATION_EXT = $2027;
  WGL_SWAP_EXCHANGE_EXT = $2028;
  WGL_SWAP_COPY_EXT = $2029;
  WGL_SWAP_UNDEFINED_EXT = $202A;
  WGL_TYPE_RGBA_EXT = $202B;
  WGL_TYPE_COLORINDEX_EXT = $202C;

  // WGL_EXT_pixel_format_packed_float
  WGL_TYPE_RGBA_UNSIGNED_FLOAT_EXT = $20A8;

  // WGL_I3D_digital_video_control
  WGL_DIGITAL_VIDEO_CURSOR_ALPHA_FRAMEBUFFER_I3D = $2050;
  WGL_DIGITAL_VIDEO_CURSOR_ALPHA_VALUE_I3D = $2051;
  WGL_DIGITAL_VIDEO_CURSOR_INCLUDED_I3D = $2052;
  WGL_DIGITAL_VIDEO_GAMMA_CORRECTED_I3D = $2053;

  // WGL_I3D_gamma
  WGL_GAMMA_TABLE_SIZE_I3D = $204E;
  WGL_GAMMA_EXCLUDE_DESKTOP_I3D = $204F;

  // WGL_I3D_genlock
  WGL_GENLOCK_SOURCE_MULTIVIEW_I3D = $2044;
  WGL_GENLOCK_SOURCE_EXTENAL_SYNC_I3D = $2045;
  WGL_GENLOCK_SOURCE_EXTENAL_FIELD_I3D = $2046;
  WGL_GENLOCK_SOURCE_EXTENAL_TTL_I3D = $2047;
  WGL_GENLOCK_SOURCE_DIGITAL_SYNC_I3D = $2048;
  WGL_GENLOCK_SOURCE_DIGITAL_FIELD_I3D = $2049;
  WGL_GENLOCK_SOURCE_EDGE_FALLING_I3D = $204A;
  WGL_GENLOCK_SOURCE_EDGE_RISING_I3D = $204B;
  WGL_GENLOCK_SOURCE_EDGE_BOTH_I3D = $204C;

  // WGL_I3D_image_buffer
  WGL_IMAGE_BUFFER_MIN_ACCESS_I3D = $00000001;
  WGL_IMAGE_BUFFER_LOCK_I3D = $00000002;

  // WGL_NV_float_buffer
  WGL_FLOAT_COMPONENTS_NV = $20B0;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_R_NV = $20B1;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RG_NV = $20B2;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGB_NV = $20B3;
  WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGBA_NV = $20B4;
  WGL_TEXTURE_FLOAT_R_NV = $20B5;
  WGL_TEXTURE_FLOAT_RG_NV = $20B6;
  WGL_TEXTURE_FLOAT_RGB_NV = $20B7;
  WGL_TEXTURE_FLOAT_RGBA_NV = $20B8;

  // WGL_NV_render_depth_texture
  WGL_BIND_TO_TEXTURE_DEPTH_NV = $20A3;
  WGL_BIND_TO_TEXTURE_RECTANGLE_DEPTH_NV = $20A4;
  WGL_DEPTH_TEXTURE_FORMAT_NV = $20A5;
  WGL_TEXTURE_DEPTH_COMPONENT_NV = $20A6;
  WGL_DEPTH_COMPONENT_NV = $20A7;

  // WGL_NV_render_texture_rectangle
  WGL_BIND_TO_TEXTURE_RECTANGLE_RGB_NV = $20A0;
  WGL_BIND_TO_TEXTURE_RECTANGLE_RGBA_NV = $20A1;
  WGL_TEXTURE_RECTANGLE_NV = $20A2;

  // WGL_NV_present_video
  WGL_NUM_VIDEO_SLOTS_NV = $20F0;

  // WGL_NV_video_output
  WGL_BIND_TO_VIDEO_RGB_NV = $20C0;
  WGL_BIND_TO_VIDEO_RGBA_NV = $20C1;
  WGL_BIND_TO_VIDEO_RGB_AND_DEPTH_NV = $20C2;
  WGL_VIDEO_OUT_COLOR_NV = $20C3;
  WGL_VIDEO_OUT_ALPHA_NV = $20C4;
  WGL_VIDEO_OUT_DEPTH_NV = $20C5;
  WGL_VIDEO_OUT_COLOR_AND_ALPHA_NV = $20C6;
  WGL_VIDEO_OUT_COLOR_AND_DEPTH_NV = $20C7;
  WGL_VIDEO_OUT_FRAME = $20C8;
  WGL_VIDEO_OUT_FIELD_1 = $20C9;
  WGL_VIDEO_OUT_FIELD_2 = $20CA;
  WGL_VIDEO_OUT_STACKED_FIELDS_1_2 = $20CB;
  WGL_VIDEO_OUT_STACKED_FIELDS_2_1 = $20CC;

  // WGL_NV_gpu_affinity
  WGL_ERROR_INCOMPATIBLE_AFFINITY_MASKS_NV = $20D0;
  WGL_ERROR_MISSING_AFFINITY_MASK_NV = $20D1;

  // WGL_NV_multigpu_context
  WGL_CONTEXT_MULTIGPU_ATTRIB_NV = $20AA;
  WGL_CONTEXT_MULTIGPU_ATTRIB_SINGLE_NV = $20AB;
  WGL_CONTEXT_MULTIGPU_ATTRIB_AFR_NV = $20AC;
  WGL_CONTEXT_MULTIGPU_ATTRIB_MULTICAST_NV = $20AD;
  WGL_CONTEXT_MULTIGPU_ATTRIB_MULTI_DISPLAY_MULTICAST_NV = $20AE;

  // WGL_NV_video_capture
  WGL_UNIQUE_ID_NV = $20CE;
  WGL_NUM_VIDEO_CAPTURE_SLOTS_NV = $20CF;

  // WGL_NV_multisample_coverage
  WGL_COVERAGE_SAMPLES_NV = $2042;
  WGL_COLOR_SAMPLES_NV = $20B9;

  // WGL_EXT_create_context_es2_profile
  WGL_CONTEXT_ES2_PROFILE_BIT_EXT = $00000004;

  // WGL_EXT_create_context_es2_profile
  WGL_CONTEXT_ES_PROFILE_BIT_EXT = $00000004;

  // WGL_NV_DX_interop
  WGL_ACCESS_READ_ONLY_NV        = $00000000;
  WGL_ACCESS_READ_WRITE_NV       = $00000001;
  WGL_ACCESS_WRITE_DISCARD_NV    = $00000002;
(*******************************************************************************
*                                     end WGL                                  *
*******************************************************************************)
{$EndIf}

{$IfDef LINUX}
(*******************************************************************************
*                                   begin GLX                                  *
*******************************************************************************)
type
  PGLXFBConfig  = ^GLXFBConfig;
  PGLXFBConfigSGIX  = ^GLXFBConfigSGIX;
  PGLXHyperpipeConfigSGIX  = ^GLXHyperpipeConfigSGIX;
  PGLXHyperpipeNetworkSGIX  = ^GLXHyperpipeNetworkSGIX;
  PGLXVideoCaptureDeviceNV  = ^GLXVideoCaptureDeviceNV;
  PGLXVideoDeviceNV  = ^GLXVideoDeviceNV;
//  PXVisualInfo  = ^XVisualInfo;

  GLXFBConfig = Pointer;
  GLXContext = Pointer;
  GLXDrawable = TXID;
  XWindow = TXID;
  XPixmap = TXID;
  XFont = TXID;
  XColormap = TXID;
  GLXPixmap = TXID;
  GLXWindow = TXID;
  GLXContextID = TXID;
  GLXPBuffer = TXID;

  cuint = LongWord;
  cint = LongInt;

  // GLX_NV_video_capture
  GLXVideoCaptureDeviceNV = TXID;

  // GLX_NV_video_out
  GLXVideoDeviceNV = dword;

  // GLX_OML_sync_control
  (*                есть желание, разбирайтесь
  В данное время эта часть блока будет отключена, пока нормально не переведут эти "запчасти"
  предварительно, как понимаю я:
  -----------------
  Pint64_t = ^int64_t;
  Puint64_t = ^uint64_t;
  Pint32_t = ^int32_t;
  {$IfDef ARM}    // хотя что за фигня происходит, ведь не только ARM 32-х битная архитектура?!
    int64_t = LongInt;
    uint64_t = DWord;
  {$else}
    int64_t = Int64;
    uint64_t = QWord;
  {$EndIf}
  int32_t = LongInt;
  ----------------

  {$ifndef GLEXT_64_TYPES_DEFINED}
    { This code block is duplicated in glext.h, so must be protected  }
    { Этот блок кода дублируется в glext.h, поэтому должен быть защищен }
  {$define GLEXT_64_TYPES_DEFINED}
    { Define int32_t, int64_t, and uint64_t types for UST/MSC  }
    { (as used in the GLX_OML_sync_control extension).  }
    { Define int32_t, int64_t и uint64_t типы для UST/MSC }

  {$if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L}
  {$include <inttypes.h>}
  ( *** was #elif **** ){$else defined(__sun__) || defined(__digital__)}
  {$include <inttypes.h>}
  {$if defined(__STDC__)}
  {$if defined(__arch64__) || defined(_LP64)}  // unix + arch64

    type
      int64_t = longint;
      uint64_t = dword;
  {$else}

    type
      int64_t = int64;
      uint64_t = qword;
  {$endif}
    { __arch64__  }
  {$endif}
    { __STDC__  }
  ( *** was #elif **** ){$else defined( __VMS ) || defined(__sgi)}
  {$include <inttypes.h>}
  ( *** was #elif **** ){$else defined(__SCO__) || defined(__USLC__)}
  {$include <stdint.h>}
  ( *** was #elif **** ){$else defined(__UNIXOS2__) || defined(__SOL64__)}

    type
      int32_t = longint;
      int64_t = int64;
      uint64_t = qword;
  ( *** was #elif **** ){$else defined(_WIN32) && defined(__GNUC__)}
  {$include <stdint.h>}
  ( *** was #elif **** ){$else defined(_WIN32)}

    type
      int32_t = longint;                           дебильный блок... не думаю что нужно разбираться.
      int64_t = int64;
      uint64_t = qword;
  {$else}
    { Fallback if nothing above works  }
  {$include <inttypes.h>}
  {$endif}
  {$endif}              *)

  // GLX_SGIX_dmbuffer
  GLXPbufferSGIX = TXID;

  // GLX_SGIX_fbconfig
  GLXFBConfigSGIX = Pointer; // или Integer?; // ^__GLXFBConfigRec;

// GLX_SGIX_hyperpipe
  GLXHyperpipeNetworkSGIX = record
    pipeName : array[0..79] of char;
    networkId : longint;
  end;
  { Should be [GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX]  }
  GLXHyperpipeConfigSGIX = record
    pipeName : array[0..79] of char;
    channel : longint;
    participationType : dword;
    timeSlice : longint;
  end;
  { Should be [GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX]  }
  GLXPipeRect = record
    pipeName : array[0..79] of char;
    srcXOrigin : longint;
    srcYOrigin : longint;
    srcWidth : longint;
    srcHeight : longint;
    destXOrigin : longint;
    destYOrigin : longint;
    destWidth : longint;
    destHeight : longint;
  end;
  { Should be [GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX]  }
  GLXPipeRectLimits = record
    pipeName : array[0..79] of char;
    XOrigin : longint;
    YOrigin : longint;
    maxHeight : longint;
    maxWidth : longint;
  end;

  // GLX_SGIX_video_source
  GLXVideoSourceSGIX = TXID;

type
  TVector2d = array[0..1] of double;
  TVector2f = array[0..1] of single;
  TVector2i = array[0..1] of longint;
  TVector2s = array[0..1] of smallint;
  TVector2b = array[0..1] of byte;

  TVector3d = array[0..2] of double;
  TVector3f = array[0..2] of single;
  TVector3i = array[0..2] of longint;
  TVector3s = array[0..2] of smallint;
  TVector3b = array[0..2] of byte;

  TVector4d = array[0..3] of double;
  TVector4f = array[0..3] of single;
  TVector4i = array[0..3] of longint;
  TVector4s = array[0..3] of smallint;
  TVector4b = array[0..3] of byte;

  TMatrix3d = array[0..2] of TVector3d;
  TMatrix3f = array[0..2] of TVector3f;
  TMatrix3i = array[0..2] of TVector3i;
  TMatrix3s = array[0..2] of TVector3s;
  TMatrix3b = array[0..2] of TVector3b;

  TMatrix4d = array[0..3] of TVector4d;
  TMatrix4f = array[0..3] of TVector4f;
  TMatrix4i = array[0..3] of TVector4i;
  TMatrix4s = array[0..3] of TVector4s;
  TMatrix4b = array[0..3] of TVector4b;

{$ifdef GLX_EXT_stereo_tree}
type
  GLXStereoNotifyEventEXT = record
     _type : longint;
      serial : dword;
      send_event : Bool;
      display : ^Display;
      extension : longint;
      evtype : longint;
      window : GLXDrawable;
      stereo_tree : Bool;
    end;
{$EndIf}

const
(* Tokens for glXChooseVisual and glXGetConfig *)
  GLX_USE_GL                            = 1;
  GLX_BUFFER_SIZE                       = 2;
  GLX_LEVEL                             = 3;
  GLX_RGBA                              = 4;
  GLX_DOUBLEBUFFER                      = 5;
  GLX_STEREO                            = 6;
  GLX_AUX_BUFFERS                       = 7;
  GLX_RED_SIZE                          = 8;
  GLX_GREEN_SIZE                        = 9;
  GLX_BLUE_SIZE                         = 10;
  GLX_ALPHA_SIZE                        = 11;
  GLX_DEPTH_SIZE                        = 12;
  GLX_STENCIL_SIZE                      = 13;
  GLX_ACCUM_RED_SIZE                    = 14;
  GLX_ACCUM_GREEN_SIZE                  = 15;
  GLX_ACCUM_BLUE_SIZE                   = 16;
  GLX_ACCUM_ALPHA_SIZE                  = 17;

(* Error codes returned by glXGetConfig *)
  GLX_BAD_SCREEN                        = 1;
  GLX_BAD_ATTRIBUTE                     = 2;
  GLX_NO_EXTENSION                      = 3;
  GLX_BAD_VISUAL                        = 4;
  GLX_BAD_CONTEXT                       = 5;
  GLX_BAD_VALUE                         = 6;
  GLX_BAD_ENUM                          = 7;

(* GLX 1.1 and later *)
  GLX_VENDOR                            = 1;            // поставщик?
  GLX_VERSION                           = 2;            // версия
  GLX_EXTENSIONS                        = 3;            // расширения

(* GLX 1.3 and later *)
  GLX_CONFIG_CAVEAT                     = $20;
  GLX_DONT_CARE                         = $FFFFFFFF;
  GLX_X_VISUAL_TYPE                     = $22;
  GLX_TRANSPARENT_TYPE                  = $23;
  GLX_TRANSPARENT_INDEX_VALUE           = $24;
  GLX_TRANSPARENT_RED_VALUE             = $25;
  GLX_TRANSPARENT_GREEN_VALUE           = $26;
  GLX_TRANSPARENT_BLUE_VALUE            = $27;
  GLX_TRANSPARENT_ALPHA_VALUE           = $28;
  GLX_WINDOW_BIT                        = $00000001;
  GLX_PIXMAP_BIT                        = $00000002;
  GLX_PBUFFER_BIT                       = $00000004;
  GLX_AUX_BUFFERS_BIT                   = $00000010;
  GLX_FRONT_LEFT_BUFFER_BIT             = $00000001;
  GLX_FRONT_RIGHT_BUFFER_BIT            = $00000002;
  GLX_BACK_LEFT_BUFFER_BIT              = $00000004;
  GLX_BACK_RIGHT_BUFFER_BIT             = $00000008;
  GLX_DEPTH_BUFFER_BIT                  = $00000020;
  GLX_STENCIL_BUFFER_BIT                = $00000040;
  GLX_ACCUM_BUFFER_BIT                  = $00000080;
  GLX_NONE                              = $8000;
  GLX_SLOW_CONFIG                       = $8001;
  GLX_TRUE_COLOR                        = $8002;
  GLX_DIRECT_COLOR                      = $8003;
  GLX_PSEUDO_COLOR                      = $8004;
  GLX_STATIC_COLOR                      = $8005;
  GLX_GRAY_SCALE                        = $8006;
  GLX_STATIC_GRAY                       = $8007;
  GLX_TRANSPARENT_RGB                   = $8008;
  GLX_TRANSPARENT_INDEX                 = $8009;
  GLX_VISUAL_ID                         = $800B;
  GLX_SCREEN                            = $800C;
  GLX_NON_CONFORMANT_CONFIG             = $800D;
  GLX_DRAWABLE_TYPE                     = $8010;
  GLX_RENDER_TYPE                       = $8011;
  GLX_X_RENDERABLE                      = $8012;
  GLX_FBCONFIG_ID                       = $8013;
  GLX_RGBA_TYPE                         = $8014;
  GLX_COLOR_INDEX_TYPE                  = $8015;
  GLX_MAX_PBUFFER_WIDTH                 = $8016;
  GLX_MAX_PBUFFER_HEIGHT                = $8017;
  GLX_MAX_PBUFFER_PIXELS                = $8018;
  GLX_PRESERVED_CONTENTS                = $801B;
  GLX_LARGEST_PBUFFER                   = $801C;
  GLX_WIDTH                             = $801D;
  GLX_HEIGHT                            = $801E;
  GLX_EVENT_MASK                        = $801F;
  GLX_DAMAGED                           = $8020;
  GLX_SAVED                             = $8021;
  GLX_WINDOW                            = $8022;
  GLX_PBUFFER                           = $8023;
  GLX_PBUFFER_HEIGHT                    = $8040;
  GLX_PBUFFER_WIDTH                     = $8041;
  GLX_RGBA_BIT                          = $00000001;
  GLX_COLOR_INDEX_BIT                   = $00000002;
  GLX_PBUFFER_CLOBBER_MASK              = $08000000;

(* GLX 1.4 and later *)
  GLX_SAMPLE_BUFFERS                    = $186A0;
  GLX_SAMPLES                           = $186A1;

(* Extensions *)
(* GLX_ARB_context_flush_control *)
  GLX_CONTEXT_RELEASE_BEHAVIOR_ARB = $2097;
  GLX_CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;
  GLX_CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = $2098;

(* GLX_ARB_multisample *)
  GLX_SAMPLE_BUFFERS_ARB                = 100000;
  GLX_SAMPLES_ARB                       = 100001;

(* GLX_ARB_create_context (http://www.opengl.org/registry/specs/ARB/glx_create_context.txt) *)
  GLX_CONTEXT_DEBUG_BIT_ARB             = $00000001;
  GLX_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = $00000002;
  GLX_CONTEXT_MAJOR_VERSION_ARB         = $2091;
  GLX_CONTEXT_MINOR_VERSION_ARB         = $2092;
  GLX_CONTEXT_FLAGS_ARB                 = $2094;

(* GLX_ARB_create_context_no_error *)
  GLX_CONTEXT_OPENGL_NO_ERROR_ARB = $31B3;

(* GLX_ARB_create_context_profile *)
  GLX_CONTEXT_CORE_PROFILE_BIT_ARB      = $00000001;
  GLX_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = $00000002;
  GLX_CONTEXT_PROFILE_MASK_ARB          = $9126;

(* GLX_ARB_create_context_robustness *)
  GLX_CONTEXT_ROBUST_ACCESS_BIT_ARB     = $00000004;
  GLX_LOSE_CONTEXT_ON_RESET_ARB         = $8252;
  GLX_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  GLX_NO_RESET_NOTIFICATION_ARB         = $8261;

(* GLX_ARB_fbconfig_float *)
  GLX_RGBA_FLOAT_TYPE_ARB               = $20B9;
  GLX_RGBA_FLOAT_BIT_ARB                = $00000004;

(* GLX_ARB_framebuffer_sRGB *)
  GLX_FRAMEBUFFER_SRGB_CAPABLE_ARB      = $20B2;

(* GLX_ARB_robustness_application_isolation *)
  GLX_CONTEXT_RESET_ISOLATION_BIT_ARB   = $00000008;

(* GLX_ARB_vertex_buffer_object *)
  GLX_CONTEXT_ALLOW_BUFFER_BYTE_ORDER_MISMATCH_ARB = $2095;

(* GLX_3DFX_multisample *)
  GLX_SAMPLE_BUFFERS_3DFX = $8050;
  GLX_SAMPLES_3DFX = $8051;

(* GLX_AMD_gpu_association *)
  GLX_GPU_VENDOR_AMD = $1F00;
  GLX_GPU_RENDERER_STRING_AMD = $1F01;
  GLX_GPU_OPENGL_VERSION_STRING_AMD = $1F02;
  GLX_GPU_FASTEST_TARGET_GPUS_AMD = $21A2;
  GLX_GPU_RAM_AMD = $21A3;
  GLX_GPU_CLOCK_AMD = $21A4;
  GLX_GPU_NUM_PIPES_AMD = $21A5;
  GLX_GPU_NUM_SIMD_AMD = $21A6;
  GLX_GPU_NUM_RB_AMD = $21A7;
  GLX_GPU_NUM_SPI_AMD = $21A8;

(* GLX_EXT_buffer_age *)
  GLX_BACK_BUFFER_AGE_EXT = $20F4;

(* GLX_EXT_context_priority *)
  GLX_CONTEXT_PRIORITY_LEVEL_EXT = $3100;
  GLX_CONTEXT_PRIORITY_HIGH_EXT = $3101;
  GLX_CONTEXT_PRIORITY_MEDIUM_EXT = $3102;
  GLX_CONTEXT_PRIORITY_LOW_EXT = $3103;

(* GLX_EXT_create_context_es2_profile *)
  GLX_CONTEXT_ES2_PROFILE_BIT_EXT = $00000004;

(* GLX_EXT_create_context_es_profile *)
  GLX_CONTEXT_ES_PROFILE_BIT_EXT = $00000004;

(* GLX_EXT_fbconfig_packed_float *)
  GLX_RGBA_UNSIGNED_FLOAT_TYPE_EXT      = $20B1;
  GLX_RGBA_UNSIGNED_FLOAT_BIT_EXT       = $00000008;

(* GLX_EXT_framebuffer_sRGB *)
  GLX_FRAMEBUFFER_SRGB_CAPABLE_EXT      = $20B2;

(* GLX_EXT_import_context *)
  GLX_SHARE_CONTEXT_EXT = $800A;
  GLX_VISUAL_ID_EXT = $800B;
  GLX_SCREEN_EXT = $800C;

(* GLX_EXT_libglvnd *)
  GLX_VENDOR_NAMES_EXT = $20F6;

(* GLX_EXT_stereo_tree *)
  GLX_STEREO_TREE_EXT = $20F5;
  GLX_STEREO_NOTIFY_MASK_EXT = $00000001;
  GLX_STEREO_NOTIFY_EXT = $00000000;

(* GLX_EXT_swap_control *)
  GLX_SWAP_INTERVAL_EXT = $20F1;
  GLX_MAX_SWAP_INTERVAL_EXT = $20F2;

(* GLX_EXT_swap_control_tear *)
  GLX_LATE_SWAPS_TEAR_EXT = $20F3;

(* GLX_EXT_texture_from_pixmap *)
  GLX_TEXTURE_1D_BIT_EXT = $00000001;
  GLX_TEXTURE_2D_BIT_EXT = $00000002;
  GLX_TEXTURE_RECTANGLE_BIT_EXT = $00000004;
  GLX_BIND_TO_TEXTURE_RGB_EXT = $20D0;
  GLX_BIND_TO_TEXTURE_RGBA_EXT = $20D1;
  GLX_BIND_TO_MIPMAP_TEXTURE_EXT = $20D2;
  GLX_BIND_TO_TEXTURE_TARGETS_EXT = $20D3;
  GLX_Y_INVERTED_EXT = $20D4;
  GLX_TEXTURE_FORMAT_EXT = $20D5;
  GLX_TEXTURE_TARGET_EXT = $20D6;
  GLX_MIPMAP_TEXTURE_EXT = $20D7;
  GLX_TEXTURE_FORMAT_NONE_EXT = $20D8;
  GLX_TEXTURE_FORMAT_RGB_EXT = $20D9;
  GLX_TEXTURE_FORMAT_RGBA_EXT = $20DA;
  GLX_TEXTURE_1D_EXT = $20DB;
  GLX_TEXTURE_2D_EXT = $20DC;
  GLX_TEXTURE_RECTANGLE_EXT = $20DD;
  GLX_FRONT_LEFT_EXT = $20DE;
  GLX_FRONT_RIGHT_EXT = $20DF;
  GLX_BACK_LEFT_EXT = $20E0;
  GLX_BACK_RIGHT_EXT = $20E1;
  GLX_FRONT_EXT = $20DE;
  GLX_BACK_EXT = $20E0;
  GLX_AUX0_EXT = $20E2;
  GLX_AUX1_EXT = $20E3;
  GLX_AUX2_EXT = $20E4;
  GLX_AUX3_EXT = $20E5;
  GLX_AUX4_EXT = $20E6;
  GLX_AUX5_EXT = $20E7;
  GLX_AUX6_EXT = $20E8;
  GLX_AUX7_EXT = $20E9;
  GLX_AUX8_EXT = $20EA;
  GLX_AUX9_EXT = $20EB;

(* GLX_SGIS_multisample *)
  GLX_SAMPLE_BUFFERS_SGIS               = 100000;
  GLX_SAMPLES_SGIS                      = 100001;

(* GLX_EXT_visual_info *)
  GLX_X_VISUAL_TYPE_EXT                 = $22;
  GLX_TRANSPARENT_TYPE_EXT              = $23;
  GLX_TRANSPARENT_INDEX_VALUE_EXT       = $24;
  GLX_TRANSPARENT_RED_VALUE_EXT         = $25;
  GLX_TRANSPARENT_GREEN_VALUE_EXT       = $26;
  GLX_TRANSPARENT_BLUE_VALUE_EXT        = $27;
  GLX_TRANSPARENT_ALPHA_VALUE_EXT       = $28;

  GLX_TRUE_COLOR_EXT                    = $8002;
  GLX_DIRECT_COLOR_EXT                  = $8003;
  GLX_PSEUDO_COLOR_EXT                  = $8004;
  GLX_STATIC_COLOR_EXT                  = $8005;
  GLX_GRAY_SCALE_EXT                    = $8006;
  GLX_STATIC_GRAY_EXT                   = $8007;
  GLX_NONE_EXT                          = $8000;
  GLX_TRANSPARENT_RGB_EXT               = $8008;
  GLX_TRANSPARENT_INDEX_EXT             = $8009;

(* GLX_EXT_visual_rating *)
  GLX_VISUAL_CAVEAT_EXT = $20;
  GLX_SLOW_VISUAL_EXT = $8001;
  GLX_NON_CONFORMANT_VISUAL_EXT = $800D;

(* GLX_INTEL_swap_event *)
  GLX_BUFFER_SWAP_COMPLETE_INTEL_MASK = $04000000;
  GLX_EXCHANGE_COMPLETE_INTEL = $8180;
  GLX_COPY_COMPLETE_INTEL = $8181;
  GLX_FLIP_COMPLETE_INTEL = $8182;

(* GLX_MESA_agp_offset *)
  GLX_RENDERER_VENDOR_ID_MESA = $8183;
  GLX_RENDERER_DEVICE_ID_MESA = $8184;
  GLX_RENDERER_VERSION_MESA = $8185;
  GLX_RENDERER_ACCELERATED_MESA = $8186;
  GLX_RENDERER_VIDEO_MEMORY_MESA = $8187;
  GLX_RENDERER_UNIFIED_MEMORY_ARCHITECTURE_MESA = $8188;
  GLX_RENDERER_PREFERRED_PROFILE_MESA = $8189;
  GLX_RENDERER_OPENGL_CORE_PROFILE_VERSION_MESA = $818A;
  GLX_RENDERER_OPENGL_COMPATIBILITY_PROFILE_VERSION_MESA = $818B;
  GLX_RENDERER_OPENGL_ES_PROFILE_VERSION_MESA = $818C;
  GLX_RENDERER_OPENGL_ES2_PROFILE_VERSION_MESA = $818D;

(* GLX_MESA_set_3dfx_mode *)
  GLX_3DFX_WINDOW_MODE_MESA = $1;
  GLX_3DFX_FULLSCREEN_MODE_MESA = $2;

(* GLX_NV_float_buffer *)
  GLX_FLOAT_COMPONENTS_NV = $20B0;

(* GLX_NV_multigpu_context *)
  GLX_CONTEXT_MULTIGPU_ATTRIB_NV = $20AA;
  GLX_CONTEXT_MULTIGPU_ATTRIB_SINGLE_NV = $20AB;
  GLX_CONTEXT_MULTIGPU_ATTRIB_AFR_NV = $20AC;
  GLX_CONTEXT_MULTIGPU_ATTRIB_MULTICAST_NV = $20AD;
  GLX_CONTEXT_MULTIGPU_ATTRIB_MULTI_DISPLAY_MULTICAST_NV = $20AE;

(* GLX_NV_multisample_coverage *)
  GLX_COVERAGE_SAMPLES_NV = 100001;
  GLX_COLOR_SAMPLES_NV = $20B3;

(* GLX_NV_present_video *)
  GLX_NUM_VIDEO_SLOTS_NV = $20F0;

(* GLX_NV_robustness_video_memory_purge *)
  GLX_GENERATE_RESET_ON_VIDEO_MEMORY_PURGE_NV = $20F7;

(* GLX_NV_video_capture *)
  GLX_DEVICE_ID_NV = $20CD;
  GLX_UNIQUE_ID_NV = $20CE;
  GLX_NUM_VIDEO_CAPTURE_SLOTS_NV = $20CF;

(* GLX_NV_video_out *)
  GLX_VIDEO_OUT_COLOR_NV = $20C3;
  GLX_VIDEO_OUT_ALPHA_NV = $20C4;
  GLX_VIDEO_OUT_DEPTH_NV = $20C5;
  GLX_VIDEO_OUT_COLOR_AND_ALPHA_NV = $20C6;
  GLX_VIDEO_OUT_COLOR_AND_DEPTH_NV = $20C7;
  GLX_VIDEO_OUT_FRAME_NV = $20C8;
  GLX_VIDEO_OUT_FIELD_1_NV = $20C9;
  GLX_VIDEO_OUT_FIELD_2_NV = $20CA;
  GLX_VIDEO_OUT_STACKED_FIELDS_1_2_NV = $20CB;
  GLX_VIDEO_OUT_STACKED_FIELDS_2_1_NV = $20CC;

(* GLX_OML_swap_method *)
  GLX_SWAP_METHOD_OML = $8060;
  GLX_SWAP_EXCHANGE_OML = $8061;
  GLX_SWAP_COPY_OML = $8062;
  GLX_SWAP_UNDEFINED_OML = $8063;

(* GLX_SGIS_blended_overlay *)
  GLX_BLENDED_RGBA_SGIS = $8025;

(* GLX_SGIS_shared_multisample *)
  GLX_MULTISAMPLE_SUB_RECT_WIDTH_SGIS = $8026;
  GLX_MULTISAMPLE_SUB_RECT_HEIGHT_SGIS = $8027;

(* GLX_SGIX_dmbuffer *)
  GLX_DIGITAL_MEDIA_PBUFFER_SGIX = $8024;

(* GLX_SGIX_fbconfig *)
  GLX_WINDOW_BIT_SGIX = $00000001;
  GLX_PIXMAP_BIT_SGIX = $00000002;
  GLX_RGBA_BIT_SGIX = $00000001;
  GLX_COLOR_INDEX_BIT_SGIX = $00000002;
  GLX_DRAWABLE_TYPE_SGIX = $8010;
  GLX_RENDER_TYPE_SGIX = $8011;
  GLX_X_RENDERABLE_SGIX = $8012;
  GLX_FBCONFIG_ID_SGIX = $8013;
  GLX_RGBA_TYPE_SGIX = $8014;
  GLX_COLOR_INDEX_TYPE_SGIX = $8015;

(* GLX_SGIX_hyperpipe *)
  GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX = 80;
  GLX_BAD_HYPERPIPE_CONFIG_SGIX = 91;
  GLX_BAD_HYPERPIPE_SGIX = 92;
  GLX_HYPERPIPE_DISPLAY_PIPE_SGIX = $00000001;
  GLX_HYPERPIPE_RENDER_PIPE_SGIX = $00000002;
  GLX_PIPE_RECT_SGIX = $00000001;
  GLX_PIPE_RECT_LIMITS_SGIX = $00000002;
  GLX_HYPERPIPE_STEREO_SGIX = $00000003;
  GLX_HYPERPIPE_PIXEL_AVERAGE_SGIX = $00000004;
  GLX_HYPERPIPE_ID_SGIX = $8030;

(* GLX_SGIX_pbuffer *)
  GLX_PBUFFER_BIT_SGIX = $00000004;
  GLX_BUFFER_CLOBBER_MASK_SGIX = $08000000;
  GLX_FRONT_LEFT_BUFFER_BIT_SGIX = $00000001;
  GLX_FRONT_RIGHT_BUFFER_BIT_SGIX = $00000002;
  GLX_BACK_LEFT_BUFFER_BIT_SGIX = $00000004;
  GLX_BACK_RIGHT_BUFFER_BIT_SGIX = $00000008;
  GLX_AUX_BUFFERS_BIT_SGIX = $00000010;
  GLX_DEPTH_BUFFER_BIT_SGIX = $00000020;
  GLX_STENCIL_BUFFER_BIT_SGIX = $00000040;
  GLX_ACCUM_BUFFER_BIT_SGIX = $00000080;
  GLX_SAMPLE_BUFFERS_BIT_SGIX = $00000100;
  GLX_MAX_PBUFFER_WIDTH_SGIX = $8016;
  GLX_MAX_PBUFFER_HEIGHT_SGIX = $8017;
  GLX_MAX_PBUFFER_PIXELS_SGIX = $8018;
  GLX_OPTIMAL_PBUFFER_WIDTH_SGIX = $8019;
  GLX_OPTIMAL_PBUFFER_HEIGHT_SGIX = $801A;
  GLX_PRESERVED_CONTENTS_SGIX = $801B;
  GLX_LARGEST_PBUFFER_SGIX = $801C;
  GLX_WIDTH_SGIX = $801D;
  GLX_HEIGHT_SGIX = $801E;
  GLX_EVENT_MASK_SGIX = $801F;
  GLX_DAMAGED_SGIX = $8020;
  GLX_SAVED_SGIX = $8021;
  GLX_WINDOW_SGIX = $8022;
  GLX_PBUFFER_SGIX = $8023;

(* GLX_SGIX_video_resize *)
  GLX_SYNC_FRAME_SGIX = $00000000;
  GLX_SYNC_SWAP_SGIX = $00000001;

(* GLX_SGIX_visual_select_group *)
  GLX_VISUAL_SELECT_GROUP_SGIX = $8028;

(*******************************************************************************
*                                     end GLX                                  *
*******************************************************************************)
{$EndIf}

const
  // AccumOp
  GL_ACCUM                          = $0100;
  GL_LOAD                           = $0101;
  GL_RETURN                         = $0102;
  GL_MULT                           = $0103;
  GL_ADD                            = $0104;

  // AlphaFunction
  GL_NEVER                          = $0200;
  GL_LESS                           = $0201;
  GL_EQUAL                          = $0202;
  GL_LEQUAL                         = $0203;
  GL_GREATER                        = $0204;
  GL_NOTEQUAL                       = $0205;
  GL_GEQUAL                         = $0206;
  GL_ALWAYS                         = $0207;

  // AttribMask
  GL_CURRENT_BIT                    = $00000001;
  GL_POINT_BIT                      = $00000002;
  GL_LINE_BIT                       = $00000004;
  GL_POLYGON_BIT                    = $00000008;
  GL_POLYGON_STIPPLE_BIT            = $00000010;
  GL_PIXEL_MODE_BIT                 = $00000020;
  GL_LIGHTING_BIT                   = $00000040;
  GL_FOG_BIT                        = $00000080;
  GL_DEPTH_BUFFER_BIT               = $00000100;
  GL_ACCUM_BUFFER_BIT               = $00000200;
  GL_STENCIL_BUFFER_BIT             = $00000400;
  GL_VIEWPORT_BIT                   = $00000800;
  GL_TRANSFORM_BIT                  = $00001000;
  GL_ENABLE_BIT                     = $00002000;
  GL_COLOR_BUFFER_BIT               = $00004000;
  GL_HINT_BIT                       = $00008000;
  GL_EVAL_BIT                       = $00010000;
  GL_LIST_BIT                       = $00020000;
  GL_TEXTURE_BIT                    = $00040000;
  GL_SCISSOR_BIT                    = $00080000;
  GL_ALL_ATTRIB_BITS                = $000FFFFF;

  // BeginMode
  GL_POINTS                         = $0000;
  GL_LINES                          = $0001;
  GL_LINE_LOOP                      = $0002;
  GL_LINE_STRIP                     = $0003;
  GL_TRIANGLES                      = $0004;
  GL_TRIANGLE_STRIP                 = $0005;
  GL_TRIANGLE_FAN                   = $0006;
  GL_QUADS                          = $0007;
  GL_QUAD_STRIP                     = $0008;
  GL_POLYGON                        = $0009;

  // BlendingFactorDest
  GL_ZERO                           = 0;
  GL_ONE                            = 1;
  GL_SRC_COLOR                      = $0300;
  GL_ONE_MINUS_SRC_COLOR            = $0301;
  GL_SRC_ALPHA                      = $0302;
  GL_ONE_MINUS_SRC_ALPHA            = $0303;
  GL_DST_ALPHA                      = $0304;
  GL_ONE_MINUS_DST_ALPHA            = $0305;

  // BlendingFactorSrc
  GL_DST_COLOR                      = $0306;
  GL_ONE_MINUS_DST_COLOR            = $0307;
  GL_SRC_ALPHA_SATURATE             = $0308;

  // Boolean
  GL_TRUE                           = 1;
  GL_FALSE                          = 0;

  // ClipPlaneName
  GL_CLIP_PLANE0                    = $3000;
  GL_CLIP_PLANE1                    = $3001;
  GL_CLIP_PLANE2                    = $3002;
  GL_CLIP_PLANE3                    = $3003;
  GL_CLIP_PLANE4                    = $3004;
  GL_CLIP_PLANE5                    = $3005;

  // DataType
  GL_BYTE                           = $1400;
  GL_UNSIGNED_BYTE                  = $1401;
  GL_SHORT                          = $1402;
  GL_UNSIGNED_SHORT                 = $1403;
  GL_INT                            = $1404;
  GL_UNSIGNED_INT                   = $1405;
  GL_FLOAT                          = $1406;
  GL_2_BYTES                        = $1407;
  GL_3_BYTES                        = $1408;
  GL_4_BYTES                        = $1409;
  GL_DOUBLE                         = $140A;

  // DrawBufferMode
  GL_NONE                           = 0;
  GL_FRONT_LEFT                     = $0400;
  GL_FRONT_RIGHT                    = $0401;
  GL_BACK_LEFT                      = $0402;
  GL_BACK_RIGHT                     = $0403;
  GL_FRONT                          = $0404;
  GL_BACK                           = $0405;
  GL_LEFT                           = $0406;
  GL_RIGHT                          = $0407;
  GL_FRONT_AND_BACK                 = $0408;
  GL_AUX0                           = $0409;
  GL_AUX1                           = $040A;
  GL_AUX2                           = $040B;
  GL_AUX3                           = $040C;

  // ErrorCode
  GL_NO_ERROR                       = 0;
  GL_INVALID_ENUM                   = $0500;
  GL_INVALID_VALUE                  = $0501;
  GL_INVALID_OPERATION              = $0502;
  GL_STACK_OVERFLOW                 = $0503;
  GL_STACK_UNDERFLOW                = $0504;
  GL_OUT_OF_MEMORY                  = $0505;

  // FeedBackMode
  GL_2D                             = $0600;
  GL_3D                             = $0601;
  GL_3D_COLOR                       = $0602;
  GL_3D_COLOR_TEXTURE               = $0603;
  GL_4D_COLOR_TEXTURE               = $0604;

  // FeedBackToken
  GL_PASS_THROUGH_TOKEN             = $0700;
  GL_POINT_TOKEN                    = $0701;
  GL_LINE_TOKEN                     = $0702;
  GL_POLYGON_TOKEN                  = $0703;
  GL_BITMAP_TOKEN                   = $0704;
  GL_DRAW_PIXEL_TOKEN               = $0705;
  GL_COPY_PIXEL_TOKEN               = $0706;
  GL_LINE_RESET_TOKEN               = $0707;

  // FogMode
  GL_EXP                            = $0800;
  GL_EXP2                           = $0801;

  // FrontFaceDirection
  GL_CW                             = $0900;
  GL_CCW                            = $0901;

  // GetMapTarget
  GL_COEFF                          = $0A00;
  GL_ORDER                          = $0A01;
  GL_DOMAIN                         = $0A02;

  // GetTarget
  GL_CURRENT_COLOR                  = $0B00;
  GL_CURRENT_INDEX                  = $0B01;
  GL_CURRENT_NORMAL                 = $0B02;
  GL_CURRENT_TEXTURE_COORDS         = $0B03;
  GL_CURRENT_RASTER_COLOR           = $0B04;
  GL_CURRENT_RASTER_INDEX           = $0B05;
  GL_CURRENT_RASTER_TEXTURE_COORDS  = $0B06;
  GL_CURRENT_RASTER_POSITION        = $0B07;
  GL_CURRENT_RASTER_POSITION_VALID  = $0B08;
  GL_CURRENT_RASTER_DISTANCE        = $0B09;
  GL_POINT_SMOOTH                   = $0B10;
  GL_POINT_SIZE                     = $0B11;
  GL_POINT_SIZE_RANGE               = $0B12;
  GL_POINT_SIZE_GRANULARITY         = $0B13;
  GL_LINE_SMOOTH                    = $0B20;
  GL_LINE_WIDTH                     = $0B21;
  GL_LINE_WIDTH_RANGE               = $0B22;
  GL_LINE_WIDTH_GRANULARITY         = $0B23;
  GL_LINE_STIPPLE                   = $0B24;
  GL_LINE_STIPPLE_PATTERN           = $0B25;
  GL_LINE_STIPPLE_REPEAT            = $0B26;
  GL_LIST_MODE                      = $0B30;
  GL_MAX_LIST_NESTING               = $0B31;
  GL_LIST_BASE                      = $0B32;
  GL_LIST_INDEX                     = $0B33;
  GL_POLYGON_MODE                   = $0B40;
  GL_POLYGON_SMOOTH                 = $0B41;
  GL_POLYGON_STIPPLE                = $0B42;
  GL_EDGE_FLAG                      = $0B43;
  GL_CULL_FACE                      = $0B44;
  GL_CULL_FACE_MODE                 = $0B45;
  GL_FRONT_FACE                     = $0B46;
  GL_LIGHTING                       = $0B50;
  GL_LIGHT_MODEL_LOCAL_VIEWER       = $0B51;
  GL_LIGHT_MODEL_TWO_SIDE           = $0B52;
  GL_LIGHT_MODEL_AMBIENT            = $0B53;
  GL_SHADE_MODEL                    = $0B54;
  GL_COLOR_MATERIAL_FACE            = $0B55;
  GL_COLOR_MATERIAL_PARAMETER       = $0B56;
  GL_COLOR_MATERIAL                 = $0B57;
  GL_FOG                            = $0B60;
  GL_FOG_INDEX                      = $0B61;
  GL_FOG_DENSITY                    = $0B62;
  GL_FOG_START                      = $0B63;
  GL_FOG_END                        = $0B64;
  GL_FOG_MODE                       = $0B65;
  GL_FOG_COLOR                      = $0B66;
  GL_DEPTH_RANGE                    = $0B70;
  GL_DEPTH_TEST                     = $0B71;
  GL_DEPTH_WRITEMASK                = $0B72;
  GL_DEPTH_CLEAR_VALUE              = $0B73;
  GL_DEPTH_FUNC                     = $0B74;
  GL_ACCUM_CLEAR_VALUE              = $0B80;
  GL_STENCIL_TEST                   = $0B90;
  GL_STENCIL_CLEAR_VALUE            = $0B91;
  GL_STENCIL_FUNC                   = $0B92;
  GL_STENCIL_VALUE_MASK             = $0B93;
  GL_STENCIL_FAIL                   = $0B94;
  GL_STENCIL_PASS_DEPTH_FAIL        = $0B95;
  GL_STENCIL_PASS_DEPTH_PASS        = $0B96;
  GL_STENCIL_REF                    = $0B97;
  GL_STENCIL_WRITEMASK              = $0B98;
  GL_MATRIX_MODE                    = $0BA0;
  GL_NORMALIZE                      = $0BA1;
  GL_VIEWPORT                       = $0BA2;
  GL_MODELVIEW_STACK_DEPTH          = $0BA3;
  GL_PROJECTION_STACK_DEPTH         = $0BA4;
  GL_TEXTURE_STACK_DEPTH            = $0BA5;
  GL_MODELVIEW_MATRIX               = $0BA6;
  GL_PROJECTION_MATRIX              = $0BA7;
  GL_TEXTURE_MATRIX                 = $0BA8;
  GL_ATTRIB_STACK_DEPTH             = $0BB0;
  GL_CLIENT_ATTRIB_STACK_DEPTH      = $0BB1;
  GL_ALPHA_TEST                     = $0BC0;
  GL_ALPHA_TEST_FUNC                = $0BC1;
  GL_ALPHA_TEST_REF                 = $0BC2;
  GL_DITHER                         = $0BD0;
  GL_BLEND_DST                      = $0BE0;
  GL_BLEND_SRC                      = $0BE1;
  GL_BLEND                          = $0BE2;
  GL_LOGIC_OP_MODE                  = $0BF0;
  GL_INDEX_LOGIC_OP                 = $0BF1;
  GL_COLOR_LOGIC_OP                 = $0BF2;
  GL_AUX_BUFFERS                    = $0C00;
  GL_DRAW_BUFFER                    = $0C01;
  GL_READ_BUFFER                    = $0C02;
  GL_SCISSOR_BOX                    = $0C10;
  GL_SCISSOR_TEST                   = $0C11;
  GL_INDEX_CLEAR_VALUE              = $0C20;
  GL_INDEX_WRITEMASK                = $0C21;
  GL_COLOR_CLEAR_VALUE              = $0C22;
  GL_COLOR_WRITEMASK                = $0C23;
  GL_INDEX_MODE                     = $0C30;
  GL_RGBA_MODE                      = $0C31;
  GL_DOUBLEBUFFER                   = $0C32;
  GL_STEREO                         = $0C33;
  GL_RENDER_MODE                    = $0C40;
  GL_PERSPECTIVE_CORRECTION_HINT    = $0C50;
  GL_POINT_SMOOTH_HINT              = $0C51;
  GL_LINE_SMOOTH_HINT               = $0C52;
  GL_POLYGON_SMOOTH_HINT            = $0C53;
  GL_FOG_HINT                       = $0C54;
  GL_TEXTURE_GEN_S                  = $0C60;
  GL_TEXTURE_GEN_T                  = $0C61;
  GL_TEXTURE_GEN_R                  = $0C62;
  GL_TEXTURE_GEN_Q                  = $0C63;
  GL_PIXEL_MAP_I_TO_I               = $0C70;
  GL_PIXEL_MAP_S_TO_S               = $0C71;
  GL_PIXEL_MAP_I_TO_R               = $0C72;
  GL_PIXEL_MAP_I_TO_G               = $0C73;
  GL_PIXEL_MAP_I_TO_B               = $0C74;
  GL_PIXEL_MAP_I_TO_A               = $0C75;
  GL_PIXEL_MAP_R_TO_R               = $0C76;
  GL_PIXEL_MAP_G_TO_G               = $0C77;
  GL_PIXEL_MAP_B_TO_B               = $0C78;
  GL_PIXEL_MAP_A_TO_A               = $0C79;
  GL_PIXEL_MAP_I_TO_I_SIZE          = $0CB0;
  GL_PIXEL_MAP_S_TO_S_SIZE          = $0CB1;
  GL_PIXEL_MAP_I_TO_R_SIZE          = $0CB2;
  GL_PIXEL_MAP_I_TO_G_SIZE          = $0CB3;
  GL_PIXEL_MAP_I_TO_B_SIZE          = $0CB4;
  GL_PIXEL_MAP_I_TO_A_SIZE          = $0CB5;
  GL_PIXEL_MAP_R_TO_R_SIZE          = $0CB6;
  GL_PIXEL_MAP_G_TO_G_SIZE          = $0CB7;
  GL_PIXEL_MAP_B_TO_B_SIZE          = $0CB8;
  GL_PIXEL_MAP_A_TO_A_SIZE          = $0CB9;
  GL_UNPACK_SWAP_BYTES              = $0CF0;
  GL_UNPACK_LSB_FIRST               = $0CF1;
  GL_UNPACK_ROW_LENGTH              = $0CF2;
  GL_UNPACK_SKIP_ROWS               = $0CF3;
  GL_UNPACK_SKIP_PIXELS             = $0CF4;
  GL_UNPACK_ALIGNMENT               = $0CF5;
  GL_PACK_SWAP_BYTES                = $0D00;
  GL_PACK_LSB_FIRST                 = $0D01;
  GL_PACK_ROW_LENGTH                = $0D02;
  GL_PACK_SKIP_ROWS                 = $0D03;
  GL_PACK_SKIP_PIXELS               = $0D04;
  GL_PACK_ALIGNMENT                 = $0D05;
  GL_MAP_COLOR                      = $0D10;
  GL_MAP_STENCIL                    = $0D11;
  GL_INDEX_SHIFT                    = $0D12;
  GL_INDEX_OFFSET                   = $0D13;
  GL_RED_SCALE                      = $0D14;
  GL_RED_BIAS                       = $0D15;
  GL_ZOOM_X                         = $0D16;
  GL_ZOOM_Y                         = $0D17;
  GL_GREEN_SCALE                    = $0D18;
  GL_GREEN_BIAS                     = $0D19;
  GL_BLUE_SCALE                     = $0D1A;
  GL_BLUE_BIAS                      = $0D1B;
  GL_ALPHA_SCALE                    = $0D1C;
  GL_ALPHA_BIAS                     = $0D1D;
  GL_DEPTH_SCALE                    = $0D1E;
  GL_DEPTH_BIAS                     = $0D1F;
  GL_MAX_EVAL_ORDER                 = $0D30;
  GL_MAX_LIGHTS                     = $0D31;
  GL_MAX_CLIP_PLANES                = $0D32;
  GL_MAX_TEXTURE_SIZE               = $0D33;
  GL_MAX_PIXEL_MAP_TABLE            = $0D34;
  GL_MAX_ATTRIB_STACK_DEPTH         = $0D35;
  GL_MAX_MODELVIEW_STACK_DEPTH      = $0D36;
  GL_MAX_NAME_STACK_DEPTH           = $0D37;
  GL_MAX_PROJECTION_STACK_DEPTH     = $0D38;
  GL_MAX_TEXTURE_STACK_DEPTH        = $0D39;
  GL_MAX_VIEWPORT_DIMS              = $0D3A;
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH  = $0D3B;
  GL_SUBPIXEL_BITS                  = $0D50;
  GL_INDEX_BITS                     = $0D51;
  GL_RED_BITS                       = $0D52;
  GL_GREEN_BITS                     = $0D53;
  GL_BLUE_BITS                      = $0D54;
  GL_ALPHA_BITS                     = $0D55;
  GL_DEPTH_BITS                     = $0D56;
  GL_STENCIL_BITS                   = $0D57;
  GL_ACCUM_RED_BITS                 = $0D58;
  GL_ACCUM_GREEN_BITS               = $0D59;
  GL_ACCUM_BLUE_BITS                = $0D5A;
  GL_ACCUM_ALPHA_BITS               = $0D5B;
  GL_NAME_STACK_DEPTH               = $0D70;
  GL_AUTO_NORMAL                    = $0D80;
  GL_MAP1_COLOR_4                   = $0D90;
  GL_MAP1_INDEX                     = $0D91;
  GL_MAP1_NORMAL                    = $0D92;
  GL_MAP1_TEXTURE_COORD_1           = $0D93;
  GL_MAP1_TEXTURE_COORD_2           = $0D94;
  GL_MAP1_TEXTURE_COORD_3           = $0D95;
  GL_MAP1_TEXTURE_COORD_4           = $0D96;
  GL_MAP1_VERTEX_3                  = $0D97;
  GL_MAP1_VERTEX_4                  = $0D98;
  GL_MAP2_COLOR_4                   = $0DB0;
  GL_MAP2_INDEX                     = $0DB1;
  GL_MAP2_NORMAL                    = $0DB2;
  GL_MAP2_TEXTURE_COORD_1           = $0DB3;
  GL_MAP2_TEXTURE_COORD_2           = $0DB4;
  GL_MAP2_TEXTURE_COORD_3           = $0DB5;
  GL_MAP2_TEXTURE_COORD_4           = $0DB6;
  GL_MAP2_VERTEX_3                  = $0DB7;
  GL_MAP2_VERTEX_4                  = $0DB8;
  GL_MAP1_GRID_DOMAIN               = $0DD0;
  GL_MAP1_GRID_SEGMENTS             = $0DD1;
  GL_MAP2_GRID_DOMAIN               = $0DD2;
  GL_MAP2_GRID_SEGMENTS             = $0DD3;
  GL_TEXTURE_1D                     = $0DE0;
  GL_TEXTURE_2D                     = $0DE1;
  GL_FEEDBACK_BUFFER_POINTER        = $0DF0;
  GL_FEEDBACK_BUFFER_SIZE           = $0DF1;
  GL_FEEDBACK_BUFFER_TYPE           = $0DF2;
  GL_SELECTION_BUFFER_POINTER       = $0DF3;
  GL_SELECTION_BUFFER_SIZE          = $0DF4;

  // GetTextureParameter
  GL_TEXTURE_WIDTH                  = $1000;
  GL_TEXTURE_HEIGHT                 = $1001;
  GL_TEXTURE_INTERNAL_FORMAT        = $1003;
  GL_TEXTURE_BORDER_COLOR           = $1004;
  GL_TEXTURE_BORDER                 = $1005;

  // HintMode
  GL_DONT_CARE                      = $1100;
  GL_FASTEST                        = $1101;
  GL_NICEST                         = $1102;

  // LightName
  GL_LIGHT0                         = $4000;
  GL_LIGHT1                         = $4001;
  GL_LIGHT2                         = $4002;
  GL_LIGHT3                         = $4003;
  GL_LIGHT4                         = $4004;
  GL_LIGHT5                         = $4005;
  GL_LIGHT6                         = $4006;
  GL_LIGHT7                         = $4007;

  // LightParameter
  GL_AMBIENT                        = $1200;
  GL_DIFFUSE                        = $1201;
  GL_SPECULAR                       = $1202;
  GL_POSITION                       = $1203;
  GL_SPOT_DIRECTION                 = $1204;
  GL_SPOT_EXPONENT                  = $1205;
  GL_SPOT_CUTOFF                    = $1206;
  GL_CONSTANT_ATTENUATION           = $1207;
  GL_LINEAR_ATTENUATION             = $1208;
  GL_QUADRATIC_ATTENUATION          = $1209;

  // ListMode
  GL_COMPILE                        = $1300;
  GL_COMPILE_AND_EXECUTE            = $1301;

  // LogicOp
  GL_CLEAR                          = $1500;
  GL_AND                            = $1501;
  GL_AND_REVERSE                    = $1502;
  GL_COPY                           = $1503;
  GL_AND_INVERTED                   = $1504;
  GL_NOOP                           = $1505;
  GL_XOR                            = $1506;
  GL_OR                             = $1507;
  GL_NOR                            = $1508;
  GL_EQUIV                          = $1509;
  GL_INVERT                         = $150A;
  GL_OR_REVERSE                     = $150B;
  GL_COPY_INVERTED                  = $150C;
  GL_OR_INVERTED                    = $150D;
  GL_NAND                           = $150E;
  GL_SET                            = $150F;

  // MaterialParameter
  GL_EMISSION                       = $1600;
  GL_SHININESS                      = $1601;
  GL_AMBIENT_AND_DIFFUSE            = $1602;
  GL_COLOR_INDEXES                  = $1603;

  // MatrixMode
  GL_MODELVIEW                      = $1700;
  GL_PROJECTION                     = $1701;
  GL_TEXTURE                        = $1702;

  // PixelCopyType
  GL_COLOR                          = $1800;
  GL_DEPTH                          = $1801;
  GL_STENCIL                        = $1802;

  // PixelFormat
  GL_COLOR_INDEX                    = $1900;
  GL_STENCIL_INDEX                  = $1901;
  GL_DEPTH_COMPONENT                = $1902;
  GL_RED                            = $1903;
  GL_GREEN                          = $1904;
  GL_BLUE                           = $1905;
  GL_ALPHA                          = $1906;
  GL_RGB                            = $1907;
  GL_RGBA                           = $1908;
  GL_LUMINANCE                      = $1909;
  GL_LUMINANCE_ALPHA                = $190A;

  // PixelType
  GL_BITMAP                         = $1A00;

  // PolygonMode
  GL_POINT                          = $1B00;
  GL_LINE                           = $1B01;
  GL_FILL                           = $1B02;

  // RenderingMode
  GL_RENDER                         = $1C00;
  GL_FEEDBACK                       = $1C01;
  GL_SELECT                         = $1C02;

  // ShadingModel
  GL_FLAT                           = $1D00;
  GL_SMOOTH                         = $1D01;

  // StencilOp
  GL_KEEP                           = $1E00;
  GL_REPLACE                        = $1E01;
  GL_INCR                           = $1E02;
  GL_DECR                           = $1E03;

  // StringName
  GL_VENDOR                         = $1F00;
  GL_RENDERER                       = $1F01;
  GL_VERSION                        = $1F02;
  GL_EXTENSIONS                     = $1F03;

  // TextureCoordName
  GL_S                              = $2000;
  GL_T                              = $2001;
  GL_R                              = $2002;
  GL_Q                              = $2003;

  // TextureEnvMode
  GL_MODULATE                       = $2100;
  GL_DECAL                          = $2101;

  // TextureEnvParameter
  GL_TEXTURE_ENV_MODE               = $2200;
  GL_TEXTURE_ENV_COLOR              = $2201;

  // TextureEnvTarget
  GL_TEXTURE_ENV                    = $2300;

  // TextureGenMode
  GL_EYE_LINEAR                     = $2400;
  GL_OBJECT_LINEAR                  = $2401;
  GL_SPHERE_MAP                     = $2402;

  // TextureGenParameter
  GL_TEXTURE_GEN_MODE               = $2500;
  GL_OBJECT_PLANE                   = $2501;
  GL_EYE_PLANE                      = $2502;

  // TextureMagFilter
  GL_NEAREST                        = $2600;
  GL_LINEAR                         = $2601;

  // TextureMinFilter
  GL_NEAREST_MIPMAP_NEAREST         = $2700;
  GL_LINEAR_MIPMAP_NEAREST          = $2701;
  GL_NEAREST_MIPMAP_LINEAR          = $2702;
  GL_LINEAR_MIPMAP_LINEAR           = $2703;

  // TextureParameterName
  GL_TEXTURE_MAG_FILTER             = $2800;
  GL_TEXTURE_MIN_FILTER             = $2801;
  GL_TEXTURE_WRAP_S                 = $2802;
  GL_TEXTURE_WRAP_T                 = $2803;

  // TextureWrapMode
  GL_CLAMP                          = $2900;
  GL_REPEAT                         = $2901;

  // ClientAttribMask
  GL_CLIENT_PIXEL_STORE_BIT         = $00000001;
  GL_CLIENT_VERTEX_ARRAY_BIT        = $00000002;
  GL_CLIENT_ALL_ATTRIB_BITS         = $FFFFFFFF;

  // polygon_offset
  GL_POLYGON_OFFSET_FACTOR          = $8038;
  GL_POLYGON_OFFSET_UNITS           = $2A00;
  GL_POLYGON_OFFSET_POINT           = $2A01;
  GL_POLYGON_OFFSET_LINE            = $2A02;
  GL_POLYGON_OFFSET_FILL            = $8037;

  // texture
  GL_ALPHA4                         = $803B;
  GL_ALPHA8                         = $803C;
  GL_ALPHA12                        = $803D;
  GL_ALPHA16                        = $803E;
  GL_LUMINANCE4                     = $803F;
  GL_LUMINANCE8                     = $8040;
  GL_LUMINANCE12                    = $8041;
  GL_LUMINANCE16                    = $8042;
  GL_LUMINANCE4_ALPHA4              = $8043;
  GL_LUMINANCE6_ALPHA2              = $8044;
  GL_LUMINANCE8_ALPHA8              = $8045;
  GL_LUMINANCE12_ALPHA4             = $8046;
  GL_LUMINANCE12_ALPHA12            = $8047;
  GL_LUMINANCE16_ALPHA16            = $8048;
  GL_INTENSITY                      = $8049;
  GL_INTENSITY4                     = $804A;
  GL_INTENSITY8                     = $804B;
  GL_INTENSITY12                    = $804C;
  GL_INTENSITY16                    = $804D;
  GL_R3_G3_B2                       = $2A10;
  GL_RGB4                           = $804F;
  GL_RGB5                           = $8050;
  GL_RGB8                           = $8051;
  GL_RGB10                          = $8052;
  GL_RGB12                          = $8053;
  GL_RGB16                          = $8054;
  GL_RGBA2                          = $8055;
  GL_RGBA4                          = $8056;
  GL_RGB5_A1                        = $8057;
  GL_RGBA8                          = $8058;
  GL_RGB10_A2                       = $8059;
  GL_RGBA12                         = $805A;
  GL_RGBA16                         = $805B;
  GL_TEXTURE_RED_SIZE               = $805C;
  GL_TEXTURE_GREEN_SIZE             = $805D;
  GL_TEXTURE_BLUE_SIZE              = $805E;
  GL_TEXTURE_ALPHA_SIZE             = $805F;
  GL_TEXTURE_LUMINANCE_SIZE         = $8060;
  GL_TEXTURE_INTENSITY_SIZE         = $8061;
  GL_PROXY_TEXTURE_1D               = $8063;
  GL_PROXY_TEXTURE_2D               = $8064;

  // texture_object
  GL_TEXTURE_PRIORITY               = $8066;
  GL_TEXTURE_RESIDENT               = $8067;
  GL_TEXTURE_BINDING_1D             = $8068;
  GL_TEXTURE_BINDING_2D             = $8069;

  // vertex_array
  GL_VERTEX_ARRAY                   = $8074;
  GL_NORMAL_ARRAY                   = $8075;
  GL_COLOR_ARRAY                    = $8076;
  GL_INDEX_ARRAY                    = $8077;
  GL_TEXTURE_COORD_ARRAY            = $8078;
  GL_EDGE_FLAG_ARRAY                = $8079;
  GL_VERTEX_ARRAY_SIZE              = $807A;
  GL_VERTEX_ARRAY_TYPE              = $807B;
  GL_VERTEX_ARRAY_STRIDE            = $807C;
  GL_NORMAL_ARRAY_TYPE              = $807E;
  GL_NORMAL_ARRAY_STRIDE            = $807F;
  GL_COLOR_ARRAY_SIZE               = $8081;
  GL_COLOR_ARRAY_TYPE               = $8082;
  GL_COLOR_ARRAY_STRIDE             = $8083;
  GL_INDEX_ARRAY_TYPE               = $8085;
  GL_INDEX_ARRAY_STRIDE             = $8086;
  GL_TEXTURE_COORD_ARRAY_SIZE       = $8088;
  GL_TEXTURE_COORD_ARRAY_TYPE       = $8089;
  GL_TEXTURE_COORD_ARRAY_STRIDE     = $808A;
  GL_EDGE_FLAG_ARRAY_STRIDE         = $808C;
  GL_VERTEX_ARRAY_POINTER           = $808E;
  GL_NORMAL_ARRAY_POINTER           = $808F;
  GL_COLOR_ARRAY_POINTER            = $8090;
  GL_INDEX_ARRAY_POINTER            = $8091;
  GL_TEXTURE_COORD_ARRAY_POINTER    = $8092;
  GL_EDGE_FLAG_ARRAY_POINTER        = $8093;
  GL_V2F                            = $2A20;
  GL_V3F                            = $2A21;
  GL_C4UB_V2F                       = $2A22;
  GL_C4UB_V3F                       = $2A23;
  GL_C3F_V3F                        = $2A24;
  GL_N3F_V3F                        = $2A25;
  GL_C4F_N3F_V3F                    = $2A26;
  GL_T2F_V3F                        = $2A27;
  GL_T4F_V4F                        = $2A28;
  GL_T2F_C4UB_V3F                   = $2A29;
  GL_T2F_C3F_V3F                    = $2A2A;
  GL_T2F_N3F_V3F                    = $2A2B;
  GL_T2F_C4F_N3F_V3F                = $2A2C;
  GL_T4F_C4F_N3F_V4F                = $2A2D;
  // For compatibility with OpenGL v1.0
  GL_LOGIC_OP                       = GL_INDEX_LOGIC_OP;
  GL_TEXTURE_COMPONENTS             = GL_TEXTURE_INTERNAL_FORMAT;
(*******************************************************************************
*                         end deprecated                                       *
*******************************************************************************)

  //GL_VERSION_1_2
  GL_UNSIGNED_BYTE_3_3_2 = $8032;
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;
  GL_UNSIGNED_INT_8_8_8_8 = $8035;
  GL_UNSIGNED_INT_10_10_10_2 = $8036;
  GL_TEXTURE_BINDING_3D = $806A;
  GL_PACK_SKIP_IMAGES = $806B;
  GL_PACK_IMAGE_HEIGHT = $806C;
  GL_UNPACK_SKIP_IMAGES = $806D;
  GL_UNPACK_IMAGE_HEIGHT = $806E;
  GL_TEXTURE_3D = $806F;
  GL_PROXY_TEXTURE_3D = $8070;
  GL_TEXTURE_DEPTH = $8071;
  GL_TEXTURE_WRAP_R = $8072;
  GL_MAX_3D_TEXTURE_SIZE = $8073;
  GL_UNSIGNED_BYTE_2_3_3_REV = $8362;
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;
  GL_UNSIGNED_INT_8_8_8_8_REV = $8367;
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;
  GL_BGR = $80E0;
  GL_BGRA = $80E1;
  GL_MAX_ELEMENTS_VERTICES = $80E8;
  GL_MAX_ELEMENTS_INDICES = $80E9;
  GL_CLAMP_TO_EDGE = $812F;
  GL_TEXTURE_MIN_LOD = $813A;
  GL_TEXTURE_MAX_LOD = $813B;
  GL_TEXTURE_BASE_LEVEL = $813C;
  GL_TEXTURE_MAX_LEVEL = $813D;
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;
  GL_SMOOTH_POINT_SIZE_GRANULARITY = $0B13;
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = $0B23;
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;
  // glext + GL_VERSION_1_2
  GL_RESCALE_NORMAL = $803A;
  GL_LIGHT_MODEL_COLOR_CONTROL = $81F8;
  GL_SINGLE_COLOR = $81F9;
  GL_SEPARATE_SPECULAR_COLOR = $81FA;
  GL_ALIASED_POINT_SIZE_RANGE = $846D;

  // GL_VERSION_1_3
  GL_TEXTURE0 = $84C0;
  GL_TEXTURE1 = $84C1;
  GL_TEXTURE2 = $84C2;
  GL_TEXTURE3 = $84C3;
  GL_TEXTURE4 = $84C4;
  GL_TEXTURE5 = $84C5;
  GL_TEXTURE6 = $84C6;
  GL_TEXTURE7 = $84C7;
  GL_TEXTURE8 = $84C8;
  GL_TEXTURE9 = $84C9;
  GL_TEXTURE10 = $84CA;
  GL_TEXTURE11 = $84CB;
  GL_TEXTURE12 = $84CC;
  GL_TEXTURE13 = $84CD;
  GL_TEXTURE14 = $84CE;
  GL_TEXTURE15 = $84CF;
  GL_TEXTURE16 = $84D0;
  GL_TEXTURE17 = $84D1;
  GL_TEXTURE18 = $84D2;
  GL_TEXTURE19 = $84D3;
  GL_TEXTURE20 = $84D4;
  GL_TEXTURE21 = $84D5;
  GL_TEXTURE22 = $84D6;
  GL_TEXTURE23 = $84D7;
  GL_TEXTURE24 = $84D8;
  GL_TEXTURE25 = $84D9;
  GL_TEXTURE26 = $84DA;
  GL_TEXTURE27 = $84DB;
  GL_TEXTURE28 = $84DC;
  GL_TEXTURE29 = $84DD;
  GL_TEXTURE30 = $84DE;
  GL_TEXTURE31 = $84DF;
  GL_ACTIVE_TEXTURE = $84E0;
  GL_MULTISAMPLE = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;
  GL_SAMPLE_ALPHA_TO_ONE = $809F;
  GL_SAMPLE_COVERAGE = $80A0;
  GL_SAMPLE_BUFFERS = $80A8;
  GL_SAMPLES = $80A9;
  GL_SAMPLE_COVERAGE_VALUE = $80AA;
  GL_SAMPLE_COVERAGE_INVERT = $80AB;
  GL_TEXTURE_CUBE_MAP = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A;
  GL_PROXY_TEXTURE_CUBE_MAP = $851B;
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = $851C;
  GL_COMPRESSED_RGB = $84ED;
  GL_COMPRESSED_RGBA = $84EE;
  GL_TEXTURE_COMPRESSION_HINT = $84EF;
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0;
  GL_TEXTURE_COMPRESSED = $86A1;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;
  GL_CLAMP_TO_BORDER = $812D;
  // glext + GL_VERSION_1_3
  GL_CLIENT_ACTIVE_TEXTURE = $84E1;
  GL_MAX_TEXTURE_UNITS = $84E2;
  GL_TRANSPOSE_MODELVIEW_MATRIX = $84E3;
  GL_TRANSPOSE_PROJECTION_MATRIX = $84E4;
  GL_TRANSPOSE_TEXTURE_MATRIX = $84E5;
  GL_TRANSPOSE_COLOR_MATRIX = $84E6;
  GL_MULTISAMPLE_BIT = $20000000;
  GL_NORMAL_MAP = $8511;
  GL_REFLECTION_MAP = $8512;
  GL_COMPRESSED_ALPHA = $84E9;
  GL_COMPRESSED_LUMINANCE = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;
  GL_COMPRESSED_INTENSITY = $84EC;
  GL_COMBINE = $8570;
  GL_COMBINE_RGB = $8571;
  GL_COMBINE_ALPHA = $8572;
  GL_SOURCE0_RGB = $8580;
  GL_SOURCE1_RGB = $8581;
  GL_SOURCE2_RGB = $8582;
  GL_SOURCE0_ALPHA = $8588;
  GL_SOURCE1_ALPHA = $8589;
  GL_SOURCE2_ALPHA = $858A;
  GL_OPERAND0_RGB = $8590;
  GL_OPERAND1_RGB = $8591;
  GL_OPERAND2_RGB = $8592;
  GL_OPERAND0_ALPHA = $8598;
  GL_OPERAND1_ALPHA = $8599;
  GL_OPERAND2_ALPHA = $859A;
  GL_RGB_SCALE = $8573;
  GL_ADD_SIGNED = $8574;
  GL_INTERPOLATE = $8575;
  GL_SUBTRACT = $84E7;
  GL_CONSTANT = $8576;
  GL_PRIMARY_COLOR = $8577;
  GL_PREVIOUS = $8578;
  GL_DOT3_RGB = $86AE;
  GL_DOT3_RGBA = $86AF;

  // GL_VERSION_1_4
  GL_BLEND_DST_RGB = $80C8;
  GL_BLEND_SRC_RGB = $80C9;
  GL_BLEND_DST_ALPHA = $80CA;
  GL_BLEND_SRC_ALPHA = $80CB;
  GL_POINT_FADE_THRESHOLD_SIZE = $8128;
  GL_DEPTH_COMPONENT16 = $81A5;
  GL_DEPTH_COMPONENT24 = $81A6;
  GL_DEPTH_COMPONENT32 = $81A7;
  GL_MIRRORED_REPEAT = $8370;
  GL_MAX_TEXTURE_LOD_BIAS = $84FD;
  GL_TEXTURE_LOD_BIAS = $8501;
  GL_INCR_WRAP = $8507;
  GL_DECR_WRAP = $8508;
  GL_TEXTURE_DEPTH_SIZE = $884A;
  GL_TEXTURE_COMPARE_MODE = $884C;
  GL_TEXTURE_COMPARE_FUNC = $884D;
  GL_BLEND_COLOR = $8005;
  GL_BLEND_EQUATION = $8009;
  GL_CONSTANT_COLOR = $8001;
  GL_ONE_MINUS_CONSTANT_COLOR = $8002;
  GL_CONSTANT_ALPHA = $8003;
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004;
  GL_FUNC_ADD = $8006;
  GL_FUNC_REVERSE_SUBTRACT = $800B;
  GL_FUNC_SUBTRACT = $800A;
  GL_MIN = $8007;
  GL_MAX = $8008;
  // glext + GL_VERSION_1_4
  GL_POINT_SIZE_MIN = $8126;
  GL_POINT_SIZE_MAX = $8127;
  GL_POINT_DISTANCE_ATTENUATION = $8129;
  GL_GENERATE_MIPMAP = $8191;
  GL_GENERATE_MIPMAP_HINT = $8192;
  GL_FOG_COORDINATE_SOURCE = $8450;
  GL_FOG_COORDINATE = $8451;
  GL_FRAGMENT_DEPTH = $8452;
  GL_CURRENT_FOG_COORDINATE = $8453;
  GL_FOG_COORDINATE_ARRAY_TYPE = $8454;
  GL_FOG_COORDINATE_ARRAY_STRIDE = $8455;
  GL_FOG_COORDINATE_ARRAY_POINTER = $8456;
  GL_FOG_COORDINATE_ARRAY = $8457;
  GL_COLOR_SUM = $8458;
  GL_CURRENT_SECONDARY_COLOR = $8459;
  GL_SECONDARY_COLOR_ARRAY_SIZE = $845A;
  GL_SECONDARY_COLOR_ARRAY_TYPE = $845B;
  GL_SECONDARY_COLOR_ARRAY_STRIDE = $845C;
  GL_SECONDARY_COLOR_ARRAY_POINTER = $845D;
  GL_SECONDARY_COLOR_ARRAY = $845E;
  GL_TEXTURE_FILTER_CONTROL = $8500;
  GL_DEPTH_TEXTURE_MODE = $884B;
  GL_COMPARE_R_TO_TEXTURE = $884E;

  // GL_VERSION_1_5
  GL_BUFFER_SIZE = $8764;
  GL_BUFFER_USAGE = $8765;
  GL_QUERY_COUNTER_BITS = $8864;
  GL_CURRENT_QUERY = $8865;
  GL_QUERY_RESULT = $8866;
  GL_QUERY_RESULT_AVAILABLE = $8867;
  GL_ARRAY_BUFFER = $8892;
  GL_ELEMENT_ARRAY_BUFFER = $8893;
  GL_ARRAY_BUFFER_BINDING = $8894;
  GL_ELEMENT_ARRAY_BUFFER_BINDING = $8895;
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = $889F;
  GL_READ_ONLY = $88B8;
  GL_WRITE_ONLY = $88B9;
  GL_READ_WRITE = $88BA;
  GL_BUFFER_ACCESS = $88BB;
  GL_BUFFER_MAPPED = $88BC;
  GL_BUFFER_MAP_POINTER = $88BD;
  GL_STREAM_DRAW = $88E0;
  GL_STREAM_READ = $88E1;
  GL_STREAM_COPY = $88E2;
  GL_STATIC_DRAW = $88E4;
  GL_STATIC_READ = $88E5;
  GL_STATIC_COPY = $88E6;
  GL_DYNAMIC_DRAW = $88E8;
  GL_DYNAMIC_READ = $88E9;
  GL_DYNAMIC_COPY = $88EA;
  GL_SAMPLES_PASSED = $8914;
  GL_SRC1_ALPHA = $8589;
  // glext + GL_VERSION_1_5
  GL_VERTEX_ARRAY_BUFFER_BINDING = $8896;
  GL_NORMAL_ARRAY_BUFFER_BINDING = $8897;
  GL_COLOR_ARRAY_BUFFER_BINDING = $8898;
  GL_INDEX_ARRAY_BUFFER_BINDING = $8899;
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = $889B;
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = $889C;
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = $889D;
  GL_WEIGHT_ARRAY_BUFFER_BINDING = $889E;
  GL_FOG_COORD_SRC = $8450;
  GL_FOG_COORD = $8451;
  GL_CURRENT_FOG_COORD = $8453;
  GL_FOG_COORD_ARRAY_TYPE = $8454;
  GL_FOG_COORD_ARRAY_STRIDE = $8455;
  GL_FOG_COORD_ARRAY_POINTER = $8456;
  GL_FOG_COORD_ARRAY = $8457;
  GL_FOG_COORD_ARRAY_BUFFER_BINDING = $889D;
  GL_SRC0_RGB = $8580;
  GL_SRC1_RGB = $8581;
  GL_SRC2_RGB = $8582;
  GL_SRC0_ALPHA = $8588;
  GL_SRC2_ALPHA = $858A;

  // GL_VERSION_2_0
  GL_BLEND_EQUATION_RGB = $8009;
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = $8622;
  GL_VERTEX_ATTRIB_ARRAY_SIZE = $8623;
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = $8624;
  GL_VERTEX_ATTRIB_ARRAY_TYPE = $8625;
  GL_CURRENT_VERTEX_ATTRIB = $8626;
  GL_VERTEX_PROGRAM_POINT_SIZE = $8642;
  GL_VERTEX_ATTRIB_ARRAY_POINTER = $8645;
  GL_STENCIL_BACK_FUNC = $8800;
  GL_STENCIL_BACK_FAIL = $8801;
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = $8802;
  GL_STENCIL_BACK_PASS_DEPTH_PASS = $8803;
  GL_MAX_DRAW_BUFFERS = $8824;
  GL_DRAW_BUFFER0 = $8825;
  GL_DRAW_BUFFER1 = $8826;
  GL_DRAW_BUFFER2 = $8827;
  GL_DRAW_BUFFER3 = $8828;
  GL_DRAW_BUFFER4 = $8829;
  GL_DRAW_BUFFER5 = $882A;
  GL_DRAW_BUFFER6 = $882B;
  GL_DRAW_BUFFER7 = $882C;
  GL_DRAW_BUFFER8 = $882D;
  GL_DRAW_BUFFER9 = $882E;
  GL_DRAW_BUFFER10 = $882F;
  GL_DRAW_BUFFER11 = $8830;
  GL_DRAW_BUFFER12 = $8831;
  GL_DRAW_BUFFER13 = $8832;
  GL_DRAW_BUFFER14 = $8833;
  GL_DRAW_BUFFER15 = $8834;
  GL_BLEND_EQUATION_ALPHA = $883D;
  GL_MAX_VERTEX_ATTRIBS = $8869;
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A;
  GL_MAX_TEXTURE_IMAGE_UNITS = $8872;
  GL_FRAGMENT_SHADER = $8B30;
  GL_VERTEX_SHADER = $8B31;
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = $8B49;
  GL_MAX_VERTEX_UNIFORM_COMPONENTS = $8B4A;
  GL_MAX_VARYING_FLOATS = $8B4B;
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = $8B4C;
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = $8B4D;
  GL_SHADER_TYPE = $8B4F;
  GL_FLOAT_VEC2 = $8B50;
  GL_FLOAT_VEC3 = $8B51;
  GL_FLOAT_VEC4 = $8B52;
  GL_INT_VEC2 = $8B53;
  GL_INT_VEC3 = $8B54;
  GL_INT_VEC4 = $8B55;
  GL_BOOL = $8B56;
  GL_BOOL_VEC2 = $8B57;
  GL_BOOL_VEC3 = $8B58;
  GL_BOOL_VEC4 = $8B59;
  GL_FLOAT_MAT2 = $8B5A;
  GL_FLOAT_MAT3 = $8B5B;
  GL_FLOAT_MAT4 = $8B5C;
  GL_SAMPLER_1D = $8B5D;
  GL_SAMPLER_2D = $8B5E;
  GL_SAMPLER_3D = $8B5F;
  GL_SAMPLER_CUBE = $8B60;
  GL_SAMPLER_1D_SHADOW = $8B61;
  GL_SAMPLER_2D_SHADOW = $8B62;
  GL_DELETE_STATUS = $8B80;
  GL_COMPILE_STATUS = $8B81;
  GL_LINK_STATUS = $8B82;
  GL_VALIDATE_STATUS = $8B83;
  GL_INFO_LOG_LENGTH = $8B84;
  GL_ATTACHED_SHADERS = $8B85;
  GL_ACTIVE_UNIFORMS = $8B86;
  GL_ACTIVE_UNIFORM_MAX_LENGTH = $8B87;
  GL_SHADER_SOURCE_LENGTH = $8B88;
  GL_ACTIVE_ATTRIBUTES = $8B89;
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = $8B8A;
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT = $8B8B;
  GL_SHADING_LANGUAGE_VERSION = $8B8C;
  GL_CURRENT_PROGRAM = $8B8D;
  GL_POINT_SPRITE_COORD_ORIGIN = $8CA0;
  GL_LOWER_LEFT = $8CA1;
  GL_UPPER_LEFT = $8CA2;
  GL_STENCIL_BACK_REF = $8CA3;
  GL_STENCIL_BACK_VALUE_MASK = $8CA4;
  GL_STENCIL_BACK_WRITEMASK = $8CA5;
  // glext + GL_VERSION_2_0
  GL_VERTEX_PROGRAM_TWO_SIDE = $8643;
  GL_POINT_SPRITE = $8861;
  GL_COORD_REPLACE = $8862;
  GL_MAX_TEXTURE_COORDS = $8871;

  // GL_VERSION_2_1
  GL_PIXEL_PACK_BUFFER = $88EB;
  GL_PIXEL_UNPACK_BUFFER = $88EC;
  GL_PIXEL_PACK_BUFFER_BINDING = $88ED;
  GL_PIXEL_UNPACK_BUFFER_BINDING = $88EF;
  GL_FLOAT_MAT2x3 = $8B65;
  GL_FLOAT_MAT2x4 = $8B66;
  GL_FLOAT_MAT3x2 = $8B67;
  GL_FLOAT_MAT3x4 = $8B68;
  GL_FLOAT_MAT4x2 = $8B69;
  GL_FLOAT_MAT4x3 = $8B6A;
  GL_SRGB = $8C40;
  GL_SRGB8 = $8C41;
  GL_SRGB_ALPHA = $8C42;
  GL_SRGB8_ALPHA8 = $8C43;
  GL_COMPRESSED_SRGB = $8C48;
  GL_COMPRESSED_SRGB_ALPHA = $8C49;
  // glext + GL_VERSION_2_1
  GL_CURRENT_RASTER_SECONDARY_COLOR = $845F;
  GL_SLUMINANCE_ALPHA = $8C44;
  GL_SLUMINANCE8_ALPHA8 = $8C45;
  GL_SLUMINANCE = $8C46;
  GL_SLUMINANCE8 = $8C47;
  GL_COMPRESSED_SLUMINANCE = $8C4A;
  GL_COMPRESSED_SLUMINANCE_ALPHA = $8C4B;

  // GL_VERSION_3_0
  GL_COMPARE_REF_TO_TEXTURE = $884E;
  GL_CLIP_DISTANCE0 = $3000;
  GL_CLIP_DISTANCE1 = $3001;
  GL_CLIP_DISTANCE2 = $3002;
  GL_CLIP_DISTANCE3 = $3003;
  GL_CLIP_DISTANCE4 = $3004;
  GL_CLIP_DISTANCE5 = $3005;
  GL_CLIP_DISTANCE6 = $3006;
  GL_CLIP_DISTANCE7 = $3007;
  GL_MAX_CLIP_DISTANCES = $0D32;
  GL_MAJOR_VERSION = $821B;
  GL_MINOR_VERSION = $821C;
  GL_NUM_EXTENSIONS = $821D;
  GL_CONTEXT_FLAGS = $821E;
  GL_COMPRESSED_RED = $8225;
  GL_COMPRESSED_RG = $8226;
  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = $00000001;
  GL_RGBA32F = $8814;
  GL_RGB32F = $8815;
  GL_RGBA16F = $881A;
  GL_RGB16F = $881B;
  GL_VERTEX_ATTRIB_ARRAY_INTEGER = $88FD;
  GL_MAX_ARRAY_TEXTURE_LAYERS = $88FF;
  GL_MIN_PROGRAM_TEXEL_OFFSET = $8904;
  GL_MAX_PROGRAM_TEXEL_OFFSET = $8905;
  GL_CLAMP_READ_COLOR = $891C;
  GL_FIXED_ONLY = $891D;
  GL_MAX_VARYING_COMPONENTS = $8B4B;
  GL_TEXTURE_1D_ARRAY = $8C18;
  GL_PROXY_TEXTURE_1D_ARRAY = $8C19;
  GL_TEXTURE_2D_ARRAY = $8C1A;
  GL_PROXY_TEXTURE_2D_ARRAY = $8C1B;
  GL_TEXTURE_BINDING_1D_ARRAY = $8C1C;
  GL_TEXTURE_BINDING_2D_ARRAY = $8C1D;
  GL_R11F_G11F_B10F = $8C3A;
  GL_UNSIGNED_INT_10F_11F_11F_REV = $8C3B;
  GL_RGB9_E5 = $8C3D;
  GL_UNSIGNED_INT_5_9_9_9_REV = $8C3E;
  GL_TEXTURE_SHARED_SIZE = $8C3F;
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = $8C76;
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE = $8C7F;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = $8C80;
  GL_TRANSFORM_FEEDBACK_VARYINGS = $8C83;
  GL_TRANSFORM_FEEDBACK_BUFFER_START = $8C84;
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = $8C85;
  GL_PRIMITIVES_GENERATED = $8C87;
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = $8C88;
  GL_RASTERIZER_DISCARD = $8C89;
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = $8C8A;
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = $8C8B;
  GL_INTERLEAVED_ATTRIBS = $8C8C;
  GL_SEPARATE_ATTRIBS = $8C8D;
  GL_TRANSFORM_FEEDBACK_BUFFER = $8C8E;
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = $8C8F;
  GL_RGBA32UI = $8D70;
  GL_RGB32UI = $8D71;
  GL_RGBA16UI = $8D76;
  GL_RGB16UI = $8D77;
  GL_RGBA8UI = $8D7C;
  GL_RGB8UI = $8D7D;
  GL_RGBA32I = $8D82;
  GL_RGB32I = $8D83;
  GL_RGBA16I = $8D88;
  GL_RGB16I = $8D89;
  GL_RGBA8I = $8D8E;
  GL_RGB8I = $8D8F;
  GL_RED_INTEGER = $8D94;
  GL_GREEN_INTEGER = $8D95;
  GL_BLUE_INTEGER = $8D96;
  GL_RGB_INTEGER = $8D98;
  GL_RGBA_INTEGER = $8D99;
  GL_BGR_INTEGER = $8D9A;
  GL_BGRA_INTEGER = $8D9B;
  GL_SAMPLER_1D_ARRAY = $8DC0;
  GL_SAMPLER_2D_ARRAY = $8DC1;
  GL_SAMPLER_1D_ARRAY_SHADOW = $8DC3;
  GL_SAMPLER_2D_ARRAY_SHADOW = $8DC4;
  GL_SAMPLER_CUBE_SHADOW = $8DC5;
  GL_UNSIGNED_INT_VEC2 = $8DC6;
  GL_UNSIGNED_INT_VEC3 = $8DC7;
  GL_UNSIGNED_INT_VEC4 = $8DC8;
  GL_INT_SAMPLER_1D = $8DC9;
  GL_INT_SAMPLER_2D = $8DCA;
  GL_INT_SAMPLER_3D = $8DCB;
  GL_INT_SAMPLER_CUBE = $8DCC;
  GL_INT_SAMPLER_1D_ARRAY = $8DCE;
  GL_INT_SAMPLER_2D_ARRAY = $8DCF;
  GL_UNSIGNED_INT_SAMPLER_1D = $8DD1;
  GL_UNSIGNED_INT_SAMPLER_2D = $8DD2;
  GL_UNSIGNED_INT_SAMPLER_3D = $8DD3;
  GL_UNSIGNED_INT_SAMPLER_CUBE = $8DD4;
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = $8DD6;
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = $8DD7;
  GL_QUERY_WAIT = $8E13;
  GL_QUERY_NO_WAIT = $8E14;
  GL_QUERY_BY_REGION_WAIT = $8E15;
  GL_QUERY_BY_REGION_NO_WAIT = $8E16;
  GL_BUFFER_ACCESS_FLAGS = $911F;
  GL_BUFFER_MAP_LENGTH = $9120;
  GL_BUFFER_MAP_OFFSET = $9121;
  GL_DEPTH_COMPONENT32F = $8CAC;
  GL_DEPTH32F_STENCIL8 = $8CAD;
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV = $8DAD;
  GL_INVALID_FRAMEBUFFER_OPERATION = $0506;
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = $8210;
  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = $8211;
  GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = $8212;
  GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = $8213;
  GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = $8214;
  GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = $8215;
  GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = $8216;
  GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = $8217;
  GL_FRAMEBUFFER_DEFAULT = $8218;
  GL_FRAMEBUFFER_UNDEFINED = $8219;
  GL_DEPTH_STENCIL_ATTACHMENT = $821A;
  GL_MAX_RENDERBUFFER_SIZE = $84E8;
  GL_DEPTH_STENCIL = $84F9;
  GL_UNSIGNED_INT_24_8 = $84FA;
  GL_DEPTH24_STENCIL8 = $88F0;
  GL_TEXTURE_STENCIL_SIZE = $88F1;
  GL_TEXTURE_RED_TYPE = $8C10;
  GL_TEXTURE_GREEN_TYPE = $8C11;
  GL_TEXTURE_BLUE_TYPE = $8C12;
  GL_TEXTURE_ALPHA_TYPE = $8C13;
  GL_TEXTURE_DEPTH_TYPE = $8C16;
  GL_UNSIGNED_NORMALIZED = $8C17;
  GL_FRAMEBUFFER_BINDING = $8CA6;
  GL_DRAW_FRAMEBUFFER_BINDING = $8CA6;
  GL_RENDERBUFFER_BINDING = $8CA7;
  GL_READ_FRAMEBUFFER = $8CA8;
  GL_DRAW_FRAMEBUFFER = $8CA9;
  GL_READ_FRAMEBUFFER_BINDING = $8CAA;
  GL_RENDERBUFFER_SAMPLES = $8CAB;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = $8CD0;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = $8CD1;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = $8CD2;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = $8CD3;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = $8CD4;
  GL_FRAMEBUFFER_COMPLETE = $8CD5;
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = $8CD6;
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = $8CD7;
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = $8CDB;
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = $8CDC;
  GL_FRAMEBUFFER_UNSUPPORTED = $8CDD;
  GL_MAX_COLOR_ATTACHMENTS = $8CDF;
  GL_COLOR_ATTACHMENT0 = $8CE0;
  GL_COLOR_ATTACHMENT1 = $8CE1;
  GL_COLOR_ATTACHMENT2 = $8CE2;
  GL_COLOR_ATTACHMENT3 = $8CE3;
  GL_COLOR_ATTACHMENT4 = $8CE4;
  GL_COLOR_ATTACHMENT5 = $8CE5;
  GL_COLOR_ATTACHMENT6 = $8CE6;
  GL_COLOR_ATTACHMENT7 = $8CE7;
  GL_COLOR_ATTACHMENT8 = $8CE8;
  GL_COLOR_ATTACHMENT9 = $8CE9;
  GL_COLOR_ATTACHMENT10 = $8CEA;
  GL_COLOR_ATTACHMENT11 = $8CEB;
  GL_COLOR_ATTACHMENT12 = $8CEC;
  GL_COLOR_ATTACHMENT13 = $8CED;
  GL_COLOR_ATTACHMENT14 = $8CEE;
  GL_COLOR_ATTACHMENT15 = $8CEF;
  GL_COLOR_ATTACHMENT16 = $8CF0;
  GL_COLOR_ATTACHMENT17 = $8CF1;
  GL_COLOR_ATTACHMENT18 = $8CF2;
  GL_COLOR_ATTACHMENT19 = $8CF3;
  GL_COLOR_ATTACHMENT20 = $8CF4;
  GL_COLOR_ATTACHMENT21 = $8CF5;
  GL_COLOR_ATTACHMENT22 = $8CF6;
  GL_COLOR_ATTACHMENT23 = $8CF7;
  GL_COLOR_ATTACHMENT24 = $8CF8;
  GL_COLOR_ATTACHMENT25 = $8CF9;
  GL_COLOR_ATTACHMENT26 = $8CFA;
  GL_COLOR_ATTACHMENT27 = $8CFB;
  GL_COLOR_ATTACHMENT28 = $8CFC;
  GL_COLOR_ATTACHMENT29 = $8CFD;
  GL_COLOR_ATTACHMENT30 = $8CFE;
  GL_COLOR_ATTACHMENT31 = $8CFF;
  GL_DEPTH_ATTACHMENT = $8D00;
  GL_STENCIL_ATTACHMENT = $8D20;
  GL_FRAMEBUFFER = $8D40;
  GL_RENDERBUFFER = $8D41;
  GL_RENDERBUFFER_WIDTH = $8D42;
  GL_RENDERBUFFER_HEIGHT = $8D43;
  GL_RENDERBUFFER_INTERNAL_FORMAT = $8D44;
  GL_STENCIL_INDEX1 = $8D46;
  GL_STENCIL_INDEX4 = $8D47;
  GL_STENCIL_INDEX8 = $8D48;
  GL_STENCIL_INDEX16 = $8D49;
  GL_RENDERBUFFER_RED_SIZE = $8D50;
  GL_RENDERBUFFER_GREEN_SIZE = $8D51;
  GL_RENDERBUFFER_BLUE_SIZE = $8D52;
  GL_RENDERBUFFER_ALPHA_SIZE = $8D53;
  GL_RENDERBUFFER_DEPTH_SIZE = $8D54;
  GL_RENDERBUFFER_STENCIL_SIZE = $8D55;
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = $8D56;
  GL_MAX_SAMPLES = $8D57;
  GL_FRAMEBUFFER_SRGB = $8DB9;
  GL_HALF_FLOAT = $140B;
  GL_MAP_READ_BIT = $0001;
  GL_MAP_WRITE_BIT = $0002;
  GL_MAP_INVALIDATE_RANGE_BIT = $0004;
  GL_MAP_INVALIDATE_BUFFER_BIT = $0008;
  GL_MAP_FLUSH_EXPLICIT_BIT = $0010;
  GL_MAP_UNSYNCHRONIZED_BIT = $0020;
  GL_COMPRESSED_RED_RGTC1 = $8DBB;
  GL_COMPRESSED_SIGNED_RED_RGTC1 = $8DBC;
  GL_COMPRESSED_RG_RGTC2 = $8DBD;
  GL_COMPRESSED_SIGNED_RG_RGTC2 = $8DBE;
  GL_RG = $8227;
  GL_RG_INTEGER = $8228;
  GL_R8 = $8229;
  GL_R16 = $822A;
  GL_RG8 = $822B;
  GL_RG16 = $822C;
  GL_R16F = $822D;
  GL_R32F = $822E;
  GL_RG16F = $822F;
  GL_RG32F = $8230;
  GL_R8I = $8231;
  GL_R8UI = $8232;
  GL_R16I = $8233;
  GL_R16UI = $8234;
  GL_R32I = $8235;
  GL_R32UI = $8236;
  GL_RG8I = $8237;
  GL_RG8UI = $8238;
  GL_RG16I = $8239;
  GL_RG16UI = $823A;
  GL_RG32I = $823B;
  GL_RG32UI = $823C;
  GL_VERTEX_ARRAY_BINDING = $85B5;
  // glext + GL_VERSION_3_0
  GL_INDEX = $8222;
  GL_TEXTURE_LUMINANCE_TYPE = $8C14;
  GL_TEXTURE_INTENSITY_TYPE = $8C15;
  GL_CLAMP_VERTEX_COLOR = $891A;
  GL_CLAMP_FRAGMENT_COLOR = $891B;
  GL_ALPHA_INTEGER = $8D97;

  // GL_VERSION_3_1
  GL_SAMPLER_2D_RECT = $8B63;
  GL_SAMPLER_2D_RECT_SHADOW = $8B64;
  GL_SAMPLER_BUFFER = $8DC2;
  GL_INT_SAMPLER_2D_RECT = $8DCD;
  GL_INT_SAMPLER_BUFFER = $8DD0;
  GL_UNSIGNED_INT_SAMPLER_2D_RECT = $8DD5;
  GL_UNSIGNED_INT_SAMPLER_BUFFER = $8DD8;
  GL_TEXTURE_BUFFER = $8C2A;
  GL_MAX_TEXTURE_BUFFER_SIZE = $8C2B;
  GL_TEXTURE_BINDING_BUFFER = $8C2C;
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING = $8C2D;
  GL_TEXTURE_RECTANGLE = $84F5;
  GL_TEXTURE_BINDING_RECTANGLE = $84F6;
  GL_PROXY_TEXTURE_RECTANGLE = $84F7;
  GL_MAX_RECTANGLE_TEXTURE_SIZE = $84F8;
  GL_R8_SNORM = $8F94;
  GL_RG8_SNORM = $8F95;
  GL_RGB8_SNORM = $8F96;
  GL_RGBA8_SNORM = $8F97;
  GL_R16_SNORM = $8F98;
  GL_RG16_SNORM = $8F99;
  GL_RGB16_SNORM = $8F9A;
  GL_RGBA16_SNORM = $8F9B;
  GL_SIGNED_NORMALIZED = $8F9C;
  GL_PRIMITIVE_RESTART = $8F9D;
  GL_PRIMITIVE_RESTART_INDEX = $8F9E;
  GL_COPY_READ_BUFFER = $8F36;
  GL_COPY_WRITE_BUFFER = $8F37;
  GL_UNIFORM_BUFFER = $8A11;
  GL_UNIFORM_BUFFER_BINDING = $8A28;
  GL_UNIFORM_BUFFER_START = $8A29;
  GL_UNIFORM_BUFFER_SIZE = $8A2A;
  GL_MAX_VERTEX_UNIFORM_BLOCKS = $8A2B;
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS = $8A2C;
  GL_MAX_FRAGMENT_UNIFORM_BLOCKS = $8A2D;
  GL_MAX_COMBINED_UNIFORM_BLOCKS = $8A2E;
  GL_MAX_UNIFORM_BUFFER_BINDINGS = $8A2F;
  GL_MAX_UNIFORM_BLOCK_SIZE = $8A30;
  GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = $8A31;
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = $8A32;
  GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = $8A33;
  GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = $8A34;
  GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = $8A35;
  GL_ACTIVE_UNIFORM_BLOCKS = $8A36;
  GL_UNIFORM_TYPE = $8A37;
  GL_UNIFORM_SIZE = $8A38;
  GL_UNIFORM_NAME_LENGTH = $8A39;
  GL_UNIFORM_BLOCK_INDEX = $8A3A;
  GL_UNIFORM_OFFSET = $8A3B;
  GL_UNIFORM_ARRAY_STRIDE = $8A3C;
  GL_UNIFORM_MATRIX_STRIDE = $8A3D;
  GL_UNIFORM_IS_ROW_MAJOR = $8A3E;
  GL_UNIFORM_BLOCK_BINDING = $8A3F;
  GL_UNIFORM_BLOCK_DATA_SIZE = $8A40;
  GL_UNIFORM_BLOCK_NAME_LENGTH = $8A41;
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = $8A42;
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = $8A43;
  GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = $8A44;
  GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = $8A45;
  GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = $8A46;
  GL_INVALID_INDEX = $FFFFFFFF;

  // GL_VERSION_3_2
  GL_CONTEXT_CORE_PROFILE_BIT = $00000001;
  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = $00000002;
  GL_LINES_ADJACENCY = $000A;
  GL_LINE_STRIP_ADJACENCY = $000B;
  GL_TRIANGLES_ADJACENCY = $000C;
  GL_TRIANGLE_STRIP_ADJACENCY = $000D;
  GL_PROGRAM_POINT_SIZE = $8642;
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = $8C29;
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED = $8DA7;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = $8DA8;
  GL_GEOMETRY_SHADER = $8DD9;
  GL_GEOMETRY_VERTICES_OUT = $8916;
  GL_GEOMETRY_INPUT_TYPE = $8917;
  GL_GEOMETRY_OUTPUT_TYPE = $8918;
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = $8DDF;
  GL_MAX_GEOMETRY_OUTPUT_VERTICES = $8DE0;
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = $8DE1;
  GL_MAX_VERTEX_OUTPUT_COMPONENTS = $9122;
  GL_MAX_GEOMETRY_INPUT_COMPONENTS = $9123;
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = $9124;
  GL_MAX_FRAGMENT_INPUT_COMPONENTS = $9125;
  GL_CONTEXT_PROFILE_MASK = $9126;
  GL_DEPTH_CLAMP = $864F;
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = $8E4C;
  GL_FIRST_VERTEX_CONVENTION = $8E4D;
  GL_LAST_VERTEX_CONVENTION = $8E4E;
  GL_PROVOKING_VERTEX = $8E4F;
  GL_TEXTURE_CUBE_MAP_SEAMLESS = $884F;
  GL_MAX_SERVER_WAIT_TIMEOUT = $9111;
  GL_OBJECT_TYPE = $9112;
  GL_SYNC_CONDITION = $9113;
  GL_SYNC_STATUS = $9114;
  GL_SYNC_FLAGS = $9115;
  GL_SYNC_FENCE = $9116;
  GL_SYNC_GPU_COMMANDS_COMPLETE = $9117;
  GL_UNSIGNALED = $9118;
  GL_SIGNALED = $9119;
  GL_ALREADY_SIGNALED = $911A;
  GL_TIMEOUT_EXPIRED = $911B;
  GL_CONDITION_SATISFIED = $911C;
  GL_WAIT_FAILED = $911D;
  GL_TIMEOUT_IGNORED = $FFFFFFFFFFFFFFFF;
  GL_SYNC_FLUSH_COMMANDS_BIT = $00000001;
  GL_SAMPLE_POSITION = $8E50;
  GL_SAMPLE_MASK = $8E51;
  GL_SAMPLE_MASK_VALUE = $8E52;
  GL_MAX_SAMPLE_MASK_WORDS = $8E59;
  GL_TEXTURE_2D_MULTISAMPLE = $9100;
  GL_PROXY_TEXTURE_2D_MULTISAMPLE = $9101;
  GL_TEXTURE_2D_MULTISAMPLE_ARRAY = $9102;
  GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = $9103;
  GL_TEXTURE_BINDING_2D_MULTISAMPLE = $9104;
  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = $9105;
  GL_TEXTURE_SAMPLES = $9106;
  GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = $9107;
  GL_SAMPLER_2D_MULTISAMPLE = $9108;
  GL_INT_SAMPLER_2D_MULTISAMPLE = $9109;
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = $910A;
  GL_SAMPLER_2D_MULTISAMPLE_ARRAY = $910B;
  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910C;
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910D;
  GL_MAX_COLOR_TEXTURE_SAMPLES = $910E;
  GL_MAX_DEPTH_TEXTURE_SAMPLES = $910F;
  GL_MAX_INTEGER_SAMPLES = $9110;

  // GL_VERSION_3_3
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR = $88FE;
  GL_SRC1_COLOR = $88F9;
  GL_ONE_MINUS_SRC1_COLOR = $88FA;
  GL_ONE_MINUS_SRC1_ALPHA = $88FB;
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = $88FC;
  GL_ANY_SAMPLES_PASSED = $8C2F;
  GL_SAMPLER_BINDING = $8919;
  GL_RGB10_A2UI = $906F;
  GL_TEXTURE_SWIZZLE_R = $8E42;
  GL_TEXTURE_SWIZZLE_G = $8E43;
  GL_TEXTURE_SWIZZLE_B = $8E44;
  GL_TEXTURE_SWIZZLE_A = $8E45;
  GL_TEXTURE_SWIZZLE_RGBA = $8E46;
  GL_TIME_ELAPSED = $88BF;
  GL_TIMESTAMP = $8E28;
  GL_INT_2_10_10_10_REV = $8D9F;

  // GL_VERSION_4_0
  GL_SAMPLE_SHADING = $8C36;
  GL_MIN_SAMPLE_SHADING_VALUE = $8C37;
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5E;
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5F;
  GL_TEXTURE_CUBE_MAP_ARRAY = $9009;
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = $900A;
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = $900B;
  GL_SAMPLER_CUBE_MAP_ARRAY = $900C;
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = $900D;
  GL_INT_SAMPLER_CUBE_MAP_ARRAY = $900E;
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = $900F;
  GL_DRAW_INDIRECT_BUFFER = $8F3F;
  GL_DRAW_INDIRECT_BUFFER_BINDING = $8F43;
  GL_GEOMETRY_SHADER_INVOCATIONS = $887F;
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS = $8E5A;
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = $8E5B;
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = $8E5C;
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = $8E5D;
  GL_MAX_VERTEX_STREAMS = $8E71;
  GL_DOUBLE_VEC2 = $8FFC;
  GL_DOUBLE_VEC3 = $8FFD;
  GL_DOUBLE_VEC4 = $8FFE;
  GL_DOUBLE_MAT2 = $8F46;
  GL_DOUBLE_MAT3 = $8F47;
  GL_DOUBLE_MAT4 = $8F48;
  GL_DOUBLE_MAT2x3 = $8F49;
  GL_DOUBLE_MAT2x4 = $8F4A;
  GL_DOUBLE_MAT3x2 = $8F4B;
  GL_DOUBLE_MAT3x4 = $8F4C;
  GL_DOUBLE_MAT4x2 = $8F4D;
  GL_DOUBLE_MAT4x3 = $8F4E;
  GL_ACTIVE_SUBROUTINES = $8DE5;
  GL_ACTIVE_SUBROUTINE_UNIFORMS = $8DE6;
  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = $8E47;
  GL_ACTIVE_SUBROUTINE_MAX_LENGTH = $8E48;
  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = $8E49;
  GL_MAX_SUBROUTINES = $8DE7;
  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = $8DE8;
  GL_NUM_COMPATIBLE_SUBROUTINES = $8E4A;
  GL_COMPATIBLE_SUBROUTINES = $8E4B;
  GL_PATCHES = $000E;
  GL_PATCH_VERTICES = $8E72;
  GL_PATCH_DEFAULT_INNER_LEVEL = $8E73;
  GL_PATCH_DEFAULT_OUTER_LEVEL = $8E74;
  GL_TESS_CONTROL_OUTPUT_VERTICES = $8E75;
  GL_TESS_GEN_MODE = $8E76;
  GL_TESS_GEN_SPACING = $8E77;
  GL_TESS_GEN_VERTEX_ORDER = $8E78;
  GL_TESS_GEN_POINT_MODE = $8E79;
  GL_ISOLINES = $8E7A;
  GL_FRACTIONAL_ODD = $8E7B;
  GL_FRACTIONAL_EVEN = $8E7C;
  GL_MAX_PATCH_VERTICES = $8E7D;
  GL_MAX_TESS_GEN_LEVEL = $8E7E;
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = $8E7F;
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E80;
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = $8E81;
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = $8E82;
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = $8E83;
  GL_MAX_TESS_PATCH_COMPONENTS = $8E84;
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = $8E85;
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = $8E86;
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = $8E89;
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = $8E8A;
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = $886C;
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = $886D;
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = $8E1E;
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E1F;
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = $84F0;
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = $84F1;
  GL_TESS_EVALUATION_SHADER = $8E87;
  GL_TESS_CONTROL_SHADER = $8E88;
  GL_TRANSFORM_FEEDBACK = $8E22;
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = $8E23;
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = $8E24;
  GL_TRANSFORM_FEEDBACK_BINDING = $8E25;
  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = $8E70;

  // GL_VERSION_4_1
  GL_FIXED = $140C;
  GL_IMPLEMENTATION_COLOR_READ_TYPE = $8B9A;
  GL_IMPLEMENTATION_COLOR_READ_FORMAT = $8B9B;
  GL_LOW_FLOAT = $8DF0;
  GL_MEDIUM_FLOAT = $8DF1;
  GL_HIGH_FLOAT = $8DF2;
  GL_LOW_INT = $8DF3;
  GL_MEDIUM_INT = $8DF4;
  GL_HIGH_INT = $8DF5;
  GL_SHADER_COMPILER = $8DFA;
  GL_SHADER_BINARY_FORMATS = $8DF8;
  GL_NUM_SHADER_BINARY_FORMATS = $8DF9;
  GL_MAX_VERTEX_UNIFORM_VECTORS = $8DFB;
  GL_MAX_VARYING_VECTORS = $8DFC;
  GL_MAX_FRAGMENT_UNIFORM_VECTORS = $8DFD;
  GL_RGB565 = $8D62;
  GL_PROGRAM_BINARY_RETRIEVABLE_HINT = $8257;
  GL_PROGRAM_BINARY_LENGTH = $8741;
  GL_NUM_PROGRAM_BINARY_FORMATS = $87FE;
  GL_PROGRAM_BINARY_FORMATS = $87FF;
  GL_VERTEX_SHADER_BIT = $00000001;
  GL_FRAGMENT_SHADER_BIT = $00000002;
  GL_GEOMETRY_SHADER_BIT = $00000004;
  GL_TESS_CONTROL_SHADER_BIT = $00000008;
  GL_TESS_EVALUATION_SHADER_BIT = $00000010;
  GL_ALL_SHADER_BITS = $FFFFFFFF;
  GL_PROGRAM_SEPARABLE = $8258;
  GL_ACTIVE_PROGRAM = $8259;
  GL_PROGRAM_PIPELINE_BINDING = $825A;
  GL_MAX_VIEWPORTS = $825B;
  GL_VIEWPORT_SUBPIXEL_BITS = $825C;
  GL_VIEWPORT_BOUNDS_RANGE = $825D;
  GL_LAYER_PROVOKING_VERTEX = $825E;
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX = $825F;
  GL_UNDEFINED_VERTEX = $8260;

  // GL_VERSION_4_2
  GL_COPY_READ_BUFFER_BINDING = $8F36;
  GL_COPY_WRITE_BUFFER_BINDING = $8F37;
  GL_TRANSFORM_FEEDBACK_ACTIVE = $8E24;
  GL_TRANSFORM_FEEDBACK_PAUSED = $8E23;
  GL_UNPACK_COMPRESSED_BLOCK_WIDTH = $9127;
  GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = $9128;
  GL_UNPACK_COMPRESSED_BLOCK_DEPTH = $9129;
  GL_UNPACK_COMPRESSED_BLOCK_SIZE = $912A;
  GL_PACK_COMPRESSED_BLOCK_WIDTH = $912B;
  GL_PACK_COMPRESSED_BLOCK_HEIGHT = $912C;
  GL_PACK_COMPRESSED_BLOCK_DEPTH = $912D;
  GL_PACK_COMPRESSED_BLOCK_SIZE = $912E;
  GL_NUM_SAMPLE_COUNTS = $9380;
  GL_MIN_MAP_BUFFER_ALIGNMENT = $90BC;
  GL_ATOMIC_COUNTER_BUFFER = $92C0;
  GL_ATOMIC_COUNTER_BUFFER_BINDING = $92C1;
  GL_ATOMIC_COUNTER_BUFFER_START = $92C2;
  GL_ATOMIC_COUNTER_BUFFER_SIZE = $92C3;
  GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE = $92C4;
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = $92C5;
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = $92C6;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = $92C7;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = $92C8;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = $92C9;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = $92CA;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = $92CB;
  GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = $92CC;
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = $92CD;
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = $92CE;
  GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = $92CF;
  GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = $92D0;
  GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = $92D1;
  GL_MAX_VERTEX_ATOMIC_COUNTERS = $92D2;
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS = $92D3;
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS = $92D4;
  GL_MAX_GEOMETRY_ATOMIC_COUNTERS = $92D5;
  GL_MAX_FRAGMENT_ATOMIC_COUNTERS = $92D6;
  GL_MAX_COMBINED_ATOMIC_COUNTERS = $92D7;
  GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE = $92D8;
  GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = $92DC;
  GL_ACTIVE_ATOMIC_COUNTER_BUFFERS = $92D9;
  GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = $92DA;
  GL_UNSIGNED_INT_ATOMIC_COUNTER = $92DB;
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT = $00000001;
  GL_ELEMENT_ARRAY_BARRIER_BIT = $00000002;
  GL_UNIFORM_BARRIER_BIT = $00000004;
  GL_TEXTURE_FETCH_BARRIER_BIT = $00000008;
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = $00000020;
  GL_COMMAND_BARRIER_BIT = $00000040;
  GL_PIXEL_BUFFER_BARRIER_BIT = $00000080;
  GL_TEXTURE_UPDATE_BARRIER_BIT = $00000100;
  GL_BUFFER_UPDATE_BARRIER_BIT = $00000200;
  GL_FRAMEBUFFER_BARRIER_BIT = $00000400;
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT = $00000800;
  GL_ATOMIC_COUNTER_BARRIER_BIT = $00001000;
  GL_ALL_BARRIER_BITS = $FFFFFFFF;
  GL_MAX_IMAGE_UNITS = $8F38;
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = $8F39;
  GL_IMAGE_BINDING_NAME = $8F3A;
  GL_IMAGE_BINDING_LEVEL = $8F3B;
  GL_IMAGE_BINDING_LAYERED = $8F3C;
  GL_IMAGE_BINDING_LAYER = $8F3D;
  GL_IMAGE_BINDING_ACCESS = $8F3E;
  GL_IMAGE_1D = $904C;
  GL_IMAGE_2D = $904D;
  GL_IMAGE_3D = $904E;
  GL_IMAGE_2D_RECT = $904F;
  GL_IMAGE_CUBE = $9050;
  GL_IMAGE_BUFFER = $9051;
  GL_IMAGE_1D_ARRAY = $9052;
  GL_IMAGE_2D_ARRAY = $9053;
  GL_IMAGE_CUBE_MAP_ARRAY = $9054;
  GL_IMAGE_2D_MULTISAMPLE = $9055;
  GL_IMAGE_2D_MULTISAMPLE_ARRAY = $9056;
  GL_INT_IMAGE_1D = $9057;
  GL_INT_IMAGE_2D = $9058;
  GL_INT_IMAGE_3D = $9059;
  GL_INT_IMAGE_2D_RECT = $905A;
  GL_INT_IMAGE_CUBE = $905B;
  GL_INT_IMAGE_BUFFER = $905C;
  GL_INT_IMAGE_1D_ARRAY = $905D;
  GL_INT_IMAGE_2D_ARRAY = $905E;
  GL_INT_IMAGE_CUBE_MAP_ARRAY = $905F;
  GL_INT_IMAGE_2D_MULTISAMPLE = $9060;
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $9061;
  GL_UNSIGNED_INT_IMAGE_1D = $9062;
  GL_UNSIGNED_INT_IMAGE_2D = $9063;
  GL_UNSIGNED_INT_IMAGE_3D = $9064;
  GL_UNSIGNED_INT_IMAGE_2D_RECT = $9065;
  GL_UNSIGNED_INT_IMAGE_CUBE = $9066;
  GL_UNSIGNED_INT_IMAGE_BUFFER = $9067;
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY = $9068;
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY = $9069;
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = $906A;
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = $906B;
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $906C;
  GL_MAX_IMAGE_SAMPLES = $906D;
  GL_IMAGE_BINDING_FORMAT = $906E;
  GL_IMAGE_FORMAT_COMPATIBILITY_TYPE = $90C7;
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = $90C8;
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = $90C9;
  GL_MAX_VERTEX_IMAGE_UNIFORMS = $90CA;
  GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS = $90CB;
  GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS = $90CC;
  GL_MAX_GEOMETRY_IMAGE_UNIFORMS = $90CD;
  GL_MAX_FRAGMENT_IMAGE_UNIFORMS = $90CE;
  GL_MAX_COMBINED_IMAGE_UNIFORMS = $90CF;
  GL_COMPRESSED_RGBA_BPTC_UNORM = $8E8C;
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM = $8E8D;
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT = $8E8E;
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = $8E8F;
  GL_TEXTURE_IMMUTABLE_FORMAT = $912F;

  // GL_VERSION_4_3
  GL_NUM_SHADING_LANGUAGE_VERSIONS = $82E9;
  GL_VERTEX_ATTRIB_ARRAY_LONG = $874E;
  GL_COMPRESSED_RGB8_ETC2 = $9274;
  GL_COMPRESSED_SRGB8_ETC2 = $9275;
  GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9276;
  GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9277;
  GL_COMPRESSED_RGBA8_ETC2_EAC = $9278;
  GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = $9279;
  GL_COMPRESSED_R11_EAC = $9270;
  GL_COMPRESSED_SIGNED_R11_EAC = $9271;
  GL_COMPRESSED_RG11_EAC = $9272;
  GL_COMPRESSED_SIGNED_RG11_EAC = $9273;
  GL_PRIMITIVE_RESTART_FIXED_INDEX = $8D69;
  GL_ANY_SAMPLES_PASSED_CONSERVATIVE = $8D6A;
  GL_MAX_ELEMENT_INDEX = $8D6B;
  GL_COMPUTE_SHADER = $91B9;
  GL_MAX_COMPUTE_UNIFORM_BLOCKS = $91BB;
  GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = $91BC;
  GL_MAX_COMPUTE_IMAGE_UNIFORMS = $91BD;
  GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = $8262;
  GL_MAX_COMPUTE_UNIFORM_COMPONENTS = $8263;
  GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = $8264;
  GL_MAX_COMPUTE_ATOMIC_COUNTERS = $8265;
  GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = $8266;
  GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = $90EB;
  GL_MAX_COMPUTE_WORK_GROUP_COUNT = $91BE;
  GL_MAX_COMPUTE_WORK_GROUP_SIZE = $91BF;
  GL_COMPUTE_WORK_GROUP_SIZE = $8267;
  GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = $90EC;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = $90ED;
  GL_DISPATCH_INDIRECT_BUFFER = $90EE;
  GL_DISPATCH_INDIRECT_BUFFER_BINDING = $90EF;
  GL_COMPUTE_SHADER_BIT = $00000020;
  GL_DEBUG_OUTPUT_SYNCHRONOUS = $8242;
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = $8243;
  GL_DEBUG_CALLBACK_FUNCTION = $8244;
  GL_DEBUG_CALLBACK_USER_PARAM = $8245;
  GL_DEBUG_SOURCE_API = $8246;
  GL_DEBUG_SOURCE_WINDOW_SYSTEM = $8247;
  GL_DEBUG_SOURCE_SHADER_COMPILER = $8248;
  GL_DEBUG_SOURCE_THIRD_PARTY = $8249;
  GL_DEBUG_SOURCE_APPLICATION = $824A;
  GL_DEBUG_SOURCE_OTHER = $824B;
  GL_DEBUG_TYPE_ERROR = $824C;
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR = $824D;
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR = $824E;
  GL_DEBUG_TYPE_PORTABILITY = $824F;
  GL_DEBUG_TYPE_PERFORMANCE = $8250;
  GL_DEBUG_TYPE_OTHER = $8251;
  GL_MAX_DEBUG_MESSAGE_LENGTH = $9143;
  GL_MAX_DEBUG_LOGGED_MESSAGES = $9144;
  GL_DEBUG_LOGGED_MESSAGES = $9145;
  GL_DEBUG_SEVERITY_HIGH = $9146;
  GL_DEBUG_SEVERITY_MEDIUM = $9147;
  GL_DEBUG_SEVERITY_LOW = $9148;
  GL_DEBUG_TYPE_MARKER = $8268;
  GL_DEBUG_TYPE_PUSH_GROUP = $8269;
  GL_DEBUG_TYPE_POP_GROUP = $826A;
  GL_DEBUG_SEVERITY_NOTIFICATION = $826B;
  GL_MAX_DEBUG_GROUP_STACK_DEPTH = $826C;
  GL_DEBUG_GROUP_STACK_DEPTH = $826D;
  GL_BUFFER = $82E0;
  GL_SHADER = $82E1;
  GL_PROGRAM = $82E2;
  GL_QUERY = $82E3;
  GL_PROGRAM_PIPELINE = $82E4;
  GL_SAMPLER = $82E6;
  GL_MAX_LABEL_LENGTH = $82E8;
  GL_DEBUG_OUTPUT = $92E0;
  GL_CONTEXT_FLAG_DEBUG_BIT = $00000002;
  GL_MAX_UNIFORM_LOCATIONS = $826E;
  GL_FRAMEBUFFER_DEFAULT_WIDTH = $9310;
  GL_FRAMEBUFFER_DEFAULT_HEIGHT = $9311;
  GL_FRAMEBUFFER_DEFAULT_LAYERS = $9312;
  GL_FRAMEBUFFER_DEFAULT_SAMPLES = $9313;
  GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = $9314;
  GL_MAX_FRAMEBUFFER_WIDTH = $9315;
  GL_MAX_FRAMEBUFFER_HEIGHT = $9316;
  GL_MAX_FRAMEBUFFER_LAYERS = $9317;
  GL_MAX_FRAMEBUFFER_SAMPLES = $9318;
  GL_INTERNALFORMAT_SUPPORTED = $826F;
  GL_INTERNALFORMAT_PREFERRED = $8270;
  GL_INTERNALFORMAT_RED_SIZE = $8271;
  GL_INTERNALFORMAT_GREEN_SIZE = $8272;
  GL_INTERNALFORMAT_BLUE_SIZE = $8273;
  GL_INTERNALFORMAT_ALPHA_SIZE = $8274;
  GL_INTERNALFORMAT_DEPTH_SIZE = $8275;
  GL_INTERNALFORMAT_STENCIL_SIZE = $8276;
  GL_INTERNALFORMAT_SHARED_SIZE = $8277;
  GL_INTERNALFORMAT_RED_TYPE = $8278;
  GL_INTERNALFORMAT_GREEN_TYPE = $8279;
  GL_INTERNALFORMAT_BLUE_TYPE = $827A;
  GL_INTERNALFORMAT_ALPHA_TYPE = $827B;
  GL_INTERNALFORMAT_DEPTH_TYPE = $827C;
  GL_INTERNALFORMAT_STENCIL_TYPE = $827D;
  GL_MAX_WIDTH = $827E;
  GL_MAX_HEIGHT = $827F;
  GL_MAX_DEPTH = $8280;
  GL_MAX_LAYERS = $8281;
  GL_MAX_COMBINED_DIMENSIONS = $8282;
  GL_COLOR_COMPONENTS = $8283;
  GL_DEPTH_COMPONENTS = $8284;
  GL_STENCIL_COMPONENTS = $8285;
  GL_COLOR_RENDERABLE = $8286;
  GL_DEPTH_RENDERABLE = $8287;
  GL_STENCIL_RENDERABLE = $8288;
  GL_FRAMEBUFFER_RENDERABLE = $8289;
  GL_FRAMEBUFFER_RENDERABLE_LAYERED = $828A;
  GL_FRAMEBUFFER_BLEND = $828B;
  GL_READ_PIXELS = $828C;
  GL_READ_PIXELS_FORMAT = $828D;
  GL_READ_PIXELS_TYPE = $828E;
  GL_TEXTURE_IMAGE_FORMAT = $828F;
  GL_TEXTURE_IMAGE_TYPE = $8290;
  GL_GET_TEXTURE_IMAGE_FORMAT = $8291;
  GL_GET_TEXTURE_IMAGE_TYPE = $8292;
  GL_MIPMAP = $8293;
  GL_MANUAL_GENERATE_MIPMAP = $8294;
  GL_AUTO_GENERATE_MIPMAP = $8295;
  GL_COLOR_ENCODING = $8296;
  GL_SRGB_READ = $8297;
  GL_SRGB_WRITE = $8298;
  GL_FILTER = $829A;
  GL_VERTEX_TEXTURE = $829B;
  GL_TESS_CONTROL_TEXTURE = $829C;
  GL_TESS_EVALUATION_TEXTURE = $829D;
  GL_GEOMETRY_TEXTURE = $829E;
  GL_FRAGMENT_TEXTURE = $829F;
  GL_COMPUTE_TEXTURE = $82A0;
  GL_TEXTURE_SHADOW = $82A1;
  GL_TEXTURE_GATHER = $82A2;
  GL_TEXTURE_GATHER_SHADOW = $82A3;
  GL_SHADER_IMAGE_LOAD = $82A4;
  GL_SHADER_IMAGE_STORE = $82A5;
  GL_SHADER_IMAGE_ATOMIC = $82A6;
  GL_IMAGE_TEXEL_SIZE = $82A7;
  GL_IMAGE_COMPATIBILITY_CLASS = $82A8;
  GL_IMAGE_PIXEL_FORMAT = $82A9;
  GL_IMAGE_PIXEL_TYPE = $82AA;
  GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = $82AC;
  GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = $82AD;
  GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = $82AE;
  GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = $82AF;
  GL_TEXTURE_COMPRESSED_BLOCK_WIDTH = $82B1;
  GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT = $82B2;
  GL_TEXTURE_COMPRESSED_BLOCK_SIZE = $82B3;
  GL_CLEAR_BUFFER = $82B4;
  GL_TEXTURE_VIEW = $82B5;
  GL_VIEW_COMPATIBILITY_CLASS = $82B6;
  GL_FULL_SUPPORT = $82B7;
  GL_CAVEAT_SUPPORT = $82B8;
  GL_IMAGE_CLASS_4_X_32 = $82B9;
  GL_IMAGE_CLASS_2_X_32 = $82BA;
  GL_IMAGE_CLASS_1_X_32 = $82BB;
  GL_IMAGE_CLASS_4_X_16 = $82BC;
  GL_IMAGE_CLASS_2_X_16 = $82BD;
  GL_IMAGE_CLASS_1_X_16 = $82BE;
  GL_IMAGE_CLASS_4_X_8 = $82BF;
  GL_IMAGE_CLASS_2_X_8 = $82C0;
  GL_IMAGE_CLASS_1_X_8 = $82C1;
  GL_IMAGE_CLASS_11_11_10 = $82C2;
  GL_IMAGE_CLASS_10_10_10_2 = $82C3;
  GL_VIEW_CLASS_128_BITS = $82C4;
  GL_VIEW_CLASS_96_BITS = $82C5;
  GL_VIEW_CLASS_64_BITS = $82C6;
  GL_VIEW_CLASS_48_BITS = $82C7;
  GL_VIEW_CLASS_32_BITS = $82C8;
  GL_VIEW_CLASS_24_BITS = $82C9;
  GL_VIEW_CLASS_16_BITS = $82CA;
  GL_VIEW_CLASS_8_BITS = $82CB;
  GL_VIEW_CLASS_S3TC_DXT1_RGB = $82CC;
  GL_VIEW_CLASS_S3TC_DXT1_RGBA = $82CD;
  GL_VIEW_CLASS_S3TC_DXT3_RGBA = $82CE;
  GL_VIEW_CLASS_S3TC_DXT5_RGBA = $82CF;
  GL_VIEW_CLASS_RGTC1_RED = $82D0;
  GL_VIEW_CLASS_RGTC2_RG = $82D1;
  GL_VIEW_CLASS_BPTC_UNORM = $82D2;
  GL_VIEW_CLASS_BPTC_FLOAT = $82D3;
  GL_UNIFORM = $92E1;
  GL_UNIFORM_BLOCK = $92E2;
  GL_PROGRAM_INPUT = $92E3;
  GL_PROGRAM_OUTPUT = $92E4;
  GL_BUFFER_VARIABLE = $92E5;
  GL_SHADER_STORAGE_BLOCK = $92E6;
  GL_VERTEX_SUBROUTINE = $92E8;
  GL_TESS_CONTROL_SUBROUTINE = $92E9;
  GL_TESS_EVALUATION_SUBROUTINE = $92EA;
  GL_GEOMETRY_SUBROUTINE = $92EB;
  GL_FRAGMENT_SUBROUTINE = $92EC;
  GL_COMPUTE_SUBROUTINE = $92ED;
  GL_VERTEX_SUBROUTINE_UNIFORM = $92EE;
  GL_TESS_CONTROL_SUBROUTINE_UNIFORM = $92EF;
  GL_TESS_EVALUATION_SUBROUTINE_UNIFORM = $92F0;
  GL_GEOMETRY_SUBROUTINE_UNIFORM = $92F1;
  GL_FRAGMENT_SUBROUTINE_UNIFORM = $92F2;
  GL_COMPUTE_SUBROUTINE_UNIFORM = $92F3;
  GL_TRANSFORM_FEEDBACK_VARYING = $92F4;
  GL_ACTIVE_RESOURCES = $92F5;
  GL_MAX_NAME_LENGTH = $92F6;
  GL_MAX_NUM_ACTIVE_VARIABLES = $92F7;
  GL_MAX_NUM_COMPATIBLE_SUBROUTINES = $92F8;
  GL_NAME_LENGTH = $92F9;
  GL_TYPE = $92FA;
  GL_ARRAY_SIZE = $92FB;
  GL_OFFSET = $92FC;
  GL_BLOCK_INDEX = $92FD;
  GL_ARRAY_STRIDE = $92FE;
  GL_MATRIX_STRIDE = $92FF;
  GL_IS_ROW_MAJOR = $9300;
  GL_ATOMIC_COUNTER_BUFFER_INDEX = $9301;
  GL_BUFFER_BINDING = $9302;
  GL_BUFFER_DATA_SIZE = $9303;
  GL_NUM_ACTIVE_VARIABLES = $9304;
  GL_ACTIVE_VARIABLES = $9305;
  GL_REFERENCED_BY_VERTEX_SHADER = $9306;
  GL_REFERENCED_BY_TESS_CONTROL_SHADER = $9307;
  GL_REFERENCED_BY_TESS_EVALUATION_SHADER = $9308;
  GL_REFERENCED_BY_GEOMETRY_SHADER = $9309;
  GL_REFERENCED_BY_FRAGMENT_SHADER = $930A;
  GL_REFERENCED_BY_COMPUTE_SHADER = $930B;
  GL_TOP_LEVEL_ARRAY_SIZE = $930C;
  GL_TOP_LEVEL_ARRAY_STRIDE = $930D;
  GL_LOCATION = $930E;
  GL_LOCATION_INDEX = $930F;
  GL_IS_PER_PATCH = $92E7;
  GL_SHADER_STORAGE_BUFFER = $90D2;
  GL_SHADER_STORAGE_BUFFER_BINDING = $90D3;
  GL_SHADER_STORAGE_BUFFER_START = $90D4;
  GL_SHADER_STORAGE_BUFFER_SIZE = $90D5;
  GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS = $90D6;
  GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = $90D7;
  GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = $90D8;
  GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = $90D9;
  GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = $90DA;
  GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS = $90DB;
  GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS = $90DC;
  GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS = $90DD;
  GL_MAX_SHADER_STORAGE_BLOCK_SIZE = $90DE;
  GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = $90DF;
  GL_SHADER_STORAGE_BARRIER_BIT = $00002000;
  GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = $8F39;
  GL_DEPTH_STENCIL_TEXTURE_MODE = $90EA;
  GL_TEXTURE_BUFFER_OFFSET = $919D;
  GL_TEXTURE_BUFFER_SIZE = $919E;
  GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = $919F;
  GL_TEXTURE_VIEW_MIN_LEVEL = $82DB;
  GL_TEXTURE_VIEW_NUM_LEVELS = $82DC;
  GL_TEXTURE_VIEW_MIN_LAYER = $82DD;
  GL_TEXTURE_VIEW_NUM_LAYERS = $82DE;
  GL_TEXTURE_IMMUTABLE_LEVELS = $82DF;
  GL_VERTEX_ATTRIB_BINDING = $82D4;
  GL_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D5;
  GL_VERTEX_BINDING_DIVISOR = $82D6;
  GL_VERTEX_BINDING_OFFSET = $82D7;
  GL_VERTEX_BINDING_STRIDE = $82D8;
  GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D9;
  GL_MAX_VERTEX_ATTRIB_BINDINGS = $82DA;
  GL_VERTEX_BINDING_BUFFER = $8F4F;
  // glext + GL_VERSION_4_3
  GL_DISPLAY_LIST = $82E7;

  // GL_VERSION_4_4
  GL_MAX_VERTEX_ATTRIB_STRIDE = $82E5;
  GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = $8221;
  GL_TEXTURE_BUFFER_BINDING = $8C2A;
  GL_MAP_PERSISTENT_BIT = $0040;
  GL_MAP_COHERENT_BIT = $0080;
  GL_DYNAMIC_STORAGE_BIT = $0100;
  GL_CLIENT_STORAGE_BIT = $0200;
  GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = $00004000;
  GL_BUFFER_IMMUTABLE_STORAGE = $821F;
  GL_BUFFER_STORAGE_FLAGS = $8220;
  GL_CLEAR_TEXTURE = $9365;
  GL_LOCATION_COMPONENT = $934A;
  GL_TRANSFORM_FEEDBACK_BUFFER_INDEX = $934B;
  GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = $934C;
  GL_QUERY_BUFFER = $9192;
  GL_QUERY_BUFFER_BARRIER_BIT = $00008000;
  GL_QUERY_BUFFER_BINDING = $9193;
  GL_QUERY_RESULT_NO_WAIT = $9194;
  GL_MIRROR_CLAMP_TO_EDGE = $8743;

  // GL_VERSION_4_5
  GL_CONTEXT_LOST = $0507;
  GL_NEGATIVE_ONE_TO_ONE = $935E;
  GL_ZERO_TO_ONE = $935F;
  GL_CLIP_ORIGIN = $935C;
  GL_CLIP_DEPTH_MODE = $935D;
  GL_QUERY_WAIT_INVERTED = $8E17;
  GL_QUERY_NO_WAIT_INVERTED = $8E18;
  GL_QUERY_BY_REGION_WAIT_INVERTED = $8E19;
  GL_QUERY_BY_REGION_NO_WAIT_INVERTED = $8E1A;
  GL_MAX_CULL_DISTANCES = $82F9;
  GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = $82FA;
  GL_TEXTURE_TARGET = $1006;
  GL_QUERY_TARGET = $82EA;
  GL_GUILTY_CONTEXT_RESET = $8253;
  GL_INNOCENT_CONTEXT_RESET = $8254;
  GL_UNKNOWN_CONTEXT_RESET = $8255;
  GL_RESET_NOTIFICATION_STRATEGY = $8256;
  GL_LOSE_CONTEXT_ON_RESET = $8252;
  GL_NO_RESET_NOTIFICATION = $8261;
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = $00000004;
  GL_CONTEXT_RELEASE_BEHAVIOR = $82FB;
  GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = $82FC;
  // glext + GL_VERSION_4_5
  GL_COLOR_TABLE = $80D0;
  GL_POST_CONVOLUTION_COLOR_TABLE = $80D1;
  GL_POST_COLOR_MATRIX_COLOR_TABLE = $80D2;
  GL_PROXY_COLOR_TABLE = $80D3;
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = $80D4;
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = $80D5;
  GL_CONVOLUTION_1D = $8010;
  GL_CONVOLUTION_2D = $8011;
  GL_SEPARABLE_2D = $8012;
  GL_HISTOGRAM = $8024;
  GL_PROXY_HISTOGRAM = $8025;
  GL_MINMAX = $802E;

  // GL_VERSION_4_6
  GL_SHADER_BINARY_FORMAT_SPIR_V = $9551;
  GL_SPIR_V_BINARY = $9552;
  GL_PARAMETER_BUFFER = $80EE;
  GL_PARAMETER_BUFFER_BINDING = $80EF;
  GL_CONTEXT_FLAG_NO_ERROR_BIT = $00000008;
  GL_VERTICES_SUBMITTED = $82EE;
  GL_PRIMITIVES_SUBMITTED = $82EF;
  GL_VERTEX_SHADER_INVOCATIONS = $82F0;
  GL_TESS_CONTROL_SHADER_PATCHES = $82F1;
  GL_TESS_EVALUATION_SHADER_INVOCATIONS = $82F2;
  GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED = $82F3;
  GL_FRAGMENT_SHADER_INVOCATIONS = $82F4;
  GL_COMPUTE_SHADER_INVOCATIONS = $82F5;
  GL_CLIPPING_INPUT_PRIMITIVES = $82F6;
  GL_CLIPPING_OUTPUT_PRIMITIVES = $82F7;
  GL_POLYGON_OFFSET_CLAMP = $8E1B;
  GL_SPIR_V_EXTENSIONS = $9553;
  GL_NUM_SPIR_V_EXTENSIONS = $9554;
  GL_TEXTURE_MAX_ANISOTROPY = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY = $84FF;
  GL_TRANSFORM_FEEDBACK_OVERFLOW = $82EC;
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW = $82ED;

  // GL_ARB_ES3_2_compatibility
  GL_PRIMITIVE_BOUNDING_BOX_ARB = $92BE;
  GL_MULTISAMPLE_LINE_WIDTH_RANGE_ARB = $9381;
  GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB = $9382;
  // GL_ARB_bindless_texture
  GL_UNSIGNED_INT64_ARB = $140F;
  // GL_ARB_cl_event
  GL_SYNC_CL_EVENT_ARB = $8240;
  GL_SYNC_CL_EVENT_COMPLETE_ARB = $8241;
      // GL_ARB_color_buffer_float
      GL_RGBA_FLOAT_MODE_ARB = $8820;
      GL_CLAMP_VERTEX_COLOR_ARB = $891A;
      GL_CLAMP_FRAGMENT_COLOR_ARB = $891B;
      GL_CLAMP_READ_COLOR_ARB = $891C;
      GL_FIXED_ONLY_ARB = $891D;
  // GL_ARB_compute_variable_group_size
  GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = $9344;
  GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = $90EB;
  GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = $9345;
  GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = $91BF;
  // GL_ARB_debug_output
  GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB = $8242;
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = $8243;
  GL_DEBUG_CALLBACK_FUNCTION_ARB = $8244;
  GL_DEBUG_CALLBACK_USER_PARAM_ARB = $8245;
  GL_DEBUG_SOURCE_API_ARB = $8246;
  GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB = $8247;
  GL_DEBUG_SOURCE_SHADER_COMPILER_ARB = $8248;
  GL_DEBUG_SOURCE_THIRD_PARTY_ARB = $8249;
  GL_DEBUG_SOURCE_APPLICATION_ARB = $824A;
  GL_DEBUG_SOURCE_OTHER_ARB = $824B;
  GL_DEBUG_TYPE_ERROR_ARB = $824C;
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = $824D;
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = $824E;
  GL_DEBUG_TYPE_PORTABILITY_ARB = $824F;
  GL_DEBUG_TYPE_PERFORMANCE_ARB = $8250;
  GL_DEBUG_TYPE_OTHER_ARB = $8251;
  GL_MAX_DEBUG_MESSAGE_LENGTH_ARB = $9143;
  GL_MAX_DEBUG_LOGGED_MESSAGES_ARB = $9144;
  GL_DEBUG_LOGGED_MESSAGES_ARB = $9145;
  GL_DEBUG_SEVERITY_HIGH_ARB = $9146;
  GL_DEBUG_SEVERITY_MEDIUM_ARB = $9147;
  GL_DEBUG_SEVERITY_LOW_ARB = $9148;
      // GL_ARB_depth_texture
      GL_DEPTH_COMPONENT16_ARB = $81A5;
      GL_DEPTH_COMPONENT24_ARB = $81A6;
      GL_DEPTH_COMPONENT32_ARB = $81A7;
      GL_TEXTURE_DEPTH_SIZE_ARB = $884A;
      GL_DEPTH_TEXTURE_MODE_ARB = $884B;
      // GL_ARB_draw_buffers
      GL_MAX_DRAW_BUFFERS_ARB = $8824;
      GL_DRAW_BUFFER0_ARB = $8825;
      GL_DRAW_BUFFER1_ARB = $8826;
      GL_DRAW_BUFFER2_ARB = $8827;
      GL_DRAW_BUFFER3_ARB = $8828;
      GL_DRAW_BUFFER4_ARB = $8829;
      GL_DRAW_BUFFER5_ARB = $882A;
      GL_DRAW_BUFFER6_ARB = $882B;
      GL_DRAW_BUFFER7_ARB = $882C;
      GL_DRAW_BUFFER8_ARB = $882D;
      GL_DRAW_BUFFER9_ARB = $882E;
      GL_DRAW_BUFFER10_ARB = $882F;
      GL_DRAW_BUFFER11_ARB = $8830;
      GL_DRAW_BUFFER12_ARB = $8831;
      GL_DRAW_BUFFER13_ARB = $8832;
      GL_DRAW_BUFFER14_ARB = $8833;
      GL_DRAW_BUFFER15_ARB = $8834;
      // GL_ARB_fragment_program
      GL_FRAGMENT_PROGRAM_ARB = $8804;
      GL_PROGRAM_FORMAT_ASCII_ARB = $8875;
      GL_PROGRAM_LENGTH_ARB = $8627;
      GL_PROGRAM_FORMAT_ARB = $8876;
      GL_PROGRAM_BINDING_ARB = $8677;
      GL_PROGRAM_INSTRUCTIONS_ARB = $88A0;
      GL_MAX_PROGRAM_INSTRUCTIONS_ARB = $88A1;
      GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB = $88A2;
      GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB = $88A3;
      GL_PROGRAM_TEMPORARIES_ARB = $88A4;
      GL_MAX_PROGRAM_TEMPORARIES_ARB = $88A5;
      GL_PROGRAM_NATIVE_TEMPORARIES_ARB = $88A6;
      GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB = $88A7;
      GL_PROGRAM_PARAMETERS_ARB = $88A8;
      GL_MAX_PROGRAM_PARAMETERS_ARB = $88A9;
      GL_PROGRAM_NATIVE_PARAMETERS_ARB = $88AA;
      GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB = $88AB;
      GL_PROGRAM_ATTRIBS_ARB = $88AC;
      GL_MAX_PROGRAM_ATTRIBS_ARB = $88AD;
      GL_PROGRAM_NATIVE_ATTRIBS_ARB = $88AE;
      GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB = $88AF;
      GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB = $88B4;
      GL_MAX_PROGRAM_ENV_PARAMETERS_ARB = $88B5;
      GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB = $88B6;
      GL_PROGRAM_ALU_INSTRUCTIONS_ARB = $8805;
      GL_PROGRAM_TEX_INSTRUCTIONS_ARB = $8806;
      GL_PROGRAM_TEX_INDIRECTIONS_ARB = $8807;
      GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = $8808;
      GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = $8809;
      GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = $880A;
      GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB = $880B;
      GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB = $880C;
      GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB = $880D;
      GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = $880E;
      GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = $880F;
      GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = $8810;
      GL_PROGRAM_STRING_ARB = $8628;
      GL_PROGRAM_ERROR_POSITION_ARB = $864B;
      GL_CURRENT_MATRIX_ARB = $8641;
      GL_TRANSPOSE_CURRENT_MATRIX_ARB = $88B7;
      GL_CURRENT_MATRIX_STACK_DEPTH_ARB = $8640;
      GL_MAX_PROGRAM_MATRICES_ARB = $862F;
      GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = $862E;
      GL_MAX_TEXTURE_COORDS_ARB = $8871;
      GL_MAX_TEXTURE_IMAGE_UNITS_ARB = $8872;
      GL_PROGRAM_ERROR_STRING_ARB = $8874;
      GL_MATRIX0_ARB = $88C0;
      GL_MATRIX1_ARB = $88C1;
      GL_MATRIX2_ARB = $88C2;
      GL_MATRIX3_ARB = $88C3;
      GL_MATRIX4_ARB = $88C4;
      GL_MATRIX5_ARB = $88C5;
      GL_MATRIX6_ARB = $88C6;
      GL_MATRIX7_ARB = $88C7;
      GL_MATRIX8_ARB = $88C8;
      GL_MATRIX9_ARB = $88C9;
      GL_MATRIX10_ARB = $88CA;
      GL_MATRIX11_ARB = $88CB;
      GL_MATRIX12_ARB = $88CC;
      GL_MATRIX13_ARB = $88CD;
      GL_MATRIX14_ARB = $88CE;
      GL_MATRIX15_ARB = $88CF;
      GL_MATRIX16_ARB = $88D0;
      GL_MATRIX17_ARB = $88D1;
      GL_MATRIX18_ARB = $88D2;
      GL_MATRIX19_ARB = $88D3;
      GL_MATRIX20_ARB = $88D4;
      GL_MATRIX21_ARB = $88D5;
      GL_MATRIX22_ARB = $88D6;
      GL_MATRIX23_ARB = $88D7;
      GL_MATRIX24_ARB = $88D8;
      GL_MATRIX25_ARB = $88D9;
      GL_MATRIX26_ARB = $88DA;
      GL_MATRIX27_ARB = $88DB;
      GL_MATRIX28_ARB = $88DC;
      GL_MATRIX29_ARB = $88DD;
      GL_MATRIX30_ARB = $88DE;
      GL_MATRIX31_ARB = $88DF;
      // GL_ARB_fragment_shader
      GL_FRAGMENT_SHADER_ARB = $8B30;
      GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = $8B49;
      GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = $8B8B;
  // GL_ARB_geometry_shader4
  GL_LINES_ADJACENCY_ARB = $000A;
  GL_LINE_STRIP_ADJACENCY_ARB = $000B;
  GL_TRIANGLES_ADJACENCY_ARB = $000C;
  GL_TRIANGLE_STRIP_ADJACENCY_ARB = $000D;
  GL_PROGRAM_POINT_SIZE_ARB = $8642;
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = $8C29;
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = $8DA7;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = $8DA8;
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = $8DA9;
  GL_GEOMETRY_SHADER_ARB = $8DD9;
  GL_GEOMETRY_VERTICES_OUT_ARB = $8DDA;
  GL_GEOMETRY_INPUT_TYPE_ARB = $8DDB;
  GL_GEOMETRY_OUTPUT_TYPE_ARB = $8DDC;
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB = $8DDD;
  GL_MAX_VERTEX_VARYING_COMPONENTS_ARB = $8DDE;
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = $8DDF;
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB = $8DE0;
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = $8DE1;
  // GL_ARB_gl_spirv
  GL_SHADER_BINARY_FORMAT_SPIR_V_ARB = $9551;
  GL_SPIR_V_BINARY_ARB = $9552;
  // GL_ARB_gpu_shader_int64
  GL_INT64_ARB = $140E;
  GL_INT64_VEC2_ARB = $8FE9;
  GL_INT64_VEC3_ARB = $8FEA;
  GL_INT64_VEC4_ARB = $8FEB;
  GL_UNSIGNED_INT64_VEC2_ARB = $8FF5;
  GL_UNSIGNED_INT64_VEC3_ARB = $8FF6;
  GL_UNSIGNED_INT64_VEC4_ARB = $8FF7;
      // GL_ARB_half_float_pixel
      GL_HALF_FLOAT_ARB = $140B;
      // GL_ARB_imaging
      GL_CONVOLUTION_BORDER_MODE = $8013;
      GL_CONVOLUTION_FILTER_SCALE = $8014;
      GL_CONVOLUTION_FILTER_BIAS = $8015;
      GL_REDUCE = $8016;
      GL_CONVOLUTION_FORMAT = $8017;
      GL_CONVOLUTION_WIDTH = $8018;
      GL_CONVOLUTION_HEIGHT = $8019;
      GL_MAX_CONVOLUTION_WIDTH = $801A;
      GL_MAX_CONVOLUTION_HEIGHT = $801B;
      GL_POST_CONVOLUTION_RED_SCALE = $801C;
      GL_POST_CONVOLUTION_GREEN_SCALE = $801D;
      GL_POST_CONVOLUTION_BLUE_SCALE = $801E;
      GL_POST_CONVOLUTION_ALPHA_SCALE = $801F;
      GL_POST_CONVOLUTION_RED_BIAS = $8020;
      GL_POST_CONVOLUTION_GREEN_BIAS = $8021;
      GL_POST_CONVOLUTION_BLUE_BIAS = $8022;
      GL_POST_CONVOLUTION_ALPHA_BIAS = $8023;
      GL_HISTOGRAM_WIDTH = $8026;
      GL_HISTOGRAM_FORMAT = $8027;
      GL_HISTOGRAM_RED_SIZE = $8028;
      GL_HISTOGRAM_GREEN_SIZE = $8029;
      GL_HISTOGRAM_BLUE_SIZE = $802A;
      GL_HISTOGRAM_ALPHA_SIZE = $802B;
      GL_HISTOGRAM_LUMINANCE_SIZE = $802C;
      GL_HISTOGRAM_SINK = $802D;
      GL_MINMAX_FORMAT = $802F;
      GL_MINMAX_SINK = $8030;
      GL_TABLE_TOO_LARGE = $8031;
      GL_COLOR_MATRIX = $80B1;
      GL_COLOR_MATRIX_STACK_DEPTH = $80B2;
      GL_MAX_COLOR_MATRIX_STACK_DEPTH = $80B3;
      GL_POST_COLOR_MATRIX_RED_SCALE = $80B4;
      GL_POST_COLOR_MATRIX_GREEN_SCALE = $80B5;
      GL_POST_COLOR_MATRIX_BLUE_SCALE = $80B6;
      GL_POST_COLOR_MATRIX_ALPHA_SCALE = $80B7;
      GL_POST_COLOR_MATRIX_RED_BIAS = $80B8;
      GL_POST_COLOR_MATRIX_GREEN_BIAS = $80B9;
      GL_POST_COLOR_MATRIX_BLUE_BIAS = $80BA;
      GL_POST_COLOR_MATRIX_ALPHA_BIAS = $80BB;
      GL_COLOR_TABLE_SCALE = $80D6;
      GL_COLOR_TABLE_BIAS = $80D7;
      GL_COLOR_TABLE_FORMAT = $80D8;
      GL_COLOR_TABLE_WIDTH = $80D9;
      GL_COLOR_TABLE_RED_SIZE = $80DA;
      GL_COLOR_TABLE_GREEN_SIZE = $80DB;
      GL_COLOR_TABLE_BLUE_SIZE = $80DC;
      GL_COLOR_TABLE_ALPHA_SIZE = $80DD;
      GL_COLOR_TABLE_LUMINANCE_SIZE = $80DE;
      GL_COLOR_TABLE_INTENSITY_SIZE = $80DF;
      GL_CONSTANT_BORDER = $8151;
      GL_REPLICATE_BORDER = $8153;
      GL_CONVOLUTION_BORDER_COLOR = $8154;
  // GL_ARB_indirect_parameters
  GL_PARAMETER_BUFFER_ARB = $80EE;
  GL_PARAMETER_BUFFER_BINDING_ARB = $80EF;
  // GL_ARB_instanced_arrays
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = $88FE;
  // GL_ARB_internalformat_query2
  GL_SRGB_DECODE_ARB = $8299;
  GL_VIEW_CLASS_EAC_R11 = $9383;
  GL_VIEW_CLASS_EAC_RG11 = $9384;
  GL_VIEW_CLASS_ETC2_RGB = $9385;
  GL_VIEW_CLASS_ETC2_RGBA = $9386;
  GL_VIEW_CLASS_ETC2_EAC_RGBA = $9387;
  GL_VIEW_CLASS_ASTC_4x4_RGBA = $9388;
  GL_VIEW_CLASS_ASTC_5x4_RGBA = $9389;
  GL_VIEW_CLASS_ASTC_5x5_RGBA = $938A;
  GL_VIEW_CLASS_ASTC_6x5_RGBA = $938B;
  GL_VIEW_CLASS_ASTC_6x6_RGBA = $938C;
  GL_VIEW_CLASS_ASTC_8x5_RGBA = $938D;
  GL_VIEW_CLASS_ASTC_8x6_RGBA = $938E;
  GL_VIEW_CLASS_ASTC_8x8_RGBA = $938F;
  GL_VIEW_CLASS_ASTC_10x5_RGBA = $9390;
  GL_VIEW_CLASS_ASTC_10x6_RGBA = $9391;
  GL_VIEW_CLASS_ASTC_10x8_RGBA = $9392;
  GL_VIEW_CLASS_ASTC_10x10_RGBA = $9393;
  GL_VIEW_CLASS_ASTC_12x10_RGBA = $9394;
  GL_VIEW_CLASS_ASTC_12x12_RGBA = $9395;
      // GL_ARB_matrix_palette
      GL_MATRIX_PALETTE_ARB = $8840;
      GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB = $8841;
      GL_MAX_PALETTE_MATRICES_ARB = $8842;
      GL_CURRENT_PALETTE_MATRIX_ARB = $8843;
      GL_MATRIX_INDEX_ARRAY_ARB = $8844;
      GL_CURRENT_MATRIX_INDEX_ARB = $8845;
      GL_MATRIX_INDEX_ARRAY_SIZE_ARB = $8846;
      GL_MATRIX_INDEX_ARRAY_TYPE_ARB = $8847;
      GL_MATRIX_INDEX_ARRAY_STRIDE_ARB = $8848;
      GL_MATRIX_INDEX_ARRAY_POINTER_ARB = $8849;
      // GL_ARB_multisample
      GL_MULTISAMPLE_ARB = $809D;
      GL_SAMPLE_ALPHA_TO_COVERAGE_ARB = $809E;
      GL_SAMPLE_ALPHA_TO_ONE_ARB = $809F;
      GL_SAMPLE_COVERAGE_ARB = $80A0;
      GL_SAMPLE_BUFFERS_ARB = $80A8;
      GL_SAMPLES_ARB = $80A9;
      GL_SAMPLE_COVERAGE_VALUE_ARB = $80AA;
      GL_SAMPLE_COVERAGE_INVERT_ARB = $80AB;
      GL_MULTISAMPLE_BIT_ARB = $20000000;
      // GL_ARB_multitexture
      GL_TEXTURE0_ARB = $84C0;
      GL_TEXTURE1_ARB = $84C1;
      GL_TEXTURE2_ARB = $84C2;
      GL_TEXTURE3_ARB = $84C3;
      GL_TEXTURE4_ARB = $84C4;
      GL_TEXTURE5_ARB = $84C5;
      GL_TEXTURE6_ARB = $84C6;
      GL_TEXTURE7_ARB = $84C7;
      GL_TEXTURE8_ARB = $84C8;
      GL_TEXTURE9_ARB = $84C9;
      GL_TEXTURE10_ARB = $84CA;
      GL_TEXTURE11_ARB = $84CB;
      GL_TEXTURE12_ARB = $84CC;
      GL_TEXTURE13_ARB = $84CD;
      GL_TEXTURE14_ARB = $84CE;
      GL_TEXTURE15_ARB = $84CF;
      GL_TEXTURE16_ARB = $84D0;
      GL_TEXTURE17_ARB = $84D1;
      GL_TEXTURE18_ARB = $84D2;
      GL_TEXTURE19_ARB = $84D3;
      GL_TEXTURE20_ARB = $84D4;
      GL_TEXTURE21_ARB = $84D5;
      GL_TEXTURE22_ARB = $84D6;
      GL_TEXTURE23_ARB = $84D7;
      GL_TEXTURE24_ARB = $84D8;
      GL_TEXTURE25_ARB = $84D9;
      GL_TEXTURE26_ARB = $84DA;
      GL_TEXTURE27_ARB = $84DB;
      GL_TEXTURE28_ARB = $84DC;
      GL_TEXTURE29_ARB = $84DD;
      GL_TEXTURE30_ARB = $84DE;
      GL_TEXTURE31_ARB = $84DF;
      GL_ACTIVE_TEXTURE_ARB = $84E0;
      GL_CLIENT_ACTIVE_TEXTURE_ARB = $84E1;
      GL_MAX_TEXTURE_UNITS_ARB = $84E2;
      // GL_ARB_occlusion_query
      GL_QUERY_COUNTER_BITS_ARB = $8864;
      GL_CURRENT_QUERY_ARB = $8865;
      GL_QUERY_RESULT_ARB = $8866;
      GL_QUERY_RESULT_AVAILABLE_ARB = $8867;
      GL_SAMPLES_PASSED_ARB = $8914;
  // GL_ARB_parallel_shader_compile
  GL_MAX_SHADER_COMPILER_THREADS_ARB = $91B0;
  GL_COMPLETION_STATUS_ARB = $91B1;
  // GL_ARB_pipeline_statistics_query
  GL_VERTICES_SUBMITTED_ARB = $82EE;
  GL_PRIMITIVES_SUBMITTED_ARB = $82EF;
  GL_VERTEX_SHADER_INVOCATIONS_ARB = $82F0;
  GL_TESS_CONTROL_SHADER_PATCHES_ARB = $82F1;
  GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB = $82F2;
  GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = $82F3;
  GL_FRAGMENT_SHADER_INVOCATIONS_ARB = $82F4;
  GL_COMPUTE_SHADER_INVOCATIONS_ARB = $82F5;
  GL_CLIPPING_INPUT_PRIMITIVES_ARB = $82F6;
  GL_CLIPPING_OUTPUT_PRIMITIVES_ARB = $82F7;
  // GL_ARB_pixel_buffer_object
  GL_PIXEL_PACK_BUFFER_ARB = $88EB;
  GL_PIXEL_UNPACK_BUFFER_ARB = $88EC;
  GL_PIXEL_PACK_BUFFER_BINDING_ARB = $88ED;
  GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = $88EF;
      // GL_ARB_point_parameters
      GL_POINT_SIZE_MIN_ARB = $8126;
      GL_POINT_SIZE_MAX_ARB = $8127;
      GL_POINT_FADE_THRESHOLD_SIZE_ARB = $8128;
      GL_POINT_DISTANCE_ATTENUATION_ARB = $8129;
      // GL_ARB_point_sprite
      GL_POINT_SPRITE_ARB = $8861;
      GL_COORD_REPLACE_ARB = $8862;
  // GL_ARB_robustness
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = $00000004;
  GL_LOSE_CONTEXT_ON_RESET_ARB = $8252;
  GL_GUILTY_CONTEXT_RESET_ARB = $8253;
  GL_INNOCENT_CONTEXT_RESET_ARB = $8254;
  GL_UNKNOWN_CONTEXT_RESET_ARB = $8255;
  GL_RESET_NOTIFICATION_STRATEGY_ARB = $8256;
  GL_NO_RESET_NOTIFICATION_ARB = $8261;
  // GL_ARB_sample_locations
  GL_SAMPLE_LOCATION_SUBPIXEL_BITS_ARB = $933D;
  GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB = $933E;
  GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB = $933F;
  GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB = $9340;
  GL_SAMPLE_LOCATION_ARB = $8E50;
  GL_PROGRAMMABLE_SAMPLE_LOCATION_ARB = $9341;
  GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB = $9342;
  GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB = $9343;
  // GL_ARB_sample_shading
  GL_SAMPLE_SHADING_ARB = $8C36;
  GL_MIN_SAMPLE_SHADING_VALUE_ARB = $8C37;
      // GL_ARB_shader_objects
      GL_PROGRAM_OBJECT_ARB = $8B40;
      GL_SHADER_OBJECT_ARB = $8B48;
      GL_OBJECT_TYPE_ARB = $8B4E;
      GL_OBJECT_SUBTYPE_ARB = $8B4F;
      GL_FLOAT_VEC2_ARB = $8B50;
      GL_FLOAT_VEC3_ARB = $8B51;
      GL_FLOAT_VEC4_ARB = $8B52;
      GL_INT_VEC2_ARB = $8B53;
      GL_INT_VEC3_ARB = $8B54;
      GL_INT_VEC4_ARB = $8B55;
      GL_BOOL_ARB = $8B56;
      GL_BOOL_VEC2_ARB = $8B57;
      GL_BOOL_VEC3_ARB = $8B58;
      GL_BOOL_VEC4_ARB = $8B59;
      GL_FLOAT_MAT2_ARB = $8B5A;
      GL_FLOAT_MAT3_ARB = $8B5B;
      GL_FLOAT_MAT4_ARB = $8B5C;
      GL_SAMPLER_1D_ARB = $8B5D;
      GL_SAMPLER_2D_ARB = $8B5E;
      GL_SAMPLER_3D_ARB = $8B5F;
      GL_SAMPLER_CUBE_ARB = $8B60;
      GL_SAMPLER_1D_SHADOW_ARB = $8B61;
      GL_SAMPLER_2D_SHADOW_ARB = $8B62;
      GL_SAMPLER_2D_RECT_ARB = $8B63;
      GL_SAMPLER_2D_RECT_SHADOW_ARB = $8B64;
      GL_OBJECT_DELETE_STATUS_ARB = $8B80;
      GL_OBJECT_COMPILE_STATUS_ARB = $8B81;
      GL_OBJECT_LINK_STATUS_ARB = $8B82;
      GL_OBJECT_VALIDATE_STATUS_ARB = $8B83;
      GL_OBJECT_INFO_LOG_LENGTH_ARB = $8B84;
      GL_OBJECT_ATTACHED_OBJECTS_ARB = $8B85;
      GL_OBJECT_ACTIVE_UNIFORMS_ARB = $8B86;
      GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB = $8B87;
      GL_OBJECT_SHADER_SOURCE_LENGTH_ARB = $8B88;
      // GL_ARB_shading_language_100
      GL_SHADING_LANGUAGE_VERSION_ARB = $8B8C;
  // GL_ARB_shading_language_include
  GL_SHADER_INCLUDE_ARB = $8DAE;
  GL_NAMED_STRING_LENGTH_ARB = $8DE9;
  GL_NAMED_STRING_TYPE_ARB = $8DEA;
      // GL_ARB_shadow
      GL_TEXTURE_COMPARE_MODE_ARB = $884C;
      GL_TEXTURE_COMPARE_FUNC_ARB = $884D;
      GL_COMPARE_R_TO_TEXTURE_ARB = $884E;
      // GL_ARB_shadow_ambient
      GL_TEXTURE_COMPARE_FAIL_VALUE_ARB = $80BF;
  // GL_ARB_sparse_buffer
  GL_SPARSE_STORAGE_BIT_ARB = $0400;
  GL_SPARSE_BUFFER_PAGE_SIZE_ARB = $82F8;
  // GL_ARB_sparse_texture
  GL_TEXTURE_SPARSE_ARB = $91A6;
  GL_VIRTUAL_PAGE_SIZE_INDEX_ARB = $91A7;
  GL_NUM_SPARSE_LEVELS_ARB = $91AA;
  GL_NUM_VIRTUAL_PAGE_SIZES_ARB = $91A8;
  GL_VIRTUAL_PAGE_SIZE_X_ARB = $9195;
  GL_VIRTUAL_PAGE_SIZE_Y_ARB = $9196;
  GL_VIRTUAL_PAGE_SIZE_Z_ARB = $9197;
  GL_MAX_SPARSE_TEXTURE_SIZE_ARB = $9198;
  GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = $9199;
  GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = $919A;
  GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = $91A9;
  // GL_ARB_texture_border_clamp
  GL_CLAMP_TO_BORDER_ARB = $812D;
  // GL_ARB_texture_buffer_object
  GL_TEXTURE_BUFFER_ARB = $8C2A;
  GL_MAX_TEXTURE_BUFFER_SIZE_ARB = $8C2B;
  GL_TEXTURE_BINDING_BUFFER_ARB = $8C2C;
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = $8C2D;
  GL_TEXTURE_BUFFER_FORMAT_ARB = $8C2E;
      // GL_ARB_texture_compression
      GL_COMPRESSED_ALPHA_ARB = $84E9;
      GL_COMPRESSED_LUMINANCE_ARB = $84EA;
      GL_COMPRESSED_LUMINANCE_ALPHA_ARB = $84EB;
      GL_COMPRESSED_INTENSITY_ARB = $84EC;
      GL_COMPRESSED_RGB_ARB = $84ED;
      GL_COMPRESSED_RGBA_ARB = $84EE;
      GL_TEXTURE_COMPRESSION_HINT_ARB = $84EF;
      GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = $86A0;
      GL_TEXTURE_COMPRESSED_ARB = $86A1;
      GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB = $86A2;
      GL_COMPRESSED_TEXTURE_FORMATS_ARB = $86A3;
  // GL_ARB_texture_compression_bptc
  GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = $8E8C;
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = $8E8D;
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = $8E8E;
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = $8E8F;
      // GL_ARB_texture_cube_map
      GL_NORMAL_MAP_ARB = $8511;
      GL_REFLECTION_MAP_ARB = $8512;
      GL_TEXTURE_CUBE_MAP_ARB = $8513;
      GL_TEXTURE_BINDING_CUBE_MAP_ARB = $8514;
      GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = $8515;
      GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = $8516;
      GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = $8517;
      GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = $8518;
      GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = $8519;
      GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = $851A;
      GL_PROXY_TEXTURE_CUBE_MAP_ARB = $851B;
      GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB = $851C;
  // GL_ARB_texture_cube_map_array
  GL_TEXTURE_CUBE_MAP_ARRAY_ARB = $9009;
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = $900A;
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = $900B;
  GL_SAMPLER_CUBE_MAP_ARRAY_ARB = $900C;
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = $900D;
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900E;
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = $900F;
      // GL_ARB_texture_env_combine
      GL_COMBINE_ARB = $8570;
      GL_COMBINE_RGB_ARB = $8571;
      GL_COMBINE_ALPHA_ARB = $8572;
      GL_SOURCE0_RGB_ARB = $8580;
      GL_SOURCE1_RGB_ARB = $8581;
      GL_SOURCE2_RGB_ARB = $8582;
      GL_SOURCE0_ALPHA_ARB = $8588;
      GL_SOURCE1_ALPHA_ARB = $8589;
      GL_SOURCE2_ALPHA_ARB = $858A;
      GL_OPERAND0_RGB_ARB = $8590;
      GL_OPERAND1_RGB_ARB = $8591;
      GL_OPERAND2_RGB_ARB = $8592;
      GL_OPERAND0_ALPHA_ARB = $8598;
      GL_OPERAND1_ALPHA_ARB = $8599;
      GL_OPERAND2_ALPHA_ARB = $859A;
      GL_RGB_SCALE_ARB = $8573;
      GL_ADD_SIGNED_ARB = $8574;
      GL_INTERPOLATE_ARB = $8575;
      GL_SUBTRACT_ARB = $84E7;
      GL_CONSTANT_ARB = $8576;
      GL_PRIMARY_COLOR_ARB = $8577;
      GL_PREVIOUS_ARB = $8578;
      // GL_ARB_texture_env_dot3
      GL_DOT3_RGB_ARB = $86AE;
      GL_DOT3_RGBA_ARB = $86AF;
  // GL_ARB_texture_filter_minmax
  GL_TEXTURE_REDUCTION_MODE_ARB = $9366;
  GL_WEIGHTED_AVERAGE_ARB = $9367;
      // GL_ARB_texture_float
      GL_TEXTURE_RED_TYPE_ARB = $8C10;
      GL_TEXTURE_GREEN_TYPE_ARB = $8C11;
      GL_TEXTURE_BLUE_TYPE_ARB = $8C12;
      GL_TEXTURE_ALPHA_TYPE_ARB = $8C13;
      GL_TEXTURE_LUMINANCE_TYPE_ARB = $8C14;
      GL_TEXTURE_INTENSITY_TYPE_ARB = $8C15;
      GL_TEXTURE_DEPTH_TYPE_ARB = $8C16;
      GL_UNSIGNED_NORMALIZED_ARB = $8C17;
      GL_RGBA32F_ARB = $8814;
      GL_RGB32F_ARB = $8815;
      GL_ALPHA32F_ARB = $8816;
      GL_INTENSITY32F_ARB = $8817;
      GL_LUMINANCE32F_ARB = $8818;
      GL_LUMINANCE_ALPHA32F_ARB = $8819;
      GL_RGBA16F_ARB = $881A;
      GL_RGB16F_ARB = $881B;
      GL_ALPHA16F_ARB = $881C;
      GL_INTENSITY16F_ARB = $881D;
      GL_LUMINANCE16F_ARB = $881E;
      GL_LUMINANCE_ALPHA16F_ARB = $881F;
  // GL_ARB_texture_gather
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5E;
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = $8E5F;
  GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = $8F9F;
  // GL_ARB_texture_mirrored_repeat
  GL_MIRRORED_REPEAT_ARB = $8370;
      // GL_ARB_texture_rectangle
      GL_TEXTURE_RECTANGLE_ARB = $84F5;
      GL_TEXTURE_BINDING_RECTANGLE_ARB = $84F6;
      GL_PROXY_TEXTURE_RECTANGLE_ARB = $84F7;
      GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB = $84F8;
  // GL_ARB_transform_feedback_overflow_query
  GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = $82EC;
  GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = $82ED;
      // GL_ARB_transpose_matrix
      GL_TRANSPOSE_MODELVIEW_MATRIX_ARB = $84E3;
      GL_TRANSPOSE_PROJECTION_MATRIX_ARB = $84E4;
      GL_TRANSPOSE_TEXTURE_MATRIX_ARB = $84E5;
      GL_TRANSPOSE_COLOR_MATRIX_ARB = $84E6;
      // GL_ARB_vertex_blend
      GL_MAX_VERTEX_UNITS_ARB = $86A4;
      GL_ACTIVE_VERTEX_UNITS_ARB = $86A5;
      GL_WEIGHT_SUM_UNITY_ARB = $86A6;
      GL_VERTEX_BLEND_ARB = $86A7;
      GL_CURRENT_WEIGHT_ARB = $86A8;
      GL_WEIGHT_ARRAY_TYPE_ARB = $86A9;
      GL_WEIGHT_ARRAY_STRIDE_ARB = $86AA;
      GL_WEIGHT_ARRAY_SIZE_ARB = $86AB;
      GL_WEIGHT_ARRAY_POINTER_ARB = $86AC;
      GL_WEIGHT_ARRAY_ARB = $86AD;
      GL_MODELVIEW0_ARB = $1700;
      GL_MODELVIEW1_ARB = $850A;
      GL_MODELVIEW2_ARB = $8722;
      GL_MODELVIEW3_ARB = $8723;
      GL_MODELVIEW4_ARB = $8724;
      GL_MODELVIEW5_ARB = $8725;
      GL_MODELVIEW6_ARB = $8726;
      GL_MODELVIEW7_ARB = $8727;
      GL_MODELVIEW8_ARB = $8728;
      GL_MODELVIEW9_ARB = $8729;
      GL_MODELVIEW10_ARB = $872A;
      GL_MODELVIEW11_ARB = $872B;
      GL_MODELVIEW12_ARB = $872C;
      GL_MODELVIEW13_ARB = $872D;
      GL_MODELVIEW14_ARB = $872E;
      GL_MODELVIEW15_ARB = $872F;
      GL_MODELVIEW16_ARB = $8730;
      GL_MODELVIEW17_ARB = $8731;
      GL_MODELVIEW18_ARB = $8732;
      GL_MODELVIEW19_ARB = $8733;
      GL_MODELVIEW20_ARB = $8734;
      GL_MODELVIEW21_ARB = $8735;
      GL_MODELVIEW22_ARB = $8736;
      GL_MODELVIEW23_ARB = $8737;
      GL_MODELVIEW24_ARB = $8738;
      GL_MODELVIEW25_ARB = $8739;
      GL_MODELVIEW26_ARB = $873A;
      GL_MODELVIEW27_ARB = $873B;
      GL_MODELVIEW28_ARB = $873C;
      GL_MODELVIEW29_ARB = $873D;
      GL_MODELVIEW30_ARB = $873E;
      GL_MODELVIEW31_ARB = $873F;
      // GL_ARB_vertex_buffer_object
      GL_BUFFER_SIZE_ARB = $8764;
      GL_BUFFER_USAGE_ARB = $8765;
      GL_ARRAY_BUFFER_ARB = $8892;
      GL_ELEMENT_ARRAY_BUFFER_ARB = $8893;
      GL_ARRAY_BUFFER_BINDING_ARB = $8894;
      GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB = $8895;
      GL_VERTEX_ARRAY_BUFFER_BINDING_ARB = $8896;
      GL_NORMAL_ARRAY_BUFFER_BINDING_ARB = $8897;
      GL_COLOR_ARRAY_BUFFER_BINDING_ARB = $8898;
      GL_INDEX_ARRAY_BUFFER_BINDING_ARB = $8899;
      GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB = $889A;
      GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB = $889B;
      GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB = $889C;
      GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB = $889D;
      GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB = $889E;
      GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB = $889F;
      GL_READ_ONLY_ARB = $88B8;
      GL_WRITE_ONLY_ARB = $88B9;
      GL_READ_WRITE_ARB = $88BA;
      GL_BUFFER_ACCESS_ARB = $88BB;
      GL_BUFFER_MAPPED_ARB = $88BC;
      GL_BUFFER_MAP_POINTER_ARB = $88BD;
      GL_STREAM_DRAW_ARB = $88E0;
      GL_STREAM_READ_ARB = $88E1;
      GL_STREAM_COPY_ARB = $88E2;
      GL_STATIC_DRAW_ARB = $88E4;
      GL_STATIC_READ_ARB = $88E5;
      GL_STATIC_COPY_ARB = $88E6;
      GL_DYNAMIC_DRAW_ARB = $88E8;
      GL_DYNAMIC_READ_ARB = $88E9;
      GL_DYNAMIC_COPY_ARB = $88EA;
      // GL_ARB_vertex_program
      GL_COLOR_SUM_ARB = $8458;
      GL_VERTEX_PROGRAM_ARB = $8620;
      GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB = $8622;
      GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB = $8623;
      GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB = $8624;
      GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB = $8625;
      GL_CURRENT_VERTEX_ATTRIB_ARB = $8626;
      GL_VERTEX_PROGRAM_POINT_SIZE_ARB = $8642;
      GL_VERTEX_PROGRAM_TWO_SIDE_ARB = $8643;
      GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB = $8645;
      GL_MAX_VERTEX_ATTRIBS_ARB = $8869;
      GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = $886A;
      GL_PROGRAM_ADDRESS_REGISTERS_ARB = $88B0;
      GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB = $88B1;
      GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B2;
      GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = $88B3;
      // GL_ARB_vertex_shader
      GL_VERTEX_SHADER_ARB = $8B31;
      GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB = $8B4A;
      GL_MAX_VARYING_FLOATS_ARB = $8B4B;
      GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = $8B4C;
      GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = $8B4D;
      GL_OBJECT_ACTIVE_ATTRIBUTES_ARB = $8B89;
      GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = $8B8A;
  // GL_KHR_blend_equation_advanced
  GL_MULTIPLY_KHR = $9294;
  GL_SCREEN_KHR = $9295;
  GL_OVERLAY_KHR = $9296;
  GL_DARKEN_KHR = $9297;
  GL_LIGHTEN_KHR = $9298;
  GL_COLORDODGE_KHR = $9299;
  GL_COLORBURN_KHR = $929A;
  GL_HARDLIGHT_KHR = $929B;
  GL_SOFTLIGHT_KHR = $929C;
  GL_DIFFERENCE_KHR = $929E;
  GL_EXCLUSION_KHR = $92A0;
  GL_HSL_HUE_KHR = $92AD;
  GL_HSL_SATURATION_KHR = $92AE;
  GL_HSL_COLOR_KHR = $92AF;
  GL_HSL_LUMINOSITY_KHR = $92B0;
  // GL_KHR_blend_equation_advanced_coherent
  GL_BLEND_ADVANCED_COHERENT_KHR = $9285;
  // GL_KHR_no_error
  GL_CONTEXT_FLAG_NO_ERROR_BIT_KHR = $00000008;
  // GL_KHR_parallel_shader_compile
  GL_MAX_SHADER_COMPILER_THREADS_KHR = $91B0;
  GL_COMPLETION_STATUS_KHR = $91B1;
  // GL_KHR_robustness
  GL_CONTEXT_ROBUST_ACCESS = $90F3;
  // GL_KHR_shader_subgroup
  GL_SUBGROUP_SIZE_KHR = $9532;
  GL_SUBGROUP_SUPPORTED_STAGES_KHR = $9533;
  GL_SUBGROUP_SUPPORTED_FEATURES_KHR = $9534;
  GL_SUBGROUP_QUAD_ALL_STAGES_KHR = $9535;
  GL_SUBGROUP_FEATURE_BASIC_BIT_KHR = $00000001;
  GL_SUBGROUP_FEATURE_VOTE_BIT_KHR = $00000002;
  GL_SUBGROUP_FEATURE_ARITHMETIC_BIT_KHR = $00000004;
  GL_SUBGROUP_FEATURE_BALLOT_BIT_KHR = $00000008;
  GL_SUBGROUP_FEATURE_SHUFFLE_BIT_KHR = $00000010;
  GL_SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT_KHR = $00000020;
  GL_SUBGROUP_FEATURE_CLUSTERED_BIT_KHR = $00000040;
  GL_SUBGROUP_FEATURE_QUAD_BIT_KHR = $00000080;
  // GL_KHR_texture_compression_astc_hdr
  GL_COMPRESSED_RGBA_ASTC_4x4_KHR = $93B0;
  GL_COMPRESSED_RGBA_ASTC_5x4_KHR = $93B1;
  GL_COMPRESSED_RGBA_ASTC_5x5_KHR = $93B2;
  GL_COMPRESSED_RGBA_ASTC_6x5_KHR = $93B3;
  GL_COMPRESSED_RGBA_ASTC_6x6_KHR = $93B4;
  GL_COMPRESSED_RGBA_ASTC_8x5_KHR = $93B5;
  GL_COMPRESSED_RGBA_ASTC_8x6_KHR = $93B6;
  GL_COMPRESSED_RGBA_ASTC_8x8_KHR = $93B7;
  GL_COMPRESSED_RGBA_ASTC_10x5_KHR = $93B8;
  GL_COMPRESSED_RGBA_ASTC_10x6_KHR = $93B9;
  GL_COMPRESSED_RGBA_ASTC_10x8_KHR = $93BA;
  GL_COMPRESSED_RGBA_ASTC_10x10_KHR = $93BB;
  GL_COMPRESSED_RGBA_ASTC_12x10_KHR = $93BC;
  GL_COMPRESSED_RGBA_ASTC_12x12_KHR = $93BD;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = $93D0;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = $93D1;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = $93D2;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = $93D3;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = $93D4;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = $93D5;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = $93D6;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = $93D7;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = $93D8;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = $93D9;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = $93DA;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = $93DB;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = $93DC;
  GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = $93DD;
      // GL_OES_compressed_paletted_texture
      GL_PALETTE4_RGB8_OES = $8B90;
      GL_PALETTE4_RGBA8_OES = $8B91;
      GL_PALETTE4_R5_G6_B5_OES = $8B92;
      GL_PALETTE4_RGBA4_OES = $8B93;
      GL_PALETTE4_RGB5_A1_OES = $8B94;
      GL_PALETTE8_RGB8_OES = $8B95;
      GL_PALETTE8_RGBA8_OES = $8B96;
      GL_PALETTE8_R5_G6_B5_OES = $8B97;
      GL_PALETTE8_RGBA4_OES = $8B98;
      GL_PALETTE8_RGB5_A1_OES = $8B99;
      // GL_OES_fixed_point
      GL_FIXED_OES = $140C;
      // GL_OES_read_format
      GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = $8B9A;
      GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = $8B9B;
      // GL_3DFX_multisample
      GL_MULTISAMPLE_3DFX = $86B2;
      GL_SAMPLE_BUFFERS_3DFX = $86B3;
      GL_SAMPLES_3DFX = $86B4;
      GL_MULTISAMPLE_BIT_3DFX = $20000000;
      // GL_3DFX_texture_compression_FXT1
      GL_COMPRESSED_RGB_FXT1_3DFX = $86B0;
      GL_COMPRESSED_RGBA_FXT1_3DFX = $86B1;
      // GL_AMD_blend_minmax_factor
      GL_FACTOR_MIN_AMD = $901C;
      GL_FACTOR_MAX_AMD = $901D;
      // GL_AMD_debug_output
      GL_MAX_DEBUG_MESSAGE_LENGTH_AMD = $9143;
      GL_MAX_DEBUG_LOGGED_MESSAGES_AMD = $9144;
      GL_DEBUG_LOGGED_MESSAGES_AMD = $9145;
      GL_DEBUG_SEVERITY_HIGH_AMD = $9146;
      GL_DEBUG_SEVERITY_MEDIUM_AMD = $9147;
      GL_DEBUG_SEVERITY_LOW_AMD = $9148;
      GL_DEBUG_CATEGORY_API_ERROR_AMD = $9149;
      GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD = $914A;
      GL_DEBUG_CATEGORY_DEPRECATION_AMD = $914B;
      GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD = $914C;
      GL_DEBUG_CATEGORY_PERFORMANCE_AMD = $914D;
      GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD = $914E;
      GL_DEBUG_CATEGORY_APPLICATION_AMD = $914F;
      GL_DEBUG_CATEGORY_OTHER_AMD = $9150;
      // GL_AMD_depth_clamp_separate
      GL_DEPTH_CLAMP_NEAR_AMD = $901E;
      GL_DEPTH_CLAMP_FAR_AMD = $901F;
  // GL_AMD_framebuffer_multisample_advanced
  GL_RENDERBUFFER_STORAGE_SAMPLES_AMD = $91B2;
  GL_MAX_COLOR_FRAMEBUFFER_SAMPLES_AMD = $91B3;
  GL_MAX_COLOR_FRAMEBUFFER_STORAGE_SAMPLES_AMD = $91B4;
  GL_MAX_DEPTH_STENCIL_FRAMEBUFFER_SAMPLES_AMD = $91B5;
  GL_NUM_SUPPORTED_MULTISAMPLE_MODES_AMD = $91B6;
  GL_SUPPORTED_MULTISAMPLE_MODES_AMD = $91B7;
      // GL_AMD_framebuffer_sample_positions
      GL_SUBSAMPLE_DISTANCE_AMD = $883F;
      GL_PIXELS_PER_SAMPLE_PATTERN_X_AMD = $91AE;
      GL_PIXELS_PER_SAMPLE_PATTERN_Y_AMD = $91AF;
      GL_ALL_PIXELS_AMD = $FFFFFFFF;
      // GL_AMD_gpu_shader_half_float
      GL_FLOAT16_NV = $8FF8;
      GL_FLOAT16_VEC2_NV = $8FF9;
      GL_FLOAT16_VEC3_NV = $8FFA;
      GL_FLOAT16_VEC4_NV = $8FFB;
      GL_FLOAT16_MAT2_AMD = $91C5;
      GL_FLOAT16_MAT3_AMD = $91C6;
      GL_FLOAT16_MAT4_AMD = $91C7;
      GL_FLOAT16_MAT2x3_AMD = $91C8;
      GL_FLOAT16_MAT2x4_AMD = $91C9;
      GL_FLOAT16_MAT3x2_AMD = $91CA;
      GL_FLOAT16_MAT3x4_AMD = $91CB;
      GL_FLOAT16_MAT4x2_AMD = $91CC;
      GL_FLOAT16_MAT4x3_AMD = $91CD;
      // GL_AMD_gpu_shader_int64
      GL_INT64_NV = $140E;
      GL_UNSIGNED_INT64_NV = $140F;
      GL_INT8_NV = $8FE0;
      GL_INT8_VEC2_NV = $8FE1;
      GL_INT8_VEC3_NV = $8FE2;
      GL_INT8_VEC4_NV = $8FE3;
      GL_INT16_NV = $8FE4;
      GL_INT16_VEC2_NV = $8FE5;
      GL_INT16_VEC3_NV = $8FE6;
      GL_INT16_VEC4_NV = $8FE7;
      GL_INT64_VEC2_NV = $8FE9;
      GL_INT64_VEC3_NV = $8FEA;
      GL_INT64_VEC4_NV = $8FEB;
      GL_UNSIGNED_INT8_NV = $8FEC;
      GL_UNSIGNED_INT8_VEC2_NV = $8FED;
      GL_UNSIGNED_INT8_VEC3_NV = $8FEE;
      GL_UNSIGNED_INT8_VEC4_NV = $8FEF;
      GL_UNSIGNED_INT16_NV = $8FF0;
      GL_UNSIGNED_INT16_VEC2_NV = $8FF1;
      GL_UNSIGNED_INT16_VEC3_NV = $8FF2;
      GL_UNSIGNED_INT16_VEC4_NV = $8FF3;
      GL_UNSIGNED_INT64_VEC2_NV = $8FF5;
      GL_UNSIGNED_INT64_VEC3_NV = $8FF6;
      GL_UNSIGNED_INT64_VEC4_NV = $8FF7;
      // GL_AMD_interleaved_elements
      GL_VERTEX_ELEMENT_SWIZZLE_AMD = $91A4;
      GL_VERTEX_ID_SWIZZLE_AMD = $91A5;
      // GL_AMD_name_gen_delete
      GL_DATA_BUFFER_AMD = $9151;
      GL_PERFORMANCE_MONITOR_AMD = $9152;
      GL_QUERY_OBJECT_AMD = $9153;
      GL_VERTEX_ARRAY_OBJECT_AMD = $9154;
      GL_SAMPLER_OBJECT_AMD = $9155;
      // GL_AMD_occlusion_query_event
      GL_OCCLUSION_QUERY_EVENT_MASK_AMD = $874F;
      GL_QUERY_DEPTH_PASS_EVENT_BIT_AMD = $00000001;
      GL_QUERY_DEPTH_FAIL_EVENT_BIT_AMD = $00000002;
      GL_QUERY_STENCIL_FAIL_EVENT_BIT_AMD = $00000004;
      GL_QUERY_DEPTH_BOUNDS_FAIL_EVENT_BIT_AMD = $00000008;
      GL_QUERY_ALL_EVENT_BITS_AMD = $FFFFFFFF;
  // GL_AMD_performance_monitor
  GL_COUNTER_TYPE_AMD = $8BC0;
  GL_COUNTER_RANGE_AMD = $8BC1;
  GL_UNSIGNED_INT64_AMD = $8BC2;
  GL_PERCENTAGE_AMD = $8BC3;
  GL_PERFMON_RESULT_AVAILABLE_AMD = $8BC4;
  GL_PERFMON_RESULT_SIZE_AMD = $8BC5;
  GL_PERFMON_RESULT_AMD = $8BC6;
      // GL_AMD_pinned_memory
      GL_EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD = $9160;
      // GL_AMD_query_buffer_object
      GL_QUERY_BUFFER_AMD = $9192;
      GL_QUERY_BUFFER_BINDING_AMD = $9193;
      GL_QUERY_RESULT_NO_WAIT_AMD = $9194;
      // GL_AMD_sparse_texture
      GL_VIRTUAL_PAGE_SIZE_X_AMD = $9195;
      GL_VIRTUAL_PAGE_SIZE_Y_AMD = $9196;
      GL_VIRTUAL_PAGE_SIZE_Z_AMD = $9197;
      GL_MAX_SPARSE_TEXTURE_SIZE_AMD = $9198;
      GL_MAX_SPARSE_3D_TEXTURE_SIZE_AMD = $9199;
      GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS = $919A;
      GL_MIN_SPARSE_LEVEL_AMD = $919B;
      GL_MIN_LOD_WARNING_AMD = $919C;
      GL_TEXTURE_STORAGE_SPARSE_BIT_AMD = $00000001;
      // GL_AMD_stencil_operation_extended
      GL_SET_AMD = $874A;
      GL_REPLACE_VALUE_AMD = $874B;
      GL_STENCIL_OP_VALUE_AMD = $874C;
      GL_STENCIL_BACK_OP_VALUE_AMD = $874D;
      // GL_AMD_transform_feedback4
      GL_STREAM_RASTERIZATION_AMD = $91A0;
      // GL_AMD_vertex_shader_tessellator
      GL_SAMPLER_BUFFER_AMD = $9001;
      GL_INT_SAMPLER_BUFFER_AMD = $9002;
      GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD = $9003;
      GL_TESSELLATION_MODE_AMD = $9004;
      GL_TESSELLATION_FACTOR_AMD = $9005;
      GL_DISCRETE_AMD = $9006;
      GL_CONTINUOUS_AMD = $9007;
      // GL_APPLE_aux_depth_stencil
      GL_AUX_DEPTH_STENCIL_APPLE = $8A14;
      // GL_APPLE_client_storage
      GL_UNPACK_CLIENT_STORAGE_APPLE = $85B2;
      // GL_APPLE_element_array
      GL_ELEMENT_ARRAY_APPLE = $8A0C;
      GL_ELEMENT_ARRAY_TYPE_APPLE = $8A0D;
      GL_ELEMENT_ARRAY_POINTER_APPLE = $8A0E;
      // GL_APPLE_fence
      GL_DRAW_PIXELS_APPLE = $8A0A;
      GL_FENCE_APPLE = $8A0B;
      // GL_APPLE_float_pixels
      GL_HALF_APPLE = $140B;
      GL_RGBA_FLOAT32_APPLE = $8814;
      GL_RGB_FLOAT32_APPLE = $8815;
      GL_ALPHA_FLOAT32_APPLE = $8816;
      GL_INTENSITY_FLOAT32_APPLE = $8817;
      GL_LUMINANCE_FLOAT32_APPLE = $8818;
      GL_LUMINANCE_ALPHA_FLOAT32_APPLE = $8819;
      GL_RGBA_FLOAT16_APPLE = $881A;
      GL_RGB_FLOAT16_APPLE = $881B;
      GL_ALPHA_FLOAT16_APPLE = $881C;
      GL_INTENSITY_FLOAT16_APPLE = $881D;
      GL_LUMINANCE_FLOAT16_APPLE = $881E;
      GL_LUMINANCE_ALPHA_FLOAT16_APPLE = $881F;
      GL_COLOR_FLOAT_APPLE = $8A0F;
      // GL_APPLE_flush_buffer_range
      GL_BUFFER_SERIALIZED_MODIFY_APPLE = $8A12;
      GL_BUFFER_FLUSHING_UNMAP_APPLE = $8A13;
      // GL_APPLE_object_purgeable
      GL_BUFFER_OBJECT_APPLE = $85B3;
      GL_RELEASED_APPLE = $8A19;
      GL_VOLATILE_APPLE = $8A1A;
      GL_RETAINED_APPLE = $8A1B;
      GL_UNDEFINED_APPLE = $8A1C;
      GL_PURGEABLE_APPLE = $8A1D;
  // GL_APPLE_rgb_422
  GL_RGB_422_APPLE = $8A1F;
  GL_UNSIGNED_SHORT_8_8_APPLE = $85BA;
  GL_UNSIGNED_SHORT_8_8_REV_APPLE = $85BB;
  GL_RGB_RAW_422_APPLE = $8A51;
      // GL_APPLE_row_bytes
      GL_PACK_ROW_BYTES_APPLE = $8A15;
      GL_UNPACK_ROW_BYTES_APPLE = $8A16;
      // GL_APPLE_specular_vector
      GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE = $85B0;
      // GL_APPLE_texture_range
      GL_TEXTURE_RANGE_LENGTH_APPLE = $85B7;
      GL_TEXTURE_RANGE_POINTER_APPLE = $85B8;
      GL_TEXTURE_STORAGE_HINT_APPLE = $85BC;
      GL_STORAGE_PRIVATE_APPLE = $85BD;
      GL_STORAGE_CACHED_APPLE = $85BE;
      GL_STORAGE_SHARED_APPLE = $85BF;
      // GL_APPLE_transform_hint
      GL_TRANSFORM_HINT_APPLE = $85B1;
      // GL_APPLE_vertex_array_object
      GL_VERTEX_ARRAY_BINDING_APPLE = $85B5;
      // GL_APPLE_vertex_array_range
      GL_VERTEX_ARRAY_RANGE_APPLE = $851D;
      GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE = $851E;
      GL_VERTEX_ARRAY_STORAGE_HINT_APPLE = $851F;
      GL_VERTEX_ARRAY_RANGE_POINTER_APPLE = $8521;
      GL_STORAGE_CLIENT_APPLE = $85B4;
      // GL_APPLE_vertex_program_evaluators
      GL_VERTEX_ATTRIB_MAP1_APPLE = $8A00;
      GL_VERTEX_ATTRIB_MAP2_APPLE = $8A01;
      GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE = $8A02;
      GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE = $8A03;
      GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE = $8A04;
      GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE = $8A05;
      GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE = $8A06;
      GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE = $8A07;
      GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE = $8A08;
      GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE = $8A09;
      // GL_APPLE_ycbcr_422
      GL_YCBCR_422_APPLE = $85B9;
      // GL_ATI_draw_buffers
      GL_MAX_DRAW_BUFFERS_ATI = $8824;
      GL_DRAW_BUFFER0_ATI = $8825;
      GL_DRAW_BUFFER1_ATI = $8826;
      GL_DRAW_BUFFER2_ATI = $8827;
      GL_DRAW_BUFFER3_ATI = $8828;
      GL_DRAW_BUFFER4_ATI = $8829;
      GL_DRAW_BUFFER5_ATI = $882A;
      GL_DRAW_BUFFER6_ATI = $882B;
      GL_DRAW_BUFFER7_ATI = $882C;
      GL_DRAW_BUFFER8_ATI = $882D;
      GL_DRAW_BUFFER9_ATI = $882E;
      GL_DRAW_BUFFER10_ATI = $882F;
      GL_DRAW_BUFFER11_ATI = $8830;
      GL_DRAW_BUFFER12_ATI = $8831;
      GL_DRAW_BUFFER13_ATI = $8832;
      GL_DRAW_BUFFER14_ATI = $8833;
      GL_DRAW_BUFFER15_ATI = $8834;
      // GL_ATI_element_array
      GL_ELEMENT_ARRAY_ATI = $8768;
      GL_ELEMENT_ARRAY_TYPE_ATI = $8769;
      GL_ELEMENT_ARRAY_POINTER_ATI = $876A;
      // GL_ATI_envmap_bumpmap
      GL_BUMP_ROT_MATRIX_ATI = $8775;
      GL_BUMP_ROT_MATRIX_SIZE_ATI = $8776;
      GL_BUMP_NUM_TEX_UNITS_ATI = $8777;
      GL_BUMP_TEX_UNITS_ATI = $8778;
      GL_DUDV_ATI = $8779;
      GL_DU8DV8_ATI = $877A;
      GL_BUMP_ENVMAP_ATI = $877B;
      GL_BUMP_TARGET_ATI = $877C;
      // GL_ATI_fragment_shader
      GL_FRAGMENT_SHADER_ATI = $8920;
      GL_REG_0_ATI = $8921;
      GL_REG_1_ATI = $8922;
      GL_REG_2_ATI = $8923;
      GL_REG_3_ATI = $8924;
      GL_REG_4_ATI = $8925;
      GL_REG_5_ATI = $8926;
      GL_REG_6_ATI = $8927;
      GL_REG_7_ATI = $8928;
      GL_REG_8_ATI = $8929;
      GL_REG_9_ATI = $892A;
      GL_REG_10_ATI = $892B;
      GL_REG_11_ATI = $892C;
      GL_REG_12_ATI = $892D;
      GL_REG_13_ATI = $892E;
      GL_REG_14_ATI = $892F;
      GL_REG_15_ATI = $8930;
      GL_REG_16_ATI = $8931;
      GL_REG_17_ATI = $8932;
      GL_REG_18_ATI = $8933;
      GL_REG_19_ATI = $8934;
      GL_REG_20_ATI = $8935;
      GL_REG_21_ATI = $8936;
      GL_REG_22_ATI = $8937;
      GL_REG_23_ATI = $8938;
      GL_REG_24_ATI = $8939;
      GL_REG_25_ATI = $893A;
      GL_REG_26_ATI = $893B;
      GL_REG_27_ATI = $893C;
      GL_REG_28_ATI = $893D;
      GL_REG_29_ATI = $893E;
      GL_REG_30_ATI = $893F;
      GL_REG_31_ATI = $8940;
      GL_CON_0_ATI = $8941;
      GL_CON_1_ATI = $8942;
      GL_CON_2_ATI = $8943;
      GL_CON_3_ATI = $8944;
      GL_CON_4_ATI = $8945;
      GL_CON_5_ATI = $8946;
      GL_CON_6_ATI = $8947;
      GL_CON_7_ATI = $8948;
      GL_CON_8_ATI = $8949;
      GL_CON_9_ATI = $894A;
      GL_CON_10_ATI = $894B;
      GL_CON_11_ATI = $894C;
      GL_CON_12_ATI = $894D;
      GL_CON_13_ATI = $894E;
      GL_CON_14_ATI = $894F;
      GL_CON_15_ATI = $8950;
      GL_CON_16_ATI = $8951;
      GL_CON_17_ATI = $8952;
      GL_CON_18_ATI = $8953;
      GL_CON_19_ATI = $8954;
      GL_CON_20_ATI = $8955;
      GL_CON_21_ATI = $8956;
      GL_CON_22_ATI = $8957;
      GL_CON_23_ATI = $8958;
      GL_CON_24_ATI = $8959;
      GL_CON_25_ATI = $895A;
      GL_CON_26_ATI = $895B;
      GL_CON_27_ATI = $895C;
      GL_CON_28_ATI = $895D;
      GL_CON_29_ATI = $895E;
      GL_CON_30_ATI = $895F;
      GL_CON_31_ATI = $8960;
      GL_MOV_ATI = $8961;
      GL_ADD_ATI = $8963;
      GL_MUL_ATI = $8964;
      GL_SUB_ATI = $8965;
      GL_DOT3_ATI = $8966;
      GL_DOT4_ATI = $8967;
      GL_MAD_ATI = $8968;
      GL_LERP_ATI = $8969;
      GL_CND_ATI = $896A;
      GL_CND0_ATI = $896B;
      GL_DOT2_ADD_ATI = $896C;
      GL_SECONDARY_INTERPOLATOR_ATI = $896D;
      GL_NUM_FRAGMENT_REGISTERS_ATI = $896E;
      GL_NUM_FRAGMENT_CONSTANTS_ATI = $896F;
      GL_NUM_PASSES_ATI = $8970;
      GL_NUM_INSTRUCTIONS_PER_PASS_ATI = $8971;
      GL_NUM_INSTRUCTIONS_TOTAL_ATI = $8972;
      GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI = $8973;
      GL_NUM_LOOPBACK_COMPONENTS_ATI = $8974;
      GL_COLOR_ALPHA_PAIRING_ATI = $8975;
      GL_SWIZZLE_STR_ATI = $8976;
      GL_SWIZZLE_STQ_ATI = $8977;
      GL_SWIZZLE_STR_DR_ATI = $8978;
      GL_SWIZZLE_STQ_DQ_ATI = $8979;
      GL_SWIZZLE_STRQ_ATI = $897A;
      GL_SWIZZLE_STRQ_DQ_ATI = $897B;
      GL_RED_BIT_ATI = $00000001;
      GL_GREEN_BIT_ATI = $00000002;
      GL_BLUE_BIT_ATI = $00000004;
      GL_2X_BIT_ATI = $00000001;
      GL_4X_BIT_ATI = $00000002;
      GL_8X_BIT_ATI = $00000004;
      GL_HALF_BIT_ATI = $00000008;
      GL_QUARTER_BIT_ATI = $00000010;
      GL_EIGHTH_BIT_ATI = $00000020;
      GL_SATURATE_BIT_ATI = $00000040;
      GL_COMP_BIT_ATI = $00000002;
      GL_NEGATE_BIT_ATI = $00000004;
      GL_BIAS_BIT_ATI = $00000008;
      // GL_ATI_meminfo
      GL_VBO_FREE_MEMORY_ATI = $87FB;
      GL_TEXTURE_FREE_MEMORY_ATI = $87FC;
      GL_RENDERBUFFER_FREE_MEMORY_ATI = $87FD;
      // GL_ATI_pixel_format_float
      GL_RGBA_FLOAT_MODE_ATI = $8820;
      GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI = $8835;
      // GL_ATI_pn_triangles
      GL_PN_TRIANGLES_ATI = $87F0;
      GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI = $87F1;
      GL_PN_TRIANGLES_POINT_MODE_ATI = $87F2;
      GL_PN_TRIANGLES_NORMAL_MODE_ATI = $87F3;
      GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI = $87F4;
      GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI = $87F5;
      GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI = $87F6;
      GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI = $87F7;
      GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI = $87F8;
      // GL_ATI_separate_stencil
      GL_STENCIL_BACK_FUNC_ATI = $8800;
      GL_STENCIL_BACK_FAIL_ATI = $8801;
      GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI = $8802;
      GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI = $8803;
      // GL_ATI_text_fragment_shader
      GL_TEXT_FRAGMENT_SHADER_ATI = $8200;
      // GL_ATI_texture_env_combine3
      GL_MODULATE_ADD_ATI = $8744;
      GL_MODULATE_SIGNED_ADD_ATI = $8745;
      GL_MODULATE_SUBTRACT_ATI = $8746;
      // GL_ATI_texture_float
      GL_RGBA_FLOAT32_ATI = $8814;
      GL_RGB_FLOAT32_ATI = $8815;
      GL_ALPHA_FLOAT32_ATI = $8816;
      GL_INTENSITY_FLOAT32_ATI = $8817;
      GL_LUMINANCE_FLOAT32_ATI = $8818;
      GL_LUMINANCE_ALPHA_FLOAT32_ATI = $8819;
      GL_RGBA_FLOAT16_ATI = $881A;
      GL_RGB_FLOAT16_ATI = $881B;
      GL_ALPHA_FLOAT16_ATI = $881C;
      GL_INTENSITY_FLOAT16_ATI = $881D;
      GL_LUMINANCE_FLOAT16_ATI = $881E;
      GL_LUMINANCE_ALPHA_FLOAT16_ATI = $881F;
      // GL_ATI_texture_mirror_once
      GL_MIRROR_CLAMP_ATI = $8742;
      GL_MIRROR_CLAMP_TO_EDGE_ATI = $8743;
      // GL_ATI_vertex_array_object
      GL_STATIC_ATI = $8760;
      GL_DYNAMIC_ATI = $8761;
      GL_PRESERVE_ATI = $8762;
      GL_DISCARD_ATI = $8763;
      GL_OBJECT_BUFFER_SIZE_ATI = $8764;
      GL_OBJECT_BUFFER_USAGE_ATI = $8765;
      GL_ARRAY_OBJECT_BUFFER_ATI = $8766;
      GL_ARRAY_OBJECT_OFFSET_ATI = $8767;
      // GL_ATI_vertex_streams
      GL_MAX_VERTEX_STREAMS_ATI = $876B;
      GL_VERTEX_STREAM0_ATI = $876C;
      GL_VERTEX_STREAM1_ATI = $876D;
      GL_VERTEX_STREAM2_ATI = $876E;
      GL_VERTEX_STREAM3_ATI = $876F;
      GL_VERTEX_STREAM4_ATI = $8770;
      GL_VERTEX_STREAM5_ATI = $8771;
      GL_VERTEX_STREAM6_ATI = $8772;
      GL_VERTEX_STREAM7_ATI = $8773;
      GL_VERTEX_SOURCE_ATI = $8774;
      // GL_EXT_422_pixels
      GL_422_EXT = $80CC;
      GL_422_REV_EXT = $80CD;
      GL_422_AVERAGE_EXT = $80CE;
      GL_422_REV_AVERAGE_EXT = $80CF;
      // GL_EXT_abgr
      GL_ABGR_EXT = $8000;
      // GL_EXT_bgra
      GL_BGR_EXT = $80E0;
      GL_BGRA_EXT = $80E1;
      // GL_EXT_bindable_uniform
      GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT = $8DE2;
      GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = $8DE3;
      GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = $8DE4;
      GL_MAX_BINDABLE_UNIFORM_SIZE_EXT = $8DED;
      GL_UNIFORM_BUFFER_EXT = $8DEE;
      GL_UNIFORM_BUFFER_BINDING_EXT = $8DEF;
      // GL_EXT_blend_color
      GL_CONSTANT_COLOR_EXT = $8001;
      GL_ONE_MINUS_CONSTANT_COLOR_EXT = $8002;
      GL_CONSTANT_ALPHA_EXT = $8003;
      GL_ONE_MINUS_CONSTANT_ALPHA_EXT = $8004;
      GL_BLEND_COLOR_EXT = $8005;
      // GL_EXT_blend_equation_separate
      GL_BLEND_EQUATION_RGB_EXT = $8009;
      GL_BLEND_EQUATION_ALPHA_EXT = $883D;
      // GL_EXT_blend_func_separate
      GL_BLEND_DST_RGB_EXT = $80C8;
      GL_BLEND_SRC_RGB_EXT = $80C9;
      GL_BLEND_DST_ALPHA_EXT = $80CA;
      GL_BLEND_SRC_ALPHA_EXT = $80CB;
      // GL_EXT_blend_minmax
      GL_MIN_EXT = $8007;
      GL_MAX_EXT = $8008;
      GL_FUNC_ADD_EXT = $8006;
      GL_BLEND_EQUATION_EXT = $8009;
      // GL_EXT_blend_subtract
      GL_FUNC_SUBTRACT_EXT = $800A;
      GL_FUNC_REVERSE_SUBTRACT_EXT = $800B;
      // GL_EXT_clip_volume_hint
      GL_CLIP_VOLUME_CLIPPING_HINT_EXT = $80F0;
      // GL_EXT_cmyka
      GL_CMYK_EXT = $800C;
      GL_CMYKA_EXT = $800D;
      GL_PACK_CMYK_HINT_EXT = $800E;
      GL_UNPACK_CMYK_HINT_EXT = $800F;
      // GL_EXT_compiled_vertex_array
      GL_ARRAY_ELEMENT_LOCK_FIRST_EXT = $81A8;
      GL_ARRAY_ELEMENT_LOCK_COUNT_EXT = $81A9;
      // GL_EXT_convolution
      GL_CONVOLUTION_1D_EXT = $8010;
      GL_CONVOLUTION_2D_EXT = $8011;
      GL_SEPARABLE_2D_EXT = $8012;
      GL_CONVOLUTION_BORDER_MODE_EXT = $8013;
      GL_CONVOLUTION_FILTER_SCALE_EXT = $8014;
      GL_CONVOLUTION_FILTER_BIAS_EXT = $8015;
      GL_REDUCE_EXT = $8016;
      GL_CONVOLUTION_FORMAT_EXT = $8017;
      GL_CONVOLUTION_WIDTH_EXT = $8018;
      GL_CONVOLUTION_HEIGHT_EXT = $8019;
      GL_MAX_CONVOLUTION_WIDTH_EXT = $801A;
      GL_MAX_CONVOLUTION_HEIGHT_EXT = $801B;
      GL_POST_CONVOLUTION_RED_SCALE_EXT = $801C;
      GL_POST_CONVOLUTION_GREEN_SCALE_EXT = $801D;
      GL_POST_CONVOLUTION_BLUE_SCALE_EXT = $801E;
      GL_POST_CONVOLUTION_ALPHA_SCALE_EXT = $801F;
      GL_POST_CONVOLUTION_RED_BIAS_EXT = $8020;
      GL_POST_CONVOLUTION_GREEN_BIAS_EXT = $8021;
      GL_POST_CONVOLUTION_BLUE_BIAS_EXT = $8022;
      GL_POST_CONVOLUTION_ALPHA_BIAS_EXT = $8023;
      // GL_EXT_coordinate_frame
      GL_TANGENT_ARRAY_EXT = $8439;
      GL_BINORMAL_ARRAY_EXT = $843A;
      GL_CURRENT_TANGENT_EXT = $843B;
      GL_CURRENT_BINORMAL_EXT = $843C;
      GL_TANGENT_ARRAY_TYPE_EXT = $843E;
      GL_TANGENT_ARRAY_STRIDE_EXT = $843F;
      GL_BINORMAL_ARRAY_TYPE_EXT = $8440;
      GL_BINORMAL_ARRAY_STRIDE_EXT = $8441;
      GL_TANGENT_ARRAY_POINTER_EXT = $8442;
      GL_BINORMAL_ARRAY_POINTER_EXT = $8443;
      GL_MAP1_TANGENT_EXT = $8444;
      GL_MAP2_TANGENT_EXT = $8445;
      GL_MAP1_BINORMAL_EXT = $8446;
      GL_MAP2_BINORMAL_EXT = $8447;
      // GL_EXT_cull_vertex
      GL_CULL_VERTEX_EXT = $81AA;
      GL_CULL_VERTEX_EYE_POSITION_EXT = $81AB;
      GL_CULL_VERTEX_OBJECT_POSITION_EXT = $81AC;
  // GL_EXT_debug_label
  GL_PROGRAM_PIPELINE_OBJECT_EXT = $8A4F;
  GL_PROGRAM_OBJECT_EXT = $8B40;
  GL_SHADER_OBJECT_EXT = $8B48;
  GL_BUFFER_OBJECT_EXT = $9151;
  GL_QUERY_OBJECT_EXT = $9153;
  GL_VERTEX_ARRAY_OBJECT_EXT = $9154;
      // GL_EXT_depth_bounds_test
      GL_DEPTH_BOUNDS_TEST_EXT = $8890;    // есть и там и там, только константы на расширенном
      GL_DEPTH_BOUNDS_EXT = $8891;
  // GL_EXT_direct_state_access
  GL_PROGRAM_MATRIX_EXT = $8E2D;
  GL_TRANSPOSE_PROGRAM_MATRIX_EXT = $8E2E;
  GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = $8E2F;
      // GL_EXT_draw_range_elements
      GL_MAX_ELEMENTS_VERTICES_EXT = $80E8;
      GL_MAX_ELEMENTS_INDICES_EXT = $80E9;
      // GL_EXT_fog_coord
      GL_FOG_COORDINATE_SOURCE_EXT = $8450;
      GL_FOG_COORDINATE_EXT = $8451;
      GL_FRAGMENT_DEPTH_EXT = $8452;
      GL_CURRENT_FOG_COORDINATE_EXT = $8453;
      GL_FOG_COORDINATE_ARRAY_TYPE_EXT = $8454;
      GL_FOG_COORDINATE_ARRAY_STRIDE_EXT = $8455;
      GL_FOG_COORDINATE_ARRAY_POINTER_EXT = $8456;
      GL_FOG_COORDINATE_ARRAY_EXT = $8457;
      // GL_EXT_framebuffer_blit
      GL_READ_FRAMEBUFFER_EXT = $8CA8;
      GL_DRAW_FRAMEBUFFER_EXT = $8CA9;
      GL_DRAW_FRAMEBUFFER_BINDING_EXT = $8CA6;
      GL_READ_FRAMEBUFFER_BINDING_EXT = $8CAA;
      // GL_EXT_framebuffer_multisample
      GL_RENDERBUFFER_SAMPLES_EXT = $8CAB;
      GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = $8D56;
      GL_MAX_SAMPLES_EXT = $8D57;
      // GL_EXT_framebuffer_multisample_blit_scaled
      GL_SCALED_RESOLVE_FASTEST_EXT = $90BA;
      GL_SCALED_RESOLVE_NICEST_EXT = $90BB;
      // GL_EXT_framebuffer_object
      GL_INVALID_FRAMEBUFFER_OPERATION_EXT = $0506;
      GL_MAX_RENDERBUFFER_SIZE_EXT = $84E8;
      GL_FRAMEBUFFER_BINDING_EXT = $8CA6;
      GL_RENDERBUFFER_BINDING_EXT = $8CA7;
      GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT = $8CD0;
      GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT = $8CD1;
      GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT = $8CD2;
      GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT = $8CD3;
      GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT = $8CD4;
      GL_FRAMEBUFFER_COMPLETE_EXT = $8CD5;
      GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT = $8CD6;
      GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT = $8CD7;
      GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT = $8CD9;
      GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT = $8CDA;
      GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT = $8CDB;
      GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT = $8CDC;
      GL_FRAMEBUFFER_UNSUPPORTED_EXT = $8CDD;
      GL_MAX_COLOR_ATTACHMENTS_EXT = $8CDF;
      GL_COLOR_ATTACHMENT0_EXT = $8CE0;
      GL_COLOR_ATTACHMENT1_EXT = $8CE1;
      GL_COLOR_ATTACHMENT2_EXT = $8CE2;
      GL_COLOR_ATTACHMENT3_EXT = $8CE3;
      GL_COLOR_ATTACHMENT4_EXT = $8CE4;
      GL_COLOR_ATTACHMENT5_EXT = $8CE5;
      GL_COLOR_ATTACHMENT6_EXT = $8CE6;
      GL_COLOR_ATTACHMENT7_EXT = $8CE7;
      GL_COLOR_ATTACHMENT8_EXT = $8CE8;
      GL_COLOR_ATTACHMENT9_EXT = $8CE9;
      GL_COLOR_ATTACHMENT10_EXT = $8CEA;
      GL_COLOR_ATTACHMENT11_EXT = $8CEB;
      GL_COLOR_ATTACHMENT12_EXT = $8CEC;
      GL_COLOR_ATTACHMENT13_EXT = $8CED;
      GL_COLOR_ATTACHMENT14_EXT = $8CEE;
      GL_COLOR_ATTACHMENT15_EXT = $8CEF;
      GL_DEPTH_ATTACHMENT_EXT = $8D00;
      GL_STENCIL_ATTACHMENT_EXT = $8D20;
      GL_FRAMEBUFFER_EXT = $8D40;
      GL_RENDERBUFFER_EXT = $8D41;
      GL_RENDERBUFFER_WIDTH_EXT = $8D42;
      GL_RENDERBUFFER_HEIGHT_EXT = $8D43;
      GL_RENDERBUFFER_INTERNAL_FORMAT_EXT = $8D44;
      GL_STENCIL_INDEX1_EXT = $8D46;
      GL_STENCIL_INDEX4_EXT = $8D47;
      GL_STENCIL_INDEX8_EXT = $8D48;
      GL_STENCIL_INDEX16_EXT = $8D49;
      GL_RENDERBUFFER_RED_SIZE_EXT = $8D50;
      GL_RENDERBUFFER_GREEN_SIZE_EXT = $8D51;
      GL_RENDERBUFFER_BLUE_SIZE_EXT = $8D52;
      GL_RENDERBUFFER_ALPHA_SIZE_EXT = $8D53;
      GL_RENDERBUFFER_DEPTH_SIZE_EXT = $8D54;
      GL_RENDERBUFFER_STENCIL_SIZE_EXT = $8D55;
      // GL_EXT_framebuffer_sRGB
      GL_FRAMEBUFFER_SRGB_EXT = $8DB9;
      GL_FRAMEBUFFER_SRGB_CAPABLE_EXT = $8DBA;
      // GL_EXT_geometry_shader4
      GL_GEOMETRY_SHADER_EXT = $8DD9;
      GL_GEOMETRY_VERTICES_OUT_EXT = $8DDA;
      GL_GEOMETRY_INPUT_TYPE_EXT = $8DDB;
      GL_GEOMETRY_OUTPUT_TYPE_EXT = $8DDC;
      GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = $8C29;
      GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT = $8DDD;
      GL_MAX_VERTEX_VARYING_COMPONENTS_EXT = $8DDE;
      GL_MAX_VARYING_COMPONENTS_EXT = $8B4B;
      GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = $8DDF;
      GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = $8DE0;
      GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = $8DE1;
      GL_LINES_ADJACENCY_EXT = $000A;
      GL_LINE_STRIP_ADJACENCY_EXT = $000B;
      GL_TRIANGLES_ADJACENCY_EXT = $000C;
      GL_TRIANGLE_STRIP_ADJACENCY_EXT = $000D;
      GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = $8DA8;
      GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = $8DA9;
      GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = $8DA7;
      GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = $8CD4;
      GL_PROGRAM_POINT_SIZE_EXT = $8642;
      // GL_EXT_gpu_shader4
      GL_SAMPLER_1D_ARRAY_EXT = $8DC0;
      GL_SAMPLER_2D_ARRAY_EXT = $8DC1;
      GL_SAMPLER_BUFFER_EXT = $8DC2;
      GL_SAMPLER_1D_ARRAY_SHADOW_EXT = $8DC3;
      GL_SAMPLER_2D_ARRAY_SHADOW_EXT = $8DC4;
      GL_SAMPLER_CUBE_SHADOW_EXT = $8DC5;
      GL_UNSIGNED_INT_VEC2_EXT = $8DC6;
      GL_UNSIGNED_INT_VEC3_EXT = $8DC7;
      GL_UNSIGNED_INT_VEC4_EXT = $8DC8;
      GL_INT_SAMPLER_1D_EXT = $8DC9;
      GL_INT_SAMPLER_2D_EXT = $8DCA;
      GL_INT_SAMPLER_3D_EXT = $8DCB;
      GL_INT_SAMPLER_CUBE_EXT = $8DCC;
      GL_INT_SAMPLER_2D_RECT_EXT = $8DCD;
      GL_INT_SAMPLER_1D_ARRAY_EXT = $8DCE;
      GL_INT_SAMPLER_2D_ARRAY_EXT = $8DCF;
      GL_INT_SAMPLER_BUFFER_EXT = $8DD0;
      GL_UNSIGNED_INT_SAMPLER_1D_EXT = $8DD1;
      GL_UNSIGNED_INT_SAMPLER_2D_EXT = $8DD2;
      GL_UNSIGNED_INT_SAMPLER_3D_EXT = $8DD3;
      GL_UNSIGNED_INT_SAMPLER_CUBE_EXT = $8DD4;
      GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT = $8DD5;
      GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT = $8DD6;
      GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT = $8DD7;
      GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT = $8DD8;
      GL_MIN_PROGRAM_TEXEL_OFFSET_EXT = $8904;
      GL_MAX_PROGRAM_TEXEL_OFFSET_EXT = $8905;
      GL_VERTEX_ATTRIB_ARRAY_INTEGER_EXT = $88FD;
      // GL_EXT_histogram
      GL_HISTOGRAM_EXT = $8024;
      GL_PROXY_HISTOGRAM_EXT = $8025;
      GL_HISTOGRAM_WIDTH_EXT = $8026;
      GL_HISTOGRAM_FORMAT_EXT = $8027;
      GL_HISTOGRAM_RED_SIZE_EXT = $8028;
      GL_HISTOGRAM_GREEN_SIZE_EXT = $8029;
      GL_HISTOGRAM_BLUE_SIZE_EXT = $802A;
      GL_HISTOGRAM_ALPHA_SIZE_EXT = $802B;
      GL_HISTOGRAM_LUMINANCE_SIZE_EXT = $802C;
      GL_HISTOGRAM_SINK_EXT = $802D;
      GL_MINMAX_EXT = $802E;
      GL_MINMAX_FORMAT_EXT = $802F;
      GL_MINMAX_SINK_EXT = $8030;
      GL_TABLE_TOO_LARGE_EXT = $8031;
      // GL_EXT_index_array_formats
      GL_IUI_V2F_EXT = $81AD;
      GL_IUI_V3F_EXT = $81AE;
      GL_IUI_N3F_V2F_EXT = $81AF;
      GL_IUI_N3F_V3F_EXT = $81B0;
      GL_T2F_IUI_V2F_EXT = $81B1;
      GL_T2F_IUI_V3F_EXT = $81B2;
      GL_T2F_IUI_N3F_V2F_EXT = $81B3;
      GL_T2F_IUI_N3F_V3F_EXT = $81B4;
      // GL_EXT_index_func
      GL_INDEX_TEST_EXT = $81B5;
      GL_INDEX_TEST_FUNC_EXT = $81B6;
      GL_INDEX_TEST_REF_EXT = $81B7;
      // GL_EXT_index_material
      GL_INDEX_MATERIAL_EXT = $81B8;
      GL_INDEX_MATERIAL_PARAMETER_EXT = $81B9;
      GL_INDEX_MATERIAL_FACE_EXT = $81BA;
      // GL_EXT_light_texture
      GL_FRAGMENT_MATERIAL_EXT = $8349;
      GL_FRAGMENT_NORMAL_EXT = $834A;
      GL_FRAGMENT_COLOR_EXT = $834C;
      GL_ATTENUATION_EXT = $834D;
      GL_SHADOW_ATTENUATION_EXT = $834E;
      GL_TEXTURE_APPLICATION_MODE_EXT = $834F;
      GL_TEXTURE_LIGHT_EXT = $8350;
      GL_TEXTURE_MATERIAL_FACE_EXT = $8351;
      GL_TEXTURE_MATERIAL_PARAMETER_EXT = $8352;
      // GL_EXT_memory_object
      GL_TEXTURE_TILING_EXT = $9580;
      GL_DEDICATED_MEMORY_OBJECT_EXT = $9581;
      GL_PROTECTED_MEMORY_OBJECT_EXT = $959B;
      GL_NUM_TILING_TYPES_EXT = $9582;
      GL_TILING_TYPES_EXT = $9583;
      GL_OPTIMAL_TILING_EXT = $9584;
      GL_LINEAR_TILING_EXT = $9585;
      GL_NUM_DEVICE_UUIDS_EXT = $9596;
      GL_DEVICE_UUID_EXT = $9597;
      GL_DRIVER_UUID_EXT = $9598;
      GL_UUID_SIZE_EXT = 16;
      // GL_EXT_memory_object_fd
      GL_HANDLE_TYPE_OPAQUE_FD_EXT = $9586;
      // GL_EXT_memory_object_win32
      GL_HANDLE_TYPE_OPAQUE_WIN32_EXT = $9587;
      GL_HANDLE_TYPE_OPAQUE_WIN32_KMT_EXT = $9588;
      GL_DEVICE_LUID_EXT = $9599;
      GL_DEVICE_NODE_MASK_EXT = $959A;
      GL_LUID_SIZE_EXT = 8;
      GL_HANDLE_TYPE_D3D12_TILEPOOL_EXT = $9589;
      GL_HANDLE_TYPE_D3D12_RESOURCE_EXT = $958A;
      GL_HANDLE_TYPE_D3D11_IMAGE_EXT = $958B;
      GL_HANDLE_TYPE_D3D11_IMAGE_KMT_EXT = $958C;
      // GL_EXT_multisample
      GL_MULTISAMPLE_EXT = $809D;
      GL_SAMPLE_ALPHA_TO_MASK_EXT = $809E;
      GL_SAMPLE_ALPHA_TO_ONE_EXT = $809F;
      GL_SAMPLE_MASK_EXT = $80A0;
      GL_1PASS_EXT = $80A1;
      GL_2PASS_0_EXT = $80A2;
      GL_2PASS_1_EXT = $80A3;
      GL_4PASS_0_EXT = $80A4;
      GL_4PASS_1_EXT = $80A5;
      GL_4PASS_2_EXT = $80A6;
      GL_4PASS_3_EXT = $80A7;
      GL_SAMPLE_BUFFERS_EXT = $80A8;
      GL_SAMPLES_EXT = $80A9;
      GL_SAMPLE_MASK_VALUE_EXT = $80AA;
      GL_SAMPLE_MASK_INVERT_EXT = $80AB;
      GL_SAMPLE_PATTERN_EXT = $80AC;
      GL_MULTISAMPLE_BIT_EXT = $20000000;
      // GL_EXT_packed_depth_stencil
      GL_DEPTH_STENCIL_EXT = $84F9;
      GL_UNSIGNED_INT_24_8_EXT = $84FA;
      GL_DEPTH24_STENCIL8_EXT = $88F0;
      GL_TEXTURE_STENCIL_SIZE_EXT = $88F1;
      // GL_EXT_packed_float
      GL_R11F_G11F_B10F_EXT = $8C3A;
      GL_UNSIGNED_INT_10F_11F_11F_REV_EXT = $8C3B;
      GL_RGBA_SIGNED_COMPONENTS_EXT = $8C3C;
      // GL_EXT_packed_pixels
      GL_UNSIGNED_BYTE_3_3_2_EXT = $8032;
      GL_UNSIGNED_SHORT_4_4_4_4_EXT = $8033;
      GL_UNSIGNED_SHORT_5_5_5_1_EXT = $8034;
      GL_UNSIGNED_INT_8_8_8_8_EXT = $8035;
      GL_UNSIGNED_INT_10_10_10_2_EXT = $8036;
      // GL_EXT_paletted_texture
      GL_COLOR_INDEX1_EXT = $80E2;
      GL_COLOR_INDEX2_EXT = $80E3;
      GL_COLOR_INDEX4_EXT = $80E4;
      GL_COLOR_INDEX8_EXT = $80E5;
      GL_COLOR_INDEX12_EXT = $80E6;
      GL_COLOR_INDEX16_EXT = $80E7;
      GL_TEXTURE_INDEX_SIZE_EXT = $80ED;
      // GL_EXT_pixel_buffer_object
      GL_PIXEL_PACK_BUFFER_EXT = $88EB;
      GL_PIXEL_UNPACK_BUFFER_EXT = $88EC;
      GL_PIXEL_PACK_BUFFER_BINDING_EXT = $88ED;
      GL_PIXEL_UNPACK_BUFFER_BINDING_EXT = $88EF;
      // GL_EXT_pixel_transform
      GL_PIXEL_TRANSFORM_2D_EXT = $8330;
      GL_PIXEL_MAG_FILTER_EXT = $8331;
      GL_PIXEL_MIN_FILTER_EXT = $8332;
      GL_PIXEL_CUBIC_WEIGHT_EXT = $8333;
      GL_CUBIC_EXT = $8334;
      GL_AVERAGE_EXT = $8335;
      GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = $8336;
      GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = $8337;
      GL_PIXEL_TRANSFORM_2D_MATRIX_EXT = $8338;
      // GL_EXT_point_parameters
      GL_POINT_SIZE_MIN_EXT = $8126;
      GL_POINT_SIZE_MAX_EXT = $8127;
      GL_POINT_FADE_THRESHOLD_SIZE_EXT = $8128;
      GL_DISTANCE_ATTENUATION_EXT = $8129;
      // GL_EXT_polygon_offset
      GL_POLYGON_OFFSET_EXT = $8037;
      GL_POLYGON_OFFSET_FACTOR_EXT = $8038;
      GL_POLYGON_OFFSET_BIAS_EXT = $8039;
  // GL_EXT_polygon_offset_clamp
  GL_POLYGON_OFFSET_CLAMP_EXT = $8E1B;
      // GL_EXT_provoking_vertex
      GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = $8E4C;
      GL_FIRST_VERTEX_CONVENTION_EXT = $8E4D;
      GL_LAST_VERTEX_CONVENTION_EXT = $8E4E;
      GL_PROVOKING_VERTEX_EXT = $8E4F;
  // GL_EXT_raster_multisample
  GL_RASTER_MULTISAMPLE_EXT = $9327;
  GL_RASTER_SAMPLES_EXT = $9328;
  GL_MAX_RASTER_SAMPLES_EXT = $9329;
  GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = $932A;
  GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = $932B;
  GL_EFFECTIVE_RASTER_SAMPLES_EXT = $932C;
      // GL_EXT_rescale_normal
      GL_RESCALE_NORMAL_EXT = $803A;
      // GL_EXT_secondary_color
      GL_COLOR_SUM_EXT = $8458;
      GL_CURRENT_SECONDARY_COLOR_EXT = $8459;
      GL_SECONDARY_COLOR_ARRAY_SIZE_EXT = $845A;
      GL_SECONDARY_COLOR_ARRAY_TYPE_EXT = $845B;
      GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT = $845C;
      GL_SECONDARY_COLOR_ARRAY_POINTER_EXT = $845D;
      GL_SECONDARY_COLOR_ARRAY_EXT = $845E;
      // GL_EXT_semaphore
      GL_LAYOUT_GENERAL_EXT = $958D;
      GL_LAYOUT_COLOR_ATTACHMENT_EXT = $958E;
      GL_LAYOUT_DEPTH_STENCIL_ATTACHMENT_EXT = $958F;
      GL_LAYOUT_DEPTH_STENCIL_READ_ONLY_EXT = $9590;
      GL_LAYOUT_SHADER_READ_ONLY_EXT = $9591;
      GL_LAYOUT_TRANSFER_SRC_EXT = $9592;
      GL_LAYOUT_TRANSFER_DST_EXT = $9593;
      GL_LAYOUT_DEPTH_READ_ONLY_STENCIL_ATTACHMENT_EXT = $9530;
      GL_LAYOUT_DEPTH_ATTACHMENT_STENCIL_READ_ONLY_EXT = $9531;
      // GL_EXT_semaphore_win32
      GL_HANDLE_TYPE_D3D12_FENCE_EXT = $9594;
      GL_D3D12_FENCE_VALUE_EXT = $9595;
  // GL_EXT_separate_shader_objects
  GL_ACTIVE_PROGRAM_EXT = $8B8D;
      // GL_EXT_separate_specular_color
      GL_LIGHT_MODEL_COLOR_CONTROL_EXT = $81F8;
      GL_SINGLE_COLOR_EXT = $81F9;
      GL_SEPARATE_SPECULAR_COLOR_EXT = $81FA;
  // GL_EXT_shader_framebuffer_fetch
  GL_FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = $8A52;
      // GL_EXT_shader_image_load_store
      GL_MAX_IMAGE_UNITS_EXT = $8F38;
      GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT = $8F39;
      GL_IMAGE_BINDING_NAME_EXT = $8F3A;
      GL_IMAGE_BINDING_LEVEL_EXT = $8F3B;
      GL_IMAGE_BINDING_LAYERED_EXT = $8F3C;
      GL_IMAGE_BINDING_LAYER_EXT = $8F3D;
      GL_IMAGE_BINDING_ACCESS_EXT = $8F3E;
      GL_IMAGE_1D_EXT = $904C;
      GL_IMAGE_2D_EXT = $904D;
      GL_IMAGE_3D_EXT = $904E;
      GL_IMAGE_2D_RECT_EXT = $904F;
      GL_IMAGE_CUBE_EXT = $9050;
      GL_IMAGE_BUFFER_EXT = $9051;
      GL_IMAGE_1D_ARRAY_EXT = $9052;
      GL_IMAGE_2D_ARRAY_EXT = $9053;
      GL_IMAGE_CUBE_MAP_ARRAY_EXT = $9054;
      GL_IMAGE_2D_MULTISAMPLE_EXT = $9055;
      GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $9056;
      GL_INT_IMAGE_1D_EXT = $9057;
      GL_INT_IMAGE_2D_EXT = $9058;
      GL_INT_IMAGE_3D_EXT = $9059;
      GL_INT_IMAGE_2D_RECT_EXT = $905A;
      GL_INT_IMAGE_CUBE_EXT = $905B;
      GL_INT_IMAGE_BUFFER_EXT = $905C;
      GL_INT_IMAGE_1D_ARRAY_EXT = $905D;
      GL_INT_IMAGE_2D_ARRAY_EXT = $905E;
      GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $905F;
      GL_INT_IMAGE_2D_MULTISAMPLE_EXT = $9060;
      GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $9061;
      GL_UNSIGNED_INT_IMAGE_1D_EXT = $9062;
      GL_UNSIGNED_INT_IMAGE_2D_EXT = $9063;
      GL_UNSIGNED_INT_IMAGE_3D_EXT = $9064;
      GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT = $9065;
      GL_UNSIGNED_INT_IMAGE_CUBE_EXT = $9066;
      GL_UNSIGNED_INT_IMAGE_BUFFER_EXT = $9067;
      GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT = $9068;
      GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT = $9069;
      GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = $906A;
      GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT = $906B;
      GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = $906C;
      GL_MAX_IMAGE_SAMPLES_EXT = $906D;
      GL_IMAGE_BINDING_FORMAT_EXT = $906E;
      GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT = $00000001;
      GL_ELEMENT_ARRAY_BARRIER_BIT_EXT = $00000002;
      GL_UNIFORM_BARRIER_BIT_EXT = $00000004;
      GL_TEXTURE_FETCH_BARRIER_BIT_EXT = $00000008;
      GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT = $00000020;
      GL_COMMAND_BARRIER_BIT_EXT = $00000040;
      GL_PIXEL_BUFFER_BARRIER_BIT_EXT = $00000080;
      GL_TEXTURE_UPDATE_BARRIER_BIT_EXT = $00000100;
      GL_BUFFER_UPDATE_BARRIER_BIT_EXT = $00000200;
      GL_FRAMEBUFFER_BARRIER_BIT_EXT = $00000400;
      GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT = $00000800;
      GL_ATOMIC_COUNTER_BARRIER_BIT_EXT = $00001000;
      GL_ALL_BARRIER_BITS_EXT = $FFFFFFFF;
      // GL_EXT_shared_texture_palette
      GL_SHARED_TEXTURE_PALETTE_EXT = $81FB;
      // GL_EXT_stencil_clear_tag
      GL_STENCIL_TAG_BITS_EXT = $88F2;
      GL_STENCIL_CLEAR_TAG_VALUE_EXT = $88F3;
      // GL_EXT_stencil_two_side
      GL_STENCIL_TEST_TWO_SIDE_EXT = $8910;
      GL_ACTIVE_STENCIL_FACE_EXT = $8911;
      // GL_EXT_stencil_wrap
      GL_INCR_WRAP_EXT = $8507;
      GL_DECR_WRAP_EXT = $8508;
      // GL_EXT_texture
      GL_ALPHA4_EXT = $803B;
      GL_ALPHA8_EXT = $803C;
      GL_ALPHA12_EXT = $803D;
      GL_ALPHA16_EXT = $803E;
      GL_LUMINANCE4_EXT = $803F;
      GL_LUMINANCE8_EXT = $8040;
      GL_LUMINANCE12_EXT = $8041;
      GL_LUMINANCE16_EXT = $8042;
      GL_LUMINANCE4_ALPHA4_EXT = $8043;
      GL_LUMINANCE6_ALPHA2_EXT = $8044;
      GL_LUMINANCE8_ALPHA8_EXT = $8045;
      GL_LUMINANCE12_ALPHA4_EXT = $8046;
      GL_LUMINANCE12_ALPHA12_EXT = $8047;
      GL_LUMINANCE16_ALPHA16_EXT = $8048;
      GL_INTENSITY_EXT = $8049;
      GL_INTENSITY4_EXT = $804A;
      GL_INTENSITY8_EXT = $804B;
      GL_INTENSITY12_EXT = $804C;
      GL_INTENSITY16_EXT = $804D;
      GL_RGB2_EXT = $804E;
      GL_RGB4_EXT = $804F;
      GL_RGB5_EXT = $8050;
      GL_RGB8_EXT = $8051;
      GL_RGB10_EXT = $8052;
      GL_RGB12_EXT = $8053;
      GL_RGB16_EXT = $8054;
      GL_RGBA2_EXT = $8055;
      GL_RGBA4_EXT = $8056;
      GL_RGB5_A1_EXT = $8057;
      GL_RGBA8_EXT = $8058;
      GL_RGB10_A2_EXT = $8059;
      GL_RGBA12_EXT = $805A;
      GL_RGBA16_EXT = $805B;
      GL_TEXTURE_RED_SIZE_EXT = $805C;
      GL_TEXTURE_GREEN_SIZE_EXT = $805D;
      GL_TEXTURE_BLUE_SIZE_EXT = $805E;
      GL_TEXTURE_ALPHA_SIZE_EXT = $805F;
      GL_TEXTURE_LUMINANCE_SIZE_EXT = $8060;
      GL_TEXTURE_INTENSITY_SIZE_EXT = $8061;
      GL_REPLACE_EXT = $8062;
      GL_PROXY_TEXTURE_1D_EXT = $8063;
      GL_PROXY_TEXTURE_2D_EXT = $8064;
      GL_TEXTURE_TOO_LARGE_EXT = $8065;
      // GL_EXT_texture3D
      GL_PACK_SKIP_IMAGES_EXT = $806B;
      GL_PACK_IMAGE_HEIGHT_EXT = $806C;
      GL_UNPACK_SKIP_IMAGES_EXT = $806D;
      GL_UNPACK_IMAGE_HEIGHT_EXT = $806E;
      GL_TEXTURE_3D_EXT = $806F;
      GL_PROXY_TEXTURE_3D_EXT = $8070;
      GL_TEXTURE_DEPTH_EXT = $8071;
      GL_TEXTURE_WRAP_R_EXT = $8072;
      GL_MAX_3D_TEXTURE_SIZE_EXT = $8073;
      // GL_EXT_texture_array
      GL_TEXTURE_1D_ARRAY_EXT = $8C18;
      GL_PROXY_TEXTURE_1D_ARRAY_EXT = $8C19;
      GL_TEXTURE_2D_ARRAY_EXT = $8C1A;
      GL_PROXY_TEXTURE_2D_ARRAY_EXT = $8C1B;
      GL_TEXTURE_BINDING_1D_ARRAY_EXT = $8C1C;
      GL_TEXTURE_BINDING_2D_ARRAY_EXT = $8C1D;
      GL_MAX_ARRAY_TEXTURE_LAYERS_EXT = $88FF;
      GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT = $884E;
      // GL_EXT_texture_buffer_object
      GL_TEXTURE_BUFFER_EXT = $8C2A;
      GL_MAX_TEXTURE_BUFFER_SIZE_EXT = $8C2B;
      GL_TEXTURE_BINDING_BUFFER_EXT = $8C2C;
      GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = $8C2D;
      GL_TEXTURE_BUFFER_FORMAT_EXT = $8C2E;
      // GL_EXT_texture_compression_latc
      GL_COMPRESSED_LUMINANCE_LATC1_EXT = $8C70;
      GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = $8C71;
      GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = $8C72;
      GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = $8C73;
      // GL_EXT_texture_compression_rgtc
      GL_COMPRESSED_RED_RGTC1_EXT = $8DBB;
      GL_COMPRESSED_SIGNED_RED_RGTC1_EXT = $8DBC;
      GL_COMPRESSED_RED_GREEN_RGTC2_EXT = $8DBD;
      GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = $8DBE;
  // GL_EXT_texture_compression_s3tc
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT = $83F0;
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = $83F1;
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = $83F2;
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = $83F3;
      // GL_EXT_texture_cube_map
      GL_NORMAL_MAP_EXT = $8511;
      GL_REFLECTION_MAP_EXT = $8512;
      GL_TEXTURE_CUBE_MAP_EXT = $8513;
      GL_TEXTURE_BINDING_CUBE_MAP_EXT = $8514;
      GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT = $8515;
      GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT = $8516;
      GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT = $8517;
      GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT = $8518;
      GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT = $8519;
      GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT = $851A;
      GL_PROXY_TEXTURE_CUBE_MAP_EXT = $851B;
      GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT = $851C;
      // GL_EXT_texture_env_combine
      GL_COMBINE_EXT = $8570;
      GL_COMBINE_RGB_EXT = $8571;
      GL_COMBINE_ALPHA_EXT = $8572;
      GL_RGB_SCALE_EXT = $8573;
      GL_ADD_SIGNED_EXT = $8574;
      GL_INTERPOLATE_EXT = $8575;
      GL_CONSTANT_EXT = $8576;
      GL_PRIMARY_COLOR_EXT = $8577;
      GL_PREVIOUS_EXT = $8578;
      GL_SOURCE0_RGB_EXT = $8580;
      GL_SOURCE1_RGB_EXT = $8581;
      GL_SOURCE2_RGB_EXT = $8582;
      GL_SOURCE0_ALPHA_EXT = $8588;
      GL_SOURCE1_ALPHA_EXT = $8589;
      GL_SOURCE2_ALPHA_EXT = $858A;
      GL_OPERAND0_RGB_EXT = $8590;
      GL_OPERAND1_RGB_EXT = $8591;
      GL_OPERAND2_RGB_EXT = $8592;
      GL_OPERAND0_ALPHA_EXT = $8598;
      GL_OPERAND1_ALPHA_EXT = $8599;
      GL_OPERAND2_ALPHA_EXT = $859A;
      // GL_EXT_texture_env_dot3
      GL_DOT3_RGB_EXT = $8740;
      GL_DOT3_RGBA_EXT = $8741;
      // GL_EXT_texture_filter_anisotropic
      GL_TEXTURE_MAX_ANISOTROPY_EXT = $84FE;
      GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF;
  // GL_EXT_texture_filter_minmax
  GL_TEXTURE_REDUCTION_MODE_EXT = $9366;
  GL_WEIGHTED_AVERAGE_EXT = $9367;
      // GL_EXT_texture_integer
      GL_RGBA32UI_EXT = $8D70;
      GL_RGB32UI_EXT = $8D71;
      GL_ALPHA32UI_EXT = $8D72;
      GL_INTENSITY32UI_EXT = $8D73;
      GL_LUMINANCE32UI_EXT = $8D74;
      GL_LUMINANCE_ALPHA32UI_EXT = $8D75;
      GL_RGBA16UI_EXT = $8D76;
      GL_RGB16UI_EXT = $8D77;
      GL_ALPHA16UI_EXT = $8D78;
      GL_INTENSITY16UI_EXT = $8D79;
      GL_LUMINANCE16UI_EXT = $8D7A;
      GL_LUMINANCE_ALPHA16UI_EXT = $8D7B;
      GL_RGBA8UI_EXT = $8D7C;
      GL_RGB8UI_EXT = $8D7D;
      GL_ALPHA8UI_EXT = $8D7E;
      GL_INTENSITY8UI_EXT = $8D7F;
      GL_LUMINANCE8UI_EXT = $8D80;
      GL_LUMINANCE_ALPHA8UI_EXT = $8D81;
      GL_RGBA32I_EXT = $8D82;
      GL_RGB32I_EXT = $8D83;
      GL_ALPHA32I_EXT = $8D84;
      GL_INTENSITY32I_EXT = $8D85;
      GL_LUMINANCE32I_EXT = $8D86;
      GL_LUMINANCE_ALPHA32I_EXT = $8D87;
      GL_RGBA16I_EXT = $8D88;
      GL_RGB16I_EXT = $8D89;
      GL_ALPHA16I_EXT = $8D8A;
      GL_INTENSITY16I_EXT = $8D8B;
      GL_LUMINANCE16I_EXT = $8D8C;
      GL_LUMINANCE_ALPHA16I_EXT = $8D8D;
      GL_RGBA8I_EXT = $8D8E;
      GL_RGB8I_EXT = $8D8F;
      GL_ALPHA8I_EXT = $8D90;
      GL_INTENSITY8I_EXT = $8D91;
      GL_LUMINANCE8I_EXT = $8D92;
      GL_LUMINANCE_ALPHA8I_EXT = $8D93;
      GL_RED_INTEGER_EXT = $8D94;
      GL_GREEN_INTEGER_EXT = $8D95;
      GL_BLUE_INTEGER_EXT = $8D96;
      GL_ALPHA_INTEGER_EXT = $8D97;
      GL_RGB_INTEGER_EXT = $8D98;
      GL_RGBA_INTEGER_EXT = $8D99;
      GL_BGR_INTEGER_EXT = $8D9A;
      GL_BGRA_INTEGER_EXT = $8D9B;
      GL_LUMINANCE_INTEGER_EXT = $8D9C;
      GL_LUMINANCE_ALPHA_INTEGER_EXT = $8D9D;
      GL_RGBA_INTEGER_MODE_EXT = $8D9E;
      // GL_EXT_texture_lod_bias
      GL_MAX_TEXTURE_LOD_BIAS_EXT = $84FD;
      GL_TEXTURE_FILTER_CONTROL_EXT = $8500;
      GL_TEXTURE_LOD_BIAS_EXT = $8501;
      // GL_EXT_texture_mirror_clamp
      GL_MIRROR_CLAMP_EXT = $8742;
      GL_MIRROR_CLAMP_TO_EDGE_EXT = $8743;
      GL_MIRROR_CLAMP_TO_BORDER_EXT = $8912;
      // GL_EXT_texture_object
      GL_TEXTURE_PRIORITY_EXT = $8066;
      GL_TEXTURE_RESIDENT_EXT = $8067;
      GL_TEXTURE_1D_BINDING_EXT = $8068;
      GL_TEXTURE_2D_BINDING_EXT = $8069;
      GL_TEXTURE_3D_BINDING_EXT = $806A;
      // GL_EXT_texture_perturb_normal
      GL_PERTURB_EXT = $85AE;
      GL_TEXTURE_NORMAL_EXT = $85AF;
      // GL_EXT_texture_sRGB
      GL_SRGB_EXT = $8C40;
      GL_SRGB8_EXT = $8C41;
      GL_SRGB_ALPHA_EXT = $8C42;
      GL_SRGB8_ALPHA8_EXT = $8C43;
      GL_SLUMINANCE_ALPHA_EXT = $8C44;
      GL_SLUMINANCE8_ALPHA8_EXT = $8C45;
      GL_SLUMINANCE_EXT = $8C46;
      GL_SLUMINANCE8_EXT = $8C47;
      GL_COMPRESSED_SRGB_EXT = $8C48;
      GL_COMPRESSED_SRGB_ALPHA_EXT = $8C49;
      GL_COMPRESSED_SLUMINANCE_EXT = $8C4A;
      GL_COMPRESSED_SLUMINANCE_ALPHA_EXT = $8C4B;
      GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = $8C4C;
      GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = $8C4D;
      GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = $8C4E;
      GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = $8C4F;
  // GL_EXT_texture_sRGB_R8
  GL_SR8_EXT = $8FBD;
  // GL_EXT_texture_sRGB_RG8
  GL_SRG8_EXT = $8FBE;
  // GL_EXT_texture_sRGB_decode
  GL_TEXTURE_SRGB_DECODE_EXT = $8A48;
  GL_DECODE_EXT = $8A49;
  GL_SKIP_DECODE_EXT = $8A4A;
      // GL_EXT_texture_shared_exponent
      GL_RGB9_E5_EXT = $8C3D;
      GL_UNSIGNED_INT_5_9_9_9_REV_EXT = $8C3E;
      GL_TEXTURE_SHARED_SIZE_EXT = $8C3F;
      // GL_EXT_texture_snorm
      GL_ALPHA_SNORM = $9010;
      GL_LUMINANCE_SNORM = $9011;
      GL_LUMINANCE_ALPHA_SNORM = $9012;
      GL_INTENSITY_SNORM = $9013;
      GL_ALPHA8_SNORM = $9014;
      GL_LUMINANCE8_SNORM = $9015;
      GL_LUMINANCE8_ALPHA8_SNORM = $9016;
      GL_INTENSITY8_SNORM = $9017;
      GL_ALPHA16_SNORM = $9018;
      GL_LUMINANCE16_SNORM = $9019;
      GL_LUMINANCE16_ALPHA16_SNORM = $901A;
      GL_INTENSITY16_SNORM = $901B;
      GL_RED_SNORM = $8F90;
      GL_RG_SNORM = $8F91;
      GL_RGB_SNORM = $8F92;
      GL_RGBA_SNORM = $8F93;
  // GL_EXT_texture_storage
  GL_TEXTURE_IMMUTABLE_FORMAT_EXT = $912F;
//  GL_ALPHA8_EXT = $803C;
//  GL_LUMINANCE8_EXT = $8040;
//  GL_LUMINANCE8_ALPHA8_EXT = $8045;
  GL_RGBA32F_EXT = $8814;
  GL_RGB32F_EXT = $8815;
  GL_ALPHA32F_EXT = $8816;
  GL_LUMINANCE32F_EXT = $8818;
  GL_LUMINANCE_ALPHA32F_EXT = $8819;
  GL_RGBA16F_EXT = $881A;
  GL_RGB16F_EXT = $881B;
  GL_ALPHA16F_EXT = $881C;
  GL_LUMINANCE16F_EXT = $881E;
  GL_LUMINANCE_ALPHA16F_EXT = $881F;
//  GL_RGB10_A2_EXT = $8059;
//  GL_RGB10_EXT = $8052;
  GL_BGRA8_EXT = $93A1;
  GL_R8_EXT = $8229;
  GL_RG8_EXT = $822B;
  GL_R32F_EXT = $822E;
  GL_RG32F_EXT = $8230;
  GL_R16F_EXT = $822D;
  GL_RG16F_EXT = $822F;

      // GL_EXT_texture_swizzle
      GL_TEXTURE_SWIZZLE_R_EXT = $8E42;
      GL_TEXTURE_SWIZZLE_G_EXT = $8E43;
      GL_TEXTURE_SWIZZLE_B_EXT = $8E44;
      GL_TEXTURE_SWIZZLE_A_EXT = $8E45;
      GL_TEXTURE_SWIZZLE_RGBA_EXT = $8E46;
      // GL_EXT_timer_query
      GL_TIME_ELAPSED_EXT = $88BF;
      // GL_EXT_transform_feedback
      GL_TRANSFORM_FEEDBACK_BUFFER_EXT = $8C8E;
      GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT = $8C84;
      GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = $8C85;
      GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = $8C8F;
      GL_INTERLEAVED_ATTRIBS_EXT = $8C8C;
      GL_SEPARATE_ATTRIBS_EXT = $8C8D;
      GL_PRIMITIVES_GENERATED_EXT = $8C87;
      GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = $8C88;
      GL_RASTERIZER_DISCARD_EXT = $8C89;
      GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = $8C8A;
      GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = $8C8B;
      GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = $8C80;
      GL_TRANSFORM_FEEDBACK_VARYINGS_EXT = $8C83;
      GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = $8C7F;
      GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = $8C76;
      // GL_EXT_vertex_array
      GL_VERTEX_ARRAY_EXT = $8074;
      GL_NORMAL_ARRAY_EXT = $8075;
      GL_COLOR_ARRAY_EXT = $8076;
      GL_INDEX_ARRAY_EXT = $8077;
      GL_TEXTURE_COORD_ARRAY_EXT = $8078;
      GL_EDGE_FLAG_ARRAY_EXT = $8079;
      GL_VERTEX_ARRAY_SIZE_EXT = $807A;
      GL_VERTEX_ARRAY_TYPE_EXT = $807B;
      GL_VERTEX_ARRAY_STRIDE_EXT = $807C;
      GL_VERTEX_ARRAY_COUNT_EXT = $807D;
      GL_NORMAL_ARRAY_TYPE_EXT = $807E;
      GL_NORMAL_ARRAY_STRIDE_EXT = $807F;
      GL_NORMAL_ARRAY_COUNT_EXT = $8080;
      GL_COLOR_ARRAY_SIZE_EXT = $8081;
      GL_COLOR_ARRAY_TYPE_EXT = $8082;
      GL_COLOR_ARRAY_STRIDE_EXT = $8083;
      GL_COLOR_ARRAY_COUNT_EXT = $8084;
      GL_INDEX_ARRAY_TYPE_EXT = $8085;
      GL_INDEX_ARRAY_STRIDE_EXT = $8086;
      GL_INDEX_ARRAY_COUNT_EXT = $8087;
      GL_TEXTURE_COORD_ARRAY_SIZE_EXT = $8088;
      GL_TEXTURE_COORD_ARRAY_TYPE_EXT = $8089;
      GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = $808A;
      GL_TEXTURE_COORD_ARRAY_COUNT_EXT = $808B;
      GL_EDGE_FLAG_ARRAY_STRIDE_EXT = $808C;
      GL_EDGE_FLAG_ARRAY_COUNT_EXT = $808D;
      GL_VERTEX_ARRAY_POINTER_EXT = $808E;
      GL_NORMAL_ARRAY_POINTER_EXT = $808F;
      GL_COLOR_ARRAY_POINTER_EXT = $8090;
      GL_INDEX_ARRAY_POINTER_EXT = $8091;
      GL_TEXTURE_COORD_ARRAY_POINTER_EXT = $8092;
      GL_EDGE_FLAG_ARRAY_POINTER_EXT = $8093;
      // GL_EXT_vertex_attrib_64bit
      GL_DOUBLE_VEC2_EXT = $8FFC;
      GL_DOUBLE_VEC3_EXT = $8FFD;
      GL_DOUBLE_VEC4_EXT = $8FFE;
      GL_DOUBLE_MAT2_EXT = $8F46;
      GL_DOUBLE_MAT3_EXT = $8F47;
      GL_DOUBLE_MAT4_EXT = $8F48;
      GL_DOUBLE_MAT2x3_EXT = $8F49;
      GL_DOUBLE_MAT2x4_EXT = $8F4A;
      GL_DOUBLE_MAT3x2_EXT = $8F4B;
      GL_DOUBLE_MAT3x4_EXT = $8F4C;
      GL_DOUBLE_MAT4x2_EXT = $8F4D;
      GL_DOUBLE_MAT4x3_EXT = $8F4E;
      // GL_EXT_vertex_shader
      GL_VERTEX_SHADER_EXT = $8780;
      GL_VERTEX_SHADER_BINDING_EXT = $8781;
      GL_OP_INDEX_EXT = $8782;
      GL_OP_NEGATE_EXT = $8783;
      GL_OP_DOT3_EXT = $8784;
      GL_OP_DOT4_EXT = $8785;
      GL_OP_MUL_EXT = $8786;
      GL_OP_ADD_EXT = $8787;
      GL_OP_MADD_EXT = $8788;
      GL_OP_FRAC_EXT = $8789;
      GL_OP_MAX_EXT = $878A;
      GL_OP_MIN_EXT = $878B;
      GL_OP_SET_GE_EXT = $878C;
      GL_OP_SET_LT_EXT = $878D;
      GL_OP_CLAMP_EXT = $878E;
      GL_OP_FLOOR_EXT = $878F;
      GL_OP_ROUND_EXT = $8790;
      GL_OP_EXP_BASE_2_EXT = $8791;
      GL_OP_LOG_BASE_2_EXT = $8792;
      GL_OP_POWER_EXT = $8793;
      GL_OP_RECIP_EXT = $8794;
      GL_OP_RECIP_SQRT_EXT = $8795;
      GL_OP_SUB_EXT = $8796;
      GL_OP_CROSS_PRODUCT_EXT = $8797;
      GL_OP_MULTIPLY_MATRIX_EXT = $8798;
      GL_OP_MOV_EXT = $8799;
      GL_OUTPUT_VERTEX_EXT = $879A;
      GL_OUTPUT_COLOR0_EXT = $879B;
      GL_OUTPUT_COLOR1_EXT = $879C;
      GL_OUTPUT_TEXTURE_COORD0_EXT = $879D;
      GL_OUTPUT_TEXTURE_COORD1_EXT = $879E;
      GL_OUTPUT_TEXTURE_COORD2_EXT = $879F;
      GL_OUTPUT_TEXTURE_COORD3_EXT = $87A0;
      GL_OUTPUT_TEXTURE_COORD4_EXT = $87A1;
      GL_OUTPUT_TEXTURE_COORD5_EXT = $87A2;
      GL_OUTPUT_TEXTURE_COORD6_EXT = $87A3;
      GL_OUTPUT_TEXTURE_COORD7_EXT = $87A4;
      GL_OUTPUT_TEXTURE_COORD8_EXT = $87A5;
      GL_OUTPUT_TEXTURE_COORD9_EXT = $87A6;
      GL_OUTPUT_TEXTURE_COORD10_EXT = $87A7;
      GL_OUTPUT_TEXTURE_COORD11_EXT = $87A8;
      GL_OUTPUT_TEXTURE_COORD12_EXT = $87A9;
      GL_OUTPUT_TEXTURE_COORD13_EXT = $87AA;
      GL_OUTPUT_TEXTURE_COORD14_EXT = $87AB;
      GL_OUTPUT_TEXTURE_COORD15_EXT = $87AC;
      GL_OUTPUT_TEXTURE_COORD16_EXT = $87AD;
      GL_OUTPUT_TEXTURE_COORD17_EXT = $87AE;
      GL_OUTPUT_TEXTURE_COORD18_EXT = $87AF;
      GL_OUTPUT_TEXTURE_COORD19_EXT = $87B0;
      GL_OUTPUT_TEXTURE_COORD20_EXT = $87B1;
      GL_OUTPUT_TEXTURE_COORD21_EXT = $87B2;
      GL_OUTPUT_TEXTURE_COORD22_EXT = $87B3;
      GL_OUTPUT_TEXTURE_COORD23_EXT = $87B4;
      GL_OUTPUT_TEXTURE_COORD24_EXT = $87B5;
      GL_OUTPUT_TEXTURE_COORD25_EXT = $87B6;
      GL_OUTPUT_TEXTURE_COORD26_EXT = $87B7;
      GL_OUTPUT_TEXTURE_COORD27_EXT = $87B8;
      GL_OUTPUT_TEXTURE_COORD28_EXT = $87B9;
      GL_OUTPUT_TEXTURE_COORD29_EXT = $87BA;
      GL_OUTPUT_TEXTURE_COORD30_EXT = $87BB;
      GL_OUTPUT_TEXTURE_COORD31_EXT = $87BC;
      GL_OUTPUT_FOG_EXT = $87BD;
      GL_SCALAR_EXT = $87BE;
      GL_VECTOR_EXT = $87BF;
      GL_MATRIX_EXT = $87C0;
      GL_VARIANT_EXT = $87C1;
      GL_INVARIANT_EXT = $87C2;
      GL_LOCAL_CONSTANT_EXT = $87C3;
      GL_LOCAL_EXT = $87C4;
      GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT = $87C5;
      GL_MAX_VERTEX_SHADER_VARIANTS_EXT = $87C6;
      GL_MAX_VERTEX_SHADER_INVARIANTS_EXT = $87C7;
      GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87C8;
      GL_MAX_VERTEX_SHADER_LOCALS_EXT = $87C9;
      GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT = $87CA;
      GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT = $87CB;
      GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87CC;
      GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = $87CD;
      GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT = $87CE;
      GL_VERTEX_SHADER_INSTRUCTIONS_EXT = $87CF;
      GL_VERTEX_SHADER_VARIANTS_EXT = $87D0;
      GL_VERTEX_SHADER_INVARIANTS_EXT = $87D1;
      GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = $87D2;
      GL_VERTEX_SHADER_LOCALS_EXT = $87D3;
      GL_VERTEX_SHADER_OPTIMIZED_EXT = $87D4;
      GL_X_EXT = $87D5;
      GL_Y_EXT = $87D6;
      GL_Z_EXT = $87D7;
      GL_W_EXT = $87D8;
      GL_NEGATIVE_X_EXT = $87D9;
      GL_NEGATIVE_Y_EXT = $87DA;
      GL_NEGATIVE_Z_EXT = $87DB;
      GL_NEGATIVE_W_EXT = $87DC;
      GL_ZERO_EXT = $87DD;
      GL_ONE_EXT = $87DE;
      GL_NEGATIVE_ONE_EXT = $87DF;
      GL_NORMALIZED_RANGE_EXT = $87E0;
      GL_FULL_RANGE_EXT = $87E1;
      GL_CURRENT_VERTEX_EXT = $87E2;
      GL_MVP_MATRIX_EXT = $87E3;
      GL_VARIANT_VALUE_EXT = $87E4;
      GL_VARIANT_DATATYPE_EXT = $87E5;
      GL_VARIANT_ARRAY_STRIDE_EXT = $87E6;
      GL_VARIANT_ARRAY_TYPE_EXT = $87E7;
      GL_VARIANT_ARRAY_EXT = $87E8;
      GL_VARIANT_ARRAY_POINTER_EXT = $87E9;
      GL_INVARIANT_VALUE_EXT = $87EA;
      GL_INVARIANT_DATATYPE_EXT = $87EB;
      GL_LOCAL_CONSTANT_VALUE_EXT = $87EC;
      GL_LOCAL_CONSTANT_DATATYPE_EXT = $87ED;
      // GL_EXT_vertex_weighting
      GL_MODELVIEW0_STACK_DEPTH_EXT = $0BA3;
      GL_MODELVIEW1_STACK_DEPTH_EXT = $8502;
      GL_MODELVIEW0_MATRIX_EXT = $0BA6;
      GL_MODELVIEW1_MATRIX_EXT = $8506;
      GL_VERTEX_WEIGHTING_EXT = $8509;
      GL_MODELVIEW0_EXT = $1700;
      GL_MODELVIEW1_EXT = $850A;
      GL_CURRENT_VERTEX_WEIGHT_EXT = $850B;
      GL_VERTEX_WEIGHT_ARRAY_EXT = $850C;
      GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT = $850D;
      GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT = $850E;
      GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT = $850F;
      GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT = $8510;
  // GL_EXT_window_rectangles
  GL_INCLUSIVE_EXT = $8F10;
  GL_EXCLUSIVE_EXT = $8F11;
  GL_WINDOW_RECTANGLE_EXT = $8F12;
  GL_WINDOW_RECTANGLE_MODE_EXT = $8F13;
  GL_MAX_WINDOW_RECTANGLES_EXT = $8F14;
  GL_NUM_WINDOW_RECTANGLES_EXT = $8F15;
      // GL_EXT_x11_sync_object
      GL_SYNC_X11_FENCE_EXT = $90E1;
      // GL_HP_convolution_border_modes
      GL_IGNORE_BORDER_HP = $8150;
      GL_CONSTANT_BORDER_HP = $8151;
      GL_REPLICATE_BORDER_HP = $8153;
      GL_CONVOLUTION_BORDER_COLOR_HP = $8154;
      // GL_HP_image_transform
      GL_IMAGE_SCALE_X_HP = $8155;
      GL_IMAGE_SCALE_Y_HP = $8156;
      GL_IMAGE_TRANSLATE_X_HP = $8157;
      GL_IMAGE_TRANSLATE_Y_HP = $8158;
      GL_IMAGE_ROTATE_ANGLE_HP = $8159;
      GL_IMAGE_ROTATE_ORIGIN_X_HP = $815A;
      GL_IMAGE_ROTATE_ORIGIN_Y_HP = $815B;
      GL_IMAGE_MAG_FILTER_HP = $815C;
      GL_IMAGE_MIN_FILTER_HP = $815D;
      GL_IMAGE_CUBIC_WEIGHT_HP = $815E;
      GL_CUBIC_HP = $815F;
      GL_AVERAGE_HP = $8160;
      GL_IMAGE_TRANSFORM_2D_HP = $8161;
      GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = $8162;
      GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = $8163;
      // GL_HP_occlusion_test
      GL_OCCLUSION_TEST_HP = $8165;
      GL_OCCLUSION_TEST_RESULT_HP = $8166;
      // GL_HP_texture_lighting
      GL_TEXTURE_LIGHTING_MODE_HP = $8167;
      GL_TEXTURE_POST_SPECULAR_HP = $8168;
      GL_TEXTURE_PRE_SPECULAR_HP = $8169;
      // GL_IBM_cull_vertex
      GL_CULL_VERTEX_IBM = 103050;
      // GL_IBM_rasterpos_clip
      GL_RASTER_POSITION_UNCLIPPED_IBM = $19262;
      // GL_IBM_static_data
      GL_ALL_STATIC_DATA_IBM = 103060;
      GL_STATIC_VERTEX_ARRAY_IBM = 103061;
      // GL_IBM_texture_mirrored_repeat
      GL_MIRRORED_REPEAT_IBM = $8370;
      // GL_IBM_vertex_array_lists
      GL_VERTEX_ARRAY_LIST_IBM = 103070;
      GL_NORMAL_ARRAY_LIST_IBM = 103071;
      GL_COLOR_ARRAY_LIST_IBM = 103072;
      GL_INDEX_ARRAY_LIST_IBM = 103073;
      GL_TEXTURE_COORD_ARRAY_LIST_IBM = 103074;
      GL_EDGE_FLAG_ARRAY_LIST_IBM = 103075;
      GL_FOG_COORDINATE_ARRAY_LIST_IBM = 103076;
      GL_SECONDARY_COLOR_ARRAY_LIST_IBM = 103077;
      GL_VERTEX_ARRAY_LIST_STRIDE_IBM = 103080;
      GL_NORMAL_ARRAY_LIST_STRIDE_IBM = 103081;
      GL_COLOR_ARRAY_LIST_STRIDE_IBM = 103082;
      GL_INDEX_ARRAY_LIST_STRIDE_IBM = 103083;
      GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM = 103084;
      GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM = 103085;
      GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM = 103086;
      GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM = 103087;
      // GL_INGR_color_clamp
      GL_RED_MIN_CLAMP_INGR = $8560;
      GL_GREEN_MIN_CLAMP_INGR = $8561;
      GL_BLUE_MIN_CLAMP_INGR = $8562;
      GL_ALPHA_MIN_CLAMP_INGR = $8563;
      GL_RED_MAX_CLAMP_INGR = $8564;
      GL_GREEN_MAX_CLAMP_INGR = $8565;
      GL_BLUE_MAX_CLAMP_INGR = $8566;
      GL_ALPHA_MAX_CLAMP_INGR = $8567;
      // GL_INGR_interlace_read
      GL_INTERLACE_READ_INGR = $8568;
  // GL_INTEL_blackhole_render
  GL_BLACKHOLE_RENDER_INTEL = $83FC;
  // GL_INTEL_conservative_rasterization
  GL_CONSERVATIVE_RASTERIZATION_INTEL = $83FE;
      // GL_INTEL_map_texture
      GL_TEXTURE_MEMORY_LAYOUT_INTEL = $83FF;
      GL_LAYOUT_DEFAULT_INTEL = 0;
      GL_LAYOUT_LINEAR_INTEL = 1;
      GL_LAYOUT_LINEAR_CPU_CACHED_INTEL = 2;
      // GL_INTEL_parallel_arrays
      GL_PARALLEL_ARRAYS_INTEL = $83F4;
      GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = $83F5;
      GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = $83F6;
      GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL = $83F7;
      GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = $83F8;
  // GL_INTEL_performance_query
  GL_PERFQUERY_SINGLE_CONTEXT_INTEL = $00000000;
  GL_PERFQUERY_GLOBAL_CONTEXT_INTEL = $00000001;
  GL_PERFQUERY_WAIT_INTEL = $83FB;
  GL_PERFQUERY_FLUSH_INTEL = $83FA;
  GL_PERFQUERY_DONOT_FLUSH_INTEL = $83F9;
  GL_PERFQUERY_COUNTER_EVENT_INTEL = $94F0;
  GL_PERFQUERY_COUNTER_DURATION_NORM_INTEL = $94F1;
  GL_PERFQUERY_COUNTER_DURATION_RAW_INTEL = $94F2;
  GL_PERFQUERY_COUNTER_THROUGHPUT_INTEL = $94F3;
  GL_PERFQUERY_COUNTER_RAW_INTEL = $94F4;
  GL_PERFQUERY_COUNTER_TIMESTAMP_INTEL = $94F5;
  GL_PERFQUERY_COUNTER_DATA_UINT32_INTEL = $94F8;
  GL_PERFQUERY_COUNTER_DATA_UINT64_INTEL = $94F9;
  GL_PERFQUERY_COUNTER_DATA_FLOAT_INTEL = $94FA;
  GL_PERFQUERY_COUNTER_DATA_DOUBLE_INTEL = $94FB;
  GL_PERFQUERY_COUNTER_DATA_BOOL32_INTEL = $94FC;
  GL_PERFQUERY_QUERY_NAME_LENGTH_MAX_INTEL = $94FD;
  GL_PERFQUERY_COUNTER_NAME_LENGTH_MAX_INTEL = $94FE;
  GL_PERFQUERY_COUNTER_DESC_LENGTH_MAX_INTEL = $94FF;
  GL_PERFQUERY_GPA_EXTENDED_COUNTERS_INTEL = $9500;
      // GL_MESAX_texture_stack
      GL_TEXTURE_1D_STACK_MESAX = $8759;
      GL_TEXTURE_2D_STACK_MESAX = $875A;
      GL_PROXY_TEXTURE_1D_STACK_MESAX = $875B;
      GL_PROXY_TEXTURE_2D_STACK_MESAX = $875C;
      GL_TEXTURE_1D_STACK_BINDING_MESAX = $875D;
      GL_TEXTURE_2D_STACK_BINDING_MESAX = $875E;
  // GL_MESA_framebuffer_flip_x
  GL_FRAMEBUFFER_FLIP_X_MESA = $8BBC;
  // GL_MESA_framebuffer_flip_y
  GL_FRAMEBUFFER_FLIP_Y_MESA = $8BBB;
  // GL_MESA_framebuffer_swap_xy
  GL_FRAMEBUFFER_SWAP_XY_MESA = $8BBD;
      // GL_MESA_pack_invert
      GL_PACK_INVERT_MESA = $8758;
      // GL_MESA_program_binary_formats
      GL_PROGRAM_BINARY_FORMAT_MESA = $875F;
      // GL_MESA_tile_raster_order
      GL_TILE_RASTER_ORDER_FIXED_MESA = $8BB8;
      GL_TILE_RASTER_ORDER_INCREASING_X_MESA = $8BB9;
      GL_TILE_RASTER_ORDER_INCREASING_Y_MESA = $8BBA;
      // GL_MESA_ycbcr_texture
      GL_UNSIGNED_SHORT_8_8_MESA = $85BA;
      GL_UNSIGNED_SHORT_8_8_REV_MESA = $85BB;
      GL_YCBCR_MESA = $8757;
      // GL_NVX_gpu_memory_info
      GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX = $9047;
      GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX = $9048;
      GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX = $9049;
      GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX = $904A;
      GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX = $904B;
      // GL_NVX_gpu_multicast2
      GL_UPLOAD_GPU_MASK_NVX = $954A;
      // GL_NVX_linked_gpu_multicast
      GL_LGPU_SEPARATE_STORAGE_BIT_NVX = $0800;
      GL_MAX_LGPU_GPUS_NVX = $92BA;
      // GL_NV_alpha_to_coverage_dither_control
      GL_ALPHA_TO_COVERAGE_DITHER_DEFAULT_NV = $934D;
      GL_ALPHA_TO_COVERAGE_DITHER_ENABLE_NV = $934E;
      GL_ALPHA_TO_COVERAGE_DITHER_DISABLE_NV = $934F;
      GL_ALPHA_TO_COVERAGE_DITHER_MODE_NV = $92BF;
  // GL_NV_blend_equation_advanced
  GL_BLEND_OVERLAP_NV = $9281;
  GL_BLEND_PREMULTIPLIED_SRC_NV = $9280;
  GL_BLUE_NV = $1905;
  GL_COLORBURN_NV = $929A;
  GL_COLORDODGE_NV = $9299;
  GL_CONJOINT_NV = $9284;
  GL_CONTRAST_NV = $92A1;
  GL_DARKEN_NV = $9297;
  GL_DIFFERENCE_NV = $929E;
  GL_DISJOINT_NV = $9283;
  GL_DST_ATOP_NV = $928F;
  GL_DST_IN_NV = $928B;
  GL_DST_NV = $9287;
  GL_DST_OUT_NV = $928D;
  GL_DST_OVER_NV = $9289;
  GL_EXCLUSION_NV = $92A0;
  GL_GREEN_NV = $1904;
  GL_HARDLIGHT_NV = $929B;
  GL_HARDMIX_NV = $92A9;
  GL_HSL_COLOR_NV = $92AF;
  GL_HSL_HUE_NV = $92AD;
  GL_HSL_LUMINOSITY_NV = $92B0;
  GL_HSL_SATURATION_NV = $92AE;
  GL_INVERT_OVG_NV = $92B4;
  GL_INVERT_RGB_NV = $92A3;
  GL_LIGHTEN_NV = $9298;
  GL_LINEARBURN_NV = $92A5;
  GL_LINEARDODGE_NV = $92A4;
  GL_LINEARLIGHT_NV = $92A7;
  GL_MINUS_CLAMPED_NV = $92B3;
  GL_MINUS_NV = $929F;
  GL_MULTIPLY_NV = $9294;
  GL_OVERLAY_NV = $9296;
  GL_PINLIGHT_NV = $92A8;
  GL_PLUS_CLAMPED_ALPHA_NV = $92B2;
  GL_PLUS_CLAMPED_NV = $92B1;
  GL_PLUS_DARKER_NV = $9292;
  GL_PLUS_NV = $9291;
  GL_RED_NV = $1903;
  GL_SCREEN_NV = $9295;
  GL_SOFTLIGHT_NV = $929C;
  GL_SRC_ATOP_NV = $928E;
  GL_SRC_IN_NV = $928A;
  GL_SRC_NV = $9286;
  GL_SRC_OUT_NV = $928C;
  GL_SRC_OVER_NV = $9288;
  GL_UNCORRELATED_NV = $9282;
  GL_VIVIDLIGHT_NV = $92A6;
  GL_XOR_NV = $1506;
  // GL_NV_blend_equation_advanced_coherent
  GL_BLEND_ADVANCED_COHERENT_NV = $9285;
  // GL_NV_blend_minmax_factor
//  GL_FACTOR_MIN_AMD = $901C;
//  GL_FACTOR_MAX_AMD = $901D;
  // GL_NV_clip_space_w_scaling
  GL_VIEWPORT_POSITION_W_SCALE_NV = $937C;
  GL_VIEWPORT_POSITION_W_SCALE_X_COEFF_NV = $937D;
  GL_VIEWPORT_POSITION_W_SCALE_Y_COEFF_NV = $937E;
  // GL_NV_command_list
  GL_TERMINATE_SEQUENCE_COMMAND_NV = $0000;
  GL_NOP_COMMAND_NV = $0001;
  GL_DRAW_ELEMENTS_COMMAND_NV = $0002;
  GL_DRAW_ARRAYS_COMMAND_NV = $0003;
  GL_DRAW_ELEMENTS_STRIP_COMMAND_NV = $0004;
  GL_DRAW_ARRAYS_STRIP_COMMAND_NV = $0005;
  GL_DRAW_ELEMENTS_INSTANCED_COMMAND_NV = $0006;
  GL_DRAW_ARRAYS_INSTANCED_COMMAND_NV = $0007;
  GL_ELEMENT_ADDRESS_COMMAND_NV = $0008;
  GL_ATTRIBUTE_ADDRESS_COMMAND_NV = $0009;
  GL_UNIFORM_ADDRESS_COMMAND_NV = $000A;
  GL_BLEND_COLOR_COMMAND_NV = $000B;
  GL_STENCIL_REF_COMMAND_NV = $000C;
  GL_LINE_WIDTH_COMMAND_NV = $000D;
  GL_POLYGON_OFFSET_COMMAND_NV = $000E;
  GL_ALPHA_REF_COMMAND_NV = $000F;
  GL_VIEWPORT_COMMAND_NV = $0010;
  GL_SCISSOR_COMMAND_NV = $0011;
  GL_FRONT_FACE_COMMAND_NV = $0012;
      // GL_NV_compute_program5
      GL_COMPUTE_PROGRAM_NV = $90FB;
      GL_COMPUTE_PROGRAM_PARAMETER_BUFFER_NV = $90FC;
  // GL_NV_conditional_render
  GL_QUERY_WAIT_NV = $8E13;
  GL_QUERY_NO_WAIT_NV = $8E14;
  GL_QUERY_BY_REGION_WAIT_NV = $8E15;
  GL_QUERY_BY_REGION_NO_WAIT_NV = $8E16;
  // GL_NV_conservative_raster
  GL_CONSERVATIVE_RASTERIZATION_NV = $9346;
  GL_SUBPIXEL_PRECISION_BIAS_X_BITS_NV = $9347;
  GL_SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = $9348;
  GL_MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = $9349;
  // GL_NV_conservative_raster_dilate
  GL_CONSERVATIVE_RASTER_DILATE_NV = $9379;
  GL_CONSERVATIVE_RASTER_DILATE_RANGE_NV = $937A;
  GL_CONSERVATIVE_RASTER_DILATE_GRANULARITY_NV = $937B;
  // GL_NV_conservative_raster_pre_snap
  GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_NV = $9550;
  // GL_NV_conservative_raster_pre_snap_triangles
  GL_CONSERVATIVE_RASTER_MODE_NV = $954D;
  GL_CONSERVATIVE_RASTER_MODE_POST_SNAP_NV = $954E;
  GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_TRIANGLES_NV = $954F;
      // GL_NV_copy_depth_to_color
      GL_DEPTH_STENCIL_TO_RGBA_NV = $886E;
      GL_DEPTH_STENCIL_TO_BGRA_NV = $886F;
      // GL_NV_deep_texture3D
      GL_MAX_DEEP_3D_TEXTURE_WIDTH_HEIGHT_NV = $90D0;
      GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV = $90D1;
  // GL_NV_depth_buffer_float
  GL_DEPTH_COMPONENT32F_NV = $8DAB;
  GL_DEPTH32F_STENCIL8_NV = $8DAC;
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = $8DAD;
  GL_DEPTH_BUFFER_FLOAT_MODE_NV = $8DAF;
      // GL_NV_depth_clamp
      GL_DEPTH_CLAMP_NV = $864F;
      // GL_NV_evaluators
      GL_EVAL_2D_NV = $86C0;
      GL_EVAL_TRIANGULAR_2D_NV = $86C1;
      GL_MAP_TESSELLATION_NV = $86C2;
      GL_MAP_ATTRIB_U_ORDER_NV = $86C3;
      GL_MAP_ATTRIB_V_ORDER_NV = $86C4;
      GL_EVAL_FRACTIONAL_TESSELLATION_NV = $86C5;
      GL_EVAL_VERTEX_ATTRIB0_NV = $86C6;
      GL_EVAL_VERTEX_ATTRIB1_NV = $86C7;
      GL_EVAL_VERTEX_ATTRIB2_NV = $86C8;
      GL_EVAL_VERTEX_ATTRIB3_NV = $86C9;
      GL_EVAL_VERTEX_ATTRIB4_NV = $86CA;
      GL_EVAL_VERTEX_ATTRIB5_NV = $86CB;
      GL_EVAL_VERTEX_ATTRIB6_NV = $86CC;
      GL_EVAL_VERTEX_ATTRIB7_NV = $86CD;
      GL_EVAL_VERTEX_ATTRIB8_NV = $86CE;
      GL_EVAL_VERTEX_ATTRIB9_NV = $86CF;
      GL_EVAL_VERTEX_ATTRIB10_NV = $86D0;
      GL_EVAL_VERTEX_ATTRIB11_NV = $86D1;
      GL_EVAL_VERTEX_ATTRIB12_NV = $86D2;
      GL_EVAL_VERTEX_ATTRIB13_NV = $86D3;
      GL_EVAL_VERTEX_ATTRIB14_NV = $86D4;
      GL_EVAL_VERTEX_ATTRIB15_NV = $86D5;
      GL_MAX_MAP_TESSELLATION_NV = $86D6;
      GL_MAX_RATIONAL_EVAL_ORDER_NV = $86D7;
      // GL_NV_explicit_multisample
      GL_SAMPLE_POSITION_NV = $8E50;
      GL_SAMPLE_MASK_NV = $8E51;
      GL_SAMPLE_MASK_VALUE_NV = $8E52;
      GL_TEXTURE_BINDING_RENDERBUFFER_NV = $8E53;
      GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV = $8E54;
      GL_TEXTURE_RENDERBUFFER_NV = $8E55;
      GL_SAMPLER_RENDERBUFFER_NV = $8E56;
      GL_INT_SAMPLER_RENDERBUFFER_NV = $8E57;
      GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV = $8E58;
      GL_MAX_SAMPLE_MASK_WORDS_NV = $8E59;
      // GL_NV_fence
      GL_ALL_COMPLETED_NV = $84F2;
      GL_FENCE_STATUS_NV = $84F3;
      GL_FENCE_CONDITION_NV = $84F4;
  // GL_NV_fill_rectangle
  GL_FILL_RECTANGLE_NV = $933C;
      // GL_NV_float_buffer
      GL_FLOAT_R_NV = $8880;
      GL_FLOAT_RG_NV = $8881;
      GL_FLOAT_RGB_NV = $8882;
      GL_FLOAT_RGBA_NV = $8883;
      GL_FLOAT_R16_NV = $8884;
      GL_FLOAT_R32_NV = $8885;
      GL_FLOAT_RG16_NV = $8886;
      GL_FLOAT_RG32_NV = $8887;
      GL_FLOAT_RGB16_NV = $8888;
      GL_FLOAT_RGB32_NV = $8889;
      GL_FLOAT_RGBA16_NV = $888A;
      GL_FLOAT_RGBA32_NV = $888B;
      GL_TEXTURE_FLOAT_COMPONENTS_NV = $888C;
      GL_FLOAT_CLEAR_COLOR_VALUE_NV = $888D;
      GL_FLOAT_RGBA_MODE_NV = $888E;
      // GL_NV_fog_distance
      GL_FOG_DISTANCE_MODE_NV = $855A;
      GL_EYE_RADIAL_NV = $855B;
      GL_EYE_PLANE_ABSOLUTE_NV = $855C;
  // GL_NV_fragment_coverage_to_color
  GL_FRAGMENT_COVERAGE_TO_COLOR_NV = $92DD;
  GL_FRAGMENT_COVERAGE_COLOR_NV = $92DE;
      // GL_NV_fragment_program
      GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = $8868;
      GL_FRAGMENT_PROGRAM_NV = $8870;
      GL_MAX_TEXTURE_COORDS_NV = $8871;
      GL_MAX_TEXTURE_IMAGE_UNITS_NV = $8872;
      GL_FRAGMENT_PROGRAM_BINDING_NV = $8873;
      GL_PROGRAM_ERROR_STRING_NV = $8874;
      // GL_NV_fragment_program2
      GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = $88F4;
      GL_MAX_PROGRAM_CALL_DEPTH_NV = $88F5;
      GL_MAX_PROGRAM_IF_DEPTH_NV = $88F6;
      GL_MAX_PROGRAM_LOOP_DEPTH_NV = $88F7;
      GL_MAX_PROGRAM_LOOP_COUNT_NV = $88F8;
  // GL_NV_framebuffer_mixed_samples
  GL_COVERAGE_MODULATION_TABLE_NV = $9331;
  GL_COLOR_SAMPLES_NV = $8E20;
  GL_DEPTH_SAMPLES_NV = $932D;
  GL_STENCIL_SAMPLES_NV = $932E;
  GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = $932F;
  GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = $9330;
  GL_COVERAGE_MODULATION_NV = $9332;
  GL_COVERAGE_MODULATION_TABLE_SIZE_NV = $9333;
  // GL_NV_framebuffer_multisample_coverage
  GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = $8CAB;
  GL_RENDERBUFFER_COLOR_SAMPLES_NV = $8E10;
  GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV = $8E11;
  GL_MULTISAMPLE_COVERAGE_MODES_NV = $8E12;
      // GL_NV_geometry_program4
      GL_GEOMETRY_PROGRAM_NV = $8C26;
      GL_MAX_PROGRAM_OUTPUT_VERTICES_NV = $8C27;
      GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = $8C28;
      // GL_NV_gpu_multicast
      GL_PER_GPU_STORAGE_BIT_NV = $0800;
      GL_MULTICAST_GPUS_NV = $92BA;
      GL_RENDER_GPU_MASK_NV = $9558;
      GL_PER_GPU_STORAGE_NV = $9548;
      GL_MULTICAST_PROGRAMMABLE_SAMPLE_LOCATION_NV = $9549;
      // GL_NV_gpu_program4
      GL_MIN_PROGRAM_TEXEL_OFFSET_NV = $8904;
      GL_MAX_PROGRAM_TEXEL_OFFSET_NV = $8905;
      GL_PROGRAM_ATTRIB_COMPONENTS_NV = $8906;
      GL_PROGRAM_RESULT_COMPONENTS_NV = $8907;
      GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV = $8908;
      GL_MAX_PROGRAM_RESULT_COMPONENTS_NV = $8909;
      GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV = $8DA5;
      GL_MAX_PROGRAM_GENERIC_RESULTS_NV = $8DA6;
      // GL_NV_gpu_program5
      GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = $8E5A;
      GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5B;
      GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = $8E5C;
      GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = $8E5D;
      GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5E;
      GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = $8E5F;
      GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV = $8F44;
      GL_MAX_PROGRAM_SUBROUTINE_NUM_NV = $8F45;
  // GL_NV_gpu_shader5
(*  GL_INT64_NV = $140E;
  GL_UNSIGNED_INT64_NV = $140F;
  GL_INT8_NV = $8FE0;
  GL_INT8_VEC2_NV = $8FE1;
  GL_INT8_VEC3_NV = $8FE2;
  GL_INT8_VEC4_NV = $8FE3;
  GL_INT16_NV = $8FE4;
  GL_INT16_VEC2_NV = $8FE5;
  GL_INT16_VEC3_NV = $8FE6;
  GL_INT16_VEC4_NV = $8FE7;
  GL_INT64_VEC2_NV = $8FE9;
  GL_INT64_VEC3_NV = $8FEA;
  GL_INT64_VEC4_NV = $8FEB;
  GL_UNSIGNED_INT8_NV = $8FEC;
  GL_UNSIGNED_INT8_VEC2_NV = $8FED;
  GL_UNSIGNED_INT8_VEC3_NV = $8FEE;
  GL_UNSIGNED_INT8_VEC4_NV = $8FEF;
  GL_UNSIGNED_INT16_NV = $8FF0;
  GL_UNSIGNED_INT16_VEC2_NV = $8FF1;
  GL_UNSIGNED_INT16_VEC3_NV = $8FF2;
  GL_UNSIGNED_INT16_VEC4_NV = $8FF3;
  GL_UNSIGNED_INT64_VEC2_NV = $8FF5;
  GL_UNSIGNED_INT64_VEC3_NV = $8FF6;
  GL_UNSIGNED_INT64_VEC4_NV = $8FF7;
  GL_FLOAT16_NV = $8FF8;
  GL_FLOAT16_VEC2_NV = $8FF9;
  GL_FLOAT16_VEC3_NV = $8FFA;
  GL_FLOAT16_VEC4_NV = $8FFB;   *)
      // GL_NV_half_float
      GL_HALF_FLOAT_NV = $140B;
  // GL_NV_internalformat_sample_query
  GL_MULTISAMPLES_NV = $9371;
  GL_SUPERSAMPLE_SCALE_X_NV = $9372;
  GL_SUPERSAMPLE_SCALE_Y_NV = $9373;
  GL_CONFORMANT_NV = $9374;
      // GL_NV_light_max_exponent
      GL_MAX_SHININESS_NV = $8504;
      GL_MAX_SPOT_EXPONENT_NV = $8505;
  // GL_NV_memory_attachment
  GL_ATTACHED_MEMORY_OBJECT_NV = $95A4;
  GL_ATTACHED_MEMORY_OFFSET_NV = $95A5;
  GL_MEMORY_ATTACHABLE_ALIGNMENT_NV = $95A6;
  GL_MEMORY_ATTACHABLE_SIZE_NV = $95A7;
  GL_MEMORY_ATTACHABLE_NV = $95A8;
  GL_DETACHED_MEMORY_INCARNATION_NV = $95A9;
  GL_DETACHED_TEXTURES_NV = $95AA;
  GL_DETACHED_BUFFERS_NV = $95AB;
  GL_MAX_DETACHED_TEXTURES_NV = $95AC;
  GL_MAX_DETACHED_BUFFERS_NV = $95AD;
  // GL_NV_mesh_shader
  GL_MESH_SHADER_NV = $9559;
  GL_TASK_SHADER_NV = $955A;
  GL_MAX_MESH_UNIFORM_BLOCKS_NV = $8E60;
  GL_MAX_MESH_TEXTURE_IMAGE_UNITS_NV = $8E61;
  GL_MAX_MESH_IMAGE_UNIFORMS_NV = $8E62;
  GL_MAX_MESH_UNIFORM_COMPONENTS_NV = $8E63;
  GL_MAX_MESH_ATOMIC_COUNTER_BUFFERS_NV = $8E64;
  GL_MAX_MESH_ATOMIC_COUNTERS_NV = $8E65;
  GL_MAX_MESH_SHADER_STORAGE_BLOCKS_NV = $8E66;
  GL_MAX_COMBINED_MESH_UNIFORM_COMPONENTS_NV = $8E67;
  GL_MAX_TASK_UNIFORM_BLOCKS_NV = $8E68;
  GL_MAX_TASK_TEXTURE_IMAGE_UNITS_NV = $8E69;
  GL_MAX_TASK_IMAGE_UNIFORMS_NV = $8E6A;
  GL_MAX_TASK_UNIFORM_COMPONENTS_NV = $8E6B;
  GL_MAX_TASK_ATOMIC_COUNTER_BUFFERS_NV = $8E6C;
  GL_MAX_TASK_ATOMIC_COUNTERS_NV = $8E6D;
  GL_MAX_TASK_SHADER_STORAGE_BLOCKS_NV = $8E6E;
  GL_MAX_COMBINED_TASK_UNIFORM_COMPONENTS_NV = $8E6F;
  GL_MAX_MESH_WORK_GROUP_INVOCATIONS_NV = $95A2;
  GL_MAX_TASK_WORK_GROUP_INVOCATIONS_NV = $95A3;
  GL_MAX_MESH_TOTAL_MEMORY_SIZE_NV = $9536;
  GL_MAX_TASK_TOTAL_MEMORY_SIZE_NV = $9537;
  GL_MAX_MESH_OUTPUT_VERTICES_NV = $9538;
  GL_MAX_MESH_OUTPUT_PRIMITIVES_NV = $9539;
  GL_MAX_TASK_OUTPUT_COUNT_NV = $953A;
  GL_MAX_DRAW_MESH_TASKS_COUNT_NV = $953D;
  GL_MAX_MESH_VIEWS_NV = $9557;
  GL_MESH_OUTPUT_PER_VERTEX_GRANULARITY_NV = $92DF;
  GL_MESH_OUTPUT_PER_PRIMITIVE_GRANULARITY_NV = $9543;
  GL_MAX_MESH_WORK_GROUP_SIZE_NV = $953B;
  GL_MAX_TASK_WORK_GROUP_SIZE_NV = $953C;
  GL_MESH_WORK_GROUP_SIZE_NV = $953E;
  GL_TASK_WORK_GROUP_SIZE_NV = $953F;
  GL_MESH_VERTICES_OUT_NV = $9579;
  GL_MESH_PRIMITIVES_OUT_NV = $957A;
  GL_MESH_OUTPUT_TYPE_NV = $957B;
  GL_UNIFORM_BLOCK_REFERENCED_BY_MESH_SHADER_NV = $959C;
  GL_UNIFORM_BLOCK_REFERENCED_BY_TASK_SHADER_NV = $959D;
  GL_REFERENCED_BY_MESH_SHADER_NV = $95A0;
  GL_REFERENCED_BY_TASK_SHADER_NV = $95A1;
  GL_MESH_SHADER_BIT_NV = $00000040;
  GL_TASK_SHADER_BIT_NV = $00000080;
  GL_MESH_SUBROUTINE_NV = $957C;
  GL_TASK_SUBROUTINE_NV = $957D;
  GL_MESH_SUBROUTINE_UNIFORM_NV = $957E;
  GL_TASK_SUBROUTINE_UNIFORM_NV = $957F;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_MESH_SHADER_NV = $959E;
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TASK_SHADER_NV = $959F;
      // GL_NV_multisample_filter_hint
      GL_MULTISAMPLE_FILTER_HINT_NV = $8534;
      // GL_NV_occlusion_query
      GL_PIXEL_COUNTER_BITS_NV = $8864;
      GL_CURRENT_OCCLUSION_QUERY_ID_NV = $8865;
      GL_PIXEL_COUNT_NV = $8866;
      GL_PIXEL_COUNT_AVAILABLE_NV = $8867;
      // GL_NV_packed_depth_stencil
      GL_DEPTH_STENCIL_NV = $84F9;
      GL_UNSIGNED_INT_24_8_NV = $84FA;
      // GL_NV_parameter_buffer_object
      GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = $8DA0;
      GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = $8DA1;
      GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV = $8DA2;
      GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = $8DA3;
      GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = $8DA4;
  // GL_NV_path_rendering
  GL_PATH_FORMAT_SVG_NV = $9070;
  GL_PATH_FORMAT_PS_NV = $9071;
  GL_STANDARD_FONT_NAME_NV = $9072;
  GL_SYSTEM_FONT_NAME_NV = $9073;
  GL_FILE_NAME_NV = $9074;
  GL_PATH_STROKE_WIDTH_NV = $9075;
  GL_PATH_END_CAPS_NV = $9076;
  GL_PATH_INITIAL_END_CAP_NV = $9077;
  GL_PATH_TERMINAL_END_CAP_NV = $9078;
  GL_PATH_JOIN_STYLE_NV = $9079;
  GL_PATH_MITER_LIMIT_NV = $907A;
  GL_PATH_DASH_CAPS_NV = $907B;
  GL_PATH_INITIAL_DASH_CAP_NV = $907C;
  GL_PATH_TERMINAL_DASH_CAP_NV = $907D;
  GL_PATH_DASH_OFFSET_NV = $907E;
  GL_PATH_CLIENT_LENGTH_NV = $907F;
  GL_PATH_FILL_MODE_NV = $9080;
  GL_PATH_FILL_MASK_NV = $9081;
  GL_PATH_FILL_COVER_MODE_NV = $9082;
  GL_PATH_STROKE_COVER_MODE_NV = $9083;
  GL_PATH_STROKE_MASK_NV = $9084;
  GL_COUNT_UP_NV = $9088;
  GL_COUNT_DOWN_NV = $9089;
  GL_PATH_OBJECT_BOUNDING_BOX_NV = $908A;
  GL_CONVEX_HULL_NV = $908B;
  GL_BOUNDING_BOX_NV = $908D;
  GL_TRANSLATE_X_NV = $908E;
  GL_TRANSLATE_Y_NV = $908F;
  GL_TRANSLATE_2D_NV = $9090;
  GL_TRANSLATE_3D_NV = $9091;
  GL_AFFINE_2D_NV = $9092;
  GL_AFFINE_3D_NV = $9094;
  GL_TRANSPOSE_AFFINE_2D_NV = $9096;
  GL_TRANSPOSE_AFFINE_3D_NV = $9098;
  GL_UTF8_NV = $909A;
  GL_UTF16_NV = $909B;
  GL_BOUNDING_BOX_OF_BOUNDING_BOXES_NV = $909C;
  GL_PATH_COMMAND_COUNT_NV = $909D;
  GL_PATH_COORD_COUNT_NV = $909E;
  GL_PATH_DASH_ARRAY_COUNT_NV = $909F;
  GL_PATH_COMPUTED_LENGTH_NV = $90A0;
  GL_PATH_FILL_BOUNDING_BOX_NV = $90A1;
  GL_PATH_STROKE_BOUNDING_BOX_NV = $90A2;
  GL_SQUARE_NV = $90A3;
  GL_ROUND_NV = $90A4;
  GL_TRIANGULAR_NV = $90A5;
  GL_BEVEL_NV = $90A6;
  GL_MITER_REVERT_NV = $90A7;
  GL_MITER_TRUNCATE_NV = $90A8;
  GL_SKIP_MISSING_GLYPH_NV = $90A9;
  GL_USE_MISSING_GLYPH_NV = $90AA;
  GL_PATH_ERROR_POSITION_NV = $90AB;
  GL_ACCUM_ADJACENT_PAIRS_NV = $90AD;
  GL_ADJACENT_PAIRS_NV = $90AE;
  GL_FIRST_TO_REST_NV = $90AF;
  GL_PATH_GEN_MODE_NV = $90B0;
  GL_PATH_GEN_COEFF_NV = $90B1;
  GL_PATH_GEN_COMPONENTS_NV = $90B3;
  GL_PATH_STENCIL_FUNC_NV = $90B7;
  GL_PATH_STENCIL_REF_NV = $90B8;
  GL_PATH_STENCIL_VALUE_MASK_NV = $90B9;
  GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = $90BD;
  GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = $90BE;
  GL_PATH_COVER_DEPTH_FUNC_NV = $90BF;
  GL_PATH_DASH_OFFSET_RESET_NV = $90B4;
  GL_MOVE_TO_RESETS_NV = $90B5;
  GL_MOVE_TO_CONTINUES_NV = $90B6;
  GL_CLOSE_PATH_NV = $00;
  GL_MOVE_TO_NV = $02;
  GL_RELATIVE_MOVE_TO_NV = $03;
  GL_LINE_TO_NV = $04;
  GL_RELATIVE_LINE_TO_NV = $05;
  GL_HORIZONTAL_LINE_TO_NV = $06;
  GL_RELATIVE_HORIZONTAL_LINE_TO_NV = $07;
  GL_VERTICAL_LINE_TO_NV = $08;
  GL_RELATIVE_VERTICAL_LINE_TO_NV = $09;
  GL_QUADRATIC_CURVE_TO_NV = $0A;
  GL_RELATIVE_QUADRATIC_CURVE_TO_NV = $0B;
  GL_CUBIC_CURVE_TO_NV = $0C;
  GL_RELATIVE_CUBIC_CURVE_TO_NV = $0D;
  GL_SMOOTH_QUADRATIC_CURVE_TO_NV = $0E;
  GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = $0F;
  GL_SMOOTH_CUBIC_CURVE_TO_NV = $10;
  GL_RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV = $11;
  GL_SMALL_CCW_ARC_TO_NV = $12;
  GL_RELATIVE_SMALL_CCW_ARC_TO_NV = $13;
  GL_SMALL_CW_ARC_TO_NV = $14;
  GL_RELATIVE_SMALL_CW_ARC_TO_NV = $15;
  GL_LARGE_CCW_ARC_TO_NV = $16;
  GL_RELATIVE_LARGE_CCW_ARC_TO_NV = $17;
  GL_LARGE_CW_ARC_TO_NV = $18;
  GL_RELATIVE_LARGE_CW_ARC_TO_NV = $19;
  GL_RESTART_PATH_NV = $F0;
  GL_DUP_FIRST_CUBIC_CURVE_TO_NV = $F2;
  GL_DUP_LAST_CUBIC_CURVE_TO_NV = $F4;
  GL_RECT_NV = $F6;
  GL_CIRCULAR_CCW_ARC_TO_NV = $F8;
  GL_CIRCULAR_CW_ARC_TO_NV = $FA;
  GL_CIRCULAR_TANGENT_ARC_TO_NV = $FC;
  GL_ARC_TO_NV = $FE;
  GL_RELATIVE_ARC_TO_NV = $FF;
  GL_BOLD_BIT_NV = $01;
  GL_ITALIC_BIT_NV = $02;
  GL_GLYPH_WIDTH_BIT_NV = $01;
  GL_GLYPH_HEIGHT_BIT_NV = $02;
  GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV = $04;
  GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = $08;
  GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = $10;
  GL_GLYPH_VERTICAL_BEARING_X_BIT_NV = $20;
  GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV = $40;
  GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = $80;
  GL_GLYPH_HAS_KERNING_BIT_NV = $100;
  GL_FONT_X_MIN_BOUNDS_BIT_NV = $00010000;
  GL_FONT_Y_MIN_BOUNDS_BIT_NV = $00020000;
  GL_FONT_X_MAX_BOUNDS_BIT_NV = $00040000;
  GL_FONT_Y_MAX_BOUNDS_BIT_NV = $00080000;
  GL_FONT_UNITS_PER_EM_BIT_NV = $00100000;
  GL_FONT_ASCENDER_BIT_NV = $00200000;
  GL_FONT_DESCENDER_BIT_NV = $00400000;
  GL_FONT_HEIGHT_BIT_NV = $00800000;
  GL_FONT_MAX_ADVANCE_WIDTH_BIT_NV = $01000000;
  GL_FONT_MAX_ADVANCE_HEIGHT_BIT_NV = $02000000;
  GL_FONT_UNDERLINE_POSITION_BIT_NV = $04000000;
  GL_FONT_UNDERLINE_THICKNESS_BIT_NV = $08000000;
  GL_FONT_HAS_KERNING_BIT_NV = $10000000;
  GL_ROUNDED_RECT_NV = $E8;
  GL_RELATIVE_ROUNDED_RECT_NV = $E9;
  GL_ROUNDED_RECT2_NV = $EA;
  GL_RELATIVE_ROUNDED_RECT2_NV = $EB;
  GL_ROUNDED_RECT4_NV = $EC;
  GL_RELATIVE_ROUNDED_RECT4_NV = $ED;
  GL_ROUNDED_RECT8_NV = $EE;
  GL_RELATIVE_ROUNDED_RECT8_NV = $EF;
  GL_RELATIVE_RECT_NV = $F7;
  GL_FONT_GLYPHS_AVAILABLE_NV = $9368;
  GL_FONT_TARGET_UNAVAILABLE_NV = $9369;
  GL_FONT_UNAVAILABLE_NV = $936A;
  GL_FONT_UNINTELLIGIBLE_NV = $936B;
  GL_CONIC_CURVE_TO_NV = $1A;
  GL_RELATIVE_CONIC_CURVE_TO_NV = $1B;
  GL_FONT_NUM_GLYPH_INDICES_BIT_NV = $20000000;
  GL_STANDARD_FONT_FORMAT_NV = $936C;
  GL_PATH_PROJECTION_NV = $1701;
  GL_PATH_MODELVIEW_NV = $1700;
  GL_PATH_MODELVIEW_STACK_DEPTH_NV = $0BA3;
  GL_PATH_MODELVIEW_MATRIX_NV = $0BA6;
  GL_PATH_MAX_MODELVIEW_STACK_DEPTH_NV = $0D36;
  GL_PATH_TRANSPOSE_MODELVIEW_MATRIX_NV = $84E3;
  GL_PATH_PROJECTION_STACK_DEPTH_NV = $0BA4;
  GL_PATH_PROJECTION_MATRIX_NV = $0BA7;
  GL_PATH_MAX_PROJECTION_STACK_DEPTH_NV = $0D38;
  GL_PATH_TRANSPOSE_PROJECTION_MATRIX_NV = $84E4;
  GL_FRAGMENT_INPUT_NV = $936D;
  // glext + GL_NV_path_rendering
  GL_2_BYTES_NV = $1407;
  GL_3_BYTES_NV = $1408;
  GL_4_BYTES_NV = $1409;
  GL_EYE_LINEAR_NV = $2400;
  GL_OBJECT_LINEAR_NV = $2401;
  GL_CONSTANT_NV = $8576;
  GL_PATH_FOG_GEN_MODE_NV = $90AC;
  GL_PRIMARY_COLOR_NV = $852C;
  GL_SECONDARY_COLOR_NV = $852D;
  GL_PATH_GEN_COLOR_FORMAT_NV = $90B2;
  // GL_NV_path_rendering_shared_edge
  GL_SHARED_EDGE_NV = $C0;
      // GL_NV_pixel_data_range
      GL_WRITE_PIXEL_DATA_RANGE_NV = $8878;
      GL_READ_PIXEL_DATA_RANGE_NV = $8879;
      GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV = $887A;
      GL_READ_PIXEL_DATA_RANGE_LENGTH_NV = $887B;
      GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV = $887C;
      GL_READ_PIXEL_DATA_RANGE_POINTER_NV = $887D;
      // GL_NV_point_sprite
      GL_POINT_SPRITE_NV = $8861;
      GL_COORD_REPLACE_NV = $8862;
      GL_POINT_SPRITE_R_MODE_NV = $8863;
      // GL_NV_present_video
      GL_FRAME_NV = $8E26;
      GL_FIELDS_NV = $8E27;
      GL_CURRENT_TIME_NV = $8E28;
      GL_NUM_FILL_STREAMS_NV = $8E29;
      GL_PRESENT_TIME_NV = $8E2A;
      GL_PRESENT_DURATION_NV = $8E2B;
      // GL_NV_primitive_restart
      GL_PRIMITIVE_RESTART_NV = $8558;
      GL_PRIMITIVE_RESTART_INDEX_NV = $8559;
  // GL_NV_primitive_shading_rate
  GL_SHADING_RATE_IMAGE_PER_PRIMITIVE_NV = $95B1;
  GL_SHADING_RATE_IMAGE_PALETTE_COUNT_NV = $95B2;
      // GL_NV_query_resource
      GL_QUERY_RESOURCE_TYPE_VIDMEM_ALLOC_NV = $9540;
      GL_QUERY_RESOURCE_MEMTYPE_VIDMEM_NV = $9542;
      GL_QUERY_RESOURCE_SYS_RESERVED_NV = $9544;
      GL_QUERY_RESOURCE_TEXTURE_NV = $9545;
      GL_QUERY_RESOURCE_RENDERBUFFER_NV = $9546;
      GL_QUERY_RESOURCE_BUFFEROBJECT_NV = $9547;
      // GL_NV_register_combiners
      GL_REGISTER_COMBINERS_NV = $8522;
      GL_VARIABLE_A_NV = $8523;
      GL_VARIABLE_B_NV = $8524;
      GL_VARIABLE_C_NV = $8525;
      GL_VARIABLE_D_NV = $8526;
      GL_VARIABLE_E_NV = $8527;
      GL_VARIABLE_F_NV = $8528;
      GL_VARIABLE_G_NV = $8529;
      GL_CONSTANT_COLOR0_NV = $852A;
      GL_CONSTANT_COLOR1_NV = $852B;
      GL_SPARE0_NV = $852E;
      GL_SPARE1_NV = $852F;
      GL_DISCARD_NV = $8530;
      GL_E_TIMES_F_NV = $8531;
      GL_SPARE0_PLUS_SECONDARY_COLOR_NV = $8532;
      GL_UNSIGNED_IDENTITY_NV = $8536;
      GL_UNSIGNED_INVERT_NV = $8537;
      GL_EXPAND_NORMAL_NV = $8538;
      GL_EXPAND_NEGATE_NV = $8539;
      GL_HALF_BIAS_NORMAL_NV = $853A;
      GL_HALF_BIAS_NEGATE_NV = $853B;
      GL_SIGNED_IDENTITY_NV = $853C;
      GL_SIGNED_NEGATE_NV = $853D;
      GL_SCALE_BY_TWO_NV = $853E;
      GL_SCALE_BY_FOUR_NV = $853F;
      GL_SCALE_BY_ONE_HALF_NV = $8540;
      GL_BIAS_BY_NEGATIVE_ONE_HALF_NV = $8541;
      GL_COMBINER_INPUT_NV = $8542;
      GL_COMBINER_MAPPING_NV = $8543;
      GL_COMBINER_COMPONENT_USAGE_NV = $8544;
      GL_COMBINER_AB_DOT_PRODUCT_NV = $8545;
      GL_COMBINER_CD_DOT_PRODUCT_NV = $8546;
      GL_COMBINER_MUX_SUM_NV = $8547;
      GL_COMBINER_SCALE_NV = $8548;
      GL_COMBINER_BIAS_NV = $8549;
      GL_COMBINER_AB_OUTPUT_NV = $854A;
      GL_COMBINER_CD_OUTPUT_NV = $854B;
      GL_COMBINER_SUM_OUTPUT_NV = $854C;
      GL_MAX_GENERAL_COMBINERS_NV = $854D;
      GL_NUM_GENERAL_COMBINERS_NV = $854E;
      GL_COLOR_SUM_CLAMP_NV = $854F;
      GL_COMBINER0_NV = $8550;
      GL_COMBINER1_NV = $8551;
      GL_COMBINER2_NV = $8552;
      GL_COMBINER3_NV = $8553;
      GL_COMBINER4_NV = $8554;
      GL_COMBINER5_NV = $8555;
      GL_COMBINER6_NV = $8556;
      GL_COMBINER7_NV = $8557;
      // GL_NV_register_combiners2
      GL_PER_STAGE_CONSTANTS_NV = $8535;
  // GL_NV_representative_fragment_test
  GL_REPRESENTATIVE_FRAGMENT_TEST_NV = $937F;
      // GL_NV_robustness_video_memory_purge
      GL_PURGED_CONTEXT_RESET_NV = $92BB;
  // GL_NV_sample_locations
  GL_SAMPLE_LOCATION_SUBPIXEL_BITS_NV = $933D;
  GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = $933E;
  GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = $933F;
  GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = $9340;
  GL_SAMPLE_LOCATION_NV = $8E50;
  GL_PROGRAMMABLE_SAMPLE_LOCATION_NV = $9341;
  GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = $9342;
  GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = $9343;
  // GL_NV_scissor_exclusive
  GL_SCISSOR_TEST_EXCLUSIVE_NV = $9555;
  GL_SCISSOR_BOX_EXCLUSIVE_NV = $9556;
  // GL_NV_shader_buffer_load
  GL_BUFFER_GPU_ADDRESS_NV = $8F1D;
  GL_GPU_ADDRESS_NV = $8F34;
  GL_MAX_SHADER_BUFFER_ADDRESS_NV = $8F35;
  // GL_NV_shader_buffer_store
  GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = $00000010;
  // GL_NV_shader_subgroup_partitioned
  GL_SUBGROUP_FEATURE_PARTITIONED_BIT_NV = $00000100;
  // GL_NV_shader_thread_group
  GL_WARP_SIZE_NV = $9339;
  GL_WARPS_PER_SM_NV = $933A;
  GL_SM_COUNT_NV = $933B;
  // GL_NV_shading_rate_image
  GL_SHADING_RATE_IMAGE_NV = $9563;
  GL_SHADING_RATE_NO_INVOCATIONS_NV = $9564;
  GL_SHADING_RATE_1_INVOCATION_PER_PIXEL_NV = $9565;
  GL_SHADING_RATE_1_INVOCATION_PER_1X2_PIXELS_NV = $9566;
  GL_SHADING_RATE_1_INVOCATION_PER_2X1_PIXELS_NV = $9567;
  GL_SHADING_RATE_1_INVOCATION_PER_2X2_PIXELS_NV = $9568;
  GL_SHADING_RATE_1_INVOCATION_PER_2X4_PIXELS_NV = $9569;
  GL_SHADING_RATE_1_INVOCATION_PER_4X2_PIXELS_NV = $956A;
  GL_SHADING_RATE_1_INVOCATION_PER_4X4_PIXELS_NV = $956B;
  GL_SHADING_RATE_2_INVOCATIONS_PER_PIXEL_NV = $956C;
  GL_SHADING_RATE_4_INVOCATIONS_PER_PIXEL_NV = $956D;
  GL_SHADING_RATE_8_INVOCATIONS_PER_PIXEL_NV = $956E;
  GL_SHADING_RATE_16_INVOCATIONS_PER_PIXEL_NV = $956F;
  GL_SHADING_RATE_IMAGE_BINDING_NV = $955B;
  GL_SHADING_RATE_IMAGE_TEXEL_WIDTH_NV = $955C;
  GL_SHADING_RATE_IMAGE_TEXEL_HEIGHT_NV = $955D;
  GL_SHADING_RATE_IMAGE_PALETTE_SIZE_NV = $955E;
  GL_MAX_COARSE_FRAGMENT_SAMPLES_NV = $955F;
  GL_SHADING_RATE_SAMPLE_ORDER_DEFAULT_NV = $95AE;
  GL_SHADING_RATE_SAMPLE_ORDER_PIXEL_MAJOR_NV = $95AF;
  GL_SHADING_RATE_SAMPLE_ORDER_SAMPLE_MAJOR_NV = $95B0;
      // GL_NV_tessellation_program5
      GL_MAX_PROGRAM_PATCH_ATTRIBS_NV = $86D8;
      GL_TESS_CONTROL_PROGRAM_NV = $891E;
      GL_TESS_EVALUATION_PROGRAM_NV = $891F;
      GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = $8C74;
      GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = $8C75;
      // GL_NV_texgen_emboss
      GL_EMBOSS_LIGHT_NV = $855D;
      GL_EMBOSS_CONSTANT_NV = $855E;
      GL_EMBOSS_MAP_NV = $855F;
      // GL_NV_texgen_reflection
      GL_NORMAL_MAP_NV = $8511;
      GL_REFLECTION_MAP_NV = $8512;
      // GL_NV_texture_env_combine4
      GL_COMBINE4_NV = $8503;
      GL_SOURCE3_RGB_NV = $8583;
      GL_SOURCE3_ALPHA_NV = $858B;
      GL_OPERAND3_RGB_NV = $8593;
      GL_OPERAND3_ALPHA_NV = $859B;
      // GL_NV_texture_expand_normal
      GL_TEXTURE_UNSIGNED_REMAP_MODE_NV = $888F;
      // GL_NV_texture_multisample
      GL_TEXTURE_COVERAGE_SAMPLES_NV = $9045;
      GL_TEXTURE_COLOR_SAMPLES_NV = $9046;
      // GL_NV_texture_rectangle
      GL_TEXTURE_RECTANGLE_NV = $84F5;
      GL_TEXTURE_BINDING_RECTANGLE_NV = $84F6;
      GL_PROXY_TEXTURE_RECTANGLE_NV = $84F7;
      GL_MAX_RECTANGLE_TEXTURE_SIZE_NV = $84F8;
      // GL_NV_texture_shader
      GL_OFFSET_TEXTURE_RECTANGLE_NV = $864C;
      GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV = $864D;
      GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV = $864E;
      GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV = $86D9;
      GL_UNSIGNED_INT_S8_S8_8_8_NV = $86DA;
      GL_UNSIGNED_INT_8_8_S8_S8_REV_NV = $86DB;
      GL_DSDT_MAG_INTENSITY_NV = $86DC;
      GL_SHADER_CONSISTENT_NV = $86DD;
      GL_TEXTURE_SHADER_NV = $86DE;
      GL_SHADER_OPERATION_NV = $86DF;
      GL_CULL_MODES_NV = $86E0;
      GL_OFFSET_TEXTURE_MATRIX_NV = $86E1;
      GL_OFFSET_TEXTURE_SCALE_NV = $86E2;
      GL_OFFSET_TEXTURE_BIAS_NV = $86E3;
      GL_OFFSET_TEXTURE_2D_MATRIX_NV = $86E1;
      GL_OFFSET_TEXTURE_2D_SCALE_NV = $86E2;
      GL_OFFSET_TEXTURE_2D_BIAS_NV = $86E3;
      GL_PREVIOUS_TEXTURE_INPUT_NV = $86E4;
      GL_CONST_EYE_NV = $86E5;
      GL_PASS_THROUGH_NV = $86E6;
      GL_CULL_FRAGMENT_NV = $86E7;
      GL_OFFSET_TEXTURE_2D_NV = $86E8;
      GL_DEPENDENT_AR_TEXTURE_2D_NV = $86E9;
      GL_DEPENDENT_GB_TEXTURE_2D_NV = $86EA;
      GL_DOT_PRODUCT_NV = $86EC;
      GL_DOT_PRODUCT_DEPTH_REPLACE_NV = $86ED;
      GL_DOT_PRODUCT_TEXTURE_2D_NV = $86EE;
      GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV = $86F0;
      GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV = $86F1;
      GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV = $86F2;
      GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV = $86F3;
      GL_HILO_NV = $86F4;
      GL_DSDT_NV = $86F5;
      GL_DSDT_MAG_NV = $86F6;
      GL_DSDT_MAG_VIB_NV = $86F7;
      GL_HILO16_NV = $86F8;
      GL_SIGNED_HILO_NV = $86F9;
      GL_SIGNED_HILO16_NV = $86FA;
      GL_SIGNED_RGBA_NV = $86FB;
      GL_SIGNED_RGBA8_NV = $86FC;
      GL_SIGNED_RGB_NV = $86FE;
      GL_SIGNED_RGB8_NV = $86FF;
      GL_SIGNED_LUMINANCE_NV = $8701;
      GL_SIGNED_LUMINANCE8_NV = $8702;
      GL_SIGNED_LUMINANCE_ALPHA_NV = $8703;
      GL_SIGNED_LUMINANCE8_ALPHA8_NV = $8704;
      GL_SIGNED_ALPHA_NV = $8705;
      GL_SIGNED_ALPHA8_NV = $8706;
      GL_SIGNED_INTENSITY_NV = $8707;
      GL_SIGNED_INTENSITY8_NV = $8708;
      GL_DSDT8_NV = $8709;
      GL_DSDT8_MAG8_NV = $870A;
      GL_DSDT8_MAG8_INTENSITY8_NV = $870B;
      GL_SIGNED_RGB_UNSIGNED_ALPHA_NV = $870C;
      GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV = $870D;
      GL_HI_SCALE_NV = $870E;
      GL_LO_SCALE_NV = $870F;
      GL_DS_SCALE_NV = $8710;
      GL_DT_SCALE_NV = $8711;
      GL_MAGNITUDE_SCALE_NV = $8712;
      GL_VIBRANCE_SCALE_NV = $8713;
      GL_HI_BIAS_NV = $8714;
      GL_LO_BIAS_NV = $8715;
      GL_DS_BIAS_NV = $8716;
      GL_DT_BIAS_NV = $8717;
      GL_MAGNITUDE_BIAS_NV = $8718;
      GL_VIBRANCE_BIAS_NV = $8719;
      GL_TEXTURE_BORDER_VALUES_NV = $871A;
      GL_TEXTURE_HI_SIZE_NV = $871B;
      GL_TEXTURE_LO_SIZE_NV = $871C;
      GL_TEXTURE_DS_SIZE_NV = $871D;
      GL_TEXTURE_DT_SIZE_NV = $871E;
      GL_TEXTURE_MAG_SIZE_NV = $871F;
      // GL_NV_texture_shader2
      GL_DOT_PRODUCT_TEXTURE_3D_NV = $86EF;
      // GL_NV_texture_shader3
      GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV = $8850;
      GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV = $8851;
      GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV = $8852;
      GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV = $8853;
      GL_OFFSET_HILO_TEXTURE_2D_NV = $8854;
      GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV = $8855;
      GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV = $8856;
      GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV = $8857;
      GL_DEPENDENT_HILO_TEXTURE_2D_NV = $8858;
      GL_DEPENDENT_RGB_TEXTURE_3D_NV = $8859;
      GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV = $885A;
      GL_DOT_PRODUCT_PASS_THROUGH_NV = $885B;
      GL_DOT_PRODUCT_TEXTURE_1D_NV = $885C;
      GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV = $885D;
      GL_HILO8_NV = $885E;
      GL_SIGNED_HILO8_NV = $885F;
      GL_FORCE_BLUE_TO_ONE_NV = $8860;
      // GL_NV_timeline_semaphore
      GL_TIMELINE_SEMAPHORE_VALUE_NV = $9595;
      GL_SEMAPHORE_TYPE_NV = $95B3;
      GL_SEMAPHORE_TYPE_BINARY_NV = $95B4;
      GL_SEMAPHORE_TYPE_TIMELINE_NV = $95B5;
      GL_MAX_TIMELINE_SEMAPHORE_VALUE_DIFFERENCE_NV = $95B6;
      // GL_NV_transform_feedback
      GL_BACK_PRIMARY_COLOR_NV = $8C77;
      GL_BACK_SECONDARY_COLOR_NV = $8C78;
      GL_TEXTURE_COORD_NV = $8C79;
      GL_CLIP_DISTANCE_NV = $8C7A;
      GL_VERTEX_ID_NV = $8C7B;
      GL_PRIMITIVE_ID_NV = $8C7C;
      GL_GENERIC_ATTRIB_NV = $8C7D;
      GL_TRANSFORM_FEEDBACK_ATTRIBS_NV = $8C7E;
      GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV = $8C7F;
      GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV = $8C80;
      GL_ACTIVE_VARYINGS_NV = $8C81;
      GL_ACTIVE_VARYING_MAX_LENGTH_NV = $8C82;
      GL_TRANSFORM_FEEDBACK_VARYINGS_NV = $8C83;
      GL_TRANSFORM_FEEDBACK_BUFFER_START_NV = $8C84;
      GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV = $8C85;
      GL_TRANSFORM_FEEDBACK_RECORD_NV = $8C86;
      GL_PRIMITIVES_GENERATED_NV = $8C87;
      GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV = $8C88;
      GL_RASTERIZER_DISCARD_NV = $8C89;
      GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_NV = $8C8A;
      GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV = $8C8B;
      GL_INTERLEAVED_ATTRIBS_NV = $8C8C;
      GL_SEPARATE_ATTRIBS_NV = $8C8D;
      GL_TRANSFORM_FEEDBACK_BUFFER_NV = $8C8E;
      GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV = $8C8F;
      GL_LAYER_NV = $8DAA;
      GL_NEXT_BUFFER_NV = -(2);
      GL_SKIP_COMPONENTS4_NV = -(3);
      GL_SKIP_COMPONENTS3_NV = -(4);
      GL_SKIP_COMPONENTS2_NV = -(5);
      GL_SKIP_COMPONENTS1_NV = -(6);
      // GL_NV_transform_feedback2
      GL_TRANSFORM_FEEDBACK_NV = $8E22;
      GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = $8E23;
      GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = $8E24;
      GL_TRANSFORM_FEEDBACK_BINDING_NV = $8E25;
  // GL_NV_uniform_buffer_unified_memory
  GL_UNIFORM_BUFFER_UNIFIED_NV = $936E;
  GL_UNIFORM_BUFFER_ADDRESS_NV = $936F;
  GL_UNIFORM_BUFFER_LENGTH_NV = $9370;
      // GL_NV_vdpau_interop
      GL_SURFACE_STATE_NV = $86EB;
      GL_SURFACE_REGISTERED_NV = $86FD;
      GL_SURFACE_MAPPED_NV = $8700;
      GL_WRITE_DISCARD_NV = $88BE;
      // GL_NV_vertex_array_range
      GL_VERTEX_ARRAY_RANGE_NV = $851D;
      GL_VERTEX_ARRAY_RANGE_LENGTH_NV = $851E;
      GL_VERTEX_ARRAY_RANGE_VALID_NV = $851F;
      GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = $8520;
      GL_VERTEX_ARRAY_RANGE_POINTER_NV = $8521;
      // GL_NV_vertex_array_range2
      GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = $8533;
  // GL_NV_vertex_buffer_unified_memory
  GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV = $8F1E;
  GL_ELEMENT_ARRAY_UNIFIED_NV = $8F1F;
  GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV = $8F20;
  GL_VERTEX_ARRAY_ADDRESS_NV = $8F21;
  GL_NORMAL_ARRAY_ADDRESS_NV = $8F22;
  GL_COLOR_ARRAY_ADDRESS_NV = $8F23;
  GL_INDEX_ARRAY_ADDRESS_NV = $8F24;
  GL_TEXTURE_COORD_ARRAY_ADDRESS_NV = $8F25;
  GL_EDGE_FLAG_ARRAY_ADDRESS_NV = $8F26;
  GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV = $8F27;
  GL_FOG_COORD_ARRAY_ADDRESS_NV = $8F28;
  GL_ELEMENT_ARRAY_ADDRESS_NV = $8F29;
  GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV = $8F2A;
  GL_VERTEX_ARRAY_LENGTH_NV = $8F2B;
  GL_NORMAL_ARRAY_LENGTH_NV = $8F2C;
  GL_COLOR_ARRAY_LENGTH_NV = $8F2D;
  GL_INDEX_ARRAY_LENGTH_NV = $8F2E;
  GL_TEXTURE_COORD_ARRAY_LENGTH_NV = $8F2F;
  GL_EDGE_FLAG_ARRAY_LENGTH_NV = $8F30;
  GL_SECONDARY_COLOR_ARRAY_LENGTH_NV = $8F31;
  GL_FOG_COORD_ARRAY_LENGTH_NV = $8F32;
  GL_ELEMENT_ARRAY_LENGTH_NV = $8F33;
  GL_DRAW_INDIRECT_UNIFIED_NV = $8F40;
  GL_DRAW_INDIRECT_ADDRESS_NV = $8F41;
  GL_DRAW_INDIRECT_LENGTH_NV = $8F42;
      // GL_NV_vertex_program
      GL_VERTEX_PROGRAM_NV = $8620;
      GL_VERTEX_STATE_PROGRAM_NV = $8621;
      GL_ATTRIB_ARRAY_SIZE_NV = $8623;
      GL_ATTRIB_ARRAY_STRIDE_NV = $8624;
      GL_ATTRIB_ARRAY_TYPE_NV = $8625;
      GL_CURRENT_ATTRIB_NV = $8626;
      GL_PROGRAM_LENGTH_NV = $8627;
      GL_PROGRAM_STRING_NV = $8628;
      GL_MODELVIEW_PROJECTION_NV = $8629;
      GL_IDENTITY_NV = $862A;
      GL_INVERSE_NV = $862B;
      GL_TRANSPOSE_NV = $862C;
      GL_INVERSE_TRANSPOSE_NV = $862D;
      GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV = $862E;
      GL_MAX_TRACK_MATRICES_NV = $862F;
      GL_MATRIX0_NV = $8630;
      GL_MATRIX1_NV = $8631;
      GL_MATRIX2_NV = $8632;
      GL_MATRIX3_NV = $8633;
      GL_MATRIX4_NV = $8634;
      GL_MATRIX5_NV = $8635;
      GL_MATRIX6_NV = $8636;
      GL_MATRIX7_NV = $8637;
      GL_CURRENT_MATRIX_STACK_DEPTH_NV = $8640;
      GL_CURRENT_MATRIX_NV = $8641;
      GL_VERTEX_PROGRAM_POINT_SIZE_NV = $8642;
      GL_VERTEX_PROGRAM_TWO_SIDE_NV = $8643;
      GL_PROGRAM_PARAMETER_NV = $8644;
      GL_ATTRIB_ARRAY_POINTER_NV = $8645;
      GL_PROGRAM_TARGET_NV = $8646;
      GL_PROGRAM_RESIDENT_NV = $8647;
      GL_TRACK_MATRIX_NV = $8648;
      GL_TRACK_MATRIX_TRANSFORM_NV = $8649;
      GL_VERTEX_PROGRAM_BINDING_NV = $864A;
      GL_PROGRAM_ERROR_POSITION_NV = $864B;
      GL_VERTEX_ATTRIB_ARRAY0_NV = $8650;
      GL_VERTEX_ATTRIB_ARRAY1_NV = $8651;
      GL_VERTEX_ATTRIB_ARRAY2_NV = $8652;
      GL_VERTEX_ATTRIB_ARRAY3_NV = $8653;
      GL_VERTEX_ATTRIB_ARRAY4_NV = $8654;
      GL_VERTEX_ATTRIB_ARRAY5_NV = $8655;
      GL_VERTEX_ATTRIB_ARRAY6_NV = $8656;
      GL_VERTEX_ATTRIB_ARRAY7_NV = $8657;
      GL_VERTEX_ATTRIB_ARRAY8_NV = $8658;
      GL_VERTEX_ATTRIB_ARRAY9_NV = $8659;
      GL_VERTEX_ATTRIB_ARRAY10_NV = $865A;
      GL_VERTEX_ATTRIB_ARRAY11_NV = $865B;
      GL_VERTEX_ATTRIB_ARRAY12_NV = $865C;
      GL_VERTEX_ATTRIB_ARRAY13_NV = $865D;
      GL_VERTEX_ATTRIB_ARRAY14_NV = $865E;
      GL_VERTEX_ATTRIB_ARRAY15_NV = $865F;
      GL_MAP1_VERTEX_ATTRIB0_4_NV = $8660;
      GL_MAP1_VERTEX_ATTRIB1_4_NV = $8661;
      GL_MAP1_VERTEX_ATTRIB2_4_NV = $8662;
      GL_MAP1_VERTEX_ATTRIB3_4_NV = $8663;
      GL_MAP1_VERTEX_ATTRIB4_4_NV = $8664;
      GL_MAP1_VERTEX_ATTRIB5_4_NV = $8665;
      GL_MAP1_VERTEX_ATTRIB6_4_NV = $8666;
      GL_MAP1_VERTEX_ATTRIB7_4_NV = $8667;
      GL_MAP1_VERTEX_ATTRIB8_4_NV = $8668;
      GL_MAP1_VERTEX_ATTRIB9_4_NV = $8669;
      GL_MAP1_VERTEX_ATTRIB10_4_NV = $866A;
      GL_MAP1_VERTEX_ATTRIB11_4_NV = $866B;
      GL_MAP1_VERTEX_ATTRIB12_4_NV = $866C;
      GL_MAP1_VERTEX_ATTRIB13_4_NV = $866D;
      GL_MAP1_VERTEX_ATTRIB14_4_NV = $866E;
      GL_MAP1_VERTEX_ATTRIB15_4_NV = $866F;
      GL_MAP2_VERTEX_ATTRIB0_4_NV = $8670;
      GL_MAP2_VERTEX_ATTRIB1_4_NV = $8671;
      GL_MAP2_VERTEX_ATTRIB2_4_NV = $8672;
      GL_MAP2_VERTEX_ATTRIB3_4_NV = $8673;
      GL_MAP2_VERTEX_ATTRIB4_4_NV = $8674;
      GL_MAP2_VERTEX_ATTRIB5_4_NV = $8675;
      GL_MAP2_VERTEX_ATTRIB6_4_NV = $8676;
      GL_MAP2_VERTEX_ATTRIB7_4_NV = $8677;
      GL_MAP2_VERTEX_ATTRIB8_4_NV = $8678;
      GL_MAP2_VERTEX_ATTRIB9_4_NV = $8679;
      GL_MAP2_VERTEX_ATTRIB10_4_NV = $867A;
      GL_MAP2_VERTEX_ATTRIB11_4_NV = $867B;
      GL_MAP2_VERTEX_ATTRIB12_4_NV = $867C;
      GL_MAP2_VERTEX_ATTRIB13_4_NV = $867D;
      GL_MAP2_VERTEX_ATTRIB14_4_NV = $867E;
      GL_MAP2_VERTEX_ATTRIB15_4_NV = $867F;
      // GL_NV_vertex_program4
      GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV = $88FD;
      // GL_NV_video_capture
      GL_VIDEO_BUFFER_NV = $9020;
      GL_VIDEO_BUFFER_BINDING_NV = $9021;
      GL_FIELD_UPPER_NV = $9022;
      GL_FIELD_LOWER_NV = $9023;
      GL_NUM_VIDEO_CAPTURE_STREAMS_NV = $9024;
      GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV = $9025;
      GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV = $9026;
      GL_LAST_VIDEO_CAPTURE_STATUS_NV = $9027;
      GL_VIDEO_BUFFER_PITCH_NV = $9028;
      GL_VIDEO_COLOR_CONVERSION_MATRIX_NV = $9029;
      GL_VIDEO_COLOR_CONVERSION_MAX_NV = $902A;
      GL_VIDEO_COLOR_CONVERSION_MIN_NV = $902B;
      GL_VIDEO_COLOR_CONVERSION_OFFSET_NV = $902C;
      GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV = $902D;
      GL_PARTIAL_SUCCESS_NV = $902E;
      GL_SUCCESS_NV = $902F;
      GL_FAILURE_NV = $9030;
      GL_YCBYCR8_422_NV = $9031;
      GL_YCBAYCR8A_4224_NV = $9032;
      GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV = $9033;
      GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV = $9034;
      GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV = $9035;
      GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV = $9036;
      GL_Z4Y12Z4CB12Z4CR12_444_NV = $9037;
      GL_VIDEO_CAPTURE_FRAME_WIDTH_NV = $9038;
      GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV = $9039;
      GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV = $903A;
      GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV = $903B;
      GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV = $903C;
  // GL_NV_viewport_swizzle
  GL_VIEWPORT_SWIZZLE_POSITIVE_X_NV = $9350;
  GL_VIEWPORT_SWIZZLE_NEGATIVE_X_NV = $9351;
  GL_VIEWPORT_SWIZZLE_POSITIVE_Y_NV = $9352;
  GL_VIEWPORT_SWIZZLE_NEGATIVE_Y_NV = $9353;
  GL_VIEWPORT_SWIZZLE_POSITIVE_Z_NV = $9354;
  GL_VIEWPORT_SWIZZLE_NEGATIVE_Z_NV = $9355;
  GL_VIEWPORT_SWIZZLE_POSITIVE_W_NV = $9356;
  GL_VIEWPORT_SWIZZLE_NEGATIVE_W_NV = $9357;
  GL_VIEWPORT_SWIZZLE_X_NV = $9358;
  GL_VIEWPORT_SWIZZLE_Y_NV = $9359;
  GL_VIEWPORT_SWIZZLE_Z_NV = $935A;
  GL_VIEWPORT_SWIZZLE_W_NV = $935B;
      // GL_OML_interlace
      GL_INTERLACE_OML = $8980;
      GL_INTERLACE_READ_OML = $8981;
      // GL_OML_resample
      GL_PACK_RESAMPLE_OML = $8984;
      GL_UNPACK_RESAMPLE_OML = $8985;
      GL_RESAMPLE_REPLICATE_OML = $8986;
      GL_RESAMPLE_ZERO_FILL_OML = $8987;
      GL_RESAMPLE_AVERAGE_OML = $8988;
      GL_RESAMPLE_DECIMATE_OML = $8989;
      // GL_OML_subsample
      GL_FORMAT_SUBSAMPLE_24_24_OML = $8982;
      GL_FORMAT_SUBSAMPLE_244_244_OML = $8983;
  // GL_OVR_multiview
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_NUM_VIEWS_OVR = $9630;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_BASE_VIEW_INDEX_OVR = $9632;
  GL_MAX_VIEWS_OVR = $9631;
  GL_FRAMEBUFFER_INCOMPLETE_VIEW_TARGETS_OVR = $9633;
      // GL_PGI_misc_hints
      GL_PREFER_DOUBLEBUFFER_HINT_PGI = $1A1F8;
      GL_CONSERVE_MEMORY_HINT_PGI = $1A1FD;
      GL_RECLAIM_MEMORY_HINT_PGI = $1A1FE;
      GL_NATIVE_GRAPHICS_HANDLE_PGI = $1A202;
      GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI = $1A203;
      GL_NATIVE_GRAPHICS_END_HINT_PGI = $1A204;
      GL_ALWAYS_FAST_HINT_PGI = $1A20C;
      GL_ALWAYS_SOFT_HINT_PGI = $1A20D;
      GL_ALLOW_DRAW_OBJ_HINT_PGI = $1A20E;
      GL_ALLOW_DRAW_WIN_HINT_PGI = $1A20F;
      GL_ALLOW_DRAW_FRG_HINT_PGI = $1A210;
      GL_ALLOW_DRAW_MEM_HINT_PGI = $1A211;
      GL_STRICT_DEPTHFUNC_HINT_PGI = $1A216;
      GL_STRICT_LIGHTING_HINT_PGI = $1A217;
      GL_STRICT_SCISSOR_HINT_PGI = $1A218;
      GL_FULL_STIPPLE_HINT_PGI = $1A219;
      GL_CLIP_NEAR_HINT_PGI = $1A220;
      GL_CLIP_FAR_HINT_PGI = $1A221;
      GL_WIDE_LINE_HINT_PGI = $1A222;
      GL_BACK_NORMALS_HINT_PGI = $1A223;
      // GL_PGI_vertex_hints
      GL_VERTEX_DATA_HINT_PGI = $1A22A;
      GL_VERTEX_CONSISTENT_HINT_PGI = $1A22B;
      GL_MATERIAL_SIDE_HINT_PGI = $1A22C;
      GL_MAX_VERTEX_HINT_PGI = $1A22D;
      GL_COLOR3_BIT_PGI = $00010000;
      GL_COLOR4_BIT_PGI = $00020000;
      GL_EDGEFLAG_BIT_PGI = $00040000;
      GL_INDEX_BIT_PGI = $00080000;
      GL_MAT_AMBIENT_BIT_PGI = $00100000;
      GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI = $00200000;
      GL_MAT_DIFFUSE_BIT_PGI = $00400000;
      GL_MAT_EMISSION_BIT_PGI = $00800000;
      GL_MAT_COLOR_INDEXES_BIT_PGI = $01000000;
      GL_MAT_SHININESS_BIT_PGI = $02000000;
      GL_MAT_SPECULAR_BIT_PGI = $04000000;
      GL_NORMAL_BIT_PGI = $08000000;
      GL_TEXCOORD1_BIT_PGI = $10000000;
      GL_TEXCOORD2_BIT_PGI = $20000000;
      GL_TEXCOORD3_BIT_PGI = $40000000;
      GL_TEXCOORD4_BIT_PGI = $80000000;
      GL_VERTEX23_BIT_PGI = $00000004;
      GL_VERTEX4_BIT_PGI = $00000008;
      // GL_REND_screen_coordinates
      GL_SCREEN_COORDINATES_REND = $8490;
      GL_INVERTED_SCREEN_W_REND = $8491;
      // GL_S3_s3tc
      GL_RGB_S3TC = $83A0;
      GL_RGB4_S3TC = $83A1;
      GL_RGBA_S3TC = $83A2;
      GL_RGBA4_S3TC = $83A3;
      GL_RGBA_DXT5_S3TC = $83A4;
      GL_RGBA4_DXT5_S3TC = $83A5;
      // GL_SGIS_detail_texture
      GL_DETAIL_TEXTURE_2D_SGIS = $8095;
      GL_DETAIL_TEXTURE_2D_BINDING_SGIS = $8096;
      GL_LINEAR_DETAIL_SGIS = $8097;
      GL_LINEAR_DETAIL_ALPHA_SGIS = $8098;
      GL_LINEAR_DETAIL_COLOR_SGIS = $8099;
      GL_DETAIL_TEXTURE_LEVEL_SGIS = $809A;
      GL_DETAIL_TEXTURE_MODE_SGIS = $809B;
      GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS = $809C;
      // GL_SGIS_fog_function
      GL_FOG_FUNC_SGIS = $812A;
      GL_FOG_FUNC_POINTS_SGIS = $812B;
      GL_MAX_FOG_FUNC_POINTS_SGIS = $812C;
      // GL_SGIS_generate_mipmap
      GL_GENERATE_MIPMAP_SGIS = $8191;
      GL_GENERATE_MIPMAP_HINT_SGIS = $8192;
      // GL_SGIS_multisample
      GL_MULTISAMPLE_SGIS = $809D;
      GL_SAMPLE_ALPHA_TO_MASK_SGIS = $809E;
      GL_SAMPLE_ALPHA_TO_ONE_SGIS = $809F;
      GL_SAMPLE_MASK_SGIS = $80A0;
      GL_1PASS_SGIS = $80A1;
      GL_2PASS_0_SGIS = $80A2;
      GL_2PASS_1_SGIS = $80A3;
      GL_4PASS_0_SGIS = $80A4;
      GL_4PASS_1_SGIS = $80A5;
      GL_4PASS_2_SGIS = $80A6;
      GL_4PASS_3_SGIS = $80A7;
      GL_SAMPLE_BUFFERS_SGIS = $80A8;
      GL_SAMPLES_SGIS = $80A9;
      GL_SAMPLE_MASK_VALUE_SGIS = $80AA;
      GL_SAMPLE_MASK_INVERT_SGIS = $80AB;
      GL_SAMPLE_PATTERN_SGIS = $80AC;
      // GL_SGIS_pixel_texture
      GL_PIXEL_TEXTURE_SGIS = $8353;
      GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS = $8354;
      GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS = $8355;
      GL_PIXEL_GROUP_COLOR_SGIS = $8356;
      // GL_SGIS_point_line_texgen
      GL_EYE_DISTANCE_TO_POINT_SGIS = $81F0;
      GL_OBJECT_DISTANCE_TO_POINT_SGIS = $81F1;
      GL_EYE_DISTANCE_TO_LINE_SGIS = $81F2;
      GL_OBJECT_DISTANCE_TO_LINE_SGIS = $81F3;
      GL_EYE_POINT_SGIS = $81F4;
      GL_OBJECT_POINT_SGIS = $81F5;
      GL_EYE_LINE_SGIS = $81F6;
      GL_OBJECT_LINE_SGIS = $81F7;
      // GL_SGIS_point_parameters
      GL_POINT_SIZE_MIN_SGIS = $8126;
      GL_POINT_SIZE_MAX_SGIS = $8127;
      GL_POINT_FADE_THRESHOLD_SIZE_SGIS = $8128;
      GL_DISTANCE_ATTENUATION_SGIS = $8129;
      // GL_SGIS_sharpen_texture
      GL_LINEAR_SHARPEN_SGIS = $80AD;
      GL_LINEAR_SHARPEN_ALPHA_SGIS = $80AE;
      GL_LINEAR_SHARPEN_COLOR_SGIS = $80AF;
      GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS = $80B0;
      // GL_SGIS_texture4D
      GL_PACK_SKIP_VOLUMES_SGIS = $8130;
      GL_PACK_IMAGE_DEPTH_SGIS = $8131;
      GL_UNPACK_SKIP_VOLUMES_SGIS = $8132;
      GL_UNPACK_IMAGE_DEPTH_SGIS = $8133;
      GL_TEXTURE_4D_SGIS = $8134;
      GL_PROXY_TEXTURE_4D_SGIS = $8135;
      GL_TEXTURE_4DSIZE_SGIS = $8136;
      GL_TEXTURE_WRAP_Q_SGIS = $8137;
      GL_MAX_4D_TEXTURE_SIZE_SGIS = $8138;
      GL_TEXTURE_4D_BINDING_SGIS = $814F;
      // GL_SGIS_texture_border_clamp
      GL_CLAMP_TO_BORDER_SGIS = $812D;
      // GL_SGIS_texture_color_mask
      GL_TEXTURE_COLOR_WRITEMASK_SGIS = $81EF;
      // GL_SGIS_texture_edge_clamp
      GL_CLAMP_TO_EDGE_SGIS = $812F;
      // GL_SGIS_texture_filter4
      GL_FILTER4_SGIS = $8146;
      GL_TEXTURE_FILTER4_SIZE_SGIS = $8147;
      // GL_SGIS_texture_lod
      GL_TEXTURE_MIN_LOD_SGIS = $813A;
      GL_TEXTURE_MAX_LOD_SGIS = $813B;
      GL_TEXTURE_BASE_LEVEL_SGIS = $813C;
      GL_TEXTURE_MAX_LEVEL_SGIS = $813D;
      // GL_SGIS_texture_select
      GL_DUAL_ALPHA4_SGIS = $8110;
      GL_DUAL_ALPHA8_SGIS = $8111;
      GL_DUAL_ALPHA12_SGIS = $8112;
      GL_DUAL_ALPHA16_SGIS = $8113;
      GL_DUAL_LUMINANCE4_SGIS = $8114;
      GL_DUAL_LUMINANCE8_SGIS = $8115;
      GL_DUAL_LUMINANCE12_SGIS = $8116;
      GL_DUAL_LUMINANCE16_SGIS = $8117;
      GL_DUAL_INTENSITY4_SGIS = $8118;
      GL_DUAL_INTENSITY8_SGIS = $8119;
      GL_DUAL_INTENSITY12_SGIS = $811A;
      GL_DUAL_INTENSITY16_SGIS = $811B;
      GL_DUAL_LUMINANCE_ALPHA4_SGIS = $811C;
      GL_DUAL_LUMINANCE_ALPHA8_SGIS = $811D;
      GL_QUAD_ALPHA4_SGIS = $811E;
      GL_QUAD_ALPHA8_SGIS = $811F;
      GL_QUAD_LUMINANCE4_SGIS = $8120;
      GL_QUAD_LUMINANCE8_SGIS = $8121;
      GL_QUAD_INTENSITY4_SGIS = $8122;
      GL_QUAD_INTENSITY8_SGIS = $8123;
      GL_DUAL_TEXTURE_SELECT_SGIS = $8124;
      GL_QUAD_TEXTURE_SELECT_SGIS = $8125;
      // GL_SGIX_async
      GL_ASYNC_MARKER_SGIX = $8329;
      // GL_SGIX_async_histogram
      GL_ASYNC_HISTOGRAM_SGIX = $832C;
      GL_MAX_ASYNC_HISTOGRAM_SGIX = $832D;
      // GL_SGIX_async_pixel
      GL_ASYNC_TEX_IMAGE_SGIX = $835C;
      GL_ASYNC_DRAW_PIXELS_SGIX = $835D;
      GL_ASYNC_READ_PIXELS_SGIX = $835E;
      GL_MAX_ASYNC_TEX_IMAGE_SGIX = $835F;
      GL_MAX_ASYNC_DRAW_PIXELS_SGIX = $8360;
      GL_MAX_ASYNC_READ_PIXELS_SGIX = $8361;
      // GL_SGIX_blend_alpha_minmax
      GL_ALPHA_MIN_SGIX = $8320;
      GL_ALPHA_MAX_SGIX = $8321;
      // GL_SGIX_calligraphic_fragment
      GL_CALLIGRAPHIC_FRAGMENT_SGIX = $8183;
      // GL_SGIX_clipmap
      GL_LINEAR_CLIPMAP_LINEAR_SGIX = $8170;
      GL_TEXTURE_CLIPMAP_CENTER_SGIX = $8171;
      GL_TEXTURE_CLIPMAP_FRAME_SGIX = $8172;
      GL_TEXTURE_CLIPMAP_OFFSET_SGIX = $8173;
      GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX = $8174;
      GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX = $8175;
      GL_TEXTURE_CLIPMAP_DEPTH_SGIX = $8176;
      GL_MAX_CLIPMAP_DEPTH_SGIX = $8177;
      GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX = $8178;
      GL_NEAREST_CLIPMAP_NEAREST_SGIX = $844D;
      GL_NEAREST_CLIPMAP_LINEAR_SGIX = $844E;
      GL_LINEAR_CLIPMAP_NEAREST_SGIX = $844F;
      // GL_SGIX_convolution_accuracy
      GL_CONVOLUTION_HINT_SGIX = $8316;
      // GL_SGIX_depth_texture
      GL_DEPTH_COMPONENT16_SGIX = $81A5;
      GL_DEPTH_COMPONENT24_SGIX = $81A6;
      GL_DEPTH_COMPONENT32_SGIX = $81A7;
      // GL_SGIX_fog_offset
      GL_FOG_OFFSET_SGIX = $8198;
      GL_FOG_OFFSET_VALUE_SGIX = $8199;
      // GL_SGIX_fragment_lighting
      GL_FRAGMENT_LIGHTING_SGIX = $8400;
      GL_FRAGMENT_COLOR_MATERIAL_SGIX = $8401;
      GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX = $8402;
      GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX = $8403;
      GL_MAX_FRAGMENT_LIGHTS_SGIX = $8404;
      GL_MAX_ACTIVE_LIGHTS_SGIX = $8405;
      GL_CURRENT_RASTER_NORMAL_SGIX = $8406;
      GL_LIGHT_ENV_MODE_SGIX = $8407;
      GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX = $8408;
      GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX = $8409;
      GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX = $840A;
      GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX = $840B;
      GL_FRAGMENT_LIGHT0_SGIX = $840C;
      GL_FRAGMENT_LIGHT1_SGIX = $840D;
      GL_FRAGMENT_LIGHT2_SGIX = $840E;
      GL_FRAGMENT_LIGHT3_SGIX = $840F;
      GL_FRAGMENT_LIGHT4_SGIX = $8410;
      GL_FRAGMENT_LIGHT5_SGIX = $8411;
      GL_FRAGMENT_LIGHT6_SGIX = $8412;
      GL_FRAGMENT_LIGHT7_SGIX = $8413;
      // GL_SGIX_framezoom
      GL_FRAMEZOOM_SGIX = $818B;
      GL_FRAMEZOOM_FACTOR_SGIX = $818C;
      GL_MAX_FRAMEZOOM_FACTOR_SGIX = $818D;
      // GL_SGIX_instruments
      GL_INSTRUMENT_BUFFER_POINTER_SGIX = $8180;
      GL_INSTRUMENT_MEASUREMENTS_SGIX = $8181;
      // GL_SGIX_interlace
      GL_INTERLACE_SGIX = $8094;
      // GL_SGIX_ir_instrument1
      GL_IR_INSTRUMENT1_SGIX = $817F;
      // GL_SGIX_list_priority
      GL_LIST_PRIORITY_SGIX = $8182;
      // GL_SGIX_pixel_texture
      GL_PIXEL_TEX_GEN_SGIX = $8139;
      GL_PIXEL_TEX_GEN_MODE_SGIX = $832B;
      // GL_SGIX_pixel_tiles
      GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX = $813E;
      GL_PIXEL_TILE_CACHE_INCREMENT_SGIX = $813F;
      GL_PIXEL_TILE_WIDTH_SGIX = $8140;
      GL_PIXEL_TILE_HEIGHT_SGIX = $8141;
      GL_PIXEL_TILE_GRID_WIDTH_SGIX = $8142;
      GL_PIXEL_TILE_GRID_HEIGHT_SGIX = $8143;
      GL_PIXEL_TILE_GRID_DEPTH_SGIX = $8144;
      GL_PIXEL_TILE_CACHE_SIZE_SGIX = $8145;
      // GL_SGIX_polynomial_ffd
      GL_TEXTURE_DEFORMATION_BIT_SGIX = $00000001;
      GL_GEOMETRY_DEFORMATION_BIT_SGIX = $00000002;
      GL_GEOMETRY_DEFORMATION_SGIX = $8194;
      GL_TEXTURE_DEFORMATION_SGIX = $8195;
      GL_DEFORMATIONS_MASK_SGIX = $8196;
      GL_MAX_DEFORMATION_ORDER_SGIX = $8197;
      // GL_SGIX_reference_plane
      GL_REFERENCE_PLANE_SGIX = $817D;
      GL_REFERENCE_PLANE_EQUATION_SGIX = $817E;
      // GL_SGIX_resample
      GL_PACK_RESAMPLE_SGIX = $842E;
      GL_UNPACK_RESAMPLE_SGIX = $842F;
      GL_RESAMPLE_REPLICATE_SGIX = $8433;
      GL_RESAMPLE_ZERO_FILL_SGIX = $8434;
      GL_RESAMPLE_DECIMATE_SGIX = $8430;
      // GL_SGIX_scalebias_hint
      GL_SCALEBIAS_HINT_SGIX = $8322;
      // GL_SGIX_shadow
      GL_TEXTURE_COMPARE_SGIX = $819A;
      GL_TEXTURE_COMPARE_OPERATOR_SGIX = $819B;
      GL_TEXTURE_LEQUAL_R_SGIX = $819C;
      GL_TEXTURE_GEQUAL_R_SGIX = $819D;
      // GL_SGIX_shadow_ambient
      GL_SHADOW_AMBIENT_SGIX = $80BF;
      // GL_SGIX_sprite
      GL_SPRITE_SGIX = $8148;
      GL_SPRITE_MODE_SGIX = $8149;
      GL_SPRITE_AXIS_SGIX = $814A;
      GL_SPRITE_TRANSLATION_SGIX = $814B;
      GL_SPRITE_AXIAL_SGIX = $814C;
      GL_SPRITE_OBJECT_ALIGNED_SGIX = $814D;
      GL_SPRITE_EYE_ALIGNED_SGIX = $814E;
      // GL_SGIX_subsample
      GL_PACK_SUBSAMPLE_RATE_SGIX = $85A0;
      GL_UNPACK_SUBSAMPLE_RATE_SGIX = $85A1;
      GL_PIXEL_SUBSAMPLE_4444_SGIX = $85A2;
      GL_PIXEL_SUBSAMPLE_2424_SGIX = $85A3;
      GL_PIXEL_SUBSAMPLE_4242_SGIX = $85A4;
      // GL_SGIX_texture_add_env
      GL_TEXTURE_ENV_BIAS_SGIX = $80BE;
      // GL_SGIX_texture_coordinate_clamp
      GL_TEXTURE_MAX_CLAMP_S_SGIX = $8369;
      GL_TEXTURE_MAX_CLAMP_T_SGIX = $836A;
      GL_TEXTURE_MAX_CLAMP_R_SGIX = $836B;
      // GL_SGIX_texture_lod_bias
      GL_TEXTURE_LOD_BIAS_S_SGIX = $818E;
      GL_TEXTURE_LOD_BIAS_T_SGIX = $818F;
      GL_TEXTURE_LOD_BIAS_R_SGIX = $8190;
      // GL_SGIX_texture_multi_buffer
      GL_TEXTURE_MULTI_BUFFER_HINT_SGIX = $812E;
      // GL_SGIX_texture_scale_bias
      GL_POST_TEXTURE_FILTER_BIAS_SGIX = $8179;
      GL_POST_TEXTURE_FILTER_SCALE_SGIX = $817A;
      GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = $817B;
      GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = $817C;
      // GL_SGIX_vertex_preclip
      GL_VERTEX_PRECLIP_SGIX = $83EE;
      GL_VERTEX_PRECLIP_HINT_SGIX = $83EF;
      // GL_SGIX_ycrcb
      GL_YCRCB_422_SGIX = $81BB;
      GL_YCRCB_444_SGIX = $81BC;
      // GL_SGIX_ycrcba
      GL_YCRCB_SGIX = $8318;
      GL_YCRCBA_SGIX = $8319;
      // GL_SGI_color_matrix
      GL_COLOR_MATRIX_SGI = $80B1;
      GL_COLOR_MATRIX_STACK_DEPTH_SGI = $80B2;
      GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI = $80B3;
      GL_POST_COLOR_MATRIX_RED_SCALE_SGI = $80B4;
      GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI = $80B5;
      GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI = $80B6;
      GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI = $80B7;
      GL_POST_COLOR_MATRIX_RED_BIAS_SGI = $80B8;
      GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI = $80B9;
      GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI = $80BA;
      GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI = $80BB;
      // GL_SGI_color_table
      GL_COLOR_TABLE_SGI = $80D0;
      GL_POST_CONVOLUTION_COLOR_TABLE_SGI = $80D1;
      GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI = $80D2;
      GL_PROXY_COLOR_TABLE_SGI = $80D3;
      GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI = $80D4;
      GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI = $80D5;
      GL_COLOR_TABLE_SCALE_SGI = $80D6;
      GL_COLOR_TABLE_BIAS_SGI = $80D7;
      GL_COLOR_TABLE_FORMAT_SGI = $80D8;
      GL_COLOR_TABLE_WIDTH_SGI = $80D9;
      GL_COLOR_TABLE_RED_SIZE_SGI = $80DA;
      GL_COLOR_TABLE_GREEN_SIZE_SGI = $80DB;
      GL_COLOR_TABLE_BLUE_SIZE_SGI = $80DC;
      GL_COLOR_TABLE_ALPHA_SIZE_SGI = $80DD;
      GL_COLOR_TABLE_LUMINANCE_SIZE_SGI = $80DE;
      GL_COLOR_TABLE_INTENSITY_SIZE_SGI = $80DF;
      // GL_SGI_texture_color_table
      GL_TEXTURE_COLOR_TABLE_SGI = $80BC;
      GL_PROXY_TEXTURE_COLOR_TABLE_SGI = $80BD;
      // GL_SUNX_constant_data
      GL_UNPACK_CONSTANT_DATA_SUNX = $81D5;
      GL_TEXTURE_CONSTANT_DATA_SUNX = $81D6;
      // GL_SUN_convolution_border_modes
      GL_WRAP_BORDER_SUN = $81D4;
      // GL_SUN_global_alpha
      GL_GLOBAL_ALPHA_SUN = $81D9;
      GL_GLOBAL_ALPHA_FACTOR_SUN = $81DA;
      // GL_SUN_mesh_array
      GL_QUAD_MESH_SUN = $8614;
      GL_TRIANGLE_MESH_SUN = $8615;
      // GL_SUN_slice_accum
      GL_SLICE_ACCUM_SUN = $85CC;
      // GL_SUN_triangle_list
      GL_RESTART_SUN = $0001;
      GL_REPLACE_MIDDLE_SUN = $0002;
      GL_REPLACE_OLDEST_SUN = $0003;
      GL_TRIANGLE_LIST_SUN = $81D7;
      GL_REPLACEMENT_CODE_SUN = $81D8;
      GL_REPLACEMENT_CODE_ARRAY_SUN = $85C0;
      GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN = $85C1;
      GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN = $85C2;
      GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN = $85C3;
      GL_R1UI_V3F_SUN = $85C4;
      GL_R1UI_C4UB_V3F_SUN = $85C5;
      GL_R1UI_C3F_V3F_SUN = $85C6;
      GL_R1UI_N3F_V3F_SUN = $85C7;
      GL_R1UI_C4F_N3F_V3F_SUN = $85C8;
      GL_R1UI_T2F_V3F_SUN = $85C9;
      GL_R1UI_T2F_N3F_V3F_SUN = $85CA;
      GL_R1UI_T2F_C4F_N3F_V3F_SUN = $85CB;
      // GL_WIN_phong_shading
      GL_PHONG_WIN = $80EA;
      GL_PHONG_HINT_WIN = $80EB;
      // GL_WIN_specular_fog
      GL_FOG_SPECULAR_TEXTURE_WIN = $80EC;

implementation

end.
