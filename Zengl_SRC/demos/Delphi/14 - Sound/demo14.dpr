program demo14;

{$I zglCustomConfig.cfg}

{$R *.res}

uses
  zgl_screen,
  zgl_window,
  zgl_timers,
  zgl_keyboard,
  zgl_mouse,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_font,
  zgl_text,
  zgl_sprite_2d,
  zgl_sound,
  zgl_sound_wav,
  zgl_sound_ogg,
  zgl_types,
  zgl_collision_2d,
  zgl_utils,
  zgl_memory
  ;

const
  SCREEN_WIDTH  = 800;
  SCREEN_HEIGHT = 600;

var
  dirRes : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain: Byte;
  icon   : array[0..1] of zglPTexture;
  sound  : zglPSound;
  audio  : Integer;
  state  : Integer;

  musicMem: zglTMemory;

  // добавл€ем номер звука, пока дл€ одного звука
  IDSound: Integer;
  TimeStart: Byte;

// RU: “.к. звукова€ подсистема нацелена на 3D, дл€ позиционировани€ звуков в 2D нужны некоторые ухищрени€.
// EN: Because sound subsystem using 3D, there is some tricky way to calculate sound position in 2D.
function CalcX2D(const X: Single): Single;
begin
  Result := (X - SCREEN_WIDTH / 2) * (20 / SCREEN_WIDTH / 2);          // сменил смещение по X и Y, теперь более €вно можно
end;                                                                    // отдалить/приблизить звук

function CalcY2D(const Y: Single): Single;
begin
  Result := (Y - SCREEN_HEIGHT / 2) * (20 / SCREEN_HEIGHT / 2);
end;

procedure Init;
begin
  // RU: »нициализируем звуковую подсистему. ƒл€ Windows можно сделать выбор между DirectSound и OpenAL отредактировав файл zgl_config.cfg.
  // EN: Initializing sound subsystem. For Windows can be used DirectSound or OpenAL, see zgl_config.cfg.
  snd_Init();

  // RU: «агружаем звуковой файл и устанавливаем дл€ него максимальноe количество проигрываемых источников в 2.
  // EN: Load the sound file and set maximum count of sources that can be played to 2.
  sound := snd_LoadFromFile(dirRes + 'click.wav', 2);

  // RU: «агружаем текстуры, которые будут индикаторами.
  // EN: Load the textures, that will be indicators.
  icon[0] := tex_LoadFromFile(dirRes + 'audio-stop.png');
  icon[1] := tex_LoadFromFile(dirRes + 'audio-play.png');

  fntMain := font_LoadFromFile(dirRes + 'font.zfi');
  setTextScale(15, fntMain);
end;

procedure Draw;
  var
    r: zglTRect;
begin
  ssprite2d_Draw(icon[state], (SCREEN_WIDTH - 128) / 2, (SCREEN_HEIGHT - 128) / 2, 128, 128, 0);
  text_Draw(fntMain, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 64, 'Skillet - Comatose - Whispers In The Dark', TEXT_HALIGN_CENTER);

  r.X := (SCREEN_WIDTH - 128) / 2;
  r.Y := (SCREEN_HEIGHT - 128) / 2;
  r.W := 128;
  r.H := 128;
  if col2d_PointInRect(mouseX, mouseY, r) Then
    begin
      fx_SetBlendMode(FX_BLEND_ADD);
      ssprite2d_Draw(icon[state], (SCREEN_WIDTH - 132) / 2, (SCREEN_HEIGHT - 132) / 2, 132, 132, 0, 155);
      fx_SetBlendMode(FX_BLEND_NORMAL);
    end;
end;

procedure Timer;
  var
    r: zglTRect;
    p: Integer;
begin
  // RU: ѕровер€ем играет ли музыка(1 - играет, 0 - не играет). “ак же можно проверить и звуки - подставив zglPSound и ID вот так:
  //     snd_Get(Sound, ID...
  //     ID возвращаетс€ функцией snd_Play
  //
  // EN: Check if music playing(1 - playing, 0 - not playing). Sounds also can be checked this way - just use zglPSound and ID:
  //     snd_Get(Sound, ID...
  //     ID returns by function snd_Play.
  state := snd_Get(SND_STREAM, audio, SND_STATE_PLAYING);
  if state = 0 Then
    audio := 0;

  if mBClickCanClick(M_BLEFT_CLICK) Then
  begin
      // RU: ¬ данном случае мы начинаем воспроизводить звук сразу в указанных координатах, но их можно мен€ть и в процессе использу€ процедуру snd_SetPos.
      //     ¬ажно: ƒл€ OpenAL можно позиционировать только mono-звуки
      //
      // EN: In this case, we begin to play the sound directly in these coordinates, but they can be changed later using procedure snd_SetPos.
      //     Important: OpenAL can position only mono-sounds.

// эта часть изменена!!! “еперь можно заново воспроизводить звуки, даже если они не закончили играть.
    if snd_Get(sound, IDSound, SND_STATE_PLAYING) = IDSound then
      snd_Stop(sound, IDSound);
    IDSound := snd_Play(sound, FALSE, CalcX2D(mouse_X), CalcY2D(mouse_Y));
// ------------------------------------------------------------------------------------------

    r.X := (SCREEN_WIDTH - 128) / 2;
    r.Y := (SCREEN_HEIGHT - 128) / 2;
    r.W := 128;
    r.H := 128;

// добавл€ем проверку на проигрывание звука, только если много развных звуков/музыки, то номера надо мен€ть (не только 1!!!)
    if col2d_PointInRect(mouse_X, mouse_Y, r) and (audio = 1) Then
    begin
      p := snd_Get(SND_STREAM, audio, SND_STATE_PLAYING);
      if p = 1 then
        snd_StopStream(audio);
    end;
// ---------------------------------------------------------------------------------------------------------------

    if col2d_PointInRect(mouse_X, mouse_Y, r) and (audio = 0) Then
      audio := snd_PlayFile(dirRes + 'music.ogg');

  end;

  // RU: ѕолучаем в процентах позицию проигрывани€ аудиопотока и ставим громкость дл€ плавных переходов.
  // EN: Get position in percent's for audio stream and set volume for smooth playing.
  p := snd_Get(SND_STREAM, audio, SND_STATE_PERCENT);
  if (p >= 0) and (p < 25) Then
    snd_SetVolume(SND_STREAM, audio, (1 / 24) * p);
  if (p >= 75) and (p < 100) Then
    snd_SetVolume(SND_STREAM, audio, 1 - (1 / 24) * (p - 75));

  key_ClearState();
  mouse_ClearState();
end;

Begin
  randomize();

  TimeStart := timer_Add(@Timer, 16, Start);

  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg(SYS_DRAW, @Draw);

  wnd_SetCaption(utf8_Copy('14 - Sound'));

  zgl_Init();
End.
