program demo01;

// RU: Этот файл содержит некоторые настройки(например использовать ли статическую компиляцию) и определения ОС под которую происходит компиляция.
// EN: This file contains some options(e.g. whether to use static compilation) and defines of OS for which is compilation going.
{$I zglCustomConfig.cfg}

uses
  {$IFDEF USE_ZENGL_STATIC}
  // RU: При использовании статической компиляции необходимо подключать модули ZenGL содержащие необходимый функционал.
  // EN: Using static compilation needs to use ZenGL units with needed functionality.
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_utils
  {$ELSE}
  // RU: Используя ZenGL в качестве библиотеки(so, dll или dylib) нужен всего один заголовочный файл.
  // EN: Using ZenGL as a shared library(so, dll or dylib) needs only one header.
  zglHeader
  {$ENDIF}
  ;

var
  DirApp  : UTF8String;
  DirHome : UTF8String;

procedure Init;
begin
  // RU: Тут можно выполнять загрузку основных ресурсов.
  // EN: Here can be loading of main resources.
end;

procedure Draw;
begin
  // RU: Тут "рисуем" что угодно :)
  // EN: Here "draw" anything :)
end;

procedure Update( dt : Double );
begin
  // RU: Эта функция наземенима для реализация плавного движения чего-либо, т.к. точность таймеров ограничена FPS.
  // EN: This function is the best way to implement smooth moving of something, because accuracy of timers are restricted by FPS.
end;

procedure Timer;
begin
  // RU: Будем в заголовке показывать количество кадров в секунду.
  // EN: Caption will show the frames per second.
  wnd_SetCaption( '01 - Initialization[ FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) + ' ]' );
end;

procedure Quit;
begin
 //
end;

Begin
  // RU: Код ниже загружает библиотеку если статическая компиляция не используется.
  // EN: Code below loads a library if static compilation is not used.
  {$IFNDEF USE_ZENGL_STATIC}
    {$IFDEF LINUX}
    // RU: В GNU/Linux все библиотеки принято хранить в /usr/lib, поэтому libZenGL.so должна быть предварительно установлена.
    // Но zglLoad сначала проверить есть ли libZenGL.so рядом с исполняемым файлом.
    //
    // EN: In GNU/Linux all libraries placed in /usr/lib, so libZenGL.so must be installed before it will be used.
    // But zglLoad will check first if there is libZenGL.so near executable file.
    if not zglLoad( libZenGL ) Then exit;
    {$ENDIF}
    {$IFDEF WINDOWS}
    if not zglLoad( libZenGL ) Then exit;
    {$ENDIF}
    {$IFDEF DARWIN}
    // RU: libZenGL.dylib следует предварительно поместить в каталог MyApp.app/Contents/Frameworks/, где MyApp.app - Bundle вашего приложения.
    // Также следует упомянуть, что лог-файл будет создаваться в корневом каталоге поэтому либо отключайте его, либо указывайте свой путь и имя, как описано в справке.
    //
    // EN: libZenGL.dylib must be placed into this directory MyApp.app/Contents/Frameworks/, where MyApp.app - Bundle of your application.
    // Also you must know, that log-file will be created in root directory, so you must disable a log, or choose your own path and name for it. How to do this you can find in documentation.
    if not zglLoad( libZenGL ) Then exit;
    {$ENDIF}
  {$ENDIF}

  // RU: Для загрузки/создания каких-то своих настроек/профилей/etc. можно получить путь к домашенему каталогу пользователя, или к исполняемому файлу(не работает для GNU/Linux).
  // EN: For loading/creating your own options/profiles/etc. you can get path to user home directory, or to executable file(not works for GNU/Linux).
  DirApp  := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  DirHome := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_HOME ) ) );

  // RU: Создаем таймер с интервалом 1000мс.
  // EN: Create a timer with interval 1000ms.
  timer_Add( @Timer, 1000 );

  // RU: Регистрируем процедуру, что выполнится сразу после инициализации ZenGL.
  // EN: Register the procedure, that will be executed after ZenGL initialization.
  zgl_Reg( SYS_LOAD, @Init );
  // RU: Регистрируем процедуру, где будет происходить рендер.
  // EN: Register the render procedure.
  zgl_Reg( SYS_DRAW, @Draw );
  // RU: Регистрируем процедуру, которая будет принимать разницу времени между кадрами.
  // EN: Register the procedure, that will get delta time between the frames.
  zgl_Reg( SYS_UPDATE, @Update );
  // RU: Регистрируем процедуру, которая выполнится после завершения работы ZenGL.
  // EN: Register the procedure, that will be executed after ZenGL shutdown.
  zgl_Reg( SYS_EXIT, @Quit );

  // RU: Устанавливаем заголовок окна.
  // EN: Set the caption of the window.
  wnd_SetCaption( '01 - Initialization' );

  // RU: Разрешаем курсор мыши.
  // EN: Allow to show the mouse cursor.
  wnd_ShowCursor( TRUE );

  // RU: Указываем первоначальные настройки.
  // EN: Set screen options.
  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, FALSE, FALSE );

  // RU: Инициализируем ZenGL.
  // EN: Initialize ZenGL.
  zgl_Init();
End.
