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
// *** zgl_Reg ***
  SYS_APP_INIT           = $000001;
  SYS_LOAD               = $000003;
  SYS_DRAW               = $000004;
  SYS_UPDATE             = $000005;
  SYS_EXIT               = $000006;
  SYS_ACTIVATE           = $000007;

  SYS_EVENTS             = $000009;         // keyboard, mouse, touchpad
  SYS_KEYESCAPE          = $000008;         // перехват клавиши Escape
  SYS_POSTDRAW           = $000012;         // процедура постотрисовки (после того как вывелось всё на экран)
  SYS_RESET              = $000013;         // процедура обнуления
  {$IfNDef ANDROID}
  SYS_CLOSE_QUERY        = $000008;
  SYS_APP_LOOP           = $000002;
  {$EndIf}
  OGL_USER_MODE          = $000014;
  OGL_VIEW_PORT          = $000016;
  {$IFDEF iOS}
  SYS_iOS_MEMORY_WARNING     = $000010;
  SYS_iOS_CHANGE_ORIENTATION = $000011;
  {$ENDIF}
  {$IFDEF ANDROID}
  SYS_ANDROID_RESTORE = $000015;
  {$ENDIF}

  TEXTURE_FORMAT_EXTENSION   = $000100;     // расширение файла
  TEXTURE_FORMAT_FILE_LOADER = $000101;     // процедура загрузки
  TEXTURE_FORMAT_MEM_LOADER  = $000102;     // процедура загрузки из памяти
  TEXTURE_CURRENT_EFFECT     = $000103;     // процедура дополнительных эффектов

  SND_FORMAT_EXTENSION    = $000110;
  SND_FORMAT_FILE_LOADER  = $000111;
  SND_FORMAT_MEM_LOADER   = $000112;
  SND_FORMAT_DECODER      = $000113;

  VIDEO_FORMAT_DECODER    = $000130;

// *** zgl_Get ***
  ZENGL_VERSION           = 1;              // Major shr 16, ( Minor and $FF00 ) shr 8, Revision and $FF
  ZENGL_VERSION_STRING    = 2;              // PAnsiChar
  ZENGL_VERSION_DATE      = 3;              // PAnsiChar

  DIRECTORY_APPLICATION   = 101;            // PAnsiChar
  DIRECTORY_HOME          = 102;            // PAnsiChar

  LOG_FILENAME            = 203;            // PAnsiChar

  DESKTOP_WIDTH           = 300;
  DESKTOP_HEIGHT          = 301;
  RESOLUTION_LIST         = 302;            // zglPResolutionList

  WINDOW_HANDLE           = 400;            // TWindow(GNU/Linux), HWND(Windows), WindowRef(MacOS X)
  WINDOW_X                = 401;
  WINDOW_Y                = 402;
  WINDOW_WIDTH            = 403;
  WINDOW_HEIGHT           = 404;

  GAPI_CONTEXT            = 500;            // GLXContext(GNU/Linux), HGLRC(Windows), TAGLContext(MacOS X)
  GAPI_MAX_TEXTURE_SIZE   = 501;            // For ZenGL with Direct3D render only
  GAPI_MAX_TEXTURE_UNITS  = 502;
  GAPI_MAX_ANISOTROPY     = 503;
  GAPI_CAN_BLEND_SEPARATE = 504;            // Boolean
  GAPI_CAN_AUTOGEN_MIPMAP = 505;            // Boolean

  VIEWPORT_WIDTH          = 600;
  VIEWPORT_HEIGHT         = 601;
  VIEWPORT_OFFSET_X       = 602;
  VIEWPORT_OFFSET_Y       = 603;

  RENDER_FPS              = 700;
  RENDER_BATCHES_2D       = 701;
  RENDER_CURRENT_MODE     = 702;
  RENDER_CURRENT_TARGET   = 703;
  RENDER_VRAM_USED        = 704;

  MANAGER_TIMER           = 800;            // zglPTimerManager
  MANAGER_TEXTURE         = 801;            // zglPTextureManager
  MANAGER_FONT            = 802;            // zglPFontManager
  MANAGER_RTARGET         = 803;            // zglPRenderTargetManager
  MANAGER_SOUND           = 804;            // zglPSoundManager
  MANAGER_EMITTER2D       = 805;            // zglPEmitter2DManager

