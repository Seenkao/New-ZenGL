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

 !!! modification from Serge 26.02.2022
}
unit zgl_opengl;

{$I zgl_config.cfg}
{$I GLdefine.cfg}
{$IfDef MAC_COCOA}
  {$modeswitch objectivec1}
{$EndIf}
{$IFDEF UNIX}
  {$DEFINE stdcall := cdecl}
{$ENDIF}

interface
uses
  zgl_opengl_all,
  zgl_pasOpenGL,
  zgl_gltypeconst,
  {$IFDEF LINUX}
  X, XUtil, xlib,
  zgl_glx_wgl
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  zgl_glx_wgl
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  CocoaAll,
  {$EndIf}
  MacOSAll
  {$ENDIF}
  ;

const
  TARGET_SCREEN  = 1;                    // цель - экран
  TARGET_TEXTURE = 2;                    // цель - часть экрана

// Rus: инициализация OpenGL и подготовка формата пиксела.
// Eng:
function  gl_Create: Boolean;
{$IfNDef MAC_COCOA}
// Rus: уничтожение контекста.
// Eng:
procedure gl_Destroy;
{$EndIf}
// Rus: создание контекста.
// Eng:
function  gl_Initialize: Boolean;
// Rus: возвращение к первоначальным заданным данным.
// Eng:
procedure gl_ResetState;
// Rus: проверка и загрузка расширений.
// Eng:
procedure gl_LoadEx;

