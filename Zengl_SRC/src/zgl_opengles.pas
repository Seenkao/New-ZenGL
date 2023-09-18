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

 !!! modification from Serge - SSW 24.01.2022
}
unit zgl_opengles;

{$I zgl_config.cfg}
{$IFDEF iOS}
  {$modeswitch objectivec1}
  {$LINKFRAMEWORK OpenGLES}
  {$LINKFRAMEWORK QuartzCore}
{$ENDIF}
{$IF (DEFINED(WIN32) or DEFINED(WIN64) or DEFINED(MACOSX)) and not DEFINED(USE_GLES_ON_DESKTOP)}
  {$ERROR Are you seriously want to compile embedded OpenGL ES code for Windows/MacOS X? :)}
{$IFEND}

interface
uses
  {$IFDEF USE_X11}
  X, XLib, XUtil,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF iOS}
  iPhoneAll, CGGeometry,
  {$ENDIF}
  {$IfNDef NO_EGL}
  zgl_EGL,
  {$EndIf}
  zgl_opengles_all;

const
  TARGET_SCREEN  = 1;
  TARGET_TEXTURE = 2;

function  gl_Create: Boolean;
procedure gl_Destroy;
function  gl_Initialize: Boolean;
procedure gl_ResetState;
procedure gl_LoadEx;

var
  oglColor     : Byte;
  oglzDepth    : Byte;
  oglStencil   : Byte;
  oglFSAA      : Byte;
  oglAnisotropy: Byte;
  oglFOVY      : Single = 45;
  oglzNear     : Single = 0.1;
  oglzFar      : Single = 100;

  oglMode   : Integer = 2; // 2D/3D Modes
  oglTarget : Integer = TARGET_SCREEN;
  oglTargetW: Integer;
  oglTargetH: Integer;
  oglWidth  : Integer;
  oglHeight : Integer;

  oglVRAMUsed: LongWord;

  oglRenderer     : UTF8String;
  oglExtensions   : UTF8String;
  ogl3DAccelerator: Boolean;
  oglCanVSync     : Boolean;
  oglCanFBO       : Boolean;
  oglCanPBuffer   : Boolean;
  oglMaxTexSize   : Integer;
  oglMaxFBOSize   : Integer;
  oglMaxAnisotropy: Integer;
  oglMaxTexUnits  : Integer;
  oglSeparate     : Boolean;

  oglReadPixelsFBO: LongWord;
  oglReadPixelsRB : LongWord;

  {$IFNDEF NO_EGL}
  oglDisplay: EGLDisplay;
  oglConfig : EGLConfig;
  oglSurface: EGLSurface;
  oglContext: EGLContext;

  oglAttr: array[0..31] of EGLint;
  {$IFDEF USE_X11}
  oglVisualInfo: PXVisualInfo;
  {$ENDIF}
  {$ENDIF}

  {$IFDEF iOS}
  eglContext     : EAGLContext;
  eglSurface     : CAEAGLLayer;
  eglView        : UIView;
  eglFramebuffer : GLuint;
  eglRenderbuffer: GLuint;
  {$ENDIF}

implementation
uses
  zgl_application,
  zgl_screen,
  zgl_window,
  zgl_gltypeconst,
  zgl_log,
  zgl_gles,
  zgl_utils;

function gles_GetErrorStr(ErrorCode: LongWord): UTF8String;
begin
{$IFNDEF NO_EGL}
  case ErrorCode of
    EGL_NOT_INITIALIZED: Result := 'EGL_NOT_INITIALIZED';
    EGL_BAD_ACCESS: Result := 'EGL_BAD_ACCESS';
    EGL_BAD_ALLOC: Result := 'EGL_BAD_ALLOC';
    EGL_BAD_ATTRIBUTE: Result := 'EGL_BAD_ATTRIBUTE';
    EGL_BAD_CONFIG: Result := 'EGL_BAD_CONFIG';
    EGL_BAD_CONTEXT: Result := 'EGL_BAD_CONTEXT';
    EGL_BAD_CURRENT_SURFACE: Result := 'EGL_BAD_CURRENT_SURFACE';
    EGL_BAD_DISPLAY: Result := 'EGL_BAD_DISPLAY';
    EGL_BAD_MATCH: Result := 'EGL_BAD_MATCH';
    EGL_BAD_NATIVE_PIXMAP: Result := 'EGL_BAD_NATIVE_PIXMAP';
    EGL_BAD_NATIVE_WINDOW: Result := 'EGL_BAD_NATIVE_WINDOW';
    EGL_BAD_PARAMETER: Result := 'EGL_BAD_PARAMETER';
    EGL_BAD_SURFACE: Result := 'EGL_BAD_SURFACE';
    EGL_CONTEXT_LOST: Result := 'EGL_CONTEXT_LOST';
  else
    Result := 'Error code not recognized';
  end;
{$ELSE}
  Result := 'Error codes are not implemented for this platform';
{$ENDIF}
end;

