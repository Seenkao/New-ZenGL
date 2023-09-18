{*  Copyright (c) 2012 Andrey Kemka
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
unit zgl_opengles_all;

{$I zgl_config.cfg}

{$IFDEF UNIX}
  {$DEFINE stdcall := cdecl}
{$ENDIF}

{$IFDEF USE_TRIANGULATION}
  {$IFNDEF ANDROID}
    {$LINKLIB libGLU.a}
  {$ENDIF}
{$ENDIF}

interface

uses
  {$IFDEF USE_X11}
  X, XLib,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF iOS}
  iPhoneAll,
  {$ENDIF}
  //egl, gles        mypath = ... /fpc_3_2/lazarus/lcl/interfaces/customdrawn/android
  zgl_gles,
  math;

// Rus: инициализация OpenGL ES  и EGL (если не NO_EGL).
// Eng: initialization of OpenGL ES and EGL (if not NO_EGL).
function InitGLES : Boolean;
// Rus: деинициализация OpenGL ES  и EGL (если не NO_EGL).
// Eng: deinitialization of OpenGL ES and EGL (if not NO_EGL).
procedure FreeGLES;
// Rus: получение адреса функции.
// Eng: getting the address of the function.
function gl_GetProc( const Proc : UTF8String ) : Pointer;
// Rus: проверка поддержи расширений.
// Eng: check for extension support.
function gl_IsSupported( const Extension, SearchIn : UTF8String ) : Boolean;

const
  {$IFDEF USE_X11}
  libEGL     = 'libEGL.so';
  {$IfNDef USE_GLES20}
  libGLES_CM = 'libGLESv1_CM.so'; // 'libGLES_CM.so';
  libGLES  = 'libGLESv1.so';
  {$Else}
  libGLES  = 'libGLESv2.so';
  {$ENDIF}{$EndIf}
  {$IFDEF WINDOWS}
  libEGL     = 'libEGL.dll';
  {$IfNDef USE_GLES20}
  libGLES_CM = 'libGLES_CM.dll';
  libGLES  = 'libGLESv1.dll';
  {$Else}
  libGLES  = 'libGLESv2.dll';
  {$ENDIF}{$EndIf}
  {$IFDEF iOS}{$IfNDef USE_GLES20}
  libGLES_CM = '/System/Library/Frameworks/OpenGLES.framework/OpenGLES';
  libGLES  = '/System/Library/Frameworks/OpenGLES.framework/OpenGLES';
  {$Else}
  libGLES  = '/System/Library/Frameworks/OpenGLES.framework/OpenGLES';
  {$ENDIF}{$EndIf}
  {$IFDEF ANDROID}
  {$IfNDef NO_EGL}
  libEGL     = 'libEGL.so';
  {$EndIf}
  {$IfNDef USE_GLES20}
  libGLES_CM = 'libGLESv1_CM.so';
  libGLES  = 'libGLESv1_CM.so';
  {$Else}
  libGLES  = 'libGLESv2.so';
  {$ENDIF}{$EndIf}

var
  glGetString           : function(name: GLenum): PAnsiChar; stdcall;
  glHint                : procedure(target, mode: GLenum); stdcall;
  glShadeModel          : procedure(mode: GLenum); stdcall;
  glReadPixels          : procedure(x, y: GLint; width, height: GLsizei; format, atype: GLenum; pixels: Pointer); stdcall;
  // Color
  glColor4f             : procedure(red, green, blue, alpha: GLfloat); stdcall;
  // Clear
  glClear               : procedure(mask: GLbitfield); stdcall;
  glClearColor          : procedure(red, green, blue, alpha: GLclampf); stdcall;
  glClearDepthf         : procedure(depth: GLclampf); stdcall;
  // Get
