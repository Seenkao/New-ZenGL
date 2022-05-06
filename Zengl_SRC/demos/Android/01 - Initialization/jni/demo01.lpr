library demo01;

// RU: Этот файл содержит некоторые настройки(например использовать ли статическую компиляцию) и определения ОС под которую происходит
// компиляция.
// EN: This file contains some options(e.g. whether to use static compilation) and defines of OS for which is compilation going.
{$I zglCustomConfig.cfg}

uses
  zgl_application,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_utils,
  zgl_log
  ;

var
  DirApp  : UTF8String;
  DirHome : UTF8String;

  TimeStart  : LongWord = 0;

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
  //
end;

procedure Restore;
begin
  // RU: Восстановление ресурсов нужно реализовывать тут.
  // EN: Restoring of resources should be implemented here.
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  // RU: Для загрузки/создания каких-то своих настроек/профилей/etc. можно получить путь к домашенему каталогу пользователя, или к исполняемому
  //     файлу(для GNU/Linux - изменено, если будет программа содержать свой собственный путь, то путь до самого исполняемого файла будет прописан).
  //     На Android DIRECTORY_APPLICATION возвращает полный путь к apk-файлу

  // EN: For loading/creating your own options/profiles/etc. you can get path to user home directory, or to executable file(not works for GNU/Linux).
  //     On Android DIRECTORY_APPLICATION returns full path to apk-file
  DirApp  := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  DirHome := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_HOME ) ) );

  // RU: Создаем таймер с интервалом 1000мс.
  // EN: Create a timer with interval 1000ms.
  TimeStart := timer_Add( @Timer, 100, t_Start);

  // RU: Регистрируем процедуру, что выполнится сразу после инициализации ZenGL.
  // EN: Register the procedure, that will be executed after ZenGL initialization.
  zgl_Reg( SYS_LOAD, @Init );
  // RU: Регистрируем процедуру, где будет происходить рендер.
  // EN: Register the render procedure.
  zgl_Reg( SYS_DRAW, @Draw );
  // RU: Регистрируем процедуру, которая будет принимать разницу времени между кадрами.
  // EN: Register the procedure, that will get delta time between the frames.
  zgl_Reg( SYS_UPDATE, @Update );
  // RU: Очень важная для Android функция, которая вызывается при возврате фокуса приложению если необходимо восстановить ресурсы.
  // EN: Very important function for Android, which will be called every time when application gets the focus and resources need to restore.
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  // RU: Указываем первоначальные настройки.
  //     изменено, указывать ни чего не надо, либо можем указать размеры экрана с которым будем работать.
  // EN: Set screen options.
  scr_SetOptions();
end;

exports
  // RU: Эта функция должна быть реализована проектом, который использует ZenGL.
  // EN: This function should be implemented by project which is use ZenGL.
  Java_zengl_android_ZenGL_Main,

  // RU: Функции реализуемые ZenGL, которые должны быть экспортированы.
  // EN: Functions which are implemented by ZenGL and should be exported.
  {$I android_export.inc}
End.