// *** zgl_Enable/zgl_Disable ***
  COLOR_BUFFER_CLEAR    = $000001;
  DEPTH_BUFFER          = $000002;
  DEPTH_BUFFER_CLEAR    = $000004;
  DEPTH_MASK            = $000008;
  STENCIL_BUFFER_CLEAR  = $000010;          // не активируется ни где.
  CORRECT_RESOLUTION    = $000020;
  CORRECT_WIDTH         = $000040;
  CORRECT_HEIGHT        = $000080;
  APP_USE_AUTOPAUSE     = $000100;
  APP_USE_LOG           = $000200;
  APP_USE_ENGLISH_INPUT = $000400;
  APP_USE_DT_CORRECTION = $000800;
  WND_USE_AUTOCENTER    = $001000;
  SND_CAN_PLAY          = $002000;
  SND_CAN_PLAY_FILE     = $004000;
  CLIP_INVISIBLE        = $008000;
  {$IFDEF iOS}
  SND_ALLOW_BACKGROUND_MUSIC = $100000;
  {$ENDIF}
  XY_IN_CENTER_WINDOW   = $020000;          // окно выводится от центра экрана когда oglMode = Mode2D
                                            // при этом надо перерабатывать прорисовку примитивов
                                            // весь ZenGL сделан от края окна, могут быть не состыковки.

// *** timer ***
  // биты работы с таймером
  t_Stop         =   1;                     // таймер останавливается незамедлительно
  t_Start        =   2;                     // таймер создаётся и стартует незамедлительно
  t_Tiks         =   4;                     // используется только внутри таймеров!
  t_SleepToStart =   8;                     // таймер создаётся и запускается с установленной задержкой
  t_SleepToStop  =  16;                     // таймер останавливается через определённое время

// *** mouse and touch ***
  M_BLEFT       = 0;
  {$IfNDef MOBILE}
  M_BMIDDLE     = 1;
  M_BRIGHT      = 2;
  {$Else}
  M_BMIDDLE     = 2;
  M_BRIGHT      = 1;
  {$EndIf}
  MAX_TOUCH      = 10;

// *** OpenGL ***
  ModeUser       = 1;                       // MatrixMode
  Mode2D         = 2;
  Mode3D         = 3;
  {$IfDef MACOSX}
  CORE_2_1 = 1;
  CORE_3_2 = 2;
  CORE_4_1 = 3;
  {$EndIf}
  CORE_VERSION = 1;                         // совместимость с текущей версией и выше
  COMPATIBILITY_VERSION = 2;                // совместимость с ранними версиями. Нельзя использовать для GL 3.2
  GL_DEBUG = 4;                             // отладка контекста включена
  GL_FORWARD_COMPATIBLE = 8;                // вперёд совместимый контекст.

// *** primitives ***
  PR2D_FILL   = $010000;
  PR2D_SMOOTH = $020000;
  LINE_RGBA   = $040000;
  LINE_LOOP   = $080000;

// *** working with files ***
  FILE_ERROR = {$IFNDEF WINDOWS} 0 {$ELSE} Ptr(-1) {$ENDIF};

  // Open Mode
  FOM_CREATE = $01;                         // Create
  FOM_OPENR  = $02;                         // Read
  FOM_OPENW  = $03;                         // Write
  FOM_OPENRW = $04;                         // Read&Write


  // Seek Mode
  FSM_SET    = $01;
  FSM_CUR    = $02;
  FSM_END    = $03;

