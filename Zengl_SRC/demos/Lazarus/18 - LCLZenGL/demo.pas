unit demo;

{$mode objfpc}{$H+}
{$I zglCustomConfig.cfg}

interface

uses
  Classes,
  SysUtils,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,

{$IFDEF LINUX}
  {$IFDEF LCLGTK2}
  GTK2, GDK2x, GTK2Proc,
  {$ENDIF}
{$ENDIF}

{$IFDEF MACOSX}
//  CarbonPrivate,
  CocoaPrivate,
{$ENDIF}

  {$IFDEF USE_ZENGL_STATIC}
  zgl_application,
  zgl_window,
  zgl_screen,
  zgl_render_2d,
  zgl_joystick,
  zgl_mouse,
  zgl_fx,
  zgl_font,
  zgl_text,
  zgl_textures,
  zgl_textures_png,
  zgl_types,
  zgl_collision_2d,
  zgl_sprite_2d,
  // sound
  zgl_sound,
  zgl_sound_wav,
  zgl_sound_ogg,
  zgl_utils
  {$ELSE}
  zglHeader
  {$ENDIF}
  , LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

//-----------------------------------------
  dirRes  : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};

  fntMain : Byte;
  MyIcon    : array[ 0..1 ] of zglPTexture;
  sound, audio   : zglPSound;
  audioPlay : Boolean = false;
  state   : Integer;
  r : zglTRect;
  p : Integer;

  // добавляем номер звука, пока для одного звука
  IDSound: array[0..1] of Integer;

  joyCount   : Integer;
  // для возможности изменения экрана
  ScreenWidth : integer = 800;
  ScreenHeight : integer = 600;

//------------------------------------------

implementation

{$R *.lfm}

// RU: Т.к. звуковая подсистема нацелена на 3D, для позиционирования звуков в 2D нужны некоторые ухищрения.
// EN: Because sound subsystem using 3D, there is some tricky way to calculate sound position in 2D.
function CalcX2D( const X : Single ) : Single;
begin
  Result := ( X - ScreenWidth / 2 ) * ( 10 / ScreenHeight / 2 );         // сменил смещение по X и Y, теперь более явно можно
end;                                                                     // отдалить/приблизить звук

function CalcY2D( const Y : Single ) : Single;
begin
  Result := ( Y - ScreenWidth / 2 ) * ( 10 / ScreenHeight / 2 );
end;

procedure Draw;
begin
  setFontTextScale(15, fntMain);
  text_Draw( fntMain, 0, 0, 'Escape - Exit' );

  // RU: Координаты мыши можно получить при помощи функций mouse_X и mouse_Y.
  // EN: Mouse coordinates can be got using functions mouse_X and mouse_Y.
  text_Draw( fntMain, 0, 18, 'Mouse X, Y: ' + u_IntToStr( mouseX ) + '; ' + u_IntToStr( mouseY ) );

  ssprite2d_Draw( MyIcon[ state ], ( ScreenWidth - 128 ) / 2, ( ScreenHeight - 128 ) / 2, 128, 128, 0 );
  text_Draw( fntMain, ScreenWidth / 2, ScreenHeight / 2 + 64, 'Skillet - Comatose - Whispers In The Dark', TEXT_HALIGN_CENTER );

  if col2d_PointInRect( mouseX, mouseY, r ) Then
    begin
      fx_SetBlendMode( FX_BLEND_ADD );
      ssprite2d_Draw(MyIcon[state], (ScreenWidth - 132) / 2, (ScreenHeight - 132) / 2, 132, 132, 0, 155);
      fx_SetBlendMode( FX_BLEND_NORMAL );
    end;
  Application.ProcessMessages;
end;

procedure Init;
begin
  wnd_SetSize( Form1.ClientWidth, Form1.ClientHeight );
  scrVSync := true;
  // RU: Инициализируем звуковую подсистему. Для Windows можно сделать выбор между DirectSound и OpenAL отредактировав файл zgl_config.cfg.
  // EN: Initializing sound subsystem. For Windows can be used DirectSound or OpenAL, see zgl_config.cfg.
  snd_Init();

  // RU: Загружаем звуковой файл и устанавливаем для него максимальноe количество проигрываемых источников в 2.
  // EN: Load the sound file and set maximum count of sources that can be played to 2.


  // RU: Инициализируем обработку ввода джойстиков и получаем количество подключенных джойстиков.
  // EN: Initialize processing joystick input and get count of plugged joysticks.
  joyCount := joy_Init();

  // RU: Загружаем текстуры, которые будут индикаторами.
  // EN: Load the textures, that will be indicators.
  MyIcon[ 0 ] := tex_LoadFromFile( dirRes + 'audio-stop.png' );
  MyIcon[ 1 ] := tex_LoadFromFile( dirRes + 'audio-play.png' );

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );

  sound := snd_LoadFromFile( dirRes + 'click.wav', 2 );
  audio := snd_LoadFromFile(dirRes + 'music.ogg', 2);
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // вариант для неизменного окна или выбирайте нужный вариант в настройках формы.
  // Form1.BorderStyle := bsSingle;