(* 1.1 *)  glGetFloatv  : procedure(pname: GLenum; params: PGLfloat); stdcall;
  glGetIntegerv         : procedure(pname: GLenum; params: PGLint); stdcall;
  // State
  glEnable              : procedure(cap: GLenum); stdcall;
  glEnableClientState   : procedure(aarray: GLenum); stdcall;                   // gles 1.0 only
  glDisable             : procedure(cap: GLenum); stdcall;
  glDisableClientState  : procedure(aarray: GLenum); stdcall;                   // gles 1.0 only
  // Viewport
  glViewport            : procedure(x, y: GLint; width, height: GLsizei); stdcall;
  glOrthof              : procedure(left, right, bottom, top, zNear, zFar: GLfloat); stdcall;
  glScissor             : procedure(x, y: GLint; width, height: GLsizei); stdcall;
  // Depth
  glDepthFunc           : procedure(func: GLenum); stdcall;
  glDepthMask           : procedure(flag: GLboolean); stdcall;
  // Color
  glColorMask           : procedure(red, green, blue, alpha: GLboolean); stdcall;
  glColorPointer        : procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;     // gles 1.0 only
  // Alpha
  glAlphaFunc           : procedure(func: GLenum; ref: GLclampf); stdcall;      // gles 1.0 + расширения
  glBlendFunc           : procedure(sfactor, dfactor: GLenum); stdcall;
// GLES 2.0... super...
  glBlendEquation       : procedure(mode: GLenum); stdcall;
  glBlendFuncSeparate   : procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;
  // Matrix
  glPushMatrix          : procedure; stdcall;                                   // gles 1.0 only
  glPopMatrix           : procedure; stdcall;                                   // gles 1.0 only
  glMatrixMode          : procedure(mode: GLenum); stdcall;                     // gles 1.0 only
  glLoadIdentity        : procedure; stdcall;                                   // gles 1.0 only
  glLoadMatrixf         : procedure(const m: PGLfloat); stdcall;                // gles 1.0 only
  glRotatef             : procedure(angle, x, y, z: GLfloat); stdcall;          // gles 1.0 only
  glScalef              : procedure(x, y, z: GLfloat); stdcall;                 // gles 1.0 only
  glTranslatef          : procedure(x, y, z: GLfloat); stdcall;                 // gles 1.0 only
  // Vertex
  glVertexPointer       : procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;   // gles 1.0 only
  // Texture
  glBindTexture             : procedure(target: GLenum; texture: GLuint); stdcall;
  glGenTextures             : procedure(n: GLsizei; textures: PGLuint); stdcall;
  glDeleteTextures          : procedure(n: GLsizei; const textures: PGLuint); stdcall;
  glTexParameterf           : procedure(target, pname: GLenum; param: GLfloat); stdcall;
(* 1.1 *)  glTexParameteri  : procedure(target, pname: GLenum; param: GLint); stdcall;

