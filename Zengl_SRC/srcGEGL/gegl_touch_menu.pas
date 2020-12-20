unit gegl_touch_menu;

interface

const
  NameShift = 'Shift';
  NameLatin = 'Latin';
  NameRus = 'Rus';
  NameSymb = 'symb...';            
  NameKeyboard = 'Keyb';            
  NameHome = 'Home';
  NameEnd = 'End';
  NameCtrl = 'Ctrl';
  NameEnter = 'Enter';
  NameTab = 'Tab';
  NameCapsLock = 'Caps';
  NameInsert = 'Ins';
  NameBackSpace = 'BS';

  NameSave01 = 'Save';
  NameSave02 = 'Сохранить';
  NameLoad01 = 'Load';
  NameLoad02 = 'Загрузить';
  NameExit01 = 'Exit';
  NameExit02 = 'Выход';
  NameChange = '...';                

  TouchMenuGame1 = 1;
  TouchMenuGame2 = 2;
  TouchMenuKeySymb = 4;
  TouchMenuKeyNumb = 8;

  TouchMenuChange = 128;              

  keyboardCaps = 1;
  keyboardLatinRus = 2;
  keyboardInsert = 4;
  keyboardSymbol = 8;
  keyboardShift = 16;

  _Tab = 35;
  _CapsLock = 36;
  _Enter = 37;
  _Shift = 38;
  _Space = 39;
  _Latin = 40;
  _Rus = 41;
  _symb = 42;
  _Ctrl = 36;
  _Home = 40;
  _End = 41;
  _Keyboard = 42;
  _Insert = 43;
  _Del = 44;
  _Up = 24;
  _Left = 25;
  _Down = 26;
  _Right = 27;

type
  _touchButton = record
    X, Y, Angle: Single;
    bPush: Byte;                          
    _key: Byte;                           
  end;

  _oneTouchButtonJoy = record   
    X, Y: Single;
    _key: Byte;
    symb: UTF8String;
    bPush: Byte;
  end;

  _touchRolling = record
    X, Y, R, _x, _y: Single;    
    direction: Single;          
    bPush: Byte;                
  end;

  _keyTouchJoy = record
    textScale: LongWord;
    count: Byte;
    Width, Height: Single;
    BArrow: array[1..9] of _touchButton;
    OneButton: array[1..8] of _oneTouchButtonJoy;
    TextureUp, TextureDown: Cardinal;     
  end;

  _keyTouchJoyRolling = record
    textScale: LongWord;
    count: Byte;
    Width, Height: Single;
    Rolling: _touchRolling;
    OneButton: array[1..8] of _oneTouchButtonJoy;
  end;

  _oneTouchButton = record
    X, Y: Single;
    _key: byte;                 
    symb: array [1..4] of UTF8String;     
                                
  end;

  _oneDoubleTouchButton = record
    X, Y: Single;
    _key: byte;                 
    symb: array [1..2] of UTF8String;     
                               
  end;

  _stringTouchButton = record
    X, Y: Single ;
    Width: Single;
    _key: byte;
    bString: UTF8String;        
  end;

  _keyTouch = record            
    textScale: LongWord;
    count: Byte;                
    OWidth, Height: Single;       
    OneButton: array[1..34] of _oneTouchButton;
    StringButton: array[35..44] of _stringTouchButton;
    Flags: integer;             
    {.$IF defined(MACOSX) or defined(LINUX) or defined(WINDOWS)}
    FlagsKeyb: Integer;
    {.$IfEnd}
    bPush: Byte;                
    _keyPush: Byte;             
  end;

  _touchBArrow = record
    X, Y, Angle: Single;
    _key: Byte;                           
  end;
  _keyTouchSymb = record
    textScale: LongWord;
    count: Byte;                
    OWidth, Height: Single;     
    OneDoubleButton: array[1..23] of _oneDoubleTouchButton;
    BArrow: array[24..27] of _touchBArrow;
    StringButton: array[36..44] of _stringTouchButton;
    Flags: integer;             
    bPush: Byte;                
    _keyPush: Byte;             
    TextureUp, TextureDown: Cardinal;    
  end;

var
  TouchJoy: _keyTouchJoy;                             
  TouchJoyRolling: _keyTouchJoyRolling;
  TouchKey: _keyTouch;                                
  TouchKeySymb: _keyTouchSymb;                        

procedure SetMenuProcess(NumMenu: Byte);

procedure CreateGameJoy01;
procedure CreateGameJoy02;
procedure CreateTouchKeyboard;
procedure CreateTouchSymbol;

procedure UseGameJoy01Up;
procedure UseGameJoy02Up;
procedure UseTouchKeyboardUp;
procedure UseTouchSymbolUp;

procedure UseGameJoy01Down;
procedure UseGameJoy02Down;
procedure UseTouchKeyboardDown;
procedure UseTouchSymbolDown;

implementation

uses
  zgl_window,
  zgl_keyboard, {$IfDef Delphi} AsctoUtf, {$EndIf}
  zgl_math_2d,
  zgl_application,
  gegl_draw_gui,
  zgl_mouse;

procedure SetMenuProcess(NumMenu: Byte);
begin
  if (NumMenu = 0) or (NumMenu > MaxNumMenu) then exit;
  if NumMenu = 1 then
  begin
    app_UseMenuDown := @UseGameJoy01Down;
    app_UseMenuUp := @UseGameJoy01Up;
    app_DrawGui := @DrawGameJoy01;
  end;
  if NumMenu = 2 then
  begin
    app_UseMenuDown := @UseGameJoy02Down;
    app_UseMenuUp := @UseGameJoy02Up;
    app_DrawGui := @DrawGameJoy02;
  end;
  if NumMenu = 3 then
  begin
    app_UseMenuDown := @UseTouchKeyboardDown;
    app_UseMenuUp := @UseTouchKeyboardUp;
    app_DrawGui := @DrawTouchKeyboard;
  end;
  if NumMenu = 4 then
  begin
    app_UseMenuDown := @UseTouchSymbolDown;
    app_UseMenuUp := @UseTouchSymbolUp;
    app_DrawGui := @DrawTouchSymbol;
  end;
end;

