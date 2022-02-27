(*
 *  Copyright (c) 2022 Serge - SSW
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

unit zgl_glx_wgl;
{$I zgl_config.cfg}
{$I GLdefine.cfg}

interface

uses
  {$IfDef LINUX}
  X,
  XLib,
  XUtil,
  {$EndIf}
  {$IfDef WINDOWS}
  Windows,
  {$EndIf}
  zgl_gltypeconst;

{$IfDef WINDOWS}
var
  WGL_ARB_buffer_region: Boolean;
  WGL_ARB_context_flush_control: Boolean;
  WGL_ARB_create_context: Boolean;
  WGL_ARB_create_context_no_error: Boolean;
  WGL_ARB_create_context_profile: Boolean;
  WGL_ARB_create_context_robustness: Boolean;
  WGL_ARB_make_current_read: Boolean;
  WGL_ARB_extensions_string: Boolean;
  WGL_ARB_framebuffer_sRGB: Boolean;
  WGL_ARB_multisample: Boolean;
  WGL_ARB_pbuffer: Boolean;
  WGL_ARB_pixel_format: Boolean;
  WGL_ARB_pixel_format_float: Boolean;
  WGL_ARB_render_texture: Boolean;
  WGL_ARB_robustness_application_isolation: Boolean;
  WGL_ARB_robustness_share_group_isolation: Boolean;
  WGL_3DFX_multisample: Boolean;
  WGL_3DL_stereo_control: Boolean;
  WGL_AMD_gpu_association: Boolean;
  WGL_ATI_pixel_format_float: Boolean;
  WGL_ATI_render_texture_rectangle: Boolean;
  WGL_EXT_colorspace: Boolean;
  WGL_EXT_create_context_es2_profile: Boolean;
  WGL_EXT_create_context_es_profile: Boolean;
  WGL_EXT_depth_float: Boolean;
  WGL_EXT_display_color_table: Boolean;
  WGL_EXT_framebuffer_sRGB: Boolean;
  WGL_EXT_make_current_read: Boolean;
  WGL_EXT_multisample: Boolean;
  WGL_EXT_pbuffer: Boolean;
  WGL_EXT_extensions_string: Boolean;
  WGL_EXT_pixel_format: Boolean;
  WGL_EXT_pixel_format_packed_float: Boolean;
  WGL_EXT_swap_control: Boolean;
  WGL_EXT_swap_control_tear: Boolean;
  WGL_I3D_digital_video_control: Boolean;
  WGL_I3D_gamma: Boolean;
  WGL_I3D_genlock: Boolean;
  WGL_I3D_image_buffer: Boolean;
  WGL_I3D_swap_frame_lock: Boolean;
  WGL_I3D_swap_frame_usage: Boolean;
  WGL_NV_DX_interop: Boolean;
  WGL_NV_DX_interop2: Boolean;
  WGL_NV_copy_image: Boolean;
  WGL_NV_delay_before_swap: Boolean;
  WGL_NV_float_buffer: Boolean;
  WGL_NV_gpu_affinity: Boolean;
  WGL_NV_multigpu_context: Boolean;
  WGL_NV_multisample_coverage: Boolean;
  WGL_NV_present_video: Boolean;
  WGL_NV_render_depth_texture: Boolean;
  WGL_NV_render_texture_rectangle: Boolean;
  WGL_NV_swap_group: Boolean;
  WGL_NV_vertex_array_range: Boolean;
  WGL_NV_video_capture: Boolean;
  WGL_NV_video_output: Boolean;
  WGL_OML_sync_control: Boolean;

{ wgl Windows OpenGL helper functions }
{$IfNDef FPC}
  function wglGetProcAddress(ProcName: LPCSTR): PROC; stdcall; external libGL;
  {$IfDef USE_FULL_WGL}
var
  (* WGL_VERSION_1_0 *)
  wglCopyContext: function(glrcSrc: HGLRC; glrcDst: HGLRC; mask: UINT): WINBOOL; stdcall;
  wglCreateContext: function(hdc: HDC): HGLRC; stdcall;
  wglCreateLayerContext: function(hdc: HDC; iLayerPlane: longint): HGLRC; stdcall;
  wglDeleteContext: function(glrc: HGLRC): WINBOOL; stdcall;
  wglDescribeLayerPlane: function(DC: HDC; iPixelFormat: longint; iLayerPane: longint; nBytes: UINT; plpd: LPLAYERPLANEDESCRIPTOR): WINBOOL; stdcall;
  wglGetCurrentContext: function: HGLRC; stdcall;
  wglGetCurrentDC: function: HDC; stdcall;
  wglGetLayerPaletteEntries: function(DC: HDC; iLayerPlane: longint; iStart: longint; cEntries: longint; var cr: COLORREF): longint; stdcall;
  wglMakeCurrent: function(DC: HDC; glrc: HGLRC): WINBOOL; stdcall;
  wglRealizeLayerPalette: function(DC: HDC; iLayerPlane: longint; bRealize: WINBOOL): WINBOOL; stdcall;
  wglSetLayerPaletteEntries: function(DC: HDC; iLayerPlane: longint; iStart: longint; cEntries: longint; var cr: COLORREF): longint; stdcall;
  wglShareLists: function(glrc1: HGLRC; glrc2: HGLRC): WINBOOL; stdcall;
  wglSwapLayerBuffers: function(DC: HDC; fuPlanes: UINT): WINBOOL; stdcall;
  { откуда взялась эта функция? Нет ни каких указаний на неё  - wglSwapMultipleBuffers: function(p1: UINT; const p2: PWGLSWAP): DWORD; stdcall; }
  wglUseFontBitmaps: function(DC: HDC; first: DWORD; count: DWORD; listbase: DWORD):WINBOOL; stdcall;
  wglUseFontBitmapsW: function(DC: HDC; first: DWORD; count: DWORD; listbase: DWORD):WINBOOL; stdcall;
  wglUseFontBitmapsA: function(DC: HDC; first: DWORD; count: DWORD; listbase: DWORD):WINBOOL; stdcall;
  wglUseFontOutlines: function(DC: HDC; first: DWORD; count: DWORD; listbase: DWORD; deviation: Single; extrusion: Single; format: longint; lpgmf: LPGLYPHMETRICSFLOAT): WINBOOL; stdcall;
  wglUseFontOutlinesA: function(DC: HDC; first: DWORD; count: DWORD; listbase: DWORD; deviation: Single; extrusion: Single; format: longint; lpgmf: LPGLYPHMETRICSFLOAT): WINBOOL; stdcall;
  wglUseFontOutlinesW: function(DC: HDC; first: DWORD; count: DWORD;  listbase: DWORD; deviation: Single; extrusion: Single; format: longint; lpgmf: LPGLYPHMETRICSFLOAT): WINBOOL; stdcall;
  {$EndIf}
{$EndIf}
var
  {$if defined(WGL_ARB_pixel_format) or defined(WGL_EXT_pixel_format)}  //  WGL_ARB_pixel_format or WGL_EXT_pixel_format =>  WGL_ARB_pixel_format
  wglGetPixelFormatAttribivARB: function(hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; const piAttributes: PGLint; piValues: PGLint): Boolean; stdcall;
  wglGetPixelFormatAttribfvARB: function(hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; const piAttributes: PGLint; pfValues: PGLfloat): Boolean; stdcall;
  wglChoosePixelFormatARB: function(hdc: HDC; const piAttribIList: PGLint; const pfAttribFList: PGLfloat; nMaxFormats: GLuint; piFormats: PGLint; nNumFormats: PGLuint): BOOL; stdcall;
  {$IfEnd}

  {$ifdef WGL_EXT_swap_control}
  wglSwapIntervalEXT: function(interval: GLint): Boolean; stdcall;
  wglGetSwapIntervalEXT: function(): GLint; stdcall;
  {$EndIf}

  {$If defined(WGL_ARB_pbuffer) or defined(WGL_EXT_pbuffer)}   // (WGL_ARB_pbuffer or WGL_EXT_pbuffer)  =>   WGL_ARB_pbuffer
  wglCreatePbufferARB: function(hDC: HDC; iPixelFormat: GLint; iWidth: GLint; iHeight: GLint; const piAttribList: PGLint): THANDLE; stdcall;
  wglGetPbufferDCARB: function(hPbuffer: THandle): HDC; stdcall;
  wglReleasePbufferDCARB: function(hPbuffer: THandle; hDC: HDC): GLint; stdcall;
  wglDestroyPbufferARB: function(hPbuffer: THandle): Boolean; stdcall;
  // вернуть значения ширины, высоты или потеря пиксельного буфера.
  wglQueryPbufferARB: function(hPbuffer: THandle; iAttribute: GLint; piValue: PGLint): Boolean; stdcall;
  {$IfEnd}

  {$If defined(WGL_ARB_extensions_string) or defined(WGL_EXT_extensions_string)}
  // это полный кабздец... для каждого окна эта функция может возвращать разные значения!!!
  // это означает, что создавая новое окно, вы заново должны переопределить эту функцию (так же и с другими, которые запрашивают окно).
  wglGetExtensionsStringARB: function(hdc: HDC): PAnsiChar; stdcall;
  {$IfEnd}

  {$ifdef WGL_ARB_buffer_region}
  wglCreateBufferRegionARB: function(hDC: HDC; iLayerPlane: GLint; uType: GLuint): THandle; stdcall;
  wglDeleteBufferRegionARB: procedure(hRegion: THandle); stdcall;
  wglSaveBufferRegionARB: function(hRegion: THandle; x: GLint; y: GLint; width: GLint; height: GLint): Boolean; stdcall;
  wglRestoreBufferRegionARB: function(hRegion: THandle; x: GLint; y: GLint; width: GLint; height: GLint; xSrc: GLint; ySrc: GLint): Boolean; stdcall;
  {$EndIf}

  {$if defined(WGL_ARB_make_current_read) or defined(WGL_EXT_make_current_read)}
  wglMakeContextCurrentARB: function(hDrawDC: HDC; hReadDC: HDC; hglrc: HGLRC): Boolean; stdcall;
  wglGetCurrentReadDCARB: function(): HDC; stdcall;
  {$IfEnd}

  // WGL_ARB_color_buffer_float  - удалено???
  // wglClampColorARB: procedure(target: GLenum; clamp: GLenum); stdcall;

  {$ifdef WGL_ARB_render_texture}
  wglBindTexImageARB: function(hPbuffer: THandle; iBuffer: GLint): Boolean; stdcall;
  wglReleaseTexImageARB: function(hPbuffer: THandle; iBuffer: GLint): Boolean; stdcall;
  wglSetPbufferAttribARB: function(hPbuffer: THandle; const piAttribList: PGLint): Boolean; stdcall;
  {$EndIf}

  {$ifdef WGL_ARB_create_context}
  wglCreateContextAttribsARB: function(hDC: HDC; hShareContext: HGLRC; const attribList: PGLint): HGLRC; stdcall;
  {$EndIf}

  {$IfDef WGL_AMD_gpu_association}
  wglGetGPUIDsAMD: function(maxCount: Cardinal; ids: PCardinal): Cardinal; stdcall;
  wglGetGPUInfoAMD: function(id: Cardinal; property_: Integer; dataType: GLenum; size: Cardinal; data: Pointer): Integer; stdcall;
  wglGetContextGPUIDAMD: function(hglrc: HGLRC): Cardinal; stdcall;
  wglCreateAssociatedContextAMD: function(id: Cardinal): HGLRC; stdcall;
  wglCreateAssociatedContextAttribsAMD: function(id: Cardinal; hShareContext: HGLRC; const attribList: PInteger): HGLRC; stdcall;
  wglDeleteAssociatedContextAMD: function(hglrc: HGLRC): Boolean; stdcall;
  wglMakeAssociatedContextCurrentAMD: function(hglrc: HGLRC): Boolean; stdcall;
  wglGetCurrentAssociatedContextAMD: function(): HGLRC; stdcall;
  wglBlitContextFramebufferAMD: procedure(dstCtx: HGLRC; srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); stdcall;
  {$EndIf}

  {$IfDef WGL_EXT_display_color_table}
  wglCreateDisplayColorTableEXT: function(id: GLushort): GLboolean; stdcall;
  wglLoadDisplayColorTableEXT: function(const table: PGLushort; length: GLuint): GLboolean; stdcall;
  wglBindDisplayColorTableEXT: function(id: GLushort): GLboolean; stdcall;
  wglDestroyDisplayColorTableEXT: procedure(id: GLushort); stdcall;
  {$EndIf}

  {$IfDef WGL_EXT_extensions_string}
//  wglGetExtensionsStringEXT: function(): PAnsiChar{PChar}; stdcall;
  {$EndIf}

  {$IfDef WGL_EXT_make_current_read}
//  wglMakeContextCurrentEXT: function(hDrawDC: HDC; hReadDC: HDC; hglrc: HGLRC): Boolean; stdcall;
//  wglGetCurrentReadDCEXT: function(): HDC; stdcall;
  {$EndIf}

  {$ifdef WGL_EXT_pbuffer}
//  wglCreatePbufferEXT: function(hDC: HDC; iPixelFormat: GLint; iWidth: GLint; iHeight: GLint; const piAttribList: PGLint): HPBUFFEREXT; stdcall;
//  wglGetPbufferDCEXT: function(hPbuffer: HPBUFFEREXT): HDC; stdcall;
//  wglReleasePbufferDCEXT: function(hPbuffer: HPBUFFEREXT; hDC: HDC): GLint; stdcall;
//  wglDestroyPbufferEXT: function(hPbuffer: HPBUFFEREXT): Boolean; stdcall;
//  wglQueryPbufferEXT: function(hPbuffer: HPBUFFEREXT; iAttribute: GLint; piValue: PGLint): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_EXT_pixel_format}
//  wglGetPixelFormatAttribivEXT: function(hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; piAttributes: PGLint; piValues: PGLint): Boolean; stdcall;
//  wglGetPixelFormatAttribfvEXT: function(hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; piAttributes: PGLint; pfValues: PGLfloat): Boolean; stdcall;
//  wglChoosePixelFormatEXT: function(hdc: HDC; const piAttribIList: PGLint; const pfAttribFList: PGLfloat; nMaxFormats: GLuint; piFormats: PGLint; nNumFormats: PGLuint): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_I3D_digital_video_control}
  wglGetDigitalVideoParametersI3D: function(hDC: HDC; iAttribute: GLint; piValue: PGLint): Boolean; stdcall;
  wglSetDigitalVideoParametersI3D: function(hDC: HDC; iAttribute: GLint; const piValue: PGLint): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_I3D_gamma}
  wglGetGammaTableParametersI3D: function(hDC: HDC; iAttribute: GLint; piValue: PGLint): Boolean; stdcall;
  wglSetGammaTableParametersI3D: function(hDC: HDC; iAttribute: GLint; const piValue: PGLint): Boolean; stdcall;
  wglGetGammaTableI3D: function(hDC: HDC; iEntries: GLint; puRed: PGLushort; puGreen: PGLushort; puBlue: PGLushort): Boolean; stdcall;
  wglSetGammaTableI3D: function(hDC: HDC; iEntries: GLint; const puRed: PGLushort; const puGreen: PGLushort; const puBlue: PGLushort): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_I3D_genlock}
  wglEnableGenlockI3D: function(hDC: HDC): Boolean; stdcall;
  wglDisableGenlockI3D: function(hDC: HDC): Boolean; stdcall;
  wglIsEnabledGenlockI3D: function(hDC: HDC; pFlag: Boolean): Boolean; stdcall;
  wglGenlockSourceI3D: function(hDC: HDC; uSource: GLuint): Boolean; stdcall;
  wglGetGenlockSourceI3D: function(hDC: HDC; uSource: PGLuint): Boolean; stdcall;
  wglGenlockSourceEdgeI3D: function(hDC: HDC; uEdge: GLuint): Boolean; stdcall;
  wglGetGenlockSourceEdgeI3D: function(hDC: HDC; uEdge: PGLuint): Boolean; stdcall;
  wglGenlockSampleRateI3D: function(hDC: HDC; uRate: GLuint): Boolean; stdcall;
  wglGetGenlockSampleRateI3D: function(hDC: HDC; uRate: PGLuint): Boolean; stdcall;
  wglGenlockSourceDelayI3D: function(hDC: HDC; uDelay: GLuint): Boolean; stdcall;
  wglGetGenlockSourceDelayI3D: function(hDC: HDC; uDelay: PGLuint): Boolean; stdcall;
  wglQueryGenlockMaxSourceDelayI3D: function(hDC: HDC; uMaxLineDelay: PGLuint; uMaxPixelDelay: PGLuint): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_I3D_image_buffer}
  wglCreateImageBufferI3D: function(hDC: HDC; dwSize: GLuint; uFlags: GLuint): GLvoid; stdcall;
  wglDestroyImageBufferI3D: function(hDC: HDC; pAddress: GLvoid): Boolean; stdcall;
  wglAssociateImageBufferEventsI3D: function(hDC: HDC; const pEvent: THandle; const pAddress: PGLvoid; const pSize: PGLuint; count: GLuint): Boolean; stdcall;
  wglReleaseImageBufferEventsI3D: function(hDC: HDC; const pAddress: PGLvoid; count: GLuint): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_I3D_swap_frame_lock}
  wglEnableFrameLockI3D: function(): Boolean; stdcall;
  wglDisableFrameLockI3D: function(): Boolean; stdcall;
  wglIsEnabledFrameLockI3D: function(pFlag: Boolean): Boolean; stdcall;
  wglQueryFrameLockMasterI3D: function(pFlag: Boolean): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_I3D_swap_frame_usage}
  wglGetFrameUsageI3D: function(pUsage: PGLfloat): Boolean; stdcall;
  wglBeginFrameTrackingI3D: function(): Boolean; stdcall;
  wglEndFrameTrackingI3D: function(): Boolean; stdcall;
  wglQueryFrameTrackingI3D: function(pFrameCount: PGLuint; pMissedFrames: PGLuint; pLastMissedUsage: PGLfloat): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_NV_vertex_array_range}
  wglAllocateMemoryNV: procedure(size: GLsizei; readfreq: GLfloat; writefreq: GLfloat; priority: GLfloat); stdcall;
  wglFreeMemoryNV: procedure(_pointer: Pointer); stdcall;
  {$EndIf}

  {$IfDef WGL_NV_present_video}
  wglEnumerateVideoDevicesNV: function(hdc: HDC; phDeviceList: PHVIDEOOUTPUTDEVICENV): Integer; stdcall;
  wglBindVideoDeviceNV: function(hd: HDC; uVideoSlot: Cardinal; hVideoDevice: HVIDEOOUTPUTDEVICENV; piAttribList: PInteger): Boolean; stdcall;
  wglQueryCurrentContextNV: function(iAttribute: Integer; piValue: PInteger): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_NV_video_output}
  wglGetVideoDeviceNV: function(hDC: HDC; numDevices: Integer; hVideoDevice: PHPVIDEODEV): Boolean; stdcall;
  wglReleaseVideoDeviceNV: function(hVideoDevice: HPVIDEODEV): Boolean; stdcall;
  wglBindVideoImageNV: function(hVideoDevice: HPVIDEODEV; hPbuffer: THandle; iVideoBuffer: Integer): Boolean; stdcall;
  wglReleaseVideoImageNV: function(hPbuffer: THandle; iVideoBuffer: Integer): Boolean; stdcall;
  wglSendPbufferToVideoNV: function(hPbuffer: THandle; iBufferType: Integer; pulCounterPbuffer: PCardinal; bBlock: Boolean): Boolean; stdcall;
  wglGetVideoInfoNV: function(hpVideoDevice: HPVIDEODEV; pulCounterOutputPbuffer: PCardinal; pulCounterOutputVideo: PCardinal): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_NV_swap_group}
  wglJoinSwapGroupNV: function(hDC: HDC; group: GLuint): Boolean; stdcall;
  wglBindSwapBarrierNV: function(group: GLuint; barrier: GLuint): Boolean; stdcall;
  wglQuerySwapGroupNV: function(hDC: HDC; group: PGLuint; barrier: PGLuint): Boolean; stdcall;
  wglQueryMaxSwapGroupsNV: function(hDC: HDC; mxGroups: PGLuint; maxBarriers: PGLuint): Boolean; stdcall;
  wglQueryFrameCountNV: function(hDC: HDC; count: PGLuint): Boolean; stdcall;
  wglResetFrameCountNV: function(hDC: HDC): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_NV_gpu_affinity}
  wglEnumGpusNV: function(iGpuIndex: Cardinal; phGpu: PHGPUNV): Boolean; stdcall;
  wglEnumGpuDevicesNV: function(hGpu: HGPUNV; iDeviceIndex: Cardinal; lpGpuDevice: PGPU_DEVICE): Boolean; stdcall;
  wglCreateAffinityDCNV: function(const phGpuList: PHGPUNV): HDC; stdcall;
  wglEnumGpusFromAffinityDCNV: function(hAffinityDC: HDC; iGpuIndex: Cardinal; hGpu: PHGPUNV): Boolean; stdcall;
  wglDeleteDCNV: function(hDC: HDC): Boolean; stdcall;
  {$EndIf}

  {$ifdef WGL_NV_video_capture}
  wglBindVideoCaptureDeviceNV: function(uVideoSlot: Cardinal; hDevice: HVIDEOINPUTDEVICENV): Boolean; stdcall;
  wglEnumerateVideoCaptureDevicesNV: function(hDc: HDC; phDeviceList: PHVIDEOINPUTDEVICENV): Cardinal; stdcall;
  wglLockVideoCaptureDeviceNV: function(hDc: HDC; hDevice: HVIDEOINPUTDEVICENV): Boolean; stdcall;
  wglQueryVideoCaptureDeviceNV: function(hDc: HDC; hDevice: HVIDEOINPUTDEVICENV; iAttribute: Integer; piValue: PInteger): Boolean; stdcall;
  wglReleaseVideoCaptureDeviceNV: function(hDc: HDC; hDevice: HVIDEOINPUTDEVICENV): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_NV_copy_image}
  wglCopyImageSubDataNV: function(hSrcRc: HGLRC; srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; hDstRC: HGLRC; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei): Boolean; stdcall;
  {$EndIf}

  {$ifdef WGL_NV_delay_before_swap}
  wglDelayBeforeSwapNV: function (hDC:HDC; seconds:GLfloat): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_NV_DX_interop}
  wglDXSetResourceShareHandleNV: function(dxObject : PGLVoid; hareHandle : Cardinal) : Boolean; stdcall;
  wglDXOpenDeviceNV: function(dxDevice : PGLVoid) : Cardinal; stdcall;
  wglDXCloseDeviceNV: function(hDevice : Cardinal) : Boolean; stdcall;
  wglDXRegisterObjectNV: function(hDevice : Cardinal; dxObject : PGLVoid; name : GLUInt; _type : GLEnum; access : GLenum) : Cardinal; stdcall;
  wglDXUnregisterObjectNV: function(hDevice : Cardinal; hObject : Cardinal) : Boolean; stdcall;
  wglDXObjectAccessNV: function(hObject : Cardinal; access : GLenum) : Boolean; stdcall;
  wglDXLockObjectsNV: function(hDevice : Cardinal; count : GLint; hObjects : PCardinal) : Boolean; stdcall;
  wglDXUnlockObjectsNV: function (hDevice : Cardinal; count : GLint; hObjects : PCardinal) : Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_OML_sync_control}
  wglGetSyncValuesOML: function(hdc: HDC; ust: PGLint64; msc: PGLint64; sbc: PGLint64): Boolean; stdcall;
  wglGetMscRateOML: function(hdc: HDC; numerator: PGLint; denominator: PGLint): Boolean; stdcall;
  wglSwapBuffersMscOML: function(hdc: HDC; target_msc: GLint64; divisor: GLint64; remainder: GLint64): GLint64; stdcall;
  wglSwapLayerBuffersMscOML: function(hdc: HDC; fuPlanes: GLint; target_msc: GLint64; divisor: GLint64; remainder: GLint64): GLint64; stdcall;
  wglWaitForMscOML: function(hdc: HDC; target_msc: GLint64; divisor: GLint64; remainder: GLint64; ust: PGLint64; msc: PGLint64; sbc: PGLint64): Boolean; stdcall;
  wglWaitForSbcOML: function(hdc: HDC; target_sbc: GLint64; ust: PGLint64; msc: PGLint64; sbc: PGLint64): Boolean; stdcall;
  {$EndIf}

  {$IfDef WGL_3DL_stereo_control}
  wglSetStereoEmitterState3DL: function(hDC: HDC; uState: UINT): Boolean; stdcall;
  {$EndIf}
  // WIN_draw_range_elements        узнать что это за функции и здесь ли они должны быть?
