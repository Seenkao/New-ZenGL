program demo05;

{$I zglCustomConfig.cfg}

{$R *.res}

uses
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_fx,
  zgl_render_2d,
  zgl_primitives_2d,
  zgl_math_2d,
  zgl_utils
  ;

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
    i : Integer;
begin
  // RU: Устанавливаем цвет и альфу для каждой вершины прямоугольника ( в данном случае)
  // EN: Set color and alpha for each vertex.
  fx2d_SetVCA( $FF0000, $00FF00, $0000FF, $FFFFFF, 255, 255, 255, 255 );
  // RU: Рисуем прямоугольник с заливкой(флаг PR2D_FILL) с использованием отдельных цветов для каждой вершины(флаг FX2D_VCA).
  // EN: Render filled rectangle(flag PR2D_FILL) and use different colors for each vertex(flag FX2D_VCA).
  pr2d_Rect(0, 0, 800, 600, $000000, 255, FX2D_VCA or PR2D_FILL);   // 4 + $010000

  // RU: Рисуем в центре экрана круг с радиусом 128 пиксела.
  // EN: Render circle in the center of screen with radius 128 pixels.
  pr2d_Circle( 400, 300, 128, $000000, 155, 32, PR2D_FILL );

  INC( calc );
  if calc > 359 Then calc := 0;
  points[ calc ].X := 400 + m_Cos( calc ) * ( 96 + random( 32 ) );
  points[ calc ].Y := 300 + m_Sin( calc ) * ( 96 + random( 32 ) );
  // RU: Рисуем линии внутри круга.
  // EN: Render lines inside the circle.

  for i := 0 to 359 do
    pr2d_Line( 400, 300, points[ i ].X, points[ i ].Y, $00FFFF, 255 );

  // RU: Рисуем эллипсы с заливкой и без, со сглаженными контурами(флаг PR2D_SMOOTH).
  // EN: Render filled ellipses with smoothed edges(flag PR2D_SMOOTH).
  pr2d_Ellipse( 400 + 300, 300, 64, 256, $FFFFFF, 128, 32, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 + 300, 300, 64, 256, $000000, 255, 32, PR2D_SMOOTH );

  pr2d_Ellipse( 400 - 300, 300, 64, 256, $FFFFFF, 128, 32, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 - 300, 300, 64, 256, $000000, 255, 32, PR2D_SMOOTH );
end;

procedure Timer;
begin
//  if key_Press( K_ESCAPE ) Then winOn := false;

  key_ClearState();
end;

Begin
  timer_Add( @Timer, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('05 - Primitives'));

  zgl_Init();
End.