function gl_Create: Boolean;
  {$IFNDEF NO_EGL}
  var
    i, j: EGLint;
  {$ENDIF}
begin
  Result := FALSE;

  if not InitGLES() Then
  begin
    {$IfNDef USE_GLES20}
    u_Error('Cannot load GLES libraries');
    {$Else}
    u_Error('not InitGLES for GLES 2.0');
    {$EndIf}
    exit;
  end;

{$IFNDEF NO_EGL}
  {$IFDEF USE_X11}
  GetMem(oglVisualInfo, SizeOf(TXVisualInfo));
  XMatchVisualInfo(scrDisplay, scrDefault, DefaultDepth(scrDisplay, scrDefault), TrueColor, oglVisualInfo);

  oglColor := DefaultDepth(scrDisplay, scrDefault);

  oglDisplay := eglGetDisplay(scrDisplay);
  {$ENDIF}
  {$IFDEF WINDOWS}
  wnd_Create(wndWidth, wndHeight);

  oglColor := scrDesktop.dmBitsPerPel;

  oglDisplay := eglGetDisplay(wndDC);
  {$ENDIF}

  if oglDisplay = nil {EGL_NO_DISPLAY} Then
  begin
    log_Add('eglGetDisplay: EGL_DEFAULT_DISPLAY');
    oglDisplay := eglGetDisplay({$IfDef WINDOWS}0{$Else}nil{$EndIf});  // eglGetDisplay(EGL_DEFAULT_DISPLAY);    // не работает...
  end;

  if not eglInitialize(oglDisplay, @i, @j) Then
  begin
    u_Error('Failed to initialize EGL. Error code - ' + gles_GetErrorStr(eglGetError()));
    // только ли для Windows?
    {$IFDEF WINDOWS}
    wnd_Destroy;
    {$ENDIF}
    exit;
  end;

  j := 0;
  oglzDepth := 24;
  repeat
    oglAttr[0] := EGL_SURFACE_TYPE;
    oglAttr[1] := EGL_WINDOW_BIT;
    oglAttr[2] := EGL_DEPTH_SIZE;
    oglAttr[3] := oglzDepth;
    if oglColor > 16 Then
    begin
      oglAttr[4 ] := EGL_RED_SIZE;
      oglAttr[5 ] := 8;
      oglAttr[6 ] := EGL_GREEN_SIZE;
      oglAttr[7 ] := 8;
      oglAttr[8 ] := EGL_BLUE_SIZE;
      oglAttr[9 ] := 8;
      oglAttr[10] := EGL_ALPHA_SIZE;
      oglAttr[11] := 0;
    end else
    begin
      oglAttr[4 ] := EGL_RED_SIZE;
      oglAttr[5 ] := 5;
      oglAttr[6 ] := EGL_GREEN_SIZE;
      oglAttr[7 ] := 6;
      oglAttr[8 ] := EGL_BLUE_SIZE;
      oglAttr[9 ] := 5;
      oglAttr[10] := EGL_ALPHA_SIZE;
      oglAttr[11] := 0;
    end;
    i := 12;
    if oglStencil > 0 Then
    begin
      oglAttr[i    ] := EGL_STENCIL_SIZE;
      oglAttr[i + 1] := oglStencil;
      INC(i, 2);
    end;
    if oglFSAA > 0 Then
    begin
      oglAttr[i    ] := EGL_SAMPLES;
      oglAttr[i + 1] := oglFSAA;
      INC(i, 2);
    end;
    (* это можно сделать, но будет ли толк? *)
    oglAttr[i] := EGL_RENDERABLE_TYPE;
    oglAttr[i + 1] := EGL_OPENGL_ES2_BIT;
    inc(i, 2);
    oglAttr[i] := EGL_NONE;

    log_Add('eglChooseConfig: zDepth = ' + u_IntToStr(oglzDepth) + '; ' + 'stencil = ' + u_IntToStr(oglStencil) + '; ' + 'fsaa = ' + u_IntToStr(oglFSAA) );
    eglChooseConfig(oglDisplay, @oglAttr[0], @oglConfig, 1, @j);
    if (j <> 1) and (oglzDepth = 1) Then
    begin
      if oglFSAA = 0 Then
        break
      else begin
        oglzDepth := 24;
        DEC(oglFSAA, 2);
      end;
    end else
      if j <> 1 Then
        DEC(oglzDepth, 8);

    if oglzDepth = 0 Then
      oglzDepth := 1;
  until j = 1;

  Result := j = 1;
{$ELSE}
  Result := TRUE;
{$ENDIF}
end;

