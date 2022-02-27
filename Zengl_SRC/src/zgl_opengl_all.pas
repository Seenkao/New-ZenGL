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

 !!! modification from Serge - SSW 26.02.2022
}
unit zgl_opengl_all;

{$I zgl_config.cfg}
{$IFDEF UNIX}
  {$DEFINE stdcall := cdecl}
{$ENDIF}
{$IFDEF MACOSX}
  {$LINKFRAMEWORK OpenGL}
{$ENDIF}

interface

uses
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF MACOSX}
  MacOSAll,
  {$ENDIF}
  zgl_gltypeconst,
  zgl_pasOpenGL;

function InitGL: Boolean;
procedure FreeGL;
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
function InitAGL: Boolean;
procedure FreeAGL;
{$ENDIF}{$EndIf}
function gl_GetProc(const Proc: UTF8String): Pointer;
function gl_IsSupported(const Extension, SearchIn: UTF8String): Boolean;
// Rus: проверка и загрузка расширений.
// Eng:
procedure gl_LoadEx;

const
  {$IFDEF LINUX}
  libGL  = 'libGL.so.1';
  libGLU = 'libGLU.so.1';
  {$ENDIF}
  {$IFDEF WINDOWS}
  libGL  = 'opengl32.dll';
  libGLU = 'glu32.dll';
  {$ENDIF}
  {$IFDEF MACOSX}
  libGL  = '/System/Library/Frameworks/OpenGL.framework/Libraries/libGL.dylib';
  libGLU = '/System/Library/Frameworks/OpenGL.framework/Libraries/libGLU.dylib';
  {$IfNDef MAC_COCOA}
  libAGL = '/System/Library/Frameworks/AGL.framework/AGL';
  {$ENDIF}{$EndIf}

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

                              PGLvoid     = Pointer;
  GLvoid     = Pointer;       PPGLvoid    = ^PGLvoid;
  GLint64    = Int64;         PGLint64    = ^GLint64;
  GLuint64   = UInt64;        PGLuint64   = ^GLuint64;

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
  // дисплейные списки
  procedure glNewList(list: GLuint; mode: GLenum); stdcall; external libGL;                           // USE_DEPRECATED
  procedure glEndList; stdcall; external libGL;                                                       // USE_DEPRECATED
  procedure glCallList(list: GLuint); stdcall; external libGL;                                        // USE_DEPRECATED
  procedure glCallLists(n: GLsizei; atype: GLenum; const lists: Pointer); stdcall; external libGL;    // USE_DEPRECATED
  procedure glDeleteLists(list: GLuint; range: GLsizei); stdcall; external libGL;                     // USE_DEPRECATED
  function glGenLists(range: GLsizei): GLuint; stdcall; external libGL;                               // USE_DEPRECATED
  function glIsList(list: GLuint): GLboolean; stdcall; external libGL;                                // USE_DEPRECATED
  procedure glListBase(base: GLuint); stdcall; external libGL;                                        // USE_DEPRECATED

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


