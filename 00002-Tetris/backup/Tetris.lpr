program Tetris;

{$I zglCustomConfig.cfg}

{$IFDEF WINDOWS}
  {$R *.res}
{$ENDIF}

uses
  zgl_window, zgl_application, zgl_screen, zgl_main,
  zgl_timers, zgl_keyboard, zgl_utils, zgl_primitives_2d, zgl_fx;

const
  StacanWidth = 10;
  StacanHeight = 20;
  MyRect = 25;

  RectClear = 0;
  RectSolid = 255;

  RectRed = 1;
  RectGreen = 2;
  RectBlue = 3;
  RectYellow = 4;                      // c0c000
  RectLilac = 5;                       // 900090
  RectSilver = 6;                      // 909090
  RectGreenT = 7;                      // 307030

  FKub = 0;
  FPalka = 1;                          // spisok figur
  FZigLeft = 2;
  FZigRight = 3;
  FTrap = 4;
  FSapogL = 5;
  FsapogR = 6;

  PRotate = 1;                           // 16, 32, 64
  PRight  = 2;
  PDown   = 4;
  PLeft   = 8;
  PNot    = 0;
  PExist  = 128;

type
  Figure = record
    NumColor, numKadr, maxKadr: Byte;
    MyArray: array[0..15, 0..3] of Byte;
  end;

  PlayerDeyst = record
    Deyst: Byte;
    x, y: Integer;
    numFig, numKadr, maxKadr: Byte;
    PArray: array[0..15, 0..3] of Byte;
    PTime: Byte;
  end;

var
  Stacan: array[- 1..StacanWidth + 1, - 3..StacanHeight + 1] of Byte;
  MyFigure: array[0..6] of Figure;
  MyPlayer: PlayerDeyst;
  ColorCount: array[0..255] of LongWord;                             // spisok ispolzuemyx cvetov
  oldKadr: Byte;

procedure MyPlayerCreate;
var
  i, j: byte;
begin
  MyPlayer.Deyst := PExist;
  MyPlayer.PTime := 0;
  MyPlayer.x := 3;
  MyPlayer.y := - 3;
  MyPlayer.numFig := random(7);

  for i := 0 to 15 do
    for j := 0 to 3 do
      if MyFigure[MyPlayer.numFig].MyArray[i, j] <> 0 then
        MyPlayer.PArray[i, j] := MyFigure[MyPlayer.numFig].NumColor
      else
        MyPlayer.PArray[i, j] := RectClear;
  MyPlayer.numKadr := MyFigure[MyPlayer.numFig].numKadr;
  MyPlayer.maxKadr := MyFigure[MyPlayer.numFig].maxKadr;
end;

// Initialization
procedure MyInit;
var
  i, j: Integer;
