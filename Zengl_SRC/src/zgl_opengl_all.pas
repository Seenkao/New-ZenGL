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
unit zgl_opengl_all;

{$I zgl_config.cfg}
{$IFDEF UNIX}
  {$DEFINE stdcall := cdecl}
{$ENDIF}
{$IFDEF MACOSX}
  {$LINKFRAMEWORK OpenGL}
{$ENDIF}

interface

  {$IFDEF LINUX}
uses
  X, XLib, XUtil;
  {$ENDIF}
  {$IFDEF WINDOWS}
uses
  Windows;
  {$ENDIF}
  {$IFDEF MACOSX}
uses
  MacOSAll;
  {$ENDIF}


function InitGL: Boolean;
procedure FreeGL;
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
function InitAGL: Boolean;
procedure FreeAGL;
{$ENDIF}{$EndIf}
function gl_GetProc(const Proc: UTF8String): Pointer;
function gl_IsSupported(const Extension, SearchIn: UTF8String): Boolean;

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
  libAGL = '/System/Library/Frameworks/AGL.framework/AGL';
  {$ENDIF}

  GL_FALSE                          = 0;
  GL_TRUE                           = 1;
  GL_ZERO                           = 0;
  GL_ONE                            = 1;

  // String Name
  GL_VENDOR                         = $1F00;
  GL_RENDERER                       = $1F01;
  GL_VERSION                        = $1F02;
  GL_EXTENSIONS                     = $1F03;

  // DataType
  GL_UNSIGNED_BYTE                  = $1401;
  GL_UNSIGNED_SHORT                 = $1403;
  GL_UNSIGNED_INT                   = $1405;
  GL_FLOAT                          = $1406;
  GL_UNSIGNED_SHORT_4_4_4_4         = $8033;

  // PixelFormat
  GL_RED                            = $1903;
  GL_GREEN                          = $1904;
  GL_BLUE                           = $1905;
  GL_ALPHA                          = $1906;
  GL_RGB                            = $1907;
  GL_RGBA                           = $1908;

  // Alpha Function
  GL_NEVER                          = $0200;
  GL_LESS                           = $0201;
  GL_EQUAL                          = $0202;
  GL_LEQUAL                         = $0203;
  GL_GREATER                        = $0204;
  GL_NOTEQUAL                       = $0205;
  GL_GEQUAL                         = $0206;
  GL_ALWAYS                         = $0207;

  // Blend
  GL_BLEND                          = $0BE2;
  // Blending Factor Dest
  GL_SRC_COLOR                      = $0300;
  GL_ONE_MINUS_SRC_COLOR            = $0301;
  GL_SRC_ALPHA                      = $0302;
  GL_ONE_MINUS_SRC_ALPHA            = $0303;
  GL_DST_ALPHA                      = $0304;
  GL_ONE_MINUS_DST_ALPHA            = $0305;
  // Blending Factor Src
  GL_DST_COLOR                      = $0306;
  GL_ONE_MINUS_DST_COLOR            = $0307;
  GL_SRC_ALPHA_SATURATE             = $0308;

  // blendOP
  GL_FUNC_ADD_EXT                   = $8006;
  GL_MIN_EXT                        = $8007;
  GL_MAX_EXT                        = $8008;
  GL_FUNC_SUBTRACT_EXT              = $800A;
  GL_FUNC_REVERSE_SUBTRACT_EXT      = $800B;
  GL_BLEND_EQUATION_EXT             = $8009;

  GL_BLEND_DST_RGB_EXT              = $80C8;
  GL_BLEND_SRC_RGB_EXT              = $80C9;
  GL_BLEND_DST_ALPHA_EXT            = $80CA;
  GL_BLEND_SRC_ALPHA_EXT            = $80CB;
  GL_BLEND_EQUATION_RGB_EXT         = $8009;
  GL_BLEND_EQUATION_ALPHA_EXT       = $883D;

  // Hint Mode
  GL_DONT_CARE                      = $1100;
  GL_FASTEST                        = $1101;
  GL_NICEST                         = $1102;

  // Hints
  GL_PERSPECTIVE_CORRECTION_HINT    = $0C50;
  GL_LINE_SMOOTH_HINT               = $0C52;
  GL_POLYGON_SMOOTH_HINT            = $0C53;
  GL_FOG_HINT                       = $0C54;

  // Shading Model
  GL_SHADE_MODEL                    = $0B54;
  GL_FLAT                           = $1D00;
  GL_SMOOTH                         = $1D01;

  // Buffer Bit
  GL_DEPTH_BUFFER_BIT               = $00000100;
  GL_STENCIL_BUFFER_BIT             = $00000400;
  GL_COLOR_BUFFER_BIT               = $00004000;

  // Enable
  GL_LINE_SMOOTH                    = $0B20;
  GL_POLYGON_SMOOTH                 = $0B41;
  GL_NORMALIZE                      = $0BA1;

  // glBegin/glEnd
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

  // Texture
  GL_UNPACK_ROW_LENGTH              = $0CF2;
  GL_TEXTURE_2D                     = $0DE1;
  GL_TEXTURE0_ARB                   = $84C0;
  GL_MAX_TEXTURE_SIZE               = $0D33;
  GL_MAX_TEXTURE_UNITS_ARB          = $84E2;
  GL_TEXTURE_MAX_ANISOTROPY_EXT     = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF;
  // Texture Wrap Mode
  GL_CLAMP_TO_EDGE                  = $812F;
  GL_REPEAT                         = $2901;
  // Texture Format
  GL_RGB16                          = $8054;
  GL_RGBA16                         = $805B;
  GL_COMPRESSED_RGB_ARB             = $84ED;
  GL_COMPRESSED_RGBA_ARB            = $84EE;
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT   = $83F0;
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  = $83F1;
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT  = $83F2;
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT  = $83F3;
  // Texture Env Mode
  GL_MODULATE                       = $2100;
  GL_DECAL                          = $2101;
  // Texture Env Parameter
  GL_TEXTURE_ENV_MODE               = $2200;
  GL_TEXTURE_ENV_COLOR              = $2201;
  // Texture Env Target
  GL_TEXTURE_ENV                    = $2300;
  // Texture Mag Filter
  GL_NEAREST                        = $2600;
  GL_LINEAR                         = $2601;
  // Mipmaps
  GL_GENERATE_MIPMAP                = $8191;
  GL_GENERATE_MIPMAP_HINT           = $8192;
  // Texture Min Filter
  GL_NEAREST_MIPMAP_NEAREST         = $2700;
  GL_LINEAR_MIPMAP_NEAREST          = $2701;
  GL_NEAREST_MIPMAP_LINEAR          = $2702;
  GL_LINEAR_MIPMAP_LINEAR           = $2703;
  // Texture Parameter Name
  GL_TEXTURE_MAG_FILTER             = $2800;
  GL_TEXTURE_MIN_FILTER             = $2801;
  GL_TEXTURE_WRAP_S                 = $2802;
  GL_TEXTURE_WRAP_T                 = $2803;

  GL_COMBINE_ARB                    = $8570;
  GL_COMBINE_RGB_ARB                = $8571;
  GL_COMBINE_ALPHA_ARB              = $8572;
  GL_SOURCE0_RGB_ARB                = $8580;
  GL_SOURCE1_RGB_ARB                = $8581;
  GL_SOURCE2_RGB_ARB                = $8582;
  GL_SOURCE0_ALPHA_ARB              = $8588;
  GL_SOURCE1_ALPHA_ARB              = $8589;
  GL_SOURCE2_ALPHA_ARB              = $858A;
  GL_OPERAND0_RGB_ARB               = $8590;
  GL_OPERAND1_RGB_ARB               = $8591;
  GL_OPERAND2_RGB_ARB               = $8592;
  GL_OPERAND0_ALPHA_ARB             = $8598;
  GL_OPERAND1_ALPHA_ARB             = $8599;
  GL_OPERAND2_ALPHA_ARB             = $859A;
  GL_RGB_SCALE_ARB                  = $8573;
  GL_ADD_SIGNED_ARB                 = $8574;
  GL_INTERPOLATE_ARB                = $8575;
  GL_SUBTRACT_ARB                   = $84E7;
  GL_CONSTANT_ARB                   = $8576;
  GL_PRIMARY_COLOR_ARB              = $8577;
  GL_PREVIOUS_ARB                   = $8578;
  GL_DOT3_RGB                       = $86AE;
  GL_DOT3_RGBA                      = $86AF;

  // Vertex Array
  GL_VERTEX_ARRAY                   = $8074;
  GL_NORMAL_ARRAY                   = $8075;
  GL_COLOR_ARRAY                    = $8076;
  GL_INDEX_ARRAY                    = $8077;
  GL_TEXTURE_COORD_ARRAY            = $8078;

  // FBO
  GL_FRAMEBUFFER                    = $8D40;
  GL_RENDERBUFFER                   = $8D41;
  GL_DEPTH_COMPONENT16              = $81A5;
  GL_DEPTH_COMPONENT24              = $81A6;
  GL_DEPTH_COMPONENT32              = $81A7;
  GL_COLOR_ATTACHMENT0              = $8CE0;
  GL_DEPTH_ATTACHMENT               = $8D00;
  GL_MAX_RENDERBUFFER_SIZE          = $84E8;

  // Matrices
  GL_MODELVIEW_MATRIX               = $0BA6;
  GL_PROJECTION_MATRIX              = $0BA7;

  // Matrix Mode
  GL_MODELVIEW                      = $1700;
  GL_PROJECTION                     = $1701;
  GL_TEXTURE                        = $1702;

  // Test
  GL_DEPTH_TEST                     = $0B71;
  GL_STENCIL_TEST                   = $0B90;
  GL_ALPHA_TEST                     = $0BC0;
  GL_SCISSOR_TEST                   = $0C11;

  // StencilOp
  GL_KEEP                           = $1E00;
  GL_REPLACE                        = $1E01;
  GL_INCR                           = $1E02;
  GL_DECR                           = $1E03;

  // VBO
  GL_BUFFER_SIZE_ARB                = $8764;
  GL_ARRAY_BUFFER_ARB               = $8892;
  GL_ELEMENT_ARRAY_BUFFER_ARB       = $8893;
  GL_WRITE_ONLY_ARB                 = $88B9;
  GL_STREAM_DRAW_ARB                = $88E0;
  GL_STATIC_DRAW_ARB                = $88E4;

  // Triangulation
  GLU_TESS_BEGIN                    = $18704;
  GLU_TESS_VERTEX                   = $18705;
  GLU_TESS_END                      = $18706;
  GLU_TESS_ERROR                    = $18707;
  GLU_TESS_EDGE_FLAG                = $18708;
  GLU_TESS_COMBINE                  = $18709;
  GLU_TESS_BEGIN_DATA               = $1870A;
  GLU_TESS_VERTEX_DATA              = $1870B;
  GLU_TESS_END_DATA                 = $1870C;
  GLU_TESS_ERROR_DATA               = $1870D;
  GLU_TESS_EDGE_FLAG_DATA           = $1870E;
  GLU_TESS_COMBINE_DATA             = $1870F;