procedure gl_Destroy;
begin
  if oglReadPixelsFBO <> 0 Then
    glDeleteFramebuffers(1, @oglReadPixelsFBO);

  if not Assigned(oglDisplay) then
    exit;
{$IFNDEF NO_EGL}
  {$IFDEF USE_X11}
  FreeMem(oglVisualInfo);
  {$ENDIF}
  // eglMakeCurrent(oglDisplay, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
  eglMakeCurrent(oglDisplay, nil, nil, nil);
  eglTerminate(oglDisplay);
{$ENDIF}
{$IFDEF iOS}
  eglView.dealloc();

  glDeleteFramebuffers(1, @eglFramebuffer);
  glDeleteRenderbuffers(1, @eglRenderbuffer);

  EAGLContext.setCurrentContext(nil);
  eglContext.release();
{$ENDIF}

  FreeGLES();
end;

function gl_Initialize: Boolean;
var
  err: LongWord;
  {$IfDef USE_GLES20}
  contAttr: array[0..7] of EGLint;
  {$EndIf}
begin
//  Result := False;
{$IFNDEF NO_EGL}
  oglSurface := eglCreateWindowSurface(oglDisplay, oglConfig, {@}wndHandle, nil);
  err := eglGetError();
  if err <> EGL_SUCCESS Then
    begin
      u_Error('Cannot create Windows surface - ' + gles_GetErrorStr(err));
      exit;
    end;

  {$IfDef USE_GLES20}
  contAttr[0] := EGL_CONTEXT_CLIENT_VERSION;
  contAttr[1] := 2;
  // это работает с какими-то глюками? Я могу определить на ноутбуке только версию 1.1 и 3.0
  contAttr[2] := EGL_CONTEXT_MAJOR_VERSION;
  contAttr[3] := 2;
  contAttr[4] := EGL_CONTEXT_MINOR_VERSION;
  contAttr[5] := 0;
  contAttr[6] := EGL_NONE;
  oglContext := eglCreateContext(oglDisplay, oglConfig, nil, contAttr);
  {$Else}
  oglContext := eglCreateContext(oglDisplay, oglConfig, nil, nil);
  {$EndIf}
  err := eglGetError();
  if err <> EGL_SUCCESS Then
    begin
      // EGL может вызывать ошибку в Linux при двух мониторах, но само приложение запускается.
      u_Error('Cannot create OpenGL ES context - ' + gles_GetErrorStr(err));
      exit;
    end;
  eglMakeCurrent(oglDisplay, oglSurface, oglSurface, oglContext);
  err := eglGetError();
  if err <> EGL_SUCCESS Then
    begin
      u_Error('Cannot set current OpenGL ES context - ' + gles_GetErrorStr(err));
      exit;
    end;
{$ENDIF}
{$IFDEF iOS}
  eglView := zglCiOSEAGLView.alloc().initWithFrame(UIScreen.mainScreen.bounds);
  eglView.setMultipleTouchEnabled(TRUE);
  // Retina display
  if UIScreen.mainScreen.respondsToSelector(objcselector('scale')) and (UIScreen.mainScreen.scale > 1) Then
    begin
      eglView.setContentScaleFactor(UIScreen.mainScreen.scale);
      log_Add('Retina display detected');
    end;

  eglSurface := CAEAGLLayer(eglView.layer);
  eglSurface.setOpaque(TRUE);
  eglSurface.setDrawableProperties(NSDictionary.dictionaryWithObjectsAndKeys(
                                    NSNumber.numberWithBool(FALSE),
                                    utf8_GetNSString('kEAGLDrawablePropertyRetainedBacking'),
                                    utf8_GetNSString('kEAGLColorFormatRGBA8'),
                                    utf8_GetNSString('kEAGLDrawablePropertyColorFormat'),
                                    nil));
  wndViewCtrl.setView(eglView);
  // Apple, fuck you!
  if UIDevice.currentDevice.systemVersion.floatValue() >= 6.0 Then
    wndHandle.setRootViewController(wndViewCtrl)
  else
    wndHandle.addSubview(eglView);

  eglContext := EAGLContext.alloc().initWithAPI(kEAGLRenderingAPIOpenGLES1);
  EAGLContext.setCurrentContext(eglContext);
{$ENDIF}

  oglRenderer := glGetString(GL_RENDERER);
  log_Add('GL_VERSION: ' + glGetString(GL_VERSION));
  log_Add('GL_RENDERER: ' + oglRenderer);

  ogl3DAccelerator := TRUE;

  gl_LoadEx();
{$IFDEF iOS}
  glGenFramebuffers(1, @eglFramebuffer);
  glBindFramebuffer(GL_FRAMEBUFFER, eglFramebuffer);

  glGenRenderbuffers(1, @eglRenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, eglRenderbuffer);

  eglContext.renderbufferStorage_fromDrawable(GL_RENDERBUFFER, eglSurface);

  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, eglRenderbuffer);

  {if GL_OES_depth24 Then
     oglzDepth := 24
  else
     oglzDepth := 16;

  if oglzDepth > 0 Then
     begin
       case oglzDepth of
         16: glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, oglWidth, oglHeight);
         24: glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT24, oglWidth, oglHeight);
       end;
       glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, eglRenderbuffer);
     end;}
{$ENDIF}
  gl_ResetState();

  Result := TRUE;