(* 1.1 *)  glTexParameteriv : procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;

  glPixelStorei             : procedure(pname: GLenum; param: GLint); stdcall;
  glTexImage2D              : procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer); stdcall;
  glCompressedTexImage2D    : procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; imageSize: GLsizei; const pixels: Pointer); stdcall;
  glCompressedTexSubImage2D : procedure(target: GLenum; level, xoffset, yoffset: GLint ; width, height: GLsizei ; format: GLenum ; imageSize: GLsizei ; const data : Pointer); stdcall;
  glTexSubImage2D           : procedure(target: GLenum; level, xoffset, yoffset: GLint; width, height: GLsizei; format, atype: GLenum; const pixels: Pointer); stdcall;
  glCopyTexSubImage2D       : procedure(target: GLenum; level, xoffset, yoffset, x, y: GLint; width, height: GLsizei); stdcall;
  glTexEnvi                 : procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;        // gles 1.0 only
  glTexEnviv                : procedure(target: GLenum; pname: GLenum; param: PGLint); stdcall;       // gles 1.0 only
  // TexCoords
  glTexCoordPointer         : procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;  // gles 1.0 only
  //
  glDrawArrays              : procedure(mode: GLenum; first: GLint; count: GLsizei); stdcall;
  glDrawElements            : procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall;

  // FBO ... GLES 2.0 + GL_OES_framebuffer_object   !!!
  glIsRenderbuffer          : function(renderbuffer: GLuint): GLboolean; stdcall;
  glBindRenderbuffer        : procedure(target: GLenum; renderbuffer: GLuint); stdcall;
  glDeleteRenderbuffers     : procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
  glGenRenderbuffers        : procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
  glRenderbufferStorage     : procedure(target: GLenum; internalformat: GLenum; width, height: GLsizei); stdcall;
  glGetRenderbufferParameteriv : procedure(target, pname: GLenum; params: PGLint); stdcall;  // !!!!
  glIsFramebuffer           : function(framebuffer: GLuint): GLboolean; stdcall;
  glBindFramebuffer         : procedure(target: GLenum; framebuffer: GLuint); stdcall;
  glDeleteFramebuffers      : procedure(n: GLsizei; const framebuffers: PGLuint); stdcall;
  glGenFramebuffers         : procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
  glCheckFramebufferStatus  : function(target: GLenum): GLenum; stdcall;
  glFramebufferTexture2D    : procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferRenderbuffer : procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;
  glGetFramebufferAttachmentParameteriv: procedure(target, attachment, pname: GLenum; params: PGLuint); stdcall;
  glGenerateMipmap          : procedure(target: GLenum); stdcall;

  // State
  procedure glBegin(mode: GLenum);
  procedure glEnd;
// Color
  procedure _glColor4ub(red, green, blue, alpha: GLubyte); {$IFDEF USE_INLINE} inline; {$ENDIF}    // ovveride
  procedure glColor4ubv(v: PGLubyte); {$IFDEF USE_INLINE} inline; {$ENDIF}                        // nothing
  procedure _glColor4f(red, green, blue, alpha: GLfloat); {$IFDEF USE_INLINE} inline; {$ENDIF}     // ovveride
  // Matrix
  procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble);
  // Vertex
  procedure glVertex2f(x, y: GLfloat);
  procedure glVertex2fv(v: PGLfloat);
  procedure glVertex3f(x, y, z: GLfloat);
  // TexCoords
  procedure glTexCoord2f(s, t: GLfloat);
  procedure glTexCoord2fv(v: PGLfloat);

var
  {$IFNDEF NO_EGL}
  glesLibrary : {$IFDEF WINDOWS}LongWord{$ELSE}Pointer{$ENDIF};
  {$ELSE}
  glesLibrary: Pointer;
  {$ENDIF}

implementation
uses
  zgl_math_2d,
  zgl_types,
  zgl_log,
  {$IFNDEF NO_EGL}
  zgl_EGL,
  {$EndIf}
  zgl_utils
  ;

// temporary type
type
  zglGLESPVertex = ^zglGLESTVertex;
  zglGLESTVertex = record
    U, V    : Single;
    Color   : LongWord;
    X, Y, Z : Single;
  end;

var
  RenderMode     : LongWord;
  RenderQuad     : Boolean;
  RenderTextured : Boolean;
//  Buffers
  newTriangle : Integer;
  bColor      : LongWord;
  bVertices   : array of zglGLESTVertex;
  bSize       : Integer;

function InitGLES : Boolean;
begin
  {$IFDEF FPC}
    {$IF DEFINED(cpui386) or DEFINED(cpux86_64)}
    SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
    {$IFEND}
  {$ELSE}
    Set8087CW($133F);
  {$ENDIF}

