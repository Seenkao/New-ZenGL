(*
 *  Copyright (c) 2023 Serge - SSW
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
// SPDX-License-Identifier: Apache-2.0
//
// This header is generated from the Khronos EGL XML API Registry.
// The current version of the Registry, generator scripts
// used to make the header, and the header can be found at
//   http://www.khronos.org/registry/egl

unit zgl_EGL;
{$I zgl_config.cfg}
{$I egl_conf.cfg}

interface

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

  {
  ** Copyright 2013-2020 The Khronos Group Inc.
  ** SPDX-License-Identifier: Apache-2.0
  **
  ** This header is generated from the Khronos EGL XML API Registry.
  ** The current version of the Registry, generator scripts
  ** used to make the header, and the header can be found at
  **   http://www.khronos.org/registry/egl
  **
  ** Khronos $Git commit SHA1: 8c62b915dd $ on $Git commit date: 2021-11-05 23:32:01 -0400 $
   }

{$IfNDef Windows}
  {$DEFINE stdcall := cdecl}
{$ENDIF}

uses
{$IfDef LINUX}  // !!! not Wayland !!!
  x, xlib,
{$EndIf}
  zgl_utils;

const
  EGL_ALPHA_SIZE = $3021;
  EGL_BAD_ACCESS = $3002;
  EGL_BAD_ALLOC = $3003;
  EGL_BAD_ATTRIBUTE = $3004;
  EGL_BAD_CONFIG = $3005;
  EGL_BAD_CONTEXT = $3006;
  EGL_BAD_CURRENT_SURFACE = $3007;
  EGL_BAD_DISPLAY = $3008;
  EGL_BAD_MATCH = $3009;
  EGL_BAD_NATIVE_PIXMAP = $300A;
  EGL_BAD_NATIVE_WINDOW = $300B;
  EGL_BAD_PARAMETER = $300C;
  EGL_BAD_SURFACE = $300D;
  EGL_BLUE_SIZE = $3022;
  EGL_BUFFER_SIZE = $3020;
  EGL_CONFIG_CAVEAT = $3027;
  EGL_CONFIG_ID = $3028;
  EGL_CORE_NATIVE_ENGINE = $305B;
  EGL_DEPTH_SIZE = $3025;

  EGL_DRAW = $3059;
  EGL_EXTENSIONS = $3055;
  EGL_FALSE = 0;
  EGL_GREEN_SIZE = $3023;
  EGL_HEIGHT = $3056;
  EGL_LARGEST_PBUFFER = $3058;
  EGL_LEVEL = $3029;
  EGL_MAX_PBUFFER_HEIGHT = $302A;
  EGL_MAX_PBUFFER_PIXELS = $302B;
  EGL_MAX_PBUFFER_WIDTH = $302C;
  EGL_NATIVE_RENDERABLE = $302D;
  EGL_NATIVE_VISUAL_ID = $302E;
  EGL_NATIVE_VISUAL_TYPE = $302F;
  EGL_NONE = $3038;
  EGL_NON_CONFORMANT_CONFIG = $3051;
  EGL_NOT_INITIALIZED = $3001;

  EGL_PBUFFER_BIT = $0001;
  EGL_PIXMAP_BIT = $0002;
  EGL_READ = $305A;
  EGL_RED_SIZE = $3024;
  EGL_SAMPLES = $3031;
  EGL_SAMPLE_BUFFERS = $3032;
  EGL_SLOW_CONFIG = $3050;
  EGL_STENCIL_SIZE = $3026;
  EGL_SUCCESS = $3000;
  EGL_SURFACE_TYPE = $3033;
  EGL_TRANSPARENT_BLUE_VALUE = $3035;
  EGL_TRANSPARENT_GREEN_VALUE = $3036;
  EGL_TRANSPARENT_RED_VALUE = $3037;
  EGL_TRANSPARENT_RGB = $3052;
  EGL_TRANSPARENT_TYPE = $3034;
  EGL_TRUE = 1;
  EGL_VENDOR = $3053;
  EGL_VERSION = $3054;
  EGL_WIDTH = $3057;
  EGL_WINDOW_BIT = $0004;

  EGL_BACK_BUFFER = $3084;
  EGL_BIND_TO_TEXTURE_RGB = $3039;
  EGL_BIND_TO_TEXTURE_RGBA = $303A;
  EGL_CONTEXT_LOST = $300E;
  EGL_MIN_SWAP_INTERVAL = $303B;
  EGL_MAX_SWAP_INTERVAL = $303C;
  EGL_MIPMAP_TEXTURE = $3082;
  EGL_MIPMAP_LEVEL = $3083;
  EGL_NO_TEXTURE = $305C;
  EGL_TEXTURE_2D = $305F;
  EGL_TEXTURE_FORMAT = $3080;
  EGL_TEXTURE_RGB = $305D;
  EGL_TEXTURE_RGBA = $305E;
  EGL_TEXTURE_TARGET = $3081;

  EGL_ALPHA_FORMAT = $3088;
  EGL_ALPHA_FORMAT_NONPRE = $308B;
  EGL_ALPHA_FORMAT_PRE = $308C;
  EGL_ALPHA_MASK_SIZE = $303E;
  EGL_BUFFER_PRESERVED = $3094;
  EGL_BUFFER_DESTROYED = $3095;
  EGL_CLIENT_APIS = $308D;
  EGL_COLORSPACE = $3087;
  EGL_COLORSPACE_sRGB = $3089;
  EGL_COLORSPACE_LINEAR = $308A;
  EGL_COLOR_BUFFER_TYPE = $303F;
  EGL_CONTEXT_CLIENT_TYPE = $3097;
  EGL_DISPLAY_SCALING = 10000;
  EGL_HORIZONTAL_RESOLUTION = $3090;
  EGL_LUMINANCE_BUFFER = $308F;
  EGL_LUMINANCE_SIZE = $303D;
  EGL_OPENGL_ES_BIT = $0001;
  EGL_OPENVG_BIT = $0002;
  EGL_OPENGL_ES_API = $30A0;
  EGL_OPENVG_API = $30A1;
  EGL_OPENVG_IMAGE = $3096;
  EGL_PIXEL_ASPECT_RATIO = $3092;
  EGL_RENDERABLE_TYPE = $3040;
  EGL_RENDER_BUFFER = $3086;
  EGL_RGB_BUFFER = $308E;
  EGL_SINGLE_BUFFER = $3085;
  EGL_SWAP_BEHAVIOR = $3093;

  EGL_VERTICAL_RESOLUTION = $3091;

  EGL_CONFORMANT = $3042;
  EGL_CONTEXT_CLIENT_VERSION = $3098;
  EGL_MATCH_NATIVE_PIXMAP = $3041;
  EGL_OPENGL_ES2_BIT = $0004;
  EGL_VG_ALPHA_FORMAT = $3088;
  EGL_VG_ALPHA_FORMAT_NONPRE = $308B;
  EGL_VG_ALPHA_FORMAT_PRE = $308C;
  EGL_VG_ALPHA_FORMAT_PRE_BIT = $0040;
  EGL_VG_COLORSPACE = $3087;
  EGL_VG_COLORSPACE_sRGB = $3089;
  EGL_VG_COLORSPACE_LINEAR = $308A;
  EGL_VG_COLORSPACE_LINEAR_BIT = $0020;

  EGL_MULTISAMPLE_RESOLVE_BOX_BIT = $0200;
  EGL_MULTISAMPLE_RESOLVE = $3099;
  EGL_MULTISAMPLE_RESOLVE_DEFAULT = $309A;
  EGL_MULTISAMPLE_RESOLVE_BOX = $309B;
  EGL_OPENGL_API = $30A2;
  EGL_OPENGL_BIT = $0008;
  EGL_SWAP_BEHAVIOR_PRESERVED_BIT = $0400;

  EGL_CONTEXT_MAJOR_VERSION = $3098;
  EGL_CONTEXT_MINOR_VERSION = $30FB;
  EGL_CONTEXT_OPENGL_PROFILE_MASK = $30FD;
  EGL_CONTEXT_OPENGL_RESET_NOTIFICATION_STRATEGY = $31BD;
  EGL_NO_RESET_NOTIFICATION = $31BE;
  EGL_LOSE_CONTEXT_ON_RESET = $31BF;
  EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT = $00000001;
  EGL_CONTEXT_OPENGL_COMPATIBILITY_PROFILE_BIT = $00000002;
  EGL_CONTEXT_OPENGL_DEBUG = $31B0;
  EGL_CONTEXT_OPENGL_FORWARD_COMPATIBLE = $31B1;
  EGL_CONTEXT_OPENGL_ROBUST_ACCESS = $31B2;
  EGL_OPENGL_ES3_BIT = $00000040;
  EGL_CL_EVENT_HANDLE = $309C;
  EGL_SYNC_CL_EVENT = $30FE;
  EGL_SYNC_CL_EVENT_COMPLETE = $30FF;
  EGL_SYNC_PRIOR_COMMANDS_COMPLETE = $30F0;
  EGL_SYNC_TYPE = $30F7;
  EGL_SYNC_STATUS = $30F1;
  EGL_SYNC_CONDITION = $30F8;
  EGL_SIGNALED = $30F2;
  EGL_UNSIGNALED = $30F3;
  EGL_SYNC_FLUSH_COMMANDS_BIT = $0001;
  EGL_FOREVER = $FFFFFFFFFFFFFFFF;
  EGL_TIMEOUT_EXPIRED = $30F5;
  EGL_CONDITION_SATISFIED = $30F6;

  EGL_SYNC_FENCE = $30F9;
  EGL_GL_COLORSPACE = $309D;
  EGL_GL_COLORSPACE_SRGB = $3089;
  EGL_GL_COLORSPACE_LINEAR = $308A;
  EGL_GL_RENDERBUFFER = $30B9;
  EGL_GL_TEXTURE_2D = $30B1;
  EGL_GL_TEXTURE_LEVEL = $30BC;
  EGL_GL_TEXTURE_3D = $30B2;
  EGL_GL_TEXTURE_ZOFFSET = $30BD;
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_X = $30B3;
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $30B4;
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $30B5;
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $30B6;
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $30B7;
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $30B8;
  EGL_IMAGE_PRESERVED = $30D2;

// EGL extended.
// EGL_EGLEXT_VERSION = 20211116;

  EGL_CL_EVENT_HANDLE_KHR = $309C;
  EGL_SYNC_CL_EVENT_KHR = $30FE;
  EGL_SYNC_CL_EVENT_COMPLETE_KHR = $30FF;

  EGL_KHR_client_get_all_proc_addresses = 1;

  EGL_CONFORMANT_KHR = $3042;
  EGL_VG_COLORSPACE_LINEAR_BIT_KHR = $0020;
  EGL_VG_ALPHA_FORMAT_PRE_BIT_KHR = $0040;

  EGL_CONTEXT_RELEASE_BEHAVIOR_NONE_KHR = 0;
  EGL_CONTEXT_RELEASE_BEHAVIOR_KHR = $2097;
  EGL_CONTEXT_RELEASE_BEHAVIOR_FLUSH_KHR = $2098;

  EGL_CONTEXT_MAJOR_VERSION_KHR = $3098;
  EGL_CONTEXT_MINOR_VERSION_KHR = $30FB;
  EGL_CONTEXT_FLAGS_KHR = $30FC;
  EGL_CONTEXT_OPENGL_PROFILE_MASK_KHR = $30FD;
  EGL_CONTEXT_OPENGL_RESET_NOTIFICATION_STRATEGY_KHR = $31BD;
  EGL_NO_RESET_NOTIFICATION_KHR = $31BE;
  EGL_LOSE_CONTEXT_ON_RESET_KHR = $31BF;
  EGL_CONTEXT_OPENGL_DEBUG_BIT_KHR = $00000001;
  EGL_CONTEXT_OPENGL_FORWARD_COMPATIBLE_BIT_KHR = $00000002;
  EGL_CONTEXT_OPENGL_ROBUST_ACCESS_BIT_KHR = $00000004;
  EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT_KHR = $00000001;
  EGL_CONTEXT_OPENGL_COMPATIBILITY_PROFILE_BIT_KHR = $00000002;
  EGL_OPENGL_ES3_BIT_KHR = $00000040;

  EGL_CONTEXT_OPENGL_NO_ERROR_KHR = $31B3;

  EGL_OBJECT_THREAD_KHR = $33B0;
  EGL_OBJECT_DISPLAY_KHR = $33B1;
  EGL_OBJECT_CONTEXT_KHR = $33B2;
  EGL_OBJECT_SURFACE_KHR = $33B3;
  EGL_OBJECT_IMAGE_KHR = $33B4;
  EGL_OBJECT_SYNC_KHR = $33B5;
  EGL_OBJECT_STREAM_KHR = $33B6;
  EGL_DEBUG_MSG_CRITICAL_KHR = $33B9;
  EGL_DEBUG_MSG_ERROR_KHR = $33BA;
  EGL_DEBUG_MSG_WARN_KHR = $33BB;
  EGL_DEBUG_MSG_INFO_KHR = $33BC;
  EGL_DEBUG_CALLBACK_KHR = $33B8;

  EGL_TRACK_REFERENCES_KHR = $3352;

  EGL_SYNC_PRIOR_COMMANDS_COMPLETE_KHR = $30F0;
  EGL_SYNC_CONDITION_KHR = $30F8;
  EGL_SYNC_FENCE_KHR = $30F9;

  EGL_KHR_gl_colorspace = 1;
  EGL_GL_COLORSPACE_KHR = $309D;
  EGL_GL_COLORSPACE_SRGB_KHR = $3089;
  EGL_GL_COLORSPACE_LINEAR_KHR = $308A;

  EGL_GL_RENDERBUFFER_KHR = $30B9;

  EGL_GL_TEXTURE_2D_KHR = $30B1;
  EGL_GL_TEXTURE_LEVEL_KHR = $30BC;

  EGL_GL_TEXTURE_3D_KHR = $30B2;
  EGL_GL_TEXTURE_ZOFFSET_KHR = $30BD;

  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_X_KHR = $30B3;
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_X_KHR = $30B4;
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Y_KHR = $30B5;
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_KHR = $30B6;
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Z_KHR = $30B7;
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_KHR = $30B8;

  EGL_NATIVE_PIXMAP_KHR = $30B0;

  EGL_IMAGE_PRESERVED_KHR = $30D2;

  EGL_READ_SURFACE_BIT_KHR = $0001;
  EGL_WRITE_SURFACE_BIT_KHR = $0002;
  EGL_LOCK_SURFACE_BIT_KHR = $0080;
  EGL_OPTIMAL_FORMAT_BIT_KHR = $0100;
  EGL_MATCH_FORMAT_KHR = $3043;
  EGL_FORMAT_RGB_565_EXACT_KHR = $30C0;
  EGL_FORMAT_RGB_565_KHR = $30C1;
  EGL_FORMAT_RGBA_8888_EXACT_KHR = $30C2;
  EGL_FORMAT_RGBA_8888_KHR = $30C3;
  EGL_MAP_PRESERVE_PIXELS_KHR = $30C4;
  EGL_LOCK_USAGE_HINT_KHR = $30C5;
  EGL_BITMAP_POINTER_KHR = $30C6;
  EGL_BITMAP_PITCH_KHR = $30C7;
  EGL_BITMAP_ORIGIN_KHR = $30C8;
  EGL_BITMAP_PIXEL_RED_OFFSET_KHR = $30C9;
  EGL_BITMAP_PIXEL_GREEN_OFFSET_KHR = $30CA;
  EGL_BITMAP_PIXEL_BLUE_OFFSET_KHR = $30CB;
  EGL_BITMAP_PIXEL_ALPHA_OFFSET_KHR = $30CC;
  EGL_BITMAP_PIXEL_LUMINANCE_OFFSET_KHR = $30CD;
  EGL_LOWER_LEFT_KHR = $30CE;
  EGL_UPPER_LEFT_KHR = $30CF;

  EGL_BITMAP_PIXEL_SIZE_KHR = $3110;

  EGL_MUTABLE_RENDER_BUFFER_BIT_KHR = $1000;

  EGL_BUFFER_AGE_KHR = $313D;

  EGL_PLATFORM_ANDROID_KHR = $3141;

  EGL_PLATFORM_GBM_KHR = $31D7;

  EGL_PLATFORM_WAYLAND_KHR = $31D8;

  EGL_PLATFORM_X11_KHR = $31D5;
  EGL_PLATFORM_X11_SCREEN_KHR = $31D6;

  EGL_SYNC_STATUS_KHR = $30F1;
  EGL_SIGNALED_KHR = $30F2;
  EGL_UNSIGNALED_KHR = $30F3;
  EGL_TIMEOUT_EXPIRED_KHR = $30F5;
  EGL_CONDITION_SATISFIED_KHR = $30F6;
  EGL_SYNC_TYPE_KHR = $30F7;
  EGL_SYNC_REUSABLE_KHR = $30FA;
  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR = $0001;
  {$IfDef CPU64}
  EGL_FOREVER_KHR = $FFFFFFFFFFFFFFFF;     // сделано только для 64-х битных систем.
  {$EndIf}

  EGL_CONSUMER_LATENCY_USEC_KHR = $3210;
  EGL_PRODUCER_FRAME_KHR = $3212;
  EGL_CONSUMER_FRAME_KHR = $3213;
  EGL_STREAM_STATE_KHR = $3214;
  EGL_STREAM_STATE_CREATED_KHR = $3215;
  EGL_STREAM_STATE_CONNECTING_KHR = $3216;
  EGL_STREAM_STATE_EMPTY_KHR = $3217;
  EGL_STREAM_STATE_NEW_FRAME_AVAILABLE_KHR = $3218;
  EGL_STREAM_STATE_OLD_FRAME_AVAILABLE_KHR = $3219;
  EGL_STREAM_STATE_DISCONNECTED_KHR = $321A;
  EGL_BAD_STREAM_KHR = $321B;
  EGL_BAD_STATE_KHR = $321C;

  EGL_STREAM_FIFO_LENGTH_KHR = $31FC;
  EGL_STREAM_TIME_NOW_KHR = $31FD;
  EGL_STREAM_TIME_CONSUMER_KHR = $31FE;
  EGL_STREAM_TIME_PRODUCER_KHR = $31FF;

  EGL_VG_PARENT_IMAGE_KHR = $30BA;

  EGL_NATIVE_BUFFER_USAGE_ANDROID = $3143;
  EGL_NATIVE_BUFFER_USAGE_PROTECTED_BIT_ANDROID = $00000001;
  EGL_NATIVE_BUFFER_USAGE_RENDERBUFFER_BIT_ANDROID = $00000002;
  EGL_NATIVE_BUFFER_USAGE_TEXTURE_BIT_ANDROID = $00000004;

  EGL_FRAMEBUFFER_TARGET_ANDROID = $3147;

  EGL_FRONT_BUFFER_AUTO_REFRESH_ANDROID = $314C;


  EGL_TIMESTAMPS_ANDROID = $3430;
  EGL_COMPOSITE_DEADLINE_ANDROID = $3431;
  EGL_COMPOSITE_INTERVAL_ANDROID = $3432;
  EGL_COMPOSITE_TO_PRESENT_LATENCY_ANDROID = $3433;
  EGL_REQUESTED_PRESENT_TIME_ANDROID = $3434;
  EGL_RENDERING_COMPLETE_TIME_ANDROID = $3435;
  EGL_COMPOSITION_LATCH_TIME_ANDROID = $3436;
  EGL_FIRST_COMPOSITION_START_TIME_ANDROID = $3437;
  EGL_LAST_COMPOSITION_START_TIME_ANDROID = $3438;
  EGL_FIRST_COMPOSITION_GPU_FINISHED_TIME_ANDROID = $3439;
  EGL_DISPLAY_PRESENT_TIME_ANDROID = $343A;
  EGL_DEQUEUE_READY_TIME_ANDROID = $343B;
  EGL_READS_DONE_TIME_ANDROID = $343C;

  EGL_NATIVE_BUFFER_ANDROID = $3140;

  EGL_SYNC_NATIVE_FENCE_ANDROID = $3144;
  EGL_SYNC_NATIVE_FENCE_FD_ANDROID = $3145;
  EGL_SYNC_NATIVE_FENCE_SIGNALED_ANDROID = $3146;
  EGL_NO_NATIVE_FENCE_FD_ANDROID = -(1);

  EGL_RECORDABLE_ANDROID = $3142;

  EGL_D3D_TEXTURE_2D_SHARE_HANDLE_ANGLE = $3200;

  EGL_D3D9_DEVICE_ANGLE = $33A0;
  EGL_D3D11_DEVICE_ANGLE = $33A1;

  EGL_FIXED_SIZE_ANGLE = $3201;

  EGL_COLOR_COMPONENT_TYPE_UNSIGNED_INTEGER_ARM = $3287;
  EGL_COLOR_COMPONENT_TYPE_INTEGER_ARM = $3288;

  EGL_SYNC_PRIOR_COMMANDS_IMPLICIT_EXTERNAL_ARM = $328A;

  EGL_DISCARD_SAMPLES_ARM = $3286;

  EGL_FRONT_BUFFER_EXT = $3464;

  EGL_BUFFER_AGE_EXT = $313D;

  EGL_SYNC_CLIENT_EXT = $3364;
  EGL_SYNC_CLIENT_SIGNAL_EXT = $3365;

  EGL_PRIMARY_COMPOSITOR_CONTEXT_EXT = $3460;
  EGL_EXTERNAL_REF_ID_EXT = $3461;
  EGL_COMPOSITOR_DROP_NEWEST_FRAME_EXT = $3462;
  EGL_COMPOSITOR_KEEP_NEWEST_FRAME_EXT = $3463;

  EGL_CONFIG_SELECT_GROUP_EXT = $34C0;

  EGL_CONTEXT_OPENGL_ROBUST_ACCESS_EXT = $30BF;
  EGL_CONTEXT_OPENGL_RESET_NOTIFICATION_STRATEGY_EXT = $3138;
  EGL_NO_RESET_NOTIFICATION_EXT = $31BE;
  EGL_LOSE_CONTEXT_ON_RESET_EXT = $31BF;

  EGL_BAD_DEVICE_EXT = $322B;
  EGL_DEVICE_EXT = $322C;

  EGL_DRM_DEVICE_FILE_EXT = $3233;
  EGL_DRM_MASTER_FD_EXT = $333C;

  EGL_DRM_RENDER_NODE_FILE_EXT = $3377;

  EGL_OPENWF_DEVICE_ID_EXT = $3237;
  EGL_OPENWF_DEVICE_EXT = $333D;

  EGL_DEVICE_UUID_EXT = $335C;
  EGL_DRIVER_UUID_EXT = $335D;
  EGL_DRIVER_NAME_EXT = $335E;

  EGL_RENDERER_EXT = $335F;

  EGL_GL_COLORSPACE_BT2020_HLG_EXT = $3540;
  EGL_GL_COLORSPACE_BT2020_LINEAR_EXT = $333F;
  EGL_GL_COLORSPACE_BT2020_PQ_EXT = $3340;
  EGL_GL_COLORSPACE_DISPLAY_P3_EXT = $3363;
  EGL_GL_COLORSPACE_DISPLAY_P3_LINEAR_EXT = $3362;
  EGL_GL_COLORSPACE_DISPLAY_P3_PASSTHROUGH_EXT = $3490;

  EGL_GL_COLORSPACE_SCRGB_EXT = $3351;

  EGL_GL_COLORSPACE_SCRGB_LINEAR_EXT = $3350;

  EGL_LINUX_DMA_BUF_EXT = $3270;
  EGL_LINUX_DRM_FOURCC_EXT = $3271;
  EGL_DMA_BUF_PLANE0_FD_EXT = $3272;
  EGL_DMA_BUF_PLANE0_OFFSET_EXT = $3273;
  EGL_DMA_BUF_PLANE0_PITCH_EXT = $3274;
  EGL_DMA_BUF_PLANE1_FD_EXT = $3275;
  EGL_DMA_BUF_PLANE1_OFFSET_EXT = $3276;
  EGL_DMA_BUF_PLANE1_PITCH_EXT = $3277;
  EGL_DMA_BUF_PLANE2_FD_EXT = $3278;
  EGL_DMA_BUF_PLANE2_OFFSET_EXT = $3279;
  EGL_DMA_BUF_PLANE2_PITCH_EXT = $327A;
  EGL_YUV_COLOR_SPACE_HINT_EXT = $327B;
  EGL_SAMPLE_RANGE_HINT_EXT = $327C;
  EGL_YUV_CHROMA_HORIZONTAL_SITING_HINT_EXT = $327D;
  EGL_YUV_CHROMA_VERTICAL_SITING_HINT_EXT = $327E;
  EGL_ITU_REC601_EXT = $327F;
  EGL_ITU_REC709_EXT = $3280;
  EGL_ITU_REC2020_EXT = $3281;
  EGL_YUV_FULL_RANGE_EXT = $3282;
  EGL_YUV_NARROW_RANGE_EXT = $3283;
  EGL_YUV_CHROMA_SITING_0_EXT = $3284;
  EGL_YUV_CHROMA_SITING_0_5_EXT = $3285;

  EGL_DMA_BUF_PLANE3_FD_EXT = $3440;
  EGL_DMA_BUF_PLANE3_OFFSET_EXT = $3441;
  EGL_DMA_BUF_PLANE3_PITCH_EXT = $3442;
  EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT = $3443;
  EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT = $3444;
  EGL_DMA_BUF_PLANE1_MODIFIER_LO_EXT = $3445;
  EGL_DMA_BUF_PLANE1_MODIFIER_HI_EXT = $3446;
  EGL_DMA_BUF_PLANE2_MODIFIER_LO_EXT = $3447;
  EGL_DMA_BUF_PLANE2_MODIFIER_HI_EXT = $3448;
  EGL_DMA_BUF_PLANE3_MODIFIER_LO_EXT = $3449;
  EGL_DMA_BUF_PLANE3_MODIFIER_HI_EXT = $344A;

  EGL_GL_COLORSPACE_DEFAULT_EXT = $314D;

  EGL_IMPORT_SYNC_TYPE_EXT = $3470;
  EGL_IMPORT_IMPLICIT_SYNC_EXT = $3471;
  EGL_IMPORT_EXPLICIT_SYNC_EXT = $3472;

  EGL_MULTIVIEW_VIEW_COUNT_EXT = $3134;

  EGL_BAD_OUTPUT_LAYER_EXT = $322D;
  EGL_BAD_OUTPUT_PORT_EXT = $322E;
  EGL_SWAP_INTERVAL_EXT = $322F;

  EGL_DRM_CRTC_EXT = $3234;
  EGL_DRM_PLANE_EXT = $3235;
  EGL_DRM_CONNECTOR_EXT = $3236;

  EGL_OPENWF_PIPELINE_ID_EXT = $3238;
  EGL_OPENWF_PORT_ID_EXT = $3239;

  EGL_COLOR_COMPONENT_TYPE_EXT = $3339;
  EGL_COLOR_COMPONENT_TYPE_FIXED_EXT = $333A;
  EGL_COLOR_COMPONENT_TYPE_FLOAT_EXT = $333B;

  EGL_PLATFORM_DEVICE_EXT = $313F;

  EGL_PLATFORM_WAYLAND_EXT = $31D8;

  EGL_PLATFORM_X11_EXT = $31D5;
  EGL_PLATFORM_X11_SCREEN_EXT = $31D6;

  EGL_PLATFORM_XCB_EXT = $31DC;
  EGL_PLATFORM_XCB_SCREEN_EXT = $31DE;

  EGL_PRESENT_OPAQUE_EXT = $31DF;

  EGL_PROTECTED_CONTENT_EXT = $32C0;

  EGL_CTA861_3_MAX_CONTENT_LIGHT_LEVEL_EXT = $3360;
  EGL_CTA861_3_MAX_FRAME_AVERAGE_LEVEL_EXT = $3361;

  EGL_SMPTE2086_DISPLAY_PRIMARY_RX_EXT = $3341;
  EGL_SMPTE2086_DISPLAY_PRIMARY_RY_EXT = $3342;
  EGL_SMPTE2086_DISPLAY_PRIMARY_GX_EXT = $3343;
  EGL_SMPTE2086_DISPLAY_PRIMARY_GY_EXT = $3344;
  EGL_SMPTE2086_DISPLAY_PRIMARY_BX_EXT = $3345;
  EGL_SMPTE2086_DISPLAY_PRIMARY_BY_EXT = $3346;
  EGL_SMPTE2086_WHITE_POINT_X_EXT = $3347;
  EGL_SMPTE2086_WHITE_POINT_Y_EXT = $3348;
  EGL_SMPTE2086_MAX_LUMINANCE_EXT = $3349;
  EGL_SMPTE2086_MIN_LUMINANCE_EXT = $334A;
  EGL_METADATA_SCALING_EXT = 50000;

  EGL_SURFACE_COMPRESSION_EXT = $34B0;
  EGL_SURFACE_COMPRESSION_PLANE1_EXT = $328E;
  EGL_SURFACE_COMPRESSION_PLANE2_EXT = $328F;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_NONE_EXT = $34B1;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_DEFAULT_EXT = $34B2;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_1BPC_EXT = $34B4;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_2BPC_EXT = $34B5;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_3BPC_EXT = $34B6;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_4BPC_EXT = $34B7;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_5BPC_EXT = $34B8;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_6BPC_EXT = $34B9;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_7BPC_EXT = $34BA;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_8BPC_EXT = $34BB;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_9BPC_EXT = $34BC;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_10BPC_EXT = $34BD;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_11BPC_EXT = $34BE;
  EGL_SURFACE_COMPRESSION_FIXED_RATE_12BPC_EXT = $34BF;

  EGL_YUV_ORDER_EXT = $3301;
  EGL_YUV_NUMBER_OF_PLANES_EXT = $3311;
  EGL_YUV_SUBSAMPLE_EXT = $3312;
  EGL_YUV_DEPTH_RANGE_EXT = $3317;
  EGL_YUV_CSC_STANDARD_EXT = $330A;
  EGL_YUV_PLANE_BPP_EXT = $331A;
  EGL_YUV_BUFFER_EXT = $3300;
  EGL_YUV_ORDER_YUV_EXT = $3302;
  EGL_YUV_ORDER_YVU_EXT = $3303;
  EGL_YUV_ORDER_YUYV_EXT = $3304;
  EGL_YUV_ORDER_UYVY_EXT = $3305;
  EGL_YUV_ORDER_YVYU_EXT = $3306;
  EGL_YUV_ORDER_VYUY_EXT = $3307;
  EGL_YUV_ORDER_AYUV_EXT = $3308;
  EGL_YUV_SUBSAMPLE_4_2_0_EXT = $3313;
  EGL_YUV_SUBSAMPLE_4_2_2_EXT = $3314;
  EGL_YUV_SUBSAMPLE_4_4_4_EXT = $3315;
  EGL_YUV_DEPTH_RANGE_LIMITED_EXT = $3318;
  EGL_YUV_DEPTH_RANGE_FULL_EXT = $3319;
  EGL_YUV_CSC_STANDARD_601_EXT = $330B;
  EGL_YUV_CSC_STANDARD_709_EXT = $330C;
  EGL_YUV_CSC_STANDARD_2020_EXT = $330D;
  EGL_YUV_PLANE_BPP_0_EXT = $331B;
  EGL_YUV_PLANE_BPP_8_EXT = $331C;
  EGL_YUV_PLANE_BPP_10_EXT = $331D;

  EGL_CLIENT_PIXMAP_POINTER_HI = $8F74;

  EGL_COLOR_FORMAT_HI = $8F70;
  EGL_COLOR_RGB_HI = $8F71;
  EGL_COLOR_RGBA_HI = $8F72;
  EGL_COLOR_ARGB_HI = $8F73;

  EGL_CONTEXT_PRIORITY_LEVEL_IMG = $3100;
  EGL_CONTEXT_PRIORITY_HIGH_IMG = $3101;
  EGL_CONTEXT_PRIORITY_MEDIUM_IMG = $3102;
  EGL_CONTEXT_PRIORITY_LOW_IMG = $3103;

  EGL_NATIVE_BUFFER_MULTIPLANE_SEPARATE_IMG = $3105;
  EGL_NATIVE_BUFFER_PLANE_OFFSET_IMG = $3106;

  EGL_DRM_BUFFER_FORMAT_MESA = $31D0;
  EGL_DRM_BUFFER_USE_MESA = $31D1;
  EGL_DRM_BUFFER_FORMAT_ARGB32_MESA = $31D2;
  EGL_DRM_BUFFER_MESA = $31D3;
  EGL_DRM_BUFFER_STRIDE_MESA = $31D4;
  EGL_DRM_BUFFER_USE_SCANOUT_MESA = $00000001;
  EGL_DRM_BUFFER_USE_SHARE_MESA = $00000002;
  EGL_DRM_BUFFER_USE_CURSOR_MESA = $00000004;

  EGL_PLATFORM_GBM_MESA = $31D7;

  EGL_PLATFORM_SURFACELESS_MESA = $31DD;

  EGL_Y_INVERTED_NOK = $307F;

  EGL_AUTO_STEREO_NV = $3136;

  EGL_CONTEXT_PRIORITY_REALTIME_NV = $3357;

  EGL_COVERAGE_BUFFERS_NV = $30E0;
  EGL_COVERAGE_SAMPLES_NV = $30E1;

  EGL_COVERAGE_SAMPLE_RESOLVE_NV = $3131;
  EGL_COVERAGE_SAMPLE_RESOLVE_DEFAULT_NV = $3132;
  EGL_COVERAGE_SAMPLE_RESOLVE_NONE_NV = $3133;

  EGL_CUDA_EVENT_HANDLE_NV = $323B;
  EGL_SYNC_CUDA_EVENT_NV = $323C;
  EGL_SYNC_CUDA_EVENT_COMPLETE_NV = $323D;

  EGL_DEPTH_ENCODING_NV = $30E2;
  EGL_DEPTH_ENCODING_NONE_NV = 0;
  EGL_DEPTH_ENCODING_NONLINEAR_NV = $30E3;

  EGL_CUDA_DEVICE_NV = $323A;

  EGL_POST_SUB_BUFFER_SUPPORTED_NV = $30BE;

  EGL_QUADRUPLE_BUFFER_NV = $3231;

  EGL_GENERATE_RESET_ON_VIDEO_MEMORY_PURGE_NV = $334C;

  EGL_STREAM_CONSUMER_IMAGE_NV = $3373;
  EGL_STREAM_IMAGE_ADD_NV = $3374;
  EGL_STREAM_IMAGE_REMOVE_NV = $3375;
  EGL_STREAM_IMAGE_AVAILABLE_NV = $3376;

  EGL_STREAM_CONSUMER_IMAGE_USE_SCANOUT_NV = $3378;

  EGL_YUV_PLANE0_TEXTURE_UNIT_NV = $332C;
  EGL_YUV_PLANE1_TEXTURE_UNIT_NV = $332D;
  EGL_YUV_PLANE2_TEXTURE_UNIT_NV = $332E;

  EGL_STREAM_CROSS_DISPLAY_NV = $334E;

  EGL_STREAM_CROSS_OBJECT_NV = $334D;

  EGL_STREAM_CROSS_PARTITION_NV = $323F;

  EGL_STREAM_CROSS_PROCESS_NV = $3245;

  EGL_STREAM_CROSS_SYSTEM_NV = $334F;

  EGL_STREAM_DMA_NV = $3371;
  EGL_STREAM_DMA_SERVER_NV = $3372;

  EGL_PENDING_FRAME_NV = $3329;
  EGL_STREAM_TIME_PENDING_NV = $332A;

  EGL_STREAM_FIFO_SYNCHRONOUS_NV = $3336;

  EGL_PRODUCER_MAX_FRAME_HINT_NV = $3337;
  EGL_CONSUMER_MAX_FRAME_HINT_NV = $3338;

  EGL_MAX_STREAM_METADATA_BLOCKS_NV = $3250;
  EGL_MAX_STREAM_METADATA_BLOCK_SIZE_NV = $3251;
  EGL_MAX_STREAM_METADATA_TOTAL_SIZE_NV = $3252;
  EGL_PRODUCER_METADATA_NV = $3253;
  EGL_CONSUMER_METADATA_NV = $3254;
  EGL_PENDING_METADATA_NV = $3328;
  EGL_METADATA0_SIZE_NV = $3255;
  EGL_METADATA1_SIZE_NV = $3256;
  EGL_METADATA2_SIZE_NV = $3257;
  EGL_METADATA3_SIZE_NV = $3258;
  EGL_METADATA0_TYPE_NV = $3259;
  EGL_METADATA1_TYPE_NV = $325A;
  EGL_METADATA2_TYPE_NV = $325B;
  EGL_METADATA3_TYPE_NV = $325C;

  EGL_STREAM_FRAME_ORIGIN_X_NV = $3366;
  EGL_STREAM_FRAME_ORIGIN_Y_NV = $3367;
  EGL_STREAM_FRAME_MAJOR_AXIS_NV = $3368;
  EGL_CONSUMER_AUTO_ORIENTATION_NV = $3369;
  EGL_PRODUCER_AUTO_ORIENTATION_NV = $336A;
  EGL_LEFT_NV = $336B;
  EGL_RIGHT_NV = $336C;
  EGL_TOP_NV = $336D;
  EGL_BOTTOM_NV = $336E;
  EGL_X_AXIS_NV = $336F;
  EGL_Y_AXIS_NV = $3370;

  EGL_STREAM_STATE_INITIALIZING_NV = $3240;
  EGL_STREAM_TYPE_NV = $3241;
  EGL_STREAM_PROTOCOL_NV = $3242;
  EGL_STREAM_ENDPOINT_NV = $3243;
  EGL_STREAM_LOCAL_NV = $3244;
  EGL_STREAM_PRODUCER_NV = $3247;
  EGL_STREAM_CONSUMER_NV = $3248;
  EGL_STREAM_PROTOCOL_FD_NV = $3246;

  EGL_SUPPORT_RESET_NV = $3334;
  EGL_SUPPORT_REUSE_NV = $3335;

  EGL_STREAM_PROTOCOL_SOCKET_NV = $324B;
  EGL_SOCKET_HANDLE_NV = $324C;
  EGL_SOCKET_TYPE_NV = $324D;
  EGL_SOCKET_TYPE_INET_NV = $324F;
  EGL_SOCKET_TYPE_UNIX_NV = $324E;
  EGL_SYNC_NEW_FRAME_NV = $321F;

  EGL_SYNC_PRIOR_COMMANDS_COMPLETE_NV = $30E6;
  EGL_SYNC_STATUS_NV = $30E7;
  EGL_SIGNALED_NV = $30E8;
  EGL_UNSIGNALED_NV = $30E9;
  EGL_SYNC_FLUSH_COMMANDS_BIT_NV = $0001;
  EGL_FOREVER_NV = $FFFFFFFFFFFFFFFF;
  EGL_ALREADY_SIGNALED_NV = $30EA;
  EGL_TIMEOUT_EXPIRED_NV = $30EB;
  EGL_CONDITION_SATISFIED_NV = $30EC;
  EGL_SYNC_TYPE_NV = $30ED;
  EGL_SYNC_CONDITION_NV = $30EE;
  EGL_SYNC_FENCE_NV = $30EF;

  EGL_TRIPLE_BUFFER_NV = $3230;

  EGL_NATIVE_BUFFER_QNX = $3551;
  EGL_PLATFORM_SCREEN_QNX = $3550;

  EGL_NATIVE_BUFFER_TIZEN = $32A0;
  EGL_NATIVE_SURFACE_TIZEN = $32A1;

//  EGL_WL_bind_wayland_display = 1;
  EGL_WAYLAND_BUFFER_WL = $31D5;
  EGL_WAYLAND_PLANE_WL = $31D6;
  EGL_TEXTURE_Y_U_V_WL = $31D7;
  EGL_TEXTURE_Y_UV_WL = $31D8;
  EGL_TEXTURE_Y_XUXV_WL = $31D9;
  EGL_TEXTURE_EXTERNAL_WL = $31DA;
  EGL_WAYLAND_Y_INVERTED_WL = $31DB;

//  EGL_WL_create_wayland_buffer_from_image = 1;

  EGL_PRESERVED_RESOURCES         = $3030;

  { The types NativeDisplayType, NativeWindowType, and NativePixmapType
   * are aliases of window-system-dependent types, such as X Display * or
   * Windows Device Context. They must be defined in platform-specific
   * code below. The EGL-prefixed versions of Native*Type are the same
   * types, renamed in EGL 1.3 so all types in the API start with "EGL".
   *
   * Khronos STRONGLY RECOMMENDS that you use the default definitions
   * provided below, since these changes affect both binary and source
   * portability of applications using EGL running on different EGL
   * implementations.
   }
//------------------------------------------------------------------------------
   (* Khronos platform-specific types and definitions.
   *
   * The master copy of khrplatform.h is maintained in the Khronos EGL
   * Registry repository at https://github.com/KhronosGroup/EGL-Registry
   * The last semantic modification to khrplatform.h was at commit ID:
   *      67a3e0864c2d75ea5287b9f3d2eb74a745936692
   *
   * Adopters may modify this file to suit their platform. Adopters are
   * encouraged to submit platform specific modifications to the Khronos
   * group so that they can be included in future versions of this file.
   * Please submit changes by filing pull requests or issues on
   * the EGL Registry repository linked above.
   *
   *
   * See the Implementer's Guidelines for information about where this file
   * should be located on your system and for more details of its use:
   *    http://www.khronos.org/registry/implementers_guide.pdf
   *
   * This file should be included as
   *        #include <KHR/khrplatform.h>
   * by Khronos client API header files that use its types and defines.
   *
   * The types in khrplatform.h should only be used to define API-specific types.
   *
   * Types defined in khrplatform.h:
   *    khronos_int8_t              signed   8  bit
   *    khronos_uint8_t             unsigned 8  bit
   *    khronos_int16_t             signed   16 bit
   *    khronos_uint16_t            unsigned 16 bit
   *    khronos_int32_t             signed   32 bit
   *    khronos_uint32_t            unsigned 32 bit
   *    khronos_int64_t             signed   64 bit
   *    khronos_uint64_t            unsigned 64 bit
   *    khronos_intptr_t            signed   same number of bits as a pointer
   *    khronos_uintptr_t           unsigned same number of bits as a pointer
   *    khronos_ssize_t             signed   size
   *    khronos_usize_t             unsigned size
   *    khronos_float_t             signed   32 bit floating point
   *    khronos_time_ns_t           unsigned 64 bit time in nanoseconds
   *    khronos_utime_nanoseconds_t unsigned time interval or absolute time in
   *                                         nanoseconds
   *    khronos_stime_nanoseconds_t signed time interval in nanoseconds
   *    khronos_boolean_enum_t      enumerated boolean type. This should
   *      only be used as a base type when a client API's boolean type is
   *      an enum. Client APIs which use an integer or other type for
   *      booleans cannot use this as the base type for their boolean.
   *
   * Tokens defined in khrplatform.h:
   *
   *    KHRONOS_FALSE, KHRONOS_TRUE Enumerated boolean false/true values.
   *
   *    KHRONOS_SUPPORT_INT64 is 1 if 64 bit integers are supported; otherwise 0.
   *    KHRONOS_SUPPORT_FLOAT is 1 if floats are supported; otherwise 0.
   *
   * Calling convention macros defined in this file:
   *    KHRONOS_APICALL
   *    KHRONOS_APIENTRY
   *    KHRONOS_APIATTRIBUTES
   *
   * These may be used in function prototypes as:
   *
   *      KHRONOS_APICALL void KHRONOS_APIENTRY funcname(
   *                                  int arg1,
   *                                  int arg2) KHRONOS_APIATTRIBUTES;
   *)

{$IfDef EGL_NO_PLATFORM_SPECIFIC_TYPES}
// Это значение по умолчанию, для каких систем вообще?
type
  EGLNativeDisplayType = pointer;
  EGLNativePixmapType = pointer;
  EGLNativeWindowType = pointer;
{$EndIf}

{$IfDef Windows}           // для всех Windows? Или только для 32-х битной?
type
  EGLNativeDisplayType = HDC;
  EGLNativePixmapType = HBITMAP;
  EGLNativeWindowType = HWND;
{$EndIf}
  (*{$else defined(__EMSCRIPTEN__)}     // что за платформа?
    type
      EGLNativeDisplayType = longint;
      EGLNativePixmapType = longint;
      EGLNativeWindowType = longint;   *)

{$If defined(__WINSCW__) or defined(__SYMBIAN32__)}  // Symbian    // может пригодится...
type
  EGLNativeDisplayType = longint;
  EGLNativePixmapType = pointer;
  EGLNativeWindowType = pointer;
{$IfEnd}

  (* {$else defined(__GBM__)}           // что за платформа?
    type
      EGLNativeDisplayType = ^gbm_device;
      EGLNativePixmapType = ^gbm_bo;
      EGLNativeWindowType = pointer;   *)

{$IfDef ANDROID}
type
  ANativeWindow = record end;
  egl_native_pixmap_t = record end;

  EGLNativeDisplayType = pointer;
  EGLNativePixmapType = ^egl_native_pixmap_t;
  EGLNativeWindowType = ^ANativeWindow;
{$EndIf}

  (* {$else defined(USE_OZONE)}         // что за платформа?
    type
      EGLNativeDisplayType = intptr_t;
      EGLNativePixmapType = intptr_t;
      EGLNativeWindowType = intptr_t;  *)

{$IfDef UNIX)}
  {$If not defined(LINUX) and not defined(MACOSX) and not defined(ANDROID)}     // QNX???
  type
    EGLNativeDisplayType = pointer;
    EGLNativePixmapType = khronos_uintptr_t;              // khronos_uintptr_t = qword;
    EGLNativeWindowType = khronos_uintptr_t;              // or khronos_uintptr_t = dword;   в зависимости от разрядности.
  {$IfEnd}

  {$IfDef LINUX}
  {$IfDef WAYLAND}              // Wayland       WL_EGL_PLATFORM
  type
    EGLNativeDisplayType = ^wl_display;
    EGLNativePixmapType = ^wl_egl_pixmap;
    EGLNativeWindowType = ^wl_egl_window;
  {$Else}
  type
    EGLNativeDisplayType = PDisplay;
    EGLNativePixmapType = TPixmap;
    EGLNativeWindowType = TWindow;
  {$EndIf}{$EndIf}

  {$IfDef MACOSX}
  type
    EGLNativeDisplayType = longint;
    EGLNativePixmapType = pointer;
    EGLNativeWindowType = pointer;
  {$EndIf}
{$EndIf}

