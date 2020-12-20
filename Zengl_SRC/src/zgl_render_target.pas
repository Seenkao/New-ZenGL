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
unit zgl_render_target;

{$I zgl_config.cfg}

interface
uses
  {$IFDEF USE_X11}
  X, XLib, XUtil,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF MACOSX}
  MacOSAll,
  {$ENDIF}
  zgl_types,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_textures;

const
  RT_TYPE_PBUFFER = 0;
  RT_TYPE_FBO     = 1;

  RT_DEFAULT      = $00;
  RT_FULL_SCREEN  = $01;
  RT_USE_DEPTH    = $02;
  RT_CLEAR_COLOR  = $04;
  RT_CLEAR_DEPTH  = $08;

  RT_FORCE_PBUFFER = $100000;

type
  zglPRenderTarget = ^zglTRenderTarget;
  zglTRenderTarget = record
    Type_     : Byte;
    Handle    : Pointer;
    Surface   : zglPTexture;
    Flags     : Byte;

    prev, next: zglPRenderTarget;
end;

type
  zglPRenderTargetManager = ^zglTRenderTargetManager;
  zglTRenderTargetManager = record
    Count: Integer;
    First: zglTRenderTarget;
end;

type
  zglTRenderCallback = procedure(Data: Pointer);

{$IfNDef MAC_COCOA}
function  rtarget_Add(Surface: zglPTexture; Flags: Byte): zglPRenderTarget;
procedure rtarget_Del(var Target: zglPRenderTarget);
procedure rtarget_Set(Target: zglPRenderTarget);
procedure rtarget_DrawIn(Target: zglPRenderTarget; RenderCallback: zglTRenderCallback; Data: Pointer);
{$EndIf}
{$IFDEF ANDROID}
procedure rtarget_Restore(var Target: zglPRenderTarget);
{$ENDIF}

var
  managerRTarget: zglTRenderTargetManager;

implementation
uses
  zgl_application,
  zgl_window,
  zgl_screen,
  zgl_render,
  zgl_render_2d,
  zgl_sprite_2d,
  zgl_log,
  zgl_utils;

{$IFNDEF USE_GLES}
{$IFDEF USE_X11}
type
  zglPPBuffer = ^zglTPBuffer;
  zglTPBuffer = record
    Handle : Integer;
    Context: GLXContext;
    PBuffer: GLXPBuffer;
end;
{$ENDIF}
{$IFDEF WINDOWS}
type
  zglPPBuffer = ^zglTPBuffer;
  zglTPBuffer = record
    Handle: THandle;
    DC    : HDC;
    RC    : HGLRC;
end;
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
type
  zglPPBuffer = ^zglTPBuffer;
  zglTPBuffer = record
    Context: TAGLContext;
    PBuffer: TAGLPbuffer;
  end;
{$ENDIF}{$EndIf}
{$ENDIF}

type
  zglPFBO = ^zglTFBO;
  zglTFBO = record
    FrameBuffer : LongWord;
    RenderBuffer: LongWord;
  end;

var
  lRTarget: zglPRenderTarget;
  lGLW    : Integer;
  lGLH    : Integer;
  lResCX  : Single;
  lResCY  : Single;