{$IFNDEF NO_EGL}
  eglLibrary := dlopen( libEGL {$IFDEF UNIX}, $001 {$ENDIF} );
  if eglLibrary = LIB_ERROR Then
  begin
    separateEGL := FALSE;
    {$IfNDef USE_GLES20}
    eglLibrary  := dlopen( libGLES_CM {$IFDEF UNIX}, $001 {$ENDIF} );
    {$EndIf}
    if eglLibrary = LIB_ERROR Then
      eglLibrary := dlopen( libGLES {$IFDEF UNIX}, $001 {$ENDIF} );
  end
  else
    separateEGL := TRUE;

  {$IFDEF USE_GLES_SOFTWARE}
  glesLibrary := dlopen( 'libGLES_CM_NoE.dll' );
  {$ELSE}
  if separateEGL Then
  begin
    {$IfNDef USE_GLES20}
    glesLibrary := dlopen( libGLES_CM {$IFDEF UNIX}, $001 {$ENDIF} );
    {$EndIf}
    if glesLibrary = LIB_ERROR Then
      glesLibrary := dlopen( libGLES {$IFDEF UNIX}, $001 {$ENDIF} );
  end
  else
    glesLibrary := eglLibrary;
  {$ENDIF}
{$ELSE}
  {$IfNDef USE_GLES20}    // пока так, позже проверить всё.
  glesLibrary := dlopen( libGLES_CM, $001 );
  {$Else}
  glesLibrary := dlopen(libGLES, $001);
  {$EndIf}
{$ENDIF}

  if {$IFNDEF NO_EGL}( eglLibrary = LIB_ERROR ) or{$ENDIF} ( glesLibrary = LIB_ERROR ) Then
  begin
    Result := FALSE;
    exit;
  end;

{$IFNDEF NO_EGL}
  InitEGL;
{$ENDIF}

  glGetString                := dlsym( glesLibrary, 'glGetString' );
  glHint                     := dlsym( glesLibrary, 'glHint' );
  glShadeModel               := dlsym( glesLibrary, 'glShadeModel' );
  glReadPixels               := dlsym( glesLibrary, 'glReadPixels' );
  glClear                    := dlsym( glesLibrary, 'glClear' );
  glClearColor               := dlsym( glesLibrary, 'glClearColor' );
  glColor4f                  := dlsym( glesLibrary, 'glColor4f' );
  glClearDepthf              := dlsym( glesLibrary, 'glClearDepthf' );
  glGetFloatv                := dlsym( glesLibrary, 'glGetFloatv' );
  glGetIntegerv              := dlsym( glesLibrary, 'glGetIntegerv' );
  glEnable                   := dlsym( glesLibrary, 'glEnable' );
  glDisable                  := dlsym( glesLibrary, 'glDisable' );
{$IfNDef USE_GLES20}
  glEnableClientState        := dlsym( glesLibrary, 'glEnableClientState' );
  glDisableClientState       := dlsym( glesLibrary, 'glDisableClientState' );
  glOrthof                   := dlsym( glesLibrary, 'glOrthof' );
  glColorPointer             := dlsym( glesLibrary, 'glColorPointer' );
  glAlphaFunc                := dlsym( glesLibrary, 'glAlphaFunc' );
  glPushMatrix               := dlsym( glesLibrary, 'glPushMatrix' );
  glPopMatrix                := dlsym( glesLibrary, 'glPopMatrix' );
  glMatrixMode               := dlsym( glesLibrary, 'glMatrixMode' );
  glLoadIdentity             := dlsym( glesLibrary, 'glLoadIdentity' );
  glLoadMatrixf              := dlsym( glesLibrary, 'glLoadMatrixf' );
  glRotatef                  := dlsym( glesLibrary, 'glRotatef' );
  glScalef                   := dlsym( glesLibrary, 'glScalef' );
  glTranslatef               := dlsym( glesLibrary, 'glTranslatef' );
  glVertexPointer            := dlsym( glesLibrary, 'glVertexPointer' );
  glTexCoordPointer          := dlsym( glesLibrary, 'glTexCoordPointer' );

