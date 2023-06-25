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
unit zgl_types;

{$I zgl_config.cfg}

interface

//uses
  //;

const
// timer
  MAX_TIMERS   =  50;        // максимальное количество таймеров.

  // биты работы с таймером
  t_Stop         =   1;        // таймер останавливается незамедлительно
  t_Start        =   2;        // таймер создаётся и стартует незамедлительно
  t_Tiks         =   4;        // используется только внутри таймеров!
  t_SleepToStart =   8;        // таймер создаётся и запускается с установленной задержкой
  t_SleepToStop  =  16;        // таймер останавливается через определённое время
  t_Enable       = 128;        // используется или нет данный таймер (существует или нет?)
  t_Stop_or_SleepToStart = t_Stop or t_SleepToStart;
  t_Start_or_SleepToStop = t_Start or t_SleepToStop;

// mouse and touch
  is_down       = $001;                     // нажато в данный момент времени
  is_up         = $002;                     // отпущено в данный момент времени
  is_click      = is_down;
  is_canclick   = is_up;
  is_Press      = $004;                     // нажато постоянно
  is_canPress   = $008;                     // отпущенно - по умолчанию
  is_DoubleDown = $010;                     // было произведено двойное нажатие
  is_TripleDown = $020;                     // тройное нажатие, нужно или нет?
  is_mWheelUp   = $040;                     // только для третьей кнопки мыши! - ролик (центральная кнопка)
  is_mWheelDown = $080;                     // указание ролик движется вверх или вниз.
  is_notTouch   = $FF;                      // не было ни каких нажатий клавиши на виртуальной клавиатуре.

  M_BLEFT       = 0;
  {$IfNDef MOBILE}
  M_BMIDDLE     = 1;
  M_BRIGHT      = 2;
  {$Else}
  M_BMIDDLE     = 2;
  M_BRIGHT      = 1;
  {$EndIf}
  MAX_TOUCH      = 10;

  // OpenGL
  ModeUser       = 1;                       // MatrixMode
  Mode2D         = 2;
  Mode3D         = 3;
  {$IfDef MAC_COCOA}
  CORE_2_1 = 1;
  CORE_3_2 = 2;
  CORE_4_1 = 3;
  {$EndIf}
  CORE_VERSION = 1;                         // совместимость с текущей версией и выше
  COMPATIBILITY_VERSION = 2;                // совместимость с ранними версиями. Нельзя использовать для GL 3.2
  GL_DEBUG = 4;                             // отладка контекста включена
  GL_FORWARD_COMPATIBLE = 8;                // вперёд совместимый контекст.

  // primitives
  PR2D_FILL   = $010000;
  PR2D_SMOOTH = $020000;
  LINE_RGBA   = $040000;
  LINE_LOOP   = $080000;

{$IFNDEF FPC}
type
  QWORD = UInt64;
{$ENDIF}

type
  Ptr = {$IFDEF CPU64} QWORD {$ELSE} LongWord {$ENDIF};

  // Rus: указатель на массив байт.
  // Eng: pointer to an array of bytes.
  PByteArray     = ^TByteArray;
  // Rus: массив байт.
  // Eng: array of bytes.
  TByteArray     = array[0..High(LongWord) shr 1 - 1] of Byte;
  // Rus: указатель на массив слов.
  // Eng: pointer to an array of words.
  PWordArray     = ^TWordArray;
  // Rus: массив слов.
  // Eng: array of words.
  TWordArray     = array[0..High(LongWord) shr 2 - 1] of Word;
  // Rus: указатель на массив длинных слов.
  // Eng: pointer to an array of long words.
  PLongWordArray = ^TLongWordArray;
  // Rus: массив длинных слов.
  // Eng: array of long words.
  TLongWordArray = array[0..High(LongWord) shr 3 - 1] of LongWord;

  // Rus: указатель на индексы координат текстур.
  // Eng: pointer to texture coordinate indices.
  zglPTexCoordIndex = ^zglTTexCoordIndex;
  // Rus: индексы координат текстур.
  // Eng: texture coordinate indexes.
  zglTTexCoordIndex = array[0..3] of Integer;

  // Rus: указатель на список строк.
  // Eng: a pointer to a list of strings.
  zglPStringList = ^zglTStringList;
  // Rus: список строк.
  // Eng: string list.
  zglTStringList = record
    Count: Integer;
    Items: array of UTF8String;
  end;