{$IfDef __HAIKU__}
type
  EGLNativeDisplayType = pointer;
  EGLNativePixmapType = khronos_uintptr_t;
  EGLNativeWindowType = khronos_uintptr_t;
{$EndIf}

{$IfDef __Fuchsia__}
type
  EGLNativeDisplayType = pointer;
  EGLNativePixmapType = khronos_uintptr_t;
  EGLNativeWindowType = khronos_uintptr_t;
{$endif}

{$IfDef QNX}
type
  EGLNativeDisplayType = khronos_uintptr_t;
  EGLNativePixmapType = ^_screen_pixmap;
  EGLNativeWindowType = ^_screen_window;
{$EndIf}

    { EGL 1.2 types, renamed for consistency in EGL 1.3  }
type
  NativeDisplayType = EGLNativeDisplayType;
  NativePixmapType = EGLNativePixmapType;
  NativeWindowType = EGLNativeWindowType;
    { Define EGLint. This must be a signed integral type large enough to contain
     * all legal attribute names and values passed into and out of EGL, whether
     * their type is boolean, bitmask, enumerant (symbolic constant), integer,
     * handle, or other.  While in general a 32-bit integer will suffice, if
     * handles are 64 bit types, then EGLint should be defined as a signed 64-bit
     * integer type.
      }

