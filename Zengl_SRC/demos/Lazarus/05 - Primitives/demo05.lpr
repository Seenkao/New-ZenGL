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
  zgl_primitives_2dEX,
  zgl_types,
  zgl_math_2d,
  {$IfNDef OLD_METHODS}
  gegl_color,
  {$EndIf}
  zgl_utils
  {$Else}
  zglHeader
  {$EndIf}
  ;

var
  calc      : Integer;
  points    : array[ 0..359 ] of zglTPoint2D;
  TimeStart : LongWord = 0;
  {$IfNDef OLD_METHODS}
  dirRes    : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  newColor  : array[0..1] of LongWord;
  {$EndIf}
  {$IfNDef OLD_METHODS}
  // RU: это для создания ломанных линий. Можно создать динамический массив и делать
  //     линии с произвольным количеством точек.
  // EN: this is for creating broken lines. You can create a dynamic array and draw
  //     lines with an arbitrary number of points.
  myPointArray: array[0..3] of zglTPoint2DColor;
  deltaX, deltaY: array [0..3] of Integer;
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
  // Rus: устанавливаем новый цвет. Которого нет в списке стандартных. Все константы в gegl_color.
  // Eng: set a new color. Which is not in the standard list. All constants in gegl_color.
  newColor[0] := Color_FindOrAdd($0000009B);
  newColor[1] := Color_FindOrAdd($FFFFFF4B);

  myPointArray[0].X := 20;
  myPointArray[0].Y := 20;
  myPointArray[0].Color := cl_Red;
  myPointArray[1].X := wndWidth - 20;
  myPointArray[1].Y := 20;
  myPointArray[1].Color := cl_Blue;
  myPointArray[3].X := wndWidth - 80;
  myPointArray[3].Y := wndHeight - 20;
  myPointArray[3].Color := cl_Green;
  myPointArray[2].X := 80;
  myPointArray[2].Y := wndHeight - 20;
  myPointArray[2].Color := cl_Yellow;
  deltaX[0] := 1;          deltaY[0] := 1;
  deltaX[1] := - 1;        deltaY[1] := 1;
  deltaX[2] := - 1;        deltaY[2] := - 1;
  deltaX[3] := 1;          deltaY[3] := - 1;
  {$EndIf}
end;

procedure Draw;
var
  i : Integer;
begin
  batch2d_Begin;
  // RU: Устанавливаем цвет и альфу для каждой вершины.
  // EN: Set color and alpha for each vertex.
  fx2d_SetVCA( $FF0000, $00FF00, $0000FF, $FFFF00, 255, 255, 255, 255 );
  // RU: Рисуем прямоугольник с заливкой(флаг PR2D_FILL) с использованием отдельных цветов для каждой вершины(флаг FX2D_VCA).
  // EN: Render filled rectangle(flag PR2D_FILL) and use different colors for each vertex(flag FX2D_VCA).
  pr2d_Rect( 0, 0, 800, 600, {$IfDef OLD_METHODS}$000000, 255{$Else}cl_Black{$EndIf}, FX2D_VCA or PR2D_FILL );

  // RU: мне лень переделывать под старые методы, потому просто отключаю. Но сама линия приспособлена к использованию старых методов,
  //     вы можете сами потренироваться и реализовать использование этой функции для старых методов.
  // EN: I'm too lazy to remake under the old methods, so I just turn it off. But the line itself is adapted to use the old methods,
  //     you can practice and implement the use of this function for old methods.
  {$IfNDef OLD_METHODS}
  // RU: рисуем широкую ломанную линию. Каждая точка имеет свой цвет, ширина линии 10 пикселей.
  // EN: draw a wide broken line. Each point has its own color, the line width is 10 pixels.
  pr2d_LineStripEX(@myPointArray, 4, 0, 10, LINE_RGBA);
  {$EndIf}

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

  batch2d_End;
end;

procedure Timer;
var
  i: Integer;
begin
  INC( calc );
  if calc > 359 Then
    calc := 0;
  points[ calc ].X := 400 + m_Cos( calc ) * ( 96 + random( 32 ) );
  points[ calc ].Y := 300 + m_Sin( calc ) * ( 96 + random( 32 ) );
  {$IfNDef OLD_METHODS}
  for i := 0 to 3 do
  begin
    if (myPointArray[i].X > wndWidth - 20) or (myPointArray[i].X < 20) then
      deltaX[i] := - deltaX[i];
    if (myPointArray[i].Y > wndHeight - 20) or (myPointArray[i].Y < 20) then
      deltaY[i] := - deltaY[i];
    myPointArray[i].X := myPointArray[i].X + deltaX[i];
    myPointArray[i].Y := myPointArray[i].Y + deltaY[i];
  end;
  {$EndIf}
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
