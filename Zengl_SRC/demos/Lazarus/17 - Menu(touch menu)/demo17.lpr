program demo17;

{$I zglCustomConfig.cfg}

// в разработке!!!
uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF USE_ZENGL_STATIC}
  gegl_touch_menu,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_render_2d,
  zgl_fx,
  zgl_primitives_2d,
  zgl_textures,
  zgl_textures_png,
  zgl_font,
  zgl_text,
  zgl_file,
  zgl_types,
  zgl_mouse,
  gegl_draw_gui,

  zgl_utils
  {$ELSE}
  zglHeader
  {$ENDIF}
  ;

var
  //  dirRes  : UTF8String {$IFNDEF MACOSX} = 'data/' {$ENDIF};             // вне демо-версий
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};            // в демо-версиях!!!
  TimeStart: Byte = 0;


procedure Init;
begin
  file_SetPath('');                       // если dirRes = '../data/'   !!!!!     в демо-версиях!!!
  // RU: Загружаем данные о шрифте.
  // EN: Load the font.

//  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  // RU: Если же текстуры именуются без использования маски вида "$(имя_шрифта)FontName-page$(номер).$(расширение)", то загрузку можно произвести следующим образом(для png):
  // EN: If textures were named without special mask - "$(font_name)-page$(number).$(extension)", then use this method to load them(for png):
  //for i := 0 to fntMain.Count.Pages - 1 do
  //  fntMain.Pages[ i ] := tex_LoadFromFile( dirRes + 'font-page' + u_IntToStr( i ) + '.png' );

  // обязательный код! Данные для отображения клавиатуры.
  fontUse := font_LoadFromFile(dirRes + 'CalibriBold50pt.zfi');
  JoyArrow := tex_LoadFromFile(dirRes + 'arrow.png');     // загрузили текстуру
  tex_SetFrameSize(JoyArrow, 64, 64);                     // и разбили её на части, но в записях не будет указано количество полученных текстур
  CreateTouchKeyboard;
end;

procedure Draw;
  var
    r : zglTRect;
    s : UTF8String;
begin
  batch2d_Begin();
  setTextScale(15, fontUse);

  // RU: ZenGL работает исключительно с кодировкой UTF-8, поэтому весь текст должен быть в UTF-8.
  // EN: ZenGL works only with UTF-8 encoding, so all text should be encoded with UTF-8.

  text_Draw( fontUse, 400, 25, 'String with center alignment', TEXT_HALIGN_CENTER );

  text_DrawEx( fontUse, 400, 65, 3, 0, 'Scaling', 255, $FFFFFF, TEXT_HALIGN_CENTER );

  setTextScale(15, fontUse);
  fx2d_SetVCA( $FF0000, $00FF00, $0000FF, $FFFFFF, 255, 255, 255, 255 );
  text_Draw( fontUse, 400, 125, 'Gradient color for every symbol', TEXT_FX_VCA or TEXT_HALIGN_CENTER );

  r.X := 0;
  r.Y := 300 - 128;
  r.W := 192;
  r.H := 256;

  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );
  text_DrawInRect( fontUse, r, 'Simple text rendering in rectangle' + #10 + 'Текст написанный в квадрате');
  // для использования другой кодировки надо указать Lazarus что страница в кодировке UTF-8
  // File setting -> encoding -> UTF-8 with BOM

  r.X := 800 - 192;
  r.Y := 300 - 128;
  r.W := 192;
  r.H := 256;
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );
  text_DrawInRect( fontUse, r, 'Text rendering using horizontal right alignment and vertical bottom alignment', TEXT_HALIGN_RIGHT or TEXT_VALIGN_BOTTOM );

  r.X := 400 - 192;
  r.Y := 300 - 128;
  r.W := 384;
  r.H := 256;
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );
  text_DrawInRect( fontUse, r, 'This text uses justify alignment and centered vertically. Text which doesn''t fit inside the rectangle will be cropped.',
                   TEXT_HALIGN_JUSTIFY or TEXT_VALIGN_CENTER );

  r.X := 400 - 320;
  r.Y := 300 + 160;
  r.W := 640;
  r.H := 128;
  pr2d_Rect( r.X, r.Y, r.W, r.H, $FF0000 );
  text_DrawInRect( fontUse, r, 'For starting new line LF symbol can be used' + #10 + 'code of which is equal to 10 and named in Unicode as "Line Feed"',
                   TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER );

  // RU: Выводим количество FPS в правом углу, используя text_GetWidth.
  // EN: Render FPS in the top right corner using text_GetWidth.
  s := 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) );
  text_Draw( fontUse, 800 - text_GetWidth( fontUse, s ), 0, s );

  batch2d_End();
end;

procedure Timer;
begin

  key_ClearState();
  mouse_ClearState;
end;

begin
  {$IFNDEF USE_ZENGL_STATIC}
  if not zglLoad( libZenGL ) Then exit;
  {$ENDIF}
  randomize();

  timer_Add( @Timer, 16, TimeStart, Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('06 - Text'));

  zgl_Init();
end.

