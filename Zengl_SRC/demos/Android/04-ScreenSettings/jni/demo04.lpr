library demo04;

{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

uses
  zgl_application,
  zgl_file,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_touch,
  zgl_font,
  zgl_text,
  zgl_primitives_2d,
  zgl_sprite_2d,
  zgl_textures,
  zgl_textures_png,
  // Rus: для Android v5 и v6 отключите в файле конфигурации define CPUARMV7A.
  // Eng: for Android v5 and v6 disable in the config file define CPUARMV7A.
  zgl_textures_jpg,
  zgl_types,
  zgl_collision_2d,
  gegl_color,
  zgl_types,
  zgl_utils;

var
  dirRes  : UTF8String = 'assets/';

  fntMain : LongWord;
  texBack : zglPTexture;

  correctAspect : Boolean = TRUE;
  correctRect   : zglTRect2D;

  str : UTF8String;

  TimeStart: Byte;

procedure Init;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  texBack := tex_LoadFromFile( dirRes + 'back03.jpg' );

  file_CloseArchive();

  str := 'Tap here to toggle' + #10 + 'Correction of aspect';
  setFontTextScale(15, fntMain);
end;

procedure Draw;
  var
    w   : Single;
begin
  ssprite2d_Draw( texBack, 0, 0, 800, 600, 0 );

  correctRect.W := text_GetWidth( fntMain, str ) + 16;
  correctRect.H := 72;
  correctRect.X := 400 - correctRect.W / 2;
  correctRect.Y := 100;
  if correctAspect Then
    begin
      pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, cl_White05, PR2D_FILL );
      pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, cl_Lime );
    end else
      begin
        pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, cl_Black05, PR2D_FILL );
        pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, cl_White );
      end;
  text_DrawInRect( fntMain, correctRect, str, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER );
end;

procedure Timer;
begin
  if touch_Tap( 0 ) Then
  begin
    // RU: Android устройства имеют самые разнообразные разрешения экрана и соотношения сторон, поэтому коррекция аспекта просто необходма.
    // EN: Android devices have a lot of different screen resolutions and aspects, and because of this correction of aspect is "must have" for project.
    if col2d_PointInRect( touch_X( 0 ), touch_Y( 0 ), correctRect ) Then
    begin
      correctAspect := not correctAspect;
      if correctAspect Then
      begin
        zgl_Enable( CORRECT_WIDTH );
        zgl_Enable( CORRECT_HEIGHT );
        scr_SetOptions();
      end else
      begin
        zgl_Disable( CORRECT_WIDTH );
        zgl_Disable( CORRECT_HEIGHT );
        scr_SetOptions();
      end;
    end;
  end;

  touch_ClearState();
end;

procedure Restore;
begin
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  font_RestoreFromFile( fntMain, dirRes + 'font.zfi' );
  tex_RestoreFromFile( texBack, dirRes + 'back03.jpg' );
  file_CloseArchive();
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  TimeStart := timer_Add( @Timer, 16, t_Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  scr_SetOptions();
end;

exports
  Java_zengl_android_ZenGL_Main,
  {$I android_export.inc}
End.