procedure TouchKeyDown(KeyCode: byte);        
begin                                         
  keysDown[KeyCode] := TRUE;                  
  keysUp[KeyCode] := FALSE;
  keysLast[KA_DOWN] := KeyCode;
  {$IfDef LINUX}
  doKeyPress(KeyCode);
  {$else}
  keysPress[KeyCode] := TRUE;
  keysCanPress[KeyCode] := FALSE;
  {$EndIf}
end;

procedure TouchKeyUp(KeyCode: byte);
begin
  keysDown[KeyCode] := FALSE;
  keysUp  [KeyCode] := TRUE;
  keysLast[KA_UP] := KeyCode;
end;

procedure CreateGameJoy01;
begin
  TouchJoyRolling.count := 4;               
  TouchJoyRolling.textScale := 22;          
  TouchJoyRolling.Rolling.X := 55;
  TouchJoyRolling.Rolling.Y := wndHeight - 55;
  TouchJoyRolling.Rolling.R := 50;
  TouchJoyRolling.Rolling.bPush := 0;       

  TouchJoyRolling.Width := 45;
  TouchJoyRolling.Height := 45;

  TouchJoyRolling.OneButton[1].X := wndWidth - 100;
  TouchJoyRolling.OneButton[1].Y := wndHeight - 100;
  TouchJoyRolling.OneButton[1].bPush := 0;
  TouchJoyRolling.OneButton[2].X := TouchJoyRolling.OneButton[1].X + 50;
  TouchJoyRolling.OneButton[2].Y := TouchJoyRolling.OneButton[1].Y;
  TouchJoyRolling.OneButton[2].bPush := 0;
  TouchJoyRolling.OneButton[3].X := TouchJoyRolling.OneButton[1].X;
  TouchJoyRolling.OneButton[3].Y := TouchJoyRolling.OneButton[1].Y + 50;
  TouchJoyRolling.OneButton[3].bPush := 0;
  TouchJoyRolling.OneButton[4].X := TouchJoyRolling.OneButton[1].X + 50;
  TouchJoyRolling.OneButton[4].Y := TouchJoyRolling.OneButton[1].Y + 50;
  TouchJoyRolling.OneButton[4].bPush := 0;
  TouchJoyRolling.OneButton[1]._key := K_A;
  TouchJoyRolling.OneButton[2]._key := K_B;
  TouchJoyRolling.OneButton[3]._key := K_C;
  TouchJoyRolling.OneButton[4]._key := K_D;

  TouchJoyRolling.OneButton[1].symb := 'A';               
  TouchJoyRolling.OneButton[2].symb := 'B';
  TouchJoyRolling.OneButton[3].symb := 'C';
  TouchJoyRolling.OneButton[4].symb := 'D';

  MenuChange := TouchMenuGame1;
  SetMenuProcess(1);
end;

procedure CreateGameJoy02;
begin
  TouchJoy.count := 5;
  TouchJoy.textScale := 22;
  TouchJoy.Width := 45;
  TouchJoy.Height := 45;

  TouchJoy.BArrow[7].X := 5;
  TouchJoy.BArrow[7].Y := wndHeight - 150;
  TouchJoy.BArrow[7].Angle := 315;
  TouchJoy.BArrow[7].bPush := 0;

  TouchJoy.BArrow[8].X := TouchJoy.BArrow[7].X + 50;
  TouchJoy.BArrow[8].Y := TouchJoy.BArrow[7].Y;
  TouchJoy.BArrow[8].Angle := 0;
  TouchJoy.BArrow[8].bPush := 0;

  TouchJoy.BArrow[9].X := TouchJoy.BArrow[7].X + 100;
  TouchJoy.BArrow[9].Y := TouchJoy.BArrow[7].Y;
  TouchJoy.BArrow[9].Angle := 45;
  TouchJoy.BArrow[9].bPush := 0;

  TouchJoy.BArrow[4].X := TouchJoy.BArrow[7].X;
  TouchJoy.BArrow[4].Y := TouchJoy.BArrow[7].Y + 50;
  TouchJoy.BArrow[4].Angle := 270;
  TouchJoy.BArrow[4].bPush := 0;

  TouchJoy.OneButton[1].X := TouchJoy.BArrow[7].X + 50;            
  TouchJoy.OneButton[1].Y := TouchJoy.BArrow[7].Y + 50;
  TouchJoy.OneButton[1].bPush := 0;
  TouchJoy.BArrow[6].X := TouchJoy.BArrow[7].X + 100;
  TouchJoy.BArrow[6].Y := TouchJoy.BArrow[7].Y + 50;
  TouchJoy.BArrow[6].Angle := 90;
  TouchJoy.BArrow[6].bPush := 0;

  TouchJoy.BArrow[1].X := TouchJoy.BArrow[7].X;
  TouchJoy.BArrow[1].Y := TouchJoy.BArrow[7].Y + 100;
  TouchJoy.BArrow[1].Angle := 225;
  TouchJoy.BArrow[1].bPush := 0;

  TouchJoy.BArrow[2].X := TouchJoy.BArrow[7].X + 50;
  TouchJoy.BArrow[2].Y := TouchJoy.BArrow[7].Y + 100;
  TouchJoy.BArrow[2].Angle := 180;
  TouchJoy.BArrow[2].bPush := 0;

  TouchJoy.BArrow[3].X := TouchJoy.BArrow[7].X + 100;
  TouchJoy.BArrow[3].Y := TouchJoy.BArrow[7].Y + 100;
  TouchJoy.BArrow[3].Angle := 135;
  TouchJoy.BArrow[3].bPush := 0;

  TouchJoy.BArrow[1]._key := K_KP_1;
  TouchJoy.BArrow[2]._key := K_KP_2;
  TouchJoy.BArrow[3]._key := K_KP_3;
  TouchJoy.BArrow[4]._key := K_KP_4;
  TouchJoy.BArrow[6]._key := K_KP_6;
  TouchJoy.BArrow[7]._key := K_KP_7;
  TouchJoy.BArrow[8]._key := K_KP_8;
  TouchJoy.BArrow[9]._key := K_KP_9;

  TouchJoy.TextureUp := 1;        
  TouchJoy.TextureDown := 2;

  TouchJoy.OneButton[2].X := wndWidth - 100;
  TouchJoy.OneButton[2].Y := wndHeight - 100;
  TouchJoy.OneButton[2].bPush := 0;
  TouchJoy.OneButton[3].X := TouchJoy.OneButton[2].X + 50;
  TouchJoy.OneButton[3].Y := TouchJoy.OneButton[2].Y;
  TouchJoy.OneButton[3].bPush := 0;
  TouchJoy.OneButton[4].X := TouchJoy.OneButton[2].X;
  TouchJoy.OneButton[4].Y := TouchJoy.OneButton[2].Y + 50;
  TouchJoy.OneButton[4].bPush := 0;
  TouchJoy.OneButton[5].X := TouchJoy.OneButton[2].X + 50;
  TouchJoy.OneButton[5].Y := TouchJoy.OneButton[2].Y + 50;
  TouchJoy.OneButton[5].bPush := 0;

  TouchJoy.OneButton[1]._key := K_SPACE;
  TouchJoy.OneButton[2]._key := K_A;
  TouchJoy.OneButton[3]._key := K_B;
  TouchJoy.OneButton[4]._key := K_C;
  TouchJoy.OneButton[5]._key := K_D;

  TouchJoy.OneButton[1].symb := ' ';
  TouchJoy.OneButton[2].symb := 'A';
  TouchJoy.OneButton[3].symb := 'B';
  TouchJoy.OneButton[4].symb := 'C';
  TouchJoy.OneButton[5].symb := 'D';

  MenuChange := TouchMenuGame2;
  SetMenuProcess(2);
