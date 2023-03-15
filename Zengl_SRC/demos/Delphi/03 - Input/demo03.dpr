program demo03;

{$I zglCustomConfig.cfg}
{.$I zgl_config.cfg}

{$R *.res}

uses
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_mouse,
  zgl_keyboard,
  zgl_joystick,
  zgl_primitives_2d,
  zgl_render_2d,
  zgl_font,
  zgl_text,
  zgl_textures_png,
  zgl_types,
  {$IfDef OLD_METHODS}
  zgl_collision_2d,
  {$Else}
  gegl_VElements,
  {$EndIf}
  gegl_color,
  zgl_utils
  ;

var
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};

  joyCount   : Integer;
  // RU: ������ ��� ��������� �������� �� ���� �����
  // EN: string to get value from input field
  userInput  : UTF8String;
  {$IfDef OLD_METHODS}
  trackInput : Boolean;
  inputRect  : zglTRect;
  lineAlpha  : LongWord;

  TimeStart  : LongWord;
  {$Else}
  // Rus: ������ �������. ��� ������ �� �������� ���������� ������ �� ���� �������.
  // Eng: font numbers. All work with fonts comes from these numbers.
  fntMain, fntEdit: LongWord;

  // Rus: ����� �����. ������ � ������ ���������� ������ �� ����� ������.
  // Eng: color number. Work with color comes from this number.
  EditColor: LongWord;
  // RU: ������������� ����������� ���� �����
  // EN: rectangle describing the input field
  myRect: zglTRect2D;

  // "��������" ����� ����� ��� ����, ���� ����� � ����� ����� ��������.
  // RU: ��������� ���������� ��� ������ � ����� �����
  // EN: we declare a variable to work with the input field
  myEdit, myEdit2: LongWord;

// RU: ������������� ��������� ���� �����. �� ���������� ������ ����� ������������. )))
// EN: draw the base of the input field. Everything is limited only by your imagination. )))
procedure EditCont;
begin
  // RU: ��� ���������� ���� �����, �������� � ������� ��� ����� �������. � ��������� ��� ���������� �����.
  //     ����� ����� ������� ������ ����, ��� �� ����� ���������.
  // EN: displacement and rotation will be done prior to performing the procedure. I am showing you how to draw a frame.
  //     The text will be drawn on top of what you draw here.
  pr2d_Rect(- 2, - 1, myRect.W + 5, myRect.H,  {$IfnDef OLD_METHODS}cl_White{$else}, $FFFFFF, 128{$EndIf}, PR2D_FILL);
end;
  {$EndIf}

procedure Init;
{$IfNDef OLD_METHODS}
var
  EScale: LongWord;
{$EndIf}
begin
  fntMain := font_LoadFromFile(dirRes + 'font.zfi');
  {$IfNDef OLD_METHODS}
  // RU: ��������� ������ � ������.
  // EN: Load the font.
  fntEdit := font_LoadFromFile( dirRes + 'CalibriBold50pt.zfi');

//------------------------------------------------------------------------------
// RU: ������ ��� ����������� ����������. ����������������, ���� ������ ������������ ����������� ���������� ��� ��.
// EN: Data for the virtual keyboard. Uncomment if you will use the virtual keyboard for PC.

  // ������������ ���! ������ ��� ����������� ����������.
  // RU: ��������� ������ � ������.
  // EN: Load the font.
//   fontUse := font_LoadFromFile(dirRes + 'CalibriBold50pt.zfi');
//   JoyArrow := tex_LoadFromFile(dirRes + 'arrow.png');     // ��������� ��������
//   tex_SetFrameSize(JoyArrow, 64, 64);                     // � ������� � �� �����, �� � ������� �� ����� ������� ���������� ���������� �������
  // RU: ������ ��� ����������� ����������.
  // EN: Data for the virtual keyboard.
//   txt_LoadFromFile(dirRes + 'Rus.txt', LoadText);
  // RU: ������ ����������� ����������. ��� ��������� ������ ��� ����� ������������ ����� � ����������.
  // EN: We create a virtual keyboard. For mobile systems, this will be a mandatory code in the future.
//   CreateTouchKeyboard;

