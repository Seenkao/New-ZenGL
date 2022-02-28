program demo12;

{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

{$R *.res}

uses
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_render_target,
  zgl_sprite_2d,
  zgl_font,
  zgl_text,
  zgl_math_2d,
  zgl_utils
  ;

var
  dirRes   : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain  : LongWord;
  texTux   : zglPTexture;
  rtFull   : zglPRenderTarget;
  rtDefault: zglPRenderTarget;

procedure Init;
begin
  texTux := tex_LoadFromFile(dirRes + 'tux_stand.png');
  tex_SetFrameSize(texTux, 64, 64);

  fntMain := font_LoadFromFile(dirRes + 'font.zfi');

  // RU: ������� RenderTarget � "�������" ������ ��������. � �������� �������� ����� ������� �������� rtarget.Surface ������ zglPTexture, ������� ��� �� ��������� ������� � ����, ��� ������� �
  //     tex_CreateZero. ������� ����� ������ ���� RT_FULL_SCREEN, ���������� �� ��, ��� �� � �������� ���������� ��� ���������� ������ � �� ������� 256x256(��� � ������ RT_DEFAULT).
  // EN: Create a RenderTarget and "bind" empty texture to it. Later texture can be changed via changing rtarget.Surface to another zglPTexture, the only requirement - the same size, that was
  //     set in tex_CreateZero. Also target use flag RT_FULL_SCREEN that responsible for rendering whole content of screen into target, not only region 256x256(like with flag RT_DEFAULT).
  rtFull := rtarget_Add(tex_CreateZero(256, 256), RT_FULL_SCREEN);

  // RU: ��� ��������� �������� ��� ���� RenderTarget � ������ RT_DEFAULT.
  // EN: Create one more RenderTarget with flag RT_DEFAULT for comparison.
  rtDefault := rtarget_Add(tex_CreateZero(256, 256), RT_DEFAULT);

  setFontTextScale(15, fntMain);
end;

procedure Draw;
begin
  // RU: ������������� ������� RenderTarget.
  // EN: Set current RenderTarget.
  rtarget_Set(rtFull);
  // RU: ������ � ����.
  // EN: Render to it.
  asprite2d_Draw(texTux, random(800 - 64), random(600 - 64), 64, 64, 0, random(9) + 1);
  // RU: ������������ � �������� �������.
  // EN: Return to default rendering.
  rtarget_Set(nil);

  rtarget_Set(rtDefault);
  asprite2d_Draw(texTux, random(800 - 64), random(600 - 64), 64, 64, 0, random(9) + 1);
  rtarget_Set(nil);

  // RU: ������ ������ ���������� RenderTarget'��.
  // EN: Render content of RenderTargets.
  ssprite2d_Draw(rtFull.Surface, (400 - 256) / 2, (600 - 256) / 2, 256, 256, 0);
  ssprite2d_Draw(rtDefault.Surface, (400 - 256) / 2 + 400, (600 - 256) / 2, 256, 256, 0);

  text_Draw(fntMain, 0, 0, 'FPS: ' + u_IntToStr(zgl_Get(RENDER_FPS)));
end;

Begin
  randomize();

  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg(SYS_DRAW, @Draw);

  wnd_SetCaption(utf8_Copy('12 - Render into Texture'));

  zgl_Init();
End.