end;

procedure CreateTouchKeyboard;
var
  dw, dh, x0, y0: Single;
  i: integer;
begin
  TouchKey.count := 34;                         
  if wndWidth < 1200 then
    dw := wndWidth
  else
    dw := 1200;
  if wndHeight < 500 then                       
    dh := (wndHeight / 2)
  else
    dh := 251;

  TouchKey.OWidth := ((dw - 5 - 36) / 13);  

  x0 := 2; 
  dw := 3 + TouchKey.OWidth;
  y0 := wndHeight - dh;
  dh := 3 + ((dh - 2 - 9) / 4);

  TouchKey.Height := dh - 3;                    

  if dw >= dh then                              
    TouchKey.textScale := round(dh * 0.5)
  else
    TouchKey.textScale := round(dw * 0.5);

  for i := 1 to 13 do
  begin
    TouchKey.OneButton[i].X := x0 + dw * (i - 1);
    TouchKey.OneButton[i].Y := y0;
  end;

  y0 := y0 + dh;
  TouchKey.StringButton[_Tab].X := x0;
  TouchKey.StringButton[_Tab].Y := y0;
  TouchKey.StringButton[_Tab].Width := (TouchKey.OWidth * 1.5) + 3; 
  TouchKey.StringButton[_Tab].bString := NameTab;
  TouchKey.StringButton[_Tab]._key := K_TAB;
  for i := 14 to 24 do
  begin
    TouchKey.OneButton[i].X := x0 + TouchKey.StringButton[35].Width + 3 + dw * (i - 14);
    TouchKey.OneButton[i].Y := y0;
  end;

  y0 := y0 + dh;
  TouchKey.StringButton[_CapsLock].X := x0;
  TouchKey.StringButton[_CapsLock].Y := y0;
  TouchKey.StringButton[_CapsLock].Width := TouchKey.OWidth * 2 + 3; 
  TouchKey.StringButton[_CapsLock].bString := NameCapsLock;
  TouchKey.StringButton[_CapsLock]._key := K_CAPSLOCK;
  for i := 25 to 33 do
  begin
    TouchKey.OneButton[i].X := x0 + TouchKey.StringButton[_CapsLock].Width + 3 + dw * (i - 25);
    TouchKey.OneButton[i].Y := y0;
  end;
  TouchKey.StringButton[_Enter].X := TouchKey.OneButton[33].X + dw;      
  TouchKey.StringButton[_Enter].Y := y0;                                 
  TouchKey.StringButton[_Enter].Width := TouchKey.OWidth * 2 + 3; 
  TouchKey.StringButton[_Enter].bString := NameEnter;
  TouchKey.StringButton[_Enter]._key := K_ENTER;

  y0 := y0 + dh;
  TouchKey.StringButton[_Shift].X := x0;
  TouchKey.StringButton[_Shift].Y := y0;
  TouchKey.StringButton[_Shift].Width := TouchKey.OWidth * 2 + 3; 
  TouchKey.StringButton[_Shift].bString := NameShift;
  TouchKey.StringButton[_Shift]._key := K_SHIFT;

  TouchKey.StringButton[_Space].X := x0 + TouchKey.StringButton[_Shift].Width + 3;
  TouchKey.StringButton[_Space].Y := y0;
  TouchKey.StringButton[_Space].Width := (TouchKey.OWidth * 2 + 3);          
  TouchKey.StringButton[_Space].bString := '';
  TouchKey.StringButton[_Space]._key := K_SPACE;

  TouchKey.StringButton[_Latin].X := TouchKey.StringButton[_Space].X + TouchKey.StringButton[_Space].Width + 3;
  TouchKey.StringButton[_Latin].Y := y0;
  TouchKey.StringButton[_Latin].Width := TouchKey.OWidth * 2 + 3; 
  TouchKey.StringButton[_Latin].bString := NameLatin;
  TouchKey.StringButton[_Latin]._key := K_F1;

  TouchKey.StringButton[_Rus].X := TouchKey.StringButton[_Space].X + TouchKey.StringButton[_Space].Width + 3;
  TouchKey.StringButton[_Rus].Y := y0;
  TouchKey.StringButton[_Rus].Width := TouchKey.OWidth * 2 + 3; 
  TouchKey.StringButton[_Rus].bString := NameRus;
  TouchKey.StringButton[_Rus]._key := K_F1;

  TouchKey.StringButton[_symb].X := TouchKey.StringButton[_Latin].X + TouchKey.StringButton[_Latin].Width + 3;
  TouchKey.StringButton[_symb].Y := y0;
  TouchKey.StringButton[_symb].Width := (TouchKey.OWidth * 3 + 6); 
  TouchKey.StringButton[_symb].bString := NameSymb;
  TouchKey.StringButton[_symb]._key := K_F2;
  TouchKey.OneButton[34].X := TouchKey.StringButton[_symb].X + TouchKey.StringButton[_symb].Width + 3;      
  TouchKey.OneButton[34].Y := y0;

  TouchKey.StringButton[_Insert].X := TouchKey.OneButton[34].X + TouchKey.OWidth + 3;
  TouchKey.StringButton[_Insert].Y := y0;
  TouchKey.StringButton[_Insert].Width := (TouchKey.OWidth * 1.5 + 3);  
  TouchKey.StringButton[_Insert].bString := NameInsert;
  TouchKey.StringButton[_Insert]._key := K_INSERT;

  TouchKey.StringButton[_Del].X := TouchKey.StringButton[_Insert].X + TouchKey.StringButton[_Insert].Width + 3;
  TouchKey.StringButton[_Del].Y := y0;
  TouchKey.StringButton[_Del].Width := (TouchKey.OWidth * 1.5); 
  TouchKey.StringButton[_Del].bString := NameBackSpace;
  TouchKey.StringButton[_Del]._key := K_BACKSPACE;

  TouchKey.OneButton[1].symb[1] := '~';
  TouchKey.OneButton[1].symb[2] := '`';
  TouchKey.OneButton[1].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ё');
  TouchKey.OneButton[1].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ё');
  TouchKey.OneButton[1]._key := K_TILDE;

  TouchKey.OneButton[2].symb[1] := 'Q';
  TouchKey.OneButton[2].symb[2] := 'q';
  TouchKey.OneButton[2].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Й');
  TouchKey.OneButton[2].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('й');
  TouchKey.OneButton[2]._key := K_Q;

  TouchKey.OneButton[3].symb[1] := 'W';
  TouchKey.OneButton[3].symb[2] := 'w';
  TouchKey.OneButton[3].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ц');
  TouchKey.OneButton[3].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ц');
  TouchKey.OneButton[3]._key := K_W;

  TouchKey.OneButton[4].symb[1] := 'E';
  TouchKey.OneButton[4].symb[2] := 'e';
  TouchKey.OneButton[4].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('У');
  TouchKey.OneButton[4].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('у');
  TouchKey.OneButton[4]._key := K_E;

  TouchKey.OneButton[5].symb[1] := 'R';
  TouchKey.OneButton[5].symb[2] := 'r';
  TouchKey.OneButton[5].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('К');
  TouchKey.OneButton[5].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('к');
  TouchKey.OneButton[5]._key := K_R;

  TouchKey.OneButton[6].symb[1] := 'T';
  TouchKey.OneButton[6].symb[2] := 't';
  TouchKey.OneButton[6].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Е');
  TouchKey.OneButton[6].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('е');
  TouchKey.OneButton[6]._key := K_T;

  TouchKey.OneButton[7].symb[1] := 'Y';
  TouchKey.OneButton[7].symb[2] := 'y';
  TouchKey.OneButton[7].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Н');
  TouchKey.OneButton[7].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('н');
  TouchKey.OneButton[7]._key := K_Y;

  TouchKey.OneButton[8].symb[1] := 'U';
  TouchKey.OneButton[8].symb[2] := 'u';
  TouchKey.OneButton[8].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Г');
  TouchKey.OneButton[8].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('г');
  TouchKey.OneButton[8]._key := K_U;

  TouchKey.OneButton[9].symb[1] := 'I';
  TouchKey.OneButton[9].symb[2] := 'i';
  TouchKey.OneButton[9].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ш');
  TouchKey.OneButton[9].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ш');
  TouchKey.OneButton[9]._key := K_I;

  TouchKey.OneButton[10].symb[1] := 'O';
  TouchKey.OneButton[10].symb[2] := 'o';
  TouchKey.OneButton[10].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Щ');
  TouchKey.OneButton[10].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('щ');
  TouchKey.OneButton[10]._key := K_O;

  TouchKey.OneButton[11].symb[1] := 'P';
  TouchKey.OneButton[11].symb[2] := 'p';
  TouchKey.OneButton[11].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('З');
  TouchKey.OneButton[11].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('з');
  TouchKey.OneButton[11]._key := K_P;

  TouchKey.OneButton[12].symb[1] := '{';
  TouchKey.OneButton[12].symb[2] := '[';
  TouchKey.OneButton[12].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Х');
  TouchKey.OneButton[12].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('х');
  TouchKey.OneButton[12]._key := K_BRACKET_L;

  TouchKey.OneButton[13].symb[1] := '}';
  TouchKey.OneButton[13].symb[2] := ']';
  TouchKey.OneButton[13].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ъ');
  TouchKey.OneButton[13].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ъ');
  TouchKey.OneButton[13]._key := K_BRACKET_R;

  TouchKey.OneButton[14].symb[1] := 'A';
  TouchKey.OneButton[14].symb[2] := 'a';
  TouchKey.OneButton[14].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ф');
  TouchKey.OneButton[14].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ф');
  TouchKey.OneButton[14]._key := K_A;

  TouchKey.OneButton[15].symb[1] := 'S';
  TouchKey.OneButton[15].symb[2] := 's';
  TouchKey.OneButton[15].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ы');
  TouchKey.OneButton[15].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ы');
  TouchKey.OneButton[15]._key := K_S;

  TouchKey.OneButton[16].symb[1] := 'D';
  TouchKey.OneButton[16].symb[2] := 'd';
  TouchKey.OneButton[16].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('В');
  TouchKey.OneButton[16].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('в');
  TouchKey.OneButton[16]._key := K_D;

  TouchKey.OneButton[17].symb[1] := 'F';
  TouchKey.OneButton[17].symb[2] := 'f';
  TouchKey.OneButton[17].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('А');
  TouchKey.OneButton[17].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('а');
  TouchKey.OneButton[17]._key := K_F;

  TouchKey.OneButton[18].symb[1] := 'G';
  TouchKey.OneButton[18].symb[2] := 'g';
  TouchKey.OneButton[18].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('П');
  TouchKey.OneButton[18].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('п');
  TouchKey.OneButton[18]._key := K_G;

  TouchKey.OneButton[19].symb[1] := 'H';
  TouchKey.OneButton[19].symb[2] := 'h';
  TouchKey.OneButton[19].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Р');
  TouchKey.OneButton[19].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('р');
  TouchKey.OneButton[19]._key := K_H;

  TouchKey.OneButton[20].symb[1] := 'J';
  TouchKey.OneButton[20].symb[2] := 'j';
  TouchKey.OneButton[20].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('О');
  TouchKey.OneButton[20].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('о');
  TouchKey.OneButton[20]._key := K_J;

  TouchKey.OneButton[21].symb[1] := 'K';
  TouchKey.OneButton[21].symb[2] := 'k';
  TouchKey.OneButton[21].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Л');
  TouchKey.OneButton[21].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('л');
  TouchKey.OneButton[21]._key := K_K;

  TouchKey.OneButton[22].symb[1] := 'L';
  TouchKey.OneButton[22].symb[2] := 'l';
  TouchKey.OneButton[22].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Д');
  TouchKey.OneButton[22].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('д');
  TouchKey.OneButton[22]._key := K_L;

  TouchKey.OneButton[23].symb[1] := ':';
  TouchKey.OneButton[23].symb[2] := ';';
  TouchKey.OneButton[23].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ж');
  TouchKey.OneButton[23].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ж');
  TouchKey.OneButton[23]._key := K_SEMICOLON;

  TouchKey.OneButton[24].symb[1] := '"';
  TouchKey.OneButton[24].symb[2] := chr($27);
  TouchKey.OneButton[24].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Э');
  TouchKey.OneButton[24].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('э');
  TouchKey.OneButton[24]._key := K_APOSTROPHE;

  TouchKey.OneButton[25].symb[1] := 'Z';
  TouchKey.OneButton[25].symb[2] := 'z';
  TouchKey.OneButton[25].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Я');
  TouchKey.OneButton[25].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('я');
  TouchKey.OneButton[25]._key := K_Z;

  TouchKey.OneButton[26].symb[1] := 'X';
  TouchKey.OneButton[26].symb[2] := 'x';
  TouchKey.OneButton[26].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ч');
  TouchKey.OneButton[26].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ч');
  TouchKey.OneButton[26]._key := K_X;

  TouchKey.OneButton[27].symb[1] := 'C';
  TouchKey.OneButton[27].symb[2] := 'c';
  TouchKey.OneButton[27].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('С');
  TouchKey.OneButton[27].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('с');
  TouchKey.OneButton[27]._key := K_C;

  TouchKey.OneButton[28].symb[1] := 'V';
  TouchKey.OneButton[28].symb[2] := 'v';
  TouchKey.OneButton[28].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('М');
  TouchKey.OneButton[28].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('м');
  TouchKey.OneButton[28]._key := K_V;

  TouchKey.OneButton[29].symb[1] := 'B';
  TouchKey.OneButton[29].symb[2] := 'b';
  TouchKey.OneButton[29].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('И');
  TouchKey.OneButton[29].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('и');
  TouchKey.OneButton[29]._key := K_B;

  TouchKey.OneButton[30].symb[1] := 'N';
  TouchKey.OneButton[30].symb[2] := 'n';
  TouchKey.OneButton[30].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Т');
  TouchKey.OneButton[30].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('т');
  TouchKey.OneButton[30]._key := K_N;

  TouchKey.OneButton[31].symb[1] := 'M';
  TouchKey.OneButton[31].symb[2] := 'm';
  TouchKey.OneButton[31].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ь');
  TouchKey.OneButton[31].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ь');
  TouchKey.OneButton[31]._key := K_M;

  TouchKey.OneButton[32].symb[1] := '<';
  TouchKey.OneButton[32].symb[2] := ',';
  TouchKey.OneButton[32].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Б');
  TouchKey.OneButton[32].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('б');
  TouchKey.OneButton[32]._key := K_SEPARATOR;

  TouchKey.OneButton[33].symb[1] := '>';
  TouchKey.OneButton[33].symb[2] := '.';
  TouchKey.OneButton[33].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}('Ю');
  TouchKey.OneButton[33].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('ю');
  TouchKey.OneButton[33]._key := K_DECIMAL;

  TouchKey.OneButton[34].symb[1] := '?';
  TouchKey.OneButton[34].symb[2] := '/';
  TouchKey.OneButton[34].symb[3] := {$IfDef Delphi} AscToUtf8{$EndIf}(',');
  TouchKey.OneButton[34].symb[4] := {$IfDef Delphi} AscToUtf8{$EndIf}('.');
  TouchKey.OneButton[34]._key := K_SLASH;

  TouchKey.Flags := 0;

  MenuChange := 3;
  SetMenuProcess(3);
  CreateTouchSymbol;
