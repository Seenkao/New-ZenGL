{
 *  Copyright (c) 2022 SSW
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
unit zgl_primitives_2dEX;

{$I zgl_config.cfg}

interface
uses
  zgl_fx,
  zgl_textures,
  zgl_math_2d,
  zgl_gltypeconst,
  zgl_types,
  {$IfNDef OLD_METHODS}
  gegl_color
  {$EndIf}
  ;


// Rus: Точка с определёнными координатами и цветом.
// Eng: A point with specified coordinates and color.
// procedure pr2d_PixelEX(X, Y: Single; {$IfNDef OLD_METHODS}numColor: LongWord{$Else}Color: LongWord; Alpha: Byte = 255{$EndIf});

// Rus: Линия с определённым цветом и указанием сглаживания (флаг FX = PR2D_SMOOTH).
// Eng: A line with a specific color and smoothing indication (FX flag = PR2D_SMOOTH).
procedure pr2d_LineEX(X1, Y1, X2, Y2: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color1, Color2: LongWord; Alpha: Byte = 255;{$EndIf}
          WidthLine: LongWord = 2; FX: LongWord = 0);
// Rus: Ломанная линия. Задаётся посредством множества точек. Points - указатель
//      на массив точек, count - количество точек, Color - цвет, флаг FX -
//      PR2D_SMOOTH (сглаживание), LINE_RGBA (отдельный цвет для каждой точки).
//      Надо обратить внимание, что LINE_LOOP (зацикленная линия) в данной
//      процедуре не работает. Для зацикленной линии используйте последнюю точку
//      равную начальной.
//      Если
// Eng: Broken line. It is set by means of a set of points. Points - pointer to
//      point array, count - number of points, Color - color, FX flag -
//      PR2D_SMOOTH (smoothing), LINE_RGBA (separate color for each dot).
//      LINE_LOOP (looped line).
procedure pr2d_LineStripEX(Points: Pointer; count: Cardinal; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color1, Color2: LongWord; Alpha: Byte = 255;{$EndIf}
          WidthLine: LongWord = 2; FX: LongWord = 0);
// Rus: квадрат/прямоугольник с определённым цветом и широким бордюром.
//      Действующие флаги для FX PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка),
//      FX2D_VCA (использование цвета для отдельных точек). Если флаг FX2D_VCA
//      включен, то ColOrFlag - это флаг который укажет какую часть квадрата мы
//      заливаем разным цветом. ColOrFlag > 0 - внтуреннюю часть.
// Eng: square/rectangle with a specific color. Active flags for FX
//      PR2D_SMOOTH (smooth), PR2D_FILL (fill),
//      FX2D_VCA (use color for individual dots).
procedure pr2d_RectEX(X, Y, W, H: Single; {$IfNDef OLD_METHODS}numCol, ColOrFlag: LongWord;{$Else}Color, ColOrFlag: LongWord; Alpha: Byte = 255;{$EndIf}
          WidthLine: LongWord = 2; FX: LongWord = 0 );
(* // Rus: Круг, где координата - центр вокруг которого описана окружность с данным
//      радиусом. Передаётся указанный цвет. Quality - "сглаживание" (количество
//      углов у окружности). Действующие флаги FX - PR2D_SMOOTH (сглаживание),
//      PR2D_FILL (заливка).
// Eng: A circle, where the coordinate is the center around which is described by
//      a circle with the specified radius. The specified color is transmitted.
//      Quality - "smoothing" (the number of corners of the circle). Active FX
//      flags - PR2D_SMOOTH (smoothing), PR2D_FILL (fill).
procedure pr2d_CircleEX(X, Y, Radius: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality: Word = 32; FX: LongWord = 0);
// Rus: Еллипс, где координата - центр. У эллипса два радиуса. Передаётся
//      указанный цвет. Quality - "сглаживание" (количество углов у окружности).
//      Действующие флаги FX - PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка).
// Eng: Ellipse, where the coordinate is the center. An ellipse has two radii.
//      The specified color is transmitted. Quality - "smoothing" (the number of
//      corners of the circle).
//      Valid FX flags - PR2D_SMOOTH (smooth), PR2D_FILL (fill).
procedure pr2d_EllipseEX(X, Y, xRadius, yRadius: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality: Word = 32; FX: LongWord = 0);
// Rus: Произвольный треугольник. Три координаты, цвет. Действующие флаги FX
//      PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка),
//      FX2D_VCA (использование цвета для отдельных точек).
// Eng: Arbitrary triangle. Three coordinates, color. Active FX Flags
//      PR2D_SMOOTH (smooth), PR2D_FILL (fill),
//      FX2D_VCA (use color for individual dots).
procedure pr2d_TriangleEX(X1, Y1, X2, Y2, X3, Y3: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
// Rus: произвольный четырёхугольник. Четыре координаты, цвет. Действующие флаги
//      PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка),
//      FX2D_VCA (использование цвета для отдельных точек). Проверок на
//      пересечение линий не производится (вы можете получить "песочные часы").
//      Это правильное поведение. Координаты указываются точные.
// Eng: arbitrary quadrilateral. Four coordinates, color. Active flags
//      PR2D_SMOOTH (smooth), PR2D_FILL (fill), FX2D_VCA (use color for individual
//      dots). There are no checks for line crossings (you might end up with an
//      hourglass). This is the correct behavior. The coordinates are exact.
procedure pr2d_quadEX(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
*)

implementation
uses
  {$IFNDEF USE_GLES}
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles_all,
  {$ENDIF}
  zgl_render_2d;

{$IfDef LINUX}
var
  rv_0_5: Single = 0.5;
  rv_1: Single = 1;
  rv_360: Single = 360;
{$EndIf}

(*procedure pr2d_PixelEX(X, Y: Single; {$IfNDef OLD_METHODS}numColor: LongWord{$Else}Color: LongWord; Alpha: Byte = 255{$EndIf});
begin
  if ( not b2dStarted ) or batch2d_Check( GL_POINTS, FX_BLEND, nil ) Then
  begin
    glEnable( GL_BLEND );
    glBegin( GL_POINTS );
  end;

  {$IfDef OLD_METHODS}
  glColor4ub( ( Color and $FF0000 ) shr 16, ( Color and $FF00 ) shr 8, Color and $FF, Alpha );
  {$Else}
  Set_ToNumColor(numColor);
  {$EndIf}
  glVertex2f(X + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf}, Y + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf});

  if not b2dStarted Then
  begin
    glEnd();
    glDisable( GL_BLEND );
  end;
end;          *)

procedure pr2d_LineEX(X1, Y1, X2, Y2 : Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color1, Color2: LongWord; Alpha: Byte = 255;{$EndIf}
          WidthLine: LongWord = 2; FX : LongWord = 0);
var
  dx, dy, c, cc, da1, db1: Single;
  xx1, xx2, yy1, yy2, xx3, xx4, yy3, yy4: Single;
begin
  if (x1 = x2) and (y1 = y2) then
    Exit;
  if ( not b2dStarted ) or batch2d_Check( GL_LINES, FX_BLEND or FX, nil ) Then
  begin
    if FX and PR2D_SMOOTH > 0 Then
    begin
      glEnable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glEnable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glEnable( GL_BLEND );

    glBegin( GL_QUADS );
  end;

  dx := (X2 - X1);            // это А
  dy := (Y2 - Y1);            // это Б

  c := Sqrt(sqr(dx) + sqr(dy));    // гипотенуза
  cc := WidthLine / (2 * c);       // согласно формуле это заданная ширина делённая на общую гипотенузу
                                   // точнее это дальнейшее продолжение гипотенузы, на заданную ширину
                                   // делённую на 2!!! Как так? Для этого надо рассматривать получаемый прямоугольник...
//  c := WidthLine / (2 * c) ;

//  da1 := dx / cc * c;
//  db1 := dy / cc * c;
  da1 := dx * cc;
  db1 := dy * cc;

  c := db1 - da1;

  xx1 := x1 + c;
  yy2 := y2 + c;
  xx3 := x2 - c;
  yy4 := y1 - c;

  c := db1 + da1;
  xx2 := x2 + c;
  yy3 := y2 + c;
  xx4 := x1 - c;
  yy1 := y1 - c;

  if FX and FX2D_VCA > 0 Then
  begin
    glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f( xx2, yy2);
    glVertex2f( xx3, yy3);
    glColor4f(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f( xx4, yy4);
    glVertex2f( xx1, yy1);
  end else
  begin
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numColor);
    {$EndIf}
    glVertex2f( xx1, yy1);
    glVertex2f( xx2, yy2);
    glVertex2f( xx3, yy3);
    glVertex2f( xx4, yy4);
  end;

  if not b2dStarted Then
  begin
    glEnd();

    if FX and PR2D_SMOOTH > 0 Then
    begin
      glDisable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glDisable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glDisable( GL_BLEND );
  end;
end;

procedure pr2d_LineStripEX(Points: Pointer; count: Cardinal; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}
          WidthLine: LongWord = 2; FX: LongWord = 0);