type
  GLenum     = Cardinal;      PGLenum     = ^GLenum;
  GLboolean  = Byte;          PGLboolean  = ^GLboolean;
  GLbitfield = Cardinal;      PGLbitfield = ^GLbitfield;
  GLbyte     = ShortInt;      PGLbyte     = ^GLbyte;
  GLshort    = SmallInt;      PGLshort    = ^GLshort;
  GLint      = Integer;       PGLint      = ^GLint;
  GLsizei    = Integer;       PGLsizei    = ^GLsizei;
  GLubyte    = Byte;          PGLubyte    = ^GLubyte;
  GLushort   = Word;          PGLushort   = ^GLushort;
  GLuint     = Cardinal;      PGLuint     = ^GLuint;
  GLfloat    = Single;        PGLfloat    = ^GLfloat;
  GLclampf   = Single;        PGLclampf   = ^GLclampf;
  GLdouble   = Double;        PGLdouble   = ^GLdouble;
  GLclampd   = Double;        PGLclampd   = ^GLclampd;
{ GLvoid     = void; }        PGLvoid     = Pointer;
                              PPGLvoid    = ^PGLvoid;

  function  glGetString(name: GLenum): PAnsiChar; stdcall; external libGL;
  procedure glHint(target, mode: GLenum); stdcall; external libGL;

  procedure glShadeModel(mode: GLenum); stdcall; external libGL;

  procedure glReadPixels(x, y: GLint; width, height: GLsizei; format, atype: GLenum; pixels: Pointer); stdcall; external libGL;

  // Clear
  procedure glClear(mask: GLbitfield); stdcall; external libGL;
  procedure glClearColor(red, green, blue, alpha: GLclampf); stdcall; external libGL;
  procedure glClearDepth(depth: GLclampd); stdcall; external libGL;
  // Get
  procedure glGetFloatv(pname: GLenum; params: PGLfloat); stdcall; external libGL;
  procedure glGetIntegerv(pname: GLenum; params: PGLint); stdcall; external libGL;
  // State
  procedure glBegin(mode: GLenum); stdcall; external libGL;
  procedure glEnd; stdcall; external libGL;
  procedure glEnable(cap: GLenum); stdcall; external libGL;
  procedure glEnableClientState(aarray: GLenum); stdcall; external libGL;
  procedure glDisable(cap: GLenum); stdcall; external libGL;
  procedure glDisableClientState(aarray: GLenum); stdcall; external libGL;
  // Viewport
  procedure glViewport(x, y: GLint; width, height: GLsizei); stdcall; external libGL;
  procedure glOrtho(left, right, bottom, top, zNear, zFar: GLdouble); stdcall; external libGL;
  procedure glScissor(x, y: GLint; width, height: GLsizei); stdcall; external libGL;
  // Depth
  procedure glDepthFunc(func: GLenum); stdcall; external libGL;
  procedure glDepthMask(flag: GLboolean); stdcall; external libGL;
  // Color
  procedure glColor4ub(red, green, blue, alpha: GLubyte); stdcall; external libGL;
  procedure glColor4ubv(v: PGLubyte); stdcall; external libGL;

  procedure glColor3ub(red, green, blue: GLbyte); stdcall; external libGL;
  procedure glColor3ubv(v: PGLfloat); stdcall; external libGL;
  procedure glColor4f(red, green, blue, alpha: GLfloat); stdcall; external libGL;
  procedure glColor4fv(v: PGLfloat); stdcall; external libGL;
  procedure glColorMask(red, green, blue, alpha: GLboolean); stdcall; external libGL;
  // Alpha
  procedure glAlphaFunc(func: GLenum; ref: GLclampf); stdcall; external libGL;
  procedure glBlendFunc(sfactor, dfactor: GLenum); stdcall; external libGL;