type
  EGLSync = pointer;
  {$IfDef CPU64}
  EGLTime = QWord;       // khronos_utime_nanoseconds_t
  {$Else}
  EGLTime = DWord;
  {$EndIf}
  PEGLImage  = ^EGLImage;
  EGLImage = pointer;

  PAHardwareBuffer  = ^AHardwareBuffer;
  Pchar  = ^char;
  PEGLAttribKHR  = ^EGLAttribKHR;
  {$IfDef CPU64}
  EGLAttribKHR = int64;           // intptr_t
  {$Else}
  EGLAttribKHR = LongInt;         // intptr_t;
  {$EndIf}
  PEGLBoolean  = ^EGLBoolean;
  PEGLClientPixmapHI  = ^EGLClientPixmapHI;
  PEGLDeviceEXT  = ^EGLDeviceEXT;

  PEGLNativeDisplayType  = ^EGLNativeDisplayType;
  PEGLNativePixmapType  = ^EGLNativePixmapType;
  PEGLNativeWindowType  = ^EGLNativeWindowType;
  PEGLnsecsANDROID  = ^EGLnsecsANDROID;
  {$IfDef CPU64}
  EGLnsecsANDROID = Int64;        // khronos_stime_nanoseconds_t;
  {$Else}
  EGLnsecsANDROID = LongInt;      // khronos_stime_nanoseconds_t;
  {$EndIf}
  PEGLOutputLayerEXT  = ^EGLOutputLayerEXT;
  PEGLOutputPortEXT  = ^EGLOutputPortEXT;
  PEGLTimeKHR  = ^EGLTimeKHR;
  PEGLuint64KHR  = ^EGLuint64KHR;
  {$IfDef CPU64}
  EGLTimeKHR = QWord;       // khronos_utime_nanoseconds_t
  EGLuint64KHR = QWord;     // khronos_uint64_t;
  {$Else}
  EGLTimeKHR = DWord;
  EGLuint64KHR = DWord;     // khronos_uint64_t;
  {$EndIf}
