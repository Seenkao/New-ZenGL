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

 !!! modification from Serge 22.11.2021
}
unit zgl_collision_2d;

{$I zgl_config.cfg}

interface

uses
  zgl_types,
  zgl_math_2d;

// point 2d
// Rus: пересечение точки и квадрата. Край учитывается.
// Eng: intersection of a point and a square. The edge is taken into account.
function col2d_PointInRect(X, Y: Single; const Rect: zglTRect2D): Boolean;
// Rus: пересечение точки и треугольника. Край учитывается.
// Eng: intersection of a point and a triangle. The edge is taken into account.
function col2d_PointInTriangle(X, Y: Single; const P1, P2, P3: zglTPoint2D): Boolean;
// Rus: пересечение точки и круга. Край учитывается.
// Eng: intersection of a point and a circle. The edge is taken into account.
function col2d_PointInCircle(X, Y: Single; const Circle: zglTCircle2D): Boolean;
// Rus: пересечение точки и произвольного четырёхугольника. Проверить работу!!!
// Eng: intersection of a point and an arbitrary quadrilateral.
function col2d_PointInQuad(X, Y: Single; Quad: zglTRectPoints2D): Boolean;

// line 2d
// Rus: пересечение линий.
// Eng: line intersection.
function col2d_Line(const A, B: zglTLine2D; ColPoint: zglPPoint2D): Boolean;
// Rus: пересечение линий, без вычисления точки пересечения.
// Eng: line intersection, without calculating the intersection point.
function col2d_Lines(const A, B: zglTLine2D): Boolean;
// Rus: пересечение линии с  квадратом.
// Eng: intersection of a line with a square.
function col2d_LineVsRect(const Line: zglTLine2D; const Rect: zglTRect2D): Boolean;
// Rus: пересечение линии с кругом.
// Eng: intersection of a line with a circle.
function col2d_LineVsCircle(const Line: zglTLine2D; const Circle: zglTCircle2D): Boolean;

// rect
// Rus: пересечение квадратов.
// Eng: intersection of squares.
function col2d_Rect(const Rect1, Rect2: zglTRect2D): Boolean;
// Begin point - End point.
// Rus: пересечение квадратов. У квадратов заданы начальные и конечные координаты.
// Eng: intersection of squares. The squares have start and end coordinates.
function col2d_RectBPEP(const Rect1, Rect2: zglTRectBPEP2D): Boolean;
// Rus: обрезание первого квадрата по второму.
// Eng: cutting off the first square by the second.
function col2d_ClipRect(const Rect1, Rect2: zglTRect2D): zglTRect2D;
// Rus: квадрат точно внутри квадрата.
// Eng: the square is exactly inside the square.
function col2d_RectInRect(const Rect1, Rect2: zglTRect2D): Boolean;
// Rus: квадрат точно в круге.
// Eng: the square is exactly inside the circle.
function col2d_RectInCircle(const Rect: zglTRect2D; const Circle: zglTCircle2D): Boolean;
// Rus: пересечение квадрата с кругом.
// Eng: intersection of a square with a circle.
function col2d_RectVsCircle(const Rect: zglTRect2D; const Circle: zglTCircle2D): Boolean;

// circle
// Rus: пересечение кругов.
// Eng: circle intersection.
function col2d_Circle(const Circle1, Circle2: zglTCircle2D): Boolean;
// Rus: круг точно внутри круга.
// Eng: the circle is exactly inside the circle.
function col2d_CircleInCircle(const Circle1, Circle2: zglTCircle2D): Boolean;
// Rus: круг точно внутри квадрата.
// Eng: the circle is exactly inside the square.
function col2d_CircleInRect(const Circle: zglTCircle2D; const Rect: zglTRect2D): Boolean;

implementation

function col2d_PointInRect(X, Y: Single; const Rect: zglTRect2D): Boolean;
begin
  Result := (X >= Rect.X) and (X <= Rect.X + Rect.W) and (Y >= Rect.Y) and (Y <= Rect.Y + Rect.H);