{$IfNDef MAC_COCOA}
function rtarget_Add(Surface: zglPTexture; Flags: Byte): zglPRenderTarget;
  var
    i, type_: Integer;
    pFBO    : zglPFBO;
{$IFNDEF USE_GLES}
    pPBuffer: zglPPBuffer;
  {$IFDEF USE_X11}
    n           : Integer;
    fbconfig    : GLXFBConfig;
    visualinfo  : PXVisualInfo;
    pbufferiAttr: array[0..15] of Integer;
    fbconfigAttr: array[0..31] of Integer;
  {$ENDIF}
  {$IFDEF WINDOWS}
    pbufferiAttr: array[0..31] of Integer;
    pbufferfAttr: array[0..15] of Single;
    pixelFormat : array[0..63] of Integer;
    nPixelFormat: LongWord;
  {$ENDIF}
  {$IFDEF MACOSX}{$IfNDef MAC_COCOA}
    pbufferdAttr: array[0..31] of LongWord;
    pixelFormat : TAGLPixelFormat;
  {$ENDIF}{$EndIf}
  procedure FreePBuffer(var Target: zglPRenderTarget; Stage: Integer);
  begin
    oglCanPBuffer := FALSE;
    FreeMem(Target.next.Handle);
    FreeMem(Target.next);
  {$IFDEF USE_X11}
    if Stage = 4 Then
      case oglPBufferMode of
        1: glXDestroyPbuffer(scrDisplay, zglPPBuffer(Target.Handle).PBuffer);
        2: glXDestroyGLXPbufferSGIX(scrDisplay, zglPPBuffer(Target.Handle).PBuffer);
      end;
  {$ENDIF}
  {$IFDEF WINDOWS}
    if Stage = 2 Then
      wglDestroyPbufferARB(zglPPBuffer(Target.Handle).Handle);
  {$ENDIF}
  {$IFDEF MACOSX}
    if Stage = 2 Then
      aglDestroyPixelFormat(pixelFormat);
    if Stage = 3 Then
      aglDestroyContext(zglPPBuffer(Target.Handle).Context);
  {$ENDIF}
    Target := nil;
  end;
{$ENDIF}
  procedure FreeFBO(var Target: zglPRenderTarget; Stage: Integer);
  begin
    oglCanFBO := FALSE;
    FreeMem(Target.next.Handle);
    FreeMem(Target.next);
    if Stage = 2 Then
      glDeleteRenderbuffers(1, @zglPFBO(Target.Handle).RenderBuffer);
    Target := nil;
  end;
