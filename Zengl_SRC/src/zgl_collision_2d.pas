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
}
unit zgl_collision_2d;

{$I zgl_config.cfg}

interface

uses
  zgl_types,
  zgl_math_2d;

// point 2d
function col2d_PointInRect(X, Y: Single; const Rect: zglTRect): Boolean;
function col2d_PointInTriangle(X, Y: Single; const P1, P2, P3: zglTPoint2D): Boolean;
function col2d_PointInCircle(X, Y: Single; const Circle: zglTCircle): Boolean;

// line 2d
function col2d_Line(const A, B: zglTLine; ColPoint: zglPPoint2D): Boolean;
function col2d_LineVsRect(const Line: zglTLine; const Rect: zglTRect): Boolean;
function col2d_LineVsCircle(const Line: zglTLine; const Circle: zglTCircle): Boolean;

// rect
function col2d_Rect(const Rect1, Rect2: zglTRect): Boolean;
function col2d_ClipRect(const Rect1, Rect2: zglTRect): zglTRect;
function col2d_RectInRect(const Rect1, Rect2: zglTRect): Boolean;
function col2d_RectInCircle(const Rect: zglTRect; const Circle: zglTCircle): Boolean;
function col2d_RectVsCircle(const Rect: zglTRect; const Circle: zglTCircle): Boolean;
// circle
function col2d_Circle(const Circle1, Circle2: zglTCircle): Boolean;
function col2d_CircleInCircle(const Circle1, Circle2: zglTCircle): Boolean;
function col2d_CircleInRect(const Circle: zglTCircle; const Rect: zglTRect): Boolean;

implementation

function col2d_PointInRect(X, Y: Single; const Rect: zglTRect): Boolean;
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

function col2d_PointInCircle(X, Y: Single; const Circle: zglTCircle): Boolean;
begin
  Result := sqr(Circle.cX - X) + sqr(Circle.cY - Y) <= sqr(Circle.Radius);
end;

function col2d_Line(const A, B: zglTLine; ColPoint: zglPPoint2D): Boolean;
  var
    s, t, tmp: Single;
    s1, s2   : array[0..1] of Single;
begin
  Result := FALSE;

  s1[0] := A.x1 - A.x0;
  s1[1] := A.y1 - A.y0;
  s2[0] := B.x1 - B.x0;
  s2[1] := B.y1 - B.y0;

  tmp := -s2[0] * s1[1] + s1[0] * s2[1];
  if tmp <> 0 Then
    tmp := 1 / tmp
  else
    exit;

  s := (-s1[1] * (A.x0 - B.x0) + s1[0] * (A.y0 - B.y0)) * tmp;
  t := (s2[0] * (A.y0 - B.y0) - s2[1] * (A.x0 - B.x0)) * tmp;

  if (s >= 0) and (s <= 1) and (t >= 0) and (t <= 1) Then
    begin
      if Assigned(ColPoint) Then
        begin
          ColPoint.X := A.x0 + t * s1[0];
          ColPoint.Y := A.y0 + t * s1[1];
        end;

      Result := TRUE;
    end;
end;

function col2d_LineVsRect(const Line: zglTLine; const Rect: zglTRect): Boolean;
  var
    minX, maxX, minY, maxY, dx, a, b, tmp: Single;
begin
  minX := Line.x0;
  maxX := Line.x1;

  if minX > maxX Then
    begin
      maxX := minX;
      minX := Line.x1;
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

  minY := Line.y0;
  maxY := Line.y1;

  dx := Line.x1 - Line.x0;

  if abs(dx) > EPS Then
    begin
      a    := (Line.y1 - Line.y0) / dx;
      b    := Line.y0 - a * Line.x0;
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

function col2d_LineVsCircle(const Line: zglTLine; const Circle: zglTCircle): Boolean;
  var
    p1, p2 : array[0..1] of Single;
    dx, dy : Single;
    a, b, c: Single;
begin
  p1[0] := Line.x0 - Circle.cX;
  p1[1] := Line.y0 - Circle.cY;
  p2[0] := Line.x1 - Circle.cX;
  p2[1] := Line.y1 - Circle.cY;

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

function col2d_Rect(const Rect1, Rect2: zglTRect): Boolean;
begin
  Result := (Rect1.X + Rect1.W >= Rect2.X) and (Rect1.X <= Rect2.X + Rect2.W) and (Rect1.Y + Rect1.H >= Rect2.Y) and (Rect1.Y <= Rect2.Y + Rect2.H);
end;

function col2d_ClipRect(const Rect1, Rect2: zglTRect): zglTRect;
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

function col2d_RectInRect(const Rect1, Rect2: zglTRect): Boolean;
begin
  Result := (Rect1.X >= Rect2.X) and (Rect1.X + Rect1.W <= Rect2.X + Rect2.W) and (Rect1.Y >= Rect2.Y) and (Rect1.Y + Rect1.H <= Rect2.Y + Rect2.H);
end;

function col2d_RectInCircle(const Rect: zglTRect; const Circle: zglTCircle): Boolean;
  var
    sqrRadius, dX, dY: Single;
begin
  sqrRadius := sqr(Circle.Radius);
  dX        := Circle.cX - Rect.X;
  dY        := Circle.cY - Rect.Y;

  Result := (sqr(dX) + sqr(dY) <= sqrRadius) and (sqr(dX - Rect.W) + sqr(dY) <= sqrRadius) and
            (sqr(dX - Rect.W) + sqr(dY - Rect.H) <= sqrRadius) and (sqr(dX) + sqr(dY - Rect.H) <= sqrRadius);
end;

function col2d_RectVsCircle(const Rect: zglTRect; const Circle: zglTCircle): Boolean;
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

function col2d_Circle(const Circle1, Circle2: zglTCircle): Boolean;
begin
  Result := sqr(Circle1.cX - Circle2.cX) + sqr(Circle1.cY - Circle2.cY) <= sqr(Circle1.Radius + Circle2.Radius);
end;

function col2d_CircleInCircle(const Circle1, Circle2: zglTCircle): Boolean;
begin
  Result := sqr(Circle1.cX - Circle2.cX) + sqr(Circle1.cY - Circle2.cY) <= sqr(Circle1.Radius - Circle2.Radius);
end;

function col2d_CircleInRect(const Circle: zglTCircle; const Rect: zglTRect): Boolean;
begin
  Result := (Circle.cX - Circle.Radius >= Rect.X) and (Circle.cX + Circle.Radius <= Rect.X + Rect.W) and
            (Circle.cY - Circle.Radius >= Rect.Y) and (Circle.cY + Circle.Radius <= Rect.Y + Rect.H);
end;

end.