end;

// закрываем форму
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := false;
  zgl_Destroy;
  Application.Terminate;
end;

procedure TForm1.FormActivate(Sender: TObject);
{$IFDEF LINUX}
  var
    widget : PGtkWidget;
{$ENDIF}
begin
  // Производим инициализацию --------------------------------------------------
  // RU: Вертикальная синхронизация поможет избежать загрузки процессора.
  // EN: Vertical synchronization will decrease a CPU loading.
  scrVSync := true;

  // RU: Перед стартом необходимо настроить viewport.
  // EN: Before the start need to configure a viewport.
  wnd_SetPos( Form1.Left, Form1.Top );
//  wnd_SetSize( Form1.ClientWidth, Form1.ClientHeight );

  Form1.BringToFront();
  r.X := ( Form1.ClientWidth - 128 ) / 2;
  r.Y := ( Form1.ClientHeight - 128 ) / 2;
  r.W := 128;
  r.H := 128;
//-----------------------------------------------------

  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg( SYS_DRAW, @Draw );

  {$IFDEF LINUX}
    {$IFDEF LCLGTK2}
    widget := GetFixedWidget( PGtkWidget( Handle ) );
    gtk_widget_realize( widget );
    zgl_InitToHandle( GDK_WINDOW_XID( widget^.window ) );
    {$ENDIF}
  {$ENDIF}

  {$IFDEF WINDOWS}
    zgl_InitToHandle( Handle );
  {$ENDIF}

  {$IFDEF MACOSX}
    // RU: В MacOS X инициализироваться нужно в форму, даже если рисовать надо в другом контроле.
    // EN: For MacOS X initialization should be done into form, even if rendering will be into another control.
    zgl_InitToHandle( LongWord( TCarbonWindow( Form1.Handle ).Window ) );
  {$ENDIF}
end;

// проверка нажатия клавиши
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then Form1.Close;
end;

// обработка мыши и проигрывание музыки
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    // RU: В данном случаи мы начинаем воспроизводить звук сразу в указанных координатах, но их можно менять и в процессе используя процедуру snd_SetPos.
    //     Важно: Для OpenAL можно позиционировать только mono-звуки
    //
    // EN: In this case, we begin to play the sound directly in these coordinates, but they can be changed later using procedure snd_SetPos.
    //     Important: OpenAL can position only mono-sounds.

// эта часть изменена!!! Теперь можно заново воспроизводить звуки, даже если они не закончили играть.
    if snd_Get(sound, IDSound[0], SND_STATE_PLAYING) = IDSound[0] then
      snd_Stop(sound, IDSound[0]);
    IDSound[0] := snd_Play(sound, FALSE, CalcX2D(X), CalcY2D(Y));
// ------------------------------------------------------------------------------------------

// добавляем проверку на проигрывание звука, только если много развных звуков/музыки, то номера надо менять (не только 1!!!)
    if col2d_PointInRect(X, Y, r) Then
    begin
      if audioPlay then
        snd_Stop(audio, IDSound[1])
      else
        IDSound[1] := snd_Play(audio, False);
      audioPlay := not audioPlay;
    end;
  end;
end;

// для примера использования перемещения мышки
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  mouseX := X;
  mouseY := Y;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  app_PLoop;

  // RU: Проверяем играет ли музыка(1 - играет, 0 - не играет). Так же можно проверить и звуки - подставив zglPSound и ID вот так:
  //     snd_Get( Sound, ID...
  //     ID возвращается функцией snd_Play
  //
  // EN: Check if music playing(1 - playing, 0 - not playing). Sounds also can be checked this way - just use zglPSound and ID:
  //     snd_Get( Sound, ID...
  //     ID returns by function snd_Play.
  state := snd_Get( audio, IDSound[1], SND_STATE_PLAYING );
  if state = 0 Then
    audioPlay := False;

  // RU: Получаем в процентах позицию проигрывания аудиопотока и ставим громкость для плавных переходов.
  // EN: Get position in percent's for audio stream and set volume for smooth playing.
  p := snd_Get( audio, IDSound[1], SND_STATE_PERCENT );
  if ( p >= 0 ) and ( p < 25 ) Then
    snd_SetVolume(audio, IDSound[1], ( 1 / 24 ) * p );
  if ( p >= 75 ) and ( p < 100 ) Then
    snd_SetVolume(audio, IDSound[1], 1 - ( 1 / 24 ) * ( p - 75 ) );
end;

end.