begin
  Result := @managerRTarget.First;
  while Assigned(Result.next) do
    Result := Result.next;

  zgl_GetMem(Pointer(Result.next), SizeOf(zglTRenderTarget));

  type_ := RT_TYPE_FBO;

  // GeForce FX sucks: http://www.opengl.org/wiki/Common_Mistakes#Render_To_Texture
  if gl_IsSupported('GeForce FX', oglRenderer) and (Flags and RT_USE_DEPTH > 0) Then
    type_ := RT_TYPE_PBUFFER;

  if Surface.Width > oglMaxFBOSize Then
    type_ := RT_TYPE_PBUFFER;

  if (not oglCanFBO) or (Flags and RT_FORCE_PBUFFER > 0) Then
    if not oglCanPBuffer Then
      begin
        u_Error('There is no possibility to create render target');
        Result := nil;
        FreeMem(Result.next);
        exit;
      end else
        type_ := RT_TYPE_PBUFFER;

  case type_ of
    {$IFNDEF USE_GLES}
    {$IFDEF USE_X11}
    RT_TYPE_PBUFFER:
      begin
        zgl_GetMem(Result.next.Handle, SizeOf(zglTPBuffer));
        pPBuffer := Result.next.Handle;

        FillChar(pbufferiAttr[0], 16 * 4, None);
        FillChar(fbconfigAttr[0], 32 * 4, None);
        fbconfigAttr[0 ] := GLX_DRAWABLE_TYPE;
        fbconfigAttr[1 ] := GLX_PBUFFER_BIT;
        fbconfigAttr[2 ] := GLX_DOUBLEBUFFER;
        fbconfigAttr[3 ] := GL_TRUE;
        fbconfigAttr[4 ] := GLX_RENDER_TYPE;
        fbconfigAttr[5 ] := GLX_RGBA_BIT;
        fbconfigAttr[6 ] := GLX_RED_SIZE;
        fbconfigAttr[7 ] := 8;
        fbconfigAttr[8 ] := GLX_GREEN_SIZE;
        fbconfigAttr[9 ] := 8;
        fbconfigAttr[10] := GLX_BLUE_SIZE;
        fbconfigAttr[11] := 8;
        fbconfigAttr[12] := GLX_ALPHA_SIZE;
        fbconfigAttr[13] := 8;
        fbconfigAttr[14] := GLX_DEPTH_SIZE;
        fbconfigAttr[15] := oglzDepth;
        i := 16;
        if oglStencil > 0 Then
          begin
            fbconfigAttr[i    ] := GLX_STENCIL_SIZE;
            fbconfigAttr[i + 1] := oglStencil;
            INC(i, 2);
          end;
        if oglFSAA > 0 Then
          begin
            fbconfigAttr[i    ] := GLX_SAMPLES_SGIS;
            fbconfigAttr[i + 1] := oglFSAA;
          end;

        fbconfig := glXChooseFBConfig(scrDisplay, scrDefault, @fbconfigAttr[0], @n);
        if not Assigned(fbconfig) Then
          begin
            log_Add('PBuffer: failed to choose GLXFBConfig');
            FreePBuffer(Result, 1);
            Result := nil;
            exit;
          end else
            pPBuffer.Handle := PInteger(fbconfig)^;

        case oglPBufferMode of
          1:
            begin
              pbufferiAttr[0] := GLX_PBUFFER_WIDTH;
              pbufferiAttr[1] := Round(Surface.Width / Surface.U);
              pbufferiAttr[2] := GLX_PBUFFER_HEIGHT;
              pbufferiAttr[3] := Round(Surface.Height / Surface.V);
              pbufferiAttr[4] := GLX_PRESERVED_CONTENTS;
              pbufferiAttr[5] := GL_TRUE;
              pbufferiAttr[6] := GLX_LARGEST_PBUFFER;
              pbufferiAttr[7] := GL_TRUE;

              pPBuffer.PBuffer := glXCreatePbuffer(scrDisplay, pPBuffer.Handle, @pbufferiAttr[0]);
            end;
          2:
            begin
              pbufferiAttr[0] := GLX_PRESERVED_CONTENTS;
              pbufferiAttr[1] := GL_TRUE;
              pbufferiAttr[2] := GLX_LARGEST_PBUFFER;
              pbufferiAttr[3] := GL_TRUE;

              pPBuffer.PBuffer := glXCreateGLXPbufferSGIX(scrDisplay, pPBuffer.Handle, Surface.Width, Surface.Height, @pbufferiAttr[0]);
            end;
        end;

        if pPBuffer.PBuffer = 0 Then
          begin
            log_Add('PBuffer: failed to create GLXPBuffer');
            FreePBuffer(Result, 2);
            exit;
          end;

        visualinfo := glXGetVisualFromFBConfig(scrDisplay, pPBuffer.Handle);
        if not Assigned(visualinfo) Then
          begin
            log_Add('PBuffer: failed to choose Visual');
            FreePBuffer(Result, 3);
            Result := nil;
            exit;
          end;

        pPBuffer.Context := glXCreateContext(scrDisplay, visualinfo, oglContext, TRUE);
        XFree(fbconfig);
        XFree(visualinfo);
        if pPBuffer.Context = nil Then
          begin
            log_Add('PBuffer: failed to create GLXContext');
            FreePBuffer(Result, 4);
            Result := nil;
            exit;
          end;

        glXMakeCurrent(scrDisplay, pPBuffer.PBuffer, pPBuffer.Context);
        gl_ResetState();
        Set2DMode();
        glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
        ssprite2d_Draw(Surface, 0, oglHeight - Surface.Height, oglWidth - (oglWidth - Surface.Width), oglHeight - (oglHeight - Surface.Height), 0, 255);
        glXMakeCurrent(scrDisplay, wndHandle, oglContext);
      end;
    {$ENDIF}
    {$IFDEF WINDOWS}
    RT_TYPE_PBUFFER:
      begin
        zgl_GetMem(Result.next.Handle, SizeOf(zglTPBuffer));
        pPBuffer := Result.next.Handle;

        FillChar(pbufferiAttr[0], 32 * 4, 0);
        FillChar(pbufferfAttr[0], 16 * 4, 0);
        pbufferiAttr[0 ] := WGL_DRAW_TO_PBUFFER_ARB;
        pbufferiAttr[1 ] := GL_TRUE;
        pbufferiAttr[2 ] := WGL_DOUBLE_BUFFER_ARB;
        pbufferiAttr[3 ] := GL_TRUE;
        pbufferiAttr[4 ] := WGL_COLOR_BITS_ARB;
        pbufferiAttr[5 ] := 24;
        pbufferiAttr[6 ] := WGL_RED_BITS_ARB;
        pbufferiAttr[7 ] := 8;
        pbufferiAttr[8 ] := WGL_GREEN_BITS_ARB;
        pbufferiAttr[9 ] := 8;
        pbufferiAttr[10] := WGL_BLUE_BITS_ARB;
        pbufferiAttr[11] := 8;
        pbufferiAttr[12] := WGL_ALPHA_BITS_ARB;
        pbufferiAttr[13] := 8;
        pbufferiAttr[14] := WGL_DEPTH_BITS_ARB;
        pbufferiAttr[15] := oglzDepth;
        i := 16;
        if oglStencil > 0 Then
          begin
            pbufferiAttr[i    ] := WGL_STENCIL_BITS_ARB;
            pbufferiAttr[i + 1] := oglStencil;
            INC(i, 2);
          end;
        if oglFSAA > 0 Then
          begin
            pbufferiAttr[i    ] := WGL_SAMPLE_BUFFERS_ARB;
            pbufferiAttr[i + 1] := GL_TRUE;
            pbufferiAttr[i + 2] := WGL_SAMPLES_ARB;
            pbufferiAttr[i + 3] := oglFSAA;
          end;

        wglChoosePixelFormatARB(wndDC, @pbufferiAttr[0], @pbufferfAttr[0], 64, @pixelFormat, @nPixelFormat);

        pPBuffer.Handle := wglCreatePbufferARB(wndDC, pixelFormat[0], Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V), nil);
        if pPBuffer.Handle <> 0 Then
          begin
            pPBuffer.DC := wglGetPbufferDCARB(pPBuffer.Handle);
            pPBuffer.RC := wglCreateContext(pPBuffer.DC);
            if pPBuffer.RC = 0 Then
              begin
                log_Add('PBuffer: RC create - Error');
                FreePBuffer(Result, 2);
                Result := nil;
                exit;
              end;
            wglShareLists(oglContext, pPBuffer.RC);
          end else
            begin
              log_Add('PBuffer: wglCreatePbufferARB - failed');
              FreePBuffer(Result, 1);
              Result := nil;
              exit;
            end;
        wglMakeCurrent(pPBuffer.DC, pPBuffer.RC);
        gl_ResetState();
        Set2DMode();
        glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
        ssprite2d_Draw(Surface, 0, oglHeight - Surface.Height, oglWidth - (oglWidth - Surface.Width), oglHeight - (oglHeight - Surface.Height), 0, 255);
        wglMakeCurrent(wndDC, oglContext);
      end;
    {$ENDIF}
    {$IFDEF MACOSX}
    RT_TYPE_PBUFFER:
      begin
        zgl_GetMem(Result.next.Handle, SizeOf(zglTPBuffer));
        pPBuffer := Result.next.Handle;

        FillChar(pbufferdAttr[0], 32 * 4, AGL_NONE);
        pbufferdAttr[0 ] := AGL_DOUBLEBUFFER;
        pbufferdAttr[1 ] := AGL_RGBA;
        pbufferdAttr[2 ] := GL_TRUE;
        pbufferdAttr[3 ] := AGL_RED_SIZE;
        pbufferdAttr[4 ] := 8;
        pbufferdAttr[5 ] := AGL_GREEN_SIZE;
        pbufferdAttr[6 ] := 8;
        pbufferdAttr[7 ] := AGL_BLUE_SIZE;
        pbufferdAttr[8 ] := 8;
        pbufferdAttr[9 ] := AGL_ALPHA_SIZE;
        pbufferdAttr[10] := 8;
        pbufferdAttr[11] := AGL_DEPTH_SIZE;
        pbufferdAttr[12] := oglzDepth;
        i := 13;
        if oglStencil > 0 Then
          begin
            pbufferdAttr[i    ] := AGL_STENCIL_SIZE;
            pbufferdAttr[i + 1] := oglStencil;
            INC(i, 2);
          end;
        if oglFSAA > 0 Then
          begin
            pbufferdAttr[i    ] := AGL_SAMPLE_BUFFERS_ARB;
            pbufferdAttr[i + 1] := 1;
            pbufferdAttr[i + 2] := AGL_SAMPLES_ARB;
            pbufferdAttr[i + 3] := oglFSAA;
          end;

        DMGetGDeviceByDisplayID(DisplayIDType(scrDisplay), oglDevice, FALSE);
        pixelFormat := aglChoosePixelFormat(@oglDevice, 1, @pbufferdAttr[0]);
        if not Assigned(pixelFormat) Then
          begin
            log_Add('PBuffer: aglChoosePixelFormat - failed');
            FreePBuffer(Result, 1);
            Result := nil;
            exit;
          end;

        pPBuffer.Context := aglCreateContext(pixelFormat, oglContext);
        if not Assigned(pPBuffer.Context) Then
          begin
            log_Add('PBuffer: aglCreateContext - failed');
            FreePBuffer(Result, 2);
            Result := nil;
            exit;
          end;
        aglDestroyPixelFormat(pixelFormat);

        if aglCreatePBuffer(Surface.Width, Surface.Height, GL_TEXTURE_2D, GL_RGBA, 0, @pPBuffer.PBuffer) = GL_FALSE Then
          begin
            log_Add('PBuffer: aglCreatePBuffer - failed');
            FreePBuffer(Result, 3);
            Result := nil;
            exit;
          end;
      end;
    {$ENDIF}
    {$ENDIF}
    RT_TYPE_FBO:
      begin
        zgl_GetMem(Result.next.Handle, SizeOf(zglTFBO));
        pFBO := Result.next.Handle;

        glGenFramebuffers(1, @pFBO.FrameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, pFBO.FrameBuffer);
        if glIsFrameBuffer(pFBO.FrameBuffer) = GL_FALSE Then
          begin
            log_Add('FBO: Gen FrameBuffer - Error');
            FreeFBO(Result, 1);
            {$IFNDEF USE_GLES}
            Result := rtarget_Add(Surface, Flags or RT_FORCE_PBUFFER);
            {$ELSE}
            Result := nil;
            {$ENDIF}
            exit;
          end;

        glGenRenderbuffers(1, @pFBO.RenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, pFBO.RenderBuffer);
        if glIsRenderBuffer(pFBO.RenderBuffer) = GL_FALSE Then
          begin
            log_Add('FBO: Gen RenderBuffer - Error');
            FreeFBO(Result, 2);
            {$IFNDEF USE_GLES}
            Result := rtarget_Add(Surface, Flags or RT_FORCE_PBUFFER);
            {$ELSE}
            Result := nil;
            {$ENDIF}
            exit;
          end;

        glRenderbufferStorage(GL_RENDERBUFFER, GL_RGBA, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V));
        if Flags and RT_USE_DEPTH > 0 Then
          begin
            {$IFNDEF USE_GLES}
            case oglzDepth of
              24: glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT24, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V));
              32: glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT32, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V));
            else
              glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V));
            end;
            {$ELSE}
            if oglzDepth > 16 Then
              begin
                if (oglzDepth = 32) and (oglCanFBODepth32) Then
                  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT32, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V))
                else
                  if (oglzDepth = 24) and (oglCanFBODepth24) Then
                    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT24, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V))
                  else
                    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V));
              end else
                glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, Round(Surface.Width / Surface.U), Round(Surface.Height / Surface.V));
            {$ENDIF}
            glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, pFBO.RenderBuffer);
          end;

        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, 0, 0);
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        {$IFDEF iOS}
        glBindFramebuffer(GL_FRAMEBUFFER, eglFramebuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, eglRenderbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, eglRenderbuffer);
        {$ENDIF}
      end;
  end;
  Result.next.Type_   := type_;
  Result.next.Surface := Surface;
  Result.next.Flags   := Flags;

  Result.next.prev := Result;
  Result.next.next := nil;
  Result := Result.next;
  INC(managerRTarget.Count);