var
  i: LongWord;
  PPoint:  zglPPoint2D;
  PPointColor: zglPPoint2DColor;
  dx, dy, c, cc, da1, db1: Single;
  xx1, xx2, yy1, yy2, xx3, xx4, yy3, yy4: Single;
  X1, X2, Y1, Y2: Single;

  procedure twoPointToFour;
  begin
    dx := (X2 - X1);
    dy := (Y2 - Y1);

    c := Sqrt(sqr(dx) + sqr(dy));
    cc := WidthLine / (2 * c);

    da1 := dx * cc;
    db1 := dy * cc;

    c := db1 - da1;

    xx1 := x1 + c;
    yy2 := y2 + c;
    xx3 := x2 - c;
    yy4 := y1 - c;

    c := db1 + da1;
    xx2 := x2 + c;
    yy3 := y2 + c;
    xx4 := x1 - c;
    yy1 := y1 - c;
  end;

begin
  // доделать процедуру для скруглённых краёв и обрезки линии по конечным точкам. А так же для обрезанных линий произвести соединение, дабы
  // не было пробелов.
  if count < 2 then
    Exit;
  if ( not b2dStarted ) or batch2d_Check( GL_LINES, FX_BLEND or FX, nil ) Then
  begin
    if FX and PR2D_SMOOTH > 0 Then
    begin
      glEnable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glEnable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glEnable( GL_BLEND );
    // в данном варианте только параллелограммы рисуем.
    glBegin(GL_QUADS);
  end;

  {$IfNDef OLD_METHODS}
  if FX and LINE_RGBA > 0 Then
  begin
    PPointColor := Points;
    X1 := PPointColor^.X;
    Y1 := PPointColor^.y;
    numColor := PPointColor^.Color;
    inc(PPointColor);
    for i := 1 to count - 1 do
    begin
      X2 := PPointColor^.X;
      Y2 := PPointColor^.y;
      if (x2 = x1) and (y2 = y1) then
        Continue;
      twoPointToFour;
      Set_ToNumColor(PPointColor^.Color);
      glVertex2f(xx2, yy2);
      glVertex2f(xx3, yy3);
      Set_ToNumColor(numColor);
      glVertex2f(xx4, yy4);
      glVertex2f(xx1, yy1);
      X1 := X2;
      Y1 := Y2;
      numColor := PPointColor^.Color;
      inc(PPointColor);
    end;
  end else
  {$EndIf}
  begin
    PPoint := Points;
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numColor);
    {$EndIf}
    X1 := PPoint^.X;
    Y1 := PPoint^.Y;
    inc(PPoint);
    for i := 1 to count - 1 do
    begin
      X2 := PPoint^.X;
      Y2 := PPoint^.Y;
      if (x2 = x1) and (y2 = y1) then
        Continue;
      twoPointToFour;
      glVertex2f(xx2, yy2);
      glVertex2f(xx3, yy3);
      glVertex2f(xx4, yy4);
      glVertex2f(xx1, yy1);
      X1 := X2;
      Y1 := Y2;
      inc(PPoint);
    end;
  end;

  if not b2dStarted Then
  begin
    glEnd();

    if FX and PR2D_SMOOTH > 0 Then
    begin
      glDisable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glDisable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glDisable( GL_BLEND );
  end;