end;

function col2d_PointInTriangle(X, Y: Single; const P1, P2, P3: zglTPoint2D): Boolean;
var
  o1: Integer;
  o2: Integer;
  o3: Integer;
begin
  o1 := m_Orientation(X, Y, P1.x, P1.y, P2.x, P2.y);
  o2 := m_Orientation(X, Y, P2.x, P2.y, P3.x, P3.y);

  if (o1 * o2) <> -1 Then
  begin
    o3 := m_Orientation(X, Y, P3.x, P3.y, P1.x, P1.y);
    if (o1 = o3) or (o3 = 0) Then
      Result := TRUE
    else
      if o1 = 0 Then
        Result := (o2 * o3) >= 0
      else
        if o2 = 0 Then
          Result := (o1 * o3) >= 0
        else
          Result := FALSE;
  end else
      Result := FALSE;
end;

function col2d_PointInCircle(X, Y: Single; const Circle: zglTCircle2D): Boolean;
begin
  Result := sqr(Circle.cX - X) + sqr(Circle.cY - Y) <= sqr(Circle.Radius);
end;

function col2d_PointInQuad(X, Y: Single; Quad: zglTRectPoints2D): Boolean;
var
  oAll: array[0..3] of Integer;
begin
  Result := false;
  // выявить куда направляется ориентация, для того чтоб понимать куда направлять вектора/точки
  // после выявления ориентации, надо проверять, с той ли стороны находится точка (но это позже)
  oAll[0] := m_Orientation(X, Y, Quad.x1, Quad.y1, Quad.x2, Quad.y2);
  if oAll[0] < 0 then
    exit;
  oAll[1] := m_Orientation(X, Y, Quad.x2, Quad.y2, Quad.x3, Quad.y3);
  if oAll[1] < 0 then
    exit;
  oAll[2] := m_Orientation(X, Y, Quad.x3, Quad.y3, Quad.x4, Quad.y4);
  if oAll[2] < 0 then
    exit;
  oAll[3] := m_Orientation(X, Y, Quad.x4, Quad.y4, Quad.x1, Quad.y1);
  if oAll[3] < 0 then
    exit;

  Result := True;
end;

function col2d_Line(const A, B: zglTLine2D; ColPoint: zglPPoint2D): Boolean;
var
  s, t, tmp: Single;
  s1, s2   : array[0..1] of Single;
begin
  Result := FALSE;

  s1[0] := A.x2 - A.x1;
  s1[1] := A.y2 - A.y1;
  s2[0] := B.x2 - B.x1;
  s2[1] := B.y2 - B.y1;

  tmp := -s2[0] * s1[1] + s1[0] * s2[1];
  if tmp <> 0 Then
    tmp := 1 / tmp
  else
    exit;

  s := (-s1[1] * (A.x1 - B.x1) + s1[0] * (A.y1 - B.y1)) * tmp;
  t := (s2[0] * (A.y1 - B.y1) - s2[1] * (A.x1 - B.x1)) * tmp;

  if (s >= 0) and (s <= 1) and (t >= 0) and (t <= 1) Then
  begin
    if Assigned(ColPoint) Then
    begin
      ColPoint.X := A.x1 + t * s1[0];
      ColPoint.Y := A.y1 + t * s1[1];
    end;

    Result := TRUE;
  end;
end;

function col2d_Lines(const A, B: zglTLine2D): Boolean;
var
  s, t, tmp: Single;
  s1, s2   : array[0..1] of Single;
