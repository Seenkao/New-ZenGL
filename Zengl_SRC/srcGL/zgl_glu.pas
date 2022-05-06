(*
 *  Copyright (c) 2021 Serge - SSW
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
 *)
unit zgl_glu;
{$I zgl_config.cfg}
{$I GLdefine.cfg}

interface

uses
  zgl_gltypeconst,
  {$IfNDef USE_GLES}
  zgl_opengl_all
  {$Else}
  zgl_opengles_all
  {$EndIf}
  ;

type
  TViewPortArray = array [0..3] of GLint;
  T16dArray = array [0..15] of GLdouble;
  T3dArray = array [0..2] of GLdouble;
  T4pArray = array [0..3] of Pointer;
  T4fArray = array [0..3] of GLfloat;

const
  GLU_TESS_MAX_COORD = 1.0e150;
(* Boolean  *)
  GLU_FALSE = 0;
  GLU_TRUE = 1;
(* StringName  *)
  GLU_VERSION = 100800;
  GLU_EXTENSIONS = 100801;
(* ErrorCode  *)
  GLU_INVALID_ENUM = 100900;
  GLU_INVALID_VALUE = 100901;
  GLU_OUT_OF_MEMORY = 100902;
  GLU_INCOMPATIBLE_GL_VERSION = 100903;
  GLU_INVALID_OPERATION = 100904;
(* NurbsDisplay  *)
(*      GLU_FILL  *)
  GLU_OUTLINE_POLYGON = 100240;
  GLU_OUTLINE_PATCH = 100241;
(* NurbsCallback  *)
  GLU_NURBS_ERROR = 100103;
  GLU_ERROR = 100103;
  GLU_NURBS_BEGIN = 100164;
  GLU_NURBS_BEGIN_EXT = 100164;
  GLU_NURBS_VERTEX = 100165;
  GLU_NURBS_VERTEX_EXT = 100165;
  GLU_NURBS_NORMAL = 100166;
  GLU_NURBS_NORMAL_EXT = 100166;
  GLU_NURBS_COLOR = 100167;
  GLU_NURBS_COLOR_EXT = 100167;
  GLU_NURBS_TEXTURE_COORD = 100168;
  GLU_NURBS_TEX_COORD_EXT = 100168;
  GLU_NURBS_END = 100169;
  GLU_NURBS_END_EXT = 100169;
  GLU_NURBS_BEGIN_DATA = 100170;
  GLU_NURBS_BEGIN_DATA_EXT = 100170;
  GLU_NURBS_VERTEX_DATA = 100171;
  GLU_NURBS_VERTEX_DATA_EXT = 100171;
  GLU_NURBS_NORMAL_DATA = 100172;
  GLU_NURBS_NORMAL_DATA_EXT = 100172;
  GLU_NURBS_COLOR_DATA = 100173;
  GLU_NURBS_COLOR_DATA_EXT = 100173;
  GLU_NURBS_TEXTURE_COORD_DATA = 100174;
  GLU_NURBS_TEX_COORD_DATA_EXT = 100174;
  GLU_NURBS_END_DATA = 100175;
  GLU_NURBS_END_DATA_EXT = 100175;