//  glDrawRangeElementsWIN = procedure(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall;

  // WIN_swap_hint
//  glAddSwapHintRectWIN = procedure(x: GLint; y: GLint; width: GLsizei; height: GLsizei); stdcall;
{$EndIf}

{$IfDef LINUX}
var
  GLX_VERSION_1_3: Boolean;
  GLX_VERSION_1_4: Boolean;

  // ZenGL ++
  GLX_SGIX_fbconfig: boolean;
  GLX_SGIX_pbuffer: boolean;
  GLX_SGI_swap_control: boolean;
  {$IFDEF GL_VERSION_3_0}
  GLX_ARB_create_context: boolean;
  {$ENDIF}
  {$IfDef USE_FULL_GLX}
  GLX_ARB_context_flush_control: Boolean;
  GLX_ARB_create_context_no_error: boolean;
  GLX_ARB_create_context_profile: boolean;
  GLX_ARB_create_context_robustness: boolean;
  GLX_ARB_fbconfig_float: boolean;
  GLX_ARB_framebuffer_sRGB: boolean;
  GLX_ARB_get_proc_address: boolean;
  GLX_ARB_multisample: boolean;
  GLX_ARB_robustness_application_isolation: boolean;
  GLX_ARB_robustness_share_group_isolation: boolean;
  GLX_ARB_vertex_buffer_object: boolean;
  GLX_3DFX_multisample: boolean;
  GLX_AMD_gpu_association: boolean;
  GLX_EXT_buffer_age: boolean;
  GLX_EXT_context_priority: boolean;
  GLX_EXT_create_context_es2_profile: boolean;
  GLX_EXT_create_context_es_profile: boolean;
  GLX_EXT_fbconfig_packed_float: boolean;
  GLX_EXT_framebuffer_sRGB: boolean;
  GLX_EXT_get_drawable_type: boolean;
  GLX_EXT_import_context: boolean;
  GLX_EXT_libglvnd: boolean;
  GLX_EXT_no_config_context: boolean;
  GLX_EXT_stereo_tree: boolean;
  GLX_EXT_swap_control: boolean;
  GLX_EXT_swap_control_tear: boolean;
  GLX_EXT_texture_from_pixmap: Boolean;
  GLX_EXT_visual_info: boolean;
  GLX_EXT_visual_rating: boolean;
  GLX_INTEL_swap_event: boolean;
  GLX_MESA_agp_offset: boolean;
  GLX_MESA_copy_sub_buffer: boolean;
  GLX_MESA_pixmap_colormap: boolean;
  GLX_MESA_query_renderer: boolean;
  GLX_MESA_release_buffers: boolean;
  GLX_MESA_set_3dfx_mode: boolean;
  GLX_MESA_swap_control: boolean;
  GLX_NV_copy_buffer: boolean;
  GLX_NV_copy_image: boolean;
  GLX_NV_delay_before_swap: boolean;
  GLX_NV_float_buffer: boolean;
  GLX_NV_multigpu_context: boolean;
  GLX_NV_multisample_coverage: boolean;
  GLX_NV_present_video: boolean;
  GLX_NV_robustness_video_memory_purge: boolean;
  GLX_NV_swap_group: boolean;
  GLX_NV_video_capture: boolean;
  GLX_NV_video_out: boolean;
  GLX_OML_swap_method: boolean;
  GLX_OML_sync_control: boolean;
  GLX_SGIS_blended_overlay: boolean;
  GLX_SGIS_multisample: boolean;
  GLX_SGIS_shared_multisample: boolean;
  GLX_SGIX_dmbuffer: boolean;
  GLX_SGIX_hyperpipe: boolean;
  GLX_SGIX_swap_barrier: boolean;
  GLX_SGIX_swap_group: boolean;
  GLX_SGIX_video_resize: boolean;
  GLX_SGIX_video_source: boolean;
  GLX_SGIX_visual_select_group: boolean;
  GLX_SGI_cushion: boolean;
  GLX_SGI_make_current_read: boolean;
  GLX_SGI_video_sync: boolean;
  GLX_SUN_get_transparent_index: boolean;