{$Else}
  // !!! GLES 2.0 и выше.   Проверить.
{$EndIf}
  glViewport                 := dlsym( glesLibrary, 'glViewport' );
  glScissor                  := dlsym( glesLibrary, 'glScissor' );
  glDepthFunc                := dlsym( glesLibrary, 'glDepthFunc' );
  glDepthMask                := dlsym( glesLibrary, 'glDepthMask' );
  glColorMask                := dlsym( glesLibrary, 'glColorMask' );
  glBlendFunc                := dlsym( glesLibrary, 'glBlendFunc' );
  glBindTexture              := dlsym( glesLibrary, 'glBindTexture' );
  glGenTextures              := dlsym( glesLibrary, 'glGenTextures' );
  glDeleteTextures           := dlsym( glesLibrary, 'glDeleteTextures' );
  glTexParameterf            := dlsym( glesLibrary, 'glTexParameterf' );
  glTexParameteri            := dlsym( glesLibrary, 'glTexParameteri' );
  glTexParameteriv           := dlsym( glesLibrary, 'glTexParameteriv' );
  glPixelStorei              := dlsym( glesLibrary, 'glPixelStorei' );
  glTexImage2D               := dlsym( glesLibrary, 'glTexImage2D' );
  glCompressedTexImage2D     := dlsym( glesLibrary, 'glCompressedTexImage2D' );
  glCompressedTexSubImage2D  := dlsym( glesLibrary, 'glCompressedTexSubImage2D' );
  glTexSubImage2D            := dlsym( glesLibrary, 'glTexSubImage2D' );
//  glCopyTexImage2D           := dlsym( glesLibrary, 'glCopyTexImage2D' );
  glCopyTexSubImage2D        := dlsym( glesLibrary, 'glCopyTexSubImage2D' );
  glTexEnvi                  := dlsym( glesLibrary, 'glTexEnvi' );
  glTexEnviv                 := dlsym( glesLibrary, 'glTexEnviv' );

  glDrawArrays               := dlsym( glesLibrary, 'glDrawArrays' );
  glDrawElements             := dlsym( glesLibrary, 'glDrawElements' );

  // OpenGL ES 1.0
  if not Assigned( glTexParameteri ) Then
    glTexParameteri    := dlsym( glesLibrary, 'glTexParameterx' );
  if not Assigned( glTexParameteriv ) Then
    glTexParameteriv    := dlsym( glesLibrary, 'glTexParameterxv' );
  if not Assigned( glTexEnvi ) Then
    glTexEnvi          := dlsym( glesLibrary, 'glTexEnvx' );
  if not Assigned( glTexEnviv ) Then
    glTexEnviv         := dlsym( glesLibrary, 'glTexEnvxv' );

  LoadOpenGLES;

{$IFNDEF NO_EGL}
  Result := Assigned( eglGetDisplay ) and Assigned( eglInitialize ) and Assigned( eglTerminate ) and Assigned( eglChooseConfig ) and
            Assigned( eglCreateWindowSurface ) and Assigned( eglDestroySurface ) and Assigned( eglCreateContext ) and Assigned( eglDestroyContext ) and
            Assigned( eglMakeCurrent ) and Assigned( eglSwapBuffers );
{$ELSE}
  {$IfNDef USE_GLES20}
  Result := TRUE;
  {$Else}
  Result := False;
  {$EndIf}
{$ENDIF}
end;

procedure FreeGLES;
begin
  FreeOpenGLES;
{$IFNDEF NO_EGL}
  if separateEGL Then
    dlclose( glesLibrary );
  FreeEGL;
  dlclose( eglLibrary );
{$ELSE}
  dlclose( glesLibrary );
{$ENDIF}
end;

function gl_GetProc( const Proc : UTF8String ) : Pointer;
begin
{$IFNDEF NO_EGL}
  Result := eglGetProcAddress( PAnsiChar( Proc ) );
  if Result = nil Then
    Result := eglGetProcAddress( PAnsiChar( Proc + 'OES' ) );

  if Result = nil Then
{$ENDIF}

    Result := dlsym( glesLibrary, PAnsiChar( Proc ) );
  if Result = nil Then
    Result := dlsym( glesLibrary, PAnsiChar( Proc + 'OES' ) );
