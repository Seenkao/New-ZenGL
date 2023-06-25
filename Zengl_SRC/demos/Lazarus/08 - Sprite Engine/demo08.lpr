program demo08;

{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

{$IFDEF WINDOWS}
  {$R *.res}
{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF USE_ZENGL_STATIC}
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_textures_jpg,
  zgl_sprite_2d,
  zgl_sengine_2d,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_types,
  zgl_utils,
  gegl_color
  {$ELSE}
  zglHeader
  {$ENDIF}
  ;

type
  zglPMikuSprite = ^zglTMikuSprite;
  zglTMikuSprite = record
    // RU: Обязательная часть нового типа спрайта.
    // EN: New type should start with this.
    Sprite : zglTSprite2D;

    // RU: Новые параметры.
    // EN: New params.
    Speed  : zglTPoint2D;
  end;

var
  dirRes      : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain     : LongWord;
  texLogo     : zglPTexture;
  texMiku     : zglPTexture;
  time        : Integer;
  sengine2d   : zglTSEngine2D;

  TimeStart   : LongWord;
  TimeMiku    : LongWord;
  newColor    : LongWord;
  correctColor: LongWord;

// Miku
procedure MikuInit( var Miku : zglTMikuSprite );
begin
  with Miku, Miku.Sprite do
    begin
      X := 800 + random( 800 );
      Y := random( 600 - 128 );

      // RU: Задаем скорость движения.
      // EN: Set the moving speed.
      Speed.X := -random( 10 ) / 5 - 0.5;
      Speed.Y := ( random( 10 ) - 5 ) / 5;
    end;
end;

procedure MikuDraw( var Miku : zglTMikuSprite );
begin
  with Miku.Sprite do
    asprite2d_Draw( Texture, X, Y, W, H, Angle, Round( Frame ), Alpha, FxFlags );
end;

procedure MikuProc( var Miku : zglTMikuSprite );
begin
  with Miku, Miku.Sprite do
    begin
      X := X + Speed.X;
      Y := Y + Speed.Y;
      Frame := Frame + ( abs( speed.X ) + abs( speed.Y ) ) / 25;
      if Frame > 8 Then
        Frame := 1;

      // RU: Если спрайт выходит за пределы по X, сразу же удаляем его.
      // EN: Delete the sprite if it goes beyond X.
      if X < -128 Then sengine2d_DelSprite( ID );

      // RU: Если спрайт выходит за пределы по Y, ставим его в очередь на удаление.
      // EN: Add sprite to queue for delete if it goes beyond Y.
      if Y < -128 Then Destroy := TRUE;
      if Y > 600  Then Destroy := TRUE;
    end;
end;

procedure MikuFree( var Miku : zglTMikuSprite );
begin
end;

// RU: Добавить 100 спрайтов.
// EN: Add 100 sprites.
procedure AddMiku;
  var
    i : Integer;
begin
  // RU: При добавлении спрайта в менеджер спрайтов указывается текстура, слой(положение по Z) и указатели на основные функции - Инициализация, Рендер, Обработка и Уничтожение.
  // EN: For adding sprite to sprite engine must be set next parameters: texture, layer(Z-coordinate) and pointers to Initialization, Render, Process and Destroy functions.
  for i := 1 to 100 do
    sengine2d_AddCustom( texMiku, SizeOf( zglTMikuSprite ), random( 10 ), @MikuInit, @MikuDraw, @MikuProc, @MikuFree );
end;

// RU: Удалить 100 спрайтов.
// EN: Delete 100 sprites.
procedure DelMiku;
  var
    i : Integer;
begin
  // RU: Удалим 100 спрайтов со случайным ID.
  // EN: Delete 100 sprites with random ID.
  for i := 1 to 100 do
    sengine2d_DelSprite( random( sengine2d.Count ) );
end;

procedure Init;
  var
    i : Integer;
begin
  texLogo := tex_LoadFromFile( dirRes + 'zengl.png' );

  texMiku := tex_LoadFromFile( dirRes + 'miku.png' );
  tex_SetFrameSize( texMiku, 128, 128 );

  // RU: Устанавливаем текущим менеджером спрайтов свой.
  // EN: Set own sprite engine as current.
  sengine2d_Set( @sengine2d );

  // RU: Создадим 1000 спрайтов Miku-chan :)
  // EN: Create 1000 sprites of Miku-chan :)
//  for i := 0 to 9 do
//    AddMiku();

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  setFontTextScale(15, fntMain);
  newColor := Color_FindOrAdd($80A080FF - 55);
  correctColor := Color_FindOrAdd($AFAFAFFF);
end;

procedure Draw;
var
  i: LongWord;
begin
  batch2d_Begin();
  // RU: Рисуем все спрайты находящиеся в текущем спрайтовом менеджере.
  // EN: Render all sprites contained in current sprite engine.
  if time > 255 Then
    sengine2d_Draw();

  if time <= 255 Then
    ssprite2d_Draw( texLogo, 400 - 256, 300 - 128, 512, 256, 0, time )
  else
    if time < 510 Then
      begin
        pr2d_Rect( 0, 0, 800, 600, correctColor, PR2D_FILL );
        i := Get_Color(correctColor);
        dec(i);
        if i < $AFAFAF00 then
          i := $AFAFAF00;
        Correct_Color(correctColor, i);
        ssprite2d_Draw( texLogo, 400 - 256, 300 - 128, 512, 256, 0, 510 - time );
      end;

  if time > 255 Then
    begin
      pr2d_Rect( 0, 0, 256, 64, newColor, PR2D_FILL );
      text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
      text_Draw( fntMain, 0, 20, 'Sprites: ' + u_IntToStr( sengine2d.Count ) );
      text_Draw( fntMain, 0, 40, 'Up/Down - Add/Delete Miku :)' );
    end;
  batch2d_End();
end;

procedure Timer;
begin
  INC( time );

  // RU: Выполняем обработку всех спрайтов в текущем спрайтовом менеджере.
  // EN: Process all sprites contained in current sprite engine.
  sengine2d_Proc();
end;

procedure KeyMouseEvent;
begin
  // RU: По нажатию пробела очистить все спрайты.
  // EN: Delete all sprites if space was pressed.
  if key_Press( K_SPACE ) Then
    sengine2d_ClearAll();
  if key_Press( K_UP ) Then
    AddMiku();
  if key_Press( K_DOWN ) Then
    DelMiku();
end;

procedure Quit;
begin
  // RU: Очищаем память от созданных спрайтов.
  // EN: Free allocated memory for sprites.
  sengine2d_Set( @sengine2d );
  sengine2d_ClearAll();
end;

Begin
  {$IFNDEF USE_ZENGL_STATIC}
  if not zglLoad( libZenGL ) Then exit;
  {$ENDIF}

  randomize;

  TimeStart := timer_Add( @Timer, 16, t_Start );
  // RU: Таймер с задержкой в 6 секунд.
  // EN: Timer with a 6 second delay.
  TimeMiku := timer_Add( @AddMiku, 1000, t_SleepToStart, 6);

  zgl_SetEventsInterval(16);
  zgl_Reg(SYS_EVENTS, @KEyMouseEvent);
  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_EXIT, @Quit );

  wnd_SetCaption(utf8_Copy('08 - Sprite Engine'));

  zgl_Init();
End.