//  GLX_SGIX_fbconfig: boolean;
//  GLX_SGIX_pbuffer: boolean;
//  GLX_SGI_swap_control: boolean;
  {$EndIf}

  // GLX_VERSION_1_0
  glXChooseVisual: function(dpy: PDisplay; screen: Integer; attribList: PInteger): PXVisualInfo; cdecl;
  glXCreateContext: function(dpy: PDisplay; vis: PXVisualInfo; shareList: GLXContext; direct: GLBoolean): GLXContext; cdecl;
  glXDestroyContext: procedure(dpy: PDisplay; ctx: GLXContext); cdecl;
  glXMakeCurrent: function(dpy: PDisplay; drawable: GLXDrawable; ctx: GLXContext): Boolean; cdecl;
  glXSwapBuffers: procedure(dpy: PDisplay; drawable: GLXDrawable); cdecl;
  glXQueryExtension: function(dpy: PDisplay; out errorb, event: Integer): Boolean; cdecl;
  // возвращаем версию GLX
  glXQueryVersion: function(dpy: PDisplay; out major, minor: Integer): Boolean; cdecl;
  glXIsDirect: function(dpy: PDisplay; ctx: GLXContext): Boolean; cdecl;
  // GLX_VERSION_1_1
  // вернуть строку - GLX_VENDOR , GLX_VERSION или GLX_EXTENSIONS.
  glXQueryServerString: function(dpy: PDisplay; screen: Integer; name: Integer): PAnsiChar; cdecl;
  // GLX_VERSION_1_3
  glXGetFBConfigAttrib: function(dpy: PDisplay; config: GLXFBConfig; attribute: GLint; var value: GLint): glint; cdecl;
  // создание нового контекста рендеринга GLX
  glXCreateNewContext: function(dpy: PDisplay; config: GLXFBConfig; render_type: GLint; share_list: GLXContext; direct: GLboolean): GLXContext cdecl;
{$IfDef USE_FULL_GLX}
// Rus: Важно знать, это полная версия переведённая библиотека GLX для ZenGL.
//      Вы можете использовать вместо этого модуля модуль GLX.
// Eng: It is important to know, this is the full version of the translated GLX
//      library for ZenGL. You can use the GLX module instead.
  // GLX_VERSION_1_0
  glXCopyContext: procedure(dpy: PDisplay; src: GLXContext; dst: GLXContext; mask: GLuint); cdecl;
  glXCreateGLXPixmap: function(dpy: PDisplay; vis: PXVisualInfo; pixmap: XPixmap): GLXPixmap cdecl;
  glXDestroyGLXPixmap: procedure(dpy: PDisplay; pix: GLXPixmap); cdecl;
  glXGetConfig: function(dpy: PDisplay; vis: PXVisualInfo; attrib: GLint; value: PGLint): GLint; cdecl;
  glXGetCurrentContext: function: GLXContext; cdecl;
  glXGetCurrentDrawable: function: GLXDrawable; cdecl;
  glXUseXFont: procedure(font: XFont; first: GLint; count: GLint; listBase: GLint); cdecl;
  glXWaitGL: procedure; cdecl;
  glXWaitX: procedure; cdecl;
  // GLX_VERSION_1_1
  glXGetClientString: function(dpy: PDisplay; name: GLint): PGLchar; cdecl;
  glXQueryExtensionsString: function(dpy: PDisplay; screen: GLint): PGLchar; cdecl;
  {$IfDef GLX_VERSION_1_3}            // - http://code.nabla.net/doc/OpenGL/index_man1.html
  glXGetFBConfigs: function(dpy: PDisplay; screen: GLint; var nelements: GLint): PGLXFBConfig; cdecl;

  // создание области рендеринга на экране
  glXCreateWindow: function(dpy: PDisplay; config: GLXFBConfig; win: XWindow; attrib_list: PGLint): GLXWindow; cdecl;
  // уничтожение области рендеринга
  glXDestroyWindow: procedure(dpy: PDisplay; win: GLXWindow); cdecl;
  // создание области рендеринга вне экрана (вне окна? или вообще не на экране?)
  glXCreatePixmap: function(dpy: PDisplay; config: GLXFBConfig; pixmap: XPixmap; attrib_list: PGLint): GLXPixmap; cdecl;
  // уничтожение области рендеринга вне экрана
  glXDestroyPixmap: procedure(dpy: PDisplay; pixmap: GLXPixmap); cdecl;
  // возвращает атрибут, связанный с возможностью рисования GLX
  glXQueryDrawable: procedure(dpy: PDisplay; draw: GLXDrawable; attribute: GLint; value: PGLuint); cdecl;
  // связывание контекста GLX с окном
  glXMakeContextCurrent: function(display: PDisplay; draw: GLXDrawable; read_: GLXDrawable; ctx: GLXContext): GLboolean; cdecl;
  // вернуть текущий (контекст?) доступный для рисования
  glXGetCurrentReadDrawable: function: GLXDrawable; cdecl;
        // вернуть текущее окно?  Удалена???