end;

procedure pr2d_RectEX(X, Y, W, H: Single; {$IfNDef OLD_METHODS}numCol, ColOrFlag: LongWord;{$Else}Color, ColOrFlag: LongWord; Alpha: Byte = 255;{$EndIf}
          WidthLine: LongWord = 2; FX: LongWord = 0);
var
  mode: LongWord;
  XW, YH: Single;
  xx1, yy1, xx2, yy2, x3, yy3, xx4, yy4: Single;
begin
  if (WidthLine >= W) or (WidthLine >= H) then
    exit;
  if ( not b2dStarted ) or batch2d_Check( mode, FX_BLEND or FX, nil ) Then
  begin
    if FX and PR2D_SMOOTH > 0 Then
    begin
      glEnable(GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glEnable(GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glEnable( GL_BLEND );
    glBegin(GL_QUADS);
  end;

  xx1 := X + WidthLine;
  yy1 := y + WidthLine;
  xx2 := X + W - WidthLine;
  yy2 := Y + H - WidthLine;
  XW := X + W;
  YH := Y + H;

  if (FX and FX2D_VCA > 0) then
  begin
    if (ColOrFlag = 0) Then
    begin
      glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glVertex2f(xx1, yy1);
      glVertex2f(X, Y);
      glColor4f(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
      glVertex2f(XW, Y);
      glVertex2f(xx2, yy1);

      glVertex2f(xx2, yy1);
      glVertex2f(XW, Y);
      glColor4f(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glVertex2f(XW, YH);
      glVertex2f(xx2, yy2);

      glVertex2f(xx2, yy2);
      glVertex2f(XW, YH);
      glColor4f(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
      glVertex2f(X, YH);
      glVertex2f(xx1, yy2);

      glVertex2f(xx1, yy2);
      glVertex2f(X, YH);
      glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glVertex2f(X, Y);
      glVertex2f(xx1, yy1);

      if (FX and PR2D_FILL > 0) then
      begin
        Set_ToNumColor(numCol);
        glVertex2f(xx1, yy1);
        glVertex2f(xx2, yy1);
        glVertex2f(xx2, yy2);
        glVertex2f(xx1, yy2);
      end;
    end
    else begin
      Set_ToNumColor(numCol);
      glVertex2f(xx1, yy1);
      glVertex2f(X, Y);
      glVertex2f(XW, Y);
      glVertex2f(xx2, yy1);

      glVertex2f(xx2, yy1);
      glVertex2f(XW, Y);
      glVertex2f(XW, YH);
      glVertex2f(xx2, yy2);

      glVertex2f(xx2, yy2);
      glVertex2f(XW, YH);
      glVertex2f(X, YH);
      glVertex2f(xx1, yy2);

      glVertex2f(xx1, yy2);
      glVertex2f(X, YH);
      glVertex2f(X, Y);
      glVertex2f(xx1, yy1);

      glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glVertex2f(xx1, yy1);
      glColor4f(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
      glVertex2f(xx2, yy1);
      glColor4f(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glVertex2f(xx2, yy2);
      glColor4f(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
      glVertex2f(xx1, yy2);
    end;
  end
  else
  begin
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numCol);
    {$EndIf}
    glVertex2f(xx1, yy1);
    glVertex2f(X, Y);
    glVertex2f(XW, Y);
    glVertex2f(xx2, yy1);

    glVertex2f(xx2, yy1);
    glVertex2f(XW, Y);
    glVertex2f(XW, YH);
    glVertex2f(xx2, yy2);

    glVertex2f(xx2, yy2);
    glVertex2f(XW, YH);
    glVertex2f(X, YH);
    glVertex2f(xx1, yy2);

    glVertex2f(xx1, yy2);
    glVertex2f(X, YH);
    glVertex2f(X, Y);
    glVertex2f(xx1, yy1);

    if (FX and PR2D_FILL > 0) then
    begin
      Set_ToNumColor(ColOrFlag);
      glVertex2f(xx1, yy1);
      glVertex2f(xx2, yy1);
      glVertex2f(xx2, yy2);
      glVertex2f(xx1, yy2);
    end;
  end;

  if not b2dStarted Then
  begin
    glEnd();

    if FX and PR2D_SMOOTH > 0 Then
    begin
      glDisable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glDisable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glDisable( GL_BLEND );
  end;
end;

(* procedure pr2d_CircleEX(X, Y, Radius: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality: Word = 32; FX: LongWord = 0);
var
  i : Integer;
  k : Single;
begin
  if Quality > 360 Then
    k := rv_360
  else
    k := rv_360 / Quality;

  if FX and PR2D_FILL = 0 Then
    begin
      if ( not b2dStarted ) or batch2d_Check( GL_LINES, FX_BLEND or FX, nil ) Then
        begin
          if FX and PR2D_SMOOTH > 0 Then
            begin
              glEnable( GL_LINE_SMOOTH    );
              {$IFNDEF USE_GLES}
              glEnable( GL_POLYGON_SMOOTH );
              {$ENDIF}
            end;
          glEnable( GL_BLEND );

          glBegin( GL_LINES );
        end;

      {$IfDef OLD_METHODS}
      glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
      {$Else}
      Set_ToNumColor(numColor);
      {$EndIf}
      for i := 0 to Quality - 1 do
        begin
          glVertex2f( X + Radius * cosTable[ Round( i * k ) ], Y + Radius * sinTable[ Round( i * k ) ] );
          glVertex2f( X + Radius * cosTable[ Round( ( i + 1 ) * k ) ], Y + Radius * sinTable[ Round( ( i + 1 ) * k ) ] );
        end;

      if not b2dStarted Then
        begin
          glEnd();

          if FX and PR2D_SMOOTH > 0 Then
            begin
              glDisable( GL_LINE_SMOOTH    );
              {$IFNDEF USE_GLES}
              glDisable( GL_POLYGON_SMOOTH );
              {$ENDIF}
            end;
          glDisable( GL_BLEND );
        end;
    end else
      begin
        if ( not b2dStarted ) or batch2d_Check( GL_TRIANGLES, FX_BLEND or FX, nil ) Then
          begin
            if FX and PR2D_SMOOTH > 0 Then
              begin
                glEnable( GL_LINE_SMOOTH    );
                {$IFNDEF USE_GLES}
                glEnable( GL_POLYGON_SMOOTH );
                {$ENDIF}
              end;
            glEnable( GL_BLEND );

            glBegin( GL_TRIANGLES );
          end;

        {$IfDef OLD_METHODS}
        glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
        {$Else}
        Set_ToNumColor(numColor);
        {$EndIf}
        for i := 0 to Quality - 1 do
          begin
            glVertex2f( X, Y );
            glVertex2f( X + Radius * cosTable[ Round( i * k ) ], Y + Radius * sinTable[ Round( i * k ) ] );
            glVertex2f( X + Radius * cosTable[ Round( ( i + 1 ) * k ) ], Y + Radius * sinTable[ Round( ( i + 1 ) * k ) ] );
          end;

        if not b2dStarted Then
          begin
            glEnd();

            if FX and PR2D_SMOOTH > 0 Then
              begin
                glDisable( GL_LINE_SMOOTH    );
                {$IFNDEF USE_GLES}
                glDisable( GL_POLYGON_SMOOTH );
                {$ENDIF}
              end;
            glDisable( GL_BLEND );
          end;
      end;
end;

procedure pr2d_EllipseEX( X, Y, xRadius, yRadius : Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality : Word = 32; FX : LongWord = 0 );
  var
    i : Integer;
    k : Single;
begin
  if Quality > 360 Then
    k := rv_360
  else
    k := rv_360 / Quality;

  if FX and PR2D_FILL = 0 Then
    begin
      if ( not b2dStarted ) or batch2d_Check( GL_LINES, FX_BLEND or FX, nil ) Then
      begin
        if FX and PR2D_SMOOTH > 0 Then
        begin
          glEnable( GL_LINE_SMOOTH    );
          {$IFNDEF USE_GLES}
          glEnable( GL_POLYGON_SMOOTH );
          {$ENDIF}
        end;
        glEnable( GL_BLEND );

        glBegin( GL_LINES );
      end;

      {$IfDef OLD_METHODS}
      glColor4f(((Color and $FF0000) shr 16) / 255, (( Color and $FF00) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
      {$Else}
      Set_ToNumColor(numColor);
      {$EndIf}
      for i := 0 to Quality - 1 do
      begin
        glVertex2f( X + xRadius * cosTable[ Round( i * k ) ], Y + yRadius * sinTable[ Round( i * k ) ] );
        glVertex2f( X + xRadius * cosTable[ Round( ( i + 1 ) * k ) ], Y + yRadius * sinTable[ Round( ( i + 1 ) * k ) ] );
      end;

      if not b2dStarted Then
      begin
        glEnd();

        if FX and PR2D_SMOOTH > 0 Then
        begin
          glDisable( GL_LINE_SMOOTH    );
          {$IFNDEF USE_GLES}
          glDisable( GL_POLYGON_SMOOTH );
          {$ENDIF}
        end;
        glDisable( GL_BLEND );
      end;
    end else
      begin
        if ( not b2dStarted ) or batch2d_Check( GL_TRIANGLE_FAN, FX_BLEND or FX, nil ) Then
          begin
            if FX and PR2D_SMOOTH > 0 Then
              begin
                glEnable( GL_LINE_SMOOTH    );
                {$IFNDEF USE_GLES}
                glEnable( GL_POLYGON_SMOOTH );
                {$ENDIF}
              end;
            glEnable( GL_BLEND );

            glBegin( GL_TRIANGLE_FAN );
          end;

        {$IfDef OLD_METHODS}
        glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
        {$Else}
        Set_ToNumColor(numColor);
        {$EndIf}
        glVertex2f( X, Y );
        for i := 0 to Quality - 1 do
        begin
          glVertex2f( X + xRadius * cosTable[ Round( i * k ) ], Y + yRadius * sinTable[ Round( i * k ) ] );
          glVertex2f( X + xRadius * cosTable[ Round( ( i + 1 ) * k ) ], Y + yRadius * sinTable[ Round( ( i + 1 ) * k ) ] );
        end;

        if not b2dStarted Then
          begin
            glEnd();

            if FX and PR2D_SMOOTH > 0 Then
              begin
                glDisable( GL_LINE_SMOOTH    );
                {$IFNDEF USE_GLES}
                glDisable( GL_POLYGON_SMOOTH );
                {$ENDIF}
              end;
            glDisable( GL_BLEND );
          end;
      end;
end;

procedure pr2d_TriangleEX(X1, Y1, X2, Y2, X3, Y3: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
var
  mode: LongWord;
begin
  if (FX and PR2D_FILL = 0) then
    mode := GL_LINE_LOOP
  else
    mode := GL_TRIANGLES;
  if ( not b2dStarted ) or batch2d_Check( mode, FX_BLEND or FX, nil ) Then
  begin
    if FX and PR2D_SMOOTH > 0 Then
    begin
      glEnable(GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glEnable(GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glEnable( GL_BLEND );
    X1 := X1 + rv_0_5;
    Y1 := Y1 + rv_0_5;
    X2 := X2 + rv_0_5;
    Y2 := Y2 + rv_0_5;
    X3 := X3 + rv_0_5;
    Y3 := Y3 + rv_0_5;
    glBegin( mode );
  end;

  if FX and FX2D_VCA > 0 Then
  begin
    glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f(X1, Y1);

    glColor4f(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f(X2, Y2);

    glColor4f(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glVertex2f(X3, Y3);

    if (FX and PR2D_FILL = 0) then
    begin
      glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glVertex2f(X1, Y1);
    end;
  end else
  begin
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numColor);
    {$EndIf}
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
    glVertex2f(X3, Y3);
    if (FX and PR2D_FILL = 0) then
      glVertex2f(X1, Y1);
  end;

  if not b2dStarted Then
  begin
    glEnd();

    if FX and PR2D_SMOOTH > 0 Then
    begin
      glDisable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glDisable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glDisable( GL_BLEND );
  end;
end;

procedure pr2d_quadEX(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
var
  mode: LongWord;
begin
  if (FX and PR2D_FILL = 0) then
    mode := GL_LINE_LOOP
  else
    mode := GL_TRIANGLES;
  if (not b2dStarted ) or batch2d_Check( mode, FX_BLEND or FX, nil) Then
  begin
    if FX and PR2D_SMOOTH > 0 Then
    begin
      glEnable(GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glEnable(GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glEnable( GL_BLEND );
    X1 := X1 + rv_0_5;
    Y1 := Y1 + rv_0_5;
    X2 := X2 + rv_0_5;
    Y2 := Y2 + rv_0_5;
    X3 := X3 + rv_0_5;
    Y3 := Y3 + rv_0_5;
    X4 := X4 + rv_0_5;
    Y4 := Y4 + rv_0_5;
    glBegin( mode );
  end;

  if FX and FX2D_VCA > 0 Then
  begin
    glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f(X1, Y1);

    glColor4f(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f(X2, Y2);

    glColor4f(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glVertex2f(X3, Y3);

    if (FX and PR2D_FILL > 0) then
    begin
      glColor4f(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glVertex2f(X3, Y3);
    end;

    glColor4f(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
    glVertex2f(X4, Y4);
    if (FX and PR2D_FILL > 0) then
    begin
      glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glVertex2f(X1, Y1);
    end;
  end else
  begin
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numColor);
    {$EndIf}
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
    glVertex2f(X3, Y3);
    if (FX and PR2D_FILL > 0) then
      glVertex2f(X3, Y3);
    glVertex2f(X4, Y4);
    if (FX and PR2D_FILL > 0) then
      glVertex2f(X1, Y1);
  end;

  if not b2dStarted Then
  begin
    glEnd();

    if FX and PR2D_SMOOTH > 0 Then
    begin
      glDisable( GL_LINE_SMOOTH    );
      {$IFNDEF USE_GLES}
      glDisable( GL_POLYGON_SMOOTH );
      {$ENDIF}
    end;
    glDisable( GL_BLEND );
  end;
end; *)

end.