begin
  Result := FALSE;

  s1[0] := A.x2 - A.x1;
  s1[1] := A.y2 - A.y1;
  s2[0] := B.x2 - B.x1;
  s2[1] := B.y2 - B.y1;

  tmp := -s2[0] * s1[1] + s1[0] * s2[1];
  if tmp <> 0 Then
    tmp := 1 / tmp
  else
    exit;

  s := (-s1[1] * (A.x1 - B.x1) + s1[0] * (A.y1 - B.y1)) * tmp;
  t := (s2[0] * (A.y1 - B.y1) - s2[1] * (A.x1 - B.x1)) * tmp;

  if (s >= 0) and (s <= 1) and (t >= 0) and (t <= 1) Then
  begin
    Result := TRUE;
  end;
end;

function col2d_LineVsRect(const Line: zglTLine2D; const Rect: zglTRect2D): Boolean;
var
  minX, maxX, minY, maxY, dx, a, b, tmp: Single;
begin
  minX := Line.x1;
  maxX := Line.x2;

  if minX > maxX Then
  begin
    maxX := minX;
    minX := Line.x2;
  end;

  if maxX > Rect.X + Rect.W Then
    maxX := Rect.X + Rect.W;

  if minX < Rect.X Then
    minX := Rect.X;

  if minX > maxX Then
  begin
    Result := FALSE;
    exit;
  end;

  minY := Line.y1;
  maxY := Line.y2;

  dx := Line.x2 - Line.x1;

  if abs(dx) > EPS Then
  begin
    a    := (Line.y2 - Line.y1) / dx;
    b    := Line.y1 - a * Line.x1;
    minY := a * minX + b;
    maxY := a * maxX + b;
  end;

  if minY > maxY Then
  begin
    tmp  := maxY;
    maxY := minY;
    minY := tmp;
  end;

  if maxY > Rect.Y + Rect.H Then
    maxY := Rect.Y + Rect.H;

  if minY < Rect.Y Then
    minY := Rect.Y;

  if minY > maxY Then
  begin
    Result := FALSE;
    exit;
  end;

  Result := TRUE;
end;

function col2d_LineVsCircle(const Line: zglTLine2D; const Circle: zglTCircle2D): Boolean;
var
  p1, p2 : array[0..1] of Single;
  dx, dy : Single;
  a, b, c: Single;
begin
  p1[0] := Line.x1 - Circle.cX;
  p1[1] := Line.y2 - Circle.cY;
  p2[0] := Line.x2 - Circle.cX;
  p2[1] := Line.y2 - Circle.cY;

  dx := p2[0] - p1[0];
  dy := p2[1] - p1[1];

  a := sqr(dx) + sqr(dy);
  b := (p1[0] * dx + p1[1] * dy) * 2;
  c := sqr(p1[0]) + sqr(p1[1]) - sqr(Circle.Radius);

  if -b < 0 Then
    Result := c < 0
  else
    if -b < a * 2 Then
      Result := a * c * 4 - sqr(b)  < 0
    else
      Result := a + b + c < 0;
end;

function col2d_Rect(const Rect1, Rect2: zglTRect2D): Boolean;
begin
  Result := (Rect1.X + Rect1.W >= Rect2.X) and (Rect1.X <= Rect2.X + Rect2.W) and (Rect1.Y + Rect1.H >= Rect2.Y) and (Rect1.Y <= Rect2.Y + Rect2.H);
end;

function col2d_RectBPEP(const Rect1, Rect2: zglTRectBPEP2D): Boolean;
begin
  Result := (Rect1.X2 >= Rect2.X1) and (Rect1.X1 <= Rect2.X2) and (rect1.Y2 >= Rect2.Y1) and (Rect1.Y1 <= Rect2.Y2);
end;

function col2d_ClipRect(const Rect1, Rect2: zglTRect2D): zglTRect2D;
begin
  if (Rect1.X < Rect2.X) or (Rect1.X > Rect2.X + Rect2.W) Then
    Result.X := Rect2.X
  else
    Result.X := Rect1.X;
  if (Rect1.Y < Rect2.Y) or (Rect1.Y > Rect2.Y + Rect2.H) Then
    Result.Y := Rect2.Y
  else
    Result.Y := Rect1.Y;

  Result.W := (Rect1.X + Rect1.W) - Result.X;
  Result.H := (Rect1.Y + Rect1.H) - Result.Y;

  if Result.X + Result.W > Rect2.X + Rect2.W Then
    Result.W := (Rect2.X + Rect2.W) - Result.X - 1;
  if Result.Y + Result.H > Rect2.Y + Rect2.H Then
    Result.H := (Rect2.Y + Rect2.H) - Result.Y - 1;