//        glXGetCurreentDisplay: function: PDisplay; cdecl;
  // информация о контексте запроса
  glXQueryContext: function(dpy: PDisplay; ctx: GLXContext; attribute: GLint; value: PGLint): GLint; cdecl;
  // устанавливаем маску события GLX для пиксельного буфера или окна
  glXSelectEvent: procedure(dpy: PDisplay; draw: GLXDrawable; event_mask: GLuint); cdecl;
  // возвращаем маску события выбранного для рисования
  glXGetSelectedEvent: procedure(dpy: PDisplay; draw: GLXDrawable; event_mask: PGLuint); cdecl;
  {$EndIf}
{$EndIf}

  {$ifdef GLX_ARB_create_context}
  glXCreateContextAttribsARB: function(dpy: PDisplay; config: GLXFBConfig; share_context: GLXContext; direct: boolean; const attrib_list: PGLint): GLXContext; cdecl;
  {$EndIf}

  {$ifdef GLX_AMD_gpu_association}
  glXGetGPUIDsAMD: function(maxCount: dword; ids: Pdword): dword; cdecl;
  glXGetGPUInfoAMD: function(id: dword; _property: longint; dataType: GLenum; size: dword; data: pointer): longint; cdecl;
  glXGetContextGPUIDAMD: function(ctx: GLXContext): dword; cdecl;
  glXCreateAssociatedContextAMD: function(id: dword; share_list: GLXContext): GLXContext; cdecl;
  glXCreateAssociatedContextAttribsAMD: function(id: dword; share_context: GLXContext; attribList: Plongint): GLXContext; cdecl;
  glXDeleteAssociatedContextAMD: function(ctx: GLXContext): Boolean; cdecl;
  glXMakeAssociatedContextCurrentAMD: function(ctx: GLXContext): Boolean; cdecl;
  glXGetCurrentAssociatedContextAMD: function: GLXContext; cdecl;
  glXBlitContextFramebufferAMD: procedure(dstCtx: GLXContext; srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1: GLint; mask: GLbitfield; filter: GLenum); cdecl;
  {$EndIf}

  {$ifdef GLX_EXT_import_context}
  glXGetCurrentDisplayEXT: function: PDisplay; cdecl;
  glXQueryContextInfoEXT: function(dpy: PDisplay; context: GLXContext; attribute: GLint; value: PGLint): GLint; cdecl;
  glXGetContextIDEXT: function(const context: GLXContext): GLXContextID; cdecl;
  glXImportContextEXT: function(dpy: PDisplay; contextID: GLXContextID): GLXContext; cdecl;
  glXFreeContextEXT: procedure(dpy: PDisplay; context: GLXContext); cdecl;
  {$EndIf}

  {$ifdef GLX_EXT_texture_from_pixmap}
  glXBindTexImageEXT: procedure(dpy: PDisplay; drawable: GLXDrawable; buffer: GLint; const attrib_list: PGLint); cdecl;
  glXReleaseTexImageEXT: procedure(dpy: PDisplay; drawable: GLXDrawable; buffer: GLint); cdecl;
  {$EndIf}

  {$ifdef GLX_EXT_swap_control}
  glXSwapIntervalEXT: procedure(dpy : PDisplay; drawable : GLXDrawable; interval : GLint); cdecl;
  {$EndIf}

  {$ifdef GLX_MESA_agp_offset}
  glXGetAGPOffsetMESA: function(pointer: pointer): dword; cdecl;
  {$endif}

  {$ifdef GLX_MESA_pixmap_colormap}
  glXCreateGLXPixmapMESA: function(dpy: PDisplay; visual: PXVisualInfo; pixmap: XPixmap; cmap: XColormap): GLXPixmap; cdecl;
  {$EndIf}

  {$ifdef GLX_MESA_query_renderer}
  glXQueryCurrentRendererIntegerMESA: function(attribute: longint; value: Pdword): Boolean; cdecl;
  glXQueryCurrentRendererStringMESA: function(attribute:longint): Pchar; cdecl;
  glXQueryRendererIntegerMESA: function(dpy: PDisplay; screen: longint; renderer: longint; attribute: longint; value: Pdword): Boolean; cdecl;
  glXQueryRendererStringMESA: function(dpy: PDisplay; screen: longint; renderer: longint; attribute: longint): Pchar; cdecl;
  {$EndIf}

  {$ifdef GLX_MESA_swap_control}
  glXSwapIntervalMESA: function(interval: cuint): cint; cdecl;
  glXGetSwapIntervalMESA: function: cint; cdecl;
  {$EndIf}

  // Unknown Mesa GLX extension (undocumented in current GLX C headers?)
  {$ifdef GLX_MESA_release_buffers}
  glXReleaseBuffersMESA: function(dpy: PDisplay; d: GLXDrawable): TBoolResult; cdecl;
  {$EndIf}

  {$ifdef GLX_MESA_copy_sub_buffer}
  glXCopySubBufferMESA: procedure(dpy: PDisplay; drawable: GLXDrawable; x, y, width, height: cint); cdecl;
  {$EndIf}

  {$ifdef GLX_MESA_set_3dfx_mode}
  glXSet3DfxModeMESA: function(mode: GLint): GLboolean; cdecl;
  {$EndIf}

  {$ifdef GLX_NV_copy_buffer}
  glXCopyBufferSubDataNV: procedure(dpy: PDisplay; readCtx, writeCtx: GLXContext; readTarget, writeTarget: GLenum; readOffset, writeOffset: GLintptr; size: GLsizeiptr); cdecl;
  glXNamedCopyBufferSubDataNV: procedure(dpy: PDisplay; readCtx, writeCtx: GLXContext; readBuffer, writeBuffer: GLuint; readOffset, writeOffset: GLintptr; size: GLsizeiptr); cdecl;
  {$endif}

  {$ifdef GLX_NV_copy_image}
  glXCopyImageSubDataNV: procedure(dpy: PDisplay; srcCtx: GLXContext; srcName: GLuint; srcTarget: GLenum; srcLevel, srcX, srcY, srcZ: GLint; dstCtx: GLXContext; dstName: GLuint; dstTarget: GLenum; dstLevel, dstX, dstY, dstZ: GLint; width, height, depth: GLsizei); cdecl;
  {$endif}

  {$ifdef GLX_NV_delay_before_swap}
  glXDelayBeforeSwapNV: function(dpy: PDisplay; drawable: GLXDrawable; seconds: GLfloat): Boolean; cdecl;
  {$endif}

  {$ifdef GLX_NV_present_video}
  glXEnumerateVideoDevicesNV: function(dpy: PDisplay; screen: longint; nelements: Plongint): Pdword; cdecl;
  glXBindVideoDeviceNV: function(dpy: PDisplay; video_slot: dword; video_device: dword; attrib_list: Plongint): longint; cdecl;
  {$EndIf}

  {$ifdef GLX_NV_swap_group}
  glXJoinSwapGroupNV: function(dpy: PDisplay; drawable: GLXDrawable; group: GLuint): Boolean; cdecl;
  glXBindSwapBarrierNV: function(dpy: PDisplay; group: GLuint; barrier: GLuint): Boolean; cdecl;
  glXQuerySwapGroupNV: function(dpy: PDisplay; drawable: GLXDrawable; group: PGLuint; barrier: PGLuint): Boolean; cdecl;
  glXQueryMaxSwapGroupsNV: function(dpy: PDisplay; screen: longint; maxGroups: PGLuint; maxBarriers: PGLuint): Boolean; cdecl;
  glXQueryFrameCountNV: function(dpy: PDisplay; screen: longint; count: PGLuint): Boolean; cdecl;
  glXResetFrameCountNV: function(dpy: PDisplay; screen: longint):Boolean; cdecl;
  {$endif}

  {$ifdef GLX_NV_video_capture}
  glXBindVideoCaptureDeviceNV: function(dpy: PDisplay; video_capture_slot: dword; device: GLXVideoCaptureDeviceNV): longint; cdecl;
  glXEnumerateVideoCaptureDevicesNV: function(dpy: PDisplay; screen: longint; nelements: Plongint): PGLXVideoCaptureDeviceNV; cdecl;
  glXLockVideoCaptureDeviceNV: procedure(dpy: PDisplay; device: GLXVideoCaptureDeviceNV); cdecl;
  glXQueryVideoCaptureDeviceNV: function(dpy: PDisplay; device: GLXVideoCaptureDeviceNV; attribute: longint; value: Plongint): longint; cdecl;
  glXReleaseVideoCaptureDeviceNV: procedure(dpy: PDisplay; device: GLXVideoCaptureDeviceNV); cdecl;
  {$EndIf}

  {$ifdef GLX_NV_video_out}
  glXGetVideoDeviceNV: function(dpy: PDisplay; screen: longint; numVideoDevices: longint; pVideoDevice: PGLXVideoDeviceNV): longint; cdecl;
  glXReleaseVideoDeviceNV: function(dpy: PDisplay; screen: longint; VideoDevice: GLXVideoDeviceNV): longint; cdecl;
  glXBindVideoImageNV: function(dpy: PDisplay; VideoDevice: GLXVideoDeviceNV; pbuf: GLXPbuffer; iVideoBuffer: longint): longint; cdecl;
  glXReleaseVideoImageNV: function(dpy: PDisplay; pbuf: GLXPbuffer): longint; cdecl;
  glXSendPbufferToVideoNV: function(dpy: PDisplay; pbuf: GLXPbuffer; iBufferType: longint; pulCounterPbuffer: Pdword; bBlock: GLboolean): longint; cdecl;
  glXGetVideoInfoNV: function(dpy: PDisplay; screen: longint; VideoDevice: GLXVideoDeviceNV; pulCounterOutputPbuffer: Pdword; pulCounterOutputVideo: Pdword): longint; cdecl;
  {$EndIf}

  {$ifdef GLX_OML_sync_control}
  glXGetSyncValuesOML: function(dpy: PDisplay; drawable: GLXDrawable; ust: Pint64_t; msc: Pint64_t; sbc: Pint64_t): Boolean; cdecl;
  glXGetMscRateOML: function(dpy: PDisplay; drawable: GLXDrawable; numerator: Pint32_t; denominator: Pint32_t):Boolean; cdecl;
  glXSwapBuffersMscOML: function(dpy: PDisplay; drawable: GLXDrawable; target_msc: int64_t; divisor: int64_t; remainder: int64_t): int64_t; cdecl;
  glXWaitForMscOML: function(dpy: PDisplay; drawable: GLXDrawable; target_msc: int64_t; divisor: int64_t; remainder: int64_t; ust: Pint64_t; msc: Pint64_t; sbc: Pint64_t): Boolean; cdecl;
  glXWaitForSbcOML: function(dpy: PDisplay; drawable: GLXDrawable; target_sbc: int64_t; ust: Pint64_t; msc: Pint64_t; sbc: Pint64_t): Boolean; cdecl;
  {$EndIf}

  {$ifdef GLX_SGIX_dmbuffer}     // dm_buffer.h застрелитесь - Digital media
  glXAssociateDMPbufferSGIX: function(dpy: PDisplay; pbuffer: GLXPbufferSGIX; params: PDMparams; dmbuffer: DMbuffer): Boolean; cdecl;
  {$EndIf}

  {$ifdef GLX_SGIX_fbconfig}
  glXGetFBConfigAttribSGIX: function(dpy: PDisplay; config: GLXFBConfigSGIX; attribute: longint; var value: longint): longint; cdecl;
  glXChooseFBConfigSGIX: function(dpy: PDisplay; screen: longint; attrib_list: Plongint; var nelements: longint): PGLXFBConfigSGIX; cdecl;
  glXCreateGLXPixmapWithConfigSGIX: function(dpy: PDisplay; config: GLXFBConfigSGIX; pixmap: XPixmap): GLXPixmap; cdecl;
  glXCreateContextWithConfigSGIX: function(dpy: PDisplay; config: GLXFBConfigSGIX; render_type: longint; share_list: GLXContext; direct: Boolean): GLXContext; cdecl;
  glXGetVisualFromFBConfigSGIX: function(dpy: PDisplay; config: GLXFBConfigSGIX): PXVisualInfo; cdecl;
  glXGetFBConfigFromVisualSGIX: function(dpy: PDisplay; vis: PXVisualInfo): GLXFBConfigSGIX; cdecl;
  {$EndIf}

  {$ifdef GLX_SGIX_hyperpipe}
  glXQueryHyperpipeNetworkSGIX: function(dpy: PDisplay; npipes: Plongint): PGLXHyperpipeNetworkSGIX; cdecl;
  glXHyperpipeConfigSGIX: function(dpy: PDisplay; networkId: longint; npipes: longint; cfg: PGLXHyperpipeConfigSGIX; hpId: Plongint): longint; cdecl;
  glXQueryHyperpipeConfigSGIX: function(dpy: PDisplay; hpId: longint; npipes: Plongint): PGLXHyperpipeConfigSGIX; cdecl;
  glXDestroyHyperpipeConfigSGIX: function(dpy: PDisplay; hpId: longint): longint; cdecl;
  glXBindHyperpipeSGIX: function(dpy: PDisplay; hpId: longint): longint; cdecl;
  glXQueryHyperpipeBestAttribSGIX: function(dpy: PDisplay; timeSlice: longint; attrib: longint; size: longint; attribList: pointer; returnAttribList: pointer): longint; cdecl;
  glXHyperpipeAttribSGIX: function(dpy: PDisplay; timeSlice: longint; attrib: longint; size: longint; attribList: pointer): longint; cdecl;
  glXQueryHyperpipeAttribSGIX: function(dpy: PDisplay; timeSlice: longint; attrib: longint; size: longint; returnAttribList: pointer): longint; cdecl;
  {$EndIf}

  {$ifdef GLX_SGIX_swap_barrier}
  glXBindSwapBarrierSGIX: procedure(dpy: PDisplay; drawable: GLXDrawable; barrier: longint); cdecl;
  glXQueryMaxSwapBarriersSGIX: function(dpy: PDisplay; screen: longint; max: Plongint): Boolean; cdecl;
  {$endif}

  {$ifdef GLX_SGIX_swap_group}
  glXJoinSwapGroupSGIX: procedure(dpy: PDisplay; drawable: GLXDrawable; member: GLXDrawable); cdecl;
  {$endif}

  {$ifdef GLX_SGIX_video_resize}
  glXBindChannelToWindowSGIX: function(display: PDisplay; screen: longint; channel: longint; window: XWindow): longint; cdecl;
  glXChannelRectSGIX: function(display: PDisplay; screen: longint; channel: longint; x: longint; y: longint; w: longint; h: longint): longint; cdecl;
  glXQueryChannelRectSGIX: function(display: PDisplay; screen: longint; channel: longint; dx: Plongint; dy: Plongint; dw: Plongint; dh: Plongint): longint; cdecl;
  glXQueryChannelDeltasSGIX: function(display: PDisplay; screen: longint; channel: longint; x: Plongint; y: Plongint; w: Plongint; h: Plongint): longint; cdecl;
  glXChannelRectSyncSGIX: function(display: PDisplay; screen: longint; channel: longint; synctype: GLenum): longint; cdecl;
  {$EndIf}

  {$ifdef GLX_SGIX_video_source}       // afs_vl.h     https://wiki.gentoo.org/wiki/OpenAFS#What_is_AFS.3F
  glXCreateGLXVideoSourceSGIX: function(display: PDisplay; screen: longint; server: VLServer; path: VLPath; nodeClass: longint; drainNode: VLNode): GLXVideoSourceSGIX; cdecl;
  glXDestroyGLXVideoSourceSGIX: procedure(dpy: PDisplay; glxvideosource: GLXVideoSourceSGIX); cdecl;
  {$EndIf}

  {$ifdef GLX_SGI_cushion}
  glXCushionSGI: procedure(dpy: PDisplay; window: XWindow; cushion: single); cdecl;
  {$endif}

  {$ifdef GLX_SGI_make_current_read}
  glXMakeCurrentReadSGI: function(dpy: PDisplay; draw: GLXDrawable; read: GLXDrawable; ctx: GLXContext): Boolean; cdecl;
  glXGetCurrentReadDrawableSGI: function: GLXDrawable; cdecl;
  {$endif}

  {$ifdef GLX_SGI_video_sync}
  glXGetVideoSyncSGI: function(var count: cuint): cint; cdecl;
  glXWaitVideoSyncSGI: function(divisor, remainder: cint; var count: cuint): cint; cdecl;
  {$EndIf}

  {$ifdef GLX_SUN_get_transparent_index}
  glXGetTransparentIndexSUN: function(dpy: PDisplay; overlay: XWindow; underlay: XWindow; pTransparentIndex: Pdword): Integer {Status}; cdecl;
  {$endif}

  {$If defined(GLX_VERSION_1_4) or defined(GLX_ARB_get_proc_address)}
  glXGetProcAddressARB: function(name: PAnsiChar): Pointer; cdecl;
  {$IfEnd}
  {$IfDef GLX_SGI_swap_control}
  glXSwapIntervalSGI: function(interval: Integer): Integer; cdecl;
  {$EndIf}
  // 1.3
  {$IfDef GLX_VERSION_1_3}
  // PBuffer
  glXGetVisualFromFBConfig: function(dpy: PDisplay; config: GLXFBConfig): PXVisualInfo; cdecl;
  glXChooseFBConfig: function(dpy: PDisplay; screen: GLint; attribList: PGLint; var nitems: GLint): PGLXFBConfig; cdecl;
     // создание области рендеринга вне экрана
  glXCreatePbuffer: function(dpy: PDisplay; config: Integer; attribList: PInteger): GLXPBuffer; cdecl;
     // уничтожение области рендеринга вне экрана
  glXDestroyPbuffer: procedure(dpy: PDisplay; pbuf: GLXPBuffer); cdecl;
  {$EndIf}
  {$IfDef GLX_SGIX_pbuffer}
  glXCreateGLXPbufferSGIX: function(dpy: PDisplay; config: Integer; width, height: LongWord; attribList: PInteger): GLXPBuffer; cdecl;
  glXDestroyGLXPbufferSGIX: procedure(dpy: PDisplay; pbuf: GLXPBuffer); cdecl;
  glXQueryGLXPbufferSGIX: procedure(dpy: PDisplay; pbuf: GLXPbufferSGIX; attribute: longint; value: Pdword); cdecl;
  glXSelectEventSGIX: procedure(dpy: PDisplay; drawable: GLXDrawable; mask: dword); cdecl;
  glXGetSelectedEventSGIX: procedure(dpy: PDisplay; drawable: GLXDrawable; mask: Pdword); cdecl;
  {$EndIf}
{$EndIf}

  procedure AllCheckWGLorGLXExtension;
  procedure Init_GLX_WGL;