// RU: ����� ������ ��� ����������� ���������� �������������.
// EN: here the data for the virtual keyboard ends.
//------------------------------------------------------------------------------

  // RU: ��������� ������� �������
  // EN: set font sizes
  setFontTextScale(15, fntMain);
  setFontTextScale(20, fntEdit);
  // RU: ������ ������ ���� ����� (��� ��������� ��� ����������). ������� ������ ������, �� ������ ������ �
  //     ������� ���� ����� - myRect � ������ ������. ���� ��� �� ���������.
  // EN: the font size of the input field (to understand what's going on). By changing the font size,
  //     we must also change the size of the input field - myRect in this case. They themselves will not change.
  EScale := 20;
  setFontTextScale(EScale, fntEdit);
  // RU: ��������� ������� ���� �����
  // EN: specify the size of the input field
  myRect.X := 200;
  myRect.Y := 150;
  myRect.W := 200;
  myRect.H := 33;
  // RU: ��������� ����� ��������, � ������ ������ ����� ���� �����(�� �������������) � ���� ��������(�������� 45)
  // EN: specify the point of rotation, in this case the center of the input field (if necessary) and the angle of rotation (for example 45)
  SetOfRotateAngleAndPoint(myRect.x + myRect.W / 2, myRect.y + myRect.H / 2, 30);

  // RU: ��������� ���� ������ (��������� ����� ����� �����, ���� ������ ������� ��� ��������� ����, ���� �� ��� ��� ��������).
  // EN: specify the color of the text (we add a new color number, although this function will return the color to you if it
  //     has already been assigned).
  EditColor := Color_FindOrAdd($208055FF);
  // Ru: ������������� ����� �� ��������� ��� ����  ��������� API. ��� ����� ����� ������������� ������ ��� ��������
  //     ������������ ��������. ��� ��������� ����� � ����� (��� ���������) ��������, �� ���� �� �����������.
  //     ���������� �������� ���� �������� �����, �� ��� �� �������� �� ��� ��������� ���������.
  // En: set default colors for all API elements. These colors will only be used when creating a specific element.
  //     To change the color in the (already created) element itself, nothing is attached. Further changes to these
  //     color values will not affect the already created elements in any way.
  SetDefColor(EditColor, cl_Green, cl_Black);

  // RU: ������ ���� ���� ����� � ������� ���������� ���� � ������������� �������
  // EN: create the input field itself with the data specified above and the data that needs to be transferred
  myEdit := CreateEdit(myRect, fntEdit, EScale, @EditCont);

  // RU: ������������ ������.
  // EN: adjust the cursor.
  CorrectEditCursor(myEdit, 3);

  // RU: ����� ������� ������ �������� ������
  // EN: set the screen to clear with a specified color
  scr_SetClearColor(true, $7090af);

  {$Else}
  inputRect.X := 400 - 192;
  inputRect.Y := 300 - 100 - 32;
  inputRect.W := 384;
  inputRect.H := 96;
  setFontTextScale(15, fntMain);
  {$EndIf}

  // RU: �������������� ��������� ����� ���������� � �������� ���������� ������������ ����������.
  // EN: Initialize processing joystick input and get count of plugged joysticks.
  joyCount := joy_Init();
end;

