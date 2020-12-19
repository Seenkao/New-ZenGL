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
  math;


function InitGLES : Boolean;
procedure FreeGLES;

function gl_GetProc( const Proc : UTF8String ) : Pointer;
function gl_IsSupported( const Extension, SearchIn : UTF8String ) : Boolean;

const
  {$IFNDEF USE_GLES_ON_DESKTOP}
    {$IFDEF USE_X11}
    libEGL     = 'libEGL.so';
    libGLES_CM = 'libGLES_CM.so';
    libGLESv1  = 'libGLESv1.so';
    libGLESv2  = 'libGLESv2.so';
    {$ENDIF}
    {$IFDEF WINDOWS}
    libEGL     = 'libEGL.dll';
    libGLES_CM = 'libGLES_CM.dll';
    libGLESv1  = 'libGLESv1.dll';
    libGLESv2  = 'libGLESv2.dll';
    {$ENDIF}
    {$IFDEF iOS}
    libGLES_CM = '/System/Library/Frameworks/OpenGLES.framework/OpenGLES';
    libGLESv1  = '/System/Library/Frameworks/OpenGLES.framework/OpenGLES';
    libGLESv2  = '/System/Library/Frameworks/OpenGLES.framework/OpenGLES';
    {$ENDIF}
    {$IFDEF ANDROID}
    libEGL     = 'libEGL.so';
    libGLES_CM = 'libGLESv1_CM.so';
    libGLESv1  = 'libGLESv1_CM.so';
    libGLESv2  = 'libGLESv2.so';
    {$ENDIF}
  {$ELSE}
    {$IFDEF LINUX}
      {$IFNDEF USE_AMD_DRIVER}
      libEGL     = 'libEGL.so';
      libGLES_CM = 'libGLES_CM.so';
      libGLESv1  = 'libGLESv1.so';
      libGLESv2  = 'libGLESv2.so';
      {$ELSE}
      libEGL     = 'libGL.so.1';
      libGLES_CM = 'libGL.so.1';
      libGLESv1  = 'libGL.so.1';
      libGLESv2  = 'libGL.so.1';
      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}
    libEGL     = 'libEGL.dll';
    libGLES_CM = 'libGLES_CM.dll';
    libGLESv1  = 'libGLESv1.dll';
    libGLESv2  = 'libGLESv2.dll';
    {$ENDIF}
  {$ENDIF}

  GL_FALSE                            = 0;
  GL_TRUE                             = 1;
  GL_ZERO                             = 0;
  GL_ONE                              = 1;

  // String Name
  GL_VENDOR                           = $1F00;
  GL_RENDERER                         = $1F01;
  GL_VERSION                          = $1F02;
  GL_EXTENSIONS                       = $1F03;

  // DataType
  GL_UNSIGNED_BYTE                    = $1401;
  GL_UNSIGNED_SHORT                   = $1403;
  GL_FLOAT                            = $1406;
  GL_UNSIGNED_SHORT_4_4_4_4           = $8033;

  // PixelFormat
  GL_RGBA                             = $1908;

  // Alpha Function
  GL_NEVER                            = $0200;
  GL_LESS                             = $0201;
  GL_EQUAL                            = $0202;
  GL_LEQUAL                           = $0203;
  GL_GREATER                          = $0204;
  GL_NOTEQUAL                         = $0205;
  GL_GEQUAL                           = $0206;
  GL_ALWAYS                           = $0207;

  // Blend
  GL_BLEND                            = $0BE2;
  // Blending Factor Dest
  GL_SRC_COLOR                        = $0300;
  GL_ONE_MINUS_SRC_COLOR              = $0301;
  GL_SRC_ALPHA                        = $0302;
  GL_ONE_MINUS_SRC_ALPHA              = $0303;
  GL_DST_ALPHA                        = $0304;
  GL_ONE_MINUS_DST_ALPHA              = $0305;
  // Blending Factor Src
  GL_DST_COLOR                        = $0306;
  GL_ONE_MINUS_DST_COLOR              = $0307;
  GL_SRC_ALPHA_SATURATE               = $0308;

  // -------------------------------------------------------------
  GL_FRONT = $0404;
  GL_BACK = $0405;
  GL_FRONT_AND_BACK = $0408;
  GL_FOG = $0B60;
  GL_LIGHTING = $0B50;
  GL_CULL_FACE = $0B44;
  GL_COLOR_LOGIC_OP = $0BF2;
  GL_DITHER = $0BD0;
  GL_POINT_SMOOTH = $0B10;
  GL_COLOR_MATERIAL = $0B57;
  GL_RESCALE_NORMAL = $803A;
  GL_POLYGON_OFFSET_FILL = $8037;
  GL_MULTISAMPLE = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;
  GL_SAMPLE_ALPHA_TO_ONE = $809F;
  GL_SAMPLE_COVERAGE = $80A0;
  GL_NO_ERROR = 0;
  GL_INVALID_ENUM = $0500;
  GL_INVALID_VALUE = $0501;
  GL_INVALID_OPERATION = $0502;
  GL_STACK_OVERFLOW = $0503;
  GL_STACK_UNDERFLOW = $0504;
  GL_OUT_OF_MEMORY = $0505;
  GL_EXP = $0800;
  GL_EXP2 = $0801;
  GL_FOG_DENSITY = $0B62;
  GL_FOG_START = $0B63;
  GL_FOG_END = $0B64;
  GL_FOG_MODE = $0B65;
  GL_FOG_COLOR = $0B66;
  GL_CW = $0900;
  GL_CCW = $0901;
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;
  GL_ALIASED_POINT_SIZE_RANGE = $846D;
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;
  GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = $8B9A;
  GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = $8B9B;
  GL_MAX_LIGHTS = $0D31;
  GL_MAX_MODELVIEW_STACK_DEPTH = $0D36;
  GL_MAX_PROJECTION_STACK_DEPTH = $0D38;
  GL_MAX_TEXTURE_STACK_DEPTH = $0D39;
  GL_MAX_VIEWPORT_DIMS = $0D3A;
  GL_MAX_ELEMENTS_VERTICES = $80E8;
  GL_MAX_ELEMENTS_INDICES = $80E9;
  GL_MAX_TEXTURE_UNITS = $84E2;
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;
  GL_SUBPIXEL_BITS = $0D50;
  GL_RED_BITS = $0D52;
  GL_GREEN_BITS = $0D53;
  GL_BLUE_BITS = $0D54;
  GL_ALPHA_BITS = $0D55;
  GL_DEPTH_BITS = $0D56;
  GL_STENCIL_BITS = $0D57;
  GL_POINT_SMOOTH_HINT = $0C51;
  GL_LIGHT_MODEL_AMBIENT = $0B53;
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;
  GL_AMBIENT = $1200;
  GL_DIFFUSE = $1201;
  GL_SPECULAR = $1202;
  GL_POSITION = $1203;
  GL_SPOT_DIRECTION = $1204;
  GL_SPOT_EXPONENT = $1205;
  GL_SPOT_CUTOFF = $1206;
  GL_CONSTANT_ATTENUATION = $1207;
  GL_LINEAR_ATTENUATION = $1208;
  GL_QUADRATIC_ATTENUATION = $1209;
  GL_BYTE = $1400;
  GL_SHORT = $1402;
  GL_FIXED = $140C;
  GL_CLEAR = $1500;
  GL_AND = $1501;
  GL_AND_REVERSE = $1502;
  GL_COPY = $1503;
  GL_AND_INVERTED = $1504;
  GL_NOOP = $1505;
  GL_XOR = $1506;
  GL_OR = $1507;
  GL_NOR = $1508;
  GL_EQUIV = $1509;
  GL_INVERT = $150A;
  GL_OR_REVERSE = $150B;
  GL_COPY_INVERTED = $150C;
  GL_OR_INVERTED = $150D;
  GL_NAND = $150E;
  GL_SET = $150F;
  GL_EMISSION = $1600;
  GL_SHININESS = $1601;
  GL_AMBIENT_AND_DIFFUSE = $1602;
  GL_ALPHA = $1906;
  GL_RGB = $1907;
  GL_LUMINANCE = $1909;
  GL_LUMINANCE_ALPHA = $190A;
  GL_UNPACK_ALIGNMENT = $0CF5;
  GL_PACK_ALIGNMENT = $0D05;
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  GL_ADD = $0104;
  GL_TEXTURE0 = $84C0;
  GL_TEXTURE1 = $84C1;
  GL_TEXTURE2 = $84C2;
  GL_TEXTURE3 = $84C3;
  GL_TEXTURE4 = $84C4;
  GL_TEXTURE5 = $84C5;
  GL_TEXTURE6 = $84C6;
  GL_TEXTURE7 = $84C7;
  GL_TEXTURE8 = $84C8;
  GL_TEXTURE9 = $84C9;
  GL_TEXTURE10 = $84CA;
  GL_TEXTURE11 = $84CB;
  GL_TEXTURE12 = $84CC;
  GL_TEXTURE13 = $84CD;
  GL_TEXTURE14 = $84CE;
  GL_TEXTURE15 = $84CF;
  GL_TEXTURE16 = $84D0;
  GL_TEXTURE17 = $84D1;
  GL_TEXTURE18 = $84D2;
  GL_TEXTURE19 = $84D3;
  GL_TEXTURE20 = $84D4;
  GL_TEXTURE21 = $84D5;
  GL_TEXTURE22 = $84D6;
  GL_TEXTURE23 = $84D7;
  GL_TEXTURE24 = $84D8;
  GL_TEXTURE25 = $84D9;
  GL_TEXTURE26 = $84DA;
  GL_TEXTURE27 = $84DB;
  GL_TEXTURE28 = $84DC;
  GL_TEXTURE29 = $84DD;
  GL_TEXTURE30 = $84DE;
  GL_TEXTURE31 = $84DF;
  GL_PALETTE4_RGB8_OES = $8B90;
  GL_PALETTE4_RGBA8_OES = $8B91;
  GL_PALETTE4_R5_G6_B5_OES = $8B92;
  GL_PALETTE4_RGBA4_OES = $8B93;
  GL_PALETTE4_RGB5_A1_OES = $8B94;
  GL_PALETTE8_RGB8_OES = $8B95;
  GL_PALETTE8_RGBA8_OES = $8B96;
  GL_PALETTE8_R5_G6_B5_OES = $8B97;
  GL_PALETTE8_RGBA4_OES = $8B98;
  GL_PALETTE8_RGB5_A1_OES = $8B99;
  GL_LIGHT0 = $4000;
  GL_LIGHT1 = $4001;
  GL_LIGHT2 = $4002;
  GL_LIGHT3 = $4003;
  GL_LIGHT4 = $4004;
  GL_LIGHT5 = $4005;
  GL_LIGHT6 = $4006;
  GL_LIGHT7 = $4007;

  //EGL
  EGL_VERSION_1_0 = 1;
  EGL_VERSION_1_1 = 1;
  EGL_VERSION_1_2 = 1;
  EGL_VERSION_1_3 = 1;
  EGL_FALSE = 0;
  EGL_TRUE = 1;
  EGL_BUFFER_SIZE = $3020;
  EGL_CONFIG_CAVEAT = $3027;
  EGL_CONFIG_ID = $3028;
  EGL_LEVEL = $3029;
  EGL_MAX_PBUFFER_HEIGHT = $302A;
  EGL_MAX_PBUFFER_PIXELS = $302B;
  EGL_MAX_PBUFFER_WIDTH = $302C;
  EGL_NATIVE_RENDERABLE = $302D;
  EGL_NATIVE_VISUAL_ID = $302E;
  EGL_NATIVE_VISUAL_TYPE = $302F;
  EGL_PRESERVED_RESOURCES = $3030;
  EGL_SAMPLE_BUFFERS = $3032;
  EGL_TRANSPARENT_TYPE = $3034;
  EGL_TRANSPARENT_BLUE_VALUE = $3035;
  EGL_TRANSPARENT_GREEN_VALUE = $3036;
  EGL_TRANSPARENT_RED_VALUE = $3037;
  EGL_BIND_TO_TEXTURE_RGB = $3039;
  EGL_BIND_TO_TEXTURE_RGBA = $303A;
  EGL_MIN_SWAP_INTERVAL = $303B;
  EGL_MAX_SWAP_INTERVAL = $303C;
  EGL_LUMINANCE_SIZE = $303D;
  EGL_ALPHA_MASK_SIZE = $303E;
  EGL_COLOR_BUFFER_TYPE = $303F;
  EGL_MATCH_NATIVE_PIXMAP = $3041;
  EGL_SLOW_CONFIG = $3050;
  EGL_NON_CONFORMANT_CONFIG = $3051;
  EGL_TRANSPARENT_RGB = $3052;
  EGL_RGB_BUFFER = $308E;
  EGL_LUMINANCE_BUFFER = $308F;
  EGL_NO_TEXTURE = $305C;
  EGL_TEXTURE_RGB = $305D;
  EGL_TEXTURE_RGBA = $305E;
  EGL_TEXTURE_2D = $305F;
  EGL_PIXMAP_BIT = $02;
  EGL_OPENVG_BIT = $02;
  EGL_VENDOR = $3053;
  EGL_VERSION = $3054;
  EGL_EXTENSIONS = $3055;
  EGL_CLIENT_APIS = $308D;
  EGL_HEIGHT = $3056;
  EGL_WIDTH = $3057;
  EGL_LARGEST_PBUFFER = $3058;
  EGL_TEXTURE_FORMAT = $3080;
  EGL_TEXTURE_TARGET = $3081;
  EGL_MIPMAP_TEXTURE = $3082;
  EGL_MIPMAP_LEVEL = $3083;
  EGL_RENDER_BUFFER = $3086;
  EGL_COLORSPACE = $3087;
  EGL_ALPHA_FORMAT = $3088;
  EGL_HORIZONTAL_RESOLUTION = $3090;
  EGL_VERTICAL_RESOLUTION = $3091;
  EGL_PIXEL_ASPECT_RATIO = $3092;
  EGL_SWAP_BEHAVIOR = $3093;
  EGL_BACK_BUFFER = $3084;
  EGL_SINGLE_BUFFER = $3085;
  EGL_COLORSPACE_sRGB = $3089;
  EGL_COLORSPACE_LINEAR = $308A;
  EGL_ALPHA_FORMAT_NONPRE = $308B;
  EGL_ALPHA_FORMAT_PRE = $308C;
  EGL_DISPLAY_SCALING = 10000;
  EGL_BUFFER_PRESERVED = $3094;
  EGL_BUFFER_DESTROYED = $3095;
  EGL_OPENVG_IMAGE = $3096;
  EGL_CONTEXT_CLIENT_TYPE = $3097;
  EGL_CONTEXT_CLIENT_VERSION = $3098;
  EGL_OPENGL_ES_API = $30A0;
  EGL_OPENVG_API = $30A1;
  EGL_DRAW = $3059;
  EGL_READ = $305A;
  EGL_CORE_NATIVE_ENGINE = $305B;
  //--------------------------------------------------------------

  // blendOP
  GL_FUNC_ADD_EXT                     = $8006; 
  GL_MIN_EXT                          = $8007;
  GL_MAX_EXT                          = $8008;
  GL_FUNC_SUBTRACT_EXT                = $800A;
  GL_FUNC_REVERSE_SUBTRACT_EXT        = $800B;

  GL_BLEND_DST                        = $0BE0;
  GL_BLEND_SRC                        = $0BE1;

  // Hint Mode
  GL_DONT_CARE                        = $1100;
  GL_FASTEST                          = $1101;
  GL_NICEST                           = $1102;

  // Hints
  GL_PERSPECTIVE_CORRECTION_HINT      = $0C50;
  GL_LINE_SMOOTH_HINT                 = $0C52;
  GL_FOG_HINT                         = $0C54;

  // Shading Model
  GL_SHADE_MODEL                      = $0B54;
  GL_FLAT                             = $1D00;
  GL_SMOOTH                           = $1D01;

  // Buffer Bit
  GL_DEPTH_BUFFER_BIT                 = $00000100;
  GL_STENCIL_BUFFER_BIT               = $00000400;
  GL_COLOR_BUFFER_BIT                 = $00004000;

  // Enable
  GL_LINE_SMOOTH                      = $0B20;
  GL_NORMALIZE                        = $0BA1;

  // glBegin/glEnd
  GL_POINTS                           = $0000;
  GL_LINES                            = $0001;
  GL_LINE_LOOP                        = $0002;
  GL_LINE_STRIP                       = $0003;
  GL_TRIANGLES                        = $0004;
  GL_TRIANGLE_STRIP                   = $0005;
  GL_TRIANGLE_FAN                     = $0006;
  GL_QUADS                            = $0007;

  // Texture
  GL_TEXTURE_2D                       = $0DE1;
  GL_MAX_TEXTURE_SIZE                 = $0D33;
  GL_TEXTURE_MAX_ANISOTROPY_EXT       = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT   = $84FF;
  // Texture Wrap Mode
  GL_CLAMP_TO_EDGE                    = $812F;
  GL_REPEAT                           = $2901;
  // Texture Format
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG  = $8C00;
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG  = $8C01;
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG = $8C02;
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG = $8C03;
  // Texture Env Mode
  GL_MODULATE                         = $2100;
  GL_DECAL                            = $2101;
  // Texture Env Parameter
  GL_TEXTURE_ENV_MODE                 = $2200;
  GL_TEXTURE_ENV_COLOR                = $2201;
  // Texture Env Target
  GL_TEXTURE_ENV                      = $2300;
  // Texture Mag Filter
  GL_NEAREST                          = $2600;
  GL_LINEAR                           = $2601;
  // Mipmaps
  GL_GENERATE_MIPMAP                  = $8191;
  GL_GENERATE_MIPMAP_HINT             = $8192;
  // Texture Min Filter
  GL_NEAREST_MIPMAP_NEAREST           = $2700;
  GL_LINEAR_MIPMAP_NEAREST            = $2701;
  GL_NEAREST_MIPMAP_LINEAR            = $2702;
  GL_LINEAR_MIPMAP_LINEAR             = $2703;
  // Texture Parameter Name
  GL_TEXTURE_MAG_FILTER               = $2800;
  GL_TEXTURE_MIN_FILTER               = $2801;
  GL_TEXTURE_WRAP_S                   = $2802;
  GL_TEXTURE_WRAP_T                   = $2803;

  GL_COMBINE_ARB                      = $8570;
  GL_COMBINE_RGB_ARB                  = $8571;
  GL_COMBINE_ALPHA_ARB                = $8572;
  GL_SOURCE0_RGB_ARB                  = $8580;
  GL_SOURCE1_RGB_ARB                  = $8581;
  GL_SOURCE2_RGB_ARB                  = $8582;
  GL_SOURCE0_ALPHA_ARB                = $8588;
  GL_SOURCE1_ALPHA_ARB                = $8589;
  GL_SOURCE2_ALPHA_ARB                = $858A;
  GL_OPERAND0_RGB_ARB                 = $8590;
  GL_OPERAND1_RGB_ARB                 = $8591;
  GL_OPERAND2_RGB_ARB                 = $8592;
  GL_OPERAND0_ALPHA_ARB               = $8598;
  GL_OPERAND1_ALPHA_ARB               = $8599;
  GL_OPERAND2_ALPHA_ARB               = $859A;
  GL_RGB_SCALE_ARB                    = $8573;

  GL_ADD_SIGNED                       = $8574;
  GL_INTERPOLATE_ARB                  = $8575;
  GL_SUBTRACT_ARB                     = $84E7;
  GL_CONSTANT_ARB                     = $8576;
  GL_PRIMARY_COLOR_ARB                = $8577;
  GL_PREVIOUS_ARB                     = $8578;
  GL_DOT3_RGB                         = $86AE;
  GL_DOT3_RGBA                        = $86AF;

  // Vertex Array
  GL_VERTEX_ARRAY                     = $8074;
  GL_NORMAL_ARRAY                     = $8075;
  GL_COLOR_ARRAY                      = $8076;
  GL_TEXTURE_COORD_ARRAY              = $8078;

  // FBO
  GL_FRAMEBUFFER                      = $8D40;
  GL_RENDERBUFFER                     = $8D41;
  GL_DEPTH_COMPONENT16                = $81A5;
  GL_DEPTH_COMPONENT24                = $81A6;
  GL_DEPTH_COMPONENT32                = $81A7;
  GL_COLOR_ATTACHMENT0                = $8CE0;
  GL_DEPTH_ATTACHMENT                 = $8D00;
  GL_MAX_RENDERBUFFER_SIZE            = $84E8;

  // Matrices
  GL_MODELVIEW_MATRIX                 = $0BA6;
  GL_PROJECTION_MATRIX                = $0BA7;

  // Matrix Mode
  GL_MODELVIEW                        = $1700;
  GL_PROJECTION                       = $1701;
  GL_TEXTURE                          = $1702;

  // Test
  GL_DEPTH_TEST                       = $0B71;
  GL_STENCIL_TEST                     = $0B90;
  GL_ALPHA_TEST                       = $0BC0;
  GL_SCISSOR_TEST                     = $0C11;

  // StencilOp
  GL_KEEP                             = $1E00;
  GL_REPLACE                          = $1E01;
  GL_INCR                             = $1E02;
  GL_DECR                             = $1E03;

  // VBO
  GL_BUFFER_SIZE_ARB                  = $8764;
  GL_ARRAY_BUFFER_ARB                 = $8892;
  GL_ELEMENT_ARRAY_BUFFER_ARB         = $8893;
  GL_WRITE_ONLY_ARB                   = $88B9;
  GL_STATIC_DRAW_ARB                  = $88E4;
  GL_DYNAMIC_DRAW_ARB                 = $88E8;

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