// timer
  zglPTimer = ^zglTTimer;
  zglTTimer = record
    Interval, SInterval: LongWord;
    Flags: LongWord;
    LastTick, LastTickForSleep: Double;
    OnTimer: procedure;
  end;

  zglPTimerManager = ^zglTTimerManager;
  zglTTimerManager = record
    Count: LongWord;
    maxTimers: LongWord;
    Timers: array of zglPTimer;
  end;

  // Rus: указатель на цвет в "точной" форме - RGBA - single. От 0 до 1.
  // Eng: pointer to color in "exact" form - RGBA - single. 0 to 1.
  zglPColor = ^zglTColor;
  // Rus: цвет в "точной" форме - RGBA - single. От 0 до 1.
  // Eng: color in "exact" form - RGBA - single. 0 to 1.
  zglTColor = record
    R, G, B, A: Single;
  end;

  // Rus: указатель на цвет в байтах - RGBA.
  // Eng: pointer to color in bytes - RGBA.
  zglPByteColor = ^zglTByteColor;
  // Rus: цвет в байтах - RGBA.
  // Eng: color in bytes - RGBA.
  zglTByteColor = record
    R, G, B, A: Byte;
  end;

// - было произведено нажатие-отжатие - эти события очищаются
// - было произведено удержание - это событие не должно очищаться, пока не было нажатия или отжатия

(*******************************************************************************
*                    keyboard, mouse, touch and joystick&                      *
*******************************************************************************)
  // мы можем расширить структуру и реализовать множественные нажатия, аж до нескольких сотен
  // но, для данного ввода, нам надо определить будет ли это эффективно
  // проверяем это на мыши.

  // Rus: для тачскрина, у каждого касания есть свои координаты.
  // Eng: for a touchscreen, each touch has its own coordinates.
  Pm_touch = ^m_touch;
  m_touch = record
    oldX, oldY, newX, newY: Integer;            // старые и новые координаты, когда ведут по сенсору.
//    oldXtap, oldYtap: Integer;                  // последние координаты, которые были, до обнуления координат
    state: LongWord;
    DBLClickTime: Double;
  end;

  // Rus: для клавиш клавиатуры и мыши.
  // Eng: for keyboard and mouse keys.
  km_Button = record
    state: LongWord;
    DBLClickTime: Double;
  end;
(*******************************************************************************
*                                 End                                          *
*******************************************************************************)