{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
const
  AGL_NONE         = 0;
  AGL_BUFFER_SIZE  = 2;
  AGL_RGBA         = 4;
  AGL_DOUBLEBUFFER = 5;
  AGL_RED_SIZE     = 8;
  AGL_GREEN_SIZE   = 9;
  AGL_BLUE_SIZE    = 10;
  AGL_ALPHA_SIZE   = 11;
  AGL_DEPTH_SIZE   = 12;
  AGL_STENCIL_SIZE = 13;
  AGL_FULLSCREEN   = 54;

  AGL_SAMPLE_BUFFERS_ARB = 55;
  AGL_SAMPLES_ARB        = 56;
  AGL_MULTISAMPLE        = 59;
  AGL_SUPERSAMPLE        = 60;

  AGL_SWAP_INTERVAL = 222;

  AGL_CLIP_REGION = 254;

type
  TGDHandle = ptrint;
  TCGrafPtr = Pointer;

  PAGLDevice = ^TAGLDevice;
  TAGLDevice = TGDHandle;

  PAGLDrawable = ^TAGLDrawable;
  TAGLDrawable = TCGrafPtr;

  TAGLPixelFormat = Pointer;

  TAGLContext = Pointer;

  TAGLPbuffer = Pointer;
  PAGLPbuffer = ^TAGLPbuffer;

  function aglSetInt(ctx:TAGLContext; pname:GLenum; params:GLint):GLboolean;

var
  aglChoosePixelFormat: function(gdevs:PAGLDevice; ndev:GLint; attribs:PGLint):TAGLPixelFormat;cdecl;
  aglDestroyPixelFormat: procedure(pix:TAGLPixelFormat);cdecl;
  aglCreateContext: function(pix:TAGLPixelFormat; share:TAGLContext):TAGLContext;cdecl;
  aglDestroyContext: function(ctx:TAGLContext):GLboolean;cdecl;
  aglUpdateContext: function(ctx:TAGLContext):GLboolean;cdecl;
  aglSetCurrentContext: function(ctx:TAGLContext):GLboolean;cdecl;
  aglSetDrawable: function(ctx:TAGLContext; draw:TAGLDrawable):GLboolean;cdecl;
  aglGetDrawable: function(ctx:TAGLContext):TAGLDrawable;cdecl;
  aglSetFullScreen: function(ctx:TAGLContext; width:GLsizei; height:GLsizei; freq:GLsizei; device:GLint):GLboolean;cdecl;
  aglSwapBuffers: procedure(ctx:TAGLContext);cdecl;
  aglSetInteger: function(ctx:TAGLContext; pname:GLenum; params:PGLint):GLboolean;cdecl;
  aglEnable: function(ctx:TAGLContext; pname:GLenum):GLboolean;cdecl;
  aglGetVirtualScreen: function(ctx:TAGLContext):GLint;cdecl;
  aglCreatePBuffer: function(width:GLint; height:GLint; target:GLenum; internalFormat:GLenum; max_level:longint; pbuffer:PAGLPbuffer):GLboolean;cdecl;
  aglDestroyPBuffer: function(pbuffer:TAGLPbuffer):GLboolean;cdecl;
  aglSetPBuffer: function(ctx:TAGLContext; pbuffer:TAGLPbuffer; face:GLint; level:GLint; screen:GLint):GLboolean;cdecl;
{$ENDIF}{$EndIf}

var
  oglLibrary: {$IFDEF UNIX} Pointer {$ENDIF} {$IFDEF WINDOWS} HMODULE {$ENDIF};
  {$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  aglLibrary: Pointer;
  {$ENDIF}{$EndIf}

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
  zgl_opengl,
  zgl_log,
  zgl_utils;

function InitGL: Boolean;
begin
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

  oglLibrary := dlopen(libGL {$IFDEF UNIX}, $001 {$ENDIF});

  Result := oglLibrary <> LIB_ERROR;
end;

procedure FreeGL;
begin
  dlclose(oglLibrary);
end;

{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
function aglSetInt;
  var
    i: Integer;
begin
  i := params;
  Result := aglSetInteger(ctx, pname, @i);
end;

function InitAGL: Boolean;
begin
  aglLibrary := dlopen(libAGL, $001);
  if aglLibrary <> nil Then
  begin
    aglChoosePixelFormat  := dlsym(aglLibrary, 'aglChoosePixelFormat');
    aglDestroyPixelFormat := dlsym(aglLibrary, 'aglDestroyPixelFormat');
    aglCreateContext      := dlsym(aglLibrary, 'aglCreateContext');
    aglDestroyContext     := dlsym(aglLibrary, 'aglDestroyContext');
    aglUpdateContext      := dlsym(aglLibrary, 'aglUpdateContext');
    aglSetCurrentContext  := dlsym(aglLibrary, 'aglSetCurrentContext');
    aglSetDrawable        := dlsym(aglLibrary, 'aglSetDrawable');
    aglGetDrawable        := dlsym(aglLibrary, 'aglGetDrawable');
    aglSetFullScreen      := dlsym(aglLibrary, 'aglSetFullScreen');
    aglSwapBuffers        := dlsym(aglLibrary, 'aglSwapBuffers');
    aglSetInteger         := dlsym(aglLibrary, 'aglSetInteger');
    aglCreatePBuffer      := dlsym(aglLibrary, 'aglCreatePBuffer');
    aglDestroyPBuffer     := dlsym(aglLibrary, 'aglDestroyPBuffer');
    aglSetPBuffer         := dlsym(aglLibrary, 'aglSetPBuffer');
    aglEnable             := dlsym(aglLibrary, 'aglEnable');
    aglGetVirtualScreen   := dlsym(aglLibrary, 'aglGetVirtualScreen');
    Result := TRUE;
  end else
    Result := FALSE;
end;

procedure FreeAGL;
begin
  dlclose(aglLibrary);
end;
{$ENDIF}{$EndIf}

function gl_GetProc(const Proc: UTF8String): Pointer;
var
  s: String = '';
begin
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

