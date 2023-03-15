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
unit zgl_primitives_2d;

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
procedure pr2d_Pixel(X, Y: Single; {$IfNDef OLD_METHODS}numColor: LongWord{$Else}Color: LongWord; Alpha: Byte = 255{$EndIf});
// Rus: Линия с определённым цветом и указанием сглаживания (флаг FX = PR2D_SMOOTH).
// Eng: A line with a specific color and smoothing indication (FX flag = PR2D_SMOOTH).
procedure pr2d_Line(X1, Y1, X2, Y2: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX: LongWord = 0);
// Rus: Ломанная линия. Задаётся посредством множества точек. Points - указатель
//      на массив точек, count - количество точек, Color - цвет, флаг FX -
//      PR2D_SMOOTH (сглаживание), LINE_RGBA (отдельный цвет для каждой точки),
//      LINE_LOOP (зацикленная линия).
// Eng: Broken line. It is set by means of a set of points. Points - pointer to
//      point array, count - number of points, Color - color, FX flag -
//      PR2D_SMOOTH (smoothing), LINE_RGBA (separate color for each dot),
//      LINE_LOOP (looped line).
procedure pr2d_LineSORL(Points: Pointer; count: Cardinal; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf} FX: LongWord = 0);
// Rus: квадрат/прямоугольник с определённым цветом. Действующие флаги для FX
//      PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка),
//      FX2D_VCA (использование цвета для отдельных точек).
// Eng: square/rectangle with a specific color. Active flags for FX
//      PR2D_SMOOTH (smooth), PR2D_FILL (fill),
//      FX2D_VCA (use color for individual dots).
procedure pr2d_Rect(X, Y, W, H: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX: LongWord = 0 );
// Rus: Круг, где координата - центр вокруг которого описана окружность с данным
//      радиусом. Передаётся указанный цвет. Quality - "сглаживание" (количество
//      углов у окружности). Действующие флаги FX - PR2D_SMOOTH (сглаживание),
//      PR2D_FILL (заливка).
// Eng: A circle, where the coordinate is the center around which is described by
//      a circle with the specified radius. The specified color is transmitted.
//      Quality - "smoothing" (the number of corners of the circle). Active FX
//      flags - PR2D_SMOOTH (smoothing), PR2D_FILL (fill).
procedure pr2d_Circle(X, Y, Radius: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality: Word = 32; FX: LongWord = 0);
// Rus: Еллипс, где координата - центр. У эллипса два радиуса. Передаётся
//      указанный цвет. Quality - "сглаживание" (количество углов у окружности).
//      Действующие флаги FX - PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка).
// Eng: Ellipse, where the coordinate is the center. An ellipse has two radii.
//      The specified color is transmitted. Quality - "smoothing" (the number of
//      corners of the circle).
//      Valid FX flags - PR2D_SMOOTH (smooth), PR2D_FILL (fill).
procedure pr2d_Ellipse(X, Y, xRadius, yRadius: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality: Word = 32; FX: LongWord = 0);
// Rus: Треугольник с текстурой.
// Eng: Textured triangle.
procedure pr2d_TriList(Texture: zglPTexture; TriList, TexCoords: zglPPoints2D; iLo, iHi: Integer; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX: LongWord = FX_BLEND);
// Rus: Произвольный треугольник. Три координаты, цвет. Действующие флаги FX
//      PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка),
//      FX2D_VCA (использование цвета для отдельных точек).
// Eng: Arbitrary triangle. Three coordinates, color. Active FX Flags
//      PR2D_SMOOTH (smooth), PR2D_FILL (fill),
//      FX2D_VCA (use color for individual dots).
procedure pr2d_Triangle(X1, Y1, X2, Y2, X3, Y3: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
// Rus: произвольный четырёхугольник. Четыре координаты, цвет. Действующие флаги
//      PR2D_SMOOTH (сглаживание), PR2D_FILL (заливка),
//      FX2D_VCA (использование цвета для отдельных точек). Проверок на
//      пересечение линий не производится (вы можете получить "песочные часы").
//      Это правильное поведение. Координаты указываются точные.
// Eng: arbitrary quadrilateral. Four coordinates, color. Active flags
//      PR2D_SMOOTH (smooth), PR2D_FILL (fill), FX2D_VCA (use color for individual
//      dots). There are no checks for line crossings (you might end up with an
//      hourglass). This is the correct behavior. The coordinates are exact.
procedure pr2d_quad(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);

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

procedure pr2d_Pixel(X, Y: Single; {$IfNDef OLD_METHODS}numColor: LongWord{$Else}Color: LongWord; Alpha: Byte = 255{$EndIf});
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
end;

procedure pr2d_Line( X1, Y1, X2, Y2 : Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0 );
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

  X1 := X1 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
  Y1 := Y1 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
  X2 := X2 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
  Y2 := Y2 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};

  if FX and FX2D_VCA > 0 Then
  begin
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f(X1, Y1);
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f(X2, Y2);
  end else
  begin
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numColor);
    {$EndIf}
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
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