procedure Draw;
{$IfDef OLD_METHODS}
var
  w : Single;
{$EndIf}
begin
  batch2d_Begin;
  // Ru: �������� ������ ������.
  // En: indulge in the color of the font.
  setTextColor(Get_Color(cl_Blue));
  text_Draw(fntMain, 0, 0, 'Escape - Exit');

  setTextColor(Get_Color(cl_White));
  // RU: ���������� ���� ����� �������� ��� ������ ������� mouse_X � mouse_Y.
  // EN: Mouse coordinates can be got using functions mouse_X and mouse_Y.
  text_Draw(fntMain, 0, 16, 'Mouse X, Y: ' + u_IntToStr(mouseX) + '; ' + u_IntToStr(mouseY));

  {$IfDef OLD_METHODS}
  // RU: ������� �������� ������������� �����.
  // EN: Show the inputted text.
  pr2d_Rect(inputRect.X, inputRect.Y, inputRect.W, inputRect.H, $FFFFFF, 255);
  if trackInput Then
  begin
    text_Draw(fntMain, 400, 300 - 100, 'Press Enter to stop track text input:', TEXT_HALIGN_CENTER);
    w := text_GetWidth( fntMain, userInput);
    pr2d_Rect(400 + w / 2 + 2, 300 - 70, 10, 20, $FFFFFF, lineAlpha, PR2D_FILL);
  end else
    text_Draw(fntMain, 400, 300 - 100, 'Click here to enter text(maximum - 24 symbols):', TEXT_HALIGN_CENTER);
  text_Draw(fntMain, 400, 300 - 70, userInput, TEXT_HALIGN_CENTER);
  {$Else}
  text_Draw(fntMain, 0, 36, 'Press F5 to copy from Edit and draw');  // ����� � ����� ����������? ))))
  text_Draw(fntMain, 0, 54, 'Press F12 - Rus/Eng');
  if userInput <> '' then
    text_Draw(fntMain, 400, 300 - 70, userInput, TEXT_HALIGN_CENTER);
  {$EndIf}

  // RU: ����� ��������� ���� � ������ ������� ��������� � �������.
  // EN: Show the state of axes and buttons of first joystick in the system.
  text_Draw(fntMain, 400, 360, 'JOYSTICK ( Found: ' + u_IntToStr(joyCount) + ' )', TEXT_HALIGN_CENTER);

  setTextColor(Get_Color(cl_Black));
  text_Draw( fntMain, 100, 400, 'Axis X: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_X ) ) );
  text_Draw( fntMain, 100, 420, 'Axis Y: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_Y ) ) );
  setTextColor(Get_Color(cl_Black05));
  text_Draw( fntMain, 100, 440, 'Axis Z: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_Z ) ) );
  setTextColor(Get_Color(cl_Green));
  text_Draw( fntMain, 100, 460, 'Axis R: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_R ) ) );
  text_Draw( fntMain, 100, 480, 'Axis U: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_U ) ) );
  setTextColor(Get_Color(cl_Green05));
  text_Draw( fntMain, 100, 500, 'Axis V: ' + u_FloatToStr( joy_AxisPos( 0, JOY_AXIS_V ) ) );
  text_Draw( fntMain, 100, 520, 'POVX: ' + u_FloatToStr( joy_AxisPos( 0, JOY_POVX ) ) );
  text_Draw( fntMain, 100, 540, 'POVY: ' + u_FloatToStr( joy_AxisPos( 0, JOY_POVY ) ) );

  setTextColor(Get_Color(cl_Red05));
  text_Draw(fntMain, 400, 400, 'Button1: ' + u_BoolToStr(joy_Down(0, 0)));
  text_Draw(fntMain, 400, 420, 'Button2: ' + u_BoolToStr(joy_Down(0, 1)));
  text_Draw(fntMain, 400, 440, 'Button3: ' + u_BoolToStr(joy_Down(0, 2)));
  text_Draw(fntMain, 400, 460, 'Button4: ' + u_BoolToStr(joy_Down(0, 3)));
  text_Draw(fntMain, 400, 480, 'Button5: ' + u_BoolToStr(joy_Down(0, 4)));
  text_Draw(fntMain, 400, 500, 'Button6: ' + u_BoolToStr(joy_Down(0, 5)));
  text_Draw(fntMain, 400, 520, 'Button7: ' + u_BoolToStr(joy_Down(0, 6)));
  text_Draw(fntMain, 400, 540, 'Button8: ' + u_BoolToStr(joy_Down(0, 7)));
  text_Draw(fntMain, 550, 400, 'Button9: ' + u_BoolToStr(joy_Down(0, 8)));
  text_Draw(fntMain, 550, 420, 'Button10: ' + u_BoolToStr(joy_Down(0, 9)));
  text_Draw(fntMain, 550, 440, 'Button11: ' + u_BoolToStr(joy_Down(0, 10)));
  text_Draw(fntMain, 550, 460, 'Button12: ' + u_BoolToStr(joy_Down(0, 11)));
  text_Draw(fntMain, 550, 480, 'Button13: ' + u_BoolToStr(joy_Down(0, 12)));
  text_Draw(fntMain, 550, 500, 'Button14: ' + u_BoolToStr(joy_Down(0, 13)));
  text_Draw(fntMain, 550, 520, 'Button15: ' + u_BoolToStr(joy_Down(0, 14)));
  text_Draw(fntMain, 550, 540, 'Button16: ' + u_BoolToStr(joy_Down(0, 15)));
  batch2d_End;
end;

{$IfDef OLD_METHODS}
procedure Timer;
begin
  if lineAlpha > 5 Then
    DEC(lineAlpha, 10)
  else
    lineAlpha := 255;
end;
{$EndIf}

procedure KeyMouseEvent;
begin
  {$IfDef OLD_METHODS}
  // RU: ��������� ������ �� ����� ������ ���� � �������� inputRect � ������ ����������� ���� ������.
  // EN: Check if left mouse button was pressed inside inputRect and start to track text input.
  if mouseBClick(M_BLEFT) and col2d_PointInRect(mouseX, mouseY, inputRect) Then
  begin
    trackInput := TRUE;
    key_BeginReadText(userInput, 24);
  end;

  // RU: ���� ��� ����� Enter ���������� ����������� ���� ������.
  // EN: Finish to track text input if Enter was pressed.
  if key_Press(K_ENTER) Then
  begin
    trackInput := FALSE;
    key_EndReadText();
  end;

  // RU: �������� �������� ������������� �����.
  // EN: Get inputted by user text.
  if trackInput Then
    userInput := key_GetText();
  {$Else}
  // RU: �� ������� F5 �������� ��, ��� �������� � ���� �����
  // EN: by pressing F5, copy what is written in the input field
  if keysDown[K_F5] then
  begin
    userInput := GetEditToText(myEdit);
  end;
  {$EndIf}
end;

Begin
  {$IfDef OLD_METHODS}
  TimeStart := timer_Add(@Timer, 16, t_Start);
  {$EndIf}

  zgl_Reg(SYS_EVENTS, @KeyMouseEvent);
  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg(SYS_DRAW, @Draw);

  wnd_SetCaption(utf8_Copy('03 - Input'));

  zgl_Init();
End.