implementation

uses
  {$IfDef LINUX}
  zgl_screen,
  {$EndIf}
  zgl_opengl_all,
  zgl_opengl;

procedure AllCheckWGLorGLXExtension;
begin
  {$IfDef LINUX}
  // ZenGL ++
  GLX_SGIX_fbconfig := gl_IsSupported('GLX_SGIX_fbconfig', oglXExtensions);
  GLX_SGIX_pbuffer := gl_IsSupported('GLX_SGIX_pbuffer', oglXExtensions);
  GLX_SGI_swap_control := gl_IsSupported('GLX_SGI_swap_control', oglXExtensions);
  {$IFDEF GL_VERSION_3_0}
  GLX_ARB_create_context := gl_IsSupported('GLX_ARB_create_context', oglXExtensions);
  {$ENDIF}
  {$IfDef USE_FULL_GLX}
  GLX_ARB_context_flush_control := gl_IsSupported('GLX_ARB_context_flush_control', oglXExtensions);

  GLX_ARB_create_context_no_error := gl_IsSupported('GLX_ARB_create_context_no_error', oglXExtensions);
  GLX_ARB_create_context_profile := gl_IsSupported('GLX_ARB_create_context_profile', oglXExtensions);
  GLX_ARB_create_context_robustness := gl_IsSupported('GLX_ARB_create_context_robustness', oglXExtensions);
  GLX_ARB_fbconfig_float := gl_IsSupported('GLX_ARB_fbconfig_float', oglXExtensions);
  GLX_ARB_framebuffer_sRGB := gl_IsSupported('GLX_ARB_framebuffer_sRGB', oglXExtensions);
  GLX_ARB_get_proc_address := gl_IsSupported('GLX_ARB_get_proc_address', oglXExtensions);
  GLX_ARB_multisample := gl_IsSupported('GLX_ARB_multisample', oglXExtensions);
  GLX_ARB_robustness_application_isolation := gl_IsSupported('GLX_ARB_robustness_application_isolation', oglXExtensions);
  GLX_ARB_robustness_share_group_isolation := gl_IsSupported('GLX_ARB_robustness_share_group_isolation', oglXExtensions);
  GLX_ARB_vertex_buffer_object := gl_IsSupported('GLX_ARB_vertex_buffer_object', oglXExtensions);
  GLX_3DFX_multisample := gl_IsSupported('GLX_3DFX_multisample', oglXExtensions);
  GLX_AMD_gpu_association := gl_IsSupported('GLX_AMD_gpu_association', oglXExtensions);
  GLX_EXT_buffer_age := gl_IsSupported('GLX_EXT_buffer_age', oglXExtensions);
  GLX_EXT_context_priority := gl_IsSupported('GLX_EXT_context_priority', oglXExtensions);
  GLX_EXT_create_context_es2_profile := gl_IsSupported('GLX_EXT_create_context_es2_profile', oglXExtensions);
  GLX_EXT_create_context_es_profile := gl_IsSupported('GLX_EXT_create_context_es_profile', oglXExtensions);
  GLX_EXT_fbconfig_packed_float := gl_IsSupported('GLX_EXT_fbconfig_packed_float', oglXExtensions);
  GLX_EXT_framebuffer_sRGB := gl_IsSupported('GLX_EXT_framebuffer_sRGB', oglXExtensions);
  GLX_EXT_get_drawable_type := gl_IsSupported('GLX_EXT_get_drawable_type', oglXExtensions);
  GLX_EXT_import_context := gl_IsSupported('GLX_EXT_import_context', oglXExtensions);
  GLX_EXT_libglvnd := gl_IsSupported('GLX_EXT_libglvnd', oglXExtensions);
  GLX_EXT_no_config_context := gl_IsSupported('GLX_EXT_no_config_context', oglXExtensions);
  GLX_EXT_stereo_tree := gl_IsSupported('GLX_EXT_stereo_tree', oglXExtensions);
  GLX_EXT_swap_control := gl_IsSupported('GLX_EXT_swap_control', oglXExtensions);
  GLX_EXT_swap_control_tear := gl_IsSupported('GLX_EXT_swap_control_tear', oglXExtensions);
  GLX_EXT_texture_from_pixmap := gl_IsSupported('GLX_EXT_texture_from_pixmap', oglXExtensions);
  GLX_EXT_visual_info := gl_IsSupported('GLX_EXT_visual_info', oglXExtensions);
  GLX_EXT_visual_rating := gl_IsSupported('GLX_EXT_visual_rating', oglXExtensions);
  GLX_INTEL_swap_event := gl_IsSupported('GLX_INTEL_swap_event', oglXExtensions);
  GLX_MESA_agp_offset := gl_IsSupported('GLX_MESA_agp_offset', oglXExtensions);
  GLX_MESA_copy_sub_buffer := gl_IsSupported('GLX_MESA_copy_sub_buffer', oglXExtensions);
  GLX_MESA_pixmap_colormap := gl_IsSupported('GLX_MESA_pixmap_colormap', oglXExtensions);
  GLX_MESA_query_renderer := gl_IsSupported('GLX_MESA_query_renderer', oglXExtensions);
  GLX_MESA_release_buffers := gl_IsSupported('GLX_MESA_release_buffers', oglXExtensions);
  GLX_MESA_set_3dfx_mode := gl_IsSupported('GLX_MESA_set_3dfx_mode', oglXExtensions);
  GLX_MESA_swap_control := gl_IsSupported('GLX_MESA_swap_control', oglXExtensions);
  GLX_NV_copy_buffer := gl_IsSupported('GLX_NV_copy_buffer', oglXExtensions);
  GLX_NV_copy_image := gl_IsSupported('GLX_NV_copy_image', oglXExtensions);
  GLX_NV_delay_before_swap := gl_IsSupported('GLX_NV_delay_before_swap', oglXExtensions);
  GLX_NV_float_buffer := gl_IsSupported('GLX_NV_float_buffer', oglXExtensions);
  GLX_NV_multigpu_context := gl_IsSupported('GLX_NV_multigpu_context', oglXExtensions);
  GLX_NV_multisample_coverage := gl_IsSupported('GLX_NV_multisample_coverage', oglXExtensions);
  GLX_NV_present_video := gl_IsSupported('GLX_NV_present_video', oglXExtensions);
  GLX_NV_robustness_video_memory_purge := gl_IsSupported('GLX_NV_robustness_video_memory_purge', oglXExtensions);
  GLX_NV_swap_group := gl_IsSupported('GLX_NV_swap_group', oglXExtensions);
  GLX_NV_video_capture := gl_IsSupported('GLX_NV_video_capture', oglXExtensions);
  GLX_NV_video_out := gl_IsSupported('GLX_NV_video_out', oglXExtensions);
  GLX_OML_swap_method := gl_IsSupported('GLX_OML_swap_method', oglXExtensions);
  GLX_OML_sync_control := gl_IsSupported('GLX_OML_sync_control', oglXExtensions);
  GLX_SGIS_blended_overlay := gl_IsSupported('GLX_SGIS_blended_overlay', oglXExtensions);
  GLX_SGIS_multisample := gl_IsSupported('GLX_SGIS_multisample', oglXExtensions);
  GLX_SGIS_shared_multisample := gl_IsSupported('GLX_SGIS_shared_multisample', oglXExtensions);
  GLX_SGIX_dmbuffer := gl_IsSupported('GLX_SGIX_dmbuffer', oglXExtensions);
  GLX_SGIX_hyperpipe := gl_IsSupported('GLX_SGIX_hyperpipe', oglXExtensions);
  GLX_SGIX_swap_barrier := gl_IsSupported('GLX_SGIX_swap_barrier', oglXExtensions);
  GLX_SGIX_swap_group := gl_IsSupported('GLX_SGIX_swap_group', oglXExtensions);
  GLX_SGIX_video_resize := gl_IsSupported('GLX_SGIX_video_resize', oglXExtensions);
  GLX_SGIX_video_source := gl_IsSupported('GLX_SGIX_video_source', oglXExtensions);
  GLX_SGIX_visual_select_group := gl_IsSupported('GLX_SGIX_visual_select_group', oglXExtensions);
  GLX_SGI_cushion := gl_IsSupported('GLX_SGI_cushion', oglXExtensions);
  GLX_SGI_make_current_read := gl_IsSupported('GLX_SGI_make_current_read', oglXExtensions);
  GLX_SGI_video_sync := gl_IsSupported('GLX_SGI_video_sync', oglXExtensions);
  GLX_SUN_get_transparent_index := gl_IsSupported('GLX_SUN_get_transparent_index', oglXExtensions);
  {$EndIf}
  {$EndIf}
  {$IfDef WINDOWS}
  // 1 - запросить версию OpenGL
  // 2 - запросить glGetString для нужной версии, получить строку расширений.
  // 3 - проверить расширение wglGetExtensionsStringARB, если существует, второй раз запрашиваем строку расширений.

  // замкнутый круг... без расширений нельзя использовать WGL,
  // для использования WGL нужно получить расширение... олени.
  WGL_ARB_extensions_string := gl_IsSupported('WGL_ARB_extensions_string', oWGLExtensions);
  WGL_EXT_extensions_string := gl_IsSupported('WGL_EXT_extensions_string', oWGLExtensions);
  {$IfDef GL_VERSION_3_0}
  WGL_ARB_create_context := gl_IsSupported('WGL_ARB_create_context', oWGLExtensions);
  {$EndIf}
  {$IfDef USE_FULL_WGL}
  WGL_ARB_buffer_region := gl_IsSupported('WGL_ARB_buffer_region', oWGLExtensions);
  WGL_ARB_context_flush_control := gl_IsSupported('WGL_ARB_context_flush_control', oWGLExtensions);
  WGL_ARB_create_context_no_error := gl_IsSupported('WGL_ARB_create_context_no_error', oWGLExtensions);
  WGL_ARB_create_context_profile := gl_IsSupported('WGL_ARB_create_context_profile', oWGLExtensions);
  WGL_ARB_create_context_robustness := gl_IsSupported('WGL_ARB_create_context_robustness', oWGLExtensions);
  WGL_ARB_make_current_read := gl_IsSupported('WGL_ARB_make_current_read', oWGLExtensions);
  {$EndIf}

  WGL_ARB_framebuffer_sRGB := gl_IsSupported('WGL_ARB_framebuffer_sRGB', oWGLExtensions);
  WGL_ARB_multisample := gl_IsSupported('WGL_ARB_multisample', oWGLExtensions);
  WGL_ARB_pbuffer := gl_IsSupported('WGL_ARB_pbuffer', oWGLExtensions);
  WGL_ARB_pixel_format := gl_IsSupported('WGL_ARB_pixel_format', oWGLExtensions);
  {$IfDef USE_FULL_WGL}
  WGL_ARB_pixel_format_float := gl_IsSupported('WGL_ARB_pixel_format_float', oWGLExtensions);
  WGL_ARB_render_texture := gl_IsSupported('WGL_ARB_render_texture', oWGLExtensions);
  WGL_ARB_robustness_application_isolation := gl_IsSupported('WGL_ARB_robustness_application_isolation', oWGLExtensions);
  WGL_ARB_robustness_share_group_isolation := gl_IsSupported('WGL_ARB_robustness_share_group_isolation', oWGLExtensions);
  WGL_3DFX_multisample := gl_IsSupported('WGL_3DFX_multisample', oWGLExtensions);
  WGL_3DL_stereo_control := gl_IsSupported('WGL_3DL_stereo_control', oWGLExtensions);
  WGL_AMD_gpu_association := gl_IsSupported('WGL_AMD_gpu_association', oWGLExtensions);
  WGL_ATI_pixel_format_float := gl_IsSupported('WGL_ATI_pixel_format_float', oWGLExtensions);
  WGL_ATI_render_texture_rectangle := gl_IsSupported('WGL_ATI_render_texture_rectangle', oWGLExtensions);
  WGL_EXT_colorspace := gl_IsSupported('WGL_EXT_colorspace', oWGLExtensions);
  WGL_EXT_create_context_es2_profile := gl_IsSupported('WGL_EXT_create_context_es2_profile', oWGLExtensions);
  WGL_EXT_create_context_es_profile := gl_IsSupported('WGL_EXT_create_context_es_profile', oWGLExtensions);
  WGL_EXT_depth_float := gl_IsSupported('WGL_EXT_depth_float', oWGLExtensions);
  WGL_EXT_display_color_table := gl_IsSupported('WGL_EXT_display_color_table', oWGLExtensions);
  WGL_EXT_framebuffer_sRGB := gl_IsSupported('WGL_EXT_framebuffer_sRGB', oWGLExtensions);
  WGL_EXT_make_current_read := gl_IsSupported('WGL_EXT_make_current_read', oWGLExtensions);
  WGL_EXT_multisample := gl_IsSupported('WGL_EXT_multisample', oWGLExtensions);
  {$EndIf}
  WGL_EXT_pbuffer := gl_IsSupported('WGL_EXT_pbuffer', oWGLExtensions);
  WGL_EXT_pixel_format := gl_IsSupported('WGL_EXT_pixel_format', oWGLExtensions);
  WGL_EXT_pixel_format_packed_float := gl_IsSupported('WGL_EXT_pixel_format_packed_float', oWGLExtensions);
  WGL_EXT_swap_control := gl_IsSupported('WGL_EXT_swap_control', oWGLExtensions);
  {$IfDef USE_FULL_WGL}
  WGL_EXT_swap_control_tear := gl_IsSupported('WGL_EXT_swap_control_tear', oWGLExtensions);
  WGL_I3D_digital_video_control := gl_IsSupported('WGL_I3D_digital_video_control', oWGLExtensions);
  WGL_I3D_gamma := gl_IsSupported('WGL_I3D_gamma', oWGLExtensions);
  WGL_I3D_genlock := gl_IsSupported('WGL_I3D_genlock', oWGLExtensions);
  WGL_I3D_image_buffer := gl_IsSupported('WGL_I3D_image_buffer', oWGLExtensions);
  WGL_I3D_swap_frame_lock := gl_IsSupported('WGL_I3D_swap_frame_lock', oWGLExtensions);
  WGL_I3D_swap_frame_usage := gl_IsSupported('WGL_I3D_swap_frame_usage', oWGLExtensions);
  WGL_NV_DX_interop := gl_IsSupported('WGL_NV_DX_interop', oWGLExtensions);
  WGL_NV_DX_interop2 := gl_IsSupported('WGL_NV_DX_interop2', oWGLExtensions);
  WGL_NV_copy_image := gl_IsSupported('WGL_NV_copy_image', oWGLExtensions);
  WGL_NV_delay_before_swap := gl_IsSupported('WGL_NV_delay_before_swap', oWGLExtensions);
  WGL_NV_float_buffer := gl_IsSupported('WGL_NV_float_buffer', oWGLExtensions);
  WGL_NV_gpu_affinity := gl_IsSupported('WGL_NV_gpu_affinity', oWGLExtensions);
  WGL_NV_multigpu_context := gl_IsSupported('WGL_NV_multigpu_context', oWGLExtensions);
  WGL_NV_multisample_coverage := gl_IsSupported('WGL_NV_multisample_coverage', oWGLExtensions);
  WGL_NV_present_video := gl_IsSupported('WGL_NV_present_video', oWGLExtensions);
  WGL_NV_render_depth_texture := gl_IsSupported('WGL_NV_render_depth_texture', oWGLExtensions);
  WGL_NV_render_texture_rectangle := gl_IsSupported('WGL_NV_render_texture_rectangle', oWGLExtensions);
  WGL_NV_swap_group := gl_IsSupported('WGL_NV_swap_group', oWGLExtensions);
  WGL_NV_vertex_array_range := gl_IsSupported('WGL_NV_vertex_array_range', oWGLExtensions);
  WGL_NV_video_capture := gl_IsSupported('WGL_NV_video_capture', oWGLExtensions);
  WGL_NV_video_output := gl_IsSupported('WGL_NV_video_output', oWGLExtensions);
  WGL_OML_sync_control := gl_IsSupported('WGL_OML_sync_control', oWGLExtensions);
  {$EndIf}
  {$EndIf}