end;

procedure gl_ResetState;
begin
  glHint(GL_LINE_SMOOTH_HINT,            GL_NICEST);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glHint(GL_FOG_HINT,                    GL_DONT_CARE);
  glShadeModel(GL_SMOOTH);

  glClearColor(0, 0, 0, 0);

  glDepthFunc (GL_LEQUAL);
  glClearDepthf(1.0);

  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glAlphaFunc(GL_GREATER, 0);

  if oglSeparate Then
  begin
    glBlendEquation(GL_FUNC_ADD_EXT);
    glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
  end;

  glDisable(GL_BLEND);
  glDisable(GL_ALPHA_TEST);
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_TEXTURE_2D);
  glEnable (GL_NORMALIZE);
end;

procedure gl_LoadEx;
begin
  oglExtensions := glGetString(GL_EXTENSIONS);

  // Texture size
  glGetIntegerv(GL_MAX_TEXTURE_SIZE, @oglMaxTexSize);
  log_Add('GL_MAX_TEXTURE_SIZE: ' + u_IntToStr(oglMaxTexSize));

  glCompressedTexImage2D := gl_GetProc('glCompressedTexImage2D');
  GL_IMG_texture_compression_pvrtc := gl_IsSupported('GL_IMG_texture_compression_pvrtc', oglExtensions);
  log_Add('GL_IMG_texture_compression_pvrtc: ' + u_BoolToStr(GL_IMG_texture_compression_pvrtc));

  // Multitexturing
  glGetIntegerv(GL_MAX_TEXTURE_UNITS, @oglMaxTexUnits);
  log_Add('GL_MAX_TEXTURE_UNITS: ' + u_IntToStr(oglMaxTexUnits));

  // Anisotropy
  GL_EXT_texture_filter_anisotropic := gl_IsSupported('GL_EXT_texture_filter_anisotropic', oglExtensions);
  if GL_EXT_texture_filter_anisotropic Then
  begin
    glGetIntegerv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, @oglMaxAnisotropy);
    oglAnisotropy := oglMaxAnisotropy;
  end else
    oglAnisotropy := 0;
  log_Add('GL_EXT_texture_filter_anisotropic: ' + u_BoolToStr(GL_EXT_texture_filter_anisotropic));
  log_Add('GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT: ' + u_IntToStr(oglMaxAnisotropy));

  glBlendEquation     := gl_GetProc('glBlendEquation');
  glBlendFuncSeparate := gl_GetProc('glBlendFuncSeparate');

  {$IfDef USE_GLES20}
  GL_OES_blend_func_separate := true;
  {$Else}
  GL_OES_blend_func_separate := gl_IsSupported('GL_OES_blend_func_separate', oglExtensions);
  {$EndIf}
  oglSeparate := Assigned(glBlendEquation) and Assigned(glBlendFuncSeparate) and GL_OES_blend_func_separate;
  log_Add('glBlendEquation: ' + u_BoolToStr(Assigned(glBlendEquation)));
  log_Add('glBlendFuncSeparate: ' + u_BoolToStr(Assigned(glBlendFuncSeparate)));
  log_Add('GL_OES_blend_func_separate: ' + u_BoolToStr(GL_OES_blend_func_separate));
  log_Add('oglSeparate: ' + u_BoolToStr(oglSeparate));

  // FBO
  {$IfDef USE_GLES20}
  GL_OES_framebuffer_object := True;
  {$Else}
  GL_OES_framebuffer_object := gl_IsSupported('GL_OES_framebuffer_object', oglExtensions);
  {$EndIf}
  if GL_OES_framebuffer_object Then
  begin
    oglCanFBO                 := TRUE;
    glBindRenderbuffer        := gl_GetProc('glBindRenderbuffer'       );
    glIsRenderbuffer          := gl_GetProc('glIsRenderbuffer'         );
    glDeleteRenderbuffers     := gl_GetProc('glDeleteRenderbuffers'    );
    glGenRenderbuffers        := gl_GetProc('glGenRenderbuffers'       );
    glRenderbufferStorage     := gl_GetProc('glRenderbufferStorage'    );
    glIsFramebuffer           := gl_GetProc('glIsFramebuffer'          );
    glBindFramebuffer         := gl_GetProc('glBindFramebuffer'        );
    glDeleteFramebuffers      := gl_GetProc('glDeleteFramebuffers'     );
    glGenFramebuffers         := gl_GetProc('glGenFramebuffers'        );
    glCheckFramebufferStatus  := gl_GetProc('glCheckFramebufferStatus' );
    glFramebufferTexture2D    := gl_GetProc('glFramebufferTexture2D'   );
    glFramebufferRenderbuffer := gl_GetProc('glFramebufferRenderbuffer');

    glGetIntegerv(GL_MAX_RENDERBUFFER_SIZE, @oglMaxFBOSize);
    if oglMaxFBOSize = 0 Then
    begin
      log_Add('Tegra-based device or other shit? It returns 0 for GL_MAX_RENDERBUFFER_SIZE');
      oglMaxFBOSize := oglMaxTexSize;
    end;
    log_Add('GL_MAX_RENDERBUFFER_SIZE: ' + u_IntToStr(oglMaxFBOSize));
  end else
    oglCanFBO := FALSE;

  GL_OES_depth24 := gl_IsSupported('GL_OES_depth24', oglExtensions);
  GL_OES_depth32 := gl_IsSupported('GL_OES_depth32', oglExtensions);
  log_Add('GL_OES_FRAMEBUFFER_OBJECT: ' + u_BoolToStr(oglCanFBO));

  // WaitVSync
{$IF (not DEFINED(iOS)) and (not DEFINED(ANDROID)) }
  oglCanVSync := Assigned(eglSwapInterval);
  if oglCanVSync Then
    scr_SetVSync(scrVSync);
{$ELSE}
  oglCanVSync := FALSE;
{$IFEND}
  log_Add('Support WaitVSync: ' + u_BoolToStr(oglCanVSync));
end;

end.