//
  PEGLAttrib  = ^EGLAttrib;
  {$IfDef CPU64}
  EGLAttrib = int64;           // intptr_t
  {$Else}
  EGLAttrib = LongInt;         // intptr_t;
  {$EndIf}
  PEGLConfig  = ^EGLConfig;
  PEGLint  = ^EGLint;
  EGLint = longint;
  EGLConfig = pointer;
  EGLBoolean = LongBool; // dword;
  EGLDisplay = pointer;

  EGLSurface = pointer;
  EGLContext = pointer;
  PEGLenum  = ^EGLenum;
  EGLenum = DWord;
  EGLClientBuffer = pointer;
//const

(*  {$IfDef WINDOWS}
  EGL_DEFAULT_DISPLAY = 0;
  {$ELSE}
  EGL_DEFAULT_DISPLAY = nil;
  {$EndIf}
  EGL_NO_CONTEXT      = nil;
  EGL_NO_DISPLAY      = nil;
  EGL_NO_SURFACE      = nil; *)

//
  Plongint  = ^longint;
  Pwl_display  = ^wl_display;
  Pwl_resource  = ^wl_resource;
  Pwl_buffer = ^wl_buffer;

  EGLSyncKHR = pointer;

  EGLLabelKHR = pointer;
  EGLObjectKHR = pointer;

  EGLImageKHR = pointer;
  EGLStreamKHR = pointer;
  EGLNativeFileDescriptorKHR = longint;
  {$IfDef CPU64}
  EGLsizeiANDROID = Int64;       // khronos_ssize_t;
  {$Else}
  EGLsizeiANDROID = LongInt;     // khronos_ssize_t;
  {$EndIf}

  AHardwareBuffer = record end;

  EGLDeviceEXT = pointer;
  EGLOutputLayerEXT = pointer;
  EGLOutputPortEXT = pointer;

  {$IfDef EGL_HI_clientpixmap}
  EGLClientPixmapHI = record
    pData : pointer;
    iWidth : EGLint;
    iHeight : EGLint;
    iStride : EGLint;
  end;
  {$EndIf}

  EGLSyncNV = pointer;
  {$IfDef CPU64}
  EGLTimeNV = QWord;             // khronos_utime_nanoseconds_t;
  EGLuint64NV = QWord;           // khronos_utime_nanoseconds_t;
  {$Else}
  EGLTimeNV = DWord;             // khronos_utime_nanoseconds_t;
  EGLuint64NV = DWord;           // khronos_utime_nanoseconds_t;
  {$EndIf}

  wl_display = record end;
  wl_resource = record end;
  wl_buffer = record end;

  // __eglMustCastToProperFunctionPointerType = procedure (_para1: pointer); cdecl;

var
  eglLibrary  : {$IFDEF WINDOWS}LongWord{$ELSE}Pointer{$ENDIF};
  separateEGL : Boolean;

  {$IfDef EGL_VERSION_1_0}
var
  // eglGetProcAddress: function(procname: Pchar): __eglMustCastToProperFunctionPointerType; stdcall;
  eglGetProcAddress: function(name: PAnsiChar): Pointer; stdcall;
  eglChooseConfig: function(dpy: EGLDisplay; attrib_list: PEGLint; configs: PEGLConfig; config_size: EGLint; num_config: PEGLint): EGLBoolean; stdcall;
  eglCreateContext: function(dpy: EGLDisplay; config: EGLConfig; share_context: EGLContext; attrib_list: PEGLint): EGLContext; stdcall;
  eglCreateWindowSurface: function(dpy: EGLDisplay; config: EGLConfig; win: EGLNativeWindowType; attrib_list: PEGLint): EGLSurface; stdcall;
  eglDestroyContext: function(dpy: EGLDisplay; ctx: EGLContext): EGLBoolean; stdcall;
  eglDestroySurface: function(dpy: EGLDisplay; surface: EGLSurface): EGLBoolean; stdcall;
  eglGetDisplay: function(display_id: EGLNativeDisplayType): EGLDisplay; stdcall;
  eglGetError: function: EGLint; stdcall;
  eglInitialize: function(dpy: EGLDisplay; major: PEGLint; minor: PEGLint): EGLBoolean; stdcall;
  eglMakeCurrent: function(dpy: EGLDisplay; draw: EGLSurface; read: EGLSurface; ctx: EGLContext): EGLBoolean; stdcall;
  eglSwapBuffers: function(dpy: EGLDisplay; surface: EGLSurface): EGLBoolean; stdcall;
  eglTerminate: function(dpy: EGLDisplay): EGLBoolean; stdcall;
  {$IfDef EGL_NO_MIN}
  eglCopyBuffers: function(dpy: EGLDisplay; surface: EGLSurface; target: EGLNativePixmapType): EGLBoolean; stdcall;
  eglCreatePbufferSurface: function(dpy: EGLDisplay; config: EGLConfig; attrib_list: PEGLint): EGLSurface; stdcall;
  eglCreatePixmapSurface: function(dpy: EGLDisplay; config: EGLConfig; pixmap: EGLNativePixmapType; attrib_list: PEGLint): EGLSurface; stdcall;
  eglGetConfigAttrib: function(dpy: EGLDisplay; config: EGLConfig; attribute: EGLint; value: PEGLint): EGLBoolean; stdcall;
  eglGetConfigs: function(dpy: EGLDisplay; configs: PEGLConfig; config_size: EGLint; num_config: PEGLint): EGLBoolean; stdcall;
  eglGetCurrentDisplay: function: EGLDisplay; stdcall;
  eglGetCurrentSurface: function(readdraw: EGLint): EGLSurface; stdcall;
  eglQueryContext: function(dpy: EGLDisplay; ctx: EGLContext; attribute: EGLint; value: PEGLint): EGLBoolean; stdcall;
  eglQueryString: function(dpy: EGLDisplay; name: EGLint): Pchar; stdcall;
  eglQuerySurface: function(dpy: EGLDisplay; surface: EGLSurface; attribute: EGLint; value: PEGLint): EGLBoolean; stdcall;
  eglWaitGL: function: EGLBoolean; stdcall;
  eglWaitNative: function(engine: EGLint): EGLBoolean; stdcall;
  {$EndIf}
  {$EndIf}

  {$IfDef EGL_VERSION_1_1}
