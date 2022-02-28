program demo09;

{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

{$R *.res}

uses
  zglSpriteEngine,
  zgl_screen,
  zgl_window,
  zgl_application,
  zgl_timers,
  zgl_keyboard,
  zgl_render_2d,
  zgl_fx,
  zgl_textures,
  zgl_textures_png,
  zgl_sprite_2d,
  zgl_primitives_2d,
  zgl_font,
  zgl_text,
  zgl_types,
  zgl_utils
  {$IfNDef OLD_METHODS}
  , gegl_color
  {$EndIf}
  ;

type
  CMiku = class(zglCSprite2D)
  protected
    FSpeed: zglTPoint2D;
  public
    procedure OnInit(_Texture: zglPTexture; _Layer: Integer); override;
    procedure OnDraw; override;
    procedure OnProc; override;
    procedure OnFree; override;
  end;

var
  dirRes   : UTF8String {$IFNDEF MACOSX} = '../data/' {$ENDIF};
  fntMain  : LongWord = 0;
  texLogo  : zglPTexture;
  texMiku  : zglPTexture;
  time     : Integer;
  sengine2d: zglCSEngine2D;
  TimeStart : LongWord = 0;
  TimeMiku  : LongWord = 0;

  newColor  : LongWord;
  correctColor: array[0..1] of LongWord;

// Miku
procedure CMiku.OnInit(_Texture: zglPTexture; _Layer: Integer);
begin
  // RU: ������ ���� �������� � ���� ��� �������, ������ ����������� ����������� ��������� ����� ������ � ������ �� ������ ������ � ����� � ��������.
  // EN: Set own texture and layer for sprite, also standard parameters will be set automatically(like width and height from info about texture).
  inherited OnInit(texMiku, random(10));

  X := 800 + random(800);
  Y := random(600 - 128);
  // RU: ������ �������� ��������.
  // EN: Set the moving speed.
  FSpeed.X := -random(10) / 5 - 0.5;
  FSpeed.Y := (random(10) - 5) / 5;
end;

procedure CMiku.OnDraw;
begin
  // RU: �.�. �� ���� ��� ��������� ��������� ������ ��� �������, �� ������� �������� ����� OnDraw ������ zglCSprite2D.
  // EN: Because in fact, this procedure is declared only for example, so call to the main method OnDraw of class zglCSprite2D.
  inherited;
end;

procedure CMiku.OnProc;
begin
  inherited;
  X := X + FSpeed.X;
  Y := Y + FSpeed.Y;
  Frame := Frame + (abs(FSpeed.X) + abs(FSpeed.Y)) / 25;
  if Frame > 8 Then
    Frame := 1;

  // RU: ���� ������ ������� �� ������� �� X, ����� �� ������� ���.
  // EN: Delete the sprite if it goes beyond X.
  if X < -128 Then sengine2d.DelSprite(ID);

  // RU: ���� ������ ������� �� ������� �� Y, ������ ��� � ������� �� ��������
  // EN: Add sprite to queue for delete if it goes beyond Y.
  if Y < -128 Then Kill := TRUE;
  if Y > 600  Then Kill := TRUE;
end;

procedure CMiku.OnFree;
begin
  inherited;
end;

// RU: �������� 100 ��������.
// EN: Add 100 sprites.
procedure AddMiku;
  var
    i, ID: Integer;
begin
  for i := 1 to 100 do
    begin
      // RU: ����������� � ����������� ��������� ����� "�����" ��� ������ :)
      // EN: Request a "place" for a new sprite :)
      ID := sengine2d.AddSprite();
      // RU: ������� ��������� ������� CMiku. ����������� ������������ �������� ��� �������� � ������� ID ��� �������.
      // EN: Create a new CMiku. Constructor arguments must be current sprite engine and future ID for sprite.
      sengine2d.List[ID] := CMiku.Create(sengine2d, ID);
    end;
end;

// RU: ������� 100 ��������.
// EN: Delete 100 sprites.
procedure DelMiku;
  var
    i: Integer;
begin
  // RU: ������ 100 �������� �� ��������� ID.
  // EN: Delete 100 sprites with random ID.
  for i := 1 to 100 do
    sengine2d.DelSprite(random(sengine2d.Count));
end;

procedure Init;
  var
    i: Integer;
begin
  texLogo := tex_LoadFromFile(dirRes + 'zengl.png');

  texMiku := tex_LoadFromFile(dirRes + 'miku.png');
  tex_SetFrameSize(texMiku, 128, 128);

  // RU: ������� ��������� zglCSEngine2D.
  // EN: Create zglCSEngine2D object.
  sengine2d := zglCSEngine2D.Create();

  // RU: �������� 1000 �������� Miku-chan :)
  // EN: Create 1000 sprites of Miku-chan :)
//  for i := 0 to 9 do
//    AddMiku();

  fntMain := font_LoadFromFile( dirRes + 'font.zfi' );
  setFontTextScale(15, fntMain);

  newColor := Color_FindOrAdd($80A080FF - 55);
  correctColor[1] := Color_FindOrAdd($7FAF7FFF);
  correctColor[0] := Color_FindOrAdd($AFAFAFFF);
end;

procedure Draw;
var
  i: LongWord;
begin
  // RU: ������ ��� ������� ����������� � ������� ���������� ���������.
  // EN: Render all sprites contained in current sprite engine.
  if time > 255 Then
    sengine2d.Draw();

  if time <= 255 Then
  begin
    i := Get_Color(correctColor[1]);
    pr2d_Rect(0, 0, 800, 600,{$IfDef OLD_METHODS} $7FAF7F, 255,{$Else}correctColor[1],{$EndIf} PR2D_FILL);
    dec(i);
    if i < $7FAF7F00 then
      i := $7FAF7F00;
    Correct_Color(correctColor[1], i);
    ssprite2d_Draw(texLogo, 400 - 256, 300 - 128, 512, 256, 0, time)
  end
  else
    if time < 510 Then
      begin
        i := Get_Color(correctColor[0]);
        pr2d_Rect( 0, 0, 800, 600,{$IfDef OLD_METHODS} $AFAFAF, 510 - time,{$Else}correctColor[0],{$EndIf} PR2D_FILL );
        dec(i);
        if i < $AFAFAF00 then
          i := $AFAFAF00;
        Correct_Color(correctColor[0], i);
        ssprite2d_Draw(texLogo, 400 - 256, 300 - 128, 512, 256, 0, 510 - time);
      end;

  if time > 255 Then
    begin
      pr2d_Rect(0, 0, 256, 64, {$IfDef OLD_METHODS} $80A080, 200,{$Else}newColor,{$EndIf} PR2D_FILL);
      text_Draw(fntMain, 0, 0, 'FPS: ' + u_IntToStr(zgl_Get(RENDER_FPS)));
      text_Draw(fntMain, 0, 20, 'Sprites: ' + u_IntToStr(sengine2d.Count));
      text_Draw(fntMain, 0, 40, 'Up/Down - Add/Delete Miku :)');
    end;
end;

procedure Timer;
begin
  INC(time);

  // RU: ��������� ��������� ���� �������� � ������� ���������� ���������.
  // EN: Process all sprites contained in current sprite engine.
  sengine2d.Proc();
end;

procedure KeyMouseEvent;
begin
  // RU: �� ������� ������� �������� ��� �������.
  // EN: Delete all sprites if space was pressed.
  if key_Press(K_SPACE) Then
    sengine2d.ClearAll();
  if key_Press(K_UP) Then
    AddMiku();
  if key_Press(K_DOWN) Then
    DelMiku();
end;

procedure Quit;
begin
  // RU: ������� ������ �� ��������� ��������.
  // EN: Free allocated memory for sprites.
  sengine2d.Destroy();
end;

Begin
  randomize();

  TimeStart := timer_Add( @Timer, 16, t_Start );
  TimeMiku := timer_Add( @AddMiku, 1000, t_SleepToStart, 6 );

  zgl_Reg(SYS_EVENTS, @KeyMouseEvent);
  zgl_Reg(SYS_LOAD, @Init);
  zgl_Reg(SYS_DRAW, @Draw);
  zgl_Reg(SYS_EXIT, @Quit);

  wnd_SetCaption(utf8_Copy('09 - Sprite Engine(Classes)'));

  zgl_Init();
End.
