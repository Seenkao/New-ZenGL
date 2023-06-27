library demo02;
{$I zgl_config.cfg}
{$I zglCustomConfig.cfg}

uses
  zgl_application,
  zgl_types,
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
  dirRes : UTF8String = 'assets/';

  memory : zglTMemory;

  // RU: У каждого ресурса есть свой определённый тип, который является указателем на структуру.
  // EN: Every resource has its own typem which is just a pointer to structure.
  fntMain  : LongWord;
  //
  texLogo  : zglPTexture;
  texTest  : array[ 0..3 ] of zglPTexture;
  //
  sndClick : zglPSound;
  sndMusic : zglPSound;

  resLoaded : Boolean;

procedure TextureCalcEffect( pData : PByteArray; Width, Height : Word );
begin
  u_Sleep( 1000 );
end;

procedure Init;
  var
    i : Integer;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  // RU: Более детальное рассмотрение параметров функций загрузки ресурсов есть в соответствующих примерах, тут же показана лишь основная суть.
  // EN: Description with more details about parameters of functions can be found in other demos, here is only main idea shown.

  snd_Init();

  // RU: Основное отличие приложений Android от других заключается в том, что все ресурсы хранятся зачастую хранятся внутри apk-файла(обычный zip-архив).
  //     Поэтому перед загрузкой любых ресурсов необходимо сначала "открыть" этот apk-файл, а потом "закрыть".
  // EN: Main difference between Android application and others is containing resources in apk-file(just a zip archive).
  //     And that is why before loading of any resources this apk-file should be "opened" first, and then "closed".
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );

  // RU: Функции загрузки ресурсов именуются в формате "$(префикс)_LoadFrom$(откуда)", где "$(префикс)" может быть tex, snd, font и т.д., а "$(откуда)" - File и Memory.
  // EN: Functions for loading resources named in format "$(prefix)_LoadFrom$(where)", where "$(prefix)" can be tex, snd, font and so on, and $(where) - File and Memory.
  fntMain  := font_LoadFromFile( dirRes + 'font.zfi' );
  texLogo  := tex_LoadFromFile( dirRes + 'zengl.png' );
  sndClick := snd_LoadFromFile( dirRes + 'click.wav' );

  // RU: Не забываем "закрыть" apk-файл.
  // EN: Don't forget to "close" apk-file.
  file_CloseArchive();

  // RU: Многопоточная загрузка ресурсов позволяет составить очередь и не ожидать загрузки выполняя другие операции, например рендеринг какой-то анимации.
  //     Процесс загрузки в многопоточном режиме практически ничем не отличается от обычного за исключением вызова функций старта и окончания очереди.
  // EN: Multithreaded resource loading allows to make queue and do something while loading, e.g. rendering some animation.
  //     Loading resources in multithreaded mode has almost no difference with standard mode, except using functions for beginning and ending queues.
  res_BeginQueue( 0 );
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  // RU: Между res_BeginQueue и res_EndQueue могут использоваться все обычные функции загрузки ресурсов.
  //     Для задержки экрана загрузки ресурсы будут загружены несколько раз, а для текстуры будет использована обработка с задержкой.
  // EN: All standard functions for loading resources can be used between res_BeginQueue and res_EndQueue.
  //     Just for holding loading screen resources will be loaded multiple times, and texture will be post-processed with delay.
  zgl_Reg( TEXTURE_CURRENT_EFFECT, @TextureCalcEffect );
  for i := 0 to 3 do
    texTest[ i ]  := tex_LoadFromFile( dirRes + 'back01.jpg', TEX_NO_COLORKEY, TEX_DEFAULT_2D or TEX_CUSTOM_EFFECT );
  file_CloseArchive();
  res_EndQueue();
end;

procedure Draw;
begin
  // RU: К ресурсам, которые загружаются в многопоточном режиме, можно обращаться только после завершения загрузки. Код ниже рисует экран загрузки если ресурсы ещё не загрузились.
  // EN: Resources which are loading in multithreaded mode can be used only after finishing the loading process. Code below renders loading screen if resources are not loaded yet.
  if res_GetCompleted() < 100 Then
    begin
      ssprite2d_Draw( texLogo, ( 800 - texLogo^.Width ) / 2, ( 600 - texLogo^.Height ) / 2, texLogo^.Width, texLogo^.Height, 0 );
      text_Draw( fntMain, 400, 300 + texLogo^.Height / 4, 'Loading... ' + u_IntToStr( res_GetCompleted() ) + '%', TEXT_HALIGN_CENTER );
      exit;
    end;

  ssprite2d_Draw( texTest[ 0 ], 0, 0, 800, 600, 0 );
  text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
  text_Draw( fntMain, 0, 16, 'VRAM Used: ' + u_FloatToStr( zgl_Get( RENDER_VRAM_USED ) / 1024 / 1024 ) + 'Mb' );
end;

procedure Activate( active : Boolean );
begin
  // RU: Из-за проблемы в OpenAL на платформе Android(в фоном режиме приложение продолжает грузить CPU), звуковую подсистему
  //     необходимо останавливать и перезапускать, но только при потере/получении фокуса приложением.
  // EN: Because of problem inside OpenAL on Android(application continue load CPU in background), sound susbsytem should be
  //     stopped and reloaded when application loses/gets the focus.

  if active Then
    begin
      // RU: Перезапускаем звуковую подсистему.
      // EN: Reload sound subsystem.
      snd_Init();

      file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
      sndClick := snd_LoadFromFile( dirRes + 'click.wav' );
      file_CloseArchive();
    end else
      snd_Free();
end;

procedure Restore;
  var
    i : Integer;
begin
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );

  font_RestoreFromFile( fntMain, dirRes + 'font.zfi' );
  tex_RestoreFromFile( texLogo, dirRes + 'zengl.png' );

  file_CloseArchive();

  res_BeginQueue( 0 );
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  for i := 0 to 3 do
    tex_RestoreFromFile( texTest[ i ], dirRes + 'back01.jpg' );
  file_CloseArchive();
  res_EndQueue();
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_ACTIVATE, @Activate );
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  scr_SetOptions();
end;

exports
  Java_zengl_android_ZenGL_Main,
  {$I android_export.inc}
End.