//var
//  glBlendEquation: procedure(mode: GLenum); stdcall;
//  glBlendFuncSeparate: procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;
  // Matrix
  procedure glPushMatrix; stdcall; external libGL;
  procedure glPopMatrix; stdcall; external libGL;
  procedure glMatrixMode(mode: GLenum); stdcall; external libGL;
  procedure glLoadIdentity; stdcall; external libGL;

  procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble); stdcall; external libGLU;

  procedure glLoadMatrixf(const m: PGLfloat); stdcall; external libGL;
  procedure glRotatef(angle, x, y, z: GLfloat); stdcall; external libGL;
  procedure glScalef(x, y, z: GLfloat); stdcall; external libGL;
  procedure glTranslatef(x, y, z: GLfloat); stdcall; external libGL;
  // Vertex
  procedure glVertex2f(x, y: GLfloat); stdcall; external libGL;
  procedure glVertex2fv(v: PGLfloat); stdcall; external libGL;
  procedure glVertex3f(x, y, z: GLfloat); stdcall; external libGL;
  procedure glVertexPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  // Texture
  procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external libGL;
  procedure glGenTextures(n: GLsizei; textures: PGLuint); stdcall; external libGL;
  procedure glDeleteTextures(n: GLsizei; const textures: PGLuint); stdcall; external libGL;
  procedure glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat); stdcall; external libGL;
  procedure glTexParameteri(target: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glPixelStorei(pname: GLenum; param: GLint); stdcall; external libGL;
  procedure glTexImage2D(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer); stdcall; external libGL;
  procedure glTexSubImage2D(target: GLenum; level, xoffset, yoffset: GLint; width, height: GLsizei; format, atype: GLenum; const pixels: Pointer); stdcall; external libGL;
  procedure glGetTexImage(target: GLenum; level: GLint; format: GLenum; atype: GLenum; pixels: Pointer); stdcall; external libGL;
  procedure glCopyTexSubImage2D(target: GLenum; level, xoffset, yoffset, x, y: GLint; width, height: GLsizei); stdcall; external libGL;
  procedure glTexEnvi(target: GLenum; pname: GLenum; param: GLint); stdcall; external libGL;
  
  function  gluBuild2DMipmaps(target: GLenum; components, width, height: GLint; format, atype: GLenum; const data: Pointer): Integer; stdcall; external libGLU;
  // TexCoords
  procedure glTexCoord2f(s, t: GLfloat); stdcall; external libGL;
  procedure glTexCoord2fv(v: PGLfloat); stdcall; external libGL;

  //---------------------------------------------------------------------
  procedure glDrawArrays(mode: GLenum; first: GLint; count: GLsizei); stdcall; external libGL;
  procedure glDrawElements(mode: GLenum; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall; external libGL;
  procedure glColorPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  procedure glTexCoordPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall; external libGL;
  //---------------------------------------------------------------------

  // deprecated
  procedure glPointSize(size: GLfloat); stdcall; external libGL;
var
  //
//  glCompressedTexImage2D: procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; imageSize: GLsizei; const pixels: Pointer); stdcall;
  // FBO
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

  // Triangulation
  {$IFDEF USE_TRIANGULATION}
  procedure gluDeleteTess(tess: Integer); stdcall external libGLU;
  function  gluErrorString(error: Integer): PAnsiChar; stdcall external libGLU;
  function  gluNewTess: Integer; stdcall external libGLU;
  procedure gluTessBeginContour(tess: Integer); stdcall external libGLU;
  procedure gluTessBeginPolygon(tess: Integer; data: Pointer); stdcall external libGLU;
  procedure gluTessCallback(tess: Integer; which: Integer; fn: Pointer); stdcall external libGLU;
  procedure gluTessEndContour(tess: Integer); stdcall external libGLU;
  procedure gluTessEndPolygon(tess: Integer); stdcall external libGLU;
  procedure gluTessVertex(tess: Integer; vertex: PDouble; data: Pointer); stdcall external libGLU;
  {$ENDIF}

{$IFDEF LINUX}
type
  GLXFBConfig = Pointer;
  GLXContext  = Pointer;
  GLXPBuffer  = TXID;
  GLXDrawable = TXID;

const
  GLX_EXTENSIONS   = 3;
  GLX_BUFFER_SIZE  = 2;
  GLX_RGBA         = 4;
  GLX_DOUBLEBUFFER = 5;
  GLX_RED_SIZE     = 8;
  GLX_GREEN_SIZE   = 9;
  GLX_BLUE_SIZE    = 10;
  GLX_ALPHA_SIZE   = 11;
  GLX_DEPTH_SIZE   = 12;
  GLX_STENCIL_SIZE = 13;

  GLX_SAMPLES_SGIS = $186A1;

  // PBuffer
  GLX_PBUFFER_HEIGHT     = $8040;
  GLX_PBUFFER_WIDTH      = $8041;
  GLX_PRESERVED_CONTENTS = $801B;
  GLX_LARGEST_PBUFFER    = $801C;
  GLX_DRAWABLE_TYPE      = $8010;
  GLX_RENDER_TYPE        = $8011;
  GLX_RGBA_BIT           = $0001;
  GLX_PBUFFER_BIT        = $0004;

  function  glXChooseVisual(dpy: PDisplay; screen: Integer; attribList: PInteger): PXVisualInfo; cdecl; external libGL;
  function  glXCreateContext(dpy: PDisplay; vis: PXVisualInfo; shareList: GLXContext; direct: Boolean): GLXContext; cdecl; external libGL;
  procedure glXDestroyContext(dpy: PDisplay; ctx: GLXContext); cdecl; external libGL;
  function  glXMakeCurrent(dpy: PDisplay; drawable: GLXDrawable; ctx: GLXContext): Boolean; cdecl; external libGL;
  procedure glXSwapBuffers(dpy: PDisplay; drawable: GLXDrawable); cdecl; external libGL;
  function  glXQueryExtension(dpy: PDisplay; out errorb, event: Integer): Boolean; cdecl; external libGL;
  function  glXQueryVersion(dpy: PDisplay; out major, minor: Integer): Boolean; cdecl; external libGL;
  function  glXIsDirect(dpy: PDisplay; ctx: GLXContext): Boolean; cdecl; external libGL;
  function  glXQueryServerString(dpy: PDisplay; screen: Integer; name: Integer): PAnsiChar; cdecl; external libGL;

var
  glXGetProcAddressARB: function(name: PAnsiChar): Pointer; cdecl;
  glXSwapIntervalSGI: function(interval: Integer): Integer; cdecl;
  // PBuffer
  glXGetVisualFromFBConfig: function(dpy: PDisplay; config: Integer): PXVisualInfo; cdecl;
  glXChooseFBConfig: function(dpy: PDisplay; screen: Integer; attribList: PInteger; nitems: PInteger): GLXFBConfig; cdecl;
  glXCreatePbuffer: function(dpy: PDisplay; config: Integer; attribList: PInteger): GLXPBuffer; cdecl;
  glXDestroyPbuffer: procedure(dpy: PDisplay; pbuf: GLXPBuffer); cdecl;
  glXCreateGLXPbufferSGIX: function(dpy: PDisplay; config: Integer; width, height: LongWord; attribList: PInteger): GLXPBuffer; cdecl;
  glXDestroyGLXPbufferSGIX: procedure(dpy: PDisplay; pbuf: GLXPBuffer); cdecl;
{$ENDIF}
{$IFDEF WINDOWS}
const
  // Pixel Format
  WGL_DRAW_TO_WINDOW_ARB    = $2001;
  WGL_ACCELERATION_ARB      = $2003;
  WGL_FULL_ACCELERATION_ARB = $2027;
  WGL_SUPPORT_OPENGL_ARB    = $2010;
  WGL_DOUBLE_BUFFER_ARB     = $2011;
  WGL_PIXEL_TYPE_ARB        = $2013;
  WGL_COLOR_BITS_ARB        = $2014;
  WGL_RED_BITS_ARB          = $2015;
  WGL_GREEN_BITS_ARB        = $2017;
  WGL_BLUE_BITS_ARB         = $2019;
  WGL_ALPHA_BITS_ARB        = $201B;
  WGL_DEPTH_BITS_ARB        = $2022;
  WGL_STENCIL_BITS_ARB      = $2023;
  WGL_TYPE_RGBA_ARB         = $202B;

  // AA
  WGL_SAMPLE_BUFFERS_ARB    = $2041;
  WGL_SAMPLES_ARB           = $2042;

  // PBuffer
  WGL_DRAW_TO_PBUFFER_ARB   = $202D;

  function wglGetProcAddress(proc: PAnsiChar): Pointer; stdcall; external libGL;
var
  wglChoosePixelFormatARB: function(hdc: HDC; const piAttribIList: PGLint; const pfAttribFList: PGLfloat; nMaxFormats: GLuint; piFormats: PGLint; nNumFormats: PGLuint): BOOL; stdcall;
  wglSwapInterval: function(interval: GLint): BOOL; stdcall;
  // PBuffer
  wglCreatePbufferARB: function(hDC: HDC; iPixelFormat: GLint; iWidth: GLint; iHeight: GLint; const piAttribList: PGLint): THandle; stdcall;
  wglGetPbufferDCARB: function(hPbuffer: THandle): HDC; stdcall;
  wglReleasePbufferDCARB: function(hPbuffer: THandle; hDC: HDC): GLint; stdcall;
  wglDestroyPbufferARB: function(hPbuffer: THandle): BOOL; stdcall;
{$ENDIF}
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
  {$IFDEF LINUX}
  glXGetProcAddressARB := gl_GetProc('glXGetProcAddress');
  {$ENDIF}

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
begin
  {$IFDEF WINDOWS}
  Result := wglGetProcAddress(PAnsiChar(Proc));                
  if Result = nil Then
    Result := wglGetProcAddress(PAnsiChar(Proc + 'ARB'));
  if Result = nil Then
    Result := wglGetProcAddress(PAnsiChar(Proc + 'EXT'));
  {$ELSE}
  Result := dlsym(oglLibrary, PAnsiChar(Proc));
  if Result = nil Then
    Result := dlsym(oglLibrary, PAnsiChar(Proc + 'ARB'));
  if Result = nil Then
    Result := dlsym(oglLibrary, PAnsiChar(Proc + 'EXT'));

  {$IFDEF LINUX}
  if (Result = nil) and Assigned(glXGetProcAddressARB) Then
    Result := glXGetProcAddressARB(PAnsiChar(Proc));
  {$ENDIF}
  {$ENDIF}
end;


function gl_IsSupported(const Extension, SearchIn: UTF8String): Boolean;
  var
    extPos: Integer;
begin
  extPos := Pos(Extension, SearchIn);
  Result := extPos > 0;
  if Result Then
    Result := ((extPos + Length(Extension) - 1) = Length(SearchIn)) or (SearchIn[extPos + Length(Extension)] = ' ');
end;

end.

