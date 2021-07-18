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

 !!! modification from Serge 04.08.2020
}
unit zgl_opengl;

{$I zgl_config.cfg}
{$IfDef MAC_COCOA}
  {$modeswitch objectivec1}
{$EndIf}
{$IFDEF UNIX}
  {$DEFINE stdcall := cdecl}
{$ENDIF}

interface
uses
  zgl_opengl_all,
  {$IFDEF LINUX}
  X, XUtil
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  CocoaAll,
  {$EndIf}
  MacOSAll
  {$ENDIF}
  ;

const
  TARGET_SCREEN  = 1;
  TARGET_TEXTURE = 2;
  {$IfDef MACOSX}
  CORE_2_1 = 1;
  CORE_3_2 = 2;
  CORE_4_1 = 3;
  {$EndIf}

function  gl_Create: Boolean;
{$IfNDef MAC_COCOA}
procedure gl_Destroy;
{$Else}
procedure gl_SetCoreGL(mode: Byte);
{$EndIf}
function  gl_Initialize: Boolean;
procedure gl_ResetState;
procedure gl_LoadEx;

var
  glCompressedTexImage2D: procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; imageSize: GLsizei; const pixels: Pointer); stdcall;
  glBlendEquation: procedure(mode: GLenum); stdcall;
  glBlendFuncSeparate: procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;

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
  oglCanAnisotropy: Boolean;
  oglCanS3TC      : Boolean;
  oglCanAutoMipMap: Boolean;
  oglCanFBO       : Boolean;
  oglCanPBuffer   : Boolean;
  oglMaxTexSize   : Integer;
  oglMaxFBOSize   : Integer;
  oglMaxAnisotropy: Integer;
  oglMaxTexUnits  : Integer;
  oglSeparate     : Boolean;

  {$IFDEF LINUX}
  oglXExtensions: UTF8String;
  oglPBufferMode: Integer;
  oglContext    : GLXContext;
  oglVisualInfo : PXVisualInfo;
  oglAttr       : array[0..31] of Integer;
  {$ENDIF}

  {$IFDEF WINDOWS}
  oglContext   : HGLRC;
  oglfAttr     : array[0..1 ] of Single = (0, 0);
  ogliAttr     : array[0..31] of Integer;
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
  zgl_application,
  zgl_screen,
  zgl_window,
  zgl_log,
  zgl_utils;

function gl_Create: Boolean;
  var
  {$IFDEF LINUX}
    i, j: Integer;
  {$ENDIF}
  {$IFDEF WINDOWS}
    i          : Integer;
    pixelFormat: Integer;
  {$ENDIF}
  {$IFDEF MACOSX}
    i: Integer;
  {$ENDIF}
begin
  Result := FALSE;

  if not InitGL() Then
    begin
      log_Add('Cannot load GL library');
      exit;
    end;