end;

procedure rtarget_Del(var Target: zglPRenderTarget);
begin
  if not Assigned(Target) Then exit;

  tex_Del(Target.Surface);

  case Target.Type_ of
    {$IFNDEF USE_GLES}
    RT_TYPE_PBUFFER:
      begin
        {$IFDEF USE_X11}
        case oglPBufferMode of
          1: glXDestroyPbuffer(scrDisplay, zglPPBuffer(Target.Handle).PBuffer);
          2: glXDestroyGLXPbufferSGIX(scrDisplay, zglPPBuffer(Target.Handle).PBuffer);
        end;
        {$ENDIF}
        {$IFDEF WINDOWS}
        if zglPPBuffer(Target.Handle).RC <> 0 Then
          wglDeleteContext(zglPPBuffer(Target.Handle).RC);
        if zglPPBuffer(Target.Handle).DC <> 0 Then
          wglReleasePbufferDCARB(zglPPBuffer(Target.Handle).Handle, zglPPBuffer(Target.Handle).DC);
        if zglPPBuffer(Target.Handle).Handle <> 0 Then
          wglDestroyPbufferARB(zglPPBuffer(Target.Handle).Handle);
        {$ENDIF}
        {$IFDEF MACOSX}
        aglDestroyContext(zglPPBuffer(Target.Handle).Context);
        aglDestroyPBuffer(zglPPBuffer(Target.Handle).PBuffer);
        {$ENDIF}
      end;
    {$ENDIF}
    RT_TYPE_FBO:
      begin
        if glIsRenderBuffer(zglPFBO(Target.Handle).RenderBuffer) = GL_TRUE Then
          glDeleteRenderbuffers(1, @zglPFBO(Target.Handle).RenderBuffer);
        if glIsFramebuffer(zglPFBO(Target.Handle).FrameBuffer) = GL_TRUE Then
          glDeleteFramebuffers(1, @zglPFBO(Target.Handle).FrameBuffer);
      end;
  end;

  if Assigned(Target.prev) Then
    Target.prev.next := Target.next;
  if Assigned(Target.next) Then
    Target.next.prev := Target.prev;

  if Assigned(Target.Handle) Then
    FreeMem(Target.Handle);
  FreeMem(Target);
  Target := nil;

  DEC(managerRTarget.Count);
