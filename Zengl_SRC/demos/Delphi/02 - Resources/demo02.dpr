program demo02;

{$I zglCustomConfig.cfg}

{$R *.res}

uses
{$IFDEF UNIX}
  cthreads,
{$ENDIF}
  Classes,

  zgl_types,
  zgl_screen,
  zgl_window,
  zgl_application,
  zgl_timers,
  // RU: ������ ��� ������ � �������, ������� � ������ � zip-��������.
  // EN: Units for using files, files in memory and zip archives.
  zgl_file,
  zgl_memory,
  // RU: ������ ��� ��������� ������������� �������� ��������.
  // EN: Unit for multithreaded resource loading.
  zgl_resources,
  // RU: ������ ��� ������ �� ��������.
  // EN: Unit for using fonts.
  zgl_font,
  // RU: ������ ��� ������ � ����������. zgl_textures �������� ��������, ��������� �� ��� ������������� ��������� ����������� ��������.
  // EN: Units for using textures. zgl_textures is a main unit, next units provide support of different formats.
  zgl_textures,
  zgl_textures_tga, // TGA
  zgl_textures_jpg, // JPG
  zgl_textures_png, // PNG
  // RU: �������� ���������� ����������� � ������� ����. ������ ����� �� ��� � � ���������� - �������� ������ � ������ ��������� ��������.
  // EN: Sound subsystem implemented in units below. Idea the same as for textures - there is a main unit and units for support different formats.
  zgl_sound,
  zgl_sound_wav, // WAV
  zgl_sound_ogg, // OGG

  zgl_primitives_2d,
  zgl_text,
  zgl_sprite_2d,
  zgl_utils;

var
  dirRes: UTF8String{$IFNDEF MACOSX} = '../data/'{$ENDIF};