end;

procedure CreateTouchSymbol;
var
  dw, dh, x0, y0: Single;
  i: integer;
begin
  TouchKeySymb.count := 23;                         
  if wndWidth < 1200 then
    dw := wndWidth
  else
    dw := 1200;
  if wndHeight < 500 then                       
    dh := round(wndHeight / 2)
  else
    dh := 251;

  TouchKeySymb.OWidth := round((dw - 4 - 36) / 11);  

  x0 := 2; 
  dw := 3 + TouchKeySymb.OWidth;
  y0 := wndHeight - dh;
  dh := 3 + round((dh - 2 - 9) / 4);

  TouchKeySymb.Height := dh - 3;                    

  if dw >= dh then                              
    TouchKeySymb.textScale := round(dh * 0.5)
  else
    TouchKeySymb.textScale := round(dw * 0.5);

  for i := 1 to 10 do
  begin
    TouchKeySymb.OneDoubleButton[i].X := x0 + dw * (i - 1);
    TouchKeySymb.OneDoubleButton[i].Y := y0;
  end;
  TouchKeySymb.OneDoubleButton[1]._key := K_1;
  TouchKeySymb.OneDoubleButton[2]._key := K_2;
  TouchKeySymb.OneDoubleButton[3]._key := K_3;
  TouchKeySymb.OneDoubleButton[4]._key := K_4;
  TouchKeySymb.OneDoubleButton[5]._key := K_5;
  TouchKeySymb.OneDoubleButton[6]._key := K_6;
  TouchKeySymb.OneDoubleButton[7]._key := K_7;
  TouchKeySymb.OneDoubleButton[8]._key := K_8;
  TouchKeySymb.OneDoubleButton[9]._key := K_9;
  TouchKeySymb.OneDoubleButton[10]._key := K_0;

  TouchKeySymb.OneDoubleButton[1].symb[1] := '1';
  TouchKeySymb.OneDoubleButton[2].symb[1] := '2';
  TouchKeySymb.OneDoubleButton[3].symb[1] := '3';
  TouchKeySymb.OneDoubleButton[4].symb[1] := '4';
  TouchKeySymb.OneDoubleButton[5].symb[1] := '5';
  TouchKeySymb.OneDoubleButton[6].symb[1] := '6';
  TouchKeySymb.OneDoubleButton[7].symb[1] := '7';
  TouchKeySymb.OneDoubleButton[8].symb[1] := '8';
  TouchKeySymb.OneDoubleButton[9].symb[1] := '9';
  TouchKeySymb.OneDoubleButton[10].symb[1] := '0';
  TouchKeySymb.OneDoubleButton[1].symb[2] := '!';
  TouchKeySymb.OneDoubleButton[2].symb[2] := '@';
  TouchKeySymb.OneDoubleButton[3].symb[2] := '#';
  TouchKeySymb.OneDoubleButton[4].symb[2] := '$';
  TouchKeySymb.OneDoubleButton[5].symb[2] := '%'; 
  TouchKeySymb.OneDoubleButton[6].symb[2] := '^';
  TouchKeySymb.OneDoubleButton[7].symb[2] := '&';
  TouchKeySymb.OneDoubleButton[8].symb[2] := '*';
  TouchKeySymb.OneDoubleButton[9].symb[2] := '(';
  TouchKeySymb.OneDoubleButton[10].symb[2] := ')';

  TouchKeySymb.StringButton[_Home].X := TouchKeySymb.OneDoubleButton[10].X + TouchKeySymb.OWidth + 3;
  TouchKeySymb.StringButton[_Home].Y := y0;
  TouchKeySymb.StringButton[_Home].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Home].bString := NameHome;
  TouchKeySymb.StringButton[_Home]._key := K_HOME;

  y0 := y0 + dh;
  for i := 11 to 20 do
  begin
    TouchKeySymb.OneDoubleButton[i].X := x0 + dw * (i - 11);
    TouchKeySymb.OneDoubleButton[i].Y := y0;
  end;
  TouchKeySymb.OneDoubleButton[11]._key := K_TILDE;
  TouchKeySymb.OneDoubleButton[12]._key := K_SEPARATOR;
  TouchKeySymb.OneDoubleButton[13]._key := K_DECIMAL;
  TouchKeySymb.OneDoubleButton[14]._key := K_SEMICOLON;
  TouchKeySymb.OneDoubleButton[15]._key := K_APOSTROPHE;
  TouchKeySymb.OneDoubleButton[16]._key := K_BRACKET_L;
  TouchKeySymb.OneDoubleButton[17]._key := K_BRACKET_R;
  TouchKeySymb.OneDoubleButton[18]._key := K_MINUS;
  TouchKeySymb.OneDoubleButton[19]._key := K_EQUALS;
  TouchKeySymb.OneDoubleButton[20]._key := K_BACKSLASH;

  TouchKeySymb.OneDoubleButton[11].symb[1] := '`';
  TouchKeySymb.OneDoubleButton[12].symb[1] := ',';
  TouchKeySymb.OneDoubleButton[13].symb[1] := '.';
  TouchKeySymb.OneDoubleButton[14].symb[1] := ';';
  TouchKeySymb.OneDoubleButton[15].symb[1] := chr($27);         
  TouchKeySymb.OneDoubleButton[16].symb[1] := '[';
  TouchKeySymb.OneDoubleButton[17].symb[1] := ']';
  TouchKeySymb.OneDoubleButton[18].symb[1] := '-';
  TouchKeySymb.OneDoubleButton[19].symb[1] := '=';
  TouchKeySymb.OneDoubleButton[20].symb[1] := '/';              
  TouchKeySymb.OneDoubleButton[11].symb[2] := '~';
  TouchKeySymb.OneDoubleButton[12].symb[2] := '<';
  TouchKeySymb.OneDoubleButton[13].symb[2] := '>';
  TouchKeySymb.OneDoubleButton[14].symb[2] := ':';
  TouchKeySymb.OneDoubleButton[15].symb[2] := '"';
  TouchKeySymb.OneDoubleButton[16].symb[2] := '{';
  TouchKeySymb.OneDoubleButton[17].symb[2] := '}';
  TouchKeySymb.OneDoubleButton[18].symb[2] := '_';
  TouchKeySymb.OneDoubleButton[19].symb[2] := '+';
  TouchKeySymb.OneDoubleButton[20].symb[2] := '\';

  TouchKeySymb.StringButton[_End].X := TouchKeySymb.OneDoubleButton[20].X + TouchKeySymb.OWidth + 3;
  TouchKeySymb.StringButton[_End].Y := y0;
  TouchKeySymb.StringButton[_End].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_End].bString := NameEnd;
  TouchKeySymb.StringButton[_End]._key := K_END;

  TouchKeySymb.TextureDown := 3;
  TouchKeySymb.TextureUp := 3;

  y0 := y0 + dh;
  TouchKeySymb.StringButton[_Ctrl].X := x0;
  TouchKeySymb.StringButton[_Ctrl].Y := y0;
  TouchKeySymb.StringButton[_Ctrl].Width := TouchKeySymb.OWidth * 2 + 3;
  TouchKeySymb.StringButton[_Ctrl].bString := NameCtrl;
  TouchKeySymb.StringButton[_Ctrl]._key := K_CTRL;

  for i := 21 to 23 do
  begin
    TouchKeySymb.OneDoubleButton[i].X := x0 + TouchKeySymb.StringButton[_Ctrl].Width + 3 + dw * (i - 21);
    TouchKeySymb.OneDoubleButton[i].Y := y0;
  end;
  TouchKeySymb.OneDoubleButton[21].symb[1] := {$IfDef Delphi} AscToUtf8{$EndIf} ('№');
  TouchKeySymb.OneDoubleButton[21].symb[2] := TouchKeySymb.OneDoubleButton[21].symb[1];
  TouchKeySymb.OneDoubleButton[21]._key := K_KP_3;
  TouchKeySymb.OneDoubleButton[22].symb[1] := '?';
  TouchKeySymb.OneDoubleButton[22].symb[2] := '?';
  TouchKeySymb.OneDoubleButton[22]._key := K_KP_2;
  TouchKeySymb.OneDoubleButton[23].symb[1] := '|';
  TouchKeySymb.OneDoubleButton[23].symb[2] := '|';
  TouchKeySymb.OneDoubleButton[23]._key := K_KP_1;

  TouchKeySymb.BArrow[_Up].X := TouchKeySymb.OneDoubleButton[23].X + 3 * TouchKeySymb.OWidth + 9;
  TouchKeySymb.BArrow[_Up].Y := y0;
  TouchKeySymb.BArrow[_Up].Angle := 0;
  TouchKeySymb.BArrow[_Up]._key := K_UP;

  TouchKeySymb.StringButton[_Enter].X := TouchKeySymb.BArrow[_Up].X + 6 + TouchKeySymb.OWidth * 2;
  TouchKeySymb.StringButton[_Enter].Y := y0;
  TouchKeySymb.StringButton[_Enter].Width := TouchKeySymb.StringButton[_Ctrl].Width;
  TouchKeySymb.StringButton[_Enter].bString := NameEnter;
  TouchKeySymb.StringButton[_Enter]._key := K_ENTER;

  y0 := y0 + dh;
  TouchKeySymb.StringButton[_Shift].X := x0;
  TouchKeySymb.StringButton[_Shift].Y := y0;
  TouchKeySymb.StringButton[_Shift].Width := TouchKeySymb.StringButton[_Ctrl].Width;
  TouchKeySymb.StringButton[_Shift].bString := NameShift;
  TouchKeySymb.StringButton[_Shift]._key := K_SHIFT;

  TouchKeySymb.StringButton[_Space].X := TouchKeySymb.StringButton[_Shift].X + TouchKeySymb.StringButton[_Shift].Width + 3;
  TouchKeySymb.StringButton[_Space].Y := y0;
  TouchKeySymb.StringButton[_Space].Width := TouchKeySymb.StringButton[_Shift].Width;
  TouchKeySymb.StringButton[_Space].bString := ' ';
  TouchKeySymb.StringButton[_Space]._key := K_SPACE;

  TouchKeySymb.StringButton[_Keyboard].X := TouchKeySymb.StringButton[_Space].X + TouchKeySymb.StringButton[_Space].Width + 3;
  TouchKeySymb.StringButton[_Keyboard].Y := y0;
  TouchKeySymb.StringButton[_Keyboard].Width := TouchKeySymb.StringButton[_Space].Width;
  TouchKeySymb.StringButton[_Keyboard].bString := NameKeyboard;
  TouchKeySymb.StringButton[_Keyboard]._key := K_F2;

  TouchKeySymb.BArrow[_Left].X := TouchKeySymb.StringButton[_Keyboard].X + 3 + TouchKeySymb.StringButton[_Keyboard].Width;
  TouchKeySymb.BArrow[_Left].Y := y0;
  TouchKeySymb.BArrow[_Left].Angle := 270;
  TouchKeySymb.BArrow[_Left]._key := K_LEFT;

  TouchKeySymb.BArrow[_Down].X := TouchKeySymb.BArrow[_Left].X + 3 + TouchKeySymb.OWidth;
  TouchKeySymb.BArrow[_Down].Y := y0;
  TouchKeySymb.BArrow[_Down].Angle := 180;
  TouchKeySymb.BArrow[_Down]._key := K_DOWN;

  TouchKeySymb.BArrow[_Right].X := TouchKeySymb.BArrow[_Down].X + 3 + TouchKeySymb.OWidth;
  TouchKeySymb.BArrow[_Right].Y := y0;
  TouchKeySymb.BArrow[_Right].Angle := 90;
  TouchKeySymb.BArrow[_Right]._key := K_RIGHT;

  TouchKeySymb.StringButton[_Insert].X := TouchKeySymb.BArrow[_Down].X + 6 + TouchKeySymb.OWidth * 2;
  TouchKeySymb.StringButton[_Insert].Y := y0;
  TouchKeySymb.StringButton[_Insert].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Insert].bString := NameInsert;
  TouchKeySymb.StringButton[_Insert]._key := K_INSERT;

  TouchKeySymb.StringButton[_Del].X := TouchKeySymb.StringButton[_Insert].X + 3 + TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Del].Y := y0;
  TouchKeySymb.StringButton[_Del].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Del].bString := NameBackSpace;
  TouchKeySymb.StringButton[_Del]._key := K_BACKSPACE;
