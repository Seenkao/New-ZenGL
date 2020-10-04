program demo06;

{$I zglCustomConfig.cfg}

uses
  zgl_main,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_render_2d,
  zgl_fx,
  zgl_primitives_2d,
  zgl_textures,
  zgl_textures_png,
  zgl_font,
  zgl_text,
  zgl_math_2d,
  zgl_utils
  ;

var
  dirRes  : UTF8String = 'data/';
  fntMain : zglPFont;

procedure Init;
  //var
  //  i : Integer;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  // RU: Загружаем данные о шрифте.
  // EN: Load the font.
  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  // RU: Если же текстуры именуются без использования маски вида "$(имя_шрифта)FontName-page$(номер).$(расширение)", то загрузку можно произвести следующим образом(для png):
  // EN: If textures were named without special mask - "$(font_name)-page$(number).$(extension)", then use this method to load them(for png):
  //for i := 0 to fntMain.Count.Pages - 1 do
  //  fntMain.Pages[ i ] := tex_LoadFromFile( dirRes + 'font-page' + u_IntToStr( i ) + '.png' );
end;

procedure Draw;
  var
    r : zglTRect;
    s : UTF8String;
begin
  batch2d_Begin();

  // RU: ZenGL работает исключительно с кодировкой UTF-8, поэтому весь текст должен быть в UTF-8.
  // EN: ZenGL works only with UTF-8 encoding, so all text should be encoded with UTF-8.

  text_Draw( fntMain, 400, 25, 'String with center alignment', TEXT_HALIGN_CENTER );

  text_DrawEx( fntMain, 400, 65, 2, 0, 'Scaling', 255, $FFFFFF, TEXT_HALIGN_CENTER );

  fx2d_SetVCA( $FF0000, $00FF00, $0000FF, $FFFFFF, 255, 255, 255, 255 );
  text_Draw( fntMain, 400, 125, 'Gradient color for every symbol', TEXT_FX_VCA or TEXT_HALIGN_CENTER );

  r.X := 0;
  r.Y := 300 - 128;
  r.W := 192;
  r.H := 256;
  text_DrawInRect( fntMain, r, 'Simple text rendering in rectangle' );
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );

  r.X := 800 - 192;
  r.Y := 300 - 128;
  r.W := 192;
  r.H := 256;
  text_DrawInRect( fntMain, r, 'Text rendering using horizontal right alignment and vertical bottom alignment', TEXT_HALIGN_RIGHT or TEXT_VALIGN_BOTTOM );
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );

  r.X := 400 - 192;
  r.Y := 300 - 128;
  r.W := 384;
  r.H := 256;
  text_DrawInRect( fntMain, r, 'This text uses justify alignment and centered vertically. Text which doesn''t fit inside the rectangle will be cropped.',
                   TEXT_HALIGN_JUSTIFY or TEXT_VALIGN_CENTER );
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );

  r.X := 400 - 320;
  r.Y := 300 + 160;
  r.W := 640;
  r.H := 128;
  text_DrawInRect( fntMain, r, 'For starting new line LF symbol can be used' + #10 + 'code of which is equal to 10 and named in Unicode as "Line Feed"',
                   TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER );
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );

  // RU: Выводим количество FPS в правом углу, используя text_GetWidth.
  // EN: Render FPS in the top right corner using text_GetWidth.
  s := 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) );
  text_Draw( fntMain, 800 - text_GetWidth( fntMain, s ), 0, s );

  batch2d_End();
end;

Begin
  randomize();

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );

  zgl_Init();
End.
