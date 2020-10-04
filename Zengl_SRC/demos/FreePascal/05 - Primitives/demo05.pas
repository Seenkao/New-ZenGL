program demo05;

{$I zglCustomConfig.cfg}

uses
  {$IFDEF USE_ZENGL_STATIC}
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_fx,
  zgl_render_2d,
  zgl_primitives_2d,
  zgl_math_2d,
  zgl_utils
  {$ELSE}
  zglHeader
  {$ENDIF}
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
  // RU: Устанавливаем цвет и альфу для каждой вершины.
  // EN: Set color and alpha for each vertex.
  fx2d_SetVCA( $FF0000, $00FF00, $0000FF, $FFFFFF, 255, 255, 255, 255 );
  // RU: Рисуем прямоугольник с заливкой(флаг PR2D_FILL) с использованием отдельных цветов для каждой вершины(флаг FX2D_VCA).
  // EN: Render filled rectangle(flag PR2D_FILL) and use different colors for each vertex(flag FX2D_VCA).
  pr2d_Rect( 0, 0, 800, 600, $000000, 255, FX2D_VCA or PR2D_FILL );

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
    pr2d_Line( 400, 300, points[ i ].X, points[ i ].Y, $FFFFFF, 255 );

  // RU: Рисуем эллипсы с заливкой и без, со сглаженными контурами(флаг PR2D_SMOOTH).
  // EN: Render filled ellipses with smoothed edges(flag PR2D_SMOOTH).
  pr2d_Ellipse( 400 + 300, 300, 64, 256, $FFFFFF, 55, 32, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 + 300, 300, 64, 256, $000000, 255, 32, PR2D_SMOOTH );

  pr2d_Ellipse( 400 - 300, 300, 64, 256, $FFFFFF, 55, 32, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 - 300, 300, 64, 256, $000000, 255, 32, PR2D_SMOOTH );
end;

procedure Timer;
begin
  if key_Press( K_ESCAPE ) Then zgl_Exit();

  key_ClearState();
end;

Begin
  {$IFNDEF USE_ZENGL_STATIC}
  if not zglLoad( libZenGL ) Then exit;
  {$ENDIF}

  timer_Add( @Timer, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption( '05 - Primitives' );

  wnd_ShowCursor( TRUE );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, FALSE, FALSE );

  zgl_Init();
End.