(*******************************************************************************
*                            primitives                                        *
*******************************************************************************)
type
  // Rus: указатель на две координаты - X, Y и на цвет - Color точки.
  // Eng: pointer to two coordinates - X, Y and color - Point color.
  zglPPoint2DColor = ^zglTPoint2DColor;
  // Rus: две координаты - X, Y и цвет точки - Color.
  // Eng: two coordinates - X, Y and color of the point - Color.
  zglTPoint2DColor = record
    X, Y: Single;
    Color: LongWord;
  end;

  // Rus: указатель на две координаты точки - X, Y.
  // Eng: pointer to two point coordinates - X, Y.
  zglPPoint2D = ^zglTPoint2D;
  // Rus: две координаты точки - X, Y.
  // Eng: two coordinates of a point - X, Y.
  zglTPoint2D = record
    X, Y: Single;
  end;

  // Rus: указатель на три координаты точки - X, Y, Z.
  // Eng: pointer to three point coordinates - X, Y, Z.
  zglPPoint3D = ^zglTPoint3D;
  // Rus: три координаты точки - X, Y, Z.
  // Eng: three point coordinates - X, Y, Z.
  zglTPoint3D = record
    X, Y, Z: Single;
  end;

  // Rus: указатель на две координаты точки - массив из одного элемента.
  // Eng: a pointer to two point coordinates - an array of one element.
  zglPPoints2D = ^zglTPoints2D;
  // Rus: две координаты точки - массив из одного элемента.
  // Eng: two coordinates of a point - an array of one element.
  zglTPoints2D = array[0..0] of zglTPoint2D;

  // Rus: Указатель на линию. Две координаты XY (то же самое что и вектор).
  // Eng:
  zglPLine2D = ^zglTLine2D;
  // Rus: Координаты линии XY. То же самое что и вектор.
  // Eng:
  zglTLine2D = record
    x1, y1: Single;
    x2, y2: Single;
  end;

  // Rus: Указатель на линию. две координаты XYZ (то же самое что и вектор).
  // Eng: Line pointer. Two XY coordinates (same as a vector).
  zglPLine3D = ^zglTLine3D;
  // Rus: линия - две координаты XYZ. То же самое что и вектор.
  // Eng: line - two XYZ coordinates. The same as a vector.
  zglTLine3D = record
    x1, y1, z1: Single;
    x2, y2, z2: Single;
  end;

  // Rus: указатель на вектор - 2 точки - X, Y.
  // Eng: pointer to vector - 2 points - X, Y.
  zglPVector2D = ^zglTVector2D;
  // Rus: вектор - 2 точки - X, Y.
  // Eng: vector - 2 points - X, Y.
  zglTVector2D = record
    x1, y1: Single;
    x2, y2: Single;
  end;

  // Rus: указатель на вектор - 2 точки - X, Y, Z.
  // Eng: vector pointer - 2 points - X, Y, Z.
  zglPVector3D = ^zglTVector3D;
  // Rus: вектор - 2 точки - X, Y, Z.
  // Eng: vector - 2 points - X, Y, Z.
  zglTVector3D = record
    x1, y1, z1: Single;
    x2, y2, z2: Single;
  end;

  // Rus: указатель на прямоугольник - координаты, ширина, высота - Single.
  // Eng: pointer to rectangle - coordinates, width, height - Single.
  zglPRect2D = ^zglTRect2D;
  // Rus: прямоугольник - координаты, ширина, высота - Single.
  // Eng: rectangle - coordinates, width, height - Single.
  zglTRect2D = record
    X, Y, W, H: Single;
  end;

  // Begin point - end point
  // Rus: указатель на прямоугольник - начальная и конечная координаты - Single.
  // Eng: pointer to rectangle - start and end coordinates - Single.
  zglPRectBPEP2D = ^zglTRectBPEP2D;
  // Begin point - end point
  // Rus: прямоугольник - начальная и конечная координаты - Single.
  // Eng: rectangle - start and end coordinates - Single.
  zglTRectBPEP2D = record
    X1, Y1, X2, Y2: Single;
  end;

  // Rus: указатель на произвольный четырёхугольник - четыре координаты - Single.
  // Eng: pointer to arbitrary quadrilateral - four coordinates - Single.
  zglPRectPoints2D = ^zglTRectPoints2D;
  // Rus: произвольный четырёхугольник - четыре координаты - Single.
  // Eng: arbitrary quadrilateral - four coordinates - Single.
  zglTRectPoints2D = record
    x1, y1: Single;
    x2, y2: Single;
    x3, y3: Single;
    x4, y4: Single;
  end;

  // Rus: указатель на прямоугольник - координаты, ширина, высота - Word.
  // Eng: pointer to rectangle - coordinates, width, height - Word.
  zglPWordRect2D = ^zglTWordRect2D;
  // Rus: прямоугольник - координаты, ширина, высота - Word.
  // Eng: rectangle - coordinates, width, height - Word.
  zglTWordRect2D = record
    X, Y, W, H: Word;
  end;

  // Rus: указатель на окружность - координата цетра и радиус.
  // Eng: circle pointer - center coordinate and radius.
  zglPCircle2D = ^zglTCircle2D;
  // Rus: окружность - координата цетра и радиус.
  // Eng: circle - center coordinate and radius.
  zglTCircle2D = record
    cX, cY: Single;
    Radius: Single;
  end;

  // Rus: Для 3D ни чего не решено, потому большинство структур - предварительны.
  // Eng: For 3D, nothing has been decided, because most of the structures are preliminary.

  // параллелограм должен находиться по координатам, высоте, ширине, глубине и
  // минимум углу поворота в пространстве от нуля.
  // Rus: указатель на параллелограм - координаты, ширина, высота, глубина - Single.
  // Eng: pointer to parallelogram - coordinates, width, height, depth - Single.
  zglPRect3D = ^zglTRect3D;
  // Rus: параллелограм - координаты, ширина, высота, глубина - Single.
  // Eng: parallelogram - coordinates, width, height, depth - Single.
  zglTRect3D = record
    X, Y, Z, W, H, Gl: Single;
  end;

  // Begin point - end point
  // так же нужен угол поворота в пространстве. Либо описанная плоскость.
  // Rus: указатель на параллелограм - начальная и конечная координаты - Single.
  //      Параллелограм описываемый двумя трёхмерными точками.
  // Eng: pointer to parallelogram - start and end coordinates - Single.
  //      Parallelogram described by two 3D points.
  zglPRectBPEP3D = ^zglTRectBPEP3D;
  // Begin point - end point
  // Rus: параллелограм - начальная и конечная координаты - Single.
  //      Параллелограм описываемый двумя трёхмерными точками.
  // Eng: parallelogram - start and end coordinates - Single.
  //      Parallelogram described by two 3D points.
  zglTRectBPEP3D = record
    X1, Y1, Z1, X2, Y2, Z2: Single;
  end;

  // Rus: указатель на произвольный восьмиугольник - восемь координат - Single.
  // Eng: pointer to an arbitrary octagon - eight coordinates - Single.
  zglPRectPoints3D = ^zglTRectPoints3D;
  // Rus: произвольный восьмиугольник - восемь координат - Single.
  // Eng: arbitrary octagon - eight coordinates - Single.
  zglTRectPoints3D = record
    x1, y1, z1, x2, y2, z2: Single;
    x3, y3, z3, x4, y4, z4: Single;
    x5, y5, z5, x6, y6, z6: Single;
    x7, y7, z7, x8, y8, z8: Single;
  end;

  // Rus: указатель на сферу - координата цетра и радиус.
  // Eng: sphere pointer - center coordinate and radius.
  zglPCircle3D = ^zglTCircle3D;
  // Rus: сфера - координата цетра и радиус.
  // Eng: sphere - center coordinate and radius.
  zglTCircle3D = record
    cX, cY, cZ: Single;
    Radius: Single;
  end;