end;

procedure rtarget_Set(Target: zglPRenderTarget);
begin
  batch2d_Flush();

  if Assigned(Target) Then
    begin
      lRTarget := Target;
      lGLW     := oglWidth;
      lGLH     := oglHeight;
      lResCX   := scrResCX;
      lResCY   := scrResCY;

      case Target.Type_ of
        {$IFNDEF USE_GLES}
        RT_TYPE_PBUFFER:
          begin
            {$IFDEF USE_X11}
            glXMakeCurrent(scrDisplay, zglPPBuffer(Target.Handle).PBuffer, zglPPBuffer(Target.Handle).Context);
            {$ENDIF}
            {$IFDEF WINDOWS}
            wglMakeCurrent(zglPPBuffer(Target.Handle).DC, zglPPBuffer(Target.Handle).RC);
            {$ENDIF}
            {$IFDEF MACOSX}
            aglSetCurrentContext(zglPPBuffer(Target.Handle).Context);
            aglSetPBuffer(zglPPBuffer(Target.Handle).Context, zglPPBuffer(Target.Handle).PBuffer, 0, 0, aglGetVirtualScreen(oglContext));
            {$ENDIF}
          end;
        {$ENDIF}
        RT_TYPE_FBO:
          begin
            glBindFramebuffer(GL_FRAMEBUFFER, zglPFBO(Target.Handle).FrameBuffer);
            glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, Target.Surface.ID, 0);
          end;
      end;

      oglTarget  := TARGET_TEXTURE;
      oglTargetW := Target.Surface.Width;
      oglTargetH := Target.Surface.Height;
      if Target.Flags and RT_FULL_SCREEN > 0 Then
        begin
          if appFlags and CORRECT_RESOLUTION > 0 Then
            begin
              oglWidth  := scrResW;
              oglHeight := scrResH;
            end;
        end else
          begin
            oglWidth  := Target.Surface.Width;
            oglHeight := Target.Surface.Height;
            scrResCX  := 1;
            scrResCY  := 1;
          end;
      SetCurrentMode();

      if Target.Flags and RT_CLEAR_COLOR > 0 Then
        glClear(GL_COLOR_BUFFER_BIT);
      if Target.Flags and RT_CLEAR_DEPTH > 0 Then
        glClear(GL_DEPTH_BUFFER_BIT);
    end else
      if Assigned(lRTarget) Then
        begin
          case lRTarget.Type_ of
            {$IFNDEF USE_GLES}
            RT_TYPE_PBUFFER:
              begin
                glEnable(GL_TEXTURE_2D);
                glBindTexture(GL_TEXTURE_2D, lRTarget.Surface.ID);
                glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, lRTarget.Surface.Width, lRTarget.Surface.Height);
                glDisable(GL_TEXTURE_2D);

                {$IFDEF USE_X11}
                glXMakeCurrent(scrDisplay, wndHandle, oglContext);
                {$ENDIF}
                {$IFDEF WINDOWS}
                wglMakeCurrent(wndDC, oglContext);
                {$ENDIF}
                {$IFDEF MACOSX}
                aglSwapBuffers(zglPPBuffer(lRTarget.Handle).Context);
                aglSetCurrentContext(oglContext);
                {$ENDIF}
              end;
            {$ENDIF}
            RT_TYPE_FBO:
              begin
                glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, 0, 0);
                glBindFramebuffer(GL_FRAMEBUFFER, 0);
                {$IFDEF iOS}
                glBindFramebuffer(GL_FRAMEBUFFER, eglFramebuffer);
                glBindRenderbuffer(GL_RENDERBUFFER, eglRenderbuffer);
                glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, eglRenderbuffer);
                {$ENDIF}
              end;
          end;

          oglTarget  := TARGET_SCREEN;
          oglWidth   := lGLW;
          oglHeight  := lGLH;
          oglTargetW := oglWidth;
          oglTargetH := oglHeight;
          if lRTarget.Flags and RT_FULL_SCREEN = 0 Then
            begin
              scrResCX := lResCX;
              scrResCY := lResCY;
            end;

          lRTarget := nil;
          SetCurrentMode();
        end;