var
  glGetString           : function(name: GLenum): PAnsiChar; stdcall;
  glHint                : procedure(target, mode: GLenum); stdcall;
  glShadeModel          : procedure(mode: GLenum); stdcall;
  glReadPixels          : procedure(x, y: GLint; width, height: GLsizei; format, atype: GLenum; pixels: Pointer); stdcall;
  // Color
//  glColor4f             : procedure(red, green, blue, alpha: GLfloat); stdcall;
  // Clear
  glClear               : procedure(mask: GLbitfield); stdcall;
  glClearColor          : procedure(red, green, blue, alpha: GLclampf); stdcall;
  {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  glClearDepthf         : procedure(depth: GLclampd); stdcall;
  {$ELSE}
  glClearDepthf         : procedure(depth: GLclampf); stdcall;
  {$ENDIF}
  // Get
  glGetFloatv           : procedure(pname: GLenum; params: PGLfloat); stdcall;
  glGetIntegerv         : procedure(pname: GLenum; params: PGLint); stdcall;
  // State
  glEnable              : procedure(cap: GLenum); stdcall;
  glEnableClientState   : procedure(aarray: GLenum); stdcall;
  glDisable             : procedure(cap: GLenum); stdcall;
  glDisableClientState  : procedure(aarray: GLenum); stdcall;
  // Viewport
  glViewport            : procedure(x, y: GLint; width, height: GLsizei); stdcall;
  {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  glOrthof              : procedure(left, right, bottom, top, zNear, zFar: GLdouble); stdcall;
  {$ELSE}
  glOrthof              : procedure(left, right, bottom, top, zNear, zFar: GLfloat); stdcall;
  {$ENDIF}
  glScissor             : procedure(x, y: GLint; width, height: GLsizei); stdcall;
  // Depth
  glDepthFunc           : procedure(func: GLenum); stdcall;
  glDepthMask           : procedure(flag: GLboolean); stdcall;
  // Color
  glColorMask           : procedure(red, green, blue, alpha: GLboolean); stdcall;
  glColorPointer        : procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;
  // Alpha
  glAlphaFunc           : procedure(func: GLenum; ref: GLclampf); stdcall;
  glBlendFunc           : procedure(sfactor, dfactor: GLenum); stdcall;
  glBlendEquation       : procedure(mode: GLenum); stdcall;
  glBlendFuncSeparate   : procedure(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum); stdcall;
  // Matrix
  glPushMatrix          : procedure; stdcall;
  glPopMatrix           : procedure; stdcall;
  glMatrixMode          : procedure(mode: GLenum); stdcall;
  glLoadIdentity        : procedure; stdcall;
  glLoadMatrixf         : procedure(const m: PGLfloat); stdcall;
  glRotatef             : procedure(angle, x, y, z: GLfloat); stdcall;
  glScalef              : procedure(x, y, z: GLfloat); stdcall;
  glTranslatef          : procedure(x, y, z: GLfloat); stdcall;
  // Vertex
  glVertexPointer       : procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;
  // Texture
  glBindTexture             : procedure(target: GLenum; texture: GLuint); stdcall;
  glGenTextures             : procedure(n: GLsizei; textures: PGLuint); stdcall;
  glDeleteTextures          : procedure(n: GLsizei; const textures: PGLuint); stdcall;
  glTexParameterf           : procedure(target: GLenum; pname: GLenum; param: GLfloat); stdcall;
  glTexParameteri           : procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;

  glTexParameteriv          : procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;

  glPixelStorei             : procedure(pname: GLenum; param: GLint); stdcall;
  glTexImage2D              : procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer); stdcall;
  glCompressedTexImage2D    : procedure(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; imageSize: GLsizei; const pixels: Pointer); stdcall;
  glCompressedTexSubImage2D : procedure(target: GLenum ; level: GLint ; xoffset: GLint ; yoffset: GLint ; width: GLsizei ; height: GLsizei ; format: GLenum ; imageSize: GLsizei ; const data : Pointer); stdcall;
  glTexSubImage2D           : procedure(target: GLenum; level, xoffset, yoffset: GLint; width, height: GLsizei; format, atype: GLenum; const pixels: Pointer); stdcall;
  glCopyTexSubImage2D       : procedure(target: GLenum; level, xoffset, yoffset, x, y: GLint; width, height: GLsizei); stdcall;
  glTexEnvi                 : procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;
  glTexEnviv                : procedure(target: GLenum; pname: GLenum; param: PGLint); stdcall;
  // TexCoords
  glTexCoordPointer         : procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); stdcall;
  //
  glDrawArrays              : procedure(mode: GLenum; first: GLint; count: GLsizei); stdcall;
  glDrawElements            : procedure(mode: GLenum; count: GLsizei; _type: GLenum; const indices: PGLvoid); stdcall;

  // FBO
  glIsRenderbuffer          : function(renderbuffer: GLuint): GLboolean; stdcall;
  glBindRenderbuffer        : procedure(target: GLenum; renderbuffer: GLuint); stdcall;
  glDeleteRenderbuffers     : procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
  glGenRenderbuffers        : procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
  glRenderbufferStorage     : procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
  glIsFramebuffer           : function(framebuffer: GLuint): GLboolean; stdcall;
  glBindFramebuffer         : procedure(target: GLenum; framebuffer: GLuint); stdcall;
  glDeleteFramebuffers      : procedure(n: GLsizei; const framebuffers: PGLuint); stdcall;
  glGenFramebuffers         : procedure(n: GLsizei; framebuffers: PGLuint); stdcall;
  glCheckFramebufferStatus  : function(target: GLenum): GLenum; stdcall;
  glFramebufferTexture2D    : procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); stdcall;
  glFramebufferRenderbuffer : procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); stdcall;

  // ------------------------------------------------------------------------------
  glActiveTexture           : procedure(texture: GLenum); stdcall;
  glClearStencil            : procedure(s: GLint); stdcall;
  glClientActiveTexture     : procedure(texture: GLenum); stdcall;
  glCopyTexImage2D          : procedure(target: GLenum ; level: GLint ; internalformat: GLenum ; x: GLint ; y: GLint ; width: GLsizei ; height: GLsizei ; border: GLint); stdcall;
  glCullFace                : procedure(mode: GLenum); stdcall;
  glDepthRangef             : procedure(zNear: GLclampf ; zFar: GLclampf); stdcall;
  glFinish                  : procedure( ); stdcall;
  glFlush                   : procedure( ); stdcall;
  glFogf                    : procedure(pname: GLenum ; param: GLfloat); stdcall;
  glFogfv                   : procedure(pname: GLenum ; const params : PGLfloat); stdcall;
  glFrustumf                : procedure(left: GLfloat ; right: GLfloat ; bottom: GLfloat ; top: GLfloat ; zNear: GLfloat ; zFar: GLfloat); stdcall;
  glFrontFace               : procedure(mode: GLenum); stdcall;
  glGetError                : function( ):GLenum; stdcall;
  glLightModelf             : procedure(pname: GLenum ; param: GLfloat); stdcall;
  glLightModelfv            : procedure(pname: GLenum ; const params: PGLfloat); stdcall;
  glLightf                  : procedure(light: GLenum ; pname: GLenum ; param: GLfloat); stdcall;
  glLightfv                 : procedure(light: GLenum ; pname: GLenum ; const params : PGLfloat); stdcall;
  glLineWidth               : procedure(width: GLfloat); stdcall;
  glLogicOp                 : procedure(opcode: GLenum); stdcall;
  glMaterialf               : procedure(face: GLenum ; pname: GLenum ; param: GLfloat); stdcall;
  glMaterialfv              : procedure(face: GLenum ; pname: GLenum ; const params: PGLfloat); stdcall;
  glMultMatrixf             : procedure(const m: PGLfloat); stdcall;
  glMultiTexCoord4f         : procedure(target: GLenum ; s: GLfloat ; t: GLfloat ; r: GLfloat ; q: GLfloat); stdcall;
  glNormal3f                : procedure(nx: GLfloat ; ny: GLfloat ; nz: GLfloat); stdcall;
  glNormalPointer           : procedure(atype: GLenum ; stride: GLsizei ; const data : Pointer); stdcall;
  glPointSize               : procedure(size: GLfloat); stdcall;
  glPolygonOffset           : procedure(factor: GLfloat ; units: GLfloat); stdcall;
  glSampleCoverage          : procedure(value: GLclampf ; invert: GLboolean); stdcall;
  glStencilFunc             : procedure(func: GLenum ; ref: GLint ; mask: GLuint); stdcall;
  glStencilMask             : procedure(mask: GLuint); stdcall;
  glStencilOp               : procedure(fail: GLenum ; zfail: GLenum ; zpass: GLenum); stdcall;
  glTexEnvf                 : procedure(target: GLenum ; pname: GLenum ; param: GLfloat); stdcall;
  glTexEnvfv                : procedure(target: GLenum ; pname: GLenum ; const params: PGLfloat); stdcall;

