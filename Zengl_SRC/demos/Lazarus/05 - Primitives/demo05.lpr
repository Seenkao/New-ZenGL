program demo05;

{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

{$IFDEF WINDOWS}
  {$R *.res}
{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IfDef USE_ZENGL_STATIC}
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_fx,
  zgl_render_2d,
  zgl_primitives_2d,
  zgl_types,
  zgl_math_2d,
  gegl_color,
  zgl_utils
  {$Else}
  zglHeader
  {$EndIf}
  ;

var
  calc   : Integer;
  points : array[ 0..359 ] of zglTPoint2D;
  TimeStart  : Byte = 0;
  {$IfNDef OLD_METHODS}
  dirRes : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  newColor: array[0..1] of LongWord;
  {$EndIf}

procedure Init;
var
  i : Integer;
begin
  for i := 0 to 359 do
  begin
    points[ i ].X := 400 + m_Cos( i ) * ( 96 + random( 32 ) );
    points[ i ].Y := 300 + m_Sin( i ) * ( 96 + random( 32 ) );
  end;
  {$IfNDef OLD_METHODS}
  // Rus: устанавливаем новый цвет. Которого нет в списке стандартных. Константы в gegl_color.
  // Eng:
  newColor[0] := Color_FindOrAdd($0000009B);
  newColor[1] := Color_FindOrAdd($FFFFFF4B);
  {$EndIf}
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
  pr2d_Rect( 0, 0, 800, 600, {$IfDef OLD_METHODS}$000000, 255{$Else}cl_Black{$EndIf}, FX2D_VCA or PR2D_FILL );

  // RU: Рисуем в центре экрана круг с радиусом 128 пиксела.
  // EN: Render circle in the center of screen with radius 128 pixels.
  pr2d_Circle( 400, 300, 128, {$IfDef OLD_METHODS}$000000, 155{$Else}newColor[0]{$EndIf}, 32, PR2D_FILL );

  // RU: Рисуем линии внутри круга.
  // EN: Render lines inside the circle.
  for i := 0 to 359 do
    pr2d_Line( 400, 300, points[ i ].X, points[ i ].Y, {$IfDef OLD_METHODS}$FFFFFF, 255{$Else}cl_White{$EndIf} );

  // RU: Рисуем эллипсы с заливкой и без, со сглаженными контурами(флаг PR2D_SMOOTH).
  // EN: Render filled ellipses with smoothed edges(flag PR2D_SMOOTH).
  pr2d_Ellipse( 400 + 300, 300, 64, 256, {$IfDef OLD_METHODS}$FFFFFF, 75{$Else}newColor[1]{$EndIf}, 64, PR2D_FILL or PR2D_SMOOTH );
  pr2d_Ellipse( 400 + 300, 300, 64, 256, {$IfDef OLD_METHODS}$000000, 255{$Else}cl_Black{$EndIf}, 32, PR2D_SMOOTH );

  pr2d_Ellipse( 400 - 300, 300, 64, 256, {$IfDef OLD_METHODS}$FFFFFF, 75{$Else}newColor[1]{$EndIf}, 64, PR2D_FILL{ or PR2D_SMOOTH });
  pr2d_Ellipse( 400 - 300, 300, 64, 256, {$IfDef OLD_METHODS}$000000, 255{$Else}cl_Black{$EndIf}, 32, PR2D_SMOOTH );
end;

procedure Timer;
begin
  INC( calc );
  if calc > 359 Then
    calc := 0;
  points[ calc ].X := 400 + m_Cos( calc ) * ( 96 + random( 32 ) );
  points[ calc ].Y := 300 + m_Sin( calc ) * ( 96 + random( 32 ) );
end;

Begin
  {$IFNDEF USE_ZENGL_STATIC}
  if not zglLoad( libZenGL ) Then exit;
  {$ENDIF}
  TimeStart := timer_Add( @Timer, 16, t_Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('05 - Primitives'));

  zgl_Init();
End.
