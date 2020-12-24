library demo03;

{$I zglCustomConfig.cfg}

uses
  zgl_application,
  zgl_file,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_touch,
  zgl_keyboard,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_textures_png,
  zgl_types,
  zgl_collision_2d,
  zgl_utils
  ;

var
  dirRes  : UTF8String = 'assets/';

  fntMain   : Byte;

  userInput  : UTF8String;
  trackInput : Boolean;
  inputRect  : zglTRect;
  lineAlpha  : Byte;

  TimerStart: Byte;

procedure Init;
begin
  zgl_Enable(CORRECT_RESOLUTION);
  scr_CorrectResolution( 800, 600 );

  file_OpenArchive(PAnsiChar(zgl_Get(DIRECTORY_APPLICATION)));

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  file_CloseArchive();

  inputRect.X := 400 - 192;
  inputRect.Y := 300 - 100 - 32;
  inputRect.W := 384;
  inputRect.H := 96;
  setTextScale(15, fntMain);
end;

procedure Draw;
  var
    w : Single;
begin
  setTextColor($FFFFFFFF);
  // RU: Координаты "пальцев" можно получить при помощи функций touch_X и touch_Y.
  // EN: "Finger" coordinates can be got using functions touch_X and touch_Y.
  text_Draw(fntMain, 0, 0, 'One   X, Y: ' + u_IntToStr(touch_X(0)) + '; ' + u_IntToStr(touch_Y(0)));
  text_Draw(fntMain, 0, 16, 'Two   X, Y: ' + u_IntToStr(touch_X(1)) + '; ' + u_IntToStr(touch_Y(1)));
  // расширю до 10 одновременных нажатий, некоторые телефоны это поддерживают
  text_Draw(fntMain, 0, 32, 'Three X, Y: ' + u_IntToStr(touch_X(2)) + '; ' + u_IntToStr(touch_Y(2)));
  text_Draw(fntMain, 0, 48, 'Four  X, Y: ' + u_IntToStr(touch_X(3)) + '; ' + u_IntToStr(touch_Y(3)));
  text_Draw(fntMain, 0, 64, 'Five  X, Y: ' + u_IntToStr(touch_X(4)) + '; ' + u_IntToStr(touch_Y(4)));
  text_Draw(fntMain, 0, 80, 'Six   X, Y: ' + u_IntToStr(touch_X(5)) + '; ' + u_IntToStr(touch_Y(5)));
  text_Draw(fntMain, 0, 96, 'Seven X, Y: ' + u_IntToStr(touch_X(6)) + '; ' + u_IntToStr(touch_Y(6)));
  text_Draw(fntMain, 0, 112, 'Eigth X, Y: ' + u_IntToStr(touch_X(7)) + '; ' + u_IntToStr(touch_Y(7)));
  text_Draw(fntMain, 0, 128, 'Nine  X, Y: ' + u_IntToStr(touch_X(8)) + '; ' + u_IntToStr(touch_Y(8)));
  text_Draw(fntMain, 0, 144, 'Ten   X, Y: ' + u_IntToStr(touch_X(9)) + '; ' + u_IntToStr(touch_Y(9)));

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

procedure Restore;
begin
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  font_RestoreFromFile( fntMain, dirRes + 'font.zfi' );
  file_CloseArchive();
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  TimerStart := timer_Add( @Timer, 16, Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  scr_SetOptions();
end;

exports
  Java_zengl_android_ZenGL_Main,
  {$I android_export.inc}
End.
