program demo03;

{$I zglCustomConfig.cfg}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_mouse,
  zgl_keyboard,
  zgl_joystick,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_textures_png,
  zgl_types,
  zgl_collision_2d,
  zgl_utils
  ;

var
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};

  fntMain    : Byte;

  joyCount   : Integer;
  userInput  : UTF8String;
  trackInput : Boolean;
  inputRect  : zglTRect;
  lineAlpha  : Byte;

  TimeStart  : Byte;

procedure Init;
begin
  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  setTextScale(15, fntMain);

  inputRect.X := 400 - 192;
  inputRect.Y := 300 - 100 - 32;
  inputRect.W := 384;
  inputRect.H := 96;

  // RU: Инициализируем обработку ввода джойстиков и получаем количество подключенных джойстиков.
  // EN: Initialize processing joystick input and get count of plugged joysticks.
  joyCount := joy_Init();
end;

procedure Draw;
  var
    w : Single;
begin
  text_Draw( fntMain, 0, 0, 'Escape - Exit' );

  // RU: Координаты мыши можно получить при помощи функций mouse_X и mouse_Y.
  // EN: Mouse coordinates can be got using functions mouse_X and mouse_Y.
  text_Draw( fntMain, 0, 18, 'Mouse X, Y: ' + u_IntToStr( mouseX ) + '; ' + u_IntToStr( mouseY ) );

  // RU: Выводим введённый пользователем текст.
  // EN: Show the inputted text.
  pr2d_Rect( inputRect.X, inputRect.Y, inputRect.W, inputRect.H, $FFFFFF, 255 );
  if trackInput Then
    begin
      text_Draw( fntMain, 400, 300 - 100, 'Press Enter to stop track text input:', TEXT_HALIGN_CENTER );
      w := text_GetWidth( fntMain, userInput );
      pr2d_Rect( 400 + w / 2 + 2, 300 - 70, 10, 20, $FFFFFF, lineAlpha, PR2D_FILL );
    end else
      text_Draw( fntMain, 400, 300 - 100, 'Click here to enter text(maximum - 24 symbols):', TEXT_HALIGN_CENTER );
  text_Draw( fntMain, 400, 300 - 70, userInput, TEXT_HALIGN_CENTER );


  // RU: Вывод состояния осей и кнопок первого джойстика в системе.
  // EN: Show the state of axes and buttons of first joystick in the system.
  text_Draw( fntMain, 400, 360, 'JOYSTICK ( Found: ' + u_IntToStr( joyCount ) + ' )', TEXT_HALIGN_CENTER );

  text_Draw( fntMain, 100, 400, 'Axis X: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_X ) ) );
  text_Draw( fntMain, 100, 420, 'Axis Y: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_Y ) ) );
  text_Draw( fntMain, 100, 440, 'Axis Z: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_Z ) ) );
  text_Draw( fntMain, 100, 460, 'Axis R: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_R ) ) );
  text_Draw( fntMain, 100, 480, 'Axis U: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_U ) ) );
  text_Draw( fntMain, 100, 500, 'Axis V: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_V ) ) );
  text_Draw( fntMain, 100, 520, 'POVX: ' + u_FloatToStr( joy_AxisPos( 0, JOY_POVX ) ) );
  text_Draw( fntMain, 100, 540, 'POVY: ' + u_FloatToStr( joy_AxisPos( 0, JOY_POVY ) ) );

  text_Draw( fntMain, 400, 400, 'Button1: ' + u_BoolToStr( joy_Down( 0, 0 ) ) );
  text_Draw( fntMain, 400, 420, 'Button2: ' + u_BoolToStr( joy_Down( 0, 1 ) ) );
  text_Draw( fntMain, 400, 440, 'Button3: ' + u_BoolToStr( joy_Down( 0, 2 ) ) );
  text_Draw( fntMain, 400, 460, 'Button4: ' + u_BoolToStr( joy_Down( 0, 3 ) ) );
  text_Draw( fntMain, 400, 480, 'Button5: ' + u_BoolToStr( joy_Down( 0, 4 ) ) );
  text_Draw( fntMain, 400, 500, 'Button6: ' + u_BoolToStr( joy_Down( 0, 5 ) ) );
  text_Draw( fntMain, 400, 520, 'Button7: ' + u_BoolToStr( joy_Down( 0, 6 ) ) );
  text_Draw( fntMain, 400, 540, 'Button8: ' + u_BoolToStr( joy_Down( 0, 7 ) ) );
  text_Draw( fntMain, 550, 400, 'Button9: ' + u_BoolToStr( joy_Down( 0, 8 ) ) );
  text_Draw( fntMain, 550, 420, 'Button10: ' + u_BoolToStr( joy_Down( 0, 9 ) ) );
  text_Draw( fntMain, 550, 440, 'Button11: ' + u_BoolToStr( joy_Down( 0, 10 ) ) );
  text_Draw( fntMain, 550, 460, 'Button12: ' + u_BoolToStr( joy_Down( 0, 11 ) ) );
  text_Draw( fntMain, 550, 480, 'Button13: ' + u_BoolToStr( joy_Down( 0, 12 ) ) );
  text_Draw( fntMain, 550, 500, 'Button14: ' + u_BoolToStr( joy_Down( 0, 13 ) ) );
  text_Draw( fntMain, 550, 520, 'Button15: ' + u_BoolToStr( joy_Down( 0, 14 ) ) );
  text_Draw( fntMain, 550, 540, 'Button16: ' + u_BoolToStr( joy_Down( 0, 15 ) ) );
end;

procedure Timer;
begin
  if lineAlpha > 5 Then
    DEC( lineAlpha, 10 )
  else
    lineAlpha := 255;

  // RU: Проверить нажата ли левая кнопка мыши в пределах inputRect и начать отслеживать ввод текста.
  // EN: Check if left mouse button was pressed inside inputRect and start to track text input.
  if mBClickCanClick( M_BLEFT_CLICK ) and col2d_PointInRect( mouseX, mouseY, inputRect ) Then
  begin
    trackInput := TRUE;
    key_BeginReadText( userInput, 24 );
  end;

  // RU: Если был нажат Enter прекращаем отслеживать ввод текста.
  // EN: Finish to track text input if Enter was pressed.
  if key_Press( K_ENTER ) Then
  begin
    trackInput := FALSE;
    key_EndReadText();
  end;

  // RU: Получаем введённый пользователем текст.
  // EN: Get inputted by user text.
  if trackInput Then
    userInput := key_GetText();

  // RU: По нажатию Escape завершить приложение.
  // EN: If Escape was pressed - shutdown the application.

  // if key_Press( K_ESCAPE ) Then zgl_Exit;
                   // больше не нужно это делать, но если для чего-то понадобится клавиша Escape, надо
                   // отключить дефайн (USE_EXIT_ESCAPE) на её обработку

  // RU: Обязательно очищаем состояния всех подсистем ввода.
  // EN: Necessarily clear all the states of input subsystems.
  mouse_ClearState();
  key_ClearState();
  joy_ClearState();
end;

Begin
  TimeStart := timer_Add( @Timer, 16, Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('03 - Input'));

  zgl_Init();
End.
