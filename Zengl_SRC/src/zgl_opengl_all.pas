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

 !!! modification from Serge
}
unit zgl_opengl_all;

{$I zgl_config.cfg}
{$IFDEF UNIX}
  {$DEFINE stdcall := cdecl}
{$ENDIF}
{$IFDEF MAC_COCOA}
  {$LINKFRAMEWORK OpenGL}
{$ENDIF}

interface

uses
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF MACOSX}
//  MacOSAll,     ????
  {$ENDIF}
  zgl_gltypeconst,
  zgl_pasOpenGL;

function InitGL: Boolean;
procedure FreeGL;
// В данную функцию мы можем завести проверку всех расширений. Но, надо будет
// определяться какие расширения будут рабочими. Это надо перебрать всю
// библиотеку OpenGL.
function gl_GetProc(const Proc: UTF8String): Pointer;
function gl_IsSupported(const Extension, SearchIn: UTF8String): Boolean;
// Rus: проверка и загрузка расширений.
// Eng:
procedure gl_LoadEx;

  function  glGetString(name: GLenum): PAnsiChar; stdcall; external libGL;            // GL_VERSION_1_0
  procedure glHint(target, mode: GLenum); stdcall; external libGL;                    // GL_VERSION_1_0

  procedure glShadeModel(mode: GLenum); stdcall; external libGL;                      // USE_DEPRECATED

  procedure glReadPixels(x, y: GLint; width, height: GLsizei; format, atype: GLenum; pixels: Pointer); stdcall; external libGL; // GL_VERSION_1_0

  // Clear
  procedure glClear(mask: GLbitfield); stdcall; external libGL;                       // USE_DEPRECATED
  procedure glClearColor(red, green, blue, alpha: GLclampf); stdcall; external libGL; // USE_DEPRECATED
  procedure glClearDepth(depth: GLclampd); stdcall; external libGL;                   // USE_DEPRECATED
  // Get
  procedure glGetFloatv(pname: GLenum; params: PGLfloat); stdcall; external libGL;    // GL_VERSION_1_0
  procedure glGetIntegerv(pname: GLenum; params: PGLint); stdcall; external libGL;    // GL_VERSION_1_0
  // State
  procedure glBegin(mode: GLenum); stdcall; external libGL;                           // USE_DEPRECATED
  procedure glEnd; stdcall; external libGL;                                           // USE_DEPRECATED
  procedure glEnable(cap: GLenum); stdcall; external libGL;                           // GL_VERSION_1_0
  procedure glEnableClientState(aarray: GLenum); stdcall; external libGL;             // USE_DEPRECATED
  procedure glDisable(cap: GLenum); stdcall; external libGL;                          // GL_VERSION_1_0
  procedure glDisableClientState(aarray: GLenum); stdcall; external libGL;            // USE_DEPRECATED
  // Viewport
  procedure glViewport(x, y: GLint; width, height: GLsizei); stdcall; external libGL; // GL_VERSION_1_0
  procedure glOrtho(left, right, bottom, top, zNear, zFar: GLdouble); stdcall; external libGL;      // USE_DEPRECATED
  procedure glScissor(x, y: GLint; width, height: GLsizei); stdcall; external libGL;  // GL_VERSION_1_0
  // Depth
  procedure glDepthFunc(func: GLenum); stdcall; external libGL;                       // GL_VERSION_1_0
  procedure glDepthMask(flag: GLboolean); stdcall; external libGL;                    // GL_VERSION_1_0
  procedure glDepthRange(zNear, zFar: GLclampd); stdcall; external libGL;             // GL_VERSION_1_0
  // Color
  procedure glColor4ub(red, green, blue, alpha: GLubyte); stdcall; external libGL;    // USE_DEPRECATED
  procedure glColor4ubv(v: PGLubyte); stdcall; external libGL;                        // USE_DEPRECATED

  procedure glColor3ub(red, green, blue: GLbyte); stdcall; external libGL;            // USE_DEPRECATED
  procedure glColor3ubv(v: PGLfloat); stdcall; external libGL;                        // USE_DEPRECATED
  procedure glColor4f(red, green, blue, alpha: GLfloat); stdcall; external libGL;     // USE_DEPRECATED
  procedure glColor4fv(v: PGLfloat); stdcall; external libGL;                         // USE_DEPRECATED
  procedure glColorMask(red, green, blue, alpha: GLboolean); stdcall; external libGL; // GL_VERSION_1_0
  procedure glColorMaterial(face, mode: GLenum); stdcall; external libGL;             // USE_DEPRECATED
  // Alpha
  procedure glAlphaFunc(func: GLenum; ref: GLclampf); stdcall; external libGL;        // USE_DEPRECATED
  procedure glBlendFunc(sfactor, dfactor: GLenum); stdcall; external libGL;           // GL_VERSION_1_0

  // Matrix
  procedure glPushMatrix; stdcall; external libGL;                                    // USE_DEPRECATED
  procedure glPopMatrix; stdcall; external libGL;                                     // USE_DEPRECATED
  procedure glMatrixMode(mode: GLenum); stdcall; external libGL;                      // USE_DEPRECATED
  procedure glLoadIdentity; stdcall; external libGL;                                  // USE_DEPRECATED
  procedure glFrustum(left, right, bottom, top, zNear, zFar: GLdouble); stdcall; external libGL;    // USE_DEPRECATED

  procedure glLoadMatrixf(const m: PGLfloat); stdcall; external libGL;                // USE_DEPRECATED
  procedure glRotatef(angle, x, y, z: GLfloat); stdcall; external libGL;              // USE_DEPRECATED
  procedure glScalef(x, y, z: GLfloat); stdcall; external libGL;                      // USE_DEPRECATED
  procedure glTranslatef(x, y, z: GLfloat); stdcall; external libGL;                  // USE_DEPRECATED
  // Vertex
  procedure glVertex2f(x, y: GLfloat); stdcall; external libGL;                       // USE_DEPRECATED
  procedure glVertex2fv(v: PGLfloat); stdcall; external libGL;                        // USE_DEPRECATED
  procedure glVertex3f(x, y, z: GLfloat); stdcall; external libGL;                    // USE_DEPRECATED
  procedure glVertex3dv(v: PGLdouble); stdcall; external libGL;                       // USE_DEPRECATED
  procedure glVertexPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;    // USE_DEPRECATED
  // Texture
  procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external libGL;                  // GL_VERSION_1_1
  procedure glGenTextures(n: GLsizei; textures: PGLuint); stdcall; external libGL;                    // GL_VERSION_1_1
  procedure glDeleteTextures(n: GLsizei; const textures: PGLuint); stdcall; external libGL;           // GL_VERSION_1_1
  procedure glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat); stdcall; external libGL;  // GL_VERSION_1_0
  procedure glTexParameterfv(target: GLenum; pname: GLenum; const params: PGLfloat); stdcall; external libGL; // GL_VERSION_1_0
  procedure glTexParameteri(target: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;    // GL_VERSION_1_0
  procedure glTexParameteriv(target: GLenum; pname: GLenum; const params: PGLint); stdcall; external libGL;   // GL_VERSION_1_0
  procedure glPixelStoref(pname: GLenum; param: GLfloat); stdcall; external libGL;                    // GL_VERSION_1_0
  procedure glPixelStorei(pname: GLenum; param: GLint); stdcall; external libGL;                      // GL_VERSION_1_0
  procedure glTexImage2D(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer); stdcall; external libGL; // GL_VERSION_1_0
  procedure glTexSubImage2D(target: GLenum; level, xoffset, yoffset: GLint; width, height: GLsizei; format, atype: GLenum; const pixels: Pointer); stdcall; external libGL; // GL_VERSION_1_1
  procedure glGetTexImage(target: GLenum; level: GLint; format: GLenum; atype: GLenum; pixels: Pointer); stdcall; external libGL;       // GL_VERSION_1_0
  procedure glCopyTexSubImage2D(target: GLenum; level, xoffset, yoffset, x, y: GLint; width, height: GLsizei); stdcall; external libGL; // GL_VERSION_1_1
  procedure glTexEnvi(target: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;          // USE_DEPRECATED
  procedure glTexEnviv(target: GLenum; pname: GLenum; const params: PGLint); stdcall; external libGL; // USE_DEPRECATED

  // TexCoords
  procedure glTexCoord2f(s, t: GLfloat); stdcall; external libGL;                                     // USE_DEPRECATED
  procedure glTexCoord2fv(v: PGLfloat); stdcall; external libGL;                                      // USE_DEPRECATED

  //---------------------------------------------------------------------
  procedure glDrawArrays(mode: GLenum; first: GLint; count: GLsizei); stdcall; external libGL;                                // GL_VERSION_1_1
  procedure glDrawElements(mode: GLenum; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall; external libGL;     // GL_VERSION_1_1
  procedure glColorPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;     // USE_DEPRECATED
  procedure glTexCoordPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;  // USE_DEPRECATED
  //---------------------------------------------------------------------

  procedure glPointSize(size: GLfloat); stdcall; external libGL;                                      // GL_VERSION_1_0

  procedure glArrayElement(i: GLint); stdcall; external libGL;                                        // USE_DEPRECATED
  procedure glDrawRangeElements(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall; external libGL; // GL_VERSION_1_2
  procedure glEdgeFlagPointer(stride: GLsizei; const _pointer: PGLvoid); stdcall; external libGL;
  procedure glFogCoordPointer(_type: GLenum; stride: GLsizei; const _pointer: PGLvoid); stdcall; external libGL;   // GL_VERSION_1_4
  procedure glInterleavedArrays(format: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL; // USE_DEPRECATED
  procedure glMultiDrawElements(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: PGLvoid; primcount: GLsizei); stdcall; external libGL;   // GL_VERSION_1_4
  procedure glNormalPointer(atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;      // USE_DEPRECATED
  procedure glSecondaryColorPointer(size: GLint; _type: GLenum; stride: GLsizei; const _pointer: PGLvoid); stdcall; external libGL; // GL_VERSION_1_4
  // освещение, материал
  procedure glLightModelf(pname: GLenum; param: GLfloat); stdcall; external libGL;                    // USE_DEPRECATED
  procedure glLightModelfv(pname: GLenum; const params: PGLfloat); stdcall; external libGL;           // USE_DEPRECATED
  procedure glLightf(light, pname: GLenum; param: GLfloat); stdcall; external libGL;                  // USE_DEPRECATED
  procedure glLightfv(light, pname: GLenum; const params: PGLfloat); stdcall; external libGL;         // USE_DEPRECATED
  procedure glGetLightfv(light, pname: GLenum; params: PGLfloat); stdcall; external libGL;         // Gles 1.1   // USE_DEPRECATED
  procedure glGetLightiv(light, pname: GLenum; params: PGLint); stdcall; external libGL;           // Gles 1.1   // USE_DEPRECATED
  procedure glGetMaterialfv(face, pname: GLenum; params: PGLfloat); stdcall; external libGL;       // Gles 1.1   // USE_DEPRECATED
  procedure glGetMaterialiv(face, pname: GLenum; params: PGLint); stdcall; external libGL;         // Gles 1.1   // USE_DEPRECATED
  procedure glMaterialf(face, pname: GLenum; param: GLfloat); stdcall; external libGL;                // USE_DEPRECATED
  procedure glMaterialfv(face, pname: GLenum; const params: PGLfloat); stdcall; external libGL;       // USE_DEPRECATED
  procedure glNormal3f(nx, ny, nz: GLfloat); stdcall; external libGL;                                 // USE_DEPRECATED
  procedure glNormal3fv(const v: PGLfloat); stdcall; external libGL;                                  // USE_DEPRECATED

var
  //
  glCompressedTexImage2D: procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; imageSize: GLsizei; const pixels: Pointer); stdcall; // GL_VERSION_1_3
  // FBO             GL_VERSION_3_0 or GL_EXT_framebuffer_object
  glIsRenderbuffer: function(renderbuffer: GLuint): GLboolean; stdcall;
  glBindRenderbuffer: procedure(target: GLenum; renderbuffer: GLuint); stdcall;
  glDeleteRenderbuffers: procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
  glGenRenderbuffers: procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
  glRenderbufferStorage: procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glIsFramebuffer: function(framebuffer: GLuint): GLboolean; stdcall;
  glBindFramebuffer: procedure(target: GLenum; framebuffer: GLuint); stdcall;
  glDeleteFramebuffers: procedure(n: GLsizei; const framebuffers: PGLuint); stdcall;
  glGenFramebuffers: procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
  glCheckFramebufferStatus: function(target: GLenum): GLenum; stdcall;
  glFramebufferTexture2D: procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferRenderbuffer: procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;

  glBlendEquation: procedure(mode: GLenum); stdcall;                                                  // GL_VERSION_1_4
  glBlendFuncSeparate: procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall; // GL_VERSION_1_4

var
  oglLibrary: {$IFDEF UNIX} Pointer {$ENDIF} {$IFDEF WINDOWS} HMODULE {$ENDIF};

implementation
uses
  {$IFDEF FPC}
  math,
  {$ENDIF}
  {$IfDef USE_X11}
  zgl_glx_wgl,
  {$EndIf}
  {$IfDef WINDOWS}
  zgl_glx_wgl,
  {$EndIf}
  zgl_window,
  zgl_screen,
  zgl_opengl,
  zgl_log,
  zgl_utils;

function InitGL: Boolean;
begin
  oglLibrary := dlopen(libGL {$IFDEF UNIX}, $001 {$ENDIF});

  Result := oglLibrary <> LIB_ERROR;
end;

procedure FreeGL;
begin
  dlclose(oglLibrary);
end;

function gl_GetProc(const Proc: UTF8String): Pointer;
var
  s: UTF8String;
begin
  s := '';
  {$IFDEF WINDOWS}
  Result := wglGetProcAddress(PAnsiChar(Proc));                
  if Result = nil Then
  begin
    s := 'ARB';
    Result := wglGetProcAddress(PAnsiChar(Proc + s));
    if Result = nil Then
    begin
      s := 'EXT';
      Result := wglGetProcAddress(PAnsiChar(Proc + s));
      if Result = nil then
        s := '';
    end;
  end;
  {$ELSE}
  Result := dlsym(oglLibrary, PAnsiChar(Proc));
  if Result = nil Then
  begin
    s := 'ARB';
    Result := dlsym(oglLibrary, PAnsiChar(Proc + s));
    if Result = nil Then
    begin
      s := 'EXT';
      Result := dlsym(oglLibrary, PAnsiChar(Proc + s));
      if Result = nil then
        s := '';
    end;
  end;
  {$IFDEF LINUX}
  if (Result = nil) and Assigned(glXGetProcAddressARB) Then
    Result := glXGetProcAddressARB(PAnsiChar(Proc));
  {$ENDIF}
  {$ENDIF}
//  log_Add(Proc + s);
end;

// получение значения заголовка
function gl_IsSupported(const Extension, SearchIn: UTF8String): Boolean;
  var
    extPos: Integer;
begin
  extPos := Pos(Extension, SearchIn);
  Result := extPos > 0;
  if Result Then
    Result := ((extPos + Length(Extension) - 1) = Length(SearchIn)) or (SearchIn[extPos + Length(Extension)] = ' ');
  // log_Add(Result);
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

  // WaitVSync
{$IFDEF LINUX}
  glXSwapIntervalSGI := gl_GetProc('glXSwapInterval');
  if not Assigned(glXSwapIntervalSGI) then
    glXSwapIntervalSGI := dlsym(oglLibrary, PAnsiChar('glXSwapIntervalSGI'));
  oglCanVSync        := Assigned(glXSwapIntervalSGI);
{$ENDIF}
{$IFDEF WINDOWS}
  wglSwapIntervalEXT := gl_GetProc('wglSwapInterval');
  oglCanVSync     := Assigned(wglSwapIntervalEXT);
{$ENDIF}
  scr_VSync;
  log_Add('Support WaitVSync: ' + u_BoolToStr(oglCanVSync));
end;

initialization
  // Scary, yeah :)
  {$IFDEF FPC}
    { according to bug 7570, this is necessary on all x86 platforms,
      maybe we've to fix the sse control word as well }
    { Yes, at least for darwin/x86_64 (JM) }
    {$IF DEFINED(cpui386) or DEFINED(cpux86_64)}
    SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
    {$IFEND}
  {$ELSE}
    Set8087CW($133F);
  {$ENDIF}

end.