procedure pr2d_LineSORL(Points: Pointer; count: Cardinal; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf} FX: LongWord = 0);
var
  i: LongWord;
  PPoint:  zglPPoint2D;
  PPointColor: zglPPoint2DColor;
begin
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
    if (FX and LINE_LOOP) > 0 then
      glBegin(GL_LINE_LOOP)
    else
      glBegin(GL_LINE_STRIP);
  end;

  {$IfNDef OLD_METHODS}
  if FX and LINE_RGBA > 0 Then
  begin
    PPointColor := Points;
    for i := 0 to count - 1 do
    begin
      Set_ToNumColor(PPointColor.Color);
      glVertex2f(PPointColor^.X + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf}, PPointColor^.Y + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf});
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
    for i := 0 to count - 1 do
    begin
      glVertex2f( PPoint^.X + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf}, PPoint^.Y + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf} );
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

procedure pr2d_Rect(X, Y, W, H: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX: LongWord = 0);
var
  mode: LongWord;
  XW, YH: Single;
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
    if (FX and PR2D_FILL = 0) Then
    begin
      X := X + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
      Y := Y + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
      W := W - {$IfDef LINUX}rv_1{$Else}1{$EndIf};
      H := H - {$IfDef LINUX}rv_1{$Else}1{$EndIf};
    End;
    glBegin( mode );
  end;

  XW := X + W;
  YH := Y + H;

  if FX and FX2D_VCA > 0 Then
  begin
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f(X, Y);
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f(XW, Y);
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glVertex2f(XW, YH);
    if (FX and PR2D_FILL > 0) then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glVertex2f(XW, YH);
    end;
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
    glVertex2f(X, YH);
    if (FX and PR2D_FILL > 0) then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glVertex2f(X, Y);
    end;
  end else
  begin
    {$IfDef OLD_METHODS}
    glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
    {$Else}
    Set_ToNumColor(numColor);
    {$EndIf}
    glVertex2f(X, Y);
    glVertex2f(XW, Y);
    glVertex2f(XW, YH);
    if (FX and PR2D_FILL > 0) then
      glVertex2f(XW, Y + H);
    glVertex2f(X, YH);
    if (FX and PR2D_FILL > 0) then
      glVertex2f(X, Y);
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

procedure pr2d_Circle(X, Y, Radius: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality: Word = 32; FX: LongWord = 0);
var
  i : Integer;
  k : Single;
begin
  if Quality > 360 Then
    k := {$IfDef LINUX}rv_360{$Else}360{$EndIf}
  else
    k := {$IfDef LINUX}rv_360{$Else}360{$EndIf} / Quality;

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

procedure pr2d_Ellipse( X, Y, xRadius, yRadius : Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}Quality : Word = 32; FX : LongWord = 0 );
  var
    i : Integer;
    k : Single;
begin
  if Quality > 360 Then
    k := {$IfDef LINUX}rv_360{$Else}360{$EndIf}
  else
    k := {$IfDef LINUX}rv_360{$Else}360{$EndIf} / Quality;

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

procedure pr2d_TriList(Texture: zglPTexture; TriList, TexCoords: zglPPoints2D; iLo, iHi: Integer; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX: LongWord = FX_BLEND);
  var
    i    : Integer;
    w, h : Single;
    mode : LongWord;
