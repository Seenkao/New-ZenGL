program circle;

uses
  zgl_main,
  zgl_screen,
  zgl_application,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_fx,
  zgl_opengl_all,
  zgl_render_2d,
  zgl_primitives_2d,
  zgl_math_2d,
  zgl_utils;

var
  calc   : Integer;
  points : array[ 0..359 ] of zglTPoint2D;

procedure Init;
  var
    i : Integer;
begin
  for i := 0 to 359 do
    begin
      points[ i ].X := 400 + m_Cos( i ) * ( 96 + random( 32 ) );
      points[ i ].Y := 300 + m_Sin( i ) * ( 96 + random( 32 ) );
    end;
end;

procedure Draw;
var
  i, k2, x, y, R: Integer;
  dx, dy: Single;
begin
  // RU: Устанавливаем цвет и альфу для каждой вершины.
  // EN: Set color and alpha for each vertex.
  fx2d_SetVCA( $a0f080, $a0f080, $a0f08F, $aFff8F, 255, 255, 255, 255 );
  // RU: Рисуем прямоугольник с заливкой(флаг PR2D_FILL) с использованием отдельных цветов для каждой вершины(флаг FX2D_VCA).
  // EN: Render filled rectangle(flag PR2D_FILL) and use different colors for each vertex(flag FX2D_VCA).
  pr2d_Rect( 0, 0, 800, 600, $000000, 255, FX2D_VCA or PR2D_FILL );

  // RU: Рисуем в центре экрана круг с радиусом 128 пиксела.
  // EN: Render circle in the center of screen with radius 128 pixels.
  pr2d_Circle( 200, 300, 130, $000000, 155, 360, PR2D_FILL );

  x := 300;
  y := 300;
  R := 30;
  dx := 0;
  dy := R;
  k2 := 0;
  glColor4f(255, 0, 0, 1);
  glEnable(GL_BLEND);
//  glBegin(GL_LINES);         // если просто окружность, не залитая
  while dy >= 0 do
  begin
    if (k2 and 1) > 0 then
    begin
      dy := dy - 1;
      dx := sqrt(sqr(R) - sqr(dy));
    end
    else begin
      dx := dx + 1;
      dy := sqrt(sqr(R) - sqr(dx));
      if dy < dx then
      begin
        k2 := 1;
        dy := round(dy);
      end;
    end;
    glBegin(GL_POINTS);
      glVertex3f(x + (dx - 0.5), y + (dy - 0.5), 0);                // up
      glVertex3f(x + (dx - 0.5), y - (dy - 0.5), 0);                // down
      glVertex3f(x - (dx - 0.5), y + (dy - 0.5), 0);                // up
      glVertex3f(x - (dx - 0.5), y - (dy - 0.5), 0);                // down
    glEnd;
  end;

  x := 500;
  y := 300;
  R := 30;
  dx := 0;
  dy := R;
  k2 := 0;
  glColor4f(32 / 255, 16 / 255, 16 / 255, 1);
  glColor4ub(0, 0, 0, 1);
  glEnable(GL_BLEND);
//  glBegin(GL_LINES);         // если просто окружность, не залитая
  while dy >= 0 do
  begin
    if (k2 and 1) > 0 then
    begin
      dy := dy - 1;
      dx := sqrt(sqr(R) - sqr(dy));
    end
    else begin
      dx := dx + 1;
      dy := sqrt(sqr(R) - sqr(dx));
      if dy < dx then
      begin
        k2 := 1;
        dy := round(dy);
      end;
    end;
    glBegin(GL_LINES);
      glVertex3f(x - (dx - 0.5), y + (dy - 0.5), 0);                     // OpenGL !!!! ++++
      glVertex3f(x - (dx - 0.5), y - (dy - 0.5), 0);                     // OpenGLES  -----
      glVertex3f(x + (dx - 0.5), y + (dy - 0.5), 0);
      glVertex3f(x + (dx - 0.5), y - (dy - 0.5), 0);
    glEnd;
  end;

  // RU: Рисуем эллипсы с заливкой и без, со сглаженными контурами(флаг PR2D_SMOOTH).
  // EN: Render filled ellipses with smoothed edges(flag PR2D_SMOOTH).
{  pr2d_Ellipse( 400 + 300, 300, 64, 256, $FFFFFF, 55, 32, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 + 300, 300, 64, 256, $000000, 255, 32, PR2D_SMOOTH );

  pr2d_Ellipse( 400 - 300, 300, 64, 256, $FFFFFF, 55, 32, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 - 300, 300, 64, 256, $000000, 255, 32, PR2D_SMOOTH );          }
end;

procedure Timer;
begin
  if key_Press( K_ESCAPE ) Then winOn := False;

  key_ClearState();
end;

begin
  timer_Add( @Timer, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wndCaption := utf8_Copy('05 - Primitives');

  zgl_Init();
end.