end;

procedure Init_GLX_WGL;
{$IfDef LINUX}
var
  i, j: Integer;
{$EndIf}
begin
  {$IfDef LINUX}
  glXChooseVisual := gl_GetProc('glXChooseVisual');
  glXCreateContext := gl_GetProc('glXCreateContext');
  glXDestroyContext := gl_GetProc('glXDestroyContext');
  glXMakeCurrent := gl_GetProc('glXMakeCurrent');
  glXSwapBuffers := gl_GetProc('glXSwapBuffers');
  glXQueryExtension := gl_GetProc('glXQueryExtension');
  glXQueryVersion := gl_GetProc('glXQueryVersion');
  glXIsDirect := gl_GetProc('glXIsDirect');
  glXQueryServerString := gl_GetProc('glXQueryServerString');

  oglxExtensions := glXQueryServerString(scrDisplay, scrDefault, GLX_EXTENSIONS);
  glXQueryVersion(scrDisplay, i, j);
  if i = 1 then
  begin
    if j >= 3 then
      GLX_VERSION_1_3 := true;
    if j = 4 then
      GLX_VERSION_1_4 := true;
  end;
  {$EndIf}
  AllCheckWGLorGLXExtension;
  {$IfDef LINUX}
  if GLX_VERSION_1_3 then
  begin
    glXGetFBConfigAttrib := gl_GetProc('glXGetFBConfigAttrib');
    glXCreateNewContext := gl_GetProc('glXCreateNewContext');;
  end;
  {$IfDef USE_FULL_GLX}
  glXCopyContext := gl_GetProc('glXCopyContext');
  glXCreateGLXPixmap := gl_GetProc('glXCreateGLXPixmap');
  glXDestroyGLXPixmap := gl_GetProc('glXDestroyGLXPixmap');
  glXGetConfig := gl_GetProc('glXGetConfig');
  glXGetCurrentContext := gl_GetProc('glXGetCurrentContext');
  glXGetCurrentDrawable := gl_GetProc('glXGetCurrentDrawable');
  glXUseXFont := gl_GetProc('glXUseXFont');
  glXWaitGL := gl_GetProc('glXWaitGL');
  glXWaitX := gl_GetProc('glXWaitX');
  glXGetClientString := gl_GetProc('glXGetClientString');
  glXQueryExtensionsString := gl_GetProc('glXQueryExtensionsString');
  {$IfDef GLX_VERSION_1_3}
  if GLX_VERSION_1_3 then
  begin
    glXGetFBConfigs := gl_GetProc('glXGetFBConfigs');
    glXCreateWindow := gl_GetProc('glXCreateWindow');
    glXDestroyWindow := gl_GetProc('glXDestroyWindow');
    glXCreatePixmap := gl_GetProc('glXCreatePixmap');
    glXDestroyPixmap := gl_GetProc('glXDestroyPixmap');
    glXQueryDrawable := gl_GetProc('glXQueryDrawable');
    glXMakeContextCurrent := gl_GetProc('glXMakeContextCurrent');
    glXGetCurrentReadDrawable := gl_GetProc('glXGetCurrentReadDrawable');
  //  glXGetCurreentDisplay := gl_GetProc('glXGetCurreentDisplay');
    glXQueryContext := gl_GetProc('glXQueryContext');
    glXSelectEvent := gl_GetProc('glXSelectEvent');
    glXGetSelectedEvent := gl_GetProc('glXGetSelectedEvent');
  end;
  {$EndIf}
  {$EndIf}
  {$ifdef GLX_ARB_create_context}
  if GLX_ARB_create_context then
    glXCreateContextAttribsARB := gl_GetProc('glXCreateContextAttribsARB');
  {$EndIf}
  {$ifdef GLX_AMD_gpu_association}
  if GLX_AMD_gpu_association then
  begin
    glXGetGPUIDsAMD := gl_GetProc('glXGetGPUIDsAMD');
    glXGetGPUInfoAMD := gl_GetProc('glXGetGPUInfoAMD');
    glXGetContextGPUIDAMD := gl_GetProc('glXGetContextGPUIDAMD');
    glXCreateAssociatedContextAMD := gl_GetProc('glXCreateAssociatedContextAMD');
    glXCreateAssociatedContextAttribsAMD := gl_GetProc('glXCreateAssociatedContextAttribsAMD');
    glXDeleteAssociatedContextAMD := gl_GetProc('glXDeleteAssociatedContextAMD');
    glXMakeAssociatedContextCurrentAMD := gl_GetProc('glXMakeAssociatedContextCurrentAMD');
    glXGetCurrentAssociatedContextAMD := gl_GetProc('glXGetCurrentAssociatedContextAMD');
    glXBlitContextFramebufferAMD := gl_GetProc('glXBlitContextFramebufferAMD');
  end;
  {$EndIf}
  {$ifdef GLX_EXT_import_context}
  if GLX_EXT_import_context then
  begin
    glXGetCurrentDisplayEXT := gl_GetProc('glXGetCurrentDisplayEXT');
    glXQueryContextInfoEXT := gl_GetProc('glXQueryContextInfoEXT');
    glXGetContextIDEXT := gl_GetProc('glXGetContextIDEXT');
    glXImportContextEXT := gl_GetProc('glXImportContextEXT');
    glXFreeContextEXT := gl_GetProc('glXFreeContextEXT');
  end;
  {$EndIf}
  {$ifdef GLX_EXT_texture_from_pixmap}
  if GLX_EXT_texture_from_pixmap then
  begin
    glXBindTexImageEXT := gl_GetProc('glXBindTexImageEXT');
    glXReleaseTexImageEXT := gl_GetProc('glXReleaseTexImageEXT');
  end;
  {$EndIf}
  {$ifdef GLX_EXT_swap_control}
  if GLX_EXT_swap_control then
    glXSwapIntervalEXT := gl_GetProc('glXSwapIntervalEXT');
  {$EndIf}
  {$ifdef GLX_MESA_agp_offset}
  if GLX_MESA_agp_offset then
    glXGetAGPOffsetMESA := gl_GetProc('glXGetAGPOffsetMESA');
  {$endif}
  {$ifdef GLX_MESA_pixmap_colormap}
  if GLX_MESA_pixmap_colormap then
    glXCreateGLXPixmapMESA := gl_GetProc('glXCreateGLXPixmapMESA');
  {$EndIf}
  {$ifdef GLX_MESA_query_renderer}
  if GLX_MESA_query_renderer then
  begin
    glXQueryCurrentRendererIntegerMESA := gl_GetProc('glXQueryCurrentRendererIntegerMESA');
    glXQueryCurrentRendererStringMESA := gl_GetProc('glXQueryCurrentRendererStringMESA');
    glXQueryRendererIntegerMESA := gl_GetProc('glXQueryRendererIntegerMESA');
    glXQueryRendererStringMESA := gl_GetProc('glXQueryRendererStringMESA');
  end;
  {$EndIf}
  {$ifdef GLX_MESA_swap_control}
  if GLX_MESA_swap_control then
  begin
    glXSwapIntervalMESA := gl_GetProc('glXSwapIntervalMESA');
    glXGetSwapIntervalMESA := gl_GetProc('glXGetSwapIntervalMESA');
  end;
  {$EndIf}
  {$ifdef GLX_MESA_release_buffers}
  if GLX_MESA_release_buffers then
    glXReleaseBuffersMESA := gl_GetProc('glXReleaseBuffersMESA');
  {$EndIf}
  {$ifdef GLX_MESA_set_3dfx_mode}
  if GLX_MESA_set_3dfx_mode then
    glXSet3DfxModeMESA := gl_GetProc('glXSet3DfxModeMESA');
  {$EndIf}
  {$ifdef GLX_MESA_copy_sub_buffer}
  if GLX_MESA_copy_sub_buffer then
    glXCopySubBufferMESA := gl_GetProc('glXCopySubBufferMESA');
  {$EndIf}
  {$ifdef GLX_NV_copy_buffer}
  if GLX_NV_copy_buffer then
  begin
    glXCopyBufferSubDataNV := gl_GetProc('glXCopyBufferSubDataNV');
    glXNamedCopyBufferSubDataNV := gl_GetProc('glXNamedCopyBufferSubDataNV');
  end;
  {$EndIf}
  {$ifdef GLX_NV_copy_image}
  if GLX_NV_copy_image then
    glXCopyImageSubDataNV := gl_GetProc('glXCopyImageSubDataNV');
  {$EndIf}
  {$ifdef GLX_NV_delay_before_swap}
  if GLX_NV_delay_before_swap then
    glXDelayBeforeSwapNV := gl_GetProc('glXDelayBeforeSwapNV');
  {$EndIf}
  {$ifdef GLX_NV_present_video}
  if GLX_NV_present_video then
  begin
    glXEnumerateVideoDevicesNV := gl_GetProc('glXEnumerateVideoDevicesNV');
    glXBindVideoDeviceNV := gl_GetProc('glXBindVideoDeviceNV');
  end;
  {$EndIf}
  {$ifdef GLX_NV_swap_group}
  if GLX_NV_swap_group then
  begin
    glXJoinSwapGroupNV := gl_GetProc('glXJoinSwapGroupNV');
    glXBindSwapBarrierNV := gl_GetProc('glXBindSwapBarrierNV');
    glXQuerySwapGroupNV := gl_GetProc('glXQuerySwapGroupNV');
    glXQueryMaxSwapGroupsNV := gl_GetProc('glXQueryMaxSwapGroupsNV');
    glXQueryFrameCountNV := gl_GetProc('glXQueryFrameCountNV');
    glXResetFrameCountNV := gl_GetProc('glXResetFrameCountNV');
  end;
  {$EndIf}
  {$ifdef GLX_NV_video_capture}
  if GLX_NV_video_capture then
  begin
    glXBindVideoCaptureDeviceNV := gl_GetProc('glXBindVideoCaptureDeviceNV');
    glXEnumerateVideoCaptureDevicesNV := gl_GetProc('glXEnumerateVideoCaptureDevicesNV');
    glXLockVideoCaptureDeviceNV := gl_GetProc('glXLockVideoCaptureDeviceNV');
    glXQueryVideoCaptureDeviceNV := gl_GetProc('glXQueryVideoCaptureDeviceNV');
    glXReleaseVideoCaptureDeviceNV := gl_GetProc('glXReleaseVideoCaptureDeviceNV');
  end;
  {$EndIf}
  {$ifdef GLX_NV_video_out}
  if GLX_NV_video_out then
  begin
    glXGetVideoDeviceNV := gl_GetProc('glXGetVideoDeviceNV');
    glXReleaseVideoDeviceNV := gl_GetProc('glXReleaseVideoDeviceNV');
    glXBindVideoImageNV := gl_GetProc('glXBindVideoImageNV');
    glXReleaseVideoImageNV := gl_GetProc('glXReleaseVideoImageNV');
    glXSendPbufferToVideoNV := gl_GetProc('glXSendPbufferToVideoNV');
    glXGetVideoInfoNV := gl_GetProc('glXGetVideoInfoNV');
  end;
  {$EndIf}
  {$ifdef GLX_OML_sync_control}
  if GLX_OML_sync_control then
  begin
    glXGetSyncValuesOML := gl_GetProc('glXGetSyncValuesOML');
    glXGetMscRateOML := gl_GetProc('glXGetMscRateOML');
    glXSwapBuffersMscOML := gl_GetProc('glXSwapBuffersMscOML');
    glXWaitForMscOML := gl_GetProc('glXWaitForMscOML');
    glXWaitForSbcOML := gl_GetProc('glXWaitForSbcOML');
  end;
  {$EndIf}
  {$ifdef GLX_SGIX_dmbuffer}
  if GLX_SGIX_dmbuffer then
    glXAssociateDMPbufferSGIX := gl_GetProc('glXAssociateDMPbufferSGIX');
  {$EndIf}
  {$ifdef GLX_SGIX_hyperpipe}
  if GLX_SGIX_hyperpipe then
  begin
    glXQueryHyperpipeNetworkSGIX := gl_GetProc('glXQueryHyperpipeNetworkSGIX');
    glXHyperpipeConfigSGIX := gl_GetProc('glXHyperpipeConfigSGIX');
    glXQueryHyperpipeConfigSGIX := gl_GetProc('glXQueryHyperpipeConfigSGIX');
    glXDestroyHyperpipeConfigSGIX := gl_GetProc('glXDestroyHyperpipeConfigSGIX');
    glXBindHyperpipeSGIX := gl_GetProc('glXBindHyperpipeSGIX');
    glXQueryHyperpipeBestAttribSGIX := gl_GetProc('glXQueryHyperpipeBestAttribSGIX');
    glXHyperpipeAttribSGIX := gl_GetProc('glXHyperpipeAttribSGIX');
    glXQueryHyperpipeAttribSGIX := gl_GetProc('glXQueryHyperpipeAttribSGIX');
  end;
  {$EndIf}
  {$ifdef GLX_SGIX_swap_barrier}
  if GLX_SGIX_swap_barrier then
  begin
    glXBindSwapBarrierSGIX := gl_GetProc('glXBindSwapBarrierSGIX');
    glXQueryMaxSwapBarriersSGIX := gl_GetProc('glXQueryMaxSwapBarriersSGIX');
  end;
  {$EndIf}
  {$ifdef GLX_SGIX_swap_group}
  if GLX_SGIX_swap_group then
    glXJoinSwapGroupSGIX := gl_GetProc('glXJoinSwapGroupSGIX');
  {$EndIf}
  {$ifdef GLX_SGIX_video_resize}
  if GLX_SGIX_video_resize then
  begin
    glXBindChannelToWindowSGIX := gl_GetProc('glXBindChannelToWindowSGIX');
    glXChannelRectSGIX := gl_GetProc('glXChannelRectSGIX');
    glXQueryChannelRectSGIX := gl_GetProc('glXQueryChannelRectSGIX');
    glXQueryChannelDeltasSGIX := gl_GetProc('glXQueryChannelDeltasSGIX');
    glXChannelRectSyncSGIX := gl_GetProc('glXChannelRectSyncSGIX');
  end;
  {$EndIf}
  {$ifdef GLX_SGIX_video_source}
  if GLX_SGIX_video_source then
  begin
    glXCreateGLXVideoSourceSGIX := gl_GetProc('glXCreateGLXVideoSourceSGIX');
    glXDestroyGLXVideoSourceSGIX := gl_GetProc('glXDestroyGLXVideoSourceSGIX');
  end;
  {$EndIf}
  {$ifdef GLX_SGI_cushion}
  if GLX_SGI_cushion then
    glXCushionSGI := gl_GetProc('glXCushionSGI');
  {$EndIf}
  {$ifdef GLX_SGI_make_current_read}
  if GLX_SGI_make_current_read then
  begin
    glXMakeCurrentReadSGI := gl_GetProc('glXMakeCurrentReadSGI');
    glXGetCurrentReadDrawableSGI := gl_GetProc('glXGetCurrentReadDrawableSGI');
  end;
  {$EndIf}
  {$ifdef GLX_SGI_video_sync}
  if GLX_SGI_video_sync then
  begin
    glXGetVideoSyncSGI := gl_GetProc('glXGetVideoSyncSGI');
    glXWaitVideoSyncSGI := gl_GetProc('glXWaitVideoSyncSGI');
  end;
  {$EndIf}
  {$ifdef GLX_SUN_get_transparent_index}
  if GLX_SUN_get_transparent_index then
    glXGetTransparentIndexSUN := gl_GetProc('glXGetTransparentIndexSUN');
  {$EndIf}
  {$ifdef GLX_SGIX_fbconfig}
  if GLX_SGIX_fbconfig then
  begin
    glXGetFBConfigAttribSGIX := gl_GetProc('glXGetFBConfigAttribSGIX');
  //  glXChooseFBConfigSGIX := gl_GetProc('glXChooseFBConfigSGIX');
    glXCreateGLXPixmapWithConfigSGIX := gl_GetProc('glXCreateGLXPixmapWithConfigSGIX');
    glXCreateContextWithConfigSGIX := gl_GetProc('glXCreateContextWithConfigSGIX');
  //  glXGetVisualFromFBConfigSGIX := gl_GetProc('glXGetVisualFromFBConfigSGIX');
    glXGetFBConfigFromVisualSGIX := gl_GetProc('glXGetFBConfigFromVisualSGIX');
  end;
  {$EndIf}
