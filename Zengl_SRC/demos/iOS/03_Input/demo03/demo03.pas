program demo03;

{$I zglCustomConfig.cfg}

uses
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_touch,
  zgl_keyboard,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_textures_png,
  zgl_math_2d,
  zgl_collision_2d,
  zgl_utils
  ;

var
  dirRes  : UTF8String = 'data/';

  fntMain   : zglPFont;

  userInput  : UTF8String;
  trackInput : Boolean;
  inputRect  : zglTRect;
  lineAlpha  : Byte;

procedure Init;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  inputRect.X := 400 - 192;
  inputRect.Y := 300 - 100 - 32;
  inputRect.W := 384;
  inputRect.H := 96;
end;

procedure Draw;
  var
    w : Single;
begin
  // RU: Координаты "пальцев" можно получить при помощи функций touch_X и touch_Y.
  // EN: "Finger" coordinates can be got using functions touch_X and touch_Y.
  text_Draw( fntMain, 0, 0, 'First finger X, Y: ' + u_IntToStr( touch_X( 0 ) ) + '; ' + u_IntToStr( touch_Y( 0 ) ) );
  text_Draw( fntMain, 0, 16, 'Second finger X, Y: ' + u_IntToStr( touch_X( 1 ) ) + '; ' + u_IntToStr( touch_Y( 1 ) ) );

  // RU: Выводим введённый пользователем текст.
  // EN: Show the inputted text.
  pr2d_Rect( inputRect.X, inputRect.Y, inputRect.W, inputRect.H, $FFFFFF, 255 );
  if trackInput Then
    begin
      text_Draw( fntMain, 400, 300 - 100, 'Press Done to stop track text input:', TEXT_HALIGN_CENTER );
      w := text_GetWidth( fntMain, userInput );
      pr2d_Rect( 400 + w / 2 + 2, 300 - 70, 10, 20, $FFFFFF, lineAlpha, PR2D_FILL );
    end else
      text_Draw( fntMain, 400, 300 - 100, 'Tap here to enter text(maximum - 24 symbols):', TEXT_HALIGN_CENTER );
  text_Draw( fntMain, 400, 300 - 70, userInput, TEXT_HALIGN_CENTER );
end;

procedure Timer;
begin
  if lineAlpha > 5 Then
    DEC( lineAlpha, 10 )
  else
    lineAlpha := 255;

  // RU: Проверить тапнул ли пользователь в пределах inputRect и начать отслеживать ввод текста.
  // EN: Check if there was tap inside inputRect and start to track text input.
  if touch_Tap( 0 ) and col2d_PointInRect( touch_X( 0 ), touch_Y( 0 ), inputRect ) Then
    begin
      trackInput := TRUE;
      key_BeginReadText( userInput, 24 );
    end;

  // RU: Если была нажата кнопка Done прекращаем отслеживать ввод текста.
  // EN: Finish to track text input if Done was pressed.
  if key_Press( K_ENTER ) Then
    begin
      trackInput := FALSE;
      key_EndReadText();
    end;

  // RU: Получаем введённый пользователем текст.
  // EN: Get inputted by user text.
  if trackInput Then
    userInput := key_GetText();

  // RU: Обязательно очищаем состояния всех подсистем ввода.
  // EN: Necessarily clear all the states of input subsystems.
  touch_ClearState();
  key_ClearState();
end;

Begin
  timer_Add( @Timer, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );

  zgl_Init();
End.