{$IFDEF LINUX}
  if not glXQueryExtension(scrDisplay, i, j) Then
    begin
      u_Error('GLX Extension not found');
      exit;
    end else log_Add('GLX Extension - ok');

  oglzDepth := 24;
  repeat
    FillChar(oglAttr[0], Length(oglAttr) * 4, None);
    oglAttr[0] := GLX_RGBA;
    oglAttr[1] := GL_TRUE;
    oglAttr[2] := GLX_RED_SIZE;
    oglAttr[3] := 8;
    oglAttr[4] := GLX_GREEN_SIZE;
    oglAttr[5] := 8;
    oglAttr[6] := GLX_BLUE_SIZE;
    oglAttr[7] := 8;
    oglAttr[8] := GLX_ALPHA_SIZE;
    // NVIDIA sucks!
    oglAttr[9] := 8; // * Byte(not appInitedToHandle);
    oglAttr[10] := GLX_DOUBLEBUFFER;
    oglAttr[11] := GL_TRUE;
    oglAttr[12] := GLX_DEPTH_SIZE;
    oglAttr[13] := oglzDepth;
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
        if not Assigned(oglVisualInfo) Then DEC(oglzDepth, 8);
  if oglzDepth = 0 Then oglzDepth := 1;
  until Assigned(oglVisualInfo);

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

  wglChoosePixelFormatARB := gl_GetProc('wglChoosePixelFormatARB');
  if Assigned(wglChoosePixelFormatARB) Then
    begin
      oglzDepth := 24;
      repeat
        FillChar(ogliAttr[0], Length(ogliAttr) * 4, 0);
        ogliAttr[0] := WGL_ACCELERATION_ARB;
        ogliAttr[1] := WGL_FULL_ACCELERATION_ARB;
        ogliAttr[2] := WGL_DRAW_TO_WINDOW_ARB;
        ogliAttr[3] := GL_TRUE;
        ogliAttr[4] := WGL_SUPPORT_OPENGL_ARB;
        ogliAttr[5] := GL_TRUE;
        ogliAttr[6] := WGL_DOUBLE_BUFFER_ARB;
        ogliAttr[7] := GL_TRUE;
        ogliAttr[8] := WGL_PIXEL_TYPE_ARB;
        ogliAttr[9] := WGL_TYPE_RGBA_ARB;
        ogliAttr[10] := WGL_COLOR_BITS_ARB;
        ogliAttr[11] := 24;
        ogliAttr[12] := WGL_RED_BITS_ARB;
        ogliAttr[13] := 8;
        ogliAttr[14] := WGL_GREEN_BITS_ARB;
        ogliAttr[15] := 8;
        ogliAttr[16] := WGL_BLUE_BITS_ARB;
        ogliAttr[17] := 8;
        ogliAttr[18] := WGL_ALPHA_BITS_ARB;
        ogliAttr[19] := 8;
        ogliAttr[20] := WGL_DEPTH_BITS_ARB;
        ogliAttr[21] := oglzDepth;
        if oglStencil > 0 Then
          begin
            ogliAttr[22] := WGL_STENCIL_BITS_ARB;
            ogliAttr[23] := oglStencil;
          end;
        if oglFSAA > 0 Then
          begin
            ogliAttr[24] := WGL_SAMPLE_BUFFERS_ARB;
            ogliAttr[25] := GL_TRUE;
            ogliAttr[26] := WGL_SAMPLES_ARB;
            ogliAttr[27] := oglFSAA;
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
    if oglStencil > 0 Then
    begin
      oglAttr[12] := AGL_STENCIL_SIZE;
      oglAttr[13] := oglStencil;
    end;
    if oglFSAA > 0 Then
    begin
      oglAttr[14] := AGL_SAMPLE_BUFFERS_ARB;
      oglAttr[15] := 1;
      oglAttr[16] := AGL_SAMPLES_ARB;
      oglAttr[17] := oglFSAA;
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
        if not Assigned(oglFormat) Then DEC(oglzDepth, 8);
  if oglzDepth = 0 Then oglzDepth := 1;
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
  oglContext := glXCreateContext(scrDisplay, oglVisualInfo, nil, TRUE);
  if not Assigned(oglContext) Then
  begin
    oglContext := glXCreateContext(scrDisplay, oglVisualInfo, nil, FALSE);
    if not Assigned(oglContext) Then
    begin
      u_Error('Cannot create OpenGL context');
      exit;
    end;
  end;
  if not glXMakeCurrent(scrDisplay, wndHandle, oglContext) Then
  begin
    u_Error('Cannot set current OpenGL context');
    exit;
  end;
{$ENDIF}
{$IFDEF WINDOWS}
  if not SetPixelFormat(wndDC, oglFormat, @oglFormatDesc) Then
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
  {$IFDEF LINUX}
  var
    i, j: Integer;
  {$ENDIF}