(* {$IfDef GLX_SGI_swap_control}
  glXSwapIntervalSGI := gl_GetProc('glXSwapIntervalSGI');
  {$EndIf}
  {$IfDef GLX_VERSION_1_3}
  glXCreatePbuffer := gl_GetProc('glXCreatePbuffer');
  glXDestroyPbuffer := gl_GetProc('glXDestroyPbuffer');
  {$EndIf} *)
  {$ifdef GLX_SGIX_pbuffer}
  if GLX_SGIX_pbuffer then
  begin
  {  glXCreateGLXPbufferSGIX := gl_GetProc('glXCreateGLXPbufferSGIX');
    glXDestroyGLXPbufferSGIX := gl_GetProc('glXDestroyGLXPbufferSGIX'); }
    glXQueryGLXPbufferSGIX := gl_GetProc('glXQueryGLXPbufferSGIX');
    glXSelectEventSGIX := gl_GetProc('glXSelectEventSGIX');
    glXGetSelectedEventSGIX := gl_GetProc('glXGetSelectedEventSGIX');
  end;
  {$EndIf}
  {$EndIf}
  {$IfDef WINDOWS}
{  wglCopyContext := gl_GetProc('wglCopyContext');
  wglCreateContext := gl_GetProc('wglCreateContext');
  wglCreateLayerContext := gl_GetProc('wglCreateLayerContext');
  wglDeleteContext := gl_GetProc('wglDeleteContext');
  wglDescribeLayerPlane := gl_GetProc('wglDescribeLayerPlane');
  wglGetCurrentContext := gl_GetProc('wglGetCurrentContext');
  wglGetCurrentDC := gl_GetProc('wglGetCurrentDC');
  wglGetLayerPaletteEntries := gl_GetProc('wglGetLayerPaletteEntries');
  wglMakeCurrent := gl_GetProc('wglMakeCurrent');
  wglRealizeLayerPalette := gl_GetProc('wglRealizeLayerPalette');
  wglSetLayerPaletteEntries := gl_GetProc('wglSetLayerPaletteEntries');
  wglShareLists := gl_GetProc('wglShareLists');
  wglSwapLayerBuffers := gl_GetProc('wglSwapLayerBuffers');
  wglUseFontBitmaps := gl_GetProc('wglUseFontBitmaps');
  wglUseFontBitmapsW := gl_GetProc('wglUseFontBitmapsW');
  wglUseFontBitmapsA := gl_GetProc('wglUseFontBitmapsA');
  wglUseFontOutlines := gl_GetProc('wglUseFontOutlines');
  wglUseFontOutlinesA := gl_GetProc('wglUseFontOutlinesA');
  wglUseFontOutlinesW := gl_GetProc('wglUseFontOutlinesW');   }
  {$IfDef WGL_ARB_extensions_string or WGL_EXT_extensions_string}
  if WGL_ARB_extensions_string or WGL_EXT_extensions_string then
    wglGetExtensionsStringARB := gl_GetProc('wglGetExtensionsString');
  {$IfEnd}
  {$ifdef WGL_ARB_pixel_format or WGL_EXT_pixel_format}
  if WGL_ARB_pixel_format or WGL_EXT_pixel_format then
  begin
    wglChoosePixelFormatARB := gl_GetProc('wglChoosePixelFormat');
    wglGetPixelFormatAttribivARB := gl_GetProc('wglGetPixelFormatAttribiv');
    wglGetPixelFormatAttribfvARB := gl_GetProc('wglGetPixelFormatAttribfv');
  end;
  {$IfEnd}
  {$ifdef WGL_EXT_swap_control}
  if WGL_EXT_swap_control then
  begin
  //  wglSwapIntervalEXT := gl_GetProc('wglSwapIntervalEXT');
    wglGetSwapIntervalEXT := gl_GetProc('wglGetSwapIntervalEXT');
  end;
  {$EndIf}
  {$If defined(WGL_ARB_pbuffer) or defined(WGL_EXT_pbuffer)}
  if WGL_ARB_pbuffer or WGL_EXT_pbuffer then
  begin
    wglCreatePbufferARB := gl_GetProc('wglCreatePbuffer');
  //  wglGetPbufferDCARB := gl_GetProc('wglGetPbufferDC');
  //  wglReleasePbufferDCARB := gl_GetProc('wglReleasePbufferDC');
  //  wglDestroyPbufferARB := gl_GetProc('wglDestroyPbuffer');
  //  wglQueryPbufferARB := gl_GetProc('wglQueryPbuffer');
  end;
  {$IfEnd}

  {$ifdef WGL_ARB_buffer_region}
  if WGL_ARB_buffer_region then
  begin
    wglCreateBufferRegionARB := gl_GetProc('wglCreateBufferRegionARB');
    wglDeleteBufferRegionARB := gl_GetProc('wglDeleteBufferRegionARB');
    wglSaveBufferRegionARB := gl_GetProc('wglSaveBufferRegionARB');
    wglRestoreBufferRegionARB := gl_GetProc('wglRestoreBufferRegionARB');
  end;
  {$EndIf}
  {$ifdef WGL_ARB_make_current_read or WGL_EXT_make_current_read}
  if WGL_ARB_make_current_read or WGL_EXT_make_current_read then
  begin
    wglMakeContextCurrentARB := gl_GetProc('wglMakeContextCurrent');
    wglGetCurrentReadDCARB := gl_GetProc('wglGetCurrentReadDC');
  end;
  {$IfEnd}