var
  {$IfDef EGL_NO_MIN}
  eglBindTexImage: function(dpy: EGLDisplay; surface: EGLSurface; buffer: EGLint): EGLBoolean; stdcall;
  eglReleaseTexImage: function(dpy: EGLDisplay; surface: EGLSurface; buffer: EGLint): EGLBoolean; stdcall;
  eglSurfaceAttrib: function(dpy: EGLDisplay; surface: EGLSurface; attribute: EGLint; value: EGLint): EGLBoolean; stdcall;
  {$EndIf}
  eglSwapInterval: function(dpy: EGLDisplay; interval: EGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NO_MIN}
  {$IfDef EGL_VERSION_1_2}
var
  eglBindAPI: function(api: EGLenum): EGLBoolean; stdcall;
  eglQueryAPI: function: EGLenum; stdcall;
  eglCreatePbufferFromClientBuffer: function(dpy: EGLDisplay; buftype: EGLenum; buffer: EGLClientBuffer; config: EGLConfig; attrib_list: PEGLint): EGLSurface; stdcall;
  eglReleaseThread: function: EGLBoolean; stdcall;
  eglWaitClient: function: EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_VERSION_1_3}
//  function EGL_DEFAULT_DISPLAY: longint;
  {$EndIf}

  {$IfDef EGL_VERSION_1_4}
var
  eglGetCurrentContext: function: EGLContext; stdcall;
//  function EGL_NO_SYNC: longint;
//  function EGL_NO_IMAGE: longint;
  {$EndIf}

  {$IfDef EGL_VERSION_1_5}
var
  eglCreateSync: function(dpy: EGLDisplay; _type: EGLenum; attrib_list: PEGLAttrib): EGLSync; stdcall;
  eglDestroySync: function(dpy: EGLDisplay; sync: EGLSync): EGLBoolean; stdcall;
  eglClientWaitSync: function(dpy: EGLDisplay; sync: EGLSync; flags: EGLint; timeout: EGLTime): EGLint; stdcall;
  eglGetSyncAttrib: function(dpy: EGLDisplay; sync: EGLSync; attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  eglCreateImage: function(dpy: EGLDisplay; ctx: EGLContext; target: EGLenum; buffer: EGLClientBuffer; attrib_list: PEGLAttrib): EGLImage; stdcall;
  eglDestroyImage: function(dpy: EGLDisplay; image: EGLImage): EGLBoolean; stdcall;
  eglGetPlatformDisplay: function(platform: EGLenum; native_display: pointer; attrib_list: PEGLAttrib): EGLDisplay; stdcall;
  eglCreatePlatformWindowSurface: function(dpy: EGLDisplay; config: EGLConfig; native_window: pointer; attrib_list: PEGLAttrib): EGLSurface; stdcall;
  eglCreatePlatformPixmapSurface: function(dpy: EGLDisplay; config: EGLConfig; native_pixmap: pointer; attrib_list: PEGLAttrib): EGLSurface; stdcall;
  eglWaitSync: function(dpy: EGLDisplay; sync: EGLSync; flags: EGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_cl_event2}
  eglCreateSync64KHR: function(dpy: EGLDisplay; _type: EGLenum; attrib_list: PEGLAttribKHR): EGLSyncKHR; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_debug}
type
  EGLDEBUGPROCKHR = procedure (error: EGLenum; command: Pchar; messageType: EGLint; threadLabel: EGLLabelKHR; objectLabel: EGLLabelKHR;
                  message: Pchar); stdcall;

var
  eglDebugMessageControlKHR: function(callback: EGLDEBUGPROCKHR; attrib_list: PEGLAttrib): EGLint; stdcall;
  eglQueryDebugKHR: function(attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  eglLabelObjectKHR: function(display: EGLDisplay; objectType: EGLenum; objectKHR: EGLObjectKHR; _label: EGLLabelKHR): EGLint; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_display_reference}
  eglQueryDisplayAttribKHR: function(dpy: EGLDisplay; name: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_fence_sync}
  {$IfDef CPU64}
  eglCreateSyncKHR: function(dpy: EGLDisplay; _type: EGLenum; attrib_list: PEGLint): EGLSyncKHR; stdcall;
  eglDestroySyncKHR: function(dpy: EGLDisplay; sync: EGLSyncKHR): EGLBoolean; stdcall;
  eglClientWaitSyncKHR: function(dpy: EGLDisplay; sync: EGLSyncKHR; flags: EGLint; timeout: EGLTimeKHR): EGLint; stdcall;
  eglGetSyncAttribKHR: function(dpy: EGLDisplay; sync: EGLSyncKHR; attribute: EGLint; value: PEGLint): EGLBoolean; stdcall;
  {$EndIf}
  {$EndIf}

//  function EGL_NO_IMAGE_KHR: longint;

  {$IfDef EGL_KHR_image}
  eglCreateImageKHR: function(dpy: EGLDisplay; ctx: EGLContext; target: EGLenum; buffer: EGLClientBuffer; attrib_list: PEGLint): EGLImageKHR; stdcall;
  eglDestroyImageKHR: function(dpy: EGLDisplay; image: EGLImageKHR): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_lock_surface}
  eglLockSurfaceKHR: function(dpy: EGLDisplay; surface: EGLSurface; attrib_list: PEGLint): EGLBoolean; stdcall;
  eglUnlockSurfaceKHR: function(dpy: EGLDisplay; surface: EGLSurface): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_lock_surface3}
  eglQuerySurface64KHR: function(dpy: EGLDisplay; surface: EGLSurface; attribute: EGLint; value: PEGLAttribKHR): EGLBoolean; stdcall;
  {$EndIf}

//  function EGL_NO_CONFIG_KHR: longint;

  {$IfDef EGL_KHR_partial_update}
  eglSetDamageRegionKHR: function(dpy: EGLDisplay; surface: EGLSurface; rects: PEGLint; n_rects: EGLint): EGLBoolean; stdcall;
  {$EndIf}

//  function EGL_NO_SYNC_KHR: longint;

  {$IfDef EGL_KHR_reusable_sync}
  {$IfDef CPU64}
  eglSignalSyncKHR: function(dpy: EGLDisplay; sync: EGLSyncKHR; mode: EGLenum): EGLBoolean; stdcall;
  {$EndIf}{$EndIf}

//  function EGL_NO_STREAM_KHR: longint; { return type might be wrong }
  {$IfDef EGL_KHR_stream}
  {$IfDef CPU64}
  eglCreateStreamKHR: function(dpy: EGLDisplay; attrib_list: PEGLint): EGLStreamKHR; stdcall;
  eglDestroyStreamKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLBoolean; stdcall;
  eglStreamAttribKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attribute: EGLenum; value: EGLint): EGLBoolean; stdcall;
  eglQueryStreamKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attribute: EGLenum; value: PEGLint): EGLBoolean; stdcall;
  eglQueryStreamu64KHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attribute: EGLenum; value: PEGLuint64KHR): EGLBoolean; stdcall;
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream_attrib}
  {$IfDef CPU64}
  eglCreateStreamAttribKHR: function(dpy: EGLDisplay; attrib_list: PEGLAttrib): EGLStreamKHR; stdcall;
  eglSetStreamAttribKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attribute: EGLenum; value: EGLAttrib): EGLBoolean; stdcall;
  eglQueryStreamAttribKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attribute: EGLenum; value: PEGLAttrib): EGLBoolean; stdcall;
  eglStreamConsumerAcquireAttribKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attrib_list: PEGLAttrib):EGLBoolean; stdcall;
  eglStreamConsumerReleaseAttribKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attrib_list: PEGLAttrib): EGLBoolean; stdcall;
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream_consumer_gltexture}
  eglStreamConsumerGLTextureExternalKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLBoolean; stdcall;
  eglStreamConsumerAcquireKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLBoolean; stdcall;
  eglStreamConsumerReleaseKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_stream_cross_process_fd}
  eglGetStreamFileDescriptorKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLNativeFileDescriptorKHR; stdcall;
  eglCreateStreamFromFileDescriptorKHR: function(dpy: EGLDisplay; file_descriptor: EGLNativeFileDescriptorKHR): EGLStreamKHR; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_stream_fifo}
  eglQueryStreamTimeKHR: function(dpy: EGLDisplay; stream: EGLStreamKHR; attribute: EGLenum; value: PEGLTimeKHR): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_stream_producer_eglsurface}
  eglCreateStreamProducerSurfaceKHR: function(dpy: EGLDisplay; config: EGLConfig; stream: EGLStreamKHR; attrib_list: PEGLint): EGLSurface; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_swap_buffers_with_damage}
  eglSwapBuffersWithDamageKHR: function(dpy: EGLDisplay; surface: EGLSurface; rects: PEGLint; n_rects: EGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_KHR_wait_sync}
  eglWaitSyncKHR: function(dpy: EGLDisplay; sync: EGLSyncKHR; flags: EGLint): EGLint; stdcall;
  {$EndIf}

  {$IfDef EGL_ANDROID_blob_cache}
type
  EGLSetBlobFuncANDROID = procedure (key: pointer; keySize: EGLsizeiANDROID; value: pointer; valueSize: EGLsizeiANDROID); stdcall;
  EGLGetBlobFuncANDROID = function (key: pointer; keySize: EGLsizeiANDROID; value: pointer; valueSize: EGLsizeiANDROID): EGLsizeiANDROID; stdcall;