begin
  oglExtensions := glGetString(GL_EXTENSIONS);

  // Texture size
  glGetIntegerv(GL_MAX_TEXTURE_SIZE, @oglMaxTexSize);
  log_Add('GL_MAX_TEXTURE_SIZE: ' + u_IntToStr(oglMaxTexSize));

  glCompressedTexImage2D := gl_GetProc('glCompressedTexImage2D');
  oglCanS3TC := gl_IsSupported('GL_EXT_texture_compression_s3tc', oglExtensions);
  log_Add('GL_EXT_TEXTURE_COMPRESSION_S3TC: ' + u_BoolToStr(oglCanS3TC));

  oglCanAutoMipMap := gl_IsSupported('GL_SGIS_generate_mipmap', oglExtensions);
  log_Add('GL_SGIS_GENERATE_MIPMAP: ' + u_BoolToStr(oglCanAutoMipMap));

  // Multitexturing
  glGetIntegerv(GL_MAX_TEXTURE_UNITS_ARB, @oglMaxTexUnits);
  log_Add('GL_MAX_TEXTURE_UNITS_ARB: ' + u_IntToStr(oglMaxTexUnits));

  // Anisotropy
  oglCanAnisotropy := gl_IsSupported('GL_EXT_texture_filter_anisotropic', oglExtensions);
  if oglCanAnisotropy Then
  begin
    glGetIntegerv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, @oglMaxAnisotropy);
    oglAnisotropy := oglMaxAnisotropy;
  end else
    oglAnisotropy := 0;
  log_Add('GL_EXT_TEXTURE_FILTER_ANISOTROPIC: ' + u_BoolToStr(oglCanAnisotropy));
  log_Add('GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT: ' + u_IntToStr(oglMaxAnisotropy));

  glBlendEquation     := gl_GetProc('glBlendEquation');
  glBlendFuncSeparate := gl_GetProc('glBlendFuncSeparate');
  // separator
  oglSeparate := Assigned(glBlendEquation) and Assigned(glBlendFuncSeparate) and gl_IsSupported('GL_EXT_blend_func_separate', oglExtensions);
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

  // PBUFFER
{$IFDEF LINUX}
  oglxExtensions := glXQueryServerString(scrDisplay, scrDefault, GLX_EXTENSIONS);
  glXQueryVersion(scrDisplay, i, j);
  if (i * 10 + j >= 13) Then
    oglPBufferMode := 1
  else
    if gl_IsSupported('GLX_SGIX_fbconfig', oglXExtensions) and gl_IsSupported('GLX_SGIX_pbuffer', oglXExtensions) Then
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
{$ENDIF}
{$IFDEF WINDOWS}
  wglCreatePbufferARB := gl_GetProc('wglCreatePbuffer');
  if Assigned(wglCreatePbufferARB) and Assigned(wglChoosePixelFormatARB) Then
  begin
    oglCanPBuffer          := TRUE;
    wglGetPbufferDCARB     := gl_GetProc('wglGetPbufferDC'    );
    wglReleasePbufferDCARB := gl_GetProc('wglReleasePbufferDC');
    wglDestroyPbufferARB   := gl_GetProc('wglDestroyPbuffer'  );
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
  wglSwapInterval := gl_GetProc('wglSwapInterval');
  oglCanVSync     := Assigned(wglSwapInterval);
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  if aglSetInt(oglContext, AGL_SWAP_INTERVAL, 1) = GL_TRUE Then
    oglCanVSync := TRUE
  else
    oglCanVSync := FALSE;
  aglSetInt(oglContext, AGL_SWAP_INTERVAL, Byte(scrVSync));
{$ENDIF}{$EndIf}
  if oglCanVSync Then
    scr_VSync;                          // prikolno... super funkciya
  log_Add('Support WaitVSync: ' + u_BoolToStr(oglCanVSync));
end;

{$IfDef MACOSX}
procedure gl_SetCoreGL(mode: Byte);
begin
  if mode = CORE_3_2 then
  begin
    oglAttr[8] := $3200;
    exit;
  end;
  if mode = CORE_4_1 then
  begin
    oglAttr[8] := $4100;
    exit;
  end;
  oglAttr[8] := $1000;
end;
{$EndIf}

end.