var
  oglzDepth    : LongWord;
  oglStencil   : LongWord;
  oglFSAA      : LongWord;
  oglAnisotropy: LongWord;
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
  oglCanPBuffer   : Boolean;               // для MacOS доделать!!!
  oglMaxTexSize   : Integer;
  oglMaxFBOSize   : Integer;
  oglMaxAnisotropy: Integer;
  oglMaxTexUnits  : Integer;
  oglSeparate     : Boolean;

  maxGLVerMajor   : Integer = 2;
  maxGLVerMinor   : Integer = 1;

  // переделать
  contextAttr     : array[0..9] of Integer;
  contextFlags    : LongWord = 2;
  contextMask     : LongWord = 2;
  oldContext      : Boolean = true;

  {$IFDEF LINUX}
  oglXExtensions: UTF8String;
  oglPBufferMode: Integer;
  oglContext    : GLXContext;
  oglVisualInfo : PXVisualInfo;
  oglFBConfig   : GLXFBConfig;
  oglAttr       : array[0..31] of Integer = (GLX_RGBA, GL_TRUE, GLX_RED_SIZE, 8, GLX_GREEN_SIZE, 8, GLX_BLUE_SIZE, 8, GLX_ALPHA_SIZE, 8,
                                    GLX_DOUBLEBUFFER, GL_TRUE, GLX_DEPTH_SIZE, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  {$IfDef GL_VERSION_3_0}
  glxAttr       : array[0..26] of GLint = (GLX_X_RENDERABLE, GL_TRUE,
                                      GLX_DRAWABLE_TYPE, GLX_WINDOW_BIT,
                                      GLX_RENDER_TYPE, GLX_RGBA_BIT,
                                      GLX_X_VISUAL_TYPE, GLX_TRUE_COLOR,
                                      GLX_RED_SIZE, 8,
                                      GLX_GREEN_SIZE, 8,
                                      GLX_BLUE_SIZE, 8,
                                      GLX_ALPHA_SIZE, 8,
                                      GLX_DEPTH_SIZE, 24,
                                      GLX_DOUBLEBUFFER, GL_TRUE,
                                      0, 0, 0, 0, 0, 0, 0);
  {$ENDIF}{$EndIf}

  {$IFDEF WINDOWS}
  oWGLExtensions: UTF8String;
  oglContext   : HGLRC;
  oglfAttr     : array[0..1 ] of Single = (0, 0);
  ogliAttr     : array[0..31] of Integer = (WGL_ACCELERATION_ARB, WGL_FULL_ACCELERATION_ARB, WGL_DRAW_TO_WINDOW_ARB, GL_TRUE,
                                    WGL_SUPPORT_OPENGL_ARB, GL_TRUE, WGL_DOUBLE_BUFFER_ARB, GL_TRUE, WGL_PIXEL_TYPE_ARB, WGL_TYPE_RGBA_ARB,
                                    WGL_COLOR_BITS_ARB, 24, WGL_RED_BITS_ARB, 8, WGL_GREEN_BITS_ARB, 8, WGL_BLUE_BITS_ARB, 8,
                                    WGL_ALPHA_BITS_ARB, 8, WGL_DEPTH_BITS_ARB, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  oglFormat    : Integer;
  oglFormats   : LongWord;
  oglFormatDesc: TPixelFormatDescriptor;
  {$ENDIF}

  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  oglContext : NSOpenGLContext;
  oglCoreGL  : Integer;
  oglAttr    : array[0..9] of NSOpenGLPixelFormatAttribute = (NSOpenGLPFADoubleBuffer, NSOpenGLPFAColorSize, 32, NSOpenGLPFADepthSize, 32,
                        NSOpenGLPFAStencilSize, 8, NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersionLegacy, 0);
  {$Else}
  oglDevice  : GDHandle;
  oglContext : TAGLContext;
  oglFormat  : TAGLPixelFormat;
  oglAttr    : array[0..31] of LongWord;
  {$ENDIF}{$EndIf}

implementation
uses
  zgl_screen,
  zgl_window,
  zgl_log,
  zgl_utils;

function gl_Create: Boolean;
var
  i, j: Integer;
  {$IfDef LINUX}
  FBConfig: GLXFBConfig;
  PFBConfig: PGLXFBConfig;
  fbcount: Integer = 0;
  samp_buf: Integer = 0;
  samples: Integer = 0;
  best_FBconf: Integer = -1;
  worst_FBconf: Integer = -1;
  best_num_samp: Integer = -1;
  worst_num_samp: Integer = 9999;
  {$EndIf}
  {$IFDEF WINDOWS}
  pixelFormat: Integer;
  {$ENDIF}
begin
  Result := FALSE;

  if not InitGL() Then
  begin
    log_Add('Cannot load GL library');
    exit;
  end;

{$IFDEF LINUX}
  glXGetProcAddressARB := gl_GetProc('glXGetProcAddress');
  Init_GLX_WGL;

  if not glXQueryExtension(scrDisplay, i, j) Then
  begin
    u_Error('GLX Extension not found');
    exit;
  end
  else
    log_Add('GLX Extension - ok');

  // PBUFFER or OpenGL 3+
  if GLX_VERSION_1_4 or GLX_VERSION_1_3 then
    oglPBufferMode := 1
  else
    if GLX_SGIX_fbconfig and GLX_SGIX_pbuffer Then
        oglPBufferMode := 2
    else
      oglPBufferMode := 0;
  oglCanPBuffer := oglPBufferMode <> 0;
  if oglPBufferMode = 2 Then
    log_Add('GLX_SGIX_PBUFFER: TRUE')
  else
    log_Add('GLX_PBUFFER: ' + u_BoolToStr(oglCanPBuffer));

  case oglPBufferMode of
    1:
      begin
        glXGetVisualFromFBConfig := gl_GetProc('glXGetVisualFromFBConfig');
        glXChooseFBConfig        := gl_GetProc('glXChooseFBConfig');
        glXCreatePbuffer         := gl_GetProc('glXCreatePbuffer');
        glXDestroyPbuffer        := gl_GetProc('glXDestroyPbuffer');
      end;
    2:
      begin
        glXGetVisualFromFBConfig := gl_GetProc('glXGetVisualFromFBConfigSGIX');
        glXChooseFBConfig        := gl_GetProc('glXChooseFBConfigSGIX');
        glXCreateGLXPbufferSGIX  := gl_GetProc('glXCreateGLXPbufferSGIX');
        glXDestroyGLXPbufferSGIX := gl_GetProc('glXDestroyGLXPbufferSGIX');
      end;
  end;

  {$IfDef GL_VERSION_3_0}
  if maxGLVerMajor >= 3 then
  begin
    oldContext := False;
    i := 20;
    FillChar(glxAttr[20], 5 * 4, None);
    if oglStencil > 0 then
    begin
      glxAttr[i] := GLX_STENCIL_SIZE;
      glxAttr[i + 1] := oglStencil;
      inc(i, 2);
    end;
    if oglFSAA > 0 then
    begin
      glxAttr[i] := GLX_SAMPLES_SGIS;
      glxAttr[i + 1] := oglFSAA;
    end;
    PFBConfig := @FBConfig;
    PFBConfig := glXChooseFBConfig(scrDisplay, scrDefault, @glxAttr[0], fbcount);
    if not Assigned(PFBConfig) or (fbcount = 0) then
    begin
      log_Add('Attribs for OpenGL 3+ not used.');
      //exit;  //????
    end;
    for i := 0 to fbcount - 1 do
    begin
      oglVisualInfo := glXGetVisualFromFBConfig(scrDisplay, PFBConfig[i]);
      if Assigned(oglVisualInfo) then
      begin
        glXGetFBConfigAttrib(scrDisplay, PFBConfig[i], GLX_SAMPLE_BUFFERS, samp_buf);
        glXGetFBConfigAttrib(scrDisplay, PFBConfig[i], GLX_SAMPLES, samples);
        if (best_FBconf < 0) or ((samp_buf and samples) > best_num_samp) then
        begin
          best_FBconf := i;
          best_num_samp := samples;
        end;
        if (worst_FBconf < 0) or ((not samp_buf or samples) < worst_num_samp) then
        begin
          worst_FBconf := i;
          worst_num_samp := samples;
        end;
      end;
      XFree(oglVisualInfo);
    end;
    oglFBConfig := PFBConfig[best_FBconf];
    XFree(PFBConfig);
    oglVisualInfo := glXGetVisualFromFBConfig(scrDisplay, oglFBConfig);
    if not Assigned(oglVisualInfo) then
    begin
      log_Add('Could not create correct visual window fo OpenGL 3+.');
      oldContext := true;
    end;
    if scrDefault <> oglVisualInfo^.screen then
    begin
      log_Add('screenID(' + u_IntToStr(scrDefault) + ') does not match visual->screen(' + u_IntToStr(oglVisualInfo^.screen) + ').');
      oldContext := true;
    end;
  end;
  {$EndIf}

  if oldContext then
  begin
    // for old context
    oglzDepth := 24;
    repeat
      FillChar(oglAttr[14], (32 - 14) * 4, None);
      i := 14;
      if oglStencil > 0 Then
      begin
        oglAttr[i] := GLX_STENCIL_SIZE;
        oglAttr[i + 1] := oglStencil;
        INC(i, 2);
      end;
      if oglFSAA > 0 Then
      begin
        oglAttr[i] := GLX_SAMPLES_SGIS;
        oglAttr[i + 1] := oglFSAA;
      end;

      log_Add('glXChooseVisual: zDepth = ' + u_IntToStr(oglzDepth) + '; ' + 'stencil = ' + u_IntToStr(oglStencil) + '; ' + 'fsaa = ' + u_IntToStr(oglFSAA));
      oglVisualInfo := glXChooseVisual(scrDisplay, scrDefault, @oglAttr[0]);
      if (not Assigned(oglVisualInfo) and (oglzDepth = 1)) Then
      begin
        if oglFSAA = 0 Then
          break
        else
        begin
          oglzDepth := 24;
          DEC(oglFSAA, 2);
        end;
      end else
        if not Assigned(oglVisualInfo) Then
          DEC(oglzDepth, 8);
    if oglzDepth = 0 Then
      oglzDepth := 1;
    until Assigned(oglVisualInfo);
  end;

  if not Assigned(oglVisualInfo) Then
  begin
    u_Error('Cannot choose visual info.');
    exit;
  end;
{$ENDIF}
{$IFDEF WINDOWS}
  wnd_Create();

  FillChar(oglFormatDesc, SizeOf(TPixelFormatDescriptor), 0);
  with oglFormatDesc do
  begin
    nSize        := SizeOf(TPIXELFORMATDESCRIPTOR);
    nVersion     := 1;
    dwFlags      := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
    iPixelType   := PFD_TYPE_RGBA;
    cColorBits   := 24;
    cAlphabits   := 8;
    cDepthBits   := 24;
    cStencilBits := oglStencil;
    iLayerType   := PFD_MAIN_PLANE;
  end;

  pixelFormat := ChoosePixelFormat(wndDC, @oglFormatDesc);
  if pixelFormat = 0 Then
  begin
    u_Error('Cannot choose pixel format');
    exit;
  end;

  if not SetPixelFormat(wndDC, pixelFormat, @oglFormatDesc) Then
  begin
    u_Error('Cannot set pixel format');
    exit;
  end;

  oglContext := wglCreateContext(wndDC);
  if (oglContext = 0) Then
  begin
    u_Error('Cannot create OpenGL context');
    exit;
  end;

  if not wglMakeCurrent(wndDC, oglContext) Then
  begin
    u_Error('Cannot set current OpenGL context');
    exit;
  end;

  wglGetExtensionsStringARB := gl_GetProc('wglGetExtensionsString');
  if Assigned(wglGetExtensionsStringARB) then
  begin
    oWGLExtensions := wglGetExtensionsStringARB(wndDC);
    log_Add('All extensions: ' + oWGLExtensions);
  end;
  CheckGLVersion;
  log_Add(u_IntToStr(use_glMajorVer) + '.' + u_IntToStr(use_glMinorVer));
  oglExtensions := '';
  {$IfDef GL_VERSION_3_0}
  if use_glMajorVer >= 3 then
  begin
    if not Assigned(glGetStringi) then
      glGetStringi := gl_GetProc('glGetStringi');
    if Assigned(glGetStringi) then
    begin
      glGetIntegerv(GL_NUM_EXTENSIONS, @j);
      for i := 0 to j - 1 do
        oglExtensions := oglExtensions + PAnsiChar(glGetStringi(GL_EXTENSIONS, i)) + #32;
    end;
  end;
  {$EndIf}
  if oglExtensions = '' then
    oglExtensions := glGetString(GL_EXTENSIONS);
  log_Add(oglExtensions);
  Init_GLX_WGL;
  LoadOpenGL;

  wglChoosePixelFormatARB := gl_GetProc('wglChoosePixelFormat');
  if Assigned(wglChoosePixelFormatARB) Then
  begin
    oglzDepth := 24;
    repeat
      FillChar(ogliAttr[22], (32 - 22) * 4, 0);
      i := 22;
      if oglStencil > 0 Then
      begin
        ogliAttr[i] := WGL_STENCIL_BITS_ARB;
        ogliAttr[i + 1] := oglStencil;
        inc(i, 2);
      end;
      if oglFSAA > 0 Then
      begin
        ogliAttr[i] := WGL_SAMPLE_BUFFERS_ARB;
        ogliAttr[i + 1] := GL_TRUE;
        ogliAttr[i + 2] := WGL_SAMPLES_ARB;
        ogliAttr[i + 3] := oglFSAA;
      end;

      log_Add('wglChoosePixelFormatARB: zDepth = ' + u_IntToStr(oglzDepth) + '; ' + 'stencil = ' + u_IntToStr(oglStencil) + '; ' + 'fsaa = ' + u_IntToStr(oglFSAA));
      wglChoosePixelFormatARB(wndDC, @ogliAttr, @oglfAttr, 1, @oglFormat, @oglFormats);
      if (oglFormat = 0) and (oglzDepth < 16) Then
      begin
        if oglFSAA <= 0 Then
          break
        else
        begin
          oglzDepth := 24;
          DEC(oglFSAA, 2);
        end;
      end else
        DEC(oglzDepth, 8);
    until oglFormat <> 0;
  end;

  if oglFormat = 0 Then
  begin
    oglzDepth := 24;
    oglFSAA   := 0;
    oglFormat := pixelFormat;
    log_Add('ChoosePixelFormat: zDepth = ' + u_IntToStr(oglzDepth) + '; ' + 'stencil = ' + u_IntToStr(oglStencil));
  end;

  wglMakeCurrent(wndDC, 0);
  wglDeleteContext(oglContext);
  wnd_Destroy();
//  wndFirst := FALSE;
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}

{$Else}
  if not InitAGL() Then
  begin
    log_Add('Cannot load AGL library');
    exit;
  end;

  oglzDepth := 24;
  repeat
    FillChar(oglAttr[0], Length(oglAttr) * 4, AGL_NONE);
    oglAttr[0] := AGL_RGBA;
    oglAttr[1] := AGL_RED_SIZE;
    oglAttr[2] := 8;
    oglAttr[3] := AGL_GREEN_SIZE;
    oglAttr[4] := 8;
    oglAttr[5] := AGL_BLUE_SIZE;
    oglAttr[6] := 8;
    oglAttr[7] := AGL_ALPHA_SIZE;
    oglAttr[8] := 8;
    oglAttr[9] := AGL_DOUBLEBUFFER;
    oglAttr[10] := AGL_DEPTH_SIZE;
    oglAttr[11] := oglzDepth;
    i := 12;
    if oglStencil > 0 Then
    begin
      oglAttr[i] := AGL_STENCIL_SIZE;
      oglAttr[i + 1] := oglStencil;
      inc(i, 2);
    end;
    if oglFSAA > 0 Then
    begin
      oglAttr[i] := AGL_SAMPLE_BUFFERS_ARB;
      oglAttr[i + 1] := 1;
      oglAttr[i + 2] := AGL_SAMPLES_ARB;
      oglAttr[i + 3] := oglFSAA;
    end;

    log_Add('aglChoosePixelFormat: zDepth = ' + u_IntToStr(oglzDepth) + '; ' + 'stencil = ' + u_IntToStr(oglStencil) + '; ' + 'fsaa = ' + u_IntToStr(oglFSAA));
    DMGetGDeviceByDisplayID(DisplayIDType(scrDisplay), oglDevice, FALSE);
    oglFormat := aglChoosePixelFormat(@oglDevice, 1, @oglAttr[0]);
    if (not Assigned(oglFormat) and (oglzDepth = 1)) Then
    begin
      if oglFSAA = 0 Then
        break
      else
      begin
        oglzDepth := 24;
        DEC(oglFSAA, 2);
      end;
    end else
      if not Assigned(oglFormat) Then
        DEC(oglzDepth, 8);
    if oglzDepth = 0 Then
      oglzDepth := 1;
  until Assigned(oglFormat);

  if not Assigned(oglFormat) Then
  begin
    u_Error('Cannot choose pixel format.');
    exit;
  end;
{$ENDIF}{$EndIf}
  Result := TRUE;
end;

{$IfNDef MAC_COCOA}
procedure gl_Destroy;
begin
{$IFDEF LINUX}
  if not glXMakeCurrent(scrDisplay, None, nil) Then
    u_Error('Cannot release current OpenGL context');

  glXDestroyContext(scrDisplay, oglContext);
{$ENDIF}
{$IFDEF WINDOWS}
  if not wglMakeCurrent(wndDC, 0) Then
    u_Error('Cannot release current OpenGL context');

  wglDeleteContext(oglContext);
{$ENDIF}
{$IFDEF MACOSX}
  aglDestroyPixelFormat(oglFormat);
  if aglSetCurrentContext(nil) = GL_FALSE Then
    u_Error('Cannot release current OpenGL context');

  aglDestroyContext(oglContext);
  FreeAGL();
{$ENDIF}

  FreeGL();
end;
{$EndIf}

function gl_Initialize: Boolean;
{$IfDef MAC_COCOA}
var
  pixfmt: NSOpenGLPixelFormat;
{$EndIf}
begin
  Result := FALSE;
{$IFDEF LINUX}
  if oldContext then
  begin
    oglContext := glXCreateContext(scrDisplay, oglVisualInfo, nil, GL_TRUE);
    if not Assigned(oglContext) Then
    begin
      oglContext := glXCreateContext(scrDisplay, oglVisualInfo, nil, GL_FALSE);
      if not Assigned(oglContext) Then
      begin
        u_Error('Cannot create OpenGL context');
        exit;
      end;
    end;
  end
  else begin
    contextAttr[0] := GLX_CONTEXT_MAJOR_VERSION_ARB;
    contextAttr[1] := maxGLVerMajor;
    contextAttr[2] := GLX_CONTEXT_MINOR_VERSION_ARB;
    contextAttr[3] := maxGLVerMinor;
    contextAttr[4] := GLX_CONTEXT_FLAGS_ARB;
    contextAttr[5] := contextFlags;
    contextAttr[6] := GLX_CONTEXT_PROFILE_MASK_ARB;
    contextAttr[7] := contextMask;
    contextAttr[8] := 0;
    if GLX_ARB_create_context then
    begin
      oglContext := glXCreateContextAttribsARB(scrDisplay, oglFBConfig, nil, true, @contextAttr[0]);
      if not Assigned(oglContext) then
        oglContext := glXCreateContextAttribsARB(scrDisplay, oglFBConfig, nil, false, @contextAttr[0]);
      if not Assigned(oglContext) Then
      begin
        u_Error('Cannot create OpenGL context');
        exit;
      end;
    end
    else begin
      oglContext := glXCreateNewContext(scrDisplay, oglFBConfig, GLX_RGBA_TYPE, nil, GL_TRUE);
      if not Assigned(oglContext) then
        oglContext := glXCreateNewContext(scrDisplay, oglFBConfig, GLX_RGBA_TYPE, nil, GL_FALSE);
      if not Assigned(oglContext) Then
      begin
        u_Error('Cannot create OpenGL context');
        exit;
      end;
    end;
  end;
  if not glXMakeCurrent(scrDisplay, wndHandle, oglContext) Then
  begin
    u_Error('Cannot set current OpenGL context');
    exit;
  end;
  CheckGLVersion;
  LoadOpenGL;
{$ENDIF}
{$IFDEF WINDOWS}
  if not SetPixelFormat(wndDC, oglFormat, @oglFormatDesc) Then
  begin
    u_Error('Cannot set pixel format');
    exit;
  end;
  oglContext := 0;
  {$IfDef GL_VERSION_3_0}
  if GL_VERSION_3_0 and Assigned(wglCreateContextAttribsARB) then
  begin
    contextAttr[0] := WGL_CONTEXT_MAJOR_VERSION_ARB;
    contextAttr[1] := use_glMajorVer;
    contextAttr[2] := WGL_CONTEXT_MINOR_VERSION_ARB;
    contextAttr[3] := use_glMinorVer;
    contextAttr[4] := WGL_CONTEXT_PROFILE_MASK_ARB;
    contextAttr[5] := contextMask;
    contextAttr[6] := WGL_CONTEXT_FLAGS_ARB;
    contextAttr[7] := contextFlags;
    contextAttr[8] := 0;
    oglContext := wglCreateContextAttribsARB(wndDC, 0, @contextAttr[0]);
  end;
  if oglContext = 0 then
  begin
    if (GL_ARB_compatibility and (use_glMajorVer >= 3)) or (use_glMajorVer <= 2) then
      oglContext := wglCreateContext(wndDC)
    else begin
      u_Error('Cannot create OpenGL context 3+');
      Exit;
    end;
  end;
  {$Else}
  oglContext := wglCreateContext(wndDC);
  {$EndIf}
  if (oglContext = 0) Then
  begin
    u_Error('Cannot create OpenGL context');
    exit;
  end;
  if not wglMakeCurrent(wndDC, oglContext) Then
  begin
    u_Error('Cannot set current OpenGL context');
    exit;
  end;
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  pixfmt := NSOpenGLPixelFormat.alloc.initWithAttributes(@oglAttr);
  oglContext := NSOpenGLContext.alloc.initWithFormat_shareContext(pixfmt, nil);
  pixfmt.release;
  oglContext.makeCurrentContext;

  oglContext.setView(zglView);
{$Else}
  oglContext := aglCreateContext(oglFormat, nil);
  if not Assigned(oglContext) Then
    begin
      u_Error('Cannot create OpenGL context');
      exit;
    end;
  if aglSetDrawable(oglContext, GetWindowPort(wndHandle)) = GL_FALSE Then
    begin
      u_Error('Cannot set Drawable');
      exit;
    end;
  if aglSetCurrentContext(oglContext) = GL_FALSE Then
    begin
      u_Error('Cannot set current OpenGL context');
      exit;
    end;
{$ENDIF}{$EndIf}

  oglRenderer := glGetString(GL_RENDERER);
  log_Add('GL_VERSION: ' + glGetString(GL_VERSION));
  log_Add('GL_RENDERER: ' + oglRenderer);

{$IFDEF LINUX}
  ogl3DAccelerator := oglRenderer <> 'Software Rasterizer';
{$ENDIF}
{$IFDEF WINDOWS}
  ogl3DAccelerator := oglRenderer <> 'GDI Generic';
{$ENDIF}
{$IFDEF MACOSX}
  ogl3DAccelerator := oglRenderer <> 'Apple Software Renderer';
{$ENDIF}
  if not ogl3DAccelerator Then
    u_Warning('Cannot find 3D-accelerator! Application run in software-mode, it''s very slow');

  gl_LoadEx();
  gl_ResetState();

  Result := TRUE;
end;

procedure gl_ResetState;
begin
  glHint(GL_LINE_SMOOTH_HINT,            GL_NICEST);
  glHint(GL_POLYGON_SMOOTH_HINT,         GL_NICEST);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
  glHint(GL_FOG_HINT,                    GL_DONT_CARE);
  glShadeModel(GL_SMOOTH);

  glClearColor(0, 0, 0, 0);

  glDepthFunc (GL_LEQUAL);
  glClearDepth(1.0);

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
  // Texture size
  glGetIntegerv(GL_MAX_TEXTURE_SIZE, @oglMaxTexSize);
  log_Add('GL_MAX_TEXTURE_SIZE: ' + u_IntToStr(oglMaxTexSize));

  glCompressedTexImage2D := gl_GetProc('glCompressedTexImage2D');
  log_Add('GL_EXT_TEXTURE_COMPRESSION_S3TC: ' + u_BoolToStr(GL_EXT_texture_compression_s3tc));

  log_Add('GL_SGIS_GENERATE_MIPMAP: ' + u_BoolToStr(GL_SGIS_generate_mipmap));

  // Multitexturing
  glGetIntegerv(GL_MAX_TEXTURE_UNITS_ARB, @oglMaxTexUnits);
  log_Add('GL_MAX_TEXTURE_UNITS_ARB: ' + u_IntToStr(oglMaxTexUnits));

  // Anisotropy
  if GL_EXT_texture_filter_anisotropic Then
  begin
    glGetIntegerv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, @oglMaxAnisotropy);
    oglAnisotropy := oglMaxAnisotropy;
  end else
    oglAnisotropy := 0;
  log_Add('GL_EXT_TEXTURE_FILTER_ANISOTROPIC: ' + u_BoolToStr(GL_EXT_texture_filter_anisotropic));
  log_Add('GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT: ' + u_IntToStr(oglMaxAnisotropy));

  glBlendEquation     := gl_GetProc('glBlendEquation');
  glBlendFuncSeparate := gl_GetProc('glBlendFuncSeparate');
  // separator
  oglSeparate := Assigned(glBlendEquation) and Assigned(glBlendFuncSeparate) and GL_EXT_blend_func_separate;
  log_Add('GL_EXT_BLEND_FUNC_SEPARATE: ' + u_BoolToStr(oglSeparate));

  // FBO
  glBindRenderbuffer := gl_GetProc('glBindRenderbuffer');
  if Assigned(glBindRenderbuffer) Then
  begin
    oglCanFBO                 := TRUE;
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
    log_Add('GL_MAX_RENDERBUFFER_SIZE: ' + u_IntToStr(oglMaxFBOSize));
  end else
    oglCanFBO := FALSE;
   log_Add('GL_EXT_FRAMEBUFFER_OBJECT: ' + u_BoolToStr(oglCanFBO));