(* NurbsError  *)
  GLU_NURBS_ERROR1  = 100251;
  GLU_NURBS_ERROR2  = 100252;
  GLU_NURBS_ERROR3  = 100253;
  GLU_NURBS_ERROR4  = 100254;
  GLU_NURBS_ERROR5  = 100255;
  GLU_NURBS_ERROR6  = 100256;
  GLU_NURBS_ERROR7  = 100257;
  GLU_NURBS_ERROR8  = 100258;
  GLU_NURBS_ERROR9  = 100259;
  GLU_NURBS_ERROR10 = 100260;
  GLU_NURBS_ERROR11 = 100261;
  GLU_NURBS_ERROR12 = 100262;
  GLU_NURBS_ERROR13 = 100263;
  GLU_NURBS_ERROR14 = 100264;
  GLU_NURBS_ERROR15 = 100265;
  GLU_NURBS_ERROR16 = 100266;
  GLU_NURBS_ERROR17 = 100267;
  GLU_NURBS_ERROR18 = 100268;
  GLU_NURBS_ERROR19 = 100269;
  GLU_NURBS_ERROR20 = 100270;
  GLU_NURBS_ERROR21 = 100271;
  GLU_NURBS_ERROR22 = 100272;
  GLU_NURBS_ERROR23 = 100273;
  GLU_NURBS_ERROR24 = 100274;
  GLU_NURBS_ERROR25 = 100275;
  GLU_NURBS_ERROR26 = 100276;
  GLU_NURBS_ERROR27 = 100277;
  GLU_NURBS_ERROR28 = 100278;
  GLU_NURBS_ERROR29 = 100279;
  GLU_NURBS_ERROR30 = 100280;
  GLU_NURBS_ERROR31 = 100281;
  GLU_NURBS_ERROR32 = 100282;
  GLU_NURBS_ERROR33 = 100283;
  GLU_NURBS_ERROR34 = 100284;
  GLU_NURBS_ERROR35 = 100285;
  GLU_NURBS_ERROR36 = 100286;
  GLU_NURBS_ERROR37 = 100287;
(* NurbsProperty  *)
  GLU_AUTO_LOAD_MATRIX = 100200;
  GLU_CULLING = 100201;
  GLU_SAMPLING_TOLERANCE = 100203;
  GLU_DISPLAY_MODE = 100204;
  GLU_PARAMETRIC_TOLERANCE = 100202;
  GLU_SAMPLING_METHOD = 100205;
  GLU_U_STEP = 100206;
  GLU_V_STEP = 100207;
  GLU_NURBS_MODE = 100160;
  GLU_NURBS_MODE_EXT = 100160;
  GLU_NURBS_TESSELLATOR = 100161;
  GLU_NURBS_TESSELLATOR_EXT = 100161;
  GLU_NURBS_RENDERER = 100162;
  GLU_NURBS_RENDERER_EXT = 100162;
(* NurbsSampling  *)
  GLU_OBJECT_PARAMETRIC_ERROR = 100208;
  GLU_OBJECT_PARAMETRIC_ERROR_EXT = 100208;
  GLU_OBJECT_PATH_LENGTH = 100209;
  GLU_OBJECT_PATH_LENGTH_EXT = 100209;
  GLU_PATH_LENGTH = 100215;
  GLU_PARAMETRIC_ERROR = 100216;
  GLU_DOMAIN_DISTANCE = 100217;
(* NurbsTrim  *)
  GLU_MAP1_TRIM_2 = 100210;
  GLU_MAP1_TRIM_3 = 100211;
(* QuadricDrawStyle  *)
  GLU_POINT = 100010;
  GLU_LINE = 100011;
  GLU_FILL = 100012;
  GLU_SILHOUETTE = 100013;

(* QuadricNormal  *)
  GLU_SMOOTH = 100000;
  GLU_FLAT = 100001;
  GLU_NONE = 100002;
(* QuadricOrientation  *)
  GLU_OUTSIDE = 100020;
  GLU_INSIDE = 100021;
(* TessCallback  *)
  GLU_TESS_BEGIN = 100100;
  GLU_BEGIN = 100100;
  GLU_TESS_VERTEX = 100101;
  GLU_VERTEX = 100101;
  GLU_TESS_END = 100102;
  GLU_END = 100102;
  GLU_TESS_ERROR = 100103;
  GLU_TESS_EDGE_FLAG = 100104;
  GLU_EDGE_FLAG = 100104;
  GLU_TESS_COMBINE = 100105;
  GLU_TESS_BEGIN_DATA = 100106;
  GLU_TESS_VERTEX_DATA = 100107;
  GLU_TESS_END_DATA = 100108;
  GLU_TESS_ERROR_DATA = 100109;
  GLU_TESS_EDGE_FLAG_DATA = 100110;
  GLU_TESS_COMBINE_DATA = 100111;
