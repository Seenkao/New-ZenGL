program demo07;

{$I zglCustomConfig.cfg}

{$R *.res}

uses
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_camera_2d,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_textures_jpg,
  zgl_sprite_2d,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_types,
  zgl_utils;

type
  TTux = record
    Texture : zglPTexture;
    Frame   : Integer;
    Pos     : zglTPoint2D;
end;

var
  dirRes      : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain     : Byte;
  texLogo     : zglPTexture;
  texBack     : zglPTexture;
  texGround   : zglPTexture;
  texTuxWalk  : zglPTexture;
  texTuxStand : zglPTexture;
  tux         : array[0..20] of TTux;
  time        : Integer;
  camMain     : zglTCamera2D;

  TimeStart: Byte;
procedure Init;
  var
    i : Integer;
begin
  // RU: �.�. �� ��������� ��� ��������� ������ ����������� ������, ������� ���������������� � ������������ ����������.
  // EN: Camera must be initialized, because camera structure is zero-filled by default.
  cam2d_Init(camMain);

  // RU: ��������� ��������.
  //     $FF000000 - ��������� �� ��, ��� �� ������������ �����-����� �� �����������.
  //     TEX_DEFAULT_2D - �������� ������, ����������� ��� 2D-��������. �������� ���� � �������.
  // EN: Load the texture.
  //     $FF000000 - means that alpha channel must be used from file, without colorkey.
  //     TEX_DEFAULT_2D - complex of flags that needed for 2D sprites. Description can be found in help.
  texLogo := tex_LoadFromFile(dirRes + 'zengl.png', $FF000000, TEX_DEFAULT_2D);

  texBack := tex_LoadFromFile(dirRes + 'back01.jpg');

  texGround := tex_LoadFromFile(dirRes + 'ground.png');
  // RU: ��������� ������ ����� � ��������.
  // EN: Set the size of single frame for texture.
  tex_SetFrameSize(texGround, 32, 32);

  texTuxWalk := tex_LoadFromFile(dirRes + 'tux_walking.png');
  tex_SetFrameSize(texTuxWalk, 64, 64);
  texTuxStand := tex_LoadFromFile(dirRes + 'tux_stand.png');
  tex_SetFrameSize(texTuxStand, 64, 64);

  for i := 0 to 9 do
  begin
    tux[i].Texture := texTuxWalk;
    tux[i].Frame   := random(19) + 2;
    tux[i].Pos.X   := i * 96;
    tux[i].Pos.Y   := 32;
  end;
  for i := 10 to 19 do
  begin
    tux[i].Texture := texTuxWalk;
    tux[i].Frame   := random(19) + 2;
    tux[i].Pos.X   := (i - 9) * 96;
    tux[i].Pos.Y   := 600 - 96;
  end;
  tux[20].Texture := texTuxStand;
  tux[20].Frame   := random(19) + 2;
  tux[20].Pos.X   := 400 - 32;
  tux[20].Pos.Y   := 300 - 64 - 4;

  // RU: ��������� �����.
  // EN: Load the font.
  fntMain := font_LoadFromFile(dirRes + 'font.zfi');
  setFontTextScale(15, fntMain);

  // RU: ������������� FPS.
  // EN: Set FPS.
  scr_SetFPS(60);
end;

procedure Draw;
var
  i : Integer;
  t : Single;
  ScaleF: LongWord;