end;

procedure rtarget_DrawIn(Target: zglPRenderTarget; RenderCallback: zglTRenderCallback; Data: Pointer);
begin
  if oglSeparate Then
    begin
      rtarget_Set(Target);
      RenderCallback(Data);
      rtarget_Set(nil);
    end else
      begin
        rtarget_Set(Target);

        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_FALSE);
        RenderCallback(Data);
        batch2d_Flush();

        glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        glColorMask(GL_FALSE, GL_FALSE, GL_FALSE, GL_TRUE);
        RenderCallback(Data);

        rtarget_Set(nil);

        glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
      end;
end;
{$EndIf}

{$IFDEF ANDROID}
procedure rtarget_Restore(var Target: zglPRenderTarget);
  var
    rt   : zglPRenderTarget;
    pData: PByteArray;
begin
  zgl_GetMem(pData, Round(Target.Surface.Width / Target.Surface.U) * Round(Target.Surface.Height / Target.Surface.V) * 4);
  tex_CreateGL(Target.Surface^, pData);
  zgl_FreeMem(pData);

  rt := rtarget_Add(Target.Surface, Target.Flags);
  FreeMem(Target.Handle);
  Target.Handle := rt.Handle;

  if Assigned(rt.prev) Then
    rt.prev.next := rt.next;
  if Assigned(rt.next) Then
    rt.next.prev := rt.prev;
  FreeMem(rt);

  DEC(managerRTarget.Count);
end;
{$ENDIF}

end.