(* TessContour  *)
  GLU_CW = 100120;
  GLU_CCW = 100121;
  GLU_INTERIOR = 100122;
  GLU_EXTERIOR = 100123;
  GLU_UNKNOWN = 100124;
(* TessProperty  *)
  GLU_TESS_WINDING_RULE = 100140;
  GLU_TESS_BOUNDARY_ONLY = 100141;
  GLU_TESS_TOLERANCE = 100142;
(* TessError  *)
  GLU_TESS_ERROR1 = 100151;
  GLU_TESS_ERROR2 = 100152;
  GLU_TESS_ERROR3 = 100153;
  GLU_TESS_ERROR4 = 100154;
  GLU_TESS_ERROR5 = 100155;
  GLU_TESS_ERROR6 = 100156;
  GLU_TESS_ERROR7 = 100157;
  GLU_TESS_ERROR8 = 100158;
  GLU_TESS_MISSING_BEGIN_POLYGON = 100151;
  GLU_TESS_MISSING_BEGIN_CONTOUR = 100152;
  GLU_TESS_MISSING_END_POLYGON = 100153;
  GLU_TESS_MISSING_END_CONTOUR = 100154;
  GLU_TESS_COORD_TOO_LARGE = 100155;
  GLU_TESS_NEED_COMBINE_CALLBACK = 100156;
(* TessWinding  *)
  GLU_TESS_WINDING_ODD = 100130;
  GLU_TESS_WINDING_NONZERO = 100131;
  GLU_TESS_WINDING_POSITIVE = 100132;
  GLU_TESS_WINDING_NEGATIVE = 100133;
  GLU_TESS_WINDING_ABS_GEQ_TWO = 100134;

type
  GLUnurbs = record end;
  GLUquadric = record end;
  GLUtesselator = record end;

  PGLUnurbs       = ^GLUnurbs;
  PGLUquadric     = ^GLUquadric;
  PGLUtesselator  = ^GLUtesselator;

  GLUnurbsObj        = GLUnurbs;
  GLUquadricObj      = GLUquadric;
  GLUtesselatorObj   = GLUtesselator;
  GLUtriangulatorObj = GLUtesselator;
  _GLUfuncptr = procedure ;stdcall;
  TCallback          = _GLUfuncptr;

  PGLchar = PAnsiChar;

  {$IfNDef USE_GLES}
  procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble); stdcall; external libGLU;
  function  gluBuild2DMipmaps(target: GLenum; components, width, height: GLint; format, atype: GLenum; const data: Pointer): Integer; stdcall; external libGLU;
  {$EndIf}

  // Triangulation
  {$IFDEF USE_TRIANGULATION}
  procedure gluDeleteTess(tess: PGLUtesselator); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  function  gluErrorString(error: GLenum): PAnsiChar; stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  function  gluNewTess: PGLUtesselator; stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  procedure gluTessBeginContour(tess: PGLUtesselator); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  procedure gluTessBeginPolygon(tess: PGLUtesselator; data: Pointer); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  procedure gluTessCallback(tess: PGLUtesselator; which: GLenum; fn: Pointer); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  procedure gluTessEndContour(tess: PGLUtesselator); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  procedure gluTessEndPolygon(tess: PGLUtesselator); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  procedure gluTessVertex(tess: PGLUtesselator; const coords: TVector3d; data: Pointer); stdcall external {$IfNDef USE_GLES}libGLU{$Else}'libGLU'{$EndIf};
  {$IfNDef USE_GLES}  // ???
  procedure gluTessNormal(tess: PGLUtesselator; valueX: GLdouble; valueY: GLdouble; valueZ: GLdouble); stdcall external libGLU;
  procedure gluTessProperty(tess: PGLUtesselator; which: GLenum; data: GLdouble); stdcall external libGLU;
  function  gluGetString(name: GLenum): PAnsiChar; stdcall external libGLU;
  {$ENDIF}{$ENDIF}

  {$IfDef USE_FULL_GLU}
  procedure gluBeginCurve(nurb: PGLUnurbs); stdcall external libGLU;
  procedure gluBeginPolygon(tess: PGLUtesselator); stdcall external libGLU;
  procedure gluBeginSurface(nurb: PGLUnurbs); stdcall external libGLU;
  procedure gluBeginTrim(nurb: PGLUnurbs); stdcall external libGLU;
  function  gluBuild1DMipmapLevels(target: GLenum; internalFormat: GLint; width: GLsizei; format: GLenum; _type: GLenum;
        level: GLint; base: GLint; max: GLint; data: pointer): GLint; stdcall external libGLU;
  function  gluBuild1DMipmaps(target: GLenum; internalFormat: GLint; width: GLsizei; format: GLenum; _type: GLenum;
        data: pointer): GLint; stdcall external libGLU;
  function  gluBuild2DMipmapLevels(target: GLenum; internalFormat: GLint; width: GLsizei; height: GLsizei; format: GLenum;
        _type: GLenum; level: GLint; base: GLint; max: GLint; data: pointer):GLint; stdcall external libGLU;

