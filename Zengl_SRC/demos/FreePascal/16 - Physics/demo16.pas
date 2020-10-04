program demo16;

// RU: В этом файле конфигурации содержится "опция" USE_CHIPMUNK_STATIC для статической компиляции с Chipmunk
// EN: This file contains "option" USE_CHIPMUNK_STATIC for static compilation with Chipmunk
{$I zglCustomConfig.cfg}

uses
  zglChipmunk,
  {$IFDEF USE_ZENGL_STATIC}
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_mouse,
  zgl_textures,
  zgl_textures_png,
  zgl_render_2d,
  zgl_font,
  zgl_text,
  zgl_primitives_2d,
  zgl_math_2d,
  zgl_utils
  {$ELSE}
  zglHeader
  {$ENDIF}
  ;

var
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain : zglPFont;
  space   : PcpSpace;
  bCount  : Integer;
  Bodies  : array of PcpBody;
  Shapes  : array of PcpShape;

// RU: Добавить объект "шар"
//     x, y - координаты центра
//     mass - масса
//     r    - радиус
//     e    - коэффициент эластичности
//     u    - коэффициент трения
//
// EN: Add new object "ball"
//     x, y - coordinates
//     mass - mass
//     r    - radius
//     e    - coefficient of restitution. (elasticity)
//     u    - coefficient of friction
procedure cpAddBall( x, y, r, mass, e, u : cpFloat );
begin
  INC( bCount );
  SetLength( Bodies, bCount );
  SetLength( Shapes, bCount );

  Bodies[ bCount - 1 ]   := cpBodyNew( mass, cpMomentForCircle( mass, 0, r, cpvzero ) );
  Bodies[ bCount - 1 ].p := cpv( x, y );
  cpSpaceAddBody( space, Bodies[ bCount - 1 ] );

  Shapes[ bCount - 1 ]   := cpCircleShapeNew( Bodies[ bCount - 1 ], r, cpvzero );
  Shapes[ bCount - 1 ].e := e;
  Shapes[ bCount - 1 ].u := u;
  cpSpaceAddShape( space, Shapes[ bCount - 1 ] );
end;

// RU: Добавить объект "коробка"
//     Схож с процедурой cpAddBall по аргументам
//     x, y - координаты центра
//     w, h - ширина и высота
//
// EN: Add bew object "box"
//     Arguments are similar to arguments of procedure cpAddBall
//     x, y - coordinates of center
//     w, h - width and height
procedure cpAddBox( x, y, w, h, mass, e, u : cpFloat );
  var
    points : array[ 0..3 ] of cpVect;
    f      : cpFloat;
begin
  INC( bCount );
  SetLength( Bodies, bCount );
  SetLength( Shapes, bCount );

  points[ 0 ].x := - w / 2;
  points[ 0 ].y := - h / 2;
  points[ 1 ].x := - w / 2;
  points[ 1 ].y := h / 2;
  points[ 2 ].x := w / 2;
  points[ 2 ].y := h / 2;
  points[ 3 ].x := w / 2;
  points[ 3 ].y := - h / 2;

  f := cpMomentForPoly( mass, 4, @points[ 0 ], cpvzero );
  Bodies[ bCount - 1 ]   := cpBodyNew( mass, f );
  Bodies[ bCount - 1 ].p := cpv( x + w / 2, y + h / 2 );
  cpSpaceAddBody( space, Bodies[ bCount - 1 ] );

  Shapes[ bCount - 1 ]   := cpPolyShapeNew( Bodies[ bCount - 1 ], 4, @points[ 0 ], cpvzero );
  Shapes[ bCount - 1 ].e := e;
  Shapes[ bCount - 1 ].u := u;
  cpSpaceAddShape( space, Shapes[ bCount - 1 ] );
end;

procedure Init;
  var
    staticBody : PcpBody;
    ground     : PcpShape;
    e, u       : cpFloat;