var
  eglSetBlobCacheFuncsANDROID: procedure(dpy: EGLDisplay; setBlob: EGLSetBlobFuncANDROID; get: EGLGetBlobFuncANDROID); stdcall;
  {$EndIf}

  {$IfDef EGL_ANDROID_create_native_client_buffer}
  eglCreateNativeClientBufferANDROID: function(attrib_list: PEGLint): EGLClientBuffer; stdcall;
  {$EndIf}

  {$IfDef EGL_ANDROID_get_frame_timestamps}
  eglGetCompositorTimingSupportedANDROID: function(dpy: EGLDisplay; surface: EGLSurface; name: EGLint): EGLBoolean; stdcall;
  eglGetCompositorTimingANDROID: function(dpy: EGLDisplay; surface: EGLSurface; numTimestamps: EGLint; names: PEGLint; values: PEGLnsecsANDROID): EGLBoolean; stdcall;
  eglGetNextFrameIdANDROID: function(dpy: EGLDisplay; surface: EGLSurface; frameId: PEGLuint64KHR): EGLBoolean; stdcall;
  eglGetFrameTimestampSupportedANDROID: function(dpy: EGLDisplay; surface: EGLSurface; timestamp: EGLint): EGLBoolean; stdcall;
  eglGetFrameTimestampsANDROID: function(dpy: EGLDisplay; surface: EGLSurface; frameId: EGLuint64KHR; numTimestamps: EGLint; timestamps: PEGLint;
             values:PEGLnsecsANDROID): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_ANDROID_get_native_client_buffer}
  eglGetNativeClientBufferANDROID: function(buffer: PAHardwareBuffer): EGLClientBuffer; stdcall;
  {$EndIf}

  {$IfDef EGL_ANDROID_native_fence_sync}
  eglDupNativeFenceFDANDROID: function(dpy: EGLDisplay; sync: EGLSyncKHR): EGLint; stdcall;
  {$EndIf}

  {$IfDef EGL_ANDROID_presentation_time}
  eglPresentationTimeANDROID: function(dpy: EGLDisplay; surface: EGLSurface; time: EGLnsecsANDROID): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_ANGLE_query_surface_pointer}
  eglQuerySurfacePointerANGLE: function(dpy: EGLDisplay; surface: EGLSurface; attribute: EGLint; value: Ppointer): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_ANGLE_sync_control_rate}
  eglGetMscRateANGLE: function(dpy: EGLDisplay; surface: EGLSurface; numerator: PEGLint; denominator: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_client_sync}
  eglClientSignalSyncEXT: function(dpy: EGLDisplay; sync: EGLSync; attrib_list: PEGLAttrib): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_compositor}
  eglCompositorSetContextListEXT: function(external_ref_ids: PEGLint; num_entries: EGLint): EGLBoolean; stdcall;
  eglCompositorSetContextAttributesEXT: function(external_ref_id: EGLint; context_attributes: PEGLint; num_entries: EGLint): EGLBoolean; stdcall;
  eglCompositorSetWindowListEXT: function(external_ref_id: EGLint; external_win_ids: PEGLint; num_entries: EGLint): EGLBoolean; stdcall;
  eglCompositorSetWindowAttributesEXT: function(external_win_id: EGLint; window_attributes: PEGLint; num_entries: EGLint): EGLBoolean; stdcall;
  eglCompositorBindTexWindowEXT: function(external_win_id: EGLint): EGLBoolean; stdcall;
  eglCompositorSetSizeEXT: function(external_win_id: EGLint; width: EGLint; height: EGLint): EGLBoolean; stdcall;
  eglCompositorSwapPolicyEXT: function(external_win_id: EGLint; policy: EGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_device_base}
  eglQueryDeviceAttribEXT: function(device: EGLDeviceEXT; attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  eglQueryDeviceStringEXT: function(device: EGLDeviceEXT; name: EGLint): Pchar; stdcall;
  eglQueryDevicesEXT: function(max_devices: EGLint; devices: PEGLDeviceEXT; num_devices: PEGLint): EGLBoolean; stdcall;
  eglQueryDisplayAttribEXT: function(dpy: EGLDisplay; attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_device_persistent_id}
  eglQueryDeviceBinaryEXT: function(device: EGLDeviceEXT; name: EGLint; max_size: EGLint; value: pointer; size: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_image_dma_buf_import_modifiers}
  eglQueryDmaBufFormatsEXT: function(dpy: EGLDisplay; max_formats: EGLint; formats: PEGLint; num_formats: PEGLint): EGLBoolean; stdcall;
  eglQueryDmaBufModifiersEXT: function(dpy: EGLDisplay; format: EGLint; max_modifiers: EGLint; modifiers: PEGLuint64KHR; external_only: PEGLBoolean;
             num_modifiers: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_output_base}
  eglGetOutputLayersEXT: function(dpy: EGLDisplay; attrib_list: PEGLAttrib; layers: PEGLOutputLayerEXT; max_layers: EGLint; num_layers: PEGLint): EGLBoolean; stdcall;
  eglGetOutputPortsEXT: function(dpy: EGLDisplay; attrib_list: PEGLAttrib; ports: PEGLOutputPortEXT; max_ports: EGLint; num_ports: PEGLint): EGLBoolean; stdcall;
  eglOutputLayerAttribEXT: function(dpy: EGLDisplay; layer: EGLOutputLayerEXT; attribute: EGLint; value: EGLAttrib): EGLBoolean; stdcall;
  eglQueryOutputLayerAttribEXT: function(dpy: EGLDisplay; layer: EGLOutputLayerEXT; attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  eglQueryOutputLayerStringEXT: function(dpy: EGLDisplay; layer: EGLOutputLayerEXT; name: EGLint): Pchar; stdcall;
  eglOutputPortAttribEXT: function(dpy: EGLDisplay; port: EGLOutputPortEXT; attribute: EGLint; value: EGLAttrib): EGLBoolean; stdcall;
  eglQueryOutputPortAttribEXT: function(dpy: EGLDisplay; port: EGLOutputPortEXT; attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  eglQueryOutputPortStringEXT: function(dpy: EGLDisplay; port: EGLOutputPortEXT; name: EGLint): Pchar; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_platform_base}
  eglGetPlatformDisplayEXT: function(platform: EGLenum; native_display: pointer; attrib_list: PEGLint): EGLDisplay; stdcall;
  eglCreatePlatformWindowSurfaceEXT: function(dpy: EGLDisplay; config: EGLConfig; native_window: pointer; attrib_list: PEGLint): EGLSurface; stdcall;
  eglCreatePlatformPixmapSurfaceEXT: function(dpy: EGLDisplay; config: EGLConfig; native_pixmap: pointer; attrib_list: PEGLint): EGLSurface; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_stream_consumer_egloutput}
  eglStreamConsumerOutputEXT: function(dpy: EGLDisplay; stream: EGLStreamKHR; layer: EGLOutputLayerEXT): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_surface_compression}
  eglQuerySupportedCompressionRatesEXT: function(dpy: EGLDisplay; configs: PEGLConfig; attrib_list: PEGLAttrib; rates: PEGLint; rate_size: EGLint;
             num_rates: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_swap_buffers_with_damage}
  eglSwapBuffersWithDamageEXT: function(dpy: EGLDisplay; surface: EGLSurface; rects: PEGLint; n_rects: EGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_EXT_sync_reuse}
  eglUnsignalSyncEXT: function(dpy: EGLDisplay; sync: EGLSync; attrib_list: PEGLAttrib): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_HI_clientpixmap}
  eglCreatePixmapSurfaceHI: function(dpy: EGLDisplay; config: EGLConfig; pixmap: PEGLClientPixmapHI): EGLSurface; stdcall;
  {$EndIf}

  {$IfDef EGL_MESA_drm_image}
  eglCreateDRMImageMESA: function(dpy: EGLDisplay; attrib_list: PEGLint): EGLImageKHR; stdcall;
  eglExportDRMImageMESA: function(dpy: EGLDisplay; image: EGLImageKHR; name: PEGLint; handle: PEGLint; stride: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_MESA_image_dma_buf_export}
  eglExportDMABUFImageQueryMESA: function(dpy: EGLDisplay; image: EGLImageKHR; fourcc: Plongint; num_planes: Plongint; modifiers: PEGLuint64KHR): EGLBoolean; stdcall;
  eglExportDMABUFImageMESA: function(dpy: EGLDisplay; image: EGLImageKHR; fds: Plongint; strides: PEGLint; offsets: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_MESA_query_driver}
  eglGetDisplayDriverConfig: function(dpy: EGLDisplay): Pchar; stdcall;
  eglGetDisplayDriverName: function(dpy: EGLDisplay): Pchar; stdcall;
  {$EndIf}

  {$IfDef EGL_NOK_swap_region}
  eglSwapBuffersRegionNOK: function(dpy: EGLDisplay; surface: EGLSurface; numRects: EGLint; rects: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NOK_swap_region2}
  eglSwapBuffersRegion2NOK: function(dpy: EGLDisplay; surface: EGLSurface; numRects: EGLint; rects: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_native_query}
  eglQueryNativeDisplayNV: function(dpy: EGLDisplay; display_id: PEGLNativeDisplayType): EGLBoolean; stdcall;
  eglQueryNativeWindowNV: function(dpy: EGLDisplay; surf: EGLSurface; window: PEGLNativeWindowType): EGLBoolean; stdcall;
  eglQueryNativePixmapNV: function(dpy: EGLDisplay; surf: EGLSurface; pixmap: PEGLNativePixmapType): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_post_sub_buffer}
  eglPostSubBufferNV: function(dpy: EGLDisplay; surface: EGLSurface; x: EGLint; y: EGLint; width: EGLint;
             height: EGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_stream_consumer_eglimage}
  eglStreamImageConsumerConnectNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; num_modifiers: EGLint; modifiers: PEGLuint64KHR; attrib_list: PEGLAttrib): EGLBoolean; stdcall;
  eglQueryStreamConsumerEventNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; timeout: EGLTime; event: PEGLenum; aux: PEGLAttrib): EGLint; stdcall;
  eglStreamAcquireImageNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; pImage: PEGLImage; sync: EGLSync): EGLBoolean; stdcall;
  eglStreamReleaseImageNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; image: EGLImage; sync: EGLSync): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_stream_consumer_gltexture_yuv}
  eglStreamConsumerGLTextureExternalAttribsNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; attrib_list: PEGLAttrib): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_stream_flush}
  eglStreamFlushNV: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_stream_metadata}
  eglQueryDisplayAttribNV: function(dpy: EGLDisplay; attribute: EGLint; value: PEGLAttrib): EGLBoolean; stdcall;
  eglSetStreamMetadataNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; n: EGLint; offset: EGLint; size: EGLint;
             data: pointer): EGLBoolean; stdcall;
  eglQueryStreamMetadataNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; name: EGLenum; n: EGLint; offset: EGLint;
             size: EGLint; data: pointer): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_stream_reset}
  eglResetStreamNV: function(dpy: EGLDisplay; stream: EGLStreamKHR): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_stream_sync}
  eglCreateStreamSyncNV: function(dpy: EGLDisplay; stream: EGLStreamKHR; _type: EGLenum; attrib_list: PEGLint): EGLSyncKHR; stdcall;
  {$EndIf}

  {$IfDef EGL_NV_sync}
  {$IfDef CPU64}
  eglCreateFenceSyncNV: function(dpy: EGLDisplay; condition: EGLenum; attrib_list: PEGLint): EGLSyncNV; stdcall;
  eglDestroySyncNV: function(sync: EGLSyncNV): EGLBoolean; stdcall;
  eglFenceNV: function(sync: EGLSyncNV): EGLBoolean; stdcall;
  eglClientWaitSyncNV: function(sync: EGLSyncNV; flags: EGLint; timeout: EGLTimeNV): EGLint; stdcall;
  eglSignalSyncNV: function(sync: EGLSyncNV; mode: EGLenum): EGLBoolean; stdcall;
  eglGetSyncAttribNV: function(sync: EGLSyncNV; attribute: EGLint; value: PEGLint): EGLBoolean; stdcall;
  {$EndIf}{$EndIf}

  {$IfDef EGL_NV_system_time}
  {$IfDef CPU64}
  eglGetSystemTimeFrequencyNV: function: EGLuint64NV; stdcall;
  eglGetSystemTimeNV: function: EGLuint64NV; stdcall;
  {$EndIf}{$EndIf}

  {$IfDef EGL_WL_bind_wayland_display}
  eglBindWaylandDisplayWL: function(dpy: EGLDisplay; display: Pwl_display): EGLBoolean; stdcall;
  eglUnbindWaylandDisplayWL: function(dpy: EGLDisplay; display: Pwl_display): EGLBoolean; stdcall;
  eglQueryWaylandBufferWL: function(dpy: EGLDisplay; buffer: Pwl_resource; attribute: EGLint; value: PEGLint): EGLBoolean; stdcall;
  {$EndIf}

  {$IfDef EGL_WL_create_wayland_buffer_from_image}
  {EGLAPI struct wl_buffer *EGLAPIENTRY eglCreateWaylandBufferFromImageWL (EGLDisplay dpy, EGLImageKHR image); }
  eglCreateWaylandBufferFromImageWL: function(dpy: EGLDisplay; image: EGLImageKHR): Pwl_buffer; stdcall;
  {$EndIf}
  {$EndIf}

function InitEGL: Boolean;
procedure FreeEGL;

implementation

