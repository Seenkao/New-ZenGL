library demo13;

{$I zglCustomConfig.cfg}

uses
  zgl_application,
  zgl_file,
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_touch,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_sprite_2d,
  zgl_particles_2d,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_types,
  zgl_utils
  ;

var
  dirRes         : UTF8String = 'assets/';
  fntMain        : Byte;
  texBack        : zglPTexture;
  debug          : Boolean;
  particles      : zglTPEngine2D;
  emitterFire    : array[ 0..2 ] of zglPEmitter2D;
  emitterDiamond : zglPEmitter2D;
  emitterRain    : zglPEmitter2D;
  TimeStart      : Byte;

procedure Init;
  var
    i : Integer;
begin
  zgl_Enable( CORRECT_RESOLUTION );
  scr_CorrectResolution( 800, 600 );

  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );

  texBack := tex_LoadFromFile( dirRes + 'back02.png' );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  // EN: Load three types of fire emitters.
  // RU: Загрузка трёх разных видов эмиттеров огня.
  emitterFire[ 0 ] := emitter2d_LoadFromFile( dirRes + 'emitter_fire00.zei' );
  emitterFire[ 1 ] := emitter2d_LoadFromFile( dirRes + 'emitter_fire01.zei' );
  emitterFire[ 2 ] := emitter2d_LoadFromFile( dirRes + 'emitter_fire02.zei' );

  // EN: Set own particels engine.
  // RU: Установка собственного движка эмиттеров.
  pengine2d_Set( @particles );

  // EN: Add 6 fire emitters to particles engine. Second parameter of function returns pointer to instance of new emitter, which can be processed manually.
  //     This instance will be nil after the death, so check everything.
  // RU: Добавляем в движок 6 эмиттеров огня. Второй параметр функции позволяет получить указатель на конкретный экземпляр эмиттера, который можно будет обрабатывать вручную.
  //     Данный экземпляр после смерти будет содержать nil, поэтому используйте проверку.
  pengine2d_AddEmitter( emitterFire[ 0 ], nil, 642, 190 );
  pengine2d_AddEmitter( emitterFire[ 0 ], nil, 40, 368 );
  pengine2d_AddEmitter( emitterFire[ 0 ], nil, 246, 368 );
  pengine2d_AddEmitter( emitterFire[ 1 ], nil, 532, 244 );
  pengine2d_AddEmitter( emitterFire[ 1 ], nil, 318, 422 );
  pengine2d_AddEmitter( emitterFire[ 1 ], nil, 583, 420 );
  pengine2d_AddEmitter( emitterFire[ 2 ], nil, 740, 525 );

  emitterDiamond := emitter2d_LoadFromFile( dirRes + 'emitter_diamond.zei' );
  pengine2d_AddEmitter( emitterDiamond, nil );

  emitterRain := emitter2d_LoadFromFile( dirRes + 'emitter_rain.zei' );
  pengine2d_AddEmitter( emitterRain, nil );

  file_CloseArchive();
  setTextScale(15, fntMain);
end;

procedure Draw;
  var
    i : Integer;
begin
  batch2d_Begin();

  ssprite2d_Draw( texBack, 0, 0, 800, 600, 0 );

  // EN: Rendering of all emitters in current particles engine.
  // RU: Рендеринг всех эмиттеров в текущем движке частиц.
  pengine2d_Draw();

  if debug Then
    for i := 0 to particles.Count.Emitters - 1 do
      with particles.List[i]^.BBox do
        pr2d_Rect( MinX, MinY, MaxX - MinX, MaxY - MinY, $FF0000, 255 );

  text_Draw( fntMain, 0, 0, 'FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) );
  text_Draw( fntMain, 0, 20, 'Particles: ' + u_IntToStr( particles.Count.Particles ) );
  text_Draw( fntMain, 0, 40, 'Debug(tap): ' + u_BoolToStr( debug ) );

  batch2d_End();
end;

procedure Timer;
begin
  if touch_Tap( 0 ) Then debug := not debug;

  touch_ClearState();
end;

procedure Update( dt : Double );
begin
  // EN: Process all emitters in current particles engine.
  // RU: Обработка всех эмиттеров в текущем движке частиц.
  pengine2d_Proc( dt );
end;

procedure Restore;
begin
  file_OpenArchive( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );

  tex_RestoreFromFile( texBack, dirRes + 'back02.png' );

  font_RestoreFromFile( fntMain, dirRes + 'font.zfi' );

  // RU: Использовать данную функцию возможно только если все эмиттеры были загружены посредством emitter2d_LoadFromFile и текстуры не были подгружены вручную.
  // EN: You can use this method only if emitters were loaded via emitter2d_LoadFromFile without manual loading of textures.
  emitter2d_RestoreAll();

  file_CloseArchive();
end;

procedure Quit;
begin
  // RU: Очищаем память от созданных эмиттеров.
  // EN: Free allocated memory for emitters.
  pengine2d_Set( @particles );
  pengine2d_ClearAll();
end;

procedure Java_zengl_android_ZenGL_Main( var env; var thiz ); cdecl;
begin
  randomize();

  TimeStart := timer_Add( @Timer, 16, Start );

  zgl_Reg( SYS_LOAD, @Init );
  zgl_Reg( SYS_DRAW, @Draw );
  zgl_Reg( SYS_UPDATE, @Update );
  zgl_Reg( SYS_ANDROID_RESTORE, @Restore );
  zgl_Reg( SYS_EXIT, @Quit );

  scr_SetOptions();
end;

exports
  Java_zengl_android_ZenGL_Main,
  {$I android_export.inc}
End.