begin
  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  cpInitChipmunk();

  // RU: Создаем новый "мир".
  // EN: Create new world.
  space            := cpSpaceNew();
  // RU: Задаем количество итераций обработки(рекомендуется 10).
  // EN: Set count of iterations of processing(recommended is 10).
  space.iterations := 10;
  space.elasticIterations := 10;
  // RU: Задаем силу гравитации.
  // EN: Set the gravity.
  space.gravity    := cpv( 0, 256 );
  // RU: Задаем коэффициент "затухания" движения объектов.
  // EN: Set the damping for moving of objects.
  space.damping    := 0.9;

  e := 1;
  u := 0.9;
  // RU: Создадим статичное "тело".
  // EN: Create a static "body".
  staticBody := cpBodyNew( INFINITY, INFINITY );
  // RU: Добавим три отрезка для ограничения мира. Первый параметр - указатель на созданное тело, два последующих - координаты точек отрезка, последний - толщина отрезка.
  // EN: Add three segments for restriction of world. First parameter - pointer of created body, next two - coordinates of segment points, the last one - width of segment.
  ground := cpSegmentShapeNew( staticBody, cpv( 5, 0 ), cpv( 5, 590 ), 1 );
  ground.e := e;
  ground.u := u;
  cpSpaceAddStaticShape( space, ground );
  ground := cpSegmentShapeNew( staticBody, cpv( 795, 0 ), cpv( 795, 590 ), 1 );
  ground.e := e;
  ground.u := u;
  cpSpaceAddStaticShape( space, ground );
  ground := cpSegmentShapeNew( staticBody, cpv( 0, 590 ), cpv( 800, 590 ), 1 );
  ground.e := e;
  ground.u := u;
  cpSpaceAddStaticShape( space, ground );
  // RU: Добавим треугольник.
  // EN: Add the triangle.
  staticBody := cpBodyNew( INFINITY, INFINITY );
  ground := cpSegmentShapeNew( staticBody, cpv( 400, 300 ), cpv( 200, 350 ), 1 );
  ground.e := e;
  ground.u := u;
  cpSpaceAddStaticShape( space, ground );
  ground := cpSegmentShapeNew( staticBody, cpv( 200, 350 ), cpv( 700, 350 ), 1 );
  ground.e := e;
  ground.u := u;
  cpSpaceAddStaticShape( space, ground );
  ground := cpSegmentShapeNew( staticBody, cpv( 700, 350 ), cpv( 400, 300 ), 1 );
  ground.e := e;
  ground.u := u;
  cpSpaceAddStaticShape( space, ground );
end;

procedure Draw;
begin
  batch2d_Begin();

  // RU: Рендерим объекты указанного "мира". Второй аргумент функции отвечает за показ точек соприкосновения.
  // EN: Render objects for specified "world". Second argument responsible for rendering of collision points.
  cpDrawSpace( space, TRUE );

  text_Draw( fntMain, 10, 5,  'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
  text_Draw( fntMain, 10, 25, 'Use your mouse: Left Click - box, Right Click - ball' );
  batch2d_End();
end;

procedure Proc;
begin
  if mouse_Click( M_BLEFT ) Then
    cpAddBox( mouse_X() - 10, mouse_Y() - 10, 48, 32, 1, 0.5, 0.5 );
  if mouse_Click( M_BRIGHT ) Then
    cpAddBall( mouse_X(), mouse_Y(), 16, 1, 0.5, 0.9 );

  if key_Press( K_ESCAPE ) Then zgl_Exit();

  key_ClearState();
  mouse_ClearState();
end;

procedure Update( dt : Double );
begin
  cpSpaceStep( space, 1 / ( 1000 / dt ) );
end;

procedure Quit;
begin
  // RU: Очистка объектов и "мира".
  // EN: Free objects and "world".
  cpSpaceFreeChildren( space );
  cpSpaceFree( space );
end;

Begin
  randomize();

  {$IFNDEF USE_ZENGL_STATIC}
  if not zglLoad( libZenGL ) Then exit;
  {$ENDIF}
  {$IFNDEF USE_CHIPMUNK_STATIC}
  if not cpLoad( libChipmunk ) Then exit;
  {$ENDIF}

  timer_Add( @Proc, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_UPDATE, @Update );
  zgl_Reg( SYS_EXIT, @Quit );

  wnd_SetCaption( '16 - Physics Simple' );

  wnd_ShowCursor( TRUE );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, FALSE, FALSE );

  zgl_Init();
End.