end;

function gl_IsSupported( const Extension, SearchIn: UTF8String ) : Boolean;
var
  extPos: Integer;
begin
  extPos := Pos( Extension, SearchIn );
  Result := extPos > 0;
  if Result Then
    Result := ( ( extPos + Length( Extension ) - 1 ) = Length( SearchIn ) ) or ( SearchIn[ extPos + Length( Extension ) ] = ' ' );
// ввести отладку!!!
//  log_Add(Extension + ' - ' + u_BoolToStr(Result));
end;

procedure glBegin(mode: GLenum);
begin
  bSize := 0;
  RenderTextured := FALSE;

  if Mode = GL_QUADS Then
  begin
    RenderQuad  := TRUE;
    newTriangle := 0;
    RenderMode  := GL_TRIANGLES;
  end else
  begin
    RenderQuad := FALSE;
    RenderMode := Mode;
  end;
end;

procedure glEnd;
begin
  if bSize = 0 Then exit;

  if RenderTextured Then
  begin
    glEnableClientState( GL_TEXTURE_COORD_ARRAY );
    glTexCoordPointer( 2, GL_FLOAT, 24, @bVertices[ 0 ] );
  end;

  glEnableClientState( GL_COLOR_ARRAY );
  glColorPointer( 4, GL_UNSIGNED_BYTE, 24, @bVertices[ 0 ].Color );

  glEnableClientState( GL_VERTEX_ARRAY );
  glVertexPointer( 3, GL_FLOAT, 24, @bVertices[ 0 ].X );

  glDrawArrays( RenderMode, 0, bSize );

  glDisableClientState( GL_VERTEX_ARRAY );
  glDisableClientState( GL_COLOR_ARRAY );
  if RenderTextured Then
    glDisableClientState( GL_TEXTURE_COORD_ARRAY );
  bSize := 0;
end;

procedure _glColor4ub(red, green, blue, alpha: GLubyte);
begin
  PByteArray(@bColor)[0] := red;
  PByteArray(@bColor)[1] := green;
  PByteArray(@bColor)[2] := blue;
  PByteArray(@bColor)[3] := alpha;
end;

procedure glColor4ubv(v: PGLubyte);
begin
  bColor := PLongWord( v )^;
end;

procedure _glColor4f(red, green, blue, alpha: GLfloat);
begin
  PByteArray(@bColor)[0] := Round(red * 255);
  PByteArray(@bColor)[1] := Round(green * 255);
  PByteArray(@bColor)[2] := Round(blue * 255);
  PByteArray(@bColor)[3] := Round(alpha * 255);
end;

{$IFDEF ANDROID}
function tan( x : Single ) : Single;
var
  _sin,_cos : Single;
begin
  m_SinCos( x, _sin, _cos );
  tan := _sin / _cos;
end;
{$ENDIF}

procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble);
var
  m : array[ 1..4, 1..4 ] of Single;
  f : Single;
begin
  f := 1 / tan( FOVY * pi / 360 );

  m[ 1, 1 ] := f / aspect;
  m[ 1, 2 ] := 0;
  m[ 1, 3 ] := 0;
  m[ 1, 4 ] := 0;

  m[ 2, 1 ] := 0;
  m[ 2, 2 ] := f;
  m[ 2, 3 ] := 0;
  m[ 2, 4 ] := 0;

  m[ 3, 1 ] := 0;
  m[ 3, 2 ] := 0;
  m[ 3, 3 ] := ( zFar + zNear ) / ( zNear - zFar );
  m[ 3, 4 ] := -1;

  m[ 4, 1 ] := 0;
  m[ 4, 2 ] := 0;
  m[ 4, 3 ] := 2 * zFar * zNear / ( zNear - zFar );
  m[ 4, 4 ] := 0;

  glLoadMatrixf( @m[ 1, 1 ] );
end;

procedure glVertex2f(x, y: GLfloat);
var
  vertex : zglGLESPVertex;