end;

procedure UseGameJoy01Down;
var
  i: Integer;
begin
  if ((Sqr(mouseX - TouchJoyRolling.Rolling.X) + Sqr(mouseY - TouchJoyRolling.Rolling.Y)) <= Sqr(TouchJoyRolling.Rolling.R)) then
  begin
    TouchJoyRolling.Rolling._x := mouseX;
    TouchJoyRolling.Rolling._y := mouseY;
    TouchJoyRolling.Rolling.bPush := 1;
    TouchJoyRolling.Rolling.direction := m_Angle(TouchJoyRolling.Rolling.X, TouchJoyRolling.Rolling.Y, TouchJoyRolling.Rolling._x, TouchJoyRolling.Rolling._y);
    exit;                       
  end
  else
    TouchJoyRolling.Rolling.bPush := 0;

  for i := 1 to TouchJoyRolling.count do
  begin
    if ((mouseX > TouchJoyRolling.OneButton[i].X) and (mouseX < (TouchJoyRolling.OneButton[i].X + TouchJoyRolling.Width)) and
        (mouseY > TouchJoyRolling.OneButton[i].Y) and (mouseY < (TouchJoyRolling.OneButton[i].Y + TouchJoyRolling.Height))) then
    begin
      TouchJoyRolling.OneButton[i].bPush := 1;
      keysDown[TouchJoyRolling.OneButton[i]._key] := True;
      exit;
    end
    else begin
      keysDown[TouchJoyRolling.OneButton[i]._key] := False;
      TouchJoyRolling.OneButton[i].bPush := 0;
    end;
  end;