{$IfDef USE_FULL_OPENGL}
  glAlphaFuncx              : procedure(func: GLenum ; ref: GLclampx); stdcall;
  glColor4x                 : procedure(red, green, blue, alpha: GLint); stdcall;
  glOrthox                  : procedure(left, right, bottom, top, zNear, zFar: GLsizei); stdcall;
  glLoadMatrixx             : procedure(const m: PGLsizei); stdcall;
  glRotatex                 : procedure(angle, x, y, z: GLint); stdcall;
  glScalex                  : procedure(x, y, z: GLint); stdcall;
  glTranslatex              : procedure(x, y, z: GLint); stdcall;
  glClearColorx             : procedure(red: GLclampx ; green: GLclampx ; blue: GLclampx ; alpha: GLclampx); stdcall;
  glClearDepthx             : procedure(depth: GLclampx); stdcall;
  glDepthRangex             : procedure(zNear: GLclampx ; zFar: GLclampx); stdcall;
  glFogx                    : procedure(pname: GLenum ; param: GLfixed); stdcall
  glFogxv                   : procedure(pname: GLenum ; const params : PGLfixed); stdcall;
  glFrustumx                : procedure(left: GLfixed ; right: GLfixed ; bottom: GLfixed ; top: GLfixed ; zNear: GLfixed ; zFar: GLfixed); stdcall;
  glLightModelx             : procedure(pname: GLenum ; param: GLfixed); stdcall;
  glLightModelxv            : procedure(pname: GLenum ; const params: PGLfixed); stdcall;
  glLightx                  : procedure(light: GLenum ; pname: GLenum ; param: GLfixed); stdcall;
  glLightxv                 : procedure(light: GLenum ; pname: GLenum ; const params: PGLfixed); stdcall;
  glLineWidthx              : procedure(width: GLfixed); stdcall;
  glMaterialx               : procedure(face: GLenum ; pname: GLenum ; param: GLfixed); stdcall;
  glMaterialxv              : procedure(face: GLenum ; pname: GLenum ; const params: PGLfixed); stdcall;
  glMultMatrixx             : procedure(const m: PGLfixed); stdcall;
  glMultiTexCoord4x         : procedure(target: GLenum ; s: GLfixed ; t: GLfixed ; r: GLfixed ; q: GLfixed); stdcall;
  glNormal3x                : procedure(nx: GLfixed ; ny: GLfixed ; nz: GLfixed); stdcall;
  glPointSizex              : procedure(size: GLfixed); stdcall;
  glPolygonOffsetx          : procedure(factor: GLfixed ; units: GLfixed); stdcall;
  glSampleCoveragex         : procedure(value: GLclampx ; invert: GLboolean); stdcall;
{$EndIf}
  { GLES 1.1
    procedure glBindBuffer(target: GLenum; buffer: GLuint); stdcall;
    procedure glBufferData(target: GLenum; size: GLsizei; const data: PGLvoid; usage: GLenum); stdcall;
    procedure glBufferSubData(target: GLenum; offset: GLint; size: GLsizei; const data: PGLvoid); stdcall;
    procedure glClipPlanef(plane: GLenum; const equation: GLfloat); stdcall;
    procedure glClipPlanex(plane: GLenum; const equation: GLfloat); stdcall;            // узнать в чём разница!!!
    glColor4ub : procedure(red, green, blue, alpha: GLubyte); stdcall;
    glGetFloatv: procedure(pname: GLenum; params: PGLfloat); stdcall;
    glGetBooleanv: procedure(pname: GLenum; params: PGLboolean); stdcall;               // прописаны, но существуют ли?
    glGetBufferParameteriv : procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
    glGetClipPlanef : procedure(plane: GLenum; equation: PGLdouble); stdcall;
    glGetClipPlanex : procedure(plane: GLenum; equation: PGLdouble); stdcall;
    glGetFixedv
    glGetLightfv: procedure(light, pname: GLenum; params: PGLfloat); stdcall;
    glGetLightxv: procedure(light, pname: GLenum; params: PGLint); stdcall;
    glGetMaterialfv: procedure(face, pname: GLenum; params: PGLfloat); stdcall;
    glGetMaterialxv: procedure(face, pname: GLenum; params: PGLint); stdcall;
    glGetPointerv: procedure(pname: GLenum; params: Pointer); stdcall;
    glGetTexEnvfv: procedure(target, pname: GLenum; params: PGLfloat); stdcall;
    glGetTexEnviv: procedure(target, pname: GLenum; params: PGLint); stdcall;
    glGetTexEnvxv: procedure(target, pname: GLenum; params: PGLint); stdcall;
    glGetTexParameterfv: procedure(target, pname: GLenum; params: PGLfloat); stdcall;
    glGetTexParameteriv: procedure(target, pname: GLenum; params: PGLint); stdcall;
    glGetTexParameterxv: procedure(target, pname: GLenum; params: PGLint); stdcall;
    glIsBuffer : function(buffer: GLuint): GLboolean; stdcall;
    glIsEnabled: function(cap: GLenum): GLboolean; stdcall;
    glIsTexture: function(texture: GLuint): GLboolean; stdcall;
    glPointParameterf : procedure(pname: GLenum; param: GLfloat); stdcall;
    glPointParameterfv : procedure(pname: GLenum; const params: PGLfloat); stdcall;
    glPointParameterx : procedure(pname: GLenum; param: GLint); stdcall;
    glPointParameterxv : procedure(pname: GLenum; const params: PGLint); stdcall;
    glPointSizePointerOES
    glWeightPointerOES (GLint size, GLenum type, GLsizei stride, const void *pointer); stdcall;
  }

  // State
  procedure glBegin(mode: GLenum);
  procedure glEnd;
