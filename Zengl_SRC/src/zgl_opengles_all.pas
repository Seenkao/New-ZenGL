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

 !!! modification from Serge 24.01.2022
}
unit zgl_opengles_all;

{$I zgl_config.cfg}
{$I GLdefine.cfg}

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
  //egl, gles        mypath = /home/mirrel/fpc_3_2/lazarus/lcl/interfaces/customdrawn/android
  math;


function InitGLES : Boolean;
procedure FreeGLES;

function gl_GetProc( const Proc : UTF8String ) : Pointer;
function gl_IsSupported( const Extension, SearchIn : UTF8String ) : Boolean;

const
  {$IFNDEF USE_GLES_ON_DESKTOP}
    {$IFDEF USE_X11}
    libEGL     = 'libEGL.so';
    libGLES_CM = 'libGLESv1_CM.so'; // 'libGLES_CM.so';
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
    libGLU     = 'libGLU';
    {$ENDIF}
  {$ELSE}
    // нужен этот дальнейший код или нет? Может для 32-х битных систем?
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

const
(*  GL_VERSION_ES_CM_1_0 = 1;
  GL_VERSION_ES_CL_1_0 = 1;
  GL_VERSION_ES_CM_1_1 = 1;
  GL_VERSION_ES_CL_1_1 = 1;
  { Legacy core versions  }
  GL_OES_VERSION_1_0 = 1;
  GL_OES_VERSION_1_1 = 1;
  { Extensions  }
  GL_OES_byte_coordinates = 1;
  GL_OES_compressed_paletted_texture = 1;
  GL_OES_draw_texture = 1;
  GL_OES_fixed_point = 1;
  GL_OES_matrix_get = 1;
  GL_OES_matrix_palette = 1;
  GL_OES_point_size_array = 1;
  GL_OES_point_sprite = 1;
  GL_OES_read_format = 1;
  GL_OES_single_precision = 1;
  { ClearBufferMask  }

  GL_FALSE                                      = 0;
  GL_TRUE                                       = 1;
  GL_ZERO                                       = 0;
  GL_ONE                                        = 1;

  // String Name
  GL_VENDOR                                     = $1F00;
  GL_RENDERER                                   = $1F01;
  GL_VERSION                                    = $1F02;
  GL_EXTENSIONS                                 = $1F03;

  // DataType
  GL_UNSIGNED_BYTE                              = $1401;
  GL_UNSIGNED_SHORT                             = $1403;
  GL_FLOAT                                      = $1406;
  GL_UNSIGNED_SHORT_4_4_4_4                     = $8033;

  // PixelFormat
  GL_RGBA                                       = $1908;

  // Alpha Function
  GL_NEVER                                      = $0200;
  GL_LESS                                       = $0201;
  GL_EQUAL                                      = $0202;
  GL_LEQUAL                                     = $0203;
  GL_GREATER                                    = $0204;
  GL_NOTEQUAL                                   = $0205;
  GL_GEQUAL                                     = $0206;
  GL_ALWAYS                                     = $0207;

  // Blend
  GL_BLEND                                      = $0BE2;
  // Blending Factor Dest
  GL_SRC_COLOR                                  = $0300;
  GL_ONE_MINUS_SRC_COLOR                        = $0301;
  GL_SRC_ALPHA                                  = $0302;
  GL_ONE_MINUS_SRC_ALPHA                        = $0303;
  GL_DST_ALPHA                                  = $0304;
  GL_ONE_MINUS_DST_ALPHA                        = $0305;
  // Blending Factor Src
  GL_DST_COLOR                                  = $0306;
  GL_ONE_MINUS_DST_COLOR                        = $0307;
  GL_SRC_ALPHA_SATURATE                         = $0308;

  // -------------------------------------------------------------
  GL_FRONT                                      = $0404;
  GL_BACK                                       = $0405;
  GL_FRONT_AND_BACK                             = $0408;
  GL_FOG                                        = $0B60;
  GL_LIGHTING                                   = $0B50;
  GL_CULL_FACE                                  = $0B44;
  GL_COLOR_LOGIC_OP                             = $0BF2;
  GL_DITHER                                     = $0BD0;
  GL_POINT_SMOOTH                               = $0B10;
  GL_COLOR_MATERIAL                             = $0B57;
  GL_RESCALE_NORMAL                             = $803A;
  GL_POLYGON_OFFSET_FILL                        = $8037;
  GL_MULTISAMPLE                                = $809D;
  GL_SAMPLE_ALPHA_TO_COVERAGE                   = $809E;
  GL_SAMPLE_ALPHA_TO_ONE                        = $809F;
  GL_SAMPLE_COVERAGE                            = $80A0;
  GL_NO_ERROR                                   = 0;
  GL_INVALID_ENUM                               = $0500;
  GL_INVALID_VALUE                              = $0501;
  GL_INVALID_OPERATION                          = $0502;
  GL_STACK_OVERFLOW                             = $0503;
  GL_STACK_UNDERFLOW                            = $0504;
  GL_OUT_OF_MEMORY                              = $0505;
  GL_EXP                                        = $0800;
  GL_EXP2                                       = $0801;
  GL_FOG_DENSITY                                = $0B62;
  GL_FOG_START                                  = $0B63;
  GL_FOG_END                                    = $0B64;
  GL_FOG_MODE                                   = $0B65;
  GL_FOG_COLOR                                  = $0B66;
  GL_CW                                         = $0900;
  GL_CCW                                        = $0901;
  GL_SMOOTH_POINT_SIZE_RANGE                    = $0B12;
  GL_SMOOTH_LINE_WIDTH_RANGE                    = $0B22;
  GL_ALIASED_POINT_SIZE_RANGE                   = $846D;
  GL_ALIASED_LINE_WIDTH_RANGE                   = $846E;
  GL_IMPLEMENTATION_COLOR_READ_TYPE_OES         = $8B9A;
  GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES       = $8B9B;

  GL_CURRENT_COLOR                              = $0B00;
  GL_CURRENT_NORMAL                             = $0B02;
  GL_CURRENT_TEXTURE_COORDS                     = $0B03;
  GL_POINT_SIZE                                 = $0B11;
  GL_POINT_SIZE_MIN                             = $8126;
  GL_POINT_SIZE_MAX                             = $8127;
  GL_POINT_FADE_THRESHOLD_SIZE                  = $8128;
  GL_POINT_DISTANCE_ATTENUATION                 = $8129;
  GL_LINE_WIDTH                                 = $0B21;
  GL_CULL_FACE_MODE                             = $0B45;
  GL_FRONT_FACE                                 = $0B46;
  GL_DEPTH_RANGE                                = $0B70;
  GL_DEPTH_WRITEMASK                            = $0B72;
  GL_DEPTH_CLEAR_VALUE                          = $0B73;
  GL_DEPTH_FUNC                                 = $0B74;
  GL_STENCIL_CLEAR_VALUE                        = $0B91;
  GL_STENCIL_FUNC                               = $0B92;
  GL_STENCIL_VALUE_MASK                         = $0B93;
  GL_STENCIL_FAIL                               = $0B94;
  GL_STENCIL_PASS_DEPTH_FAIL                    = $0B95;
  GL_STENCIL_PASS_DEPTH_PASS                    = $0B96;
  GL_STENCIL_REF                                = $0B97;
  GL_STENCIL_WRITEMASK                          = $0B98;

  GL_MATRIX_MODE                                = $0BA0;
  GL_VIEWPORT                                   = $0BA2;
  GL_MODELVIEW_STACK_DEPTH                      = $0BA3;
  GL_PROJECTION_STACK_DEPTH                     = $0BA4;
  GL_TEXTURE_STACK_DEPTH                        = $0BA5;
  GL_TEXTURE_MATRIX                             = $0BA8;
  GL_ALPHA_TEST_FUNC                            = $0BC1;
  GL_ALPHA_TEST_REF                             = $0BC2;
  GL_LOGIC_OP_MODE                              = $0BF0;
  GL_SCISSOR_BOX                                = $0C10;
  GL_COLOR_CLEAR_VALUE                          = $0C22;
  GL_COLOR_WRITEMASK                            = $0C23;
  GL_MAX_LIGHTS                                 = $0D31;
  GL_MAX_CLIP_PLANES                            = $0D32;
  GL_MAX_MODELVIEW_STACK_DEPTH                  = $0D36;
  GL_MAX_PROJECTION_STACK_DEPTH                 = $0D38;
  GL_MAX_TEXTURE_STACK_DEPTH                    = $0D39;
  GL_MAX_VIEWPORT_DIMS                          = $0D3A;
  GL_MAX_ELEMENTS_VERTICES                      = $80E8;
  GL_MAX_ELEMENTS_INDICES                       = $80E9;

  GL_POLYGON_OFFSET_UNITS                       = $2A00;
  GL_POLYGON_OFFSET_FACTOR                      = $8038;
  GL_TEXTURE_BINDING_2D                         = $8069;
  GL_VERTEX_ARRAY_SIZE                          = $807A;
  GL_VERTEX_ARRAY_TYPE                          = $807B;
  GL_VERTEX_ARRAY_STRIDE                        = $807C;
  GL_NORMAL_ARRAY_TYPE                          = $807E;
  GL_NORMAL_ARRAY_STRIDE                        = $807F;
  GL_COLOR_ARRAY_SIZE                           = $8081;
  GL_COLOR_ARRAY_TYPE                           = $8082;
  GL_COLOR_ARRAY_STRIDE                         = $8083;
  GL_TEXTURE_COORD_ARRAY_SIZE                   = $8088;
  GL_TEXTURE_COORD_ARRAY_TYPE                   = $8089;
  GL_TEXTURE_COORD_ARRAY_STRIDE                 = $808A;
  GL_VERTEX_ARRAY_POINTER                       = $808E;
  GL_NORMAL_ARRAY_POINTER                       = $808F;
  GL_COLOR_ARRAY_POINTER                        = $8090;
  GL_TEXTURE_COORD_ARRAY_POINTER                = $8092;
  GL_SAMPLE_BUFFERS                             = $80A8;
  GL_SAMPLES                                    = $80A9;
  GL_SAMPLE_COVERAGE_VALUE                      = $80AA;
  GL_SAMPLE_COVERAGE_INVERT                     = $80AB;

  GL_NUM_COMPRESSED_TEXTURE_FORMATS             = $86A2;
  GL_COMPRESSED_TEXTURE_FORMATS                 = $86A3;
  GL_SUBPIXEL_BITS                              = $0D50;
  GL_RED_BITS                                   = $0D52;
  GL_GREEN_BITS                                 = $0D53;
  GL_BLUE_BITS                                  = $0D54;
  GL_ALPHA_BITS                                 = $0D55;
  GL_DEPTH_BITS                                 = $0D56;
  GL_STENCIL_BITS                               = $0D57;

  GL_LIGHT_MODEL_AMBIENT                        = $0B53;
  GL_LIGHT_MODEL_TWO_SIDE                       = $0B52;
  GL_AMBIENT                                    = $1200;
  GL_DIFFUSE                                    = $1201;
  GL_SPECULAR                                   = $1202;
  GL_POSITION                                   = $1203;
  GL_SPOT_DIRECTION                             = $1204;
  GL_SPOT_EXPONENT                              = $1205;
  GL_SPOT_CUTOFF                                = $1206;
  GL_CONSTANT_ATTENUATION                       = $1207;
  GL_LINEAR_ATTENUATION                         = $1208;
  GL_QUADRATIC_ATTENUATION                      = $1209;
  GL_BYTE                                       = $1400;
  GL_SHORT                                      = $1402;
  GL_FIXED                                      = $140C;
  GL_CLEAR                                      = $1500;
  GL_AND                                        = $1501;
  GL_AND_REVERSE                                = $1502;
  GL_COPY                                       = $1503;
  GL_AND_INVERTED                               = $1504;
  GL_NOOP                                       = $1505;
  GL_XOR                                        = $1506;
  GL_OR                                         = $1507;
  GL_NOR                                        = $1508;
  GL_EQUIV                                      = $1509;
  GL_INVERT                                     = $150A;
  GL_OR_REVERSE                                 = $150B;
  GL_COPY_INVERTED                              = $150C;
  GL_OR_INVERTED                                = $150D;
  GL_NAND                                       = $150E;
  GL_SET                                        = $150F;
  GL_EMISSION                                   = $1600;
  GL_SHININESS                                  = $1601;
  GL_AMBIENT_AND_DIFFUSE                        = $1602;
  GL_ALPHA                                      = $1906;
  GL_RGB                                        = $1907;
  GL_LUMINANCE                                  = $1909;
  GL_LUMINANCE_ALPHA                            = $190A;
  GL_UNPACK_ALIGNMENT                           = $0CF5;
  GL_PACK_ALIGNMENT                             = $0D05;
  GL_UNSIGNED_SHORT_5_5_5_1                     = $8034;
  GL_UNSIGNED_SHORT_5_6_5                       = $8363;
  GL_ADD                                        = $0104;
  GL_TEXTURE0                                   = $84C0;
  GL_TEXTURE1                                   = $84C1;
  GL_TEXTURE2                                   = $84C2;
  GL_TEXTURE3                                   = $84C3;
  GL_TEXTURE4                                   = $84C4;
  GL_TEXTURE5                                   = $84C5;
  GL_TEXTURE6                                   = $84C6;
  GL_TEXTURE7                                   = $84C7;
  GL_TEXTURE8                                   = $84C8;
  GL_TEXTURE9                                   = $84C9;
  GL_TEXTURE10                                  = $84CA;
  GL_TEXTURE11                                  = $84CB;
  GL_TEXTURE12                                  = $84CC;
  GL_TEXTURE13                                  = $84CD;
  GL_TEXTURE14                                  = $84CE;
  GL_TEXTURE15                                  = $84CF;
  GL_TEXTURE16                                  = $84D0;
  GL_TEXTURE17                                  = $84D1;
  GL_TEXTURE18                                  = $84D2;
  GL_TEXTURE19                                  = $84D3;
  GL_TEXTURE20                                  = $84D4;
  GL_TEXTURE21                                  = $84D5;
  GL_TEXTURE22                                  = $84D6;
  GL_TEXTURE23                                  = $84D7;
  GL_TEXTURE24                                  = $84D8;
  GL_TEXTURE25                                  = $84D9;
  GL_TEXTURE26                                  = $84DA;
  GL_TEXTURE27                                  = $84DB;
  GL_TEXTURE28                                  = $84DC;
  GL_TEXTURE29                                  = $84DD;
  GL_TEXTURE30                                  = $84DE;
  GL_TEXTURE31                                  = $84DF;
  GL_ACTIVE_TEXTURE                             = $84E0;
  GL_CLIENT_ACTIVE_TEXTURE                      = $84E1;

  GL_LIGHT0                                     = $4000;
  GL_LIGHT1                                     = $4001;
  GL_LIGHT2                                     = $4002;
  GL_LIGHT3                                     = $4003;
  GL_LIGHT4                                     = $4004;
  GL_LIGHT5                                     = $4005;
  GL_LIGHT6                                     = $4006;
  GL_LIGHT7                                     = $4007;

  // blendOP
  GL_FUNC_ADD_EXT                     = $8006; // GL_FUNC_ADD_OES
  GL_MIN_EXT                          = $8007;
  GL_MAX_EXT                          = $8008;
  GL_FUNC_SUBTRACT_EXT                = $800A; // GL_FUNC_SUBTRACT_OES
  GL_FUNC_REVERSE_SUBTRACT_EXT        = $800B; // GL_FUNC_REVERSE_SUBTRACT_OES

{  GL_BLEND_DST_RGB_EXT                = $80C8; // GL_BLEND_DST_RGB_OES
  GL_BLEND_SRC_RGB_EXT                = $80C9; // GL_BLEND_SRC_RGB_OES
  GL_BLEND_DST_ALPHA_EXT              = $80CA; // GL_BLEND_DST_ALPHA_OES
  GL_BLEND_SRC_ALPHA_EXT              = $80CB; // GL_BLEND_SRC_ALPHA_OES
  GL_BLEND_EQUATION_RGB_EXT           = $8009; // GL_BLEND_EQUATION_RGB_OES
  GL_BLEND_EQUATION_ALPHA_EXT         = $883D; // GL_BLEND_EQUATION_ALPHA_OES }
  GL_BLEND_DST                        = $0BE0;    // new, use?
  GL_BLEND_SRC                        = $0BE1;    // new, use?

  // Hint Mode
  GL_DONT_CARE                        = $1100;
  GL_FASTEST                          = $1101;
  GL_NICEST                           = $1102;

  // Hints
  GL_PERSPECTIVE_CORRECTION_HINT      = $0C50;
  GL_POINT_SMOOTH_HINT                = $0C51;
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
  GL_QUADS                            = $0007; // Doesn't exists

  // Texture
  GL_TEXTURE_2D                       = $0DE1;
//  GL_TEXTURE0_ARB                     = $84C0; // GL_TEXTURE0
  GL_MAX_TEXTURE_SIZE                 = $0D33;
  GL_MAX_TEXTURE_UNITS                = $84E2; // GL_MAX_TEXTURE_UNITS_ARB
  GL_TEXTURE_MAX_ANISOTROPY_EXT       = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT   = $84FF;
  // Texture Wrap Mode
  GL_CLAMP_TO_EDGE                    = $812F;
  GL_REPEAT                           = $2901;  *)
  // Texture Format
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG  = $8C00;
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG  = $8C01;
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG = $8C02;
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG = $8C03;    (*
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

  GL_COMBINE                          = $8570; // GL_COMBINE_ARB
  GL_COMBINE_RGB                      = $8571; // GL_COMBINE_RGB_ARB
  GL_COMBINE_ALPHA                    = $8572; // GL_COMBINE_ALPHA_ARB
  GL_SOURCE0_RGB                      = $8580; // GL_SRC0_RGB_ARB
  GL_SOURCE1_RGB                      = $8581; // GL_SRC1_RGB_ARB
  GL_SOURCE2_RGB                      = $8582; // GL_SRC2_RGB_ARB
  GL_SOURCE0_ALPHA                    = $8588; // GL_SRC0_ALPHA_ARB
  GL_SOURCE1_ALPHA                    = $8589; // GL_SRC1_ALPHA_ARB
  GL_SOURCE2_ALPHA                    = $858A; // GL_SRC2_ALPHA_ARB
  GL_OPERAND0_RGB                     = $8590; // GL_OPERAND0_RGB_ARB
  GL_OPERAND1_RGB                     = $8591; // GL_OPERAND1_RGB_ARB
  GL_OPERAND2_RGB                     = $8592; // GL_OPERAND2_RGB_ARB
  GL_OPERAND0_ALPHA                   = $8598; // GL_OPERAND0_ALPHA_ARB
  GL_OPERAND1_ALPHA                   = $8599; // GL_OPERAND1_ALPHA_ARB
  GL_OPERAND2_ALPHA                   = $859A; // GL_OPERAND2_ALPHA_ARB
  GL_RGB_SCALE                        = $8573; // GL_RGB_SCALE_ARB
  GL_ADD_SIGNED                       = $8574; // GL_ADD_SIGNED_ARB
  GL_INTERPOLATE                      = $8575; // GL_INTERPOLATE_ARB
  GL_SUBTRACT                         = $84E7; // GL_SUBTRACT_ARB
  GL_CONSTANT                         = $8576; // GL_CONSTANT_ARB
  GL_PRIMARY_COLOR                    = $8577; // GL_PRIMARY_COLOR_ARB
  GL_PREVIOUS                         = $8578; // GL_PREVIOUS_ARB
  GL_DOT3_RGB                         = $86AE; // GL_DOT3_RGB
  GL_DOT3_RGBA                        = $86AF; // GL_DOT3_RGBA

  GL_ALPHA_SCALE                      = $0D1C;

  GL_SRC0_RGB                         = $8580;
  GL_SRC1_RGB                         = $8581;
  GL_SRC2_RGB                         = $8582;
  GL_SRC0_ALPHA                       = $8588;
  GL_SRC1_ALPHA                       = $8589;
  GL_SRC2_ALPHA                       = $858A;

  // Vertex Array
  GL_VERTEX_ARRAY                     = $8074;
  GL_NORMAL_ARRAY                     = $8075;
  GL_COLOR_ARRAY                      = $8076;
  GL_TEXTURE_COORD_ARRAY              = $8078;

  // FBO
  GL_FRAMEBUFFER                      = $8D40; // GL_FRAMEBUFFER_OES
  GL_RENDERBUFFER                     = $8D41; // GL_RENDERBUFFER_OES
  GL_DEPTH_COMPONENT16                = $81A5; // GL_DEPTH_COMPONENT16_OES
  GL_DEPTH_COMPONENT24                = $81A6; // GL_DEPTH_COMPONENT24_OES
  GL_DEPTH_COMPONENT32                = $81A7; // GL_DEPTH_COMPONENT32_OES
  GL_COLOR_ATTACHMENT0                = $8CE0; // GL_COLOR_ATTACHMENT0_OES
  GL_DEPTH_ATTACHMENT                 = $8D00; // GL_DEPTH_ATTACHMENT_OES
  GL_MAX_RENDERBUFFER_SIZE            = $84E8; // GL_MAX_RENDERBUFFER_SIZE_OES

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
  GL_BUFFER_SIZE                      = $8764; // GL_BUFFER_SIZE_ARB
  GL_ARRAY_BUFFER                     = $8892; // GL_ARRAY_BUFFER_ARB
  GL_ELEMENT_ARRAY_BUFFER             = $8893; // GL_ELEMENT_ARRAY_BUFFER_ARB
  GL_WRITE_ONLY                       = $88B9; // GL_WRITE_ONLY_ARB, GL_WRITE_ONLY_OES, GL_OES_mapbuffer
  GL_STATIC_DRAW                      = $88E4; // GL_STATIC_DRAW_ARB
  GL_DYNAMIC_DRAW                     = $88E8; // GL_DYNAMIC_DRAW_ARB

  { ClipPlaneName  }
  GL_CLIP_PLANE0                      = $3000;
  GL_CLIP_PLANE1                      = $3001;
  GL_CLIP_PLANE2                      = $3002;
  GL_CLIP_PLANE3                      = $3003;
  GL_CLIP_PLANE4                      = $3004;
  GL_CLIP_PLANE5                      = $3005;

  GL_ARRAY_BUFFER_BINDING             = $8894;
  GL_ELEMENT_ARRAY_BUFFER_BINDING     = $8895;
  GL_VERTEX_ARRAY_BUFFER_BINDING      = $8896;
  GL_NORMAL_ARRAY_BUFFER_BINDING      = $8897;
  GL_COLOR_ARRAY_BUFFER_BINDING       = $8898;
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;
  GL_BUFFER_USAGE                     = $8765;

  // OES ...
  GL_BUFFER_ACCESS_OES                = $88BB;
  GL_BUFFER_MAPPED_OES                = $88BC;
  GL_BUFFER_MAP_POINTER_OES           = $88BD;
  { OES_point_sprite  }
  GL_POINT_SPRITE_OES                 = $8861;
  GL_COORD_REPLACE_OES                = $8862;
  { OES_point_size_array  }
  GL_POINT_SIZE_ARRAY_OES             = $8B9C;
  GL_POINT_SIZE_ARRAY_TYPE_OES        = $898A;
  GL_POINT_SIZE_ARRAY_STRIDE_OES      = $898B;
  GL_POINT_SIZE_ARRAY_POINTER_OES     = $898C;
  GL_POINT_SIZE_ARRAY_BUFFER_BINDING_OES = $8B9F;

  GL_PALETTE4_RGB8_OES                = $8B90;
  GL_PALETTE4_RGBA8_OES               = $8B91;
  GL_PALETTE4_R5_G6_B5_OES            = $8B92;
  GL_PALETTE4_RGBA4_OES               = $8B93;
  GL_PALETTE4_RGB5_A1_OES             = $8B94;
  GL_PALETTE8_RGB8_OES                = $8B95;
  GL_PALETTE8_RGBA8_OES               = $8B96;
  GL_PALETTE8_R5_G6_B5_OES            = $8B97;
  GL_PALETTE8_RGBA4_OES               = $8B98;
  GL_PALETTE8_RGB5_A1_OES             = $8B99;

  { OES_draw_texture  }
  GL_TEXTURE_CROP_RECT_OES            = $8B9D;
  { OES_matrix_get  }
  GL_MODELVIEW_MATRIX_FLOAT_AS_INT_BITS_OES  = $898D;
  GL_PROJECTION_MATRIX_FLOAT_AS_INT_BITS_OES = $898E;
  GL_TEXTURE_MATRIX_FLOAT_AS_INT_BITS_OES    = $898F;
  { OES_matrix_palette  }
  GL_MAX_VERTEX_UNITS_OES                    = $86A4;
  GL_MAX_PALETTE_MATRICES_OES                = $8842;
  GL_MATRIX_PALETTE_OES                      = $8840;
  GL_MATRIX_INDEX_ARRAY_OES                  = $8844;
  GL_WEIGHT_ARRAY_OES                        = $86AD;
  GL_CURRENT_PALETTE_MATRIX_OES              = $8843;
  GL_MATRIX_INDEX_ARRAY_SIZE_OES             = $8846;
  GL_MATRIX_INDEX_ARRAY_TYPE_OES             = $8847;
  GL_MATRIX_INDEX_ARRAY_STRIDE_OES           = $8848;
  GL_MATRIX_INDEX_ARRAY_POINTER_OES          = $8849;
  GL_MATRIX_INDEX_ARRAY_BUFFER_BINDING_OES   = $8B9E;
  GL_WEIGHT_ARRAY_SIZE_OES                   = $86AB;
  GL_WEIGHT_ARRAY_TYPE_OES                   = $86A9;
  GL_WEIGHT_ARRAY_STRIDE_OES                 = $86AA;
  GL_WEIGHT_ARRAY_POINTER_OES                = $86AC;
  GL_WEIGHT_ARRAY_BUFFER_BINDING_OES         = $889E;      *)
(*  GL_DEPTH_STENCIL_OES                       = $84F9;
  GL_UNSIGNED_INT_24_8_OES                   = $84FA;
  GL_DEPTH24_STENCIL8_OES                    = $88F0;
  GL_ALPHA8_OES                              = $803C;
  GL_LUMINANCE4_ALPHA4_OES                   = $8043;
  GL_LUMINANCE8_ALPHA8_OES                   = $8045;
  GL_LUMINANCE8_OES                          = $8040;
  GL_RGB8_OES                                = $8051;
  GL_RGBA8_OES                               = $8058;
  GL_RGB10_EXT                               = $8052;
  GL_RGB10_A2_EXT                            = $8059;

  GL_NONE_OES                                = 0;
  GL_FRAMEBUFFER_OES                         = $8D40;
  GL_RENDERBUFFER_OES                        = $8D41;
  GL_RGBA4_OES                               = $8056;
  GL_RGB5_A1_OES                             = $8057;
  GL_RGB565_OES                              = $8D62;
  GL_DEPTH_COMPONENT16_OES                   = $81A5;
  GL_RENDERBUFFER_WIDTH_OES                  = $8D42;
  GL_RENDERBUFFER_HEIGHT_OES                 = $8D43;
  GL_RENDERBUFFER_INTERNAL_FORMAT_OES        = $8D44;
  GL_RENDERBUFFER_RED_SIZE_OES               = $8D50;
  GL_RENDERBUFFER_GREEN_SIZE_OES             = $8D51;
  GL_RENDERBUFFER_BLUE_SIZE_OES              = $8D52;
  GL_RENDERBUFFER_ALPHA_SIZE_OES             = $8D53;
  GL_RENDERBUFFER_DEPTH_SIZE_OES             = $8D54;
  GL_RENDERBUFFER_STENCIL_SIZE_OES           = $8D55;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_OES  = $8CD0;
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_OES  = $8CD1;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_OES = $8CD2;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_OES = $8CD3;
  GL_COLOR_ATTACHMENT0_OES                   = $8CE0;
  GL_DEPTH_ATTACHMENT_OES                    = $8D00;
  GL_STENCIL_ATTACHMENT_OES                  = $8D20;
  GL_FRAMEBUFFER_COMPLETE_OES                = $8CD5;
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_OES   = $8CD6;
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_OES = $8CD7;
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_OES   = $8CD9;
  GL_FRAMEBUFFER_INCOMPLETE_FORMATS_OES      = $8CDA;
  GL_FRAMEBUFFER_UNSUPPORTED_OES             = $8CDD;
  GL_FRAMEBUFFER_BINDING_OES                 = $8CA6;
  GL_RENDERBUFFER_BINDING_OES                = $8CA7;
  GL_MAX_RENDERBUFFER_SIZE_OES               = $84E8;
  GL_INVALID_FRAMEBUFFER_OPERATION_OES       = $0506;
  GL_STENCIL_INDEX1_OES                      = $8D46;
  GL_STENCIL_INDEX4_OES                      = $8D47;
  GL_STENCIL_INDEX8_OES                      = $8D48;
  GL_INCR_WRAP_OES                           = $8507;
  GL_DECR_WRAP_OES                           = $8508;
  GL_FRAMEBUFFER_UNDEFINED_OES               = $8219;
  GL_NORMAL_MAP_OES                          = $8511;
  GL_REFLECTION_MAP_OES                      = $8512;
  GL_TEXTURE_CUBE_MAP_OES                    = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP_OES            = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_OES         = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_OES         = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_OES         = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_OES         = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_OES         = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_OES         = $851A;
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_OES           = $851C;
  GL_TEXTURE_GEN_MODE_OES                    = $2500;
  GL_TEXTURE_GEN_STR_OES                     = $8D60;
  GL_MIRRORED_REPEAT_OES                     = $8370;
  GL_VERTEX_ARRAY_BINDING_OES                = $85B5;
  // AMD
  GL_3DC_X_AMD                               = $87F9;
  GL_3DC_XY_AMD                              = $87FA;
  GL_ATC_RGB_AMD                             = $8C92;
  GL_ATC_RGBA_EXPLICIT_ALPHA_AMD             = $8C93;
  GL_ATC_RGBA_INTERPOLATED_ALPHA_AMD         = $87EE;
  //APPLE
  GL_RENDERBUFFER_SAMPLES_APPLE              = $8CAB;
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_APPLE = $8D56;
  GL_MAX_SAMPLES_APPLE                       = $8D57;
  GL_READ_FRAMEBUFFER_APPLE                  = $8CA8;
  GL_DRAW_FRAMEBUFFER_APPLE                  = $8CA9;
  GL_DRAW_FRAMEBUFFER_BINDING_APPLE          = $8CA6;
  GL_READ_FRAMEBUFFER_BINDING_APPLE          = $8CAA;
  GL_SYNC_OBJECT_APPLE                       = $8A53
  GL_MAX_SERVER_WAIT_TIMEOUT_APPLE           = $9111;
  GL_OBJECT_TYPE_APPLE                       = $9112;
  GL_SYNC_CONDITION_APPLE                    = $9113;
  GL_SYNC_STATUS_APPLE                       = $9114;
  GL_SYNC_FLAGS_APPLE                        = $9115;
  GL_SYNC_FENCE_APPLE                        = $9116;
  GL_SYNC_GPU_COMMANDS_COMPLETE_APPLE        = $9117;
  GL_UNSIGNALED_APPLE                        = $9118;
  GL_SIGNALED_APPLE                          = $9119;
  GL_ALREADY_SIGNALED_APPLE                  = $911A;
  GL_TIMEOUT_EXPIRED_APPLE                   = $911B;
  GL_CONDITION_SATISFIED_APPLE               = $911C;
  GL_WAIT_FAILED_APPLE                       = $911D;
  GL_SYNC_FLUSH_COMMANDS_BIT_APPLE           = $00000001;
  GL_TIMEOUT_IGNORED_APPLE                   = $FFFFFFFFFFFFFFFF; //Full
  GL_BGRA_EXT                                = $80E1;
  GL_BGRA8_EXT                               = $93A1;
  GL_TEXTURE_MAX_LEVEL_APPLE                 = $813D;
  // EXT
  GL_MIN_EXT                                 = $8007;
  GL_MAX_EXT                                 = $8008;
  GL_COLOR_EXT                               = $1800;
  GL_DEPTH_EXT                               = $1801;
  GL_STENCIL_EXT                             = $1802;
  GL_MAP_READ_BIT_EXT                        = $0001
  GL_MAP_WRITE_BIT_EXT                       = $0002;
  GL_MAP_INVALIDATE_RANGE_BIT_EXT            = $0004;
  GL_MAP_INVALIDATE_BUFFER_BIT_EXT           = $0008;
  GL_MAP_FLUSH_EXPLICIT_BIT_EXT              = $0010;
  GL_MAP_UNSYNCHRONIZED_BIT_EXT              = $0020;
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_SAMPLES_EXT = $8D6C;
  GL_RENDERBUFFER_SAMPLES_EXT                = $8CAB;
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT  = $8D56;
  GL_MAX_SAMPLES_EXT                         = $8D57;
  GL_UNSIGNED_SHORT_4_4_4_4_REV_EXT          = $8365;
  GL_UNSIGNED_SHORT_1_5_5_5_REV_EXT          = $8366;
  GL_GUILTY_CONTEXT_RESET_EXT                = $8253;
  GL_INNOCENT_CONTEXT_RESET_EXT              = $8254;
  GL_UNKNOWN_CONTEXT_RESET_EXT               = $8255;
  GL_CONTEXT_ROBUST_ACCESS_EXT               = $90F3;
  GL_RESET_NOTIFICATION_STRATEGY_EXT         = $8256;
  GL_LOSE_CONTEXT_ON_RESET_EXT               = $8252;
  GL_NO_RESET_NOTIFICATION_EXT               = $8261;
  GL_SRGB_EXT                                = $8C40
  GL_SRGB_ALPHA_EXT                          = $8C42;
  GL_SRGB8_ALPHA8_EXT                        = $8C43;
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING_EXT = $8210;
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT            = $83F0;
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT           = $83F1;
  GL_TEXTURE_MAX_ANISOTROPY_EXT              = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT          = $84FF;
  GL_MAX_TEXTURE_LOD_BIAS_EXT                = $84FD;
  GL_TEXTURE_FILTER_CONTROL_EXT              = $8500;
  GL_TEXTURE_LOD_BIAS_EXT                    = $8501;
  GL_TEXTURE_IMMUTABLE_FORMAT_EXT            = $912F;
  GL_ALPHA8_EXT                              = $803C;
  GL_LUMINANCE8_EXT                          = $8040;
  GL_LUMINANCE8_ALPHA8_EXT                   = $8045;
  GL_RGBA32F_EXT                             = $8814;
  GL_RGB32F_EXT                              = $8815;
  GL_ALPHA32F_EXT                            = $8816;
  GL_LUMINANCE32F_EXT                        = $8818;
  GL_LUMINANCE_ALPHA32F_EXT                  = $8819;
  GL_RGBA16F_EXT                             = $881A;
  GL_RGB16F_EXT                              = $881B;
  GL_ALPHA16F_EXT                            = $881C;
  GL_LUMINANCE16F_EXT                        = $881E;
  GL_LUMINANCE_ALPHA16F_EXT                  = $881F;
  GL_R8_EXT                                  = $8229;
  GL_RG8_EXT                                 = $822B;
  GL_R32F_EXT                                = $822E;
  GL_RG32F_EXT                               = $8230;
  GL_R16F_EXT                                = $822D;
  GL_RG16F_EXT                               = $822F;
  // IMG
  GL_RENDERBUFFER_SAMPLES_IMG                = $9133;
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_IMG  = $9134;
  GL_MAX_SAMPLES_IMG                         = $9135;
  GL_TEXTURE_SAMPLES_IMG                     = $9136;
  GL_BGRA_IMG                                = $80E1;
  GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG          = $8365;
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG         = $8C00;
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG         = $8C01;
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG        = $8C02;
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG        = $8C03;
  GL_MODULATE_COLOR_IMG                      = $8C04;
  GL_RECIP_ADD_SIGNED_ALPHA_IMG              = $8C05;
  GL_TEXTURE_ALPHA_MODULATE_IMG              = $8C06;
  GL_FACTOR_ALPHA_MODULATE_IMG               = $8C07;
  GL_FRAGMENT_ALPHA_MODULATE_IMG             = $8C08;
  GL_ADD_BLEND_IMG                           = $8C09;
  GL_DOT3_RGBA_IMG                           = $86AF;
  GL_CLIP_PLANE0_IMG                         = $3000;
  GL_CLIP_PLANE1_IMG                         = $3001;
  GL_CLIP_PLANE2_IMG                         = $3002;
  GL_CLIP_PLANE3_IMG                         = $3003;
  GL_CLIP_PLANE4_IMG                         = $3004;
  GL_CLIP_PLANE5_IMG                         = $3005;
  GL_MAX_CLIP_PLANES_IMG                     = $0D32;
  // NV
  GL_ALL_COMPLETED_NV                        = $84F2;
  GL_FENCE_STATUS_NV                         = $84F3;
  GL_FENCE_CONDITION_NV                      = $84F4;
  // QCOM
  GL_TEXTURE_WIDTH_QCOM                      = $8BD2;
  GL_TEXTURE_HEIGHT_QCOM                     = $8BD3;
  GL_TEXTURE_DEPTH_QCOM                      = $8BD4;
  GL_TEXTURE_INTERNAL_FORMAT_QCOM            = $8BD5;
  GL_TEXTURE_FORMAT_QCOM                     = $8BD6;
  GL_TEXTURE_TYPE_QCOM                       = $8BD7;
  GL_TEXTURE_IMAGE_VALID_QCOM                = $8BD8;
  GL_TEXTURE_NUM_LEVELS_QCOM                 = $8BD9;
  GL_TEXTURE_TARGET_QCOM                     = $8BDA;
  GL_TEXTURE_OBJECT_VALID_QCOM               = $8BDB;
  GL_STATE_RESTORE                           = $8BDC;
  GL_PERFMON_GLOBAL_MODE_QCOM                = $8FA0;
  GL_COLOR_BUFFER_BIT0_QCOM                  = $00000001;
  GL_COLOR_BUFFER_BIT1_QCOM                  = $00000002;
  GL_COLOR_BUFFER_BIT2_QCOM                  = $00000004;
  GL_COLOR_BUFFER_BIT3_QCOM                  = $00000008;
  GL_COLOR_BUFFER_BIT4_QCOM                  = $00000010;
  GL_COLOR_BUFFER_BIT5_QCOM                  = $00000020;
  GL_COLOR_BUFFER_BIT6_QCOM                  = $00000040;
  GL_COLOR_BUFFER_BIT7_QCOM                  = $00000080;
  GL_DEPTH_BUFFER_BIT0_QCOM                  = $00000100;
  GL_DEPTH_BUFFER_BIT1_QCOM                  = $00000200;
  GL_DEPTH_BUFFER_BIT2_QCOM                  = $00000400;
  GL_DEPTH_BUFFER_BIT3_QCOM                  = $00000800;
  GL_DEPTH_BUFFER_BIT4_QCOM                  = $00001000;
  GL_DEPTH_BUFFER_BIT5_QCOM                  = $00002000;
  GL_DEPTH_BUFFER_BIT6_QCOM                  = $00004000;
  GL_DEPTH_BUFFER_BIT7_QCOM                  = $00008000;
  GL_STENCIL_BUFFER_BIT0_QCOM                = $00010000;
  GL_STENCIL_BUFFER_BIT1_QCOM                = $00020000;
  GL_STENCIL_BUFFER_BIT2_QCOM                = $00040000;
  GL_STENCIL_BUFFER_BIT3_QCOM                = $00080000;
  GL_STENCIL_BUFFER_BIT4_QCOM                = $00100000;
  GL_STENCIL_BUFFER_BIT5_QCOM                = $00200000;
  GL_STENCIL_BUFFER_BIT6_QCOM                = $00400000;
  GL_STENCIL_BUFFER_BIT7_QCOM                = $00800000;
  GL_MULTISAMPLE_BUFFER_BIT0_QCOM            = $01000000;
  GL_MULTISAMPLE_BUFFER_BIT1_QCOM            = $02000000;
  GL_MULTISAMPLE_BUFFER_BIT2_QCOM            = $04000000;
  GL_MULTISAMPLE_BUFFER_BIT3_QCOM            = $08000000;
  GL_MULTISAMPLE_BUFFER_BIT4_QCOM            = $10000000;
  GL_MULTISAMPLE_BUFFER_BIT5_QCOM            = $20000000;
  GL_MULTISAMPLE_BUFFER_BIT6_QCOM            = $40000000;
  GL_MULTISAMPLE_BUFFER_BIT7_QCOM            = $80000000;
  GL_WRITEONLY_RENDERING_QCOM                = $8823;        *)

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
  GLclampx   = LongInt;       PGLclampx   = ^GLclampx;
  GLfixed    = LongInt;       PGLfixed    = ^GLfixed;

var
  glGetString           : function(name: GLenum): PAnsiChar; stdcall;
  glHint                : procedure(target, mode: GLenum); stdcall;
  glShadeModel          : procedure(mode: GLenum); stdcall;
  glReadPixels          : procedure(x, y: GLint; width, height: GLsizei; format, atype: GLenum; pixels: Pointer); stdcall;
  // Color
  _glColor4f            : procedure(red, green, blue, alpha: GLfloat); stdcall;
  // Clear
  glClear               : procedure(mask: GLbitfield); stdcall;
  glClearColor          : procedure(red, green, blue, alpha: GLclampf); stdcall;
  {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  glClearDepthf         : procedure(depth: GLclampd); stdcall;
  {$ELSE}
  glClearDepthf         : procedure(depth: GLclampf); stdcall;
  {$ENDIF}
  // Get
(* 1.1 *)  glGetFloatv  : procedure(pname: GLenum; params: PGLfloat); stdcall;
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
// GLES 2.0... super...
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
(* 1.1 *)  glTexParameteri  : procedure(target: GLenum; pname: GLenum; param: GLint); stdcall;

(* 1.1 *)  glTexParameteriv : procedure(target: GLenum; pname: GLenum; const params: PGLint); stdcall;

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

  // FBO ... GLES 2.0 ????
  glIsRenderbuffer          : function(renderbuffer: GLuint): GLboolean; stdcall;
  glBindRenderbuffer        : procedure(target: GLenum; renderbuffer: GLuint); stdcall;
  glDeleteRenderbuffers     : procedure(n: GLsizei; const renderbuffers: PGLuint); stdcall;
  glGenRenderbuffers        : procedure(n: GLsizei; renderbuffers: PGLuint); stdcall;
  glRenderbufferStorage     : procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); stdcall;
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
  glFogx                    : procedure(pname: GLenum ; param: GLfixed); stdcall;
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
  (* GLES 1.1 *)
    glBindBuffer: procedure(target: GLenum; buffer: GLuint); stdcall;
    glBufferData: procedure(target: GLenum; size: GLsizei; const data: PGLvoid; usage: GLenum); stdcall;
    glBufferSubData: procedure(target: GLenum; offset: GLint; size: GLsizei; const data: PGLvoid); stdcall;
    glClipPlanef: procedure(plane: GLenum; const equation: GLfloat); stdcall;
    glClipPlanex: procedure(plane: GLenum; const equation: GLfloat); stdcall;            // óçíàòü â ÷¸ì ðàçíèöà!!!
//    glColor4ub: procedure(red, green, blue, alpha: GLubyte); stdcall;
//    glGetFloatv: procedure(pname: GLenum; params: PGLfloat); stdcall;
    glGetBooleanv: procedure(pname: GLenum; params: PGLboolean); stdcall;               // ïðîïèñàíû, íî ñóùåñòâóþò ëè?
    glGetBufferParameteriv : procedure(target: GLenum; pname: GLenum; params: PGLint); stdcall;
    glGetClipPlanef : procedure(plane: GLenum; equation: PGLdouble); stdcall;
    glGetClipPlanex : procedure(plane: GLenum; equation: PGLdouble); stdcall;
    glGetFixedv: procedure(pname:GLenum; params:PGLfixed);
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
    glIsBuffer: function(buffer: GLuint): GLboolean; stdcall;
    glIsEnabled: function(cap: GLenum): GLboolean; stdcall;
    glIsTexture: function(texture: GLuint): GLboolean; stdcall;
    glPointParameterf: procedure(pname: GLenum; param: GLfloat); stdcall;
    glPointParameterfv: procedure(pname: GLenum; const params: PGLfloat); stdcall;
    glPointParameterx: procedure(pname: GLenum; param: GLint); stdcall;
    glPointParameterxv: procedure(pname: GLenum; const params: PGLint); stdcall;
    glTexParameterfv: procedure(target:GLenum; pname:GLenum; params:PGLfloat); stdcall;
    glDeleteBuffers: procedure(n:GLsizei; buffers:PGLuint); stdcall;
    glGenBuffers: procedure(n:GLsizei; buffers:PGLuint); stdcall;

{***************************************************************************** }
{                                 OES extension functions                      }
{***************************************************************************** }
(*    glCurrentPaletteMatrixOES : procedure(matrixpaletteindex:GLuint); stdcall;
    glLoadPaletteFromModelViewMatrixOES : procedure; stdcall;
    glMatrixIndexPointerOES : procedure(size:GLint; _type:GLenum; stride:GLsizei; pointer:PGLvoid); stdcall;
    glWeightPointerOES: procedure(size: GLint; _type: GLenum; stride: GLsizei; pointer: PGLvoid); stdcall;
    glPointSizePointerOES: procedure(_type: GLenum; stride: GLsizei; pointer: PGLvoid); stdcall;
    glDrawTexsOES : procedure(x:GLshort; y:GLshort; z:GLshort; width:GLshort; height:GLshort); stdcall;
    glDrawTexiOES : procedure(x:GLint; y:GLint; z:GLint; width:GLint; height:GLint); stdcall;
    glDrawTexxOES : procedure(x:GLfixed; y:GLfixed; z:GLfixed; width:GLfixed; height:GLfixed); stdcall;
    glDrawTexsvOES : procedure(coords:PGLshort); stdcall;
    glDrawTexivOES : procedure(coords:PGLint); stdcall;
    glDrawTexxvOES : procedure(coords:PGLfixed); stdcall;
    glDrawTexfOES : procedure(x:GLfloat; y:GLfloat; z:GLfloat; width:GLfloat; height:GLfloat); stdcall;
    glDrawTexfvOES : procedure(coords:PGLfloat); stdcall;

    ???
    glQueryMatrixxOES: function(mantissa: PGLbitfield; exponent: PGLuint); GLbitfield;
    glClearDepthfOES
    glClipPlanefOES
    glDepthRangefOES
    glFrustumfOES
    glGetClipPlanefOES
    glOrthofOES
    glAlphaFuncxOES (GLenum func, GLfixed ref);
    glClearColorxOES (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);
    glClearDepthxOES (GLfixed depth);
    glClipPlanexOES (GLenum plane, const GLfixed *equation);
    glColor4xOES (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);
    glDepthRangexOES (GLfixed n, GLfixed f);
    glFogxOES (GLenum pname, GLfixed param);
    glFogxvOES (GLenum pname, const GLfixed *param);
    glFrustumxOES (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f);
    glGetClipPlanexOES (GLenum plane, GLfixed *equation);
    glGetFixedvOES (GLenum pname, GLfixed *params);
    glGetTexEnvxvOES (GLenum target, GLenum pname, GLfixed *params);
    glGetTexParameterxvOES (GLenum target, GLenum pname, GLfixed *params);
    glLightModelxOES (GLenum pname, GLfixed param);
    glLightModelxvOES (GLenum pname, const GLfixed *param);
    glLightxOES (GLenum light, GLenum pname, GLfixed param);
    glLightxvOES (GLenum light, GLenum pname, const GLfixed *params);
    glLineWidthxOES (GLfixed width);
    glLoadMatrixxOES (const GLfixed *m);
    glMaterialxOES (GLenum face, GLenum pname, GLfixed param);
    glMaterialxvOES (GLenum face, GLenum pname, const GLfixed *param);
    glMultMatrixxOES (const GLfixed *m);
    glMultiTexCoord4xOES (GLenum texture, GLfixed s, GLfixed t, GLfixed r, GLfixed q);
    glNormal3xOES (GLfixed nx, GLfixed ny, GLfixed nz);
    glOrthoxOES (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f);
    glPointParameterxvOES (GLenum pname, const GLfixed *params);
    glPointSizexOES (GLfixed size);
    glPolygonOffsetxOES (GLfixed factor, GLfixed units);
    glRotatexOES (GLfixed angle, GLfixed x, GLfixed y, GLfixed z);
    glScalexOES (GLfixed x, GLfixed y, GLfixed z);
    glTexEnvxOES (GLenum target, GLenum pname, GLfixed param);
    glTexEnvxvOES (GLenum target, GLenum pname, const GLfixed *params);
    glTexParameterxOES (GLenum target, GLenum pname, GLfixed param);
    glTexParameterxvOES (GLenum target, GLenum pname, const GLfixed *params);
    glTranslatexOES (GLfixed x, GLfixed y, GLfixed z);
    glGetLightxvOES (GLenum light, GLenum pname, GLfixed *params);
    glGetMaterialxvOES (GLenum face, GLenum pname, GLfixed *params);
    glPointParameterxOES (GLenum pname, GLfixed param);
    glSampleCoveragexOES (GLclampx value, GLboolean invert);
    glGetTexGenxvOES (GLenum coord, GLenum pname, GLfixed *params);
    glTexGenxOES (GLenum coord, GLenum pname, GLfixed param);
    glTexGenxvOES (GLenum coord, GLenum pname, const GLfixed *params);
    glTexGenfOES (GLenum coord, GLenum pname, GLfloat param);
    glTexGenfvOES (GLenum coord, GLenum pname, const GLfloat *params);
    glTexGeniOES (GLenum coord, GLenum pname, GLint param);
    glTexGenivOES (GLenum coord, GLenum pname, const GLint *params);
    glGetTexGenfvOES (GLenum coord, GLenum pname, GLfloat *params);
    glGetTexGenivOES (GLenum coord, GLenum pname, GLint *params);
    glBindVertexArrayOES (GLuint array);
    glDeleteVertexArraysOES (GLsizei n, const GLuint *arrays);
    glGenVertexArraysOES (GLsizei n, GLuint *arrays);
    glIsVertexArrayOES: function(GLuint array): GLboolean;
    // APPLE
    glCopyTextureLevelsAPPLE (GLuint destinationTexture, GLuint sourceTexture, GLint sourceBaseLevel, GLsizei sourceLevelCount);
    glRenderbufferStorageMultisampleAPPLE (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
    glResolveMultisampleFramebufferAPPLE (void);
    glFenceSyncAPPLE (GLenum condition, GLbitfield flags);
    glIsSyncAPPLE: function(GLsync sync): GLboolean;
    glDeleteSyncAPPLE (GLsync sync);
    glClientWaitSyncAPPLE (GLsync sync, GLbitfield flags, GLuint64 timeout): GLenum;
    glWaitSyncAPPLE (GLsync sync, GLbitfield flags, GLuint64 timeout);
    glGetInteger64vAPPLE (GLenum pname, GLint64 *params);
    glGetSyncivAPPLE (GLsync sync, GLenum pname, GLsizei count, GLsizei *length, GLint *values);
    // EXT
    glInsertEventMarkerEXT (GLsizei length, const GLchar *marker);
    glPushGroupMarkerEXT (GLsizei length, const GLchar *marker);
    glPopGroupMarkerEXT (void);
    glDiscardFramebufferEXT (GLenum target, GLsizei numAttachments, const GLenum *attachments);
    glMapBufferRangeEXT: function(GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access): pglvoid;
    glFlushMappedBufferRangeEXT (GLenum target, GLintptr offset, GLsizeiptr length);
    glMultiDrawArraysEXT (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount);
    glMultiDrawElementsEXT (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount);
    glRenderbufferStorageMultisampleEXT (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
    glFramebufferTexture2DMultisampleEXT (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLsizei samples);
    glReadnPixelsEXT (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
    glGetnUniformfvEXT (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
    glGetnUniformivEXT (GLuint program, GLint location, GLsizei bufSize, GLint *params);
    glTexStorage1DEXT (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
    glTexStorage2DEXT (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
    glTexStorage3DEXT (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
    glTextureStorage1DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
    glTextureStorage2DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
    glTextureStorage3DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
    // IMG
    glRenderbufferStorageMultisampleIMG (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
    glFramebufferTexture2DMultisampleIMG (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLsizei samples);
    glClipPlanefIMG (GLenum p, const GLfloat *eqn);
    glClipPlanexIMG (GLenum p, const GLfixed *eqn);
    // NV
    glDeleteFencesNV (GLsizei n, const GLuint *fences);
    glGenFencesNV (GLsizei n, GLuint *fences);
    glIsFenceNV: function(GLuint fence): GLboolean;
    glTestFenceNV: function(GLuint fence): GLboolean;
    glGetFenceivNV (GLuint fence, GLenum pname, GLint *params);
    glFinishFenceNV (GLuint fence);
    glSetFenceNV (GLuint fence, GLenum condition);
    // QCOM
    glGetDriverControlsQCOM (GLint *num, GLsizei size, GLuint *driverControls);
    glGetDriverControlStringQCOM (GLuint driverControl, GLsizei bufSize, GLsizei *length, GLchar *driverControlString);
    glEnableDriverControlQCOM (GLuint driverControl);
    glDisableDriverControlQCOM (GLuint driverControl);
    glExtGetTexturesQCOM (GLuint *textures, GLint maxTextures, GLint *numTextures);
    glExtGetBuffersQCOM (GLuint *buffers, GLint maxBuffers, GLint *numBuffers);
    glExtGetRenderbuffersQCOM (GLuint *renderbuffers, GLint maxRenderbuffers, GLint *numRenderbuffers);
    glExtGetFramebuffersQCOM (GLuint *framebuffers, GLint maxFramebuffers, GLint *numFramebuffers);
    glExtGetTexLevelParameterivQCOM (GLuint texture, GLenum face, GLint level, GLenum pname, GLint *params);
    glExtTexObjectStateOverrideiQCOM (GLenum target, GLenum pname, GLint param);
    glExtGetTexSubImageQCOM (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, void *texels);
    glExtGetBufferPointervQCOM (GLenum target, void **params);
    glExtGetShadersQCOM (GLuint *shaders, GLint maxShaders, GLint *numShaders);
    glExtGetProgramsQCOM (GLuint *programs, GLint maxPrograms, GLint *numPrograms);
    glExtIsProgramBinaryQCOM: function(GLuint program): GLboolean;
    glExtGetProgramBinarySourceQCOM (GLuint program, GLenum shadertype, GLchar *source, GLint *length);
    glStartTilingQCOM (GLuint x, GLuint y, GLuint width, GLuint height, GLbitfield preserveMask);
    glEndTilingQCOM (GLbitfield preserveMask);
  *)

  // State
  procedure glBegin(mode: GLenum);
  procedure glEnd;
// Color
  procedure glColor4ub(red, green, blue, alpha: GLubyte); {$IFDEF USE_INLINE} inline; {$ENDIF}    // ovveride
  procedure glColor4ubv(v: PGLubyte); {$IFDEF USE_INLINE} inline; {$ENDIF}                        // nothing
  procedure glColor4f(red, green, blue, alpha: GLfloat); {$IFDEF USE_INLINE} inline; {$ENDIF}     // ovveride
  // Matrix
  procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble);
  // Vertex
  procedure glVertex2f(x, y: GLfloat);
  procedure glVertex2fv(v: PGLfloat);
  procedure glVertex3f(x, y, z: GLfloat);
  // TexCoords
  procedure glTexCoord2f(s, t: GLfloat);
  procedure glTexCoord2fv(v: PGLfloat);


  (*****************************************************************************
  *                                EGL                                         *
  *****************************************************************************)
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

  EGL_VERSION_1_0 = 1;
  EGL_VERSION_1_1 = 1;
  EGL_VERSION_1_2 = 1;
  EGL_VERSION_1_3 = 1;
  EGL_FALSE                       = 0;
  EGL_TRUE                        = 1;
  EGL_BUFFER_SIZE                 = $3020;
  EGL_CONFIG_CAVEAT               = $3027;
  EGL_CONFIG_ID                   = $3028;
  EGL_LEVEL                       = $3029;
  EGL_MAX_PBUFFER_HEIGHT          = $302A;
  EGL_MAX_PBUFFER_PIXELS          = $302B;
  EGL_MAX_PBUFFER_WIDTH           = $302C;
  EGL_NATIVE_RENDERABLE           = $302D;
  EGL_NATIVE_VISUAL_ID            = $302E;
  EGL_NATIVE_VISUAL_TYPE          = $302F;
  EGL_PRESERVED_RESOURCES         = $3030;
  EGL_SAMPLE_BUFFERS              = $3032;
  EGL_TRANSPARENT_TYPE            = $3034;
  EGL_TRANSPARENT_BLUE_VALUE      = $3035;
  EGL_TRANSPARENT_GREEN_VALUE     = $3036;
  EGL_TRANSPARENT_RED_VALUE       = $3037;
  EGL_BIND_TO_TEXTURE_RGB         = $3039;
  EGL_BIND_TO_TEXTURE_RGBA        = $303A;
  EGL_MIN_SWAP_INTERVAL           = $303B;
  EGL_MAX_SWAP_INTERVAL           = $303C;
  EGL_LUMINANCE_SIZE              = $303D;
  EGL_ALPHA_MASK_SIZE             = $303E;
  EGL_COLOR_BUFFER_TYPE           = $303F;
  EGL_MATCH_NATIVE_PIXMAP         = $3041;
  EGL_SLOW_CONFIG                 = $3050;
  EGL_NON_CONFORMANT_CONFIG       = $3051;
  EGL_TRANSPARENT_RGB             = $3052;
  EGL_RGB_BUFFER                  = $308E;
  EGL_LUMINANCE_BUFFER            = $308F;
  EGL_NO_TEXTURE                  = $305C;
  EGL_TEXTURE_RGB                 = $305D;
  EGL_TEXTURE_RGBA                = $305E;
  EGL_TEXTURE_2D                  = $305F;
  EGL_PIXMAP_BIT                  = $02;
  EGL_OPENVG_BIT                  = $02;
  EGL_VENDOR                      = $3053;
  EGL_VERSION                     = $3054;
  EGL_EXTENSIONS                  = $3055;
  EGL_CLIENT_APIS                 = $308D;
  EGL_HEIGHT                      = $3056;
  EGL_WIDTH                       = $3057;
  EGL_LARGEST_PBUFFER             = $3058;
  EGL_TEXTURE_FORMAT              = $3080;
  EGL_TEXTURE_TARGET              = $3081;
  EGL_MIPMAP_TEXTURE              = $3082;
  EGL_MIPMAP_LEVEL                = $3083;
  EGL_RENDER_BUFFER               = $3086;
  EGL_COLORSPACE                  = $3087;
  EGL_ALPHA_FORMAT                = $3088;
  EGL_HORIZONTAL_RESOLUTION       = $3090;
  EGL_VERTICAL_RESOLUTION         = $3091;
  EGL_PIXEL_ASPECT_RATIO          = $3092;
  EGL_SWAP_BEHAVIOR               = $3093;
  EGL_BACK_BUFFER                 = $3084;
  EGL_SINGLE_BUFFER               = $3085;
  EGL_COLORSPACE_sRGB             = $3089;
  EGL_COLORSPACE_LINEAR           = $308A;
  EGL_ALPHA_FORMAT_NONPRE         = $308B;
  EGL_ALPHA_FORMAT_PRE            = $308C;
  EGL_DISPLAY_SCALING             = 10000;
  EGL_BUFFER_PRESERVED            = $3094;
  EGL_BUFFER_DESTROYED            = $3095;
  EGL_OPENVG_IMAGE                = $3096;
  EGL_CONTEXT_CLIENT_TYPE         = $3097;
  EGL_CONTEXT_CLIENT_VERSION      = $3098;
  EGL_OPENGL_ES_API               = $30A0;
  EGL_OPENVG_API                  = $30A1;
  EGL_DRAW                        = $3059;
  EGL_READ                        = $305A;
  EGL_CORE_NATIVE_ENGINE          = $305B;

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
  eglGetProcAddress      : function(name: PAnsiChar): Pointer; stdcall;
  eglGetError            : function: GLint; stdcall;
  eglGetDisplay          : function(display_id : EGLNativeDisplayType): EGLDisplay; stdcall;
  eglInitialize          : function(dpy: EGLDisplay; major: PEGLint; minor: PEGLint): EGLBoolean; stdcall;
  eglTerminate           : function(dpy: EGLDisplay): EGLBoolean; stdcall;
  eglChooseConfig        : function(dpy: EGLDisplay; attrib_list: PEGLint; configs: PEGLConfig; config_size: EGLint; num_config: PEGLint): EGLBoolean; stdcall;
  eglCreateWindowSurface : function(dpy: EGLDisplay; config: EGLConfig; win: EGLNativeWindowType; attrib_list: PEGLint): EGLSurface; stdcall;
  eglDestroySurface      : function(dpy: EGLDisplay; surface: EGLSurface): EGLBoolean; stdcall;
  eglSwapInterval        : function(dpy: EGLDisplay; interval: EGLint): EGLBoolean; stdcall;
  eglCreateContext       : function(dpy: EGLDisplay; config: EGLConfig; share_context: EGLContext; attrib_list: PEGLint): EGLContext; stdcall;
  eglDestroyContext      : function(dpy: EGLDisplay; ctx: EGLContext): EGLBoolean; stdcall;
  eglMakeCurrent         : function(dpy: EGLDisplay; draw: EGLSurface; read: EGLSurface; ctx: EGLContext): EGLBoolean; stdcall;
  eglSwapBuffers         : function(dpy: EGLDisplay; surface: EGLSurface): EGLBoolean; stdcall;
{$ENDIF}

var
  {$IFNDEF NO_EGL}
  eglLibrary  : {$IFDEF WINDOWS}LongWord{$ELSE}Pointer{$ENDIF};
  glesLibrary : {$IFDEF WINDOWS}LongWord{$ELSE}Pointer{$ENDIF};
  separateEGL : Boolean;
  {$ELSE}
  glesLibrary: Pointer;
  {$ENDIF}

implementation
uses
  zgl_math_2d,
  zgl_types,
  zgl_gltypeconst,
  zgl_utils;

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
  _glColor4f               := dlsym( glesLibrary, 'glColor4f' );
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
  bSize := 0;
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