end;

procedure UseGameJoy02Down;
var
  i: Integer;
begin
  for i := 1 to 9 do
    if i <> 5 then
    begin
      if ((mouseX > TouchJoy.BArrow[i].X) and (mouseX < (TouchJoy.BArrow[i].X + TouchJoy.Width)) and
            (mouseY > TouchJoy.BArrow[i].Y) and (mouseY < (TouchJoy.BArrow[i].Y + TouchJoy.Height))) then
      begin
        TouchJoy.BArrow[i].bPush := 1;
        keysDown[TouchJoy.BArrow[i]._key] := true;
      end
      else begin
        TouchJoy.BArrow[i].bPush := 0;
        keysDown[TouchJoy.BArrow[i]._key] := false;
      end;
    end;
  for i := 1 to TouchJoy.count do
  begin
    if ((mouseX > TouchJoy.OneButton[i].X) and (mouseX < (TouchJoy.OneButton[i].X + TouchJoy.Width)) and
          (mouseY > TouchJoy.OneButton[i].Y) and (mouseY < (TouchJoy.OneButton[i].Y + TouchJoy.Height))) then
    begin
      TouchJoy.OneButton[i].bPush := 1;                                   
      keysDown[TouchJoy.OneButton[i]._key] := True;                
    end
    else begin
      keysDown[TouchJoy.OneButton[i]._key] := False;
      TouchJoy.OneButton[i].bPush := 0;
    end;
  end;
