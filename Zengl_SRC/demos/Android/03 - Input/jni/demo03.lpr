library demo03;

{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

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
  zgl_render_2d,
  zgl_textures,
  zgl_textures_png,
  zgl_types,
  {$IfDef USE_VKEYBOARD}
  gegl_draw_gui,
  gegl_menu_gui,
  {$EndIf}
  {$IfDef OLD_METHODS}
  zgl_collision_2d,
  {$Else}
  gegl_VElements,
  gegl_utils,
  {$EndIf}
  gegl_color,
  zgl_log,
  zgl_utils
  ;

var
  dirRes  : UTF8String = 'assets/';

  // Rus: номера шрифтов. Вся работа со шрифтами происходит именно от этих номеров.
  // Eng: font numbers. All work with fonts comes from these numbers.
  fntMain, fntEdit: LongWord;

  // Rus: номер цвета. Работа с цветом происходит именно от этого номера.
  // Eng: color number. Work with color comes from this number.
  EditColor: LongWord;

  // RU: строка для получения значения из поля ввода
  // EN: string to get value from input field
  userInput  : UTF8String;
  {$IfDef OLD_METHODS}
  trackInput : Boolean;
  inputRect  : zglTRect2D;
  lineAlpha  : LongWord;

  TimeStart  : LongWord;
  {$Else}
  // RU: прямоугольник описывающий поле ввода
  // EN: rectangle describing the input field
  myRect: zglTRect2D;

  // "перепись" полей ввода для того, чтоб знать с каким полем работаем.
  // RU: объявляем переменную для работы с полем ввода
  // EN: we declare a variable to work with the input field
  myEdit, myEdit2: LongWord;

// RU: прорисовываем основание поля ввода. Всё ограничено только вашим воображением. )))
// EN: draw the base of the input field. Everything is limited only by your imagination. )))
procedure EditCont;
begin
  // RU: при прорисовке поля ввода, смешение и поворот уже будут сделаны. Я показываю как нарисовать рамку.
  //     Текст будет выведен поверх того, что вы здесь нарисуете.
  // EN: displacement and rotation will be done prior to performing the procedure. I am showing you how to draw a frame.
  //     The text will be drawn on top of what you draw here.

  pr2d_Rect(- 2, - 1, myRect.W + 5, myRect.H, {$IfnDef OLD_METHODS}cl_White{$else}, $FFFFFF, 128{$EndIf}, PR2D_FILL);
end;
  {$EndIf}

procedure Init;
{$IfNDef OLD_METHODS}
var
  EScale: LongWord;
{$EndIf}
begin

  zgl_Enable(CORRECT_RESOLUTION);
  scr_CorrectResolution( 800, 600 );
  log_Add('winOn = ' + u_BoolToStr(winOn));

  file_OpenArchive(PAnsiChar(zgl_Get(DIRECTORY_APPLICATION)));

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  {$IfNDef OLD_METHODS}
  // RU: Загружаем данные о шрифте.
  // EN: Load the font.
  fntEdit := font_LoadFromFile( dirRes + 'CalibriBold50pt.zfi');
  // Rus: для клавиатуры.
  // Eng:
  fontUse := font_LoadFromFile( dirRes + 'CalibriBold50pt.zfi');
  JoyArrow := tex_LoadFromFile(dirRes + 'arrow.png');

  if fLoadTextClearing then
  begin
    txt_LoadFromFile(dirRes + 'Rus.dat', LoadText);
    set_FlagForLoadText(False);
  end
  else
    log_Add('Rus.dat not loading. Global string false.');
  {$EndIf}

  file_CloseArchive();
  {$IfNDef OLD_METHODS}
  // Rus: очередной код для клавиатуры.
  // Eng:
  tex_SetFrameSize(JoyArrow, 64, 64);            // разбили текстуру на части, но в записях не будет указано количество полученных текстур

  // RU: размер шрифта поля ввода (для понимания что происходит). Изменяя размер шрифта, мы должны менять и
  //     размеры поля ввода - myRect в данном случае. Сами они не изменятся.
  // EN: the font size of the input field (to understand what's going on). By changing the font size,
  //     we must also change the size of the input field - myRect in this case. They themselves will not change.
  EScale := 20;
  setFontTextScale(EScale, fntEdit);
  // RU: указываем размеры поля ввода.
  // EN: specify the size of the input field.
  myRect.X := 200;
  myRect.Y := 150;
  myRect.W := 200;
  myRect.H := 33;
  // RU: указываем точку вращения, в данном случае центр поля ввода (по необходимости) и угол поворота (например 45).
  // EN: specify the point of rotation, in this case the center of the input field (if necessary) and the angle of rotation (for example 45).
  SetOfRotateAngleAndPoint(myRect.x + myRect.W / 2, myRect.y + myRect.H / 2, 30);

  // RU: указываем цвет текста (добавляем новый номер цвета, хотя данная функция вам возвратит цвет, если он уже был прописан).
  // EN: specify the color of the text (we add a new color number, although this function will return the color to you if it
  //     has already been assigned).
  EditColor := Color_FindOrAdd($40a055FF);
  // Ru: устанавливаем цвета по умолчанию для всех  элементов API. Эти цвета будут задействованы только при создании
  //     определённого элемента. Для изменения цвета в самом (уже созданном) элементе, ни чего не прилагается.
  //     Дальнейшие измениня этих значений цвета, ни как не скажется на уже созданных элементах.
  // En: set default colors for all API elements. These colors will only be used when creating a specific element.
  //     To change the color in the (already created) element itself, nothing is attached. Further changes to these
  //     color values will not affect the already created elements in any way.
  SetDefColor(EditColor, cl_Black);

  // RU: создаём само поле ввода с данными указанными выше и передаваемыми данными.
  // EN: create the input field itself with the data specified above and the data that needs to be transferred.
  myEdit := CreateEdit(myRect, fntEdit, EScale, @EditCont);

  // RU: корректируем курсор.
  // EN: adjust the cursor.
  CorrectEditCursor(myEdit, 2);

  {$Else}
  inputRect.X := 400 - 192;
  inputRect.Y := 300 - 100 - 32;
  inputRect.W := 384;
  inputRect.H := 96;
  {$EndIf}
  // RU: задаём очистку экрана заданным цветом.
  // EN: set the screen to clear with a specified color.
  scr_SetClearColor(true, $7090af);

  CreateTouchKeyboard;
  setFontTextScale(15, fntMain);
end;

procedure Draw;
var
  w : Single;
begin
  batch2d_Begin;
  setTextColor(Get_Color(cl_Blue));
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

  {$IfDef OLD_METHODS}
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
  {$Else}
{  text_Draw(fntMain, 0, 36, 'Press F5 to copy from Edit and draw');  // какой я нафиг англичанин? ))))
  text_Draw(fntMain, 0, 54, 'Press F12 - Rus/Eng');                   // переделать для Android
  if userInput <> '' then
    text_Draw(fntMain, 400, 300 - 70, userInput, TEXT_HALIGN_CENTER);  }
  {$EndIf}
  batch2d_End;
end;

{$IfDef OLD_METHODS}
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
{$EndIf}

procedure Restore;
begin
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  font_RestoreFromFile( fntMain, dirRes + 'font.zfi' );
  font_RestoreFromFile( fntEdit, dirRes + 'CalibriBold50pt.zfi' );
  tex_RestoreFromFile(JoyArrow, dirRes + 'arrow.png');
  file_CloseArchive();
  log_Add('Restored true!!!');
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  {$IfDef OLD_METHODS}
  TimerStart := timer_Add( @Timer, 16, t_Start );
  {$EndIf}

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  scr_SetOptions();
end;

exports
  Java_zengl_android_ZenGL_Main,
  {$I android_export.inc}
End.