{$IFDEF WINDOWS}
  if Assigned(wglCreatePbufferARB) and Assigned(wglChoosePixelFormatARB) Then
  begin
    oglCanPBuffer          := TRUE;
    wglGetPbufferDCARB     := gl_GetProc('wglGetPbufferDC'    );
    wglReleasePbufferDCARB := gl_GetProc('wglReleasePbufferDC');
    wglDestroyPbufferARB   := gl_GetProc('wglDestroyPbuffer'  );
    wglQueryPbufferARB     := gl_GetProc('wglQueryPbuffer');
  end else
    oglCanPBuffer := FALSE;
  log_Add('WGL_PBUFFER: ' + u_BoolToStr(oglCanPBuffer));
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  oglCanPBuffer := Assigned(aglCreatePBuffer);
  log_Add('AGL_PBUFFER: ' + u_BoolToStr(oglCanPBuffer));
{$ENDIF}{$EndIf}

  // WaitVSync
{$IFDEF LINUX}
  glXSwapIntervalSGI := gl_GetProc('glXSwapIntervalSGI');
  oglCanVSync        := Assigned(glXSwapIntervalSGI);
{$ENDIF}
{$IFDEF WINDOWS}
  wglSwapIntervalEXT := gl_GetProc('wglSwapInterval');
  oglCanVSync     := Assigned(wglSwapIntervalEXT);
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  if aglSetInt(oglContext, AGL_SWAP_INTERVAL, 1) = GL_TRUE Then
    oglCanVSync := TRUE
  else
    oglCanVSync := FALSE;
  aglSetInt(oglContext, AGL_SWAP_INTERVAL, Byte(scrVSync));
{$ENDIF}{$EndIf}
  if oglCanVSync Then
    scr_VSync;
  log_Add('Support WaitVSync: ' + u_BoolToStr(oglCanVSync));
end;

end.

