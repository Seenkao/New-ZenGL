library demo15;

{$I zglCustomConfig.cfg}

uses
  zgl_application,
  zgl_file,
  zgl_memory,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_touch,
  zgl_textures,
  zgl_textures_png,
  zgl_font,
  zgl_text,
  zgl_primitives_2d,
  zgl_render_2d,
  zgl_sprite_2d,
  zgl_video,
  zgl_video_theora,
  zgl_utils
  {$IfNDef OLD_METHODS}
  , gegl_color
  {$EndIf}
  ;

var
  dirRes    : UTF8String = 'assets/';
  fntMain   : LongWord;
  video     : zglPVideoStream;
  videoFile : zglTMemory;
  videoSeek : Boolean;
  TimeStart : LongWord;

  newColor  : LongWord;

procedure Init;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  mem_LoadFromFile( videoFile, dirRes + 'video.ogv' );

  file_CloseArchive();

  // EN: Open the video file.
  // RU: Открыть видео файл.
  video := video_OpenMemory( videoFile, 'OGV' );
  setFontTextScale(15, fntMain);

  newColor := Color_FindOrAdd($00FF0090);
end;

procedure Draw;
begin
  if Assigned( video ) Then
  begin
    batch2d_Begin;
    // EN: Rendering the current video frame in the center of screen using parameters of it from video.Info.
    // RU: Рендеринг текущего кадра видео в центре экрана используя параметры из video.Info.
    ssprite2d_Draw( video^.Texture, ( 800 - video^.Info.Width ) / 2, ( 600 - video^.Info.Height ) / 2, video^.Info.Width, video^.Info.Height, 0 );
    // EN: Rendering of progress bar.
    // RU: Рендеринг полосы прогресса.
    pr2d_Rect( 0, 600 - 100, 800, 20, {$IfNDef OLD_METHODS}cl_Green{$Else}$00FF00, 255{$EndIf} );
    pr2d_Rect( 0, 600 - 100, ( 800 / video^.Info.Duration ) * video^.Time, 20, {$IfDef OLD_METHODS}$00FF00, 155,{$Else}newColor,{$EndIf}PR2D_FILL );

    text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
    text_Draw( fntMain, 0, 20, 'Frame: ' + u_IntToStr( video^.Frame ) );
    text_Draw( fntMain, 100, 0, 'Duration: ' + u_FloatToStr( video^.Info.Duration / 1000 ) );
    text_Draw( fntMain, 100, 20, 'Frames: ' + u_IntToStr( video^.Info.Frames ) );
    text_Draw( fntMain, 230, 0, 'Time: ' + u_FloatToStr( video^.Time / 1000 ) );
    batch2d_End;
  end;
end;

procedure KeyMouseEvents;
begin
  // EN: Seek the video if finger is on the screen.
  // RU: Перемещаться по видео если пальцем водят по экрану.
  if touch_Click( 0 ) Then
    begin
      videoSeek := TRUE;
      video_Seek( video, ( touch_X( 0 ) / 800 ) * video^.Info.Duration );
    end else
      videoSeek := FALSE;
end;

procedure Update( dt : Double );
begin
  if not videoSeek Then
    video_Update( video, dt, TRUE );
end;

procedure Restore;
begin
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  font_RestoreFromFile( fntMain, dirRes + 'font.zfi' );
  file_CloseArchive();

  video_Restore( video );
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  randomize();

  zgl_Reg(SYS_EVENTS, @KeyMouseEvents);
  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_UPDATE, @Update );
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );

  scr_SetOptions();
end;

exports
  Java_zengl_android_ZenGL_Main,
  {$I android_export.inc}

End.