//  gluBuild2DMipmaps : function(target:GLenum; internalFormat:GLint; width:GLsizei; height:GLsizei; format:GLenum;
//    _type:GLenum; data:pointer):GLint; stdcall external libGLU;

  function  gluBuild3DMipmapLevels(target: GLenum; internalFormat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei;
        format: GLenum; _type: GLenum; level: GLint; base: GLint; max: GLint; data: pointer): GLint; stdcall external libGLU;
  function  gluBuild3DMipmaps(target: GLenum; internalFormat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei;
        format: GLenum; _type: GLenum; data: pointer): GLint; stdcall external libGLU;
  function  gluCheckExtension(extName: PGLubyte; extString: PGLubyte): GLboolean; stdcall external libGLU;
  procedure gluCylinder(quad:PGLUquadric; base:GLdouble; top:GLdouble; height:GLdouble; slices:GLint;
        stacks:GLint); stdcall external libGLU;
  procedure gluDeleteNurbsRenderer(nurb: PGLUnurbs); stdcall external libGLU;
  procedure gluDeleteQuadric(quad: PGLUquadric); stdcall external libGLU;
  procedure gluDisk(quad: PGLUquadric; inner: GLdouble; outer: GLdouble; slices: GLint; loops: GLint); stdcall external libGLU;
  procedure gluEndCurve(nurb: PGLUnurbs); stdcall external libGLU;
  procedure gluEndPolygon(tess: PGLUtesselator); stdcall external libGLU;
  procedure gluEndSurface(nurb: PGLUnurbs); stdcall external libGLU;
  procedure gluEndTrim(nurb: PGLUnurbs); stdcall external libGLU;
  procedure gluGetNurbsProperty(nurb: PGLUnurbs; _property: GLenum; data: PGLfloat); stdcall external libGLU;

  procedure gluGetTessProperty(tess: PGLUtesselator; which: GLenum; data: PGLdouble); stdcall external libGLU;

  procedure gluLoadSamplingMatrices(nurb: PGLUnurbs; model: PGLfloat; perspective: PGLfloat; view: PGLint); stdcall external libGLU;
  procedure gluLookAt(eyeX: GLdouble; eyeY: GLdouble; eyeZ: GLdouble; centerX: GLdouble; centerY: GLdouble;
        centerZ: GLdouble; upX: GLdouble; upY: GLdouble; upZ: GLdouble); stdcall external libGLU;
  function  gluNewNurbsRenderer: PGLUnurbs; stdcall external libGLU;
  function  gluNewQuadric: PGLUquadric; stdcall external libGLU;
  procedure gluNextContour(tess: PGLUtesselator; _type: GLenum); stdcall external libGLU;
  procedure gluNurbsCallback(nurb: PGLUnurbs; which: GLenum; CallBackFunc: _GLUfuncptr); stdcall external libGLU;
  procedure gluNurbsCallbackData(nurb: PGLUnurbs; userData: PGLvoid); stdcall external libGLU;
  procedure gluNurbsCallbackDataEXT(nurb: PGLUnurbs; userData: PGLvoid); stdcall external libGLU;
  procedure gluNurbsCurve(nurb: PGLUnurbs; knotCount: GLint; knots: PGLfloat; stride: GLint; control: PGLfloat;
        order: GLint; _type: GLenum); stdcall external libGLU;
  procedure gluNurbsProperty(nurb: PGLUnurbs; _property: GLenum; value: GLfloat); stdcall external libGLU;
  procedure gluNurbsSurface(nurb: PGLUnurbs; sKnotCount: GLint; sKnots: PGLfloat; tKnotCount: GLint; tKnots: PGLfloat;
        sStride: GLint; tStride: GLint; control: PGLfloat; sOrder: GLint; tOrder: GLint; _type: GLenum); stdcall external libGLU;
  procedure gluOrtho2D(left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble); stdcall external libGLU;
  procedure gluPartialDisk(quad: PGLUquadric; inner: GLdouble; outer: GLdouble; slices: GLint; loops: GLint;
        start: GLdouble; sweep: GLdouble); stdcall external libGLU;
  procedure gluPickMatrix(x: GLdouble; y: GLdouble; delX: GLdouble; delY: GLdouble; viewport: PGLint); stdcall external libGLU;

  function  gluProject(objX: GLdouble; objY: GLdouble; objZ: GLdouble; model: PGLdouble; proj: PGLdouble;
        view: PGLint; winX: PGLdouble; winY: PGLdouble; winZ: PGLdouble): GLint; stdcall external libGLU;
  procedure gluPwlCurve(nurb: PGLUnurbs; count: GLint; data: PGLfloat; stride: GLint; _type: GLenum); stdcall external libGLU;
  procedure gluQuadricCallback(quad: PGLUquadric; which: GLenum; CallBackFunc: _GLUfuncptr); stdcall external libGLU;
  procedure gluQuadricDrawStyle(quad: PGLUquadric; draw: GLenum); stdcall external libGLU;
  procedure gluQuadricNormals(quad: PGLUquadric; normal: GLenum); stdcall external libGLU;
  procedure gluQuadricOrientation(quad: PGLUquadric; orientation: GLenum); stdcall external libGLU;
  procedure gluQuadricTexture(quad: PGLUquadric; texture: GLboolean); stdcall external libGLU;

  function  gluScaleImage(format: GLenum; wIn: GLsizei; hIn: GLsizei; typeIn: GLenum; dataIn: pointer;
        wOut: GLsizei; hOut: GLsizei; typeOut: GLenum; dataOut: PGLvoid): GLint; stdcall external libGLU;
  procedure gluSphere(quad: PGLUquadric; radius: GLdouble; slices: GLint; stacks: GLint); stdcall external libGLU;

  function  gluUnProject(winX: GLdouble; winY: GLdouble; winZ: GLdouble; model: PGLdouble; proj: PGLdouble;
        view: PGLint; objX: PGLdouble; objY: PGLdouble; objZ: PGLdouble): GLint; stdcall external libGLU;

  function  gluUnProject4(winX: GLdouble; winY: GLdouble; winZ: GLdouble; clipW: GLdouble; model: PGLdouble;
        proj: PGLdouble; view: PGLint; nearVal: GLdouble; farVal: GLdouble; objX: PGLdouble;
        objY: PGLdouble; objZ: PGLdouble; objW: PGLdouble): GLint; stdcall external libGLU;
  {$EndIf}

var
  GLU_VERSION_1_1, GLU_VERSION_1_2, GLU_VERSION_1_3: Boolean;

implementation

end.

