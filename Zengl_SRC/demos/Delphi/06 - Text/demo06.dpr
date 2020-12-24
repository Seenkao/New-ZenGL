program demo06;

{$I zglCustomConfig.cfg}

{$R *.res}

uses
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
  zgl_types,
  zgl_utils,
  AsctoUtf;             // ��� �������� ������ � UTF-8

var
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain : Byte;
  TimeStart: Byte;
  MyText: UTF8String;

procedure Init;
  //var
  //  i : Integer;
begin
  // RU: ��������� ������ � ������.
  // EN: Load the font.
  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  // RU: ���� �� �������� ��������� ��� ������������� ����� ���� "$(���_������)FontName-page$(�����).$(����������)", �� �������� ����� ���������� ��������� �������(��� png):
  // EN: If textures were named without special mask - "$(font_name)-page$(number).$(extension)", then use this method to load them(for png):
  //for i := 0 to fntMain.Count.Pages - 1 do
  //  fntMain.Pages[ i ] := tex_LoadFromFile( dirRes + 'font-page' + u_IntToStr( i ) + '.png' );
  MyText := AscToUtf8Rus('��� ����� ��� ������ ��� � ��������');
end;

procedure Draw;
var
  r : zglTRect;
  s : UTF8String;
begin
//  batch2d_Begin();    ����� ������ ��� ��������� ������ �� ������ �����

  // RU: ZenGL �������� ������������� � ���������� UTF-8, ������� ���� ����� ������ ���� � UTF-8. ���� ���������� ������� �����-���� �����(�� ����������)
  //     ��������� ������ ������ pas-������ � Delphi ������ ���� 2009 - ����������� ������� ����� �� �������� � ��������� UTF-8 � ��� UTF8String ��� ���.
  // EN: ZenGL works only with UTF-8 encoding, so all text should be encoded with UTF-8. If you want to write some text(not English) using strings
  //     inside pas-files and version of Delphi is lower than 2009, then you need to use external files with UTF-8 strings inside and type UTF8String.

  setTextScale(20, fntMain);                                    // ����� ����������� 20 pix
  text_Draw( fntMain, 400, 65, 'Scaling', TEXT_HALIGN_CENTER );

  setTextScale(15, fntMain);                                    // ����� ����������� 15 pix

  text_Draw( fntMain, 400, 25, 'String with center alignment', TEXT_HALIGN_CENTER );

  fx2d_SetVCA( $FF0000, $00FF00, $0000FF, $FFFFFF, 255, 255, 255, 255 );
  text_Draw( fntMain, 400, 125, 'Gradient color for every symbol', TEXT_FX_VCA or TEXT_HALIGN_CENTER );

  r.X := 0;
  r.Y := 300 - 128;
  r.W := 192;
  r.H := 256;
  text_DrawInRect( fntMain, r, 'Simple text rendering in rectangle. ' + MyText);
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

  // RU: ������� ���������� FPS � ������ ����, ��������� text_GetWidth.
  // EN: Render FPS in the top right corner using text_GetWidth.
  s := 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) );
  text_Draw( fntMain, 800 - text_GetWidth( fntMain, s ), 0, s );

//  batch2d_End();
end;

procedure Timer;
begin
  key_ClearState();
end;

Begin
  randomize();

  TimeStart := timer_Add( @Timer, 16, Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  wnd_SetCaption(utf8_Copy('06 - Text'));
  
  zgl_Init();
End.
