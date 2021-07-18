program demo04;

{$I zglCustomConfig.cfg}

{$R *.res}

uses
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_font,
  zgl_text,
  zgl_sprite_2d,
  zgl_textures,
  zgl_textures_png,
  zgl_textures_jpg,
  zgl_utils
  ;

var
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};

  fntMain : Byte;
  texBack : zglPTexture;

procedure Init;
begin
  fntMain := font_LoadFromFile(dirRes + 'font.zfi');
  texBack := tex_LoadFromFile(dirRes + 'back03.jpg');
  setFontTextScale(15, fntMain);
end;

procedure Draw;
begin
  ssprite2d_Draw(texBack, 0, 0, 800, 600, 0);

  text_Draw(fntMain, 0, 0, 'Escape - Exit' );
  text_Draw(fntMain, 0, 20 * 1, 'F1 - Fullscreen with desktop resolution and correction of aspect');
  text_Draw(fntMain, 0, 20 * 2, 'F2 - Fullscreen with desktop resolution and simple scaling');
  text_Draw(fntMain, 0, 20 * 3, 'F3 - Fullscreen with resolution 800x600');
  text_Draw(fntMain, 0, 20 * 4, 'F4 - Windowed mode');
end;

procedure KeyMouseEvent;
begin
  // RU: ������������� � ������������� ������������� �����. �������� ���� - ������������� � ������������� �����
  // ��������� ������� ���������� �������� ����� ������������, �� ��� ����
  //     ��������� ��������� �����������. ��� �������� �������� ��������� ������� � LCD.
  // EN: Recommended fullscreen mode for using. Main idea is switching to fullscreen mode using current desktop resolution of user and saving the aspect. This will avoid some problems
  //     with LCD's.
  if key_Press(K_F1) Then
  begin
      // RU: �������� ��������� ���������.
      // EN: Enable aspect correction.
    zgl_Enable(CORRECT_RESOLUTION);
      // RU: ���������� ���������� ��� ������� ���������� �������� ����������.
      // EN: Set resolution for what application was wrote.
    scr_CorrectResolution(800, 600);
    zgl_SetParam(zgl_Get(DESKTOP_WIDTH), zgl_Get(DESKTOP_HEIGHT), True, false);
{    wndWidth := zgl_Get(DESKTOP_WIDTH);
    wndHeight := zgl_Get(DESKTOP_HEIGHT);
    wndFullScreen := true;  }
    scr_SetOptions();
  end;

  // RU: ������ ����� � ���������� �� ����� ����������� - ��������� ��������� �� ������ � ������. ��������, ���������� ��������� �� ������ ����� ����������� ��� ����������
  //     ������ 5:4(���������� ������ 1280x1024), �.�. ����� ��������� ��� ������� ������ ��� ������������ ���������.
  // EN: Similar mode to previous one with one exception - disabled correction for width and height. E.g. this can be useful for aspect 5:4(resolution 1280x1024),
  //     because screen can be filled without significant distortion.
  if key_Press(K_F2) Then
  begin
    zgl_Enable(CORRECT_RESOLUTION);
    zgl_Disable(CORRECT_WIDTH);
    zgl_Disable(CORRECT_HEIGHT);
    scr_CorrectResolution(800, 600);
{    wndWidth := zgl_Get(DESKTOP_WIDTH);
    wndHeight := zgl_Get(DESKTOP_HEIGHT);
    wndFullScreen := true; }
    zgl_SetParam(zgl_Get(DESKTOP_WIDTH), zgl_Get(DESKTOP_HEIGHT), True, false);
    scr_SetOptions();
  end;

  // RU: ������������ � ������������� ����� ��������� ��������� �������. � ���� ����� ����� ������ ����� ��� ������� ���������� �� LCD:
  //     - ���� ����������� ���������� �� �������� ������ ��� LCD, �� ��� ����������� ���������� � ��������� ������������ ����� ��������� ������������
  //     - �� �������������� ��������� �������� � ������������ 4:3 ����� ��������� ����������
  // EN: Switching to fullscreen mode using set values. Nowadays this method two main problems with LCD:
  //     - if used resolution is not main for LCD, then without special options in drivers user will see pixelization
  //     - picture with aspect 4:3 will be stretched on widescreen monitors
  if key_Press(K_F3 ) Then
  begin
    zgl_Disable(CORRECT_RESOLUTION);
    zgl_SetParam(800, 600, true, false);
    scr_SetOptions();
  end;

  // ��� ���������, ����� ��� ������������� - ��� �������� ������������� �����!!! ������ - 1-� � 2-� ��� ������� ������,
  // � ������ - ��� �������������.
  // � ��� ��������, ��� ��� ���� �������� ������ �� ������ ������������ ������������!!!

  // RU: ������� �����.
  // EN: Windowed mode.
  if key_Press(K_F4) Then
  begin
    zgl_Disable(CORRECT_RESOLUTION);
{    wndWidth := 800;
    wndHeight := 600;
    wndFullScreen := false;  }
    zgl_SetParam(800, 600, False, false);
    scr_SetOptions();
  end;
end;

Begin
  zgl_Reg(SYS_EVENTS, @KeyMouseEvent);

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('04 - Screen Settings'));

  zgl_Init();
End.