// *** Keyboard ***
  K_SYSRQ      = $B7;
  K_PAUSE      = $C5;
  K_ESCAPE     = $01;
  K_ENTER      = $1C;
  K_KP_ENTER   = $9C;

  K_UP         = $C8;
  K_DOWN       = $D0;
  K_LEFT       = $CB;
  K_RIGHT      = $CD;

  K_BACKSPACE  = $0E;
  K_SPACE      = $39;
  K_TAB        = $0F;
  K_TILDE      = $29;

  K_INSERT     = $D2;
  K_DELETE     = $D3;
  K_HOME       = $C7;
  K_END        = $CF;
  K_PAGEUP     = $C9;
  K_PAGEDOWN   = $D1;

  K_CTRL       = $FF - $01;
  K_CTRL_L     = $1D;
  K_CTRL_R     = $9D;
  K_ALT        = $FF - $02;
  K_ALT_L      = $38;
  K_ALT_R      = $B8;
  K_SHIFT      = $FF - $03;
  K_SHIFT_L    = $2A;
  K_SHIFT_R    = $36;
  K_SUPER      = $FF - $04;
  K_SUPER_L    = $DB;
  K_SUPER_R    = $DC;
  K_APP_MENU   = $DD;

  K_CAPSLOCK   = $3A;
  K_NUMLOCK    = $45;
  K_SCROLL     = $46;

  K_BRACKET_L  = $1A; // [{
  K_BRACKET_R  = $1B; //] }
  K_BACKSLASH  = $2B; // \
  K_SLASH      = $35; // /
  K_SEPARATOR  = $33; // ,
  K_DECIMAL    = $34; // .
  K_SEMICOLON  = $27; //: ;
  K_APOSTROPHE = $28; // ' "

  K_0          = $0B;
  K_1          = $02;
  K_2          = $03;
  K_3          = $04;
  K_4          = $05;
  K_5          = $06;
  K_6          = $07;
  K_7          = $08;
  K_8          = $09;
  K_9          = $0A;

  K_MINUS      = $0C;
  K_EQUALS     = $0D;

  K_A          = $1E;
  K_B          = $30;
  K_C          = $2E;
  K_D          = $20;
  K_E          = $12;
  K_F          = $21;
  K_G          = $22;
  K_H          = $23;
  K_I          = $17;
  K_J          = $24;
  K_K          = $25;
  K_L          = $26;
  K_M          = $32;
  K_N          = $31;
  K_O          = $18;
  K_P          = $19;
  K_Q          = $10;
  K_R          = $13;
  K_S          = $1F;
  K_T          = $14;
  K_U          = $16;
  K_V          = $2F;
  K_W          = $11;
  K_X          = $2D;
  K_Y          = $15;
  K_Z          = $2C;

  K_KP_0       = $52;
  K_KP_1       = $4F;
  K_KP_2       = $50;
  K_KP_3       = $51;
  K_KP_4       = $4B;
  K_KP_5       = $4C;
  K_KP_6       = $4D;
  K_KP_7       = $47;
  K_KP_8       = $48;
  K_KP_9       = $49;

  K_KP_SUB     = $4A;
  K_KP_ADD     = $4E;
  K_KP_MUL     = $37;
  K_KP_DIV     = $B5;
  K_KP_DECIMAL = $53;

  K_F1         = $3B;
  K_F2         = $3C;
  K_F3         = $3D;
  K_F4         = $3E;
  K_F5         = $3F;
  K_F6         = $40;
  K_F7         = $41;
  K_F8         = $42;
  K_F9         = $43;
  K_F10        = $44;
  K_F11        = $57;
  K_F12        = $58;

  // основные события происходящие между интервалами очистки клавиатуры
  KA_DOWN      = 0;
  KA_UP        = 1;
  // события происходящие только при нажатии/отжатии клавиш
  KT_DOWN      = 2;
  KT_UP        = 3;