(*   dirRes: UTF8String{$IFNDEF MACOSX} = 'data/'{$ENDIF};     // ����������� �� ������������ �����
                                                               // � Windows, Linux ������������ ����������� �� ������ �������� ������� *)

  memory: zglTMemory;

  // RU: � ������� ������� ���� ���� ����������� ���, ������� �������� ���������� �� ���������.
  // EN: Every resource has its own typem which is just a pointer to structure.
  fntMain: zglPFont;
  //
  texLogo: zglPTexture;
  texTest: zglPTexture;
  //
  sndClick: zglPSound;
  sndMusic: zglPSound;

procedure TextureCalcEffect(pData: PByteArray; Width, Height: Word);
begin
  u_Sleep(1000);
end;

procedure Init;
var
  i: Integer;
  memStream: TMemoryStream;
begin
  file_SetPath('');           // ���������� ����������� ��� ������ ����-������
  // � ����� ������� ������� ���������� �� ����!!!

  // RU: ����� ��������� ������������ ���������� ������� �������� �������� ���� � ��������������� ��������, ��� �� �������� ���� �������� ����.
  // EN: Description with more details about parameters of functions can be found in other demos, here is only main idea shown.
  snd_Init();

  // RU: ������� �������� �������� ��������� � ������� "$(�������)_LoadFrom$(������)", ��� "$(�������)" ����� ���� tex, snd, font � �.�., � "$(������)" - File � Memory.
  // EN: Functions for loading resources named in format "$(prefix)_LoadFrom$(where)", where "$(prefix)" can be tex, snd, font and so on, and $(where) - File and Memory.
  fntMain := font_LoadFromFile(dirRes + 'font.zfi');
  texLogo := tex_LoadFromFile(dirRes + 'zengl.png');
  sndClick := snd_LoadFromFile(dirRes + 'click.wav');

  // RU: ������������� �������� �������� ��������� ��������� ������� � �� ������� �������� �������� ������ ��������, �������� ��������� �����-�� ��������.
  //     ������� �������� � ������������� ������ ����������� ����� �� ���������� �� �������� �� ����������� ������ ������� ������ � ��������� �������.
  // EN: Multithreaded resource loading allows to make queue and do something while loading, e.g. rendering some animation.
  //     Loading resources in multithreaded mode has almost no difference with standard mode, except using functions for beginning and ending queues.
  res_BeginQueue(0);
  // RU: ����� res_BeginQueue � res_EndQueue ����� �������������� ��� ������� ������� �������� ��������.
  //     ��� �������� ������ �������� ������� ����� ��������� ��������� ���, � ��� �������� ����� ������������ ��������� � ���������.
  // EN: All standard functions for loading resources can be used between res_BeginQueue and res_EndQueue.
  //     Just for holding loading screen resources will be loaded multiple times, and texture will be post-processed with delay.
  zgl_Reg(TEXTURE_CURRENT_EFFECT, @TextureCalcEffect);
  for i := 0 to 3 do
  begin
    texTest := tex_LoadFromFile(dirRes + 'back01.jpg', TEX_NO_COLORKEY,
      TEX_DEFAULT_2D or TEX_CUSTOM_EFFECT);
    sndMusic := snd_LoadFromFile(dirRes + 'music.ogg');
  end;
  res_EndQueue();

  // RU: �������� ������� �� ������ � ������ ���������� ������������� ��������� �� ����������.
  //     � �������� ������� ����� ����������� TMemoryStream ������ mem_LoadFromFile/mem_Free ��� �� �������� ��� ������� zglTMemory.
  // EN: Loading resources from files in memory need additional set their extension.
  //     As an example TMemoryStream will be used instead of mem_LoadFromFile/mem_Free, just for showing how zglTMemory works.
  memStream := TMemoryStream.Create();
{$IFNDEF MACOSX}
  memStream.LoadFromFile(dirRes + 'back01.jpg');
{$ELSE}
  memStream.LoadFromFile(PAnsiChar(zgl_Get(DIRECTORY_APPLICATION)) +
    'Contents/Resources/back01.jpg');
{$ENDIF}
  memory.Position := memStream.Position;
  memory.Memory := memStream.Memory;
  memory.Size := memStream.Size;
  texTest := tex_LoadFromMemory(memory, 'JPG');
  memStream.Free();

  // RU: ��� �������� �������� �� zip-������ ���������� ��� ������� "�������" � ����� "�������" :) ��� ����� ���������� ������� file_OpenArchive � file_CloseArchive.
  // EN: For loading resources from zip-archive this archive should be "opened" first and then "closed" :) There are functions file_OpenArchive and file_CloseArchive for this.
  file_OpenArchive(dirRes + 'zengl.zip');
  texLogo := tex_LoadFromFile('zengl.png');
  file_CloseArchive();

  setTextScale(1.5);                                            // ���������� ������ ������
end;

procedure Draw;
begin
  // RU: � ��������, ������� ����������� � ������������� ������, ����� ���������� ������ ����� ���������� ��������. ��� ���� ������ ����� �������� ���� ������� ��� �� �����������.
  // EN: Resources which are loading in multithreaded mode can be used only after finishing the loading process. Code below renders loading screen if resources are not loaded yet.
  if res_GetCompleted() < 100 then
  begin
    ssprite2d_Draw(texLogo, (800 - texLogo.Width) / 2, (600 - texLogo.Height) /
      2, texLogo.Width, texLogo.Height, 0);
    text_Draw(fntMain, 400, 300 + texLogo.Height / 4, 'Loading... ' +
      u_IntToStr(res_GetCompleted()) + '%', TEXT_HALIGN_CENTER);
    exit;
  end;

  ssprite2d_Draw(texTest, 0, 0, 800, 600, 0);
  text_Draw(fntMain, 0, 0, 'FPS: ' + u_IntToStr(zgl_Get(RENDER_FPS)));
  text_Draw(fntMain, 0, 16, 'VRAM Used: ' +
    u_FloatToStr(zgl_Get(RENDER_VRAM_USED) / 1024 / 1024) + 'Mb');
end;

begin

  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg(SYS_DRAW, @Draw);

  wnd_SetCaption(utf8_Copy('02 - Resources'));

  zgl_SetParam(800, 600, false, false);

  zgl_Init();
end.