begin
//  batch2d_Begin();          // �� ������������� ��� ��    not reccomended for PC
                              // use for Android and iOS
  ScaleF := 15;
  if time > 255 Then
  begin
      // RU: ��� ���������� �������������� ����� ��������� ������� ������ �����, �������� ��� ����� ��������� ��������.
      // EN: Rendering perfomance can be increased by disabling clearing the color buffer. This is a good idea because screen is full of objects.
    zgl_Disable(COLOR_BUFFER_CLEAR);

      // RU: ������ ������ ��� � ��������� 800�600 ��������� �������� back.
      // EN: Render the background with size 800x600 and using texture "back".
    ssprite2d_Draw(texBack, 0, 0, 800, 600, 0);

      // RU: ���������� ������� ������.
      // EN: Set the current camera.
    cam2d_Set(@camMain);

      // RU: ������ �����.
      // EN: Render the ground.
    for i := - 2 to 800 div 32 + 1 do
      asprite2d_Draw(texGround, i * 32, 96 - 12, 32, 32, 0, 2);
    for i := - 2 to 800 div 32 + 1 do
      asprite2d_Draw(texGround, i * 32, 600 - 32 - 12, 32, 32, 0, 2);

      // RU: ������ �������� ���������.
      // EN: Render penguins
    for i := 0 to 9 do
      if i = 2 Then
      begin
            // RU: ������ ������� � "�������" ��� ���������.
            // EN: Render the text in frame over penguins.
        t := text_GetWidth( fntMain, 'I''m so red...' ) * 0.75;
        pr2d_Rect(tux[i].Pos.X - 1, tux[i].Pos.Y - ScaleF + 4, t, ScaleF, $000000, 200, PR2D_FILL);
        pr2d_Rect(tux[i].Pos.X - 2, tux[i].Pos.Y - ScaleF + 3, t + 2, ScaleF + 2, $FFFFFF);
        text_DrawEx(fntMain, tux[i].Pos.X, tux[i].Pos.Y - ScaleF + 5, 1, 0, 'I''m so red...');
            // RU: ������ �������� �������� ��������� fx2d-������� � ���� FX_COLOR.
            // EN: Render red penguin using fx2d-function and flag FX_COLOR.
        fx2d_SetColor($FF0000);
        asprite2d_Draw(tux[i].Texture, tux[i].Pos.X, tux[i].Pos.Y, 64, 64, 0, tux[i].Frame div 2, 255, FX_BLEND or FX_COLOR);
      end else
      if i = 7 Then
      begin
        t := text_GetWidth(fntMain, '???') * 0.75;
        pr2d_Rect(tux[i].Pos.X + 32 - t / 2, tux[i].Pos.Y - ScaleF + 4, t, ScaleF, $000000, 200, PR2D_FILL);
        pr2d_Rect(tux[i].Pos.X + 32 - t / 2 - 1, tux[i].Pos.Y - ScaleF + 3, t + 2, ScaleF + 2, $FFFFFF);
        text_DrawEx(fntMain, tux[i].Pos.X + 32, tux[i].Pos.Y - ScaleF + 5, 1, 0, '???', 255, $FFFFFF, TEXT_HALIGN_CENTER);
                // RU: ������ �������� ���������� ��������� ���� FX_COLOR ��������� ����� � FX_COLOR_SET :)
                // EN: Render penguin ghost using flag FX_COLOR and mode FX_COLOR_SET :)
        fx_SetColorMode(FX_COLOR_SET);
        fx2d_SetColor($FFFFFF);
        asprite2d_Draw(tux[i].Texture, tux[i].Pos.X, tux[i].Pos.Y, 64, 64, 0, tux[i].Frame div 2, 155, FX_BLEND or FX_COLOR);
                // RU: ���������� ������� �����.
                // EN: Return default mode.
        fx_SetColorMode(FX_COLOR_MIX);
      end else
        asprite2d_Draw(tux[i].Texture, tux[i].Pos.X, tux[i].Pos.Y, 64, 64, 0, tux[i].Frame div 2);

      // RU: ������ ��������� �������� � �������� ������� ��������� ���� ��������� �������� FX2D_FLIPX.
      // EN: Render penguins, that go another way using special flag for flipping texture - FX2D_FLIPX.
    for i := 10 to 19 do
      if i = 13 Then
      begin
        t := text_GetWidth(fntMain, 'I''m so big...') * 0.75;
        pr2d_Rect(tux[i].Pos.X - 2, tux[i].Pos.Y - ScaleF - 10, t, ScaleF, $000000, 200, PR2D_FILL);
        pr2d_Rect(tux[i].Pos.X - 3, tux[i].Pos.Y - ScaleF - 11, t + 2, ScaleF + 2, $FFFFFF);
        text_DrawEx(fntMain, tux[i].Pos.X, tux[i].Pos.Y - ScaleF - 9, 1, 0, 'I''m so big...');
            // RU: ������ "��������" ��������. �.�. FX2D_SCALE ����������� ������ ������������ ������, �� �������� ������� ������� "�������".
            // EN: Render "big" penguin. It must be shifted up, because FX2D_SCALE scale sprite relative to the center.
        fx2d_SetScale(1.25, 1.25);
        asprite2d_Draw(tux[i].Texture, tux[i].Pos.X, tux[i].Pos.Y - 8, 64, 64, 0, tux[i].Frame div 2, 255, FX_BLEND or FX2D_FLIPX or FX2D_SCALE);
      end else
      if i = 17 Then
      begin
                // RU: ������ "��������" �������� ��������� ������ ����� FX2D_SCALE ���� FX2D_VCHANGE � ������� fx2d_SetVertexes ��� �������� ��������� ���� ������� ������ �������.
                // EN: Render "tall" penguin using flag FX2D_VCHANGE instead of FX2D_SCALE, and function fx2d_SetVertexes for shifting upper vertexes of sprite.
        fx2d_SetVertexes(0, -16, 0, -16, 0, 0, 0, 0);
        asprite2d_Draw(tux[i].Texture, tux[i].Pos.X, tux[i].Pos.Y, 64, 64, 0, tux[i].Frame div 2, 255, FX_BLEND or FX2D_FLIPX or FX2D_VCHANGE);
      end else
        asprite2d_Draw(tux[i].Texture, tux[i].Pos.X, tux[i].Pos.Y, 64, 64, 0, tux[i].Frame div 2, 255, FX_BLEND or FX2D_FLIPX);

      // RU: �������� ������.
      // EN: Reset the camera.
    cam2d_Set(nil);

      // RU: ������ ������� ����� �� ������ ������.
      // EN: Render piece of ground in the center of screen.
    asprite2d_Draw(texGround, 11 * 32, 300 - 16, 32, 32, 0, 1);
    asprite2d_Draw(texGround, 12 * 32, 300 - 16, 32, 32, 0, 2);
    asprite2d_Draw(texGround, 13 * 32, 300 - 16, 32, 32, 0, 3);

    t := text_GetWidth(fntMain, 'o_O') * 0.75;
    pr2d_Rect(tux[20].Pos.X + 32 - t / 2 - 1, tux[20 ].Pos.Y - ScaleF + 3, t + 2, ScaleF + 2, $000000, 200, PR2D_FILL);
    pr2d_Rect(tux[20].Pos.X + 32 - t / 2 - 2, tux[20 ].Pos.Y - ScaleF + 2, t + 4, ScaleF + 4, $FFFFFF);
    text_DrawEx(fntMain, tux[20].Pos.X + 32, tux[20].Pos.Y - ScaleF + 5, 1, 0, 'o_O', 255, $FFFFFF, TEXT_HALIGN_CENTER);
    asprite2d_Draw(tux[20].Texture, tux[20].Pos.X, tux[20].Pos.Y, 64, 64, 0, tux[20].Frame div 2);
  end;

  if time <= 255 Then
    ssprite2d_Draw(texLogo, 400 - 256, 300 - 128, 512, 256, 0, time)
  else
  if time < 510 Then
  begin
    pr2d_Rect(0, 0, 800, 600, $000000, 510 - time, PR2D_FILL);
    ssprite2d_Draw(texLogo, 400 - 256, 300 - 128, 512, 256, 0, 510 - time);
  end;

  if time > 255 Then
    text_Draw(fntMain, 0, 0, 'FPS: ' + u_IntToStr(zgl_Get(RENDER_FPS)));

//  batch2d_End();                // �� ������������� ��� ��    not reccomended for PC
                                  // use for Android and iOS
end;

procedure Timer;
  var
    i : Integer;
begin
  INC(time, 2);

  camMain.Angle := camMain.Angle + cos(time / 1000) / 10;

  for i := 0 to 20 do
    begin
      INC(tux[i].Frame );
      if tux[i].Frame > 20 Then
        tux[i].Frame := 2;
    end;
  for i := 0 to 9 do
    begin
      tux[i].Pos.X := tux[i].Pos.X + 1.5;
      if tux[i].Pos.X > 864 Then
        tux[i].Pos.X := - 96;
    end;
  for i := 10 to 19 do                      
    begin
      tux[i].Pos.X := tux[i].Pos.X - 1.5;
      if tux[i].Pos.X < - 96 Then
        tux[i].Pos.X := 864;
    end;
end;

Begin
  randomize();

  TimeStart := timer_Add(@Timer, 16, Start);

  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg(SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('07 - Sprites'));

  zgl_Init();
End.