// *** Joystick ***
  JOY_HAS_Z   = $000001;
  JOY_HAS_R   = $000002;
  JOY_HAS_U   = $000004;
  JOY_HAS_V   = $000008;
  JOY_HAS_POV = $000010;

  JOY_AXIS_X = 0;
  JOY_AXIS_Y = 1;
  JOY_AXIS_Z = 2;
  JOY_AXIS_R = 3;
  JOY_AXIS_U = 4;
  JOY_AXIS_V = 5;
  JOY_POVX   = 6;
  JOY_POVY   = 7;

// *** ??? ***
  REFRESH_MAXIMUM = 0;
  REFRESH_DEFAULT = 1;
// *** GL ***
  TARGET_SCREEN  = 1;                       // цель - экран
  TARGET_TEXTURE = 2;                       // цель - часть экрана

// *** Render targets ***
  RT_DEFAULT      = $00;
  RT_FULL_SCREEN  = $01;
  RT_USE_DEPTH    = $02;
  RT_CLEAR_COLOR  = $04;
  RT_CLEAR_DEPTH  = $08;
  RT_SAVE_CONTENT = $10;                    // Direct3D only!

// FX
  FX_BLEND_NORMAL = $00;
  FX_BLEND_ADD    = $01;
  FX_BLEND_MULT   = $02;
  FX_BLEND_BLACK  = $03;
  FX_BLEND_WHITE  = $04;
  FX_BLEND_MASK   = $05;

  FX_COLOR_MIX    = $00;
  FX_COLOR_SET    = $01;

  FX_BLEND        = $100000;
  FX_COLOR        = $200000;

// FX 2D
  // Rus: отражение по X.
  // Eng: reflection on X.
  FX2D_FLIPX      = $000001;
  // Rus: отражение по Y.
  // Eng: reflection on Y.
  FX2D_FLIPY      = $000002;
  FX2D_VCA        = $000004;
  FX2D_VCHANGE    = $000008;
  FX2D_SCALE      = $000010;
  FX2D_RPIVOT     = $000020;



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

// *** files ***
  zglTFile     = Ptr;
  zglTFileList = zglTStringList;

// *** timer ***
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

// *** Joystick ***
  zglPJoyInfo = ^zglTJoyInfo;
  zglTJoyInfo = record
    Name  : UTF8String;
    Count : record
      Axes   : Integer;
      Buttons: Integer;
    end;
    Caps  : LongWord;
  end;

// *** Color ***
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

// *** Render targets ***
  zglPRenderTarget = ^zglTRenderTarget;
  zglTRenderTarget = record
    Type_     : Byte;
    Handle    : Pointer;
    Surface   : zglPTexture;
    Flags     : Byte;

    prev, next: zglPRenderTarget;
  end;

  zglPRenderTargetManager = ^zglTRenderTargetManager;
  zglTRenderTargetManager = record
    Count: Integer;
    First: zglTRenderTarget;
  end;

  zglTRenderCallback = procedure(Data: Pointer);

(*******************************************************************************
*                           POSIX TYPE DEFINITIONS                             *
*******************************************************************************)
type
  cint8   = shortint; pcint8   = ^cint8;
  cuint8  = byte;     pcuint8  = ^cuint8;
  cchar   = cint8;    pcchar   = ^cchar;
  cschar  = cint8;    pcschar  = ^cschar;
  cuchar  = cuint8;   pcuchar  = ^cuchar;
  cint16  = smallint; pcint16  = ^cint16;
  cuint16 = word;     pcuint16 = ^cuint16;
  cint32  = longint;  pcint32  = ^cint32;
  cuint32 = longword; pcuint32 = ^cuint32;
  cint    = cint32;   pcint    = ^cint;
  csint   = cint32;   pcsint   = ^csint;
  cuint   = cuint32;  pcuint   = ^cuint;
  cuint64 = qword;    pcuint64 = ^cuint64;
  cint64  = int64;    pcint64  = ^cint64;
  cbool   = longbool; pcbool   = ^cbool;
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
  cfloat  = single;   pcfloat  = ^cfloat;
  cdouble = double;   pcdouble = ^cdouble;

  csize_t = culong;

implementation

end.