end;

function col2d_RectInRect(const Rect1, Rect2: zglTRect2D): Boolean;
begin
  Result := (Rect1.X >= Rect2.X) and (Rect1.X + Rect1.W <= Rect2.X + Rect2.W) and (Rect1.Y >= Rect2.Y) and (Rect1.Y + Rect1.H <= Rect2.Y + Rect2.H);
end;

function col2d_RectInCircle(const Rect: zglTRect2D; const Circle: zglTCircle2D): Boolean;
var
  sqrRadius, dX, dY: Single;
  sqrDX, sqrDY, sqrDXsubDW, sqrDYsubDH: Single;
begin
  sqrRadius := sqr(Circle.Radius);
  dX        := Circle.cX - Rect.X;
  dY        := Circle.cY - Rect.Y;

  sqrDX := sqr(dX);                  sqrDY := sqr(dY);
  sqrDXsubDW := sqr(dX - Rect.W);    sqrDYsubDH := sqr(dY - Rect.H);
(*  Result := (sqr(dX) + sqr(dY) <= sqrRadius) and (sqr(dX - Rect.W) + sqr(dY) <= sqrRadius) and
            (sqr(dX - Rect.W) + sqr(dY - Rect.H) <= sqrRadius) and (sqr(dX) + sqr(dY - Rect.H) <= sqrRadius);      *)
  Result := ((sqrDX + sqrDY) <= sqrRadius) and ((sqrDXsubDW + sqrDY) <= sqrRadius) and
            ((sqrDXsubDW + sqrDYsubDH) <= sqrRadius) and ((sqrDX + sqrDYsubDH) <= sqrRadius);
end;

function col2d_RectVsCircle(const Rect: zglTRect2D; const Circle: zglTCircle2D): Boolean;
var
  closestX, closestY, distanceX, distanceY: Single;
begin
  closestX := Circle.cX;
  if Circle.cX <= Rect.X Then
    closestX := Rect.X
  else
    if Circle.cX > Rect.X + Rect.W Then
      closestX := Rect.X + Rect.W;

  closestY := Circle.cY;
  if Circle.cY <= Rect.X Then
    closestY := Rect.Y
  else
    if Circle.cY > Rect.Y + Rect.H Then
      closestY := Rect.Y + Rect.H;

  distanceX := Circle.cX - closestX;
  distanceY := Circle.cY - closestY;

  Result := sqr(distanceX) + sqr(distanceY) < sqr(circle.Radius);
end;

function col2d_Circle(const Circle1, Circle2: zglTCircle2D): Boolean;
begin
  Result := sqr(Circle1.cX - Circle2.cX) + sqr(Circle1.cY - Circle2.cY) <= sqr(Circle1.Radius + Circle2.Radius);
end;

function col2d_CircleInCircle(const Circle1, Circle2: zglTCircle2D): Boolean;
begin
  Result := sqr(Circle1.cX - Circle2.cX) + sqr(Circle1.cY - Circle2.cY) <= sqr(Circle1.Radius - Circle2.Radius);
end;

function col2d_CircleInRect(const Circle: zglTCircle2D; const Rect: zglTRect2D): Boolean;
begin
  Result := (Circle.cX - Circle.Radius >= Rect.X) and (Circle.cX + Circle.Radius <= Rect.X + Rect.W) and
            (Circle.cY - Circle.Radius >= Rect.Y) and (Circle.cY + Circle.Radius <= Rect.Y + Rect.H);
end;

end.

