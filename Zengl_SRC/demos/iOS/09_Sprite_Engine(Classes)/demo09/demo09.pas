program demo09;

{$I zglCustomConfig.cfg}

uses
  zglSpriteEngine,

  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_touch,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_textures_jpg,
  zgl_sprite_2d,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_math_2d,
  zgl_utils
  ;

type
  CMiku = class(zglCSprite2D)
  protected
    FSpeed : zglTPoint2D;
  public
    procedure OnInit( _Texture : zglPTexture; _Layer : Integer ); override;
    procedure OnDraw; override;
    procedure OnProc; override;
    procedure OnFree; override;
  end;

var
  dirRes    : UTF8String = 'data/';
  fntMain   : zglPFont;
  texLogo   : zglPTexture;
  texMiku   : zglPTexture;
  time      : Integer;
  sengine2d : zglCSEngine2D;

// Miku
procedure CMiku.OnInit( _Texture : zglPTexture; _Layer : Integer );
begin
  // RU: Укажем свою текстуру и слой для спрайта, заодно установятся стандартные параметры вроде ширины и высоты на основе данных о кадре в текстуре.
  // EN: Set own texture and layer for sprite, also standard parameters will be set automatically(like width and height from info about texture).
  inherited OnInit( texMiku, random( 10 ) );

  X := 800 + random( 800 );
  Y := random( 600 - 128 );
  // RU: Задаем скорость движения.
  // EN: Set the moving speed.
  FSpeed.X := -random( 10 ) / 5 - 0.5;
  FSpeed.Y := ( random( 10 ) - 5 ) / 5;
end;

procedure CMiku.OnDraw;
begin
  // RU: Т.к. по сути эта процедура объявлена только для примера, то вызовем основной метод OnDraw класса zglCSprite2D.
  // EN: Because in fact, this procedure is declared only for example, so call to the main method OnDraw of class zglCSprite2D.
  inherited;
end;

procedure CMiku.OnProc;
begin
  inherited;
  X := X + FSpeed.X;
  Y := Y + FSpeed.Y;
  Frame := Frame + ( abs( FSpeed.X ) + abs( FSpeed.Y ) ) / 25;
  if Frame > 8 Then
    Frame := 1;

  // RU: Если спрайт выходит за пределы по X, сразу же удаляем его.
  // EN: Delete the sprite if it goes beyond X.
  if X < -128 Then sengine2d.DelSprite( ID );

  // RU: Если спрайт выходит за пределы по Y, ставим его в очередь на удаление
  // EN: Add sprite to queue for delete if it goes beyond Y.
  if Y < -128 Then Kill := TRUE;
  if Y > 600  Then Kill := TRUE;
end;

procedure CMiku.OnFree;
begin
  inherited;
end;

// RU: Добавить 100 спрайтов.
// EN: Add 100 sprites.
procedure AddMiku;
  var
    i, ID : Integer;
begin
  for i := 1 to 100 do
    begin
      // RU: Запрашиваем у спрайтового менеджера новое "место" под спрайт :)
      // EN: Request a "place" for a new sprite :)
      ID := sengine2d.AddSprite();
      // RU: Создаем экземпляр спрайта CMiku. Аргументами конструктора являются сам менеджер и будущий ID для спрайта.
      // EN: Create a new CMiku. Constructor arguments must be current sprite engine and future ID for sprite.
      sengine2d.List[ ID ] := CMiku.Create( sengine2d, ID );
    end;
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
    sengine2d.DelSprite( random( sengine2d.Count ) );
end;

procedure Init;
  var
    i : Integer;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  texLogo := tex_LoadFromFile( dirRes + 'zengl.png' );

  texMiku := tex_LoadFromFile( dirRes + 'miku.png' );
  tex_SetFrameSize( texMiku, 128, 128 );

  // RU: Создаем экземпляр zglCSEngine2D.
  // EN: Create zglCSEngine2D object.
  sengine2d := zglCSEngine2D.Create();

  // RU: Создадим 1000 спрайтов Miku-chan :)
  // EN: Create 1000 sprites of Miku-chan :)
  for i := 0 to 9 do
    AddMiku();

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
end;

procedure Draw;
begin
  batch2d_Begin();
  // RU: Рисуем все спрайты находящиеся в текущем спрайтовом менеджере.
  // EN: Render all sprites contained in current sprite engine.
  if time > 255 Then
    sengine2d.Draw();

  if time <= 255 Then
    ssprite2d_Draw( texLogo, 400 - 256, 300 - 128, 512, 256, 0, time )
  else
    if time < 510 Then
      begin
        pr2d_Rect( 0, 0, 800, 600, $000000, 510 - time, PR2D_FILL );
        ssprite2d_Draw( texLogo, 400 - 256, 300 - 128, 512, 256, 0, 510 - time );
      end;

  if time > 255 Then
    begin
      pr2d_Rect( 0, 0, 256, 64, $000000, 200, PR2D_FILL );
      text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
      text_Draw( fntMain, 0, 20, 'Sprites: ' + u_IntToStr( sengine2d.Count ) );
      text_Draw( fntMain, 0, 40, 'Tap at the top - Add Miku' );
      text_Draw( fntMain, 0, 60, 'Tap at the bottom - Delete Miku' );
    end;
  batch2d_End();
end;

procedure Timer;
begin
  INC( time, 2 );

  // RU: Выполняем обработку всех спрайтов в текущем спрайтовом менеджере.
  // EN: Process all sprites contained in current sprite engine.
  sengine2d.Proc();

  // RU: По двойному тапу очистить все спрайты.
  // EN: Delete all sprites if there was double tap.
  if touch_DblTap( 0 ) Then
    sengine2d.ClearAll()
  else
    begin
      if touch_Tap( 0 ) Then
        begin
          if touch_Y( 0 ) < 300 Then
            AddMiku()
          else
            DelMiku();
        end;
    end;

  touch_ClearState();
end;

procedure Quit;
begin
  // RU: Очищаем память от созданных спрайтов.
  // EN: Free allocated memory for sprites.
  sengine2d.Destroy();
end;

Begin
  randomize();

  timer_Add( @Timer, 16 );
  timer_Add( @AddMiku, 1000 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_EXIT, @Quit );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );

  zgl_Init();
End.
