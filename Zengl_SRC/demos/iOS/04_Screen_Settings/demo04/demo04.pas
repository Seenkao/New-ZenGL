program demo04;

{$I zglCustomConfig.cfg}

uses
  zgl_main,
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
  zgl_textures_jpg,
  zgl_math_2d,
  zgl_collision_2d,
  zgl_utils
  ;

var
  dirRes  : UTF8String = 'data/';

  fntMain : zglPFont;
  texBack : zglPTexture;

  correctAspect : Boolean = TRUE;
  useLandscape  : Boolean = TRUE;
  usePortrait   : Boolean = TRUE;

  correctRect   : zglTRect;
  landscapeRect : zglTRect;
  portraitRect  : zglTRect;

procedure Init;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  texBack := tex_LoadFromFile( dirRes + 'back03.jpg' );
end;

procedure Draw;
  var
    w   : Single;
    str : UTF8String;
begin
  ssprite2d_Draw( texBack, 0, 0, 800, 600, 0 );

  str := 'Tap here to toggle' + #10 + 'Correction of aspect';
  correctRect.X := 64;
  correctRect.Y := 100;
  correctRect.W := text_GetWidth( fntMain, str ) + 8;
  correctRect.H := 64;
  if correctAspect Then
    begin
      pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, $FFFFFF, 25, PR2D_FILL );
      pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, $00FF00, 255 );
    end else
      begin
        pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, $000000, 155, PR2D_FILL );
        pr2d_Rect( correctRect.X, correctRect.Y, correctRect.W, correctRect.H, $FFFFFF, 255 );
      end;
  text_DrawInRect( fntMain, correctRect, str, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER );

  str := 'Tap here to toggle support of' + #10 + 'Landscape mode';
  landscapeRect.X := 260;
  landscapeRect.Y := 100;
  landscapeRect.W := text_GetWidth( fntMain, str ) + 8;
  landscapeRect.H := 64;
  if useLandscape Then
    begin
      pr2d_Rect( landscapeRect.X, landscapeRect.Y, landscapeRect.W, landscapeRect.H, $FFFFFF, 25, PR2D_FILL );
      pr2d_Rect( landscapeRect.X, landscapeRect.Y, landscapeRect.W, landscapeRect.H, $00FF00, 255 );
    end else
      begin
        pr2d_Rect( landscapeRect.X, landscapeRect.Y, landscapeRect.W, landscapeRect.H, $000000, 155, PR2D_FILL );
        pr2d_Rect( landscapeRect.X, landscapeRect.Y, landscapeRect.W, landscapeRect.H, $FFFFFF, 255 );
      end;
  text_DrawInRect( fntMain, landscapeRect, str, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER );

  str := 'Tap here to toggle support of' + #10 + 'Portrait mode';
  portraitRect.W := text_GetWidth( fntMain, str ) + 8;
  portraitRect.H := 64;
  portraitRect.X := 800 - portraitRect.W - 64;
  portraitRect.Y := 100;
  if usePortrait Then
    begin
      pr2d_Rect( portraitRect.X, portraitRect.Y, portraitRect.W, portraitRect.H, $FFFFFF, 25, PR2D_FILL );
      pr2d_Rect( portraitRect.X, portraitRect.Y, portraitRect.W, portraitRect.H, $00FF00, 255 );
    end else
      begin
        pr2d_Rect( portraitRect.X, portraitRect.Y, portraitRect.W, portraitRect.H, $000000, 155, PR2D_FILL );
        pr2d_Rect( portraitRect.X, portraitRect.Y, portraitRect.W, portraitRect.H, $FFFFFF, 255 );
      end;
  text_DrawInRect( fntMain, portraitRect, str, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER );
end;

procedure Timer;
begin
  if touch_Tap( 0 ) Then
    begin
      // RU: Данный пример использует соотношение сторон 4:3, что стандартно для iPad'а в альбомной ориентации и при масштабировании(с 800х600 до 1024х768 или 2048х1536) проблем не вызывает.
      //     На iPhone же использование соотношения 4:3 без коррекции по ширине и высоте можно наблюдать эффект растягивания. То же самое и для портретной ориентации.
      // EN: This demo uses aspect 4:3, which is standard aspect for iPad'а in landscape orientation and scaling(from 800х600 to 1024х768 or 2048х1536) won't cause a problem.
      //     Using aspect 4:3 without correction for width and height will cause a stretching effect for iPhone or portrait orientation.
      if col2d_PointInRect( touch_X( 0 ), touch_Y( 0 ), correctRect ) Then
        begin
          correctAspect := not correctAspect;
          if correctAspect Then
            begin
              zgl_Enable( CORRECT_WIDTH );
              zgl_Enable( CORRECT_HEIGHT );
              scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );
            end else
              begin
                zgl_Disable( CORRECT_WIDTH );
                zgl_Disable( CORRECT_HEIGHT );
                scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );
              end;
        end;

      // RU: Помимо стандартных настроек для iOS приложения в Info.plist, поддерживаемыми режимами ориентации можно управлять непосредственно через zgl_Enable/zgl_Disable.
      // EN: Besides the standard options for iOS application in Info.plist, support of orientations can be controlled using zgl_Enable/zgl_Disable.
      if col2d_PointInRect( touch_X( 0 ), touch_Y( 0 ), landscapeRect ) Then
        begin
          useLandscape := not useLandscape;
          if useLandscape Then
            zgl_Enable( SCR_ORIENTATION_LANDSCAPE )
          else
            zgl_Disable( SCR_ORIENTATION_LANDSCAPE );
        end;

      if col2d_PointInRect( touch_X( 0 ), touch_Y( 0 ), portraitRect ) Then
        begin
          usePortrait := not usePortrait;
          if usePortrait Then
            zgl_Enable( SCR_ORIENTATION_PORTRAIT )
          else
            zgl_Disable( SCR_ORIENTATION_PORTRAIT );
        end;
    end;

  touch_ClearState();
end;

Begin
  timer_Add( @Timer, 16 );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );

  scr_SetOptions( 800, 600, REFRESH_MAXIMUM, TRUE, TRUE );

  zgl_Init();
End.
