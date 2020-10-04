program ZenTest001;

{$I zglCustomConfig.cfg}

{$IFDEF WINDOWS}
  {$R *.res}
{$ENDIF}

uses
  zgl_window, zgl_screen, zgl_application, zgl_main,
  gl,
//  dglOpenGL,                                     // добавил чтоб проверить работоспособность
  // это вообще недоработка, если мы используем фонт и через какие-то текстуры, то файлы для работы с этими текстурами должны грузится автоматически
  zgl_textures_png,
  zgl_timers, zgl_keyboard, zgl_primitives_2d, zgl_fx, zgl_utils, zgl_font, zgl_text,
  zgl_opengl_all;

const
  MaxArray = 80;

type
  myPoint = record
    X, Y, Z: Single;
    count: GLshort;
  end;

var
  dirRes    : UTF8String = 'data/';
  fntMain   : zglPFont;
  z: Double;
// peremennye
  mode: Integer;                               // rejim otobrajeniya
  _type: Byte = 0;                             // sposob otobrajeniya
  start: Boolean = false;

  PointArr, ColorArr: array [0..100000, 0..2] of Single;

  begin_mode: array[0..9] of Byte =            // massiv rejimov otobrajeniya
                              (GL_POINTS, GL_LINES, GL_LINE_LOOP, GL_LINE_STRIP, GL_TRIANGLES, GL_TRIANGLE_FAN, GL_TRIANGLE_STRIP,
                              GL_QUADS, GL_QUAD_STRIP, GL_POLYGON);
  myPoints01: array[0..MaxArray - 1, 0..2] of Single = ((50, 150, 0), (100, 170, 0), (140, 140, 0), (130, 100, 0), (150, 50, 0), (100, 30, 0), (160, 60, 0), (100, 100, 0),//);
 { myPoints02: array[0..7, 0..1] of Single = (}(150, 150, 0), (200, 170, 0), (240, 140, 0), (230, 100, 0), (250, 50, 0), (200, 30, 0), (260, 60, 0), (200, 100, 0),//);
{  myPoints03: array[0..15, 0..1] of Single = (}(250, 150, 0), (300, 170, 0), (340, 140, 0), (330, 100, 0), (350, 50, 0), (300, 30, 0), (360, 60, 0), (300, 100, 0),//);
{  myPoints04: array[0..7, 0..1] of Single = (}(350, 150, 0), (400, 170, 0), (440, 140, 0), (430, 100, 0), (450, 50, 0), (400, 30, 0), (460, 60, 0), (400, 100, 0),//);
{  myPoints05: array[0..15, 0..1] of Single = (}(450, 150, 0), (500, 170, 0), (540, 140, 0), (530, 100, 0), (550, 50, 0), (500, 30, 0), (560, 60, 0), (500, 100, 0),//);
{  myPoints06: array[0..7, 0..1] of Single = (}(550, 150, 0), (600, 170, 0), (640, 140, 0), (630, 100, 0), (650, 50, 0), (600, 30, 0), (660, 60, 0), (600, 100, 0),//);
{  myPoints07: array[0..15, 0..1] of Single = (}(650, 150, 0), (700, 170, 0), (740, 140, 0), (730, 100, 0), (750, 50, 0), (700, 30, 0), (760, 60, 0), (700, 100, 0),//);
{  myPoints08: array[0..7, 0..1] of Single = (}(50, 250, 0), (100, 270, 0), (140, 240, 0), (130, 200, 0), (150, 150, 0), (100, 130, 0), (60, 160, 0), (100, 200, 0),//);
{  myPoints09: array[0..15, 0..1] of Single = (}(50, 350, 0), (100, 370, 0), (140, 340, 0), (130, 300, 0), (150, 250, 0), (100, 230, 0), (60, 260, 0), (100, 300, 0),//);
{  myPoints10: array[0..7, 0..1] of Single = (}(50, 450, 0), (100, 470, 0), (140, 440, 0), (130, 400, 0), (150, 350, 0), (100, 330, 0), (60, 360, 0), (100, 400, 0));

  myColor01: array[0..MaxArray - 1, 0..2] of Single = ((1, 0, 0), (1, 0.5, 0), (1, 0.5, 0.5), (1, 1, 0), (0, 1, 0), (0, 1, 0.5), (0.5, 1, 0.5), (0, 1, 1),//);
{  myColor02: array[0..7, 0..2] of Single = (}(0, 1, 0), (0.5, 1, 0), (0.5, 1, 0.5), (1, 1, 0), (1, 0, 0), (1, 0, 0.5), (1, 0.5, 0.5), (1, 0, 1),//);
{  myColor03: array[0..15, 0..2] of Single = (}(1, 0, 0), (1, 0, 0.5), (1, 0.5, 0.5), (1, 0, 1), (0, 0, 1), (0, 0.5, 1), (0.5, 0.5, 1), (0, 1, 1),//);
{  myColor04: array[0..7, 0..2] of Single = (}(0, 0, 1), (0, 0.5, 1), (0.5, 0.5, 1), (0, 1, 1), (0, 1, 0), (0.5, 1, 0), (0.5, 1, 0.5), (1, 1, 0), //);
{  myColor05: array[0..15, 0..2] of Single = (}(0.5, 0, 0), (0.5, 0.5, 0), (0.5, 0.5, 0.5), (0.5, 1, 0), (0, 1, 0), (0, 1, 0.5), (0.5, 1, 0.5), (0, 1, 1),//);
{  myColor06: array[0..7, 0..2] of Single = (}(0, 0.5, 0), (0.5, 0.5, 0), (0.5, 0.5, 0.5), (1, 0.5, 0), (0, 0.5, 0), (0, 0.5, 0.5), (0.5, 0.5, 0.5), (0, 0.5, 1),//);
{  myColor07: array[0..15, 0..2] of Single = (}(1, 0, 0), (1, 0.5, 0), (1, 0.5, 0.5), (1, 1, 0), (0, 1, 0), (0, 1, 0.5), (0.5, 1, 0.5), (0, 1, 1),//);
{  myColor08: array[0..7, 0..2] of Single = (}(1, 0, 0), (1, 0.5, 0), (1, 0.5, 0.5), (1, 1, 0), (0, 1, 0), (0, 1, 0.5), (0.5, 1, 0.5), (0, 1, 1), //);
{  myColor09: array[0..15, 0..2] of Single = (}(1, 0, 0), (1, 0.5, 0), (1, 0.5, 0.5), (1, 1, 0), (0, 1, 0), (0, 1, 0.5), (0.5, 1, 0.5), (0, 1, 1),//);
{  myColor10: array[0..7, 0..2] of Single = (}(1, 0, 0), (1, 0.5, 0), (1, 0.5, 0.5), (1, 1, 0), (0, 1, 0), (0, 1, 0.5), (0.5, 1, 0.5), (0, 1, 1));

procedure MyInit;
begin
  fntMain := font_LoadFromFile(dirRes + 'font.zfi');
  glClearColor(1, 1, 1, 1);
  setTextScale(2);
//  glNewList(1, GL_COMPILE);

//  glEndList();

end;

procedure MyDraw;
var
  i, n, zz, countPoint: Integer;
  s: String;
  m: Double;
  verr: array of GLshort;               // 65535 max
  mass: array of myPoint;
  yes: Boolean;
begin
//  if start then
  m := timer_GetTicks;
  if (_type and 1) > 0 Then
  begin

{    glPushClientAttrib(GL_CLIENT_ALL_ATTRIB_BITS);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);      }

{    SetLength(PointArr, 8000);
    SetLength(ColorArr, 8000);}
    SetLength(verr, 1000);
    SetLength(mass, 1000);
    i := 0;
    countPoint := 0;                           // kol-vo raznyx tochek
    for n := 0 to (MaxArray - 1) * 1 do
    begin
{      if Length(PointArr) < n then
        SetLength(PointArr, n + 1000);}
{      PointArr[n, 0] := myPoints01[i, 0];           // x
      ColorArr[n, 0] := myColor01[i, 0];            // y
      PointArr[n, 1] := myPoints01[i, 1];           // x
      ColorArr[n, 1] := myColor01[i, 1];            // y
      PointArr[n, 2] := myPoints01[i, 2];           // x
      ColorArr[n, 2] := myColor01[i, 2];            // y     }

      if countPoint <> 0 then
      begin
        zz := 0;
        yes := false;
        while zz <= countPoint do
        begin
          if (mass[zz].X = myPoints01[i, 0]) and (mass[zz].Y = myPoints01[i, 1]) and (mass[zz].Z = myPoints01[i, 2]) then
          begin
            verr[n] := mass[zz].count;
            yes := True;
            break;
          end;
          inc(zz);
        end;
      end;
      if not yes then
      begin
        mass[countPoint].X := myPoints01[i, 0];
        mass[countPoint].Y := myPoints01[i, 1];
        mass[countPoint].Z := myPoints01[i, 2];
        mass[countPoint].count := countPoint;
        verr[n] := countPoint;
        PointArr[countPoint, 0] := myPoints01[i, 0];           // x
        ColorArr[countPoint, 0] := myColor01[i, 0];            // y
        PointArr[countPoint, 1] := myPoints01[i, 1];           // x
        ColorArr[countPoint, 1] := myColor01[i, 1];            // y
        PointArr[countPoint, 2] := myPoints01[i, 2];           // x
        ColorArr[countPoint, 2] := myColor01[i, 2];
        inc(countPoint);
      end;

      inc(i);
      if i >= 80 then
        i := 0;
{      glVertexPointer(3, GL_FLOAT, 0, @myPoints01);

      glColorPointer(3, GL_FLOAT, 0, @myColor01);
      glDrawArrays(begin_mode[mode], 0, 80);      }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints02);
      glColorPointer(3, GL_FLOAT, 0, @myColor02);
      glDrawArrays(begin_mode[mode], 0, 8);      }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints03);
      glColorPointer(3, GL_FLOAT, 0, @myColor03);
      glDrawArrays(begin_mode[mode], 0, 16); }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints04);
      glColorPointer(3, GL_FLOAT, 0, @myColor04);
      glDrawArrays(begin_mode[mode], 0, 8);}

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints05);
      glColorPointer(3, GL_FLOAT, 0, @myColor05);
      glDrawArrays(begin_mode[mode], 0, 16); }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints06);
      glColorPointer(3, GL_FLOAT, 0, @myColor06);
      glDrawArrays(begin_mode[mode], 0, 8); }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints07);
      glColorPointer(3, GL_FLOAT, 0, @myColor07);
      glDrawArrays(begin_mode[mode], 0, 16); }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints08);
      glColorPointer(3, GL_FLOAT, 0, @myColor08);
      glDrawArrays(begin_mode[mode], 0, 8); }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints09);
      glColorPointer(3, GL_FLOAT, 0, @myColor09);
      glDrawArrays(begin_mode[mode], 0, 16); }

{      glVertexPointer(2, GL_FLOAT, 0, @myPoints10);
      glColorPointer(3, GL_FLOAT, 0, @myColor10);
      glDrawArrays(begin_mode[mode], 0, 8); }
    end;
{    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);
    glPopClientAttrib();                   }
//    z := timer_GetTicks - m;
    start := false;
    SetLength(verr, 0);
    SetLength(mass, 0);
  end
  else begin
 //   m := timer_GetTicks;
//      glEnable(GL_BLEND);
      for n := 0 to 1 do
      begin
        glBegin(begin_mode[mode]);
        for i := 0 to 79 do
        begin
          glColor3fv(myColor01[i]);
          glVertex3fv(myPoints01[i]);
        end;
        glEnd;
{        glBegin(begin_mode[mode]);
        for i := 0 to 7 do
        begin
          glColor3fv(myColor02[i]);
          glVertex2fv(myPoints02[i]);
        end;
        glEnd;}
{        glBegin(begin_mode[mode]);
        for i := 0 to 16 do
        begin
          glColor3fv(myColor03[i]);
          glVertex2fv(myPoints03[i]);
        end;
        glEnd;}
 {       glBegin(begin_mode[mode]);
        for i := 0 to 7 do
        begin
          glColor3fv(myColor04[i]);
          glVertex2fv(myPoints04[i]);
        end;
        glEnd;}
{        glBegin(begin_mode[mode]);
        for i := 0 to 16 do
        begin
          glColor3fv(myColor05[i]);
          glVertex2fv(myPoints05[i]);
        end;
        glEnd; }
{        glBegin(begin_mode[mode]);
        for i := 0 to 7 do
        begin
          glColor3fv(myColor06[i]);
          glVertex2fv(myPoints06[i]);
        end;
        glEnd; }
 {       glBegin(begin_mode[mode]);
        for i := 0 to 16 do
        begin
          glColor3fv(myColor07[i]);
          glVertex2fv(myPoints07[i]);
        end;
        glEnd; }
{        glBegin(begin_mode[mode]);
        for i := 0 to 7 do
        begin
          glColor3fv(myColor08[i]);
          glVertex2fv(myPoints08[i]);
        end;
        glEnd; }
{        glBegin(begin_mode[mode]);
        for i := 0 to 16 do
        begin
          glColor3fv(myColor09[i]);
          glVertex2fv(myPoints09[i]);
        end;
        glEnd;
}{        glBegin(begin_mode[mode]);
        for i := 0 to 7 do
        begin
          glColor3fv(myColor10[i]);
          glVertex2fv(myPoints10[i]);
        end;
        glEnd;}
      end;
//      glDisable(GL_BLEND);
//    z := timer_GetTicks - m;
//    start := false;
  end;

  if (_type and 1) > 0 Then
  begin
    glPushClientAttrib(GL_CLIENT_ALL_ATTRIB_BITS);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);

    glVertexPointer(3, GL_FLOAT, 0, @PointArr[0]);

    glColorPointer(3, GL_FLOAT, 0, @ColorArr[0]);
 //   glDrawArrays(begin_mode[mode], 0, MaxArray * 1);

    glDrawElements(begin_mode[mode], MaxArray, GL_UNSIGNED_SHORT, @verr);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);
    glPopClientAttrib();
  end;

  z := timer_GetTicks - m;
  glColor4f(0, 0.5, 0, 1);
  text_Draw(fntMain, 550, 300, utf8_Copy('FPS = ' + u_IntToStr(zgl_Get(RENDER_FPS))));
  if mode = GL_POINTS then s := 'GL_POINTS';              //!!!!!!
  if mode = GL_LINES then s := 'GL_LINES';                //!!!!!!
  if mode = GL_LINE_LOOP then s := 'GL_LINE_LOOP';
  if mode = GL_LINE_STRIP then s := 'GL_LINE_STRIP';
  if mode = GL_TRIANGLES then s := 'GL_TRIANGLES';        //!!!!!!
  if mode = GL_TRIANGLE_FAN then s := 'GL_TRIANGLE_FAN';
  if mode = GL_TRIANGLE_STRIP then s := 'GL_TRIANGLE_STRIP';
  if mode = GL_QUADS then s := 'GL_QUADS';
  if mode = GL_QUAD_STRIP then s := 'GL_QUAD_STRIP';
  if mode = GL_POLYGON then s := 'GL_POLYGON';
  text_Draw(fntMain, 550, 330, utf8_Copy('mode: ' + s));
  if _type = 0 then
    s := 'vertex'
  else
    s := 'vertex pointer';
  text_Draw(fntMain, 550, 360, utf8_Copy('type: ' + s));
  text_Draw(fntMain, 550, 390, utf8_Copy('n = ' + u_IntToStr(round(z))));

{  SetLength(PointArr, 0);
  SetLength(ColorArr, 0);}
end;

procedure MyTimer;
begin
  if key_Press(K_ESCAPE) then winOn := false;

  if key_Press(K_KP_ADD) then
  begin
    inc(mode);
    if mode > 9 then mode := 0;
  end;
  if key_Press(K_KP_SUB) then
  begin
    dec(mode);
    if mode < 0 then mode := 9;
  end;
  if key_Press(K_F1) then
    _type := _type xor 1;

//  if key_Press(K_SPACE) then start := true;

  key_ClearState;
end;

begin
  timer_Add(@MyTimer, 20);
  zgl_Reg(SYS_LOAD, @MyInit);
  zgl_Reg(SYS_DRAW, @MyDraw);

  zgl_Init(8, 8);
end.