//  wglClampColorARB := gl_GetProc('wglClampColorARB');
  {$ifdef WGL_ARB_render_texture}
  if WGL_ARB_render_texture then
  begin
    wglBindTexImageARB := gl_GetProc('wglBindTexImageARB');
    wglReleaseTexImageARB := gl_GetProc('wglReleaseTexImageARB');
    wglSetPbufferAttribARB := gl_GetProc('wglSetPbufferAttribARB');
  end;
  {$EndIf}
  {$ifdef WGL_ARB_create_context}
  if WGL_ARB_create_context then
    wglCreateContextAttribsARB := gl_GetProc('wglCreateContextAttribsARB');
  {$EndIf}
  {$IfDef WGL_AMD_gpu_association}
  if WGL_AMD_gpu_association then
  begin
    wglGetGPUIDsAMD := gl_GetProc('wglGetGPUIDsAMD');
    wglGetGPUInfoAMD := gl_GetProc('wglGetGPUInfoAMD');
    wglGetContextGPUIDAMD := gl_GetProc('wglGetContextGPUIDAMD');
    wglCreateAssociatedContextAMD := gl_GetProc('wglCreateAssociatedContextAMD');
    wglCreateAssociatedContextAttribsAMD := gl_GetProc('wglCreateAssociatedContextAttribsAMD');
    wglDeleteAssociatedContextAMD := gl_GetProc('wglDeleteAssociatedContextAMD');
    wglMakeAssociatedContextCurrentAMD := gl_GetProc('wglMakeAssociatedContextCurrentAMD');
    wglGetCurrentAssociatedContextAMD := gl_GetProc('wglGetCurrentAssociatedContextAMD');
    wglBlitContextFramebufferAMD := gl_GetProc('wglBlitContextFramebufferAMD');
  end;
  {$EndIf}
  {$IfDef WGL_EXT_display_color_table}
  if WGL_EXT_display_color_table then
  begin
    wglCreateDisplayColorTableEXT := gl_GetProc('wglCreateDisplayColorTableEXT');
    wglLoadDisplayColorTableEXT := gl_GetProc('wglLoadDisplayColorTableEXT');
    wglBindDisplayColorTableEXT := gl_GetProc('wglBindDisplayColorTableEXT');
    wglDestroyDisplayColorTableEXT := gl_GetProc('wglDestroyDisplayColorTableEXT');
  end;
  {$EndIf}

  // WGL_EXT_extensions_string
//  wglGetExtensionsStringEXT := gl_GetProc('wglGetExtensionsStringEXT');
  // WGL_EXT_make_current_read
//  wglMakeContextCurrentEXT := gl_GetProc('wglMakeContextCurrentEXT');
//  wglGetCurrentReadDCEXT := gl_GetProc('wglGetCurrentReadDCEXT');
  // WGL_EXT_pixel_format
//  wglGetPixelFormatAttribivEXT := gl_GetProc('wglGetPixelFormatAttribivEXT');
//  wglGetPixelFormatAttribfvEXT := gl_GetProc('wglGetPixelFormatAttribfvEXT');
//  wglChoosePixelFormatEXT := gl_GetProc('wglChoosePixelFormatEXT');
  {$IfDef WGL_I3D_digital_video_control}
  if WGL_I3D_digital_video_control then
  begin
    wglGetDigitalVideoParametersI3D := gl_GetProc('wglGetDigitalVideoParametersI3D');
    wglSetDigitalVideoParametersI3D := gl_GetProc('wglSetDigitalVideoParametersI3D');
  end;
  {$EndIf}
  {$IfDef WGL_I3D_gamma}
  if WGL_I3D_gamma then
  begin
    wglGetGammaTableParametersI3D := gl_GetProc('wglGetGammaTableParametersI3D');
    wglSetGammaTableParametersI3D := gl_GetProc('wglSetGammaTableParametersI3D');
    wglGetGammaTableI3D := gl_GetProc('wglGetGammaTableI3D');
    wglSetGammaTableI3D := gl_GetProc('wglSetGammaTableI3D');
  end;
  {$EndIf}
  {$IfDef WGL_I3D_genlock}
  if WGL_I3D_genlock then
  begin
    wglEnableGenlockI3D := gl_GetProc('wglEnableGenlockI3D');
    wglDisableGenlockI3D := gl_GetProc('wglDisableGenlockI3D');
    wglIsEnabledGenlockI3D := gl_GetProc('wglIsEnabledGenlockI3D');
    wglGenlockSourceI3D := gl_GetProc('wglGenlockSourceI3D');
    wglGetGenlockSourceI3D := gl_GetProc('wglGetGenlockSourceI3D');
    wglGenlockSourceEdgeI3D := gl_GetProc('wglGenlockSourceEdgeI3D');
    wglGetGenlockSourceEdgeI3D := gl_GetProc('wglGetGenlockSourceEdgeI3D');
    wglGenlockSampleRateI3D := gl_GetProc('wglGenlockSampleRateI3D');
    wglGetGenlockSampleRateI3D := gl_GetProc('wglGetGenlockSampleRateI3D');
    wglGenlockSourceDelayI3D := gl_GetProc('wglGenlockSourceDelayI3D');
    wglGetGenlockSourceDelayI3D := gl_GetProc('wglGetGenlockSourceDelayI3D');
    wglQueryGenlockMaxSourceDelayI3D := gl_GetProc('wglQueryGenlockMaxSourceDelayI3D');
  end;
  {$EndIf}
  {$IfDef WGL_I3D_image_buffer}
  if WGL_I3D_image_buffer then
  begin
    wglCreateImageBufferI3D := gl_GetProc('wglCreateImageBufferI3D');
    wglDestroyImageBufferI3D := gl_GetProc('wglDestroyImageBufferI3D');
    wglAssociateImageBufferEventsI3D := gl_GetProc('wglAssociateImageBufferEventsI3D');
    wglReleaseImageBufferEventsI3D := gl_GetProc('wglReleaseImageBufferEventsI3D');
  end;
  {$EndIf}
  {$IfDef WGL_I3D_swap_frame_lock}
  if WGL_I3D_swap_frame_lock then
  begin
    wglEnableFrameLockI3D := gl_GetProc('wglEnableFrameLockI3D');
    wglDisableFrameLockI3D := gl_GetProc('wglDisableFrameLockI3D');
    wglIsEnabledFrameLockI3D := gl_GetProc('wglIsEnabledFrameLockI3D');
    wglQueryFrameLockMasterI3D := gl_GetProc('wglQueryFrameLockMasterI3D');
  end;
  {$EndIf}
  {$IfDef WGL_I3D_swap_frame_usage}
  if WGL_I3D_swap_frame_usage then
  begin
    wglGetFrameUsageI3D := gl_GetProc('wglGetFrameUsageI3D');
    wglBeginFrameTrackingI3D := gl_GetProc('wglBeginFrameTrackingI3D');
    wglEndFrameTrackingI3D := gl_GetProc('wglEndFrameTrackingI3D');
    wglQueryFrameTrackingI3D := gl_GetProc('wglQueryFrameTrackingI3D');
  end;
  {$EndIf}
  {$IfDef WGL_NV_vertex_array_range}
  if WGL_NV_vertex_array_range then
  begin
    wglAllocateMemoryNV := gl_GetProc('wglAllocateMemoryNV');
    wglFreeMemoryNV := gl_GetProc('wglFreeMemoryNV');
  end;
  {$EndIf}
  {$IfDef WGL_NV_present_video}
  if WGL_NV_present_video then
  begin
    wglEnumerateVideoDevicesNV := gl_GetProc('wglEnumerateVideoDevicesNV');
    wglBindVideoDeviceNV := gl_GetProc('wglBindVideoDeviceNV');
    wglQueryCurrentContextNV := gl_GetProc('wglQueryCurrentContextNV');
  end;
  {$EndIf}
  {$IfDef WGL_NV_video_output}
  if WGL_NV_video_output then
  begin
    wglGetVideoDeviceNV := gl_GetProc('wglGetVideoDeviceNV');
    wglReleaseVideoDeviceNV := gl_GetProc('wglReleaseVideoDeviceNV');
    wglBindVideoImageNV := gl_GetProc('wglBindVideoImageNV');
    wglReleaseVideoImageNV := gl_GetProc('wglReleaseVideoImageNV');
    wglSendPbufferToVideoNV := gl_GetProc('wglSendPbufferToVideoNV');
    wglGetVideoInfoNV := gl_GetProc('wglGetVideoInfoNV');
  end;
  {$EndIf}
  {$IfDef WGL_NV_swap_group}
  if WGL_NV_swap_group then
  begin
    wglJoinSwapGroupNV := gl_GetProc('wglJoinSwapGroupNV');
    wglBindSwapBarrierNV := gl_GetProc('wglBindSwapBarrierNV');
    wglQuerySwapGroupNV := gl_GetProc('wglQuerySwapGroupNV');
    wglQueryMaxSwapGroupsNV := gl_GetProc('wglQueryMaxSwapGroupsNV');
    wglQueryFrameCountNV := gl_GetProc('wglQueryFrameCountNV');
    wglResetFrameCountNV := gl_GetProc('wglResetFrameCountNV');
  end;
  {$EndIf}
  {$IfDef WGL_NV_gpu_affinity}
  if WGL_NV_gpu_affinity then
  begin
    wglEnumGpusNV := gl_GetProc('wglEnumGpusNV');
    wglEnumGpuDevicesNV := gl_GetProc('wglEnumGpuDevicesNV');
    wglCreateAffinityDCNV := gl_GetProc('wglCreateAffinityDCNV');
    wglEnumGpusFromAffinityDCNV := gl_GetProc('wglEnumGpusFromAffinityDCNV');
    wglDeleteDCNV := gl_GetProc('wglDeleteDCNV');
  end;
  {$EndIf}
  {$ifdef WGL_NV_video_capture}
  if WGL_NV_video_capture then
  begin
    wglBindVideoCaptureDeviceNV := gl_GetProc('wglBindVideoCaptureDeviceNV');
    wglEnumerateVideoCaptureDevicesNV := gl_GetProc('wglEnumerateVideoCaptureDevicesNV');
    wglLockVideoCaptureDeviceNV := gl_GetProc('wglLockVideoCaptureDeviceNV');
    wglQueryVideoCaptureDeviceNV := gl_GetProc('wglQueryVideoCaptureDeviceNV');
    wglReleaseVideoCaptureDeviceNV := gl_GetProc('wglReleaseVideoCaptureDeviceNV');
  end;
  {$EndIf}
  {$IfDef WGL_NV_copy_image}
  if WGL_NV_copy_image then
    wglCopyImageSubDataNV := gl_GetProc('wglCopyImageSubDataNV');
  {$EndIf}
  {$ifdef WGL_NV_delay_before_swap}
  if WGL_NV_delay_before_swap then
    wglDelayBeforeSwapNV := gl_GetProc('wglDelayBeforeSwapNV');
  {$EndIf}
  {$IfDef WGL_NV_DX_interop}
  if WGL_NV_DX_interop then
  begin
    wglDXSetResourceShareHandleNV := gl_GetProc('wglDXSetResourceShareHandleNV');
    wglDXOpenDeviceNV := gl_GetProc('wglDXOpenDeviceNV');
    wglDXCloseDeviceNV := gl_GetProc('wglDXCloseDeviceNV');
    wglDXRegisterObjectNV := gl_GetProc('wglDXRegisterObjectNV');
    wglDXUnregisterObjectNV := gl_GetProc('wglDXUnregisterObjectNV');
    wglDXObjectAccessNV := gl_GetProc('wglDXObjectAccessNV');
    wglDXLockObjectsNV := gl_GetProc('wglDXLockObjectsNV');
    wglDXUnlockObjectsNV := gl_GetProc('wglDXUnlockObjectsNV');
  end;
  {$EndIf}
  {$IfDef WGL_OML_sync_control}
  if WGL_OML_sync_control then
  begin
    wglGetSyncValuesOML := gl_GetProc('wglGetSyncValuesOML');
    wglGetMscRateOML := gl_GetProc('wglGetMscRateOML');
    wglSwapBuffersMscOML := gl_GetProc('wglSwapBuffersMscOML');
    wglSwapLayerBuffersMscOML := gl_GetProc('wglSwapLayerBuffersMscOML');
    wglWaitForMscOML := gl_GetProc('wglWaitForMscOML');
    wglWaitForSbcOML := gl_GetProc('wglWaitForSbcOML');
  end;
  {$EndIf}
  {$IfDef WGL_3DL_stereo_control}
  if WGL_3DL_stereo_control then
    wglSetStereoEmitterState3DL := gl_GetProc('wglSetStereoEmitterState3DL');
  {$EndIf}
  {$EndIf}
end;

end.