end;

procedure UseTouchKeyboardDown;
var
  i: Integer;
begin
  if (TouchKey.bPush and 1 > 0) then
    exit;
  TouchKey.bPush := 1;
  for i := 35 to 45 do
  begin
    if ((mouseX > TouchKey.StringButton[i].X) and (mouseX < (TouchKey.StringButton[i].X + TouchKey.StringButton[i].Width)) and
          (mouseY > TouchKey.StringButton[i].Y) and (mouseY < (TouchKey.StringButton[i].Y + TouchKey.Height))) then
    begin
      TouchKey._keyPush := i;                 
      if (i = _Rus) then
        Continue;                            
      TouchKeyDown(TouchKey.StringButton[i]._key);
      exit;
    end;
  end;

  for i := 1 to TouchKey.count do
  begin
    if ((mouseX > TouchKey.OneButton[i].X) and (mouseX < (TouchKey.OneButton[i].X + TouchKey.OWidth)) and
          (mouseY > TouchKey.OneButton[i].Y) and (mouseY < (TouchKey.OneButton[i].Y + TouchKey.Height))) then
    begin
      TouchKey._keyPush := i;                   
      TouchKeyDown(TouchKey.OneButton[i]._key); 
      exit;
    end;
  end;
  TouchKey.bPush := 0;                      
