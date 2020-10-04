program demo15;

{$I zglCustomConfig.cfg}

uses
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_touch,
  zgl_textures,
  zgl_textures_png,
  zgl_font,
  zgl_text,
  zgl_primitives_2d,
  zgl_sprite_2d,
  zgl_video,
  zgl_video_theora,
  zgl_utils
  ;

var
  dirRes    : UTF8String = 'data/';
  fntMain   : zglPFont;
  video     : zglPVideoStream;
  videoSeek : Boolean;

procedure Init;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  // EN: Open the video file.
  // RU: Открыть видео файл.
  video := video_OpenFile( dirRes + 'video.ogv' );
end;

procedure Draw;
begin
  if Assigned( video ) Then
    begin
      // EN: Rendering the current video frame in the center of screen using parameters of it from video.Info.
      // RU: Рендеринг текущего кадра видео в центре экрана используя параметры из video.Info.
      ssprite2d_Draw( video.Texture, ( 800 - video.Info.Width ) / 2, ( 600 - video.Info.Height ) / 2, video.Info.Width, video.Info.Height, 0 );

      // EN: Rendering of progress bar.
      // RU: Рендеринг полосы прогресса.
      pr2d_Rect( 4, 600 - 100, 792, 20, $00FF00, 255 );
      pr2d_Rect( 4, 600 - 100, ( 792 / video.Info.Duration ) * video.Time, 20, $00FF00, 155, PR2D_FILL );

      text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
      text_Draw( fntMain, 0, 20, 'Frame: ' + u_IntToStr( video.Frame ) );
      text_Draw( fntMain, 100, 0, 'Duration: ' + u_FloatToStr( video.Info.Duration / 1000 ) );
      text_Draw( fntMain, 100, 20, 'Frames: ' + u_IntToStr( video.Info.Frames ) );
      text_Draw( fntMain, 230, 0, 'Time: ' + u_FloatToStr( video.Time / 1000 ) );
    end;
end;

procedure Timer;
begin
  if key_Press( K_ESCAPE ) Then zgl_Exit();

  // EN: Seek the video if finger is on the screen.
  // RU: Перемещаться по видео если пальцем водят по экрану.
  if touch_Down( 0 ) Then
    begin
      videoSeek := TRUE;
      video_Seek( video, ( touch_X( 0 ) / 800 ) * video.Info.Duration );
    end else
      videoSeek := FALSE;

  touch_ClearState();
end;

procedure Update( dt : Double );
begin
  if not videoSeek Then
    video_Update( video, dt, TRUE );
end;

Begin
  randomize();

  timer_Add( @Timer, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_UPDATE, @Update );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, FALSE, FALSE );

  zgl_Init();
End.