(*******************************************************************************
*                               end primitives                                 *
*******************************************************************************)

// camera
  zglPCamera2D = ^zglTCamera2D;
  zglTCamera2D = record
    X, Y  : Single;
    Angle : Single;
    Zoom  : zglTPoint2D;
    Center: zglTPoint2D;
  end;

(*******************************************************************************
*                                begin memory                                  *
*******************************************************************************)
type
  zglPMemory = ^zglTMemory;
  zglTMemory = record
    Memory  : Pointer;
    Size    : LongWord;
    Position: LongWord;
  end;
(*******************************************************************************
*                                 end memory                                   *
*******************************************************************************)

(*******************************************************************************
*                               begin textures                                 *
*******************************************************************************)
const
  // текстуры
  TEX_FORMAT_RGBA       = $01;
  TEX_FORMAT_RGBA_4444  = $02;
  TEX_FORMAT_RGBA_PVR2  = $10;
  TEX_FORMAT_RGBA_PVR4  = $11;
  TEX_FORMAT_RGBA_DXT1  = $20;
  TEX_FORMAT_RGBA_DXT3  = $21;
  TEX_FORMAT_RGBA_DXT5  = $22;

  TEX_NO_COLORKEY       = $FF000000;

  TEX_MIPMAP            = $000001;
  TEX_CLAMP             = $000002;
  TEX_REPEAT            = $000004;
  TEX_COMPRESS          = $000008;

  TEX_CONVERT_TO_POT    = $000010;
  TEX_CALCULATE_ALPHA   = $000020;

  TEX_GRAYSCALE         = $000040;
  TEX_INVERT            = $000080;
  TEX_CUSTOM_EFFECT     = $000100;

  TEX_FILTER_NEAREST    = $000200;
  TEX_FILTER_LINEAR     = $000400;
  TEX_FILTER_BILINEAR   = $000800;
  TEX_FILTER_TRILINEAR  = $001000;
  TEX_FILTER_ANISOTROPY = $002000;

  TEXTURE_FILTER_CLEAR = $ffffff - (TEX_FILTER_NEAREST or TEX_FILTER_LINEAR or TEX_FILTER_BILINEAR or TEX_FILTER_TRILINEAR or
          TEX_FILTER_ANISOTROPY);

  TEX_DEFAULT_2D        = TEX_CLAMP or TEX_FILTER_LINEAR or TEX_CONVERT_TO_POT or TEX_CALCULATE_ALPHA;