end;

procedure UseTouchSymbolDown;
var
  i: Integer;
begin
  TouchKeySymb.bPush := 1;
  for i := 1 to TouchKeySymb.count do
  begin
    if ((mouseX > TouchKeySymb.OneDoubleButton[i].X) and (mouseX < (TouchKeySymb.OneDoubleButton[i].X + TouchKeySymb.OWidth)) and
          (mouseY > TouchKeySymb.OneDoubleButton[i].Y) and (mouseY < (TouchKeySymb.OneDoubleButton[i].Y + TouchKeySymb.Height))) then
    begin
      TouchKeySymb._keyPush := i;
      TouchKeyDown(TouchKeySymb.OneDoubleButton[i]._key);
      exit;
    end;
  end;
  for i := 24 to 27 do
  begin
    if ((mouseX > TouchKeySymb.BArrow[i].X) and (mouseX < (TouchKeySymb.BArrow[i].X + TouchKeySymb.OWidth)) and
          (mouseY > TouchKeySymb.BArrow[i].Y) and (mouseY < (TouchKeySymb.BArrow[i].Y + TouchKeySymb.Height))) then
    begin
      TouchKeySymb._keyPush := i;
      TouchKeyDown(TouchKeySymb.BArrow[i]._key);
      exit;
    end;
  end;
  for i := 36 to 44 do
  Begin
    if ((mouseX > TouchKeySymb.StringButton[i].X) and (mouseX < (TouchKeySymb.StringButton[i].X + TouchKeySymb.StringButton[i].Width)) and
          (mouseY > TouchKeySymb.StringButton[i].Y) and (mouseY < (TouchKeySymb.StringButton[i].Y + TouchKeySymb.Height))) then
    begin
      TouchKeySymb._keyPush := i;
      TouchKeyDown(TouchKeySymb.StringButton[i]._key);
      exit;
    end;
  end;
  TouchKeySymb.bPush := 0;
end;

procedure UseGameJoy01Up;
var
  i: Integer;
begin
  TouchJoyRolling.Rolling.bPush := 0;
  for i := 1 to TouchJoyRolling.count do
  begin
    TouchJoyRolling.OneButton[i].bPush := 0;
    TouchKeyUp(TouchJoyRolling.OneButton[i]._key);
  end;
end;

procedure UseGameJoy02Up;
var
  i: Integer;
begin
  for i := 1 to 9 do
    if i <> 5 then
    begin
      TouchJoy.BArrow[i].bPush := 0;
      TouchKeyUp(TouchJoy.BArrow[i]._key);
    end;
  for i := 1 to TouchJoy.count do
  begin
    TouchJoy.OneButton[i].bPush := 0;
    TouchKeyUp(TouchJoy.OneButton[i]._key);
  end;
end;

procedure UseTouchKeyboardUp;
begin
  if (TouchKey.bPush and 1) > 0 then
  begin
  if TouchKey._keyPush < 35 then
    TouchKeyUp(TouchKey.OneButton[TouchKey._keyPush]._key)
  else begin
    TouchKeyUp(TouchKey.StringButton[TouchKey._keyPush]._key);
  end;
  end else
  begin
    TouchKeyUp(K_SHIFT);
  end;
  TouchKey.bPush := 0;
end;

procedure UseTouchSymbolUp;
begin
  if (TouchKeySymb.bPush and 1) > 0 then
  begin
    if TouchKeySymb._keyPush < 24 then
      TouchKeyUp(TouchKeySymb.OneDoubleButton[TouchKeySymb._keyPush]._key)
    else
      if TouchKeySymb._keyPush < 34 then
        TouchKeyUp(TouchKeySymb.BArrow[TouchKeySymb._keyPush]._key)
      else begin
        TouchKeyUp(TouchKeySymb.StringButton[TouchKeySymb._keyPush]._key);
      end;
  end else
  begin
    TouchKeyUp(K_SHIFT);
  end;
  TouchKeySymb.bPush := 0;
end;

end.