// Color
  procedure glColor4ub(red, green, blue, alpha: GLubyte); {$IFDEF USE_INLINE} inline; {$ENDIF}
  procedure glColor4ubv(v: PGLubyte); {$IFDEF USE_INLINE} inline; {$ENDIF}
  procedure glColor4f(red, green, blue, alpha: GLfloat); {$IFDEF USE_INLINE} inline; {$ENDIF}
  // Matrix
  procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble);
  // Vertex
  procedure glVertex2f(x, y: GLfloat);
  procedure glVertex2fv(v: PGLfloat);
  procedure glVertex3f(x, y, z: GLfloat);
  // TexCoords
  procedure glTexCoord2f(s, t: GLfloat);
  procedure glTexCoord2fv(v: PGLfloat);

// Triangulation
  {$IFDEF USE_TRIANGULATION}
  procedure gluDeleteTess(tess: Integer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  function  gluErrorString(error: Integer): PChar; stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  function  gluNewTess: Integer; stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  procedure gluTessBeginContour(tess: Integer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  procedure gluTessBeginPolygon(tess: Integer; data: Pointer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  procedure gluTessCallback(tess: Integer; which: Integer; fn: Pointer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  procedure gluTessEndContour(tess: Integer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  procedure gluTessEndPolygon(tess: Integer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  procedure gluTessVertex(tess: Integer; vertex: PDouble; data: Pointer); stdcall external {$IFDEF ANDROID} 'libGLU' {$ENDIF};
  {$ENDIF}

// EGL
{$IFNDEF NO_EGL}
// EGL Types
type
  {$IFDEF USE_X11}
  EGLNativeDisplayType = PDisplay;
  EGLNativeWindowType  = TWindow;
  {$ENDIF}
  {$IFDEF WINDOWS}
  EGLNativeDisplayType = HDC;
  EGLNativeWindowType  = HWND;
  {$ENDIF}
  {$IFDEF ANDROID} // android-9
  EGLNativeDisplayType = Integer;
  EGLNativeWindowType  = Pointer;
  {$ENDIF}
  EGLBoolean      = LongBool;
  EGLint          = LongInt;
  PEGLint         = ^EGLint;
  EGLenum         = LongWord;
  EGLConfig       = Pointer;
  PEGLConfig      = ^EGLConfig;
  EGLContext      = Pointer;
  EGLDisplay      = Pointer;
  EGLSurface      = Pointer;
  EGLClientBuffer = Pointer;

const
  EGL_SUCCESS             = $3000;
  EGL_NOT_INITIALIZED     = $3001;
  EGL_BAD_ACCESS          = $3002;
  EGL_BAD_ALLOC           = $3003;
  EGL_BAD_ATTRIBUTE       = $3004;
  EGL_BAD_CONFIG          = $3005;
  EGL_BAD_CONTEXT         = $3006;
  EGL_BAD_CURRENT_SURFACE = $3007;
  EGL_BAD_DISPLAY         = $3008;
  EGL_BAD_MATCH           = $3009;
  EGL_BAD_NATIVE_PIXMAP   = $300A;
  EGL_BAD_NATIVE_WINDOW   = $300B;
  EGL_BAD_PARAMETER       = $300C;
  EGL_BAD_SURFACE         = $300D;
  EGL_CONTEXT_LOST        = $300E;

  {$IFDEF WINDOWS or ANDROID}
  EGL_DEFAULT_DISPLAY = 0;
  {$ELSE}
  EGL_DEFAULT_DISPLAY = nil;
  {$ENDIF}
  EGL_NO_CONTEXT      = nil;
  EGL_NO_DISPLAY      = nil;
  EGL_NO_SURFACE      = nil;

  EGL_NONE            = $3038;

  EGL_ALPHA_SIZE      = $3021;
  EGL_BLUE_SIZE       = $3022;
  EGL_GREEN_SIZE      = $3023;
  EGL_RED_SIZE        = $3024;
  EGL_DEPTH_SIZE      = $3025;
  EGL_STENCIL_SIZE    = $3026;
  EGL_SAMPLES         = $3031;

  EGL_SURFACE_TYPE    = $3033;
  EGL_PBUFFER_BIT     = $0001;
  EGL_WINDOW_BIT      = $0004;

  EGL_RENDERABLE_TYPE = $3040;
  EGL_OPENGL_ES_BIT   = $0001;
  EGL_OPENGL_ES2_BIT  = $0004;

var
  eglGetProcAddress      : function( name: PAnsiChar ) : Pointer; stdcall;
  eglGetError            : function : GLint; stdcall;
  eglGetDisplay          : function( display_id : EGLNativeDisplayType ) : EGLDisplay; stdcall;
  eglInitialize          : function( dpy : EGLDisplay; major : PEGLint; minor : PEGLint ) : EGLBoolean; stdcall;
  eglTerminate           : function( dpy : EGLDisplay ) : EGLBoolean; stdcall;
  eglChooseConfig        : function( dpy : EGLDisplay; attrib_list : PEGLint; configs : PEGLConfig; config_size : EGLint; num_config : PEGLint ) : EGLBoolean; stdcall;
  eglCreateWindowSurface : function( dpy : EGLDisplay; config : EGLConfig; win : EGLNativeWindowType; attrib_list : PEGLint ) : EGLSurface; stdcall;
  eglDestroySurface      : function( dpy : EGLDisplay; surface : EGLSurface ) : EGLBoolean; stdcall;
  eglSwapInterval        : function( dpy : EGLDisplay; interval : EGLint ) : EGLBoolean; stdcall;
  eglCreateContext       : function( dpy : EGLDisplay; config : EGLConfig; share_context : EGLContext; attrib_list : PEGLint ) : EGLContext; stdcall;
  eglDestroyContext      : function( dpy : EGLDisplay; ctx : EGLContext ) : EGLBoolean; stdcall;
  eglMakeCurrent         : function( dpy : EGLDisplay; draw : EGLSurface; read : EGLSurface; ctx : EGLContext ) : EGLBoolean; stdcall;
  eglSwapBuffers         : function( dpy : EGLDisplay; surface : EGLSurface ) : EGLBoolean; stdcall;
{$ENDIF}

var
  {$IFNDEF NO_EGL}
  eglLibrary  : {$IFDEF WINDOWS} LongWord {$ELSE} Pointer {$ENDIF};
  glesLibrary : {$IFDEF WINDOWS} LongWord {$ELSE} Pointer {$ENDIF};
  separateEGL : Boolean;
  {$ELSE}
  glesLibrary : Pointer;
  {$ENDIF}

implementation
uses
  zgl_math_2d,
  zgl_types,
  zgl_utils;

// temporary type
type
  zglTPoint3D = record
    X, Y, Z : Single;
  end;

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
    eglLibrary  := dlopen( libGLES_CM {$IFDEF UNIX}, $001 {$ENDIF} );

    if eglLibrary = LIB_ERROR Then
      eglLibrary := dlopen( libGLESv1 {$IFDEF UNIX}, $001 {$ENDIF} );
  end else
    separateEGL := TRUE;

  {$IFDEF USE_GLES_SOFTWARE}
  glesLibrary := dlopen( 'libGLES_CM_NoE.dll' );
  {$ELSE}
  if separateEGL Then
  begin
    glesLibrary := dlopen( libGLES_CM {$IFDEF UNIX}, $001 {$ENDIF} );

    if glesLibrary = LIB_ERROR Then
      glesLibrary := dlopen( libGLESv1 {$IFDEF UNIX}, $001 {$ENDIF} );
  end else
    glesLibrary := eglLibrary;
  {$ENDIF}
{$ELSE}
  glesLibrary := dlopen( libGLES_CM, $001 );
{$ENDIF}

  if {$IFNDEF NO_EGL}( eglLibrary = LIB_ERROR ) or{$ENDIF} ( glesLibrary = LIB_ERROR ) Then
  begin
    Result := FALSE;
    exit;
  end;

{$IFNDEF NO_EGL}
  eglGetProcAddress      := dlsym( eglLibrary, 'eglGetProcAddress' );
  {$IFDEF USE_AMD_DRIVERS}
  eglGetError             := eglGetProcAddress( 'eglGetError' );
  eglGetDisplay           := eglGetProcAddress( 'eglGetDisplay' );
  eglInitialize           := eglGetProcAddress( 'eglInitialize' );
  eglTerminate            := eglGetProcAddress( 'eglTerminate' );
  eglChooseConfig         := eglGetProcAddress( 'eglChooseConfig' );
  eglCreateWindowSurface  := eglGetProcAddress( 'eglCreateWindowSurface' );
  eglDestroySurface       := eglGetProcAddress( 'eglDestroySurface' );
  eglSwapInterval         := eglGetProcAddress( 'eglSwapInterval' );
  eglCreateContext        := eglGetProcAddress( 'eglCreateContext' );
  eglDestroyContext       := eglGetProcAddress( 'eglDestroyContext' );
  eglMakeCurrent          := eglGetProcAddress( 'eglMakeCurrent' );
  eglSwapBuffers          := eglGetProcAddress( 'eglSwapBuffers' );
  {$ELSE}
  eglGetError             := dlsym( eglLibrary, 'eglGetError' );
  eglGetDisplay           := dlsym( eglLibrary, 'eglGetDisplay' );
  eglInitialize           := dlsym( eglLibrary, 'eglInitialize' );
  eglTerminate            := dlsym( eglLibrary, 'eglTerminate' );
  eglChooseConfig         := dlsym( eglLibrary, 'eglChooseConfig' );
  eglCreateWindowSurface  := dlsym( eglLibrary, 'eglCreateWindowSurface' );
  eglDestroySurface       := dlsym( eglLibrary, 'eglDestroySurface' );
  eglSwapInterval         := dlsym( eglLibrary, 'eglSwapInterval' );
  eglCreateContext        := dlsym( eglLibrary, 'eglCreateContext' );
  eglDestroyContext       := dlsym( eglLibrary, 'eglDestroyContext' );
  eglMakeCurrent          := dlsym( eglLibrary, 'eglMakeCurrent' );
  eglSwapBuffers          := dlsym( eglLibrary, 'eglSwapBuffers' );
  {$ENDIF}
{$ENDIF}

  glGetString             := dlsym( glesLibrary, 'glGetString' );
  glHint                  := dlsym( glesLibrary, 'glHint' );
  glShadeModel            := dlsym( glesLibrary, 'glShadeModel' );
  glReadPixels            := dlsym( glesLibrary, 'glReadPixels' );
  glClear                 := dlsym( glesLibrary, 'glClear' );
  glClearColor            := dlsym( glesLibrary, 'glClearColor' );
//  glColor4f               := dlsym( glesLibrary, 'glColor4f' );
  {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  glClearDepthf           := dlsym( glesLibrary, 'glClearDepth' );
  {$ELSE}
  glClearDepthf           := dlsym( glesLibrary, 'glClearDepthf' );
  {$ENDIF}
  glGetFloatv             := dlsym( glesLibrary, 'glGetFloatv' );
  glGetIntegerv           := dlsym( glesLibrary, 'glGetIntegerv' );
  glEnable                := dlsym( glesLibrary, 'glEnable' );
  glEnableClientState     := dlsym( glesLibrary, 'glEnableClientState' );
  glDisable               := dlsym( glesLibrary, 'glDisable' );
  glDisableClientState    := dlsym( glesLibrary, 'glDisableClientState' );
  glViewport              := dlsym( glesLibrary, 'glViewport' );
  {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  glOrthof                 := dlsym( glesLibrary, 'glOrtho' );
  {$ELSE}
  glOrthof                 := dlsym( glesLibrary, 'glOrthof' );
  {$ENDIF}
  glScissor               := dlsym( glesLibrary, 'glScissor' );
  glDepthFunc             := dlsym( glesLibrary, 'glDepthFunc' );
  glDepthMask             := dlsym( glesLibrary, 'glDepthMask' );
  glColorMask             := dlsym( glesLibrary, 'glColorMask' );
  glColorPointer          := dlsym( glesLibrary, 'glColorPointer' );
  glAlphaFunc             := dlsym( glesLibrary, 'glAlphaFunc' );
  glBlendFunc             := dlsym( glesLibrary, 'glBlendFunc' );
  glPushMatrix            := dlsym( glesLibrary, 'glPushMatrix' );
  glPopMatrix             := dlsym( glesLibrary, 'glPopMatrix' );
  glMatrixMode            := dlsym( glesLibrary, 'glMatrixMode' );
  glLoadIdentity          := dlsym( glesLibrary, 'glLoadIdentity' );
  glLoadMatrixf           := dlsym( glesLibrary, 'glLoadMatrixf' );
  glRotatef               := dlsym( glesLibrary, 'glRotatef' );
  glScalef                := dlsym( glesLibrary, 'glScalef' );
  glTranslatef            := dlsym( glesLibrary, 'glTranslatef' );
  glVertexPointer         := dlsym( glesLibrary, 'glVertexPointer' );
  glBindTexture           := dlsym( glesLibrary, 'glBindTexture' );
  glGenTextures           := dlsym( glesLibrary, 'glGenTextures' );
  glDeleteTextures        := dlsym( glesLibrary, 'glDeleteTextures' );
  glTexParameterf         := dlsym( glesLibrary, 'glTexParameterf' );
  glTexParameteri         := dlsym( glesLibrary, 'glTexParameteri' );
  glTexParameteriv        := dlsym( glesLibrary, 'glTexParameteriv' );
  glPixelStorei           := dlsym( glesLibrary, 'glPixelStorei' );
  glTexImage2D            := dlsym( glesLibrary, 'glTexImage2D' );
  glCompressedTexImage2D  := dlsym( glesLibrary, 'glCompressedTexImage2D' );
  glCompressedTexSubImage2D := dlsym( glesLibrary, 'glCompressedTexSubImage2D' );
  glTexSubImage2D         := dlsym( glesLibrary, 'glTexSubImage2D' );
  glCopyTexImage2D        := dlsym( glesLibrary, 'glCopyTexImage2D' );
  glCopyTexSubImage2D     := dlsym( glesLibrary, 'glCopyTexSubImage2D' );
  glTexEnvi               := dlsym( glesLibrary, 'glTexEnvi' );
  glTexEnviv              := dlsym( glesLibrary, 'glTexEnviv' );
  glTexCoordPointer       := dlsym( glesLibrary, 'glTexCoordPointer' );
  glDrawArrays            := dlsym( glesLibrary, 'glDrawArrays' );
  glDrawElements          := dlsym( glesLibrary, 'glDrawElements' );
  glActiveTexture         := dlsym( glesLibrary, 'glActiveTexture' );
  glClearStencil          := dlsym( glesLibrary, 'glClearStencil' );
  glClientActiveTexture   := dlsym( glesLibrary, 'glClientActiveTexture' );
  glCullFace              := dlsym( glesLibrary, 'glCullFace' );
  glDepthRangef           := dlsym( glesLibrary, 'glDepthRangef' );
  glFinish                := dlsym( glesLibrary, 'glFinish' );
  glFlush                 := dlsym( glesLibrary, 'glFlush' );
  glFogf                  := dlsym( glesLibrary, 'glFogf' );
  glFogfv                 := dlsym( glesLibrary, 'glFogfv' );
  glFrustumf              := dlsym( glesLibrary, 'glFrustumf' );
  glFrontFace             := dlsym( glesLibrary, 'glFrontFace' );
  glGetError              := dlsym( glesLibrary, 'glGetError' );
  glLightModelf           := dlsym( glesLibrary, 'glLightModelf' );
  glLightModelfv          := dlsym( glesLibrary, 'glLightModelfv' );
  glLightf                := dlsym( glesLibrary, 'glLightf' );
  glLightfv               := dlsym( glesLibrary, 'glLightfv' );
  glLineWidth             := dlsym( glesLibrary, 'glLineWidth' );
  glLogicOp               := dlsym( glesLibrary, 'glLogicOp' );
  glMaterialf             := dlsym( glesLibrary, 'glMaterialf' );
  glMaterialfv            := dlsym( glesLibrary, 'glMaterialfv' );
  glMultMatrixf           := dlsym( glesLibrary, 'glMultMatrixf' );
  glMultiTexCoord4f       := dlsym( glesLibrary, 'glMultiTexCoord4f' );
  glNormal3f              := dlsym( glesLibrary, 'glNormal3f' );
  glNormalPointer         := dlsym( glesLibrary, 'glNormalPointer' );
  glPointSize             := dlsym( glesLibrary, 'glPointSize' );
  glPolygonOffset         := dlsym( glesLibrary, 'glPolygonOffset' );
  glSampleCoverage        := dlsym( glesLibrary, 'glSampleCoverage' );
  glStencilFunc           := dlsym( glesLibrary, 'glStencilFunc' );
  glStencilMask           := dlsym( glesLibrary, 'glStencilMask' );
  glStencilOp             := dlsym( glesLibrary, 'glStencilOp' );
  glTexEnvf               := dlsym( glesLibrary, 'glTexEnvf' );
  glTexEnvfv              := dlsym( glesLibrary, 'glTexEnvfv' );
{$IfDef USE_FULL_OPENGL}
  glColor4x               := dlsym( glesLibrary, 'glColor4x' );
  glOrthox                 := dlsym( glesLibrary, 'glOrthox' );
  glLoadMatrixx           := dlsym( glesLibrary, 'glLoadMatrixx' );
  glRotatex               := dlsym( glesLibrary, 'glRotatex' );
  glScalex                := dlsym( glesLibrary, 'glScalex' );
  glTranslatex            := dlsym( glesLibrary, 'glTranslatex' );
  glAlphaFuncx            := dlsym( glesLibrary, 'glAlphaFuncx' );
  glClearColorx           := dlsym( glesLibrary, 'glClearColorx' );
  glClearDepthx           := dlsym( glesLibrary, 'glClearDepthx' );
  glDepthRangex           := dlsym( glesLibrary, 'glDepthRangex' );
  glFogx                  := dlsym( glesLibrary, 'glFogx' );
  glFogxv                 := dlsym( glesLibrary, 'glFogxv' );
  glFrustumx              := dlsym( glesLibrary, 'glFrustumx' );
  glLightx                := dlsym( glesLibrary, 'glLightx' );
  glLightxv               := dlsym( glesLibrary, 'glLightxv' );
  glLineWidthx            := dlsym( glesLibrary, 'glLineWidthx' );
  glMaterialx             := dlsym( glesLibrary, 'glMaterialx' );
  glMaterialxv            := dlsym( glesLibrary, 'glMaterialxv' );
  glLightModelx           := dlsym( glesLibrary, 'glLightModelx' );
  glLightModelxv          := dlsym( glesLibrary, 'glLightModelxv' );
  glMultMatrixx           := dlsym( glesLibrary, 'glMultMatrixx' );
  glMultiTexCoord4x       := dlsym( glesLibrary, 'glMultiTexCoord4x' );
  glNormal3x              := dlsym( glesLibrary, 'glNormal3x' );
  glPointSizex            := dlsym( glesLibrary, 'glPointSizex' );
  glPolygonOffsetx        := dlsym( glesLibrary, 'glPolygonOffsetx' );
  glSampleCoveragex       := dlsym( glesLibrary, 'glSampleCoveragex' );
{$EndIf}

  // OpenGL ES 1.0
  if not Assigned( glTexParameteri ) Then
    glTexParameteri    := dlsym( glesLibrary, 'glTexParameterx' );
  if not Assigned( glTexParameteriv ) Then
    glTexParameteriv    := dlsym( glesLibrary, 'glTexParameterxv' );
  if not Assigned( glTexEnvi ) Then
    glTexEnvi          := dlsym( glesLibrary, 'glTexEnvx' );
  if not Assigned( glTexEnviv ) Then
    glTexEnviv         := dlsym( glesLibrary, 'glTexEnvxv' );

{$IFNDEF NO_EGL}
  Result := Assigned( eglGetDisplay ) and Assigned( eglInitialize ) and Assigned( eglTerminate ) and Assigned( eglChooseConfig ) and
            Assigned( eglCreateWindowSurface ) and Assigned( eglDestroySurface ) and Assigned( eglCreateContext ) and Assigned( eglDestroyContext ) and
            Assigned( eglMakeCurrent ) and Assigned( eglSwapBuffers );
{$ELSE}
  Result := TRUE;
{$ENDIF}
end;

procedure FreeGLES;
begin
{$IFNDEF NO_EGL}
  if separateEGL Then
    dlclose( glesLibrary );
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
{$ELSE}
  Result := nil;
{$ENDIF}

  if Result = nil Then
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
end;

procedure glColor4ub(red, green, blue, alpha: GLubyte);
begin
  PByteArray( @bColor )[ 0 ] := red;
  PByteArray( @bColor )[ 1 ] := green;
  PByteArray( @bColor )[ 2 ] := blue;
  PByteArray( @bColor )[ 3 ] := alpha;
end;

procedure glColor4ubv(v: PGLubyte);
begin
  bColor := PLongWord( v )^;
end;

procedure glColor4f(red, green, blue, alpha: GLfloat);
begin
  PByteArray( @bColor )[ 0 ] := Round( red * 255 );
  PByteArray( @bColor )[ 1 ] := Round( green * 255 );
  PByteArray( @bColor )[ 2 ] := Round( blue * 255 );
  PByteArray( @bColor )[ 3 ] := Round( alpha * 255 );
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