function InitEGL: Boolean;
begin
  Result := False;
  {$IfDef EGL_VERSION_1_0}
  eglGetProcAddress := dlsym(eglLibrary, 'eglGetProcAddress');
  if not Assigned(eglGetProcAddress) then
    exit;

  eglChooseConfig := eglGetProcAddress('eglChooseConfig');
  eglCreateContext := eglGetProcAddress('eglCreateContext');
  eglCreateWindowSurface := eglGetProcAddress('eglCreateWindowSurface');
  eglDestroyContext := eglGetProcAddress('eglDestroyContext');
  eglDestroySurface := eglGetProcAddress('eglDestroySurface');
  eglGetDisplay := eglGetProcAddress('eglGetDisplay');
  eglGetError := eglGetProcAddress('eglGetError');
  eglInitialize := eglGetProcAddress('eglInitialize');
  eglMakeCurrent := eglGetProcAddress('eglMakeCurrent');
  eglSwapBuffers := eglGetProcAddress('eglSwapBuffers');
  eglTerminate := eglGetProcAddress('eglTerminate');
  if not Assigned(eglGetDisplay) or not Assigned(eglInitialize) or not Assigned(eglTerminate) or not Assigned(eglChooseConfig) or
     not Assigned(eglCreateWindowSurface) or not Assigned(eglDestroySurface) or not Assigned(eglCreateContext) or not Assigned(eglDestroyContext) or
     not Assigned(eglMakeCurrent) or not Assigned(eglSwapBuffers) then
    exit;
  {$IfDef EGL_NO_MIN}
  eglCopyBuffers := eglGetProcAddress('eglCopyBuffers');
  eglCreatePbufferSurface := eglGetProcAddress('eglCreatePbufferSurface');
  eglCreatePixmapSurface := eglGetProcAddress('eglCreatePixmapSurface');   // eglCreatePixmapSurfaceHI
  eglGetConfigAttrib := eglGetProcAddress('eglGetConfigAttrib');
  eglGetConfigs := eglGetProcAddress('eglGetConfigs');
  eglGetCurrentDisplay := eglGetProcAddress('eglGetCurrentDisplay');
  eglGetCurrentSurface := eglGetProcAddress('eglGetCurrentSurface');
  eglQueryContext := eglGetProcAddress('eglQueryContext');
  eglQueryString := eglGetProcAddress('eglQueryString');
  eglQuerySurface := eglGetProcAddress('eglQuerySurface');          // eglQuerySurface64KHR
  eglWaitGL := eglGetProcAddress('eglWaitGL');
  eglWaitNative := eglGetProcAddress('eglWaitNative');
  {$EndIf}{$EndIf}

  {$IfDef EGL_VERSION_1_1}
  {$IfDef EGL_NO_MIN}
  eglBindTexImage := eglGetProcAddress('eglBindTexImage');
  eglReleaseTexImage := eglGetProcAddress('eglReleaseTexImage');
  eglSurfaceAttrib := eglGetProcAddress('eglSurfaceAttrib');
  {$EndIf}
  eglSwapInterval := eglGetProcAddress('eglSwapInterval');
  {$EndIf}

  {$IfDef EGL_NO_MIN}
  {$IfDef EGL_VERSION_1_2}
  eglBindAPI := eglGetProcAddress('eglBindAPI');
  eglQueryAPI := eglGetProcAddress('eglQueryAPI');
  eglCreatePbufferFromClientBuffer := eglGetProcAddress('eglCreatePbufferFromClientBuffer');
  eglReleaseThread := eglGetProcAddress('eglReleaseThread');
  eglWaitClient := eglGetProcAddress('eglWaitClient');
  {$EndIf}

  {$IfDef EGL_VERSION_1_4}
  eglGetCurrentContext := eglGetProcAddress('eglGetCurrentContext');
  {$EndIf}

  {$IfDef EGL_VERSION_1_5}
  eglCreateSync := eglGetProcAddress('eglCreateSync');                                     // KHR, 64KHR
  eglDestroySync := eglGetProcAddress('eglDestroySync');                                   // KHR, NV
  eglClientWaitSync := eglGetProcAddress('eglClientWaitSync');                             // KHR, NV
  eglGetSyncAttrib := eglGetProcAddress('eglGetSyncAttrib');                               // KHR, NV
  eglCreateImage := eglGetProcAddress('eglCreateImage');                                   // KHR
  eglDestroyImage := eglGetProcAddress('eglDestroyImage');                                 // KHR
  eglGetPlatformDisplay := eglGetProcAddress('eglGetPlatformDisplay');                     // EXT
  eglCreatePlatformWindowSurface := eglGetProcAddress('eglCreatePlatformWindowSurface');   // EXT
  eglCreatePlatformPixmapSurface := eglGetProcAddress('eglCreatePlatformPixmapSurface');   // EXT
  eglWaitSync := eglGetProcAddress('eglWaitSync');                                         // KHR
  {$EndIf}

  {$IfDef EGL_KHR_cl_event2}
  eglCreateSync64KHR := eglGetProcAddress('eglCreateSync64KHR');
  {$EndIf}

  {$IfDef EGL_KHR_debug}
  eglDebugMessageControlKHR := eglGetProcAddress('eglDebugMessageControlKHR');
  eglQueryDebugKHR := eglGetProcAddress('eglQueryDebugKHR');
  eglLabelObjectKHR := eglGetProcAddress('eglLabelObjectKHR');
  {$EndIf}

  {$IfDef EGL_KHR_display_reference}
  eglQueryDisplayAttribKHR := eglGetProcAddress('eglQueryDisplayAttribKHR');
  {$EndIf}

  {$IfDef EGL_KHR_fence_sync}
  {$IfDef CPU64}
  eglCreateSyncKHR := eglGetProcAddress('eglCreateSyncKHR');
  eglDestroySyncKHR := eglGetProcAddress('eglDestroySyncKHR');
  eglClientWaitSyncKHR := eglGetProcAddress('eglClientWaitSyncKHR');
  eglGetSyncAttribKHR := eglGetProcAddress('eglGetSyncAttribKHR');
  {$EndIf}
  {$EndIf}

  {$IfDef EGL_KHR_image}
  eglCreateImageKHR := eglGetProcAddress('eglCreateImageKHR');
  eglDestroyImageKHR := eglGetProcAddress('eglDestroyImageKHR');
  {$EndIf}

  {$IfDef EGL_KHR_lock_surface}
  eglLockSurfaceKHR := eglGetProcAddress('eglLockSurfaceKHR');
  eglUnlockSurfaceKHR := eglGetProcAddress('eglUnlockSurfaceKHR');
  {$EndIf}

  {$IfDef EGL_KHR_lock_surface3}
  eglQuerySurface64KHR := eglGetProcAddress('eglQuerySurface64KHR');
  {$EndIf}

  {$IfDef EGL_KHR_partial_update}
  eglSetDamageRegionKHR := eglGetProcAddress('eglSetDamageRegionKHR');
  {$EndIf}

  {$IfDef EGL_KHR_reusable_sync}
  {$IfDef CPU64}
  eglSignalSyncKHR := eglGetProcAddress('eglSignalSyncKHR');
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream}
  {$IfDef CPU64}
  eglCreateStreamKHR := eglGetProcAddress('eglCreateStreamKHR');
  eglDestroyStreamKHR := eglGetProcAddress('eglDestroyStreamKHR');
  eglStreamAttribKHR := eglGetProcAddress('eglStreamAttribKHR');
  eglQueryStreamKHR := eglGetProcAddress('eglQueryStreamKHR');
  eglQueryStreamu64KHR := eglGetProcAddress('eglQueryStreamu64KHR');
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream_attrib}
  {$IfDef CPU64}
  eglCreateStreamAttribKHR := eglGetProcAddress('eglCreateStreamAttribKHR');
  eglSetStreamAttribKHR := eglGetProcAddress('eglSetStreamAttribKHR');
  eglQueryStreamAttribKHR := eglGetProcAddress('eglQueryStreamAttribKHR');
  eglStreamConsumerAcquireAttribKHR := eglGetProcAddress('eglStreamConsumerAcquireAttribKHR');
  eglStreamConsumerReleaseAttribKHR := eglGetProcAddress('eglStreamConsumerReleaseAttribKHR');
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream_consumer_gltexture}
  eglStreamConsumerGLTextureExternalKHR := eglGetProcAddress('eglStreamConsumerGLTextureExternalKHR');
  eglStreamConsumerAcquireKHR := eglGetProcAddress('eglStreamConsumerAcquireKHR');
  eglStreamConsumerReleaseKHR := eglGetProcAddress('eglStreamConsumerReleaseKHR');
  {$EndIf}

  {$IfDef EGL_KHR_stream_cross_process_fd}
  eglGetStreamFileDescriptorKHR := eglGetProcAddress('eglGetStreamFileDescriptorKHR');
  eglCreateStreamFromFileDescriptorKHR := eglGetProcAddress('eglCreateStreamFromFileDescriptorKHR');
  {$EndIf}

  {$IfDef EGL_KHR_stream_fifo}
  eglQueryStreamTimeKHR := eglGetProcAddress('eglQueryStreamTimeKHR');
  {$EndIf}

  {$IfDef EGL_KHR_stream_producer_eglsurface}
  eglCreateStreamProducerSurfaceKHR := eglGetProcAddress('eglCreateStreamProducerSurfaceKHR');
  {$EndIf}

  {$IfDef EGL_KHR_swap_buffers_with_damage}
  eglSwapBuffersWithDamageKHR := eglGetProcAddress('eglSwapBuffersWithDamageKHR');
  {$EndIf}

  {$IfDef EGL_KHR_wait_sync}
  eglWaitSyncKHR := eglGetProcAddress('eglWaitSyncKHR');
  {$EndIf}

  {$IfDef EGL_ANDROID_blob_cache}
  eglSetBlobCacheFuncsANDROID := eglGetProcAddress('eglSetBlobCacheFuncsANDROID');
  {$EndIf}

  {$IfDef EGL_ANDROID_create_native_client_buffer}
  eglCreateNativeClientBufferANDROID := eglGetProcAddress('eglCreateNativeClientBufferANDROID');
  {$EndIf}

  {$IfDef EGL_ANDROID_get_frame_timestamps}
  eglGetCompositorTimingSupportedANDROID := eglGetProcAddress('eglGetCompositorTimingSupportedANDROID');
  eglGetCompositorTimingANDROID := eglGetProcAddress('eglGetCompositorTimingANDROID');
  eglGetNextFrameIdANDROID := eglGetProcAddress('eglGetNextFrameIdANDROID');
  eglGetFrameTimestampSupportedANDROID := eglGetProcAddress('eglGetFrameTimestampSupportedANDROID');
  eglGetFrameTimestampsANDROID := eglGetProcAddress('eglGetFrameTimestampsANDROID');
  {$EndIf}

  {$IfDef EGL_ANDROID_get_native_client_buffer}
  eglGetNativeClientBufferANDROID := eglGetProcAddress('eglGetNativeClientBufferANDROID');
  {$EndIf}

  {$IfDef EGL_ANDROID_native_fence_sync}
  eglDupNativeFenceFDANDROID := eglGetProcAddress('eglDupNativeFenceFDANDROID');
  {$EndIf}

  {$IfDef EGL_ANDROID_presentation_time}
  eglPresentationTimeANDROID := eglGetProcAddress('eglPresentationTimeANDROID');
  {$EndIf}

  {$IfDef EGL_ANGLE_query_surface_pointer}
  eglQuerySurfacePointerANGLE := eglGetProcAddress('eglQuerySurfacePointerANGLE');
  {$EndIf}

  {$IfDef EGL_ANGLE_sync_control_rate}
  eglGetMscRateANGLE := eglGetProcAddress('eglGetMscRateANGLE');
  {$EndIf}

  {$IfDef EGL_EXT_client_sync}
  eglClientSignalSyncEXT := eglGetProcAddress('eglClientSignalSyncEXT');
  {$EndIf}

  {$IfDef EGL_EXT_compositor}
  eglCompositorSetContextListEXT := eglGetProcAddress('eglCompositorSetContextListEXT');
  eglCompositorSetContextAttributesEXT := eglGetProcAddress('eglCompositorSetContextAttributesEXT');
  eglCompositorSetWindowListEXT := eglGetProcAddress('eglCompositorSetWindowListEXT');
  eglCompositorSetWindowAttributesEXT := eglGetProcAddress('eglCompositorSetWindowAttributesEXT');
  eglCompositorBindTexWindowEXT := eglGetProcAddress('eglCompositorBindTexWindowEXT');
  eglCompositorSetSizeEXT := eglGetProcAddress('eglCompositorSetSizeEXT');
  eglCompositorSwapPolicyEXT := eglGetProcAddress('eglCompositorSwapPolicyEXT');
  {$EndIf}

  {$IfDef EGL_EXT_device_base}
  eglQueryDeviceAttribEXT := eglGetProcAddress('eglQueryDeviceAttribEXT');
  eglQueryDeviceStringEXT := eglGetProcAddress('eglQueryDeviceStringEXT');
  eglQueryDevicesEXT := eglGetProcAddress('eglQueryDevicesEXT');
  eglQueryDisplayAttribEXT := eglGetProcAddress('eglQueryDisplayAttribEXT');
  {$EndIf}

  {$IfDef EGL_EXT_device_persistent_id}
  eglQueryDeviceBinaryEXT := eglGetProcAddress('eglQueryDeviceBinaryEXT');
  {$EndIf}

  {$IfDef EGL_EXT_image_dma_buf_import_modifiers}
  eglQueryDmaBufFormatsEXT := eglGetProcAddress('eglQueryDmaBufFormatsEXT');
  eglQueryDmaBufModifiersEXT := eglGetProcAddress('eglQueryDmaBufModifiersEXT');
  {$EndIf}

  {$IfDef EGL_EXT_output_base}
  eglGetOutputLayersEXT := eglGetProcAddress('eglGetOutputLayersEXT');
  eglGetOutputPortsEXT := eglGetProcAddress('eglGetOutputPortsEXT');
  eglOutputLayerAttribEXT := eglGetProcAddress('eglOutputLayerAttribEXT');
  eglQueryOutputLayerAttribEXT := eglGetProcAddress('eglQueryOutputLayerAttribEXT');
  eglQueryOutputLayerStringEXT := eglGetProcAddress('eglQueryOutputLayerStringEXT');
  eglOutputPortAttribEXT := eglGetProcAddress('eglOutputPortAttribEXT');
  eglQueryOutputPortAttribEXT := eglGetProcAddress('eglQueryOutputPortAttribEXT');
  eglQueryOutputPortStringEXT := eglGetProcAddress('eglQueryOutputPortStringEXT');
  {$EndIf}

  {$IfDef EGL_EXT_platform_base}
  eglGetPlatformDisplayEXT := eglGetProcAddress('eglGetPlatformDisplayEXT');
  eglCreatePlatformWindowSurfaceEXT := eglGetProcAddress('eglCreatePlatformWindowSurfaceEXT');
  eglCreatePlatformPixmapSurfaceEXT := eglGetProcAddress('eglCreatePlatformPixmapSurfaceEXT');
  {$EndIf}

  {$IfDef EGL_EXT_stream_consumer_egloutput}
  eglStreamConsumerOutputEXT := eglGetProcAddress('eglStreamConsumerOutputEXT');
  {$EndIf}

  {$IfDef EGL_EXT_surface_compression}
  eglQuerySupportedCompressionRatesEXT := eglGetProcAddress('eglQuerySupportedCompressionRatesEXT');
  {$EndIf}

  {$IfDef EGL_EXT_swap_buffers_with_damage}
  eglSwapBuffersWithDamageEXT := eglGetProcAddress('eglSwapBuffersWithDamageEXT');
  {$EndIf}

  {$IfDef EGL_EXT_sync_reuse}
  eglUnsignalSyncEXT := eglGetProcAddress('eglUnsignalSyncEXT');
  {$EndIf}

  {$IfDef EGL_HI_clientpixmap}
  eglCreatePixmapSurfaceHI := eglGetProcAddress('eglCreatePixmapSurfaceHI');
  {$EndIf}

  {$IfDef EGL_MESA_drm_image}
  eglCreateDRMImageMESA := eglGetProcAddress('eglCreateDRMImageMESA');
  eglExportDRMImageMESA := eglGetProcAddress('eglExportDRMImageMESA');
  {$EndIf}

  {$IfDef EGL_MESA_image_dma_buf_export}
  eglExportDMABUFImageQueryMESA := eglGetProcAddress('eglExportDMABUFImageQueryMESA');
  eglExportDMABUFImageMESA := eglGetProcAddress('eglExportDMABUFImageMESA');
  {$EndIf}

  {$IfDef EGL_MESA_query_driver}
  eglGetDisplayDriverConfig := eglGetProcAddress('eglGetDisplayDriverConfig');
  eglGetDisplayDriverName := eglGetProcAddress('eglGetDisplayDriverName');
  {$EndIf}

  {$IfDef EGL_NOK_swap_region}
  eglSwapBuffersRegionNOK := eglGetProcAddress('eglSwapBuffersRegionNOK');
  {$EndIf}

  {$IfDef EGL_NOK_swap_region2}
  eglSwapBuffersRegion2NOK := eglGetProcAddress('eglSwapBuffersRegion2NOK');
  {$EndIf}

  {$IfDef EGL_NV_native_query}
  eglQueryNativeDisplayNV := eglGetProcAddress('eglQueryNativeDisplayNV');
  eglQueryNativeWindowNV := eglGetProcAddress('eglQueryNativeWindowNV');
  eglQueryNativePixmapNV := eglGetProcAddress('eglQueryNativePixmapNV');
  {$EndIf}

  {$IfDef EGL_NV_post_sub_buffer}
  eglPostSubBufferNV := eglGetProcAddress('eglPostSubBufferNV');
  {$EndIf}

  {$IfDef EGL_NV_stream_consumer_eglimage}
  eglStreamImageConsumerConnectNV := eglGetProcAddress('eglStreamImageConsumerConnectNV');
  eglQueryStreamConsumerEventNV := eglGetProcAddress('eglQueryStreamConsumerEventNV');
  eglStreamAcquireImageNV := eglGetProcAddress('eglStreamAcquireImageNV');
  eglStreamReleaseImageNV := eglGetProcAddress('eglStreamReleaseImageNV');
  {$EndIf}

  {$IfDef EGL_NV_stream_consumer_gltexture_yuv}
  eglStreamConsumerGLTextureExternalAttribsNV := eglGetProcAddress('eglStreamConsumerGLTextureExternalAttribsNV');
  {$EndIf}

  {$IfDef EGL_NV_stream_flush}
  eglStreamFlushNV := eglGetProcAddress('eglStreamFlushNV');
  {$EndIf}

  {$IfDef EGL_NV_stream_metadata}
  eglQueryDisplayAttribNV := eglGetProcAddress('eglQueryDisplayAttribNV');
  eglSetStreamMetadataNV := eglGetProcAddress('eglSetStreamMetadataNV');
  eglQueryStreamMetadataNV := eglGetProcAddress('eglQueryStreamMetadataNV');
  {$EndIf}

  {$IfDef EGL_NV_stream_reset}
  eglResetStreamNV := eglGetProcAddress('eglResetStreamNV');
  {$EndIf}

  {$IfDef EGL_NV_stream_sync}
  eglCreateStreamSyncNV := eglGetProcAddress('eglCreateStreamSyncNV');
  {$EndIf}

  {$IfDef EGL_NV_sync}
  {$IfDef CPU64}
  eglCreateFenceSyncNV := eglGetProcAddress('eglCreateFenceSyncNV');
  eglDestroySyncNV := eglGetProcAddress('eglDestroySyncNV');
  eglFenceNV := eglGetProcAddress('eglFenceNV');
  eglClientWaitSyncNV := eglGetProcAddress('eglClientWaitSyncNV');
  eglSignalSyncNV := eglGetProcAddress('eglSignalSyncNV');
  eglGetSyncAttribNV := eglGetProcAddress('eglGetSyncAttribNV');
  {$EndIf}{$EndIf}

  {$IfDef EGL_NV_system_time}
  {$IfDef CPU64}
  eglGetSystemTimeFrequencyNV := eglGetProcAddress('eglGetSystemTimeFrequencyNV');
  eglGetSystemTimeNV := eglGetProcAddress('eglGetSystemTimeNV');
  {$EndIf}{$EndIf}

  {$IfDef EGL_WL_bind_wayland_display}
  eglBindWaylandDisplayWL := eglGetProcAddress('eglBindWaylandDisplayWL');
  eglUnbindWaylandDisplayWL := eglGetProcAddress('eglUnbindWaylandDisplayWL');
  eglQueryWaylandBufferWL := eglGetProcAddress('eglQueryWaylandBufferWL');
  {$EndIf}

  {$IfDef EGL_WL_create_wayland_buffer_from_image}
  eglCreateWaylandBufferFromImageWL := eglGetProcAddress('eglCreateWaylandBufferFromImageWL');
  {$EndIf}
  {$EndIf}
  Result := True;