begin
  Randomize;

  // inicializaciya stakana
  i := - 3;
  while i < StacanHeight + 1 do
  begin
    j := - 1;
    while j < StacanWidth + 1 do
    begin
      if i = StacanHeight then
        Stacan[j, i] := RectSolid
      else
        if (j = - 1) or (j = StacanWidth) then
          Stacan[j, i] := RectSolid
        else
          Stacan[j, i] := RectClear;

      inc(j);
    end;
    inc(i);
  end;
  // inicializaciya figur
  i := 0;
  while i < 7 do
  begin
    MyFigure[i].NumColor := i + 1;                 // vystavlyayutsa cveta
    MyFigure[FKub].numKadr := 0;                   // nomer kadra
    if i = 0 then
      MyFigure[i].maxKadr := 1;                    // kub
    if (i > 0) and (i < 4) then
      MyFigure[i].maxKadr := 2;                    // palka, zigzag
    if i > 3 then
      MyFigure[i].maxKadr := 4;                    // sapog, trap
    inc(i);
  end;
  // constant cveta
  ColorCount[RectRed]    := $ff0000;
  ColorCount[RectGreen]  := $00ff00;
  ColorCount[RectBlue]   := $0090ff;
  ColorCount[RectYellow] := $cfcf00;
  ColorCount[RectLilac]  := $900090;
  ColorCount[RectClear]  := $f0f0f0;
  ColorCount[RectSilver] := $909090;
  ColorCount[RectGreenT] := $307030;

  ColorCount[RectSolid]  := $0000ff;



  i := 0;
  while i < 4 do
  begin
    j := 0;
    while j < 4 do
    begin
      if i = 1 then
        MyFigure[FPalka].MyArray[i, j] := MyFigure[FPalka].NumColor
      else
        MyFigure[FPalka].MyArray[i, j] := RectClear;
      if j = 2 then
        MyFigure[FPalka].MyArray[i + 4, j] := MyFigure[FPalka].NumColor
      else
        MyFigure[FPalka].MyArray[i + 4, j] := RectClear;

      if (i <> 0) and (i <> 3) and (j <> 0) and (j <> 3) then
        MyFigure[FKub].MyArray[i, j] := MyFigure[FKub].NumColor
      else
        MyFigure[FKub].MyArray[i, j] := RectClear;

      MyFigure[FZigLeft].MyArray[i, j] := RectClear;
      MyFigure[FZigRight].MyArray[i, j] := RectClear;
      MyFigure[FTrap].MyArray[i, j] := RectClear;
      MyFigure[FSapogL].MyArray[i, j] := RectClear;
      MyFigure[FsapogR].MyArray[i, j] := RectClear;

      MyFigure[FZigLeft].MyArray[i + 4, j] := RectClear;
      MyFigure[FZigRight].MyArray[i + 4, j] := RectClear;
      MyFigure[FTrap].MyArray[i + 4, j] := RectClear;
      MyFigure[FSapogL].MyArray[i + 4, j] := RectClear;
      MyFigure[FsapogR].MyArray[i + 4, j] := RectClear;

      MyFigure[FTrap].MyArray[i + 8, j] := RectClear;
      MyFigure[FSapogL].MyArray[i + 8, j] := RectClear;
      MyFigure[FsapogR].MyArray[i + 8, j] := RectClear;

      MyFigure[FTrap].MyArray[i + 12, j] := RectClear;
      MyFigure[FSapogL].MyArray[i + 12, j] := RectClear;
      MyFigure[FsapogR].MyArray[i + 12, j] := RectClear;
      inc(j);
    end;
    inc(i);
  end;
  MyFigure[FZigLeft].MyArray[0, 1] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[0, 2] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[1, 2] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[1, 3] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[0 + 4, 3] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[1 + 4, 2] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[1 + 4, 3] := MyFigure[FZigLeft].NumColor;
  MyFigure[FZigLeft].MyArray[2 + 4, 2] := MyFigure[FZigLeft].NumColor;

  MyFigure[FZigRight].MyArray[1, 1] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[1, 2] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[0, 2] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[0, 3] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[0 + 4, 2] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[1 + 4, 2] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[1 + 4, 3] := MyFigure[FZigRight].NumColor;
  MyFigure[FZigRight].MyArray[2 + 4, 3] := MyFigure[FZigRight].NumColor;

  MyFigure[FTrap].MyArray[0, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[2, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 4, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 4, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[2 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[0 + 8, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 8, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 8, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[2 + 8, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[0 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 12, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FTrap].MyArray[1 + 12, 3] := MyFigure[FTrap].NumColor;

  MyFigure[FSapogL].MyArray[1, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[2, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[0 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[2 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[2 + 4, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[0 + 8, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1 + 8, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1 + 8, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1 + 8, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[0 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[0 + 12, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[1 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FSapogL].MyArray[2 + 12, 2] := MyFigure[FTrap].NumColor;

  MyFigure[FsapogR].MyArray[1, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[0, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[0 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[2 + 4, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[2 + 4, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1 + 8, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1 + 8, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1 + 8, 3] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[2 + 8, 1] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[0 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[1 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[2 + 12, 2] := MyFigure[FTrap].NumColor;
  MyFigure[FsapogR].MyArray[0 + 12, 1] := MyFigure[FTrap].NumColor;

  MyPlayerCreate;
end;

// risuem okno
procedure MyDraw;
var
  i, j: Integer;
begin
  i  := 0;                                    // vyvodim ot nulya
  while i < StacanHeight + 1 do
  begin
    j := - 1;                                 // zdes vyvod ot -1
    while j < StacanWidth + 1 do
    begin
      pr2d_Rect(25 + (j + 1) * MyRect, 25 + i * MyRect, MyRect, MyRect, ColorCount[Stacan[j, i]], 255, PR2D_FILL);

      inc(j);
    end;
    inc(i);
  end;
  // vyvodim figuru

  i := - 3;
  while i < 1 do                              // tak je, my doljy otschityvat s nizu naverx, a poluchaetsa naoborot
  begin
    j := 0;                                   // !!! a zdes ot 0 ))), tak je nado eto ponimat
    while j < 4 do
    begin
      if MyPlayer.PArray[j + (MyPlayer.numKadr * 4), 3 + i] <> 0 then
        if (MyPlayer.y + 3 + i) >= 0 then
          pr2d_Rect(25 + (MyPlayer.x + j + 1) * MyRect, 25 + (MyPlayer.y + 3 + i) * MyRect, MyRect, MyRect,
                                   ColorCount[MyPlayer.PArray[j + (MyPlayer.numKadr * 4), 3 + i]], 255, PR2D_FILL);


      inc(j);
    end;
    inc(i);
  end;

end;

procedure MyKeyboard;
begin
  if key_Press(K_ESCAPE) then winOn := false;

  if key_Press(K_SPACE) then
    MyPlayer.Deyst := MyPlayer.Deyst or PRotate;
  if key_Press(K_RIGHT) and (not key_Press(K_LEFT)) then
    MyPlayer.Deyst := MyPlayer.Deyst or PRight;
  if key_Press(K_DOWN) then
    MyPlayer.Deyst := MyPlayer.Deyst or PDown;
  if key_Press(K_LEFT) and (not key_Press(K_RIGHT)) then
    MyPlayer.Deyst := MyPlayer.Deyst or PLeft;

  key_ClearState;
end;

function MyCollision: Boolean;
var
  i, j: Byte;
begin
  Result := false;
  i := 0;
  while i < 4 do
  begin
    j := 0;
    while j < 4 do
    begin
      if MyPlayer.PArray[j + (MyPlayer.numKadr * 4), i] <> 0 then
      begin
        if Stacan[MyPlayer.x + j, MyPlayer.y + i] <> RectClear then
        begin
          Result := true;
          exit;
        end;
      end;
      inc(j);
    end;
    inc(i);
  end;
end;

procedure MyTimer;
var
  i, j, nCount: Integer;
label
  JmpCol;
begin
  if (MyPlayer.Deyst and PExist) > 0 then
  begin
    MyPlayer.Deyst := PExist;
    MyKeyboard;                                     // rpoverka najatiya klavish
    if (MyPlayer.Deyst and PDown) > 0 then
    begin
      inc(MyPlayer.y);
      if MyCollision then
      begin
        goto JmpCol;
      end;
    end;

    if ((MyPlayer.Deyst and PLeft) > 0) then
    begin
      dec(MyPlayer.x);
      if (MyCollision) then
        inc(MyPlayer.x);
    end;
    if ((MyPlayer.Deyst and PRight) > 0) then
    begin
      inc(MyPlayer.x);
      if (MyCollision) then
      dec(MyPlayer.x);
    end;
    if (MyPlayer.Deyst and PRotate) > 0 then
    begin
       if MyPlayer.maxKadr > 1 then
      begin
        oldKadr := MyPlayer.numKadr;
        inc(MyPlayer.numKadr);
        if MyPlayer.numKadr >= MyPlayer.maxKadr then
          MyPlayer.numKadr := 0;
        if MyCollision then
          MyPlayer.numKadr := oldKadr;
      end;
    end;

    // rabochii cikl
    inc(MyPlayer.PTime);
    if MyPlayer.PTime >= 20 then
    begin
      inc(MyPlayer.y);
      if MyCollision then
      begin
  JmpCol:
        dec(MyPlayer.y);
        MyPlayer.Deyst := 0;                 // udalyaem
        for i := 0 to 3 do
          for j := 0 to 3 do
          begin
            if (MyPlayer.PArray[j + (MyPlayer.numKadr * 4), i] <> 0) then
            begin
              Stacan[MyPlayer.x + j, MyPlayer.y + i] := MyFigure[MyPlayer.numFig].NumColor;
            end;
          end;
//------------------------------------------------------------
        i := StacanHeight - 1;
        while i >= 0 do
        begin
          j := 0;
          nCount := 0;
          while j < StacanWidth  do
          begin
            if Stacan[j, i] <> 0 then
              inc(nCount);
            inc(j);
          end;
          if nCount = StacanWidth then
          begin
            nCount := i;
            while nCount > 0 do
            begin
              for j := 0 to StacanWidth - 1 do
              begin
                Stacan[j, nCount] := Stacan[j, nCount - 1];
              end;
              dec(nCount);
            end;
            for j := 0 to StacanWidth - 1 do
              Stacan[j, nCount] := RectClear;
            inc(i);
          end;
          dec(i);
        end;
//-----------------------------------------------------------
      end;

      MyPlayer.PTime := 0;
    end;
  end;
  if (MyPlayer.Deyst and PExist) = 0 then
  begin
    MyPlayerCreate;
    if MyCollision then winOn := false;           // game over
  end;
end;

begin
  wndHeight := 600;
  wndWidth := 600;
  wndCaption := utf8_Copy('Tetris v 0.1');
  timer_Add(@MyTimer, 30);
  zgl_Reg(SYS_DRAW, @MyDraw);
  zgl_Reg(SYS_LOAD, @MyInit);

  zgl_Init();
end.

