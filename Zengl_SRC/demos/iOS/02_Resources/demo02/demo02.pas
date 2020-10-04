program demo02;

{$I zglCustomConfig.cfg}

uses
  cthreads,
  Classes,

  zgl_types,
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  // RU: Модули для работы с файлами, файлами в памяти и zip-архивами.
  // EN: Units for using files, files in memory and zip archives.
  zgl_file,
  zgl_memory,
  // RU: Модуль для поддержки многопоточной загрузки ресурсов.
  // EN: Unit for multithreaded resource loading.
  zgl_resources,
  // RU: Модуль для работы со шрифтами.
  // EN: Unit for using fonts.
  zgl_font,
  // RU: Модули для работы с текстурами. zgl_textures является основным, следующие за ним предоставляют поддержку определённых форматов.
  // EN: Units for using textures. zgl_textures is a main unit, next units provide support of different formats.
  zgl_textures,
  zgl_textures_tga, // TGA
  zgl_textures_jpg, // JPG
  zgl_textures_png, // PNG
  // RU: Звуковая подсистема реализована в модулях ниже. Подход такой же как и с текстурами - основной модуль и модули поддержки форматов.
  // EN: Sound subsystem implemented in units below. Idea the same as for textures - there is a main unit and units for support different formats.
  zgl_sound,
  zgl_sound_wav, // WAV
  zgl_sound_ogg, // OGG

  zgl_primitives_2d,
  zgl_text,
  zgl_sprite_2d,
  zgl_utils
  ;

var
  dirRes : UTF8String = 'data/';

  memory : zglTMemory;

  // RU: У каждого ресурса есть свой определённый тип, который является указателем на структуру.
  // EN: Every resource has its own typem which is just a pointer to structure.
  fntMain  : zglPFont;
  //
  texLogo  : zglPTexture;
  texTest  : zglPTexture;
  //
  sndClick : zglPSound;
  sndMusic : zglPSound;

procedure TextureCalcEffect( pData : PByteArray; Width, Height : Word );
begin
  u_Sleep( 1000 );
end;

procedure Init;
  var
    i         : Integer;
    memStream : TMemoryStream;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  // RU: Более детальное рассмотрение параметров функций загрузки ресурсов есть в соответствующих примерах, тут же показана лишь основная суть.
  // EN: Description with more details about parameters of functions can be found in other demos, here is only main idea shown.

  snd_Init();

  // RU: Функции загрузки ресурсов именуются в формате "$(префикс)_LoadFrom$(откуда)", где "$(префикс)" может быть tex, snd, font и т.д., а "$(откуда)" - File и Memory.
  // EN: Functions for loading resources named in format "$(prefix)_LoadFrom$(where)", where "$(prefix)" can be tex, snd, font and so on, and $(where) - File and Memory.
  fntMain  := font_LoadFromFile( dirRes + 'font.zfi' );
  texLogo  := tex_LoadFromFile( dirRes + 'zengl.png' );
  sndClick := snd_LoadFromFile( dirRes + 'click.wav' );

  // RU: Многопоточная загрузка ресурсов позволяет составить очередь и не ожидать загрузки выполняя другие операции, например рендеринг какой-то анимации.
  //     Процесс загрузки в многопоточном режиме практически ничем не отличается от обычного за исключением вызова функций старта и окончания очереди.
  // EN: Multithreaded resource loading allows to make queue and do something while loading, e.g. rendering some animation.
  //     Loading resources in multithreaded mode has almost no difference with standard mode, except using functions for beginning and ending queues.
  res_BeginQueue( 0 );
  // RU: Между res_BeginQueue и res_EndQueue могут использоваться все обычные функции загрузки ресурсов.
  //     Для задержки экрана загрузки ресурсы будут загружены несколько раз, а для текстуры будет использована обработка с задержкой.
  // EN: All standard functions for loading resources can be used between res_BeginQueue and res_EndQueue.
  //     Just for holding loading screen resources will be loaded multiple times, and texture will be post-processed with delay.
  zgl_Reg( TEX_CURRENT_EFFECT, @TextureCalcEffect );
  for i := 0 to 3 do
    begin
      texTest  := tex_LoadFromFile( dirRes + 'back01.jpg', TEX_NO_COLORKEY, TEX_DEFAULT_2D or TEX_CUSTOM_EFFECT );
      sndMusic := snd_LoadFromFile( dirRes + 'music.ogg' );
    end;
  res_EndQueue();

  // RU: Загружая ресурсы из файлов в памяти необходимо дополнительно указывать их расширение.
  //     В качестве примера будет использован TMemoryStream вместо mem_LoadFromFile/mem_Free что бы показать как устроен zglTMemory.
  // EN: Loading resources from files in memory need additional set their extension.
  //     As an example TMemoryStream will be used instead of mem_LoadFromFile/mem_Free, just for showing how zglTMemory works.
  memStream := TMemoryStream.Create();
  memStream.LoadFromFile( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) + dirRes + 'back01.jpg' );
  memory.Position := memStream.Position;
  memory.Memory   := memStream.Memory;
  memory.Size     := memStream.Size;
  texTest := tex_LoadFromMemory( memory, 'JPG' );
  memStream.Free();

  // RU: Для загрузки ресурсов из zip-архива необходимо его сначала "открыть" и потом "закрыть" :) Для этого существуют функции file_OpenArchive и file_CloseArchive.
  // EN: For loading resources from zip-archive this archive should be "opened" first and then "closed" :) There are functions file_OpenArchive and file_CloseArchive for this.
  file_OpenArchive( dirRes + 'zengl.zip' );
  texLogo := tex_LoadFromFile( 'zengl.png' );
  file_CloseArchive();
end;

procedure Draw;
begin
  // RU: К ресурсам, которые загружаются в многопоточном режиме, можно обращаться только после завершения загрузки. Код ниже рисует экран загрузки если ресурсы ещё не загрузились.
  // EN: Resources which are loading in multithreaded mode can be used only after finishing the loading process. Code below renders loading screen if resources are not loaded yet.
  if res_GetCompleted() < 100 Then
    begin
      ssprite2d_Draw( texLogo, ( 800 - texLogo.Width ) / 2, ( 600 - texLogo.Height ) / 2, texLogo.Width, texLogo.Height, 0 );
      text_Draw( fntMain, 400, 300 + texLogo.Height / 4, 'Loading... ' + u_IntToStr( res_GetCompleted() ) + '%', TEXT_HALIGN_CENTER );
      exit;
    end;

  ssprite2d_Draw( texTest, 0, 0, 800, 600, 0 );
  text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
  text_Draw( fntMain, 0, 16, 'VRAM Used: ' + u_FloatToStr( zgl_Get( RENDER_VRAM_USED ) / 1024 / 1024 ) + 'Mb' );
end;

Begin
  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );

  zgl_Init();
End.
