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

 !!! modification from Serge 16.07.2021
}
unit zgl_types;

{$I zgl_config.cfg}

interface

{$IFNDEF FPC}
type
  QWORD = UInt64;
{$ENDIF}

type
  Ptr = {$IFDEF CPU64} QWORD {$ELSE} LongWord {$ENDIF};

  PByteArray     = ^TByteArray;
  TByteArray     = array[0..High(LongWord) shr 1 - 1] of Byte;
  PWordArray     = ^TWordArray;
  TWordArray     = array[0..High(LongWord) shr 2 - 1] of Word;
  PLongWordArray = ^TLongWordArray;
  TLongWordArray = array[0..High(LongWord) shr 3 - 1] of LongWord;

type
  zglPTexCoordIndex = ^zglTTexCoordIndex;
  zglTTexCoordIndex = array[0..3] of Integer;

type
  zglTStringList = record
    Count: Integer;
    Items: array of UTF8String;
  end;

  zglPColor = ^zglTColor;
  zglTColor = record
    R, G, B, A: Single;
  end;

//------------------------- primitives -------------------------------//
type
  zglPPoint2D = ^zglTPoint2D;
  zglTPoint2D = record
    X, Y: Single;
  end;

  zglPPoints2D = ^zglTPoints2D;
  zglTPoints2D = array[0..0] of zglTPoint2D;

  zglPLine2D = ^zglTLine2D;
  // то же самое что и вектор
  zglTLine2D = record
    x1, y1: Single;
    x2, y2: Single;
  end;

  zglPVector2D = ^zglTVector2D;
  // добавил для вектора, чтоб не путались
  zglTVector2D = record
    x1, y1: Single;
    x2, y2: Single;
  end;

  zglPLine3D = ^zglTLine3D;
  // то же самое что и вектор
  zglTLine3D = record
    x1, y1: Single;
    x2, y2: Single;
    x3, y3: Single;
  end;

  zglPVector3D = ^zglTVector3D;
  // добавил для вектора, чтоб не путались
  zglTVector3D = record
    x1, y1: Single;
    x2, y2: Single;
    x3, y3: Single;
  end;

  zglPRect = ^zglTRect;
  // это только для прямоугольника
  zglTRect = record
    X, Y, W, H: Single;
  end;

  zglPRectPoints = ^zglTRectPoints;
  // произвольный четырёхугольник
  zglTRectPoints = record
    x1, y1, x2, y2: Single;
    x3, y3, x4, y4: Single;
  end;

  zglPWordRect = ^zglTWordRect;
  // это только для прямоугольника
  zglTWordRect = record
    X, Y, W, H: Word;
  end;

  zglPCircle = ^zglTCircle;
  zglTCircle = record
    cX, cY: Single;
    Radius: Single;
  end;
//-------------------- end primitives ---------------------------------//

{***********************************************************************}
{                       POSIX TYPE DEFINITIONS                          }
{***********************************************************************}
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
{$If defined(CPUx86_64) and not defined(WINDOWS)}
  clong   = int64;    pclong   = ^clong;
  cslong  = int64;    pcslong  = ^cslong;
  culong  = qword;    pculong  = ^culong;
{$Else}
  clong   = longint;  pclong   = ^clong;
  cslong  = longint;  pcslong  = ^cslong;
  culong  = cardinal; pculong  = ^culong;
{$IfEnd}
  cfloat  = single;   pcfloat  = ^cfloat;
  cdouble = double;   pcdouble = ^cdouble;

  csize_t = culong;

implementation

end.