end;

procedure FreeEGL;
begin
  {$IfDef EGL_VERSION_1_0}
  eglGetProcAddress := nil;

  eglChooseConfig := nil;
  eglCreateContext := nil;
  eglCreateWindowSurface := nil;
  eglDestroyContext := nil;
  eglDestroySurface := nil;
  eglGetDisplay := nil;
  eglGetError := nil;
  eglInitialize := nil;
  eglMakeCurrent := nil;
  eglSwapBuffers := nil;
  eglTerminate := nil;
  {$IfDef EGL_NO_MIN}
  eglCopyBuffers := nil;
  eglCreatePbufferSurface := nil;
  eglCreatePixmapSurface := nil;   // eglCreatePixmapSurfaceHI
  eglGetConfigAttrib := nil;
  eglGetConfigs := nil;
  eglGetCurrentDisplay := nil;
  eglGetCurrentSurface := nil;
  eglQueryContext := nil;
  eglQueryString := nil;
  eglQuerySurface := nil;          // eglQuerySurface64KHR
  eglWaitGL := nil;
  eglWaitNative := nil;
  {$EndIf}{$EndIf}

  {$IfDef EGL_VERSION_1_1}
  {$IfDef EGL_NO_MIN}
  eglBindTexImage := nil;
  eglReleaseTexImage := nil;
  eglSurfaceAttrib := nil;
  {$EndIf}
  eglSwapInterval := nil;
  {$EndIf}

  {$IfDef EGL_NO_MIN}
  {$IfDef EGL_VERSION_1_2}
  eglBindAPI := nil;
  eglQueryAPI := nil;
  eglCreatePbufferFromClientBuffer := nil;
  eglReleaseThread := nil;
  eglWaitClient := nil;
  {$EndIf}

  {$IfDef EGL_VERSION_1_4}
  eglGetCurrentContext := nil;
  {$EndIf}

  {$IfDef EGL_VERSION_1_5}
  eglCreateSync := nil;                    // KHR, 64KHR
  eglDestroySync := nil;                   // KHR, NV
  eglClientWaitSync := nil;                // KHR, NV
  eglGetSyncAttrib := nil;                 // KHR, NV
  eglCreateImage := nil;                   // KHR
  eglDestroyImage := nil;                  // KHR
  eglGetPlatformDisplay := nil;            // EXT
  eglCreatePlatformWindowSurface := nil;   // EXT
  eglCreatePlatformPixmapSurface := nil;   // EXT
  eglWaitSync := nil;                      // KHR
  {$EndIf}

  {$IfDef EGL_KHR_cl_event2}
  eglCreateSync64KHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_debug}
  eglDebugMessageControlKHR := nil;
  eglQueryDebugKHR := nil;
  eglLabelObjectKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_display_reference}
  eglQueryDisplayAttribKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_fence_sync}
  {$IfDef CPU64}
  eglCreateSyncKHR := nil;
  eglDestroySyncKHR := nil;
  eglClientWaitSyncKHR := nil;
  eglGetSyncAttribKHR := nil;
  {$EndIf}
  {$EndIf}

  {$IfDef EGL_KHR_image}
  eglCreateImageKHR := nil;
  eglDestroyImageKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_lock_surface}
  eglLockSurfaceKHR := nil;
  eglUnlockSurfaceKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_lock_surface3}
  eglQuerySurface64KHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_partial_update}
  eglSetDamageRegionKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_reusable_sync}
  {$IfDef CPU64}
  eglSignalSyncKHR := nil;
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream}
  {$IfDef CPU64}
  eglCreateStreamKHR := nil;
  eglDestroyStreamKHR := nil;
  eglStreamAttribKHR := nil;
  eglQueryStreamKHR := nil;
  eglQueryStreamu64KHR := nil;
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream_attrib}
  {$IfDef CPU64}
  eglCreateStreamAttribKHR := nil;
  eglSetStreamAttribKHR := nil;
  eglQueryStreamAttribKHR := nil;
  eglStreamConsumerAcquireAttribKHR := nil;
  eglStreamConsumerReleaseAttribKHR := nil;
  {$EndIf}{$EndIf}

  {$IfDef EGL_KHR_stream_consumer_gltexture}
  eglStreamConsumerGLTextureExternalKHR := nil;
  eglStreamConsumerAcquireKHR := nil;
  eglStreamConsumerReleaseKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_stream_cross_process_fd}
  eglGetStreamFileDescriptorKHR := nil;
  eglCreateStreamFromFileDescriptorKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_stream_fifo}
  eglQueryStreamTimeKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_stream_producer_eglsurface}
  eglCreateStreamProducerSurfaceKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_swap_buffers_with_damage}
  eglSwapBuffersWithDamageKHR := nil;
  {$EndIf}

  {$IfDef EGL_KHR_wait_sync}
  eglWaitSyncKHR := nil;
  {$EndIf}

  {$IfDef EGL_ANDROID_blob_cache}
  eglSetBlobCacheFuncsANDROID := nil;
  {$EndIf}

  {$IfDef EGL_ANDROID_create_native_client_buffer}
  eglCreateNativeClientBufferANDROID := nil;
  {$EndIf}

  {$IfDef EGL_ANDROID_get_frame_timestamps}
  eglGetCompositorTimingSupportedANDROID := nil;
  eglGetCompositorTimingANDROID := nil;
  eglGetNextFrameIdANDROID := nil;
  eglGetFrameTimestampSupportedANDROID
  eglGetFrameTimestampsANDROID := nil;
  {$EndIf}

  {$IfDef EGL_ANDROID_get_native_client_buffer}
  eglGetNativeClientBufferANDROID := nil;
  {$EndIf}

  {$IfDef EGL_ANDROID_native_fence_sync}
  eglDupNativeFenceFDANDROID := nil;
  {$EndIf}

  {$IfDef EGL_ANDROID_presentation_time}
  eglPresentationTimeANDROID := nil;
  {$EndIf}

  {$IfDef EGL_ANGLE_query_surface_pointer}
  eglQuerySurfacePointerANGLE := nil;
  {$EndIf}

  {$IfDef EGL_ANGLE_sync_control_rate}
  eglGetMscRateANGLE := nil;
  {$EndIf}

  {$IfDef EGL_EXT_client_sync}
  eglClientSignalSyncEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_compositor}
  eglCompositorSetContextListEXT := nil;
  eglCompositorSetContextAttributesEXT := nil;
  eglCompositorSetWindowListEXT := nil;
  eglCompositorSetWindowAttributesEXT := nil;
  eglCompositorBindTexWindowEXT := nil;
  eglCompositorSetSizeEXT := nil;
  eglCompositorSwapPolicyEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_device_base}
  eglQueryDeviceAttribEXT := nil;
  eglQueryDeviceStringEXT := nil;
  eglQueryDevicesEXT := nil;
  eglQueryDisplayAttribEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_device_persistent_id}
  eglQueryDeviceBinaryEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_image_dma_buf_import_modifiers}
  eglQueryDmaBufFormatsEXT := nil;
  eglQueryDmaBufModifiersEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_output_base}
  eglGetOutputLayersEXT := nil;
  eglGetOutputPortsEXT := nil;
  eglOutputLayerAttribEXT := nil;
  eglQueryOutputLayerAttribEXT := nil;
  eglQueryOutputLayerStringEXT := nil;
  eglOutputPortAttribEXT := nil;
  eglQueryOutputPortAttribEXT := nil;
  eglQueryOutputPortStringEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_platform_base}
  eglGetPlatformDisplayEXT := nil;
  eglCreatePlatformWindowSurfaceEXT := nil;
  eglCreatePlatformPixmapSurfaceEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_stream_consumer_egloutput}
  eglStreamConsumerOutputEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_surface_compression}
  eglQuerySupportedCompressionRatesEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_swap_buffers_with_damage}
  eglSwapBuffersWithDamageEXT := nil;
  {$EndIf}

  {$IfDef EGL_EXT_sync_reuse}
  eglUnsignalSyncEXT := nil;
  {$EndIf}

  {$IfDef EGL_HI_clientpixmap}
  eglCreatePixmapSurfaceHI := nil;
  {$EndIf}

  {$IfDef EGL_MESA_drm_image}
  eglCreateDRMImageMESA := nil;
  eglExportDRMImageMESA := nil;
  {$EndIf}

  {$IfDef EGL_MESA_image_dma_buf_export}
  eglExportDMABUFImageQueryMESA := nil;
  eglExportDMABUFImageMESA := nil;
  {$EndIf}

  {$IfDef EGL_MESA_query_driver}
  eglGetDisplayDriverConfig := nil;
  eglGetDisplayDriverName := nil;
  {$EndIf}

  {$IfDef EGL_NOK_swap_region}
  eglSwapBuffersRegionNOK := nil;
  {$EndIf}

  {$IfDef EGL_NOK_swap_region2}
  eglSwapBuffersRegion2NOK := nil;
  {$EndIf}

  {$IfDef EGL_NV_native_query}
  eglQueryNativeDisplayNV := nil;
  eglQueryNativeWindowNV := nil;
  eglQueryNativePixmapNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_post_sub_buffer}
  eglPostSubBufferNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_stream_consumer_eglimage}
  eglStreamImageConsumerConnectNV := nil;
  eglQueryStreamConsumerEventNV := nil;
  eglStreamAcquireImageNV := nil;
  eglStreamReleaseImageNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_stream_consumer_gltexture_yuv}
  eglStreamConsumerGLTextureExternalAttribsNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_stream_flush}
  eglStreamFlushNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_stream_metadata}
  eglQueryDisplayAttribNV := nil;
  eglSetStreamMetadataNV := nil;
  eglQueryStreamMetadataNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_stream_reset}
  eglResetStreamNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_stream_sync}
  eglCreateStreamSyncNV := nil;
  {$EndIf}

  {$IfDef EGL_NV_sync}
  {$IfDef CPU64}
  eglCreateFenceSyncNV := nil;
  eglDestroySyncNV := nil;
  eglFenceNV := nil;
  eglClientWaitSyncNV := nil;
  eglSignalSyncNV := nil;
  eglGetSyncAttribNV := nil;
  {$EndIf}{$EndIf}

  {$IfDef EGL_NV_system_time}
  {$IfDef CPU64}
  eglGetSystemTimeFrequencyNV := nil;
  eglGetSystemTimeNV := nil;
  {$EndIf}{$EndIf}

  {$IfDef EGL_WL_bind_wayland_display}
  eglBindWaylandDisplayWL := nil;
  eglUnbindWaylandDisplayWL := nil;
  eglQueryWaylandBufferWL := nil;
  {$EndIf}

  {$IfDef EGL_WL_create_wayland_buffer_from_image}
  eglCreateWaylandBufferFromImageWL := nil;
  {$EndIf}
  {$EndIf}
end;

end.

