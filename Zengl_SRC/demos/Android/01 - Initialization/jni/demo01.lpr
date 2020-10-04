library demo01;

// RU: ���� ���� �������� ��������� ���������(�������� ������������ �� ����������� ����������) � ����������� �� ��� ������� ����������
// ����������
// EN: This file contains some options(e.g. whether to use static compilation) and defines of OS for which is compilation going.
{$I zglCustomConfig.cfg}

uses
  zgl_application,
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_utils,
  zgl_log
  ;

var
  DirApp  : UTF8String;
  DirHome : UTF8String;

procedure Init;
begin
  //  RU: ��� ����� ��������� �������� �������� ��������.
  // EN: Here can be loading of main resources.

end;

procedure Draw;
begin
  // RU: ��� "������" ��� ������ :)
  // EN: Here "draw" anything :)
end;

procedure Update( dt : Double );
begin
  // RU:  ��� ������� ���������� ��� ���������� �������� �������� ����-����, �.�. �������� �������� ���������� FPS.
  // EN: This function is the best way to implement smooth moving of something, because accuracy of timers are restricted by FPS.
end;

procedure Timer;
begin
  //
end;

procedure Restore;
begin
  // RU: �������������� �������� ����� ������������� ���.
  // EN: Restoring of resources should be implemented here.
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  // ��� ��������/�������� �����-�� ����� ��������/��������/etc. ����� �������� ���� � ���������� �������� ������������, ��� � ������������
  // �����(��� GNU/Linux - ��������, ���� ����� ��������� ��������� ���� ����������� ����, �� ���� �� ������ ������������ ����� ����� ��������).
   //     �� Android DIRECTORY_APPLICATION ���������� ������ ���� � apk-�����

  // EN: For loading/creating your own options/profiles/etc. you can get path to user home directory, or to executable file(not works for GNU/Linux).
  //     On Android DIRECTORY_APPLICATION returns full path to apk-file
  DirApp  := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  DirHome := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_HOME ) ) );

  // RU: ������� ������ � ���������� 1000��.
  // EN: Create a timer with interval 1000ms.
  timer_Add( @Timer, 1000 );

  // RU:  ������������ ���������, ��� ���������� ����� ����� ������������� ZenGL.
  // EN: Register the procedure, that will be executed after ZenGL initialization.
  zgl_Reg( SYS_LOAD, @Init );
  // RU:  ������������ ���������, ��� ����� ����������� ������.
  // EN: Register the render procedure.
  zgl_Reg( SYS_DRAW, @Draw );
  // RU: ������������ ���������, ������� ����� ��������� ������� ������� ����� �������.
  // EN: Register the procedure, that will get delta time between the frames.
  zgl_Reg( SYS_UPDATE, @Update );
  // RU: ����� ������ ��� Android �������, ������� ���������� ��� �������� ������ ���������� ���� ���������� ������������ �������.
  // EN: Very important function for Android, which will be called every time when application gets the focus and resources need to restore.
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  // RU:  ��������� �������������� ���������.
  // ��������, ��������� �� ���� �� ����, ���� ����� ������� ������� ������ � ������� ����� ��������.
  // EN: Set screen options.
  scr_SetOptions();
end;

exports
  // RU: ��� ������� ������ ���� ����������� ��������, ������� ���������� ZenGL
  // EN: This function should be implemented by project which is use ZenGL
  Java_zengl_android_ZenGL_Main,

  // RU: ������� ����������� ZenGL, ������� ������ ���� ��������������
  // EN: Functions which are implemented by ZenGL and should be exported
  {$I android_export.inc}
End.