begin
  if ( not RenderTextured ) and ( bSize = Length( bVertices ) ) Then
    SetLength( bVertices, bSize + 1024 );

  vertex       := @bVertices[ bSize ];
  vertex.X     := x;
  vertex.Y     := y;
  vertex.Z     := 0;
  vertex.Color := bColor;
  INC( bSize );
  if RenderQuad Then
  begin
    INC( newTriangle );
    if newTriangle = 3 Then
    begin
      if bSize = Length( bVertices ) Then
        SetLength( bVertices, bSize + 1024 );
      bVertices[ bSize ] := bVertices[ bSize - 1 ];

      INC( bSize );
    end else
      if newTriangle = 4 Then
      begin
        if bSize = Length( bVertices ) Then
          SetLength( bVertices, bSize + 1024 );
        bVertices[ bSize ] := bVertices[ bSize - 5 ];

        INC( bSize );
        newTriangle := 0;
      end;
  end;
end;

procedure glVertex2fv(v: PGLfloat);
var
  vertex : zglGLESPVertex;
begin
  if ( not RenderTextured ) and ( bSize = Length( bVertices ) ) Then
    SetLength( bVertices, bSize + 1024 );

  vertex       := @bVertices[ bSize ];
  vertex.X     := zglPPoint2D( v ).X;
  vertex.Y     := zglPPoint2D( v ).Y;
  vertex.Z     := 0;
  vertex.Color := bColor;
  INC( bSize );
  if RenderQuad Then
  begin
    INC( newTriangle );
    if newTriangle = 3 Then
    begin
      if bSize = Length( bVertices ) Then
        SetLength( bVertices, bSize + 1024 );
      bVertices[ bSize ] := bVertices[ bSize - 1 ];

      INC( bSize );
    end else
      if newTriangle = 4 Then
      begin
        if bSize = Length( bVertices ) Then
          SetLength( bVertices, bSize + 1024 );
        bVertices[ bSize ] := bVertices[ bSize - 5 ];

        INC( bSize );
        newTriangle := 0;
      end;
  end;
end;

procedure glVertex3f(x, y, z: GLfloat);
var
  vertex : zglGLESPVertex;
begin
  if ( not RenderTextured ) and ( bSize = Length( bVertices ) ) Then
    SetLength( bVertices, bSize + 1024 );

  vertex       := @bVertices[ bSize ];
  vertex.X     := x;
  vertex.Y     := y;
  vertex.Z     := z;
  vertex.Color := bColor;
  INC( bSize );
  if RenderQuad Then
  begin
    INC( newTriangle );
    if newTriangle = 3 Then
    begin
      if bSize = Length( bVertices ) Then
        SetLength( bVertices, bSize + 1024 );
      bVertices[ bSize ] := bVertices[ bSize - 1 ];

      INC( bSize );
    end else
      if newTriangle = 4 Then
      begin
        if bSize = Length( bVertices ) Then
          SetLength( bVertices, bSize + 1024 );
        bVertices[ bSize ] := bVertices[ bSize - 5 ];

        INC( bSize );
        newTriangle := 0;
      end;
  end;
end;

procedure glGetTexImage(target: GLenum; level: GLint; format: GLenum; atype: GLenum; pixels: Pointer);
begin
end;

procedure glTexCoord2f(s, t: GLfloat);
begin
  RenderTextured := TRUE;

  if bSize = Length( bVertices ) Then
    SetLength( bVertices, bSize + 1024 );
  bVertices[ bSize ].U := s;
  bVertices[ bSize ].V := t;
end;

procedure glTexCoord2fv(v: PGLfloat);
begin
  RenderTextured := TRUE;

  if bSize = Length( bVertices ) Then
    SetLength( bVertices, bSize + 1024 );
  bVertices[ bSize ].U := zglPPoint2D( v ).X;
  bVertices[ bSize ].V := zglPPoint2D( v ).Y;
end;                                           

end.