begin
  if FX and PR2D_FILL > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_LINES;
  if ( not b2dStarted ) or batch2d_Check( mode, FX, Texture ) Then
    begin
      if FX and PR2D_SMOOTH > 0 Then
        begin
          glEnable( GL_LINE_SMOOTH    );
          {$IFNDEF USE_GLES}
          glEnable( GL_POLYGON_SMOOTH );
          {$ENDIF}
        end;
      if ( FX and FX_BLEND > 0 ) or ( mode = GL_LINES ) Then
        glEnable( GL_BLEND )
      else
        glEnable( GL_ALPHA_TEST );

      if Assigned( Texture ) and ( mode = GL_TRIANGLES ) Then
        begin
          glEnable( GL_TEXTURE_2D );
          glBindTexture( GL_TEXTURE_2D, Texture.ID );
        end;

      glBegin( mode );
    end;

  {$IfDef OLD_METHODS}
  glColor4f(((Color and $FF0000 ) shr 16) / 255, (( Color and $FF00 ) shr 8) / 255, (Color and $FF) / 255, Alpha / 255);
  {$Else}
  Set_ToNumColor(numColor);
  {$EndIf}

  if Assigned( Texture ) and ( mode = GL_TRIANGLES ) Then
    begin
      if not Assigned( TexCoords ) Then
        begin
          w := {$IfDef LINUX}rv_1{$Else}1{$EndIf} / ( Texture.Width / Texture.U );
          h := {$IfDef LINUX}rv_1{$Else}1{$EndIf} / ( Texture.Height / Texture.V );
          for i := iLo to iHi do
            begin
              glTexCoord2f( TriList[ i ].X * w, Texture.V - TriList[ i ].Y * h );
              glVertex2fv( @TriList[ i ] );
            end;
        end else
          for i := iLo to iHi do
            begin
              glTexCoord2fv( @TexCoords[ i ] );
              glVertex2fv( @TriList[ i ] );
            end;
    end else
      if Mode = GL_TRIANGLES Then
        begin
          for i := iLo to iHi do
            glVertex2fv( @TriList[ i ] );
        end else
          begin
            i := iLo;
            while i < iHi do
              begin
                glVertex2fv( @TriList[ i ] );
                glVertex2fv( @TriList[ i + 1 ] );
                INC( i );

                glVertex2fv( @TriList[ i ] );
                glVertex2fv( @TriList[ i + 1 ] );
                INC( i );

                glVertex2fv( @TriList[ i ] );
                glVertex2fv( @TriList[ i - 2 ] );
                INC( i );
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
      if mode = GL_TRIANGLES Then
        glDisable( GL_TEXTURE_2D );
      glDisable( GL_BLEND );
      glDisable( GL_ALPHA_TEST );
    end;
end;

procedure pr2d_Triangle(X1, Y1, X2, Y2, X3, Y3: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
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
    X1 := X1 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y1 := Y1 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    X2 := X2 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y2 := Y2 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    X3 := X3 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y3 := Y3 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    glBegin( mode );
  end;

  if FX and FX2D_VCA > 0 Then
  begin
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f(X1, Y1);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f(X2, Y2);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glVertex2f(X3, Y3);

    if (FX and PR2D_FILL = 0) then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
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

procedure pr2d_quad(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single; {$IfNDef OLD_METHODS}numColor: LongWord;{$Else}Color: LongWord; Alpha: Byte = 255;{$EndIf}FX : LongWord = 0);
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
    X1 := X1 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y1 := Y1 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    X2 := X2 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y2 := Y2 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    X3 := X3 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y3 := Y3 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    X4 := X4 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    Y4 := Y4 + {$IfDef LINUX}rv_0_5{$Else}0.5{$EndIf};
    glBegin( mode );
  end;

  if FX and FX2D_VCA > 0 Then
  begin
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glVertex2f(X1, Y1);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glVertex2f(X2, Y2);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glVertex2f(X3, Y3);

    if (FX and PR2D_FILL > 0) then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glVertex2f(X3, Y3);
    end;

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
    glVertex2f(X4, Y4);
    if (FX and PR2D_FILL > 0) then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
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
end;

end.