type
  zglPTextureCoord = ^zglTTextureCoord;
  zglTTextureCoord = array[0..3] of zglTPoint2D;

  zglTTextureFileLoader = procedure(const FileName: UTF8String; out pData: PByteArray; out W, H, Format: Word);
  zglTTextureMemLoader  = procedure(const Memory: zglTMemory; out pData: PByteArray; out W, H, Format: Word);

  zglPTexture = ^zglTTexture;
  zglTTexture = record
    ID           : LongWord;
    Width, Height: Word;
    Format       : Word;
    U, V         : Single;
    FramesCoord  : array of zglTTextureCoord;
    Flags        : LongWord;

//    FrameID      : array of array [0..3] of Integer;

    prev, next   : zglPTexture;
  end;

  zglPTextureFormat = ^zglTTextureFormat;
  zglTTextureFormat = record
    Extension : UTF8String;
    FileLoader: zglTTextureFileLoader;
    MemLoader : zglTTextureMemLoader;
  end;

  zglPTextureManager = ^zglTTextureManager;
  zglTTextureManager = record
    Count  : record
      Items  : Integer;
      Formats: Integer;
              end;
    First  : zglTTexture;
    Formats: array of zglTTextureFormat;
  end;
(*******************************************************************************
*                                end textures                                  *
*******************************************************************************)

(*******************************************************************************
*                           POSIX TYPE DEFINITIONS                             *
*******************************************************************************)
type
  cint8   = shortint;    pcint8   = ^cint8;
  cuint8  = byte;        pcuint8  = ^cuint8;
  cchar   = cint8;       pcchar   = ^cchar;
  cschar  = cint8;       pcschar  = ^cschar;
  cuchar  = cuint8;      pcuchar  = ^cuchar;
  cint16  = smallint;    pcint16  = ^cint16;
  cuint16 = word;        pcuint16 = ^cuint16;
  cint32  = longint;     pcint32  = ^cint32;
  cuint32 = longword;    pcuint32 = ^cuint32;
  cint    = cint32;      pcint    = ^cint;
  csint   = cint32;      pcsint   = ^csint;
  cuint   = cuint32;     pcuint   = ^cuint;
  cuint64 = qword;       pcuint64 = ^cuint64;
  cint64  = int64;       pcint64  = ^cint64;
  cbool   = longbool;    pcbool   = ^cbool;
{$If defined(CPU64) and not defined(WINDOWS)}
  clong   = int64;
  cslong  = int64;
  culong  = qword;
{$Else}
  clong   = longint;
  cslong  = longint;
  culong  = cardinal;
{$IfEnd}
  pclong   = ^clong;
  pcslong  = ^cslong;
  pculong  = ^culong;
  cfloat  = single;      pcfloat  = ^cfloat;
  cdouble = double;      pcdouble = ^cdouble;

  csize_t = culong;

implementation

end.

