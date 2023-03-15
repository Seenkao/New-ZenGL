{
 *  Copyright (c) 2021 SSW
 *
 *  This software is provided 'as-is', without any express or
 *  implied warranty. In no event will the authors be held
 *  liable for any damages arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute
 *  it freely, subject to the following restrictions:
 *
 *  1. The origin of this software must not be misrepresented;
 *     you must not claim that you wrote the original software.
 *     If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but
 *     is not required.
 *
 *  2. Altered source versions must be plainly marked as such,
 *     and must not be misrepresented as being the original software.
 *
 *  3. This notice may not be removed or altered from any
 *     source distribution.
}

(* Обратить внимание! Если будет использоваться тачскрин, то могут происходить множественные нажатия,
   а это означает, что по процедурам надо проходиться несколько раз, и это не будет зависеть от
   возможностей??? Будет ли возможность записать все данные тачскрина, лишь бы не делать 10 проходов для
   каждого нажатия???
*)

unit gegl_menu_gui;

{$I zgl_config.cfg}

interface

const
  NameShift: UTF8String = 'Shift';
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

  GuiJoystick1 = 1;
  GuiJoystick2 = 2;
  GuiKeyboardSymb = 4;
  GuiKeyboardNumeric = 8;

  // данные только для подобных клавиатур!!! Для создания своей клавиатуры, вы должны задавать свои данные!
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
  // кнопка от текстуры
  _touchButton = record
    X, Y, Angle: Single;
    bPush: LongWord;
    _key: LongWord;
  end;

  // обычная кнопка от символа
  _oneTouchButtonJoy = record   
    X, Y: Single;
    _key: LongWord;
    symb: UTF8String;           // использовать юникод везде????
    bPush: LongWord;                // в джойстиках это отвечает за каждую клавишу в отдельности
  end;

  // "ролик" для использования в джойстике
  _touchRolling = record
    X, Y, R, _x, _y: Single;    
    direction: Single;          
    bPush: LongWord;
  end;

  // джойстик с одними кнопками
  _keyTouchJoy = record
    textScale: LongWord;
    count: LongWord;
    Width, Height: Single;
    BArrow: array[1..9] of _touchButton;
    OneButton: array[1..8] of _oneTouchButtonJoy;
    TextureUp, TextureDown: Cardinal;               // текстура используемая для стрелок
  end;

  // джойстик с кнопками и роликом
  _keyTouchJoyRolling = record
    textScale: LongWord;
    count: LongWord;
    Width, Height: Single;
    Rolling: _touchRolling;
    OneButton: array[1..8] of _oneTouchButtonJoy;
  end;

  // для четырёх разных символов (основное)
  _oneTouchButton = record
    X, Y: Single;
    _key: LongWord;
    symb: array [1..4] of LongWord;
  end;

  // для двух разных символов
  _oneDoubleTouchButton = record
    X, Y: Single;
    _key: LongWord;
    symb: array [1..2] of UTF8String;             // подменить
  end;

  _stringTouchButton = record
    X, Y: Single ;
    Width: Single;
    _key: LongWord;
    bString: UTF8String;        
  end;

  // для обычной клавиатуры
  _keyTouch = record            
    textScale: LongWord;
    count: LongWord;
    OWidth, Height: Single;       
    OneButton: array[1..34] of _oneTouchButton;
    StringButton: array[35..44] of _stringTouchButton;
  end;

  _touchBArrow = record
    X, Y, Angle: Single;
    _key: LongWord;
  end;

  // для символьной клавиатуры
  _keyTouchSymb = record
    textScale: LongWord;
    count: LongWord;
    OWidth, Height: Single;     
    OneDoubleButton: array[1..23] of _oneDoubleTouchButton;   // обычные клавиши
    BArrow: array[24..27] of _touchBArrow;                    // стрелки (управляющие клавиши)
    StringButton: array[36..44] of _stringTouchButton;        // литеральные клавиши (в основном управляющие)
    TextureUp, TextureDown: Cardinal;                         // текстура используемая для стрелок
  end;

var
  TouchJoy: _keyTouchJoy;                             
  TouchJoyRolling: _keyTouchJoyRolling;
  TouchKey: _keyTouch;                                
  TouchKeySymb: _keyTouchSymb;
  _wndWidth, _wndHeight: Single;

procedure SetMenuProcess(NumMenu: Byte);

// ни где не создаются ни джойстики, ни клавиатура!!!
// на данный момент создаю в 3-й демке для android.

// джойстик с роликом
procedure CreateGameJoy01;
// джойстик только с клавишами
procedure CreateGameJoy02;
// создание клавиатуры
procedure CreateTouchKeyboard;
procedure CreateTouchSymbol;

procedure GameJoy01Up(num: LongWord);
procedure GameJoy02Up(num: LongWord);
procedure TouchKeyboardUp(num: LongWord);
procedure TouchSymbolUp(num: LongWord);

procedure GameJoy01Down(num: LongWord);
procedure GameJoy02Down(num: LongWord);
procedure TouchKeyboardDown(num: LongWord);
procedure TouchSymbolDown(num: LongWord);

procedure ShowVKeyboard; {$IfDef USE_INLINE}inline;{$EndIf}
procedure HideVKeyboard; {$IfDef USE_INLINE}inline;{$EndIf}

implementation

uses
  gegl_utils,
  zgl_window,
  zgl_keyboard,
  zgl_math_2d,
  zgl_application,
  gegl_draw_gui,
  zgl_text,
  zgl_utils,
  zgl_log,
  zgl_file,
  zgl_types,
  zgl_mouse,
  zgl_touch;

{$IfDef LINUX}
var
  rs0:    Single = 0;
  rs045:  Single = 0.45;
  rs1_5:  Single = 1.5;
  rs2:    Single = 2;
  rs3:    Single = 3;
  rs4:    Single = 4;
  rs5:    Single = 5;
  rs6:    Single = 6;
  rs9:    Single = 9;
  rs11:   Single = 11;
  rs13:   Single = 13;
  rs40:   Single = 40;
  rs41:   Single = 41;
  rs45:   Single = 45;
  rs50:   Single = 50;
  rs55:   Single = 55;
  rs90:   Single = 90;
  rs100:  Single = 100;
  rs135:  Single = 135;
  rs150:  Single = 150;
  rs180:  Single = 180;
  rs225:  Single = 225;
  rs251:  Single = 251;
  rs270:  Single = 270;
  rs315:  Single = 315;
  rs1200: Single = 1200;
{$EndIf}
  {$IfDef MOBILE}
var
  lockTouchKeyboard: Boolean = False;
  {$EndIf}

// определиться как работать с фонтом. Должна быть загрузка "как бы" по умолчанию
// но делать приходится вручную.
procedure SetMenuProcess(NumMenu: Byte);
begin
  if (NumMenu = 0) or (NumMenu > MaxNumMenu) then exit;
  if NumMenu = 1 then
  begin
    app_UseMenuDown := @GameJoy01Down;
    app_UseMenuUp := @GameJoy01Up;
    app_DrawGui := @DrawGameJoy01;
    setFontTextScale(22, fontUse);
//    setTextColor(MenuColorText);
  end;
  if NumMenu = 2 then
  begin
    app_UseMenuDown := @GameJoy02Down;
    app_UseMenuUp := @GameJoy02Up;
    app_DrawGui := @DrawGameJoy02;
    setFontTextScale(22, fontUse);
//    setTextColor(MenuColorText);
  end;
  if NumMenu = 3 then
  begin
    app_UseMenuDown := @TouchKeyboardDown;
    app_UseMenuUp := @TouchKeyboardUp;
    app_DrawGui := @DrawTouchKeyboard;
    setFontTextScale(TouchKey.textScale, fontUse);
//    setTextColor(MenuColorText);
  end;
  if NumMenu = 4 then
  begin
    app_UseMenuDown := @TouchSymbolDown;
    app_UseMenuUp := @TouchSymbolUp;
    app_DrawGui := @DrawTouchSymbol;
    setFontTextScale(TouchKeySymb.textScale, fontUse);
//    setTextColor(MenuColorText);
  end;
end;

procedure CreateGameJoy01;
begin
  _wndWidth := wndWidth;
  _wndHeight := wndHeight;
  TouchJoyRolling.count := 4;               
  TouchJoyRolling.textScale := 22;          
  TouchJoyRolling.Rolling.X := {$IfDef LINUX}rs55{$Else}55{$EndIf};
  TouchJoyRolling.Rolling.Y := _wndHeight - {$IfDef LINUX}rs55{$Else}55{$EndIf};
  TouchJoyRolling.Rolling.R := {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoyRolling.Rolling.bPush := 0;       

  TouchJoyRolling.Width := {$IfDef LINUX}rs45{$Else}45{$EndIf};
  TouchJoyRolling.Height := {$IfDef LINUX}rs45{$Else}45{$EndIf};

  TouchJoyRolling.OneButton[1].X := _wndWidth - {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoyRolling.OneButton[1].Y := _wndHeight - {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoyRolling.OneButton[1].bPush := 0;
  TouchJoyRolling.OneButton[2].X := TouchJoyRolling.OneButton[1].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoyRolling.OneButton[2].Y := TouchJoyRolling.OneButton[1].Y;
  TouchJoyRolling.OneButton[2].bPush := 0;
  TouchJoyRolling.OneButton[3].X := TouchJoyRolling.OneButton[1].X;
  TouchJoyRolling.OneButton[3].Y := TouchJoyRolling.OneButton[1].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoyRolling.OneButton[3].bPush := 0;
  TouchJoyRolling.OneButton[4].X := TouchJoyRolling.OneButton[1].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoyRolling.OneButton[4].Y := TouchJoyRolling.OneButton[1].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoyRolling.OneButton[4].bPush := 0;
  TouchJoyRolling.OneButton[1]._key := K_A;
  TouchJoyRolling.OneButton[2]._key := K_B;
  TouchJoyRolling.OneButton[3]._key := K_C;
  TouchJoyRolling.OneButton[4]._key := K_D;

  TouchJoyRolling.OneButton[1].symb := 'A';               
  TouchJoyRolling.OneButton[2].symb := 'B';
  TouchJoyRolling.OneButton[3].symb := 'C';
  TouchJoyRolling.OneButton[4].symb := 'D';

  MenuChange := GuiJoystick1;
  SetMenuProcess(1);
end;

procedure CreateGameJoy02;
begin
  _wndWidth := wndWidth;
  _wndHeight := wndHeight;
  TouchJoy.count := 5;
  TouchJoy.textScale := 22;
  TouchJoy.Width := {$IfDef LINUX}rs45{$Else}45{$EndIf};
  TouchJoy.Height := {$IfDef LINUX}rs45{$Else}45{$EndIf};

  TouchJoy.BArrow[7].X := {$IfDef LINUX}rs5{$Else}5{$EndIf};
  TouchJoy.BArrow[7].Y := _wndHeight - {$IfDef LINUX}rs150{$Else}150{$EndIf};
  TouchJoy.BArrow[7].Angle := {$IfDef LINUX}rs315{$Else}315{$EndIf};
  TouchJoy.BArrow[7].bPush := 0;

  TouchJoy.BArrow[8].X := TouchJoy.BArrow[7].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.BArrow[8].Y := TouchJoy.BArrow[7].Y;
  TouchJoy.BArrow[8].Angle := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  TouchJoy.BArrow[8].bPush := 0;

  TouchJoy.BArrow[9].X := TouchJoy.BArrow[7].X + {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.BArrow[9].Y := TouchJoy.BArrow[7].Y;
  TouchJoy.BArrow[9].Angle := {$IfDef LINUX}rs45{$Else}45{$EndIf};
  TouchJoy.BArrow[9].bPush := 0;

  TouchJoy.BArrow[4].X := TouchJoy.BArrow[7].X;
  TouchJoy.BArrow[4].Y := TouchJoy.BArrow[7].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.BArrow[4].Angle := {$IfDef LINUX}rs270{$Else}270{$EndIf};
  TouchJoy.BArrow[4].bPush := 0;

  TouchJoy.OneButton[1].X := TouchJoy.BArrow[7].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.OneButton[1].Y := TouchJoy.BArrow[7].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.OneButton[1].bPush := 0;
  TouchJoy.BArrow[6].X := TouchJoy.BArrow[7].X + {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.BArrow[6].Y := TouchJoy.BArrow[7].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.BArrow[6].Angle := {$IfDef LINUX}rs90{$Else}90{$EndIf};
  TouchJoy.BArrow[6].bPush := 0;

  TouchJoy.BArrow[1].X := TouchJoy.BArrow[7].X;
  TouchJoy.BArrow[1].Y := TouchJoy.BArrow[7].Y + {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.BArrow[1].Angle := {$IfDef LINUX}rs225{$Else}225{$EndIf};
  TouchJoy.BArrow[1].bPush := 0;

  TouchJoy.BArrow[2].X := TouchJoy.BArrow[7].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.BArrow[2].Y := TouchJoy.BArrow[7].Y + {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.BArrow[2].Angle := {$IfDef LINUX}rs180{$Else}180{$EndIf};
  TouchJoy.BArrow[2].bPush := 0;

  TouchJoy.BArrow[3].X := TouchJoy.BArrow[7].X + {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.BArrow[3].Y := TouchJoy.BArrow[7].Y + {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.BArrow[3].Angle := {$IfDef LINUX}rs135{$Else}135{$EndIf};
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

  TouchJoy.OneButton[2].X := _wndWidth - {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.OneButton[2].Y := _wndHeight - {$IfDef LINUX}rs100{$Else}100{$EndIf};
  TouchJoy.OneButton[2].bPush := 0;
  TouchJoy.OneButton[3].X := TouchJoy.OneButton[2].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.OneButton[3].Y := TouchJoy.OneButton[2].Y;
  TouchJoy.OneButton[3].bPush := 0;
  TouchJoy.OneButton[4].X := TouchJoy.OneButton[2].X;
  TouchJoy.OneButton[4].Y := TouchJoy.OneButton[2].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.OneButton[4].bPush := 0;
  TouchJoy.OneButton[5].X := TouchJoy.OneButton[2].X + {$IfDef LINUX}rs50{$Else}50{$EndIf};
  TouchJoy.OneButton[5].Y := TouchJoy.OneButton[2].Y + {$IfDef LINUX}rs50{$Else}50{$EndIf};
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

  MenuChange := GuiJoystick2;
  SetMenuProcess(2);
end;

procedure CreateTouchKeyboard;
var
  dw, dh, x0, y0, _xx0: Single;
  i, n: integer;
  m: Integer;

  kodeSymb: array[1..34] of byte = (K_TILDE, K_Q, K_W, K_E, K_R, K_T, K_Y, K_U, K_I, K_O, K_P, K_BRACKET_L, K_BRACKET_R, K_A,
                                        K_S, K_D, K_F, K_G, K_H, K_J, K_K, K_L, K_SEMICOLON, K_APOSTROPHE, K_Z, K_X, K_C, K_V,
                                        K_B, K_N, K_M, K_SEPARATOR, K_DECIMAL, K_SLASH);

  procedure CreateOneButton(key: LongWord);
  begin
    TouchKey.OneButton[n].symb[1] := utf8_GetID(LoadText, m, @m);
    TouchKey.OneButton[n].symb[2] := utf8_GetID(LoadText, m, @m);
    TouchKey.OneButton[n].symb[3] := utf8_GetID(LoadText, m, @m);
    TouchKey.OneButton[n].symb[4] := utf8_GetID(LoadText, m, @m);
    TouchKey.OneButton[n]._key := key;
  end;

begin
  TouchKey.count := 34;
  if wndWidth < 1200 then
    dw := _wndWidth
  else
    dw := {$IfDef LINUX}rs1200{$Else}1200{$EndIf};
  if wndHeight < 500 then
    dh := (_wndHeight / {$IfDef LINUX}rs2{$Else}2{$EndIf})
  else
    dh := {$IfDef LINUX}rs251{$Else}251{$EndIf};

  TouchKey.OWidth := ((dw - {$IfDef LINUX}rs41{$Else}41{$EndIf}) / {$IfDef LINUX}rs13{$Else}13{$EndIf}); //((dw - 5 - 36) / 13);

  x0 := {$IfDef LINUX}rs2{$Else}2{$EndIf};
  dw := {$IfDef LINUX}rs3{$Else}3{$EndIf} + TouchKey.OWidth;
  y0 := _wndHeight - dh;
  dh := {$IfDef LINUX}rs3{$Else}3{$EndIf} + ((dh - {$IfDef LINUX}rs11{$Else}11{$EndIf}) / {$IfDef LINUX}rs4{$Else}4{$EndIf});

  TouchKey.Height := dh - {$IfDef LINUX}rs3{$Else}3{$EndIf};

  if dw >= dh then                              
    TouchKey.textScale := round(dh * {$IfDef LINUX}rs045{$Else}0.45{$EndIf})
  else
    TouchKey.textScale := round(dw * {$IfDef LINUX}rs045{$Else}0.45{$EndIf});

  for i := 1 to 13 do
  begin
    TouchKey.OneButton[i].X := x0 + dw * (i - 1);
    TouchKey.OneButton[i].Y := y0;
  end;

  y0 := y0 + dh;
  TouchKey.StringButton[_Tab].X := x0;
  TouchKey.StringButton[_Tab].Y := y0;
  // каждая ширина на 3 пикселя больше...
  TouchKey.StringButton[_Tab].Width := (TouchKey.OWidth * {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf}) + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Tab].bString := NameTab;
  TouchKey.StringButton[_Tab]._key := K_TAB;
  _xx0 := x0 + TouchKey.StringButton[_Tab].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  for i := 14 to 24 do
  begin
    TouchKey.OneButton[i].X := _xx0 + dw * (i - 14);
    TouchKey.OneButton[i].Y := y0;
  end;

  y0 := y0 + dh;
  TouchKey.StringButton[_CapsLock].X := x0;
  TouchKey.StringButton[_CapsLock].Y := y0;
  TouchKey.StringButton[_CapsLock].Width := TouchKey.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_CapsLock].bString := NameCapsLock;
  TouchKey.StringButton[_CapsLock]._key := K_CAPSLOCK;
  _xx0 := x0 + TouchKey.StringButton[_CapsLock].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  for i := 25 to 33 do
  begin
    TouchKey.OneButton[i].X := _xx0 + dw * (i - 25);
    TouchKey.OneButton[i].Y := y0;
  end;
  TouchKey.StringButton[_Enter].X := TouchKey.OneButton[33].X + dw;      
  TouchKey.StringButton[_Enter].Y := y0;                                 
  TouchKey.StringButton[_Enter].Width := TouchKey.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Enter].bString := NameEnter;
  TouchKey.StringButton[_Enter]._key := K_ENTER;

  y0 := y0 + dh;
  TouchKey.StringButton[_Shift].X := x0;
  TouchKey.StringButton[_Shift].Y := y0;
  TouchKey.StringButton[_Shift].Width := TouchKey.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Shift].bString := NameShift;
  TouchKey.StringButton[_Shift]._key := K_SHIFT_L;

  TouchKey.StringButton[_Space].X := x0 + TouchKey.StringButton[_Shift].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Space].Y := y0;
  TouchKey.StringButton[_Space].Width := (TouchKey.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf});
  TouchKey.StringButton[_Space].bString := ' ';
  TouchKey.StringButton[_Space]._key := K_SPACE;

  TouchKey.StringButton[_Latin].X := TouchKey.StringButton[_Space].X + TouchKey.StringButton[_Space].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Latin].Y := y0;
  TouchKey.StringButton[_Latin].Width := TouchKey.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Latin].bString := NameLatin;
  TouchKey.StringButton[_Latin]._key := K_F12;

  TouchKey.StringButton[_Rus].X := TouchKey.StringButton[_Space].X + TouchKey.StringButton[_Space].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Rus].Y := y0;
  TouchKey.StringButton[_Rus].Width := TouchKey.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Rus].bString := NameRus;
  TouchKey.StringButton[_Rus]._key := K_F12;

  TouchKey.StringButton[_symb].X := TouchKey.StringButton[_Latin].X + TouchKey.StringButton[_Latin].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_symb].Y := y0;
  TouchKey.StringButton[_symb].Width := (TouchKey.OWidth * {$IfDef LINUX}rs3{$Else}3{$EndIf} + {$IfDef LINUX}rs6{$Else}6{$EndIf});
  TouchKey.StringButton[_symb].bString := NameSymb;
  TouchKey.StringButton[_symb]._key := K_F2;
  TouchKey.OneButton[34].X := TouchKey.StringButton[_symb].X + TouchKey.StringButton[_symb].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.OneButton[34].Y := y0;

  TouchKey.StringButton[_Insert].X := TouchKey.OneButton[34].X + TouchKey.OWidth + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Insert].Y := y0;
  TouchKey.StringButton[_Insert].Width := (TouchKey.OWidth * {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf});
  TouchKey.StringButton[_Insert].bString := NameInsert;
  TouchKey.StringButton[_Insert]._key := K_INSERT;

  TouchKey.StringButton[_Del].X := TouchKey.StringButton[_Insert].X + TouchKey.StringButton[_Insert].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKey.StringButton[_Del].Y := y0;
  TouchKey.StringButton[_Del].Width := (TouchKey.OWidth * {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf});
  TouchKey.StringButton[_Del].bString := NameBackSpace;
  TouchKey.StringButton[_Del]._key := K_BACKSPACE;

(*  kodeSymb[1] := K_TILDE;       kodeSymb[2] := K_Q;   kodeSymb[3] := K_W;
    kodeSymb[4] := K_E;           kodeSymb[5] := K_R;   kodeSymb[6] := K_T;
    kodeSymb[7] := K_Y;           kodeSymb[8] := K_U;   kodeSymb[9] := K_I;
    kodeSymb[10] := K_O;          kodeSymb[11] := K_P;  kodeSymb[12] := K_BRACKET_L;
    kodeSymb[13] := K_BRACKET_R;  kodeSymb[14] := K_A;  kodeSymb[15] := K_S;
    kodeSymb[16] := K_D;          kodeSymb[17] := K_F;  kodeSymb[18] := K_G;
    kodeSymb[19] := K_H;          kodeSymb[20] := K_J;  kodeSymb[21] := K_K;
    kodeSymb[22] := K_L;          kodeSymb[23] := K_SEMICOLON;
    kodeSymb[24] := K_APOSTROPHE; kodeSymb[25] := K_Z;  kodeSymb[26] := K_X;
    kodeSymb[27] := K_C;          kodeSymb[28] := K_V;  kodeSymb[29] := K_B;
    kodeSymb[30] := K_N;          kodeSymb[31] := K_M;  kodeSymb[32] := K_SEPARATOR;
    kodeSymb[33] := K_DECIMAL;    kodeSymb[34] := K_SLASH;   *)

  m := 4;
  for n := 1 to 34 do
    CreateOneButton(kodeSymb[n]);
  set_FlagForLoadText(True);

  MenuChange := 3;
  SetMenuProcess(3);
  CreateTouchSymbol;
end;

procedure CreateTouchSymbol;
var
  dw, dh, x0, y0, _xx0: Single;
  i: integer;
begin
  TouchKeySymb.count := 23;                         
  if wndWidth < 1200 then
    dw := _wndWidth
  else
    dw := {$IfDef LINUX}rs1200{$Else}1200{$EndIf};
  if wndHeight < 500 then                       
    dh := _wndHeight / {$IfDef LINUX}rs2{$Else}2{$EndIf}
  else
    dh := {$IfDef LINUX}rs251{$Else}251{$EndIf};

  TouchKeySymb.OWidth := ((dw - {$IfDef LINUX}rs40{$Else}40{$EndIf}) / {$IfDef LINUX}rs11{$Else}11{$EndIf});

  x0 := {$IfDef LINUX}rs2{$Else}2{$EndIf};
  dw := {$IfDef LINUX}rs3{$Else}3{$EndIf} + TouchKeySymb.OWidth;
  y0 := _wndHeight - dh;
  dh := {$IfDef LINUX}rs3{$Else}3{$EndIf} + ((dh - {$IfDef LINUX}rs11{$Else}11{$EndIf}) / {$IfDef LINUX}rs4{$Else}4{$EndIf});

  TouchKeySymb.Height := dh - {$IfDef LINUX}rs3{$Else}3{$EndIf};

  if dw >= dh then                              
    TouchKeySymb.textScale := round(dh * {$IfDef LINUX}rs045{$Else}0.45{$EndIf})
  else
    TouchKeySymb.textScale := round(dw * {$IfDef LINUX}rs045{$Else}0.45{$EndIf});

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

  TouchKeySymb.StringButton[_Home].X := TouchKeySymb.OneDoubleButton[10].X + TouchKeySymb.OWidth + {$IfDef LINUX}rs3{$Else}3{$EndIf};
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

  TouchKeySymb.StringButton[_End].X := TouchKeySymb.OneDoubleButton[20].X + TouchKeySymb.OWidth + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.StringButton[_End].Y := y0;
  TouchKeySymb.StringButton[_End].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_End].bString := NameEnd;
  TouchKeySymb.StringButton[_End]._key := K_END;

  TouchKeySymb.TextureDown := 3;
  TouchKeySymb.TextureUp := 3;

  y0 := y0 + dh;
  TouchKeySymb.StringButton[_Ctrl].X := x0;
  TouchKeySymb.StringButton[_Ctrl].Y := y0;
  TouchKeySymb.StringButton[_Ctrl].Width := TouchKeySymb.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf} + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.StringButton[_Ctrl].bString := NameCtrl;
  TouchKeySymb.StringButton[_Ctrl]._key := K_CTRL_L;

  _xx0 := x0 + TouchKeySymb.StringButton[_Ctrl].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  for i := 21 to 23 do
  begin
    TouchKeySymb.OneDoubleButton[i].X := _xx0 + dw * (i - 21);
    TouchKeySymb.OneDoubleButton[i].Y := y0;
  end;
  // застрелитесь со всеми этими долбанными кодировками!!!               ('№')
  TouchKeySymb.OneDoubleButton[21].symb[1] := ID_toUTF8(8470);
  TouchKeySymb.OneDoubleButton[21].symb[2] := TouchKeySymb.OneDoubleButton[21].symb[1];
  TouchKeySymb.OneDoubleButton[21]._key := K_KP_3;
  TouchKeySymb.OneDoubleButton[22].symb[1] := '?';
  TouchKeySymb.OneDoubleButton[22].symb[2] := '?';
  TouchKeySymb.OneDoubleButton[22]._key := K_KP_2;
  TouchKeySymb.OneDoubleButton[23].symb[1] := '|';
  TouchKeySymb.OneDoubleButton[23].symb[2] := '|';
  TouchKeySymb.OneDoubleButton[23]._key := K_KP_1;

  TouchKeySymb.BArrow[_Up].X := TouchKeySymb.OneDoubleButton[23].X + {$IfDef LINUX}rs3{$Else}3{$EndIf} * TouchKeySymb.OWidth + {$IfDef LINUX}rs9{$Else}9{$EndIf};
  TouchKeySymb.BArrow[_Up].Y := y0;
  TouchKeySymb.BArrow[_Up].Angle := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  TouchKeySymb.BArrow[_Up]._key := K_UP;

  TouchKeySymb.StringButton[_Enter].X := TouchKeySymb.BArrow[_Up].X + {$IfDef LINUX}rs6{$Else}6{$EndIf} + TouchKeySymb.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf};
  TouchKeySymb.StringButton[_Enter].Y := y0;
  TouchKeySymb.StringButton[_Enter].Width := TouchKeySymb.StringButton[_Ctrl].Width;
  TouchKeySymb.StringButton[_Enter].bString := NameEnter;
  TouchKeySymb.StringButton[_Enter]._key := K_ENTER;

  y0 := y0 + dh;
  TouchKeySymb.StringButton[_Shift].X := x0;
  TouchKeySymb.StringButton[_Shift].Y := y0;
  TouchKeySymb.StringButton[_Shift].Width := TouchKeySymb.StringButton[_Ctrl].Width;
  TouchKeySymb.StringButton[_Shift].bString := NameShift;
  TouchKeySymb.StringButton[_Shift]._key := K_SHIFT_L;

  TouchKeySymb.StringButton[_Space].X := TouchKeySymb.StringButton[_Shift].X + TouchKeySymb.StringButton[_Shift].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.StringButton[_Space].Y := y0;
  TouchKeySymb.StringButton[_Space].Width := TouchKeySymb.StringButton[_Shift].Width;
  TouchKeySymb.StringButton[_Space].bString := ' ';
  TouchKeySymb.StringButton[_Space]._key := K_SPACE;

  TouchKeySymb.StringButton[_Keyboard].X := TouchKeySymb.StringButton[_Space].X + TouchKeySymb.StringButton[_Space].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.StringButton[_Keyboard].Y := y0;
  TouchKeySymb.StringButton[_Keyboard].Width := TouchKeySymb.StringButton[_Space].Width;
  TouchKeySymb.StringButton[_Keyboard].bString := NameKeyboard;
  TouchKeySymb.StringButton[_Keyboard]._key := K_F2;

  TouchKeySymb.BArrow[_Left].X := TouchKeySymb.StringButton[_Keyboard].X + TouchKeySymb.StringButton[_Keyboard].Width + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.BArrow[_Left].Y := y0;
  TouchKeySymb.BArrow[_Left].Angle := {$IfDef LINUX}rs270{$Else}270{$EndIf};
  TouchKeySymb.BArrow[_Left]._key := K_LEFT;

  TouchKeySymb.BArrow[_Down].X := TouchKeySymb.BArrow[_Left].X + TouchKeySymb.OWidth + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.BArrow[_Down].Y := y0;
  TouchKeySymb.BArrow[_Down].Angle := {$IfDef LINUX}rs180{$Else}180{$EndIf};
  TouchKeySymb.BArrow[_Down]._key := K_DOWN;

  TouchKeySymb.BArrow[_Right].X := TouchKeySymb.BArrow[_Down].X + TouchKeySymb.OWidth + {$IfDef LINUX}rs3{$Else}3{$EndIf};
  TouchKeySymb.BArrow[_Right].Y := y0;
  TouchKeySymb.BArrow[_Right].Angle := {$IfDef LINUX}rs90{$Else}90{$EndIf};
  TouchKeySymb.BArrow[_Right]._key := K_RIGHT;

  TouchKeySymb.StringButton[_Insert].X := TouchKeySymb.BArrow[_Down].X + {$IfDef LINUX}rs6{$Else}6{$EndIf} + TouchKeySymb.OWidth * {$IfDef LINUX}rs2{$Else}2{$EndIf};
  TouchKeySymb.StringButton[_Insert].Y := y0;
  TouchKeySymb.StringButton[_Insert].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Insert].bString := NameInsert;
  TouchKeySymb.StringButton[_Insert]._key := K_INSERT;

  TouchKeySymb.StringButton[_Del].X := TouchKeySymb.StringButton[_Insert].X + {$IfDef LINUX}rs3{$Else}3{$EndIf} + TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Del].Y := y0;
  TouchKeySymb.StringButton[_Del].Width := TouchKeySymb.OWidth;
  TouchKeySymb.StringButton[_Del].bString := NameBackSpace;
  TouchKeySymb.StringButton[_Del]._key := K_BACKSPACE;
end;

procedure GameJoy01Down(num: LongWord);
var
  i: Integer;
  _X, _Y: Integer;
begin
  {$IfDef MOBILE}
  _X := Mobile_Touch[num].newX;
  _Y := Mobile_Touch[num].newY;
  {$Else}
  _X := mouseX;
  _Y := mouseY;
  {$EndIf}
  if ((Sqr(_X - TouchJoyRolling.Rolling.X) + Sqr(_Y - TouchJoyRolling.Rolling.Y)) <= Sqr(TouchJoyRolling.Rolling.R)) then
  begin
    TouchJoyRolling.Rolling._x := _X;
    TouchJoyRolling.Rolling._y := _Y;
    TouchJoyRolling.Rolling.bPush := 1;
    TouchJoyRolling.Rolling.direction := m_Angle(TouchJoyRolling.Rolling.X, TouchJoyRolling.Rolling.Y, TouchJoyRolling.Rolling._x, TouchJoyRolling.Rolling._y);
    exit;                       
  end
  else
    TouchJoyRolling.Rolling.bPush := 0;

  for i := 1 to TouchJoyRolling.count do
  begin
    if ((_X > TouchJoyRolling.OneButton[i].X) and (_X < (TouchJoyRolling.OneButton[i].X + TouchJoyRolling.Width)) and
        (_Y > TouchJoyRolling.OneButton[i].Y) and (_Y < (TouchJoyRolling.OneButton[i].Y + TouchJoyRolling.Height))) then
    begin
      // если было нажатие, то отмечаем.
      TouchJoyRolling.OneButton[i].bPush := 1;
      keysDown[TouchJoyRolling.OneButton[i]._key] := True;
      exit;
    end
    else begin
      // в противном случае, "обнуляем", но по сути проще обнулить все? Или возможно множественное нажатие?
      keysDown[TouchJoyRolling.OneButton[i]._key] := False;
      TouchJoyRolling.OneButton[i].bPush := 0;
    end;
  end;
end;

procedure GameJoy02Down(num: LongWord);
var
  i: Integer;
  _X, _Y: Integer;
begin
  {$IfDef MOBILE}
  _X := Mobile_Touch[num].newX;
  _Y := Mobile_Touch[num].newY;
  {$Else}
  _X := mouseX;
  _Y := mouseY;
  {$EndIf}
  for i := 1 to 9 do
    if i <> 5 then
    begin
      if ((_X > TouchJoy.BArrow[i].X) and (_X < (TouchJoy.BArrow[i].X + TouchJoy.Width)) and
            (_Y > TouchJoy.BArrow[i].Y) and (_Y < (TouchJoy.BArrow[i].Y + TouchJoy.Height))) then
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
    if ((_X > TouchJoy.OneButton[i].X) and (_X < (TouchJoy.OneButton[i].X + TouchJoy.Width)) and
          (_Y > TouchJoy.OneButton[i].Y) and (_Y < (TouchJoy.OneButton[i].Y + TouchJoy.Height))) then
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

procedure TouchKeyboardDown(num: LongWord);
var
  i: Integer;
  lastKey: LongWord;
  _X, _Y: Integer;
label
  toCompareKey;
begin
  {$IfDef MOBILE}
  _X := Mobile_Touch[num].newX;
  _Y := Mobile_Touch[num].newY;
  {$Else}
  _X := mouseX;
  _Y := mouseY;
  {$EndIf}
  for i := 35 to 45 do
  begin
    if ((_X > TouchKey.StringButton[i].X) and (_X < (TouchKey.StringButton[i].X + TouchKey.StringButton[i].Width)) and
          (_Y > TouchKey.StringButton[i].Y) and (_Y < (TouchKey.StringButton[i].Y + TouchKey.Height))) then
    begin
 {     if (i = _Rus) then
        Continue;      }
      // выставляем какой код был на мышке последний. Но с тачпадом надо будет проверять именно номер "клика"
      lastKey := TouchKey.StringButton[i]._key;
      if (firstTapKey = is_notTouch) or ((firstTapKey = num) and (mouseLastVKey[num] = lastKey)) or (lastKey = K_SHIFT_L) or (lastKey = K_CAPSLOCK) then
        keyboardDown(lastKey)
      else
        lastKey := 0;
      goto toCompareKey;
    end;
  end;

  for i := 1 to TouchKey.count do
  begin
    if ((_X > TouchKey.OneButton[i].X) and (_X < (TouchKey.OneButton[i].X + TouchKey.OWidth)) and
          (_Y > TouchKey.OneButton[i].Y) and (_Y < (TouchKey.OneButton[i].Y + TouchKey.Height))) then
    begin
      // выставляем какой код был на мышке последний. Но с тачпадом надо будет проверять именно номер "клика"
      lastKey := TouchKey.OneButton[i]._key;
      if (firstTapKey = is_notTouch) or ((firstTapKey = num) and (mouseLastVKey[num] = lastKey)) then
        keyboardDown(lastKey)
      else
        break;
      goto toCompareKey;
    end;
  end;
  lastKey := 0;

toCompareKey:
  if (mouseLastVKey[num] <> 0) and (lastKey <> mouseLastVKey[num]) then
  begin
    keyboardUp(mouseLastVKey[num]);
    mouseLastVKey[num] := 0;
  end;
  case lastKey of
      K_PAUSE, K_INSERT, K_CTRL_L, K_CTRL_R, K_ALT_L, K_ALT_R, K_SHIFT_L, K_SHIFT_R, K_SUPER_L, K_SUPER_R, K_BACKSPACE,
        K_APP_MENU, K_CAPSLOCK, K_NUMLOCK, K_SCROLL, K_F1, K_F2, K_F3, K_F4, K_F5, K_F6, K_F7, K_F8, K_F9, K_F10, K_F11, K_F12: ;
    else begin
      if (lastKey > 0) and (firstTapKey = is_notTouch) then
        firstTapKey := num;
      mouseLastVKey[num] := lastKey;
    end;
  end;
end;

procedure TouchSymbolDown(num: LongWord);
var
  i: Integer;
  lastKey: LongWord;
  _X, _Y: Integer;
label
  toCompareKey;
begin
  {$IfDef MOBILE}
  _X := Mobile_Touch[num].newX;
  _Y := Mobile_Touch[num].newY;
  {$Else}
  _X := mouseX;
  _Y := mouseY;
  {$EndIf}
  for i := 1 to TouchKeySymb.count do
  begin
{    if ((_X > TouchKeySymb.OneDoubleButton[i].X) and (_X < (TouchKeySymb.OneDoubleButton[i].X + TouchKeySymb.OWidth)) and
          (_Y > TouchKeySymb.OneDoubleButton[i].Y) and (_Y < (TouchKeySymb.OneDoubleButton[i].Y + TouchKeySymb.Height))) then }
    if (_X > TouchKeySymb.OneDoubleButton[i].X) then
      if (_X < (TouchKeySymb.OneDoubleButton[i].X + TouchKeySymb.OWidth)) then
        if (_Y > TouchKeySymb.OneDoubleButton[i].Y) then
          if (_Y < (TouchKeySymb.OneDoubleButton[i].Y + TouchKeySymb.Height)) then
    begin
      // выставляем какой код был на мышке последний. Но с тачпадом надо будет проверять именно номер "клика"
      lastKey := TouchKeySymb.OneDoubleButton[i]._key;
    //  if (keysLast[KT_DOWN] = 0) or (keysLast[KT_DOWN] = lastKey) then
      if (firstTapKey = is_notTouch) or ((firstTapKey = num) and (mouseLastVKey[num] = lastKey)) then
        keyboardDown(lastKey)
      else
        lastKey := 0;
      goto toCompareKey;
    end;
  end;
  for i := 24 to 27 do
  begin
    if ((_X > TouchKeySymb.BArrow[i].X) and (_X < (TouchKeySymb.BArrow[i].X + TouchKeySymb.OWidth)) and
          (_Y > TouchKeySymb.BArrow[i].Y) and (_Y < (TouchKeySymb.BArrow[i].Y + TouchKeySymb.Height))) then
    begin
      // выставляем какой код был на мышке последний. Но с тачпадом надо будет проверять именно номер "клика"
      lastKey := TouchKeySymb.BArrow[i]._key;
//      if (keysLast[KT_DOWN] = 0) or (keysLast[KT_DOWN] = lastKey) then
      if (firstTapKey = is_notTouch) or ((firstTapKey = num) and (mouseLastVKey[num] = lastKey)) then
        keyboardDown(lastKey)
      else
        lastKey := 0;
      goto toCompareKey;
    end;
  end;
  for i := 36 to 44 do
  Begin
    if ((_X > TouchKeySymb.StringButton[i].X) and (_X < (TouchKeySymb.StringButton[i].X + TouchKeySymb.StringButton[i].Width)) and
          (_Y > TouchKeySymb.StringButton[i].Y) and (_Y < (TouchKeySymb.StringButton[i].Y + TouchKeySymb.Height))) then
    begin
      // выставляем какой код был на мышке последний. Но с тачпадом надо будет проверять именно номер "клика"
      lastKey := TouchKeySymb.StringButton[i]._key;
//      if (keysLast[KT_DOWN] = 0) or (keysLast[KT_DOWN] = lastKey) or ((keysLast[KT_DOWN] <> 0) and ((lastKey = K_SHIFT_L) or (lastKey = K_CTRL_L))) then
      if (firstTapKey = is_notTouch) or ((firstTapKey = num) and (mouseLastVKey[num] = lastKey)) or (lastKey = K_SHIFT_L) or (lastKey = K_CTRL_L) then
        keyboardDown(lastKey)
      else
        Break;
      goto toCompareKey;
    end;
  end;
  lastKey := 0;
toCompareKey:
  if (mouseLastVKey[num] <> 0) and (lastKey <> mouseLastVKey[num]) then
  begin
    keyboardUp(mouseLastVKey[num]);
    mouseLastVKey[num] := 0;
  end;
  case lastKey of
    K_PAUSE, K_INSERT, K_CTRL_L, K_CTRL_R, K_ALT_L, K_ALT_R, K_SHIFT_L, K_SHIFT_R, K_SUPER_L, K_SUPER_R,
        K_APP_MENU, K_CAPSLOCK, K_NUMLOCK, K_SCROLL, K_F1, K_F2, K_F3, K_F4, K_F5, K_F6, K_F7, K_F8, K_F9, K_F10, K_F11, K_F12: ;
    else begin
      if (lastKey > 0) and (firstTapKey = is_notTouch) then
        firstTapKey := num;
      mouseLastVKey[num] := lastKey;
    end;
  end;
end;

procedure ShowVKeyboard;
begin
  VisibleMenuChange := true;
end;

procedure HideVKeyboard;
begin
  VisibleMenuChange := False;
end;

procedure GameJoy01Up(num: LongWord);
var
  i: Integer;
begin
  TouchJoyRolling.Rolling.bPush := 0;
  for i := 1 to TouchJoyRolling.count do
  begin
    TouchJoyRolling.OneButton[i].bPush := 0;
    keyboardUp(TouchJoyRolling.OneButton[i]._key);
  end;
end;

procedure GameJoy02Up(num: LongWord);
var
  i: Integer;
begin
  for i := 1 to 9 do
    if i <> 5 then
    begin
      TouchJoy.BArrow[i].bPush := 0;
      keyboardUp(TouchJoy.BArrow[i]._key);
    end;
  for i := 1 to TouchJoy.count do
  begin
    TouchJoy.OneButton[i].bPush := 0;
    keyboardUp(TouchJoy.OneButton[i]._key);
  end;
end;

procedure TouchKeyboardUp(num: LongWord);
var
  i: Integer;
  lastKey: LongWord;
  _X, _Y: Integer;
begin
  {$IfDef MOBILE}
  _X := Mobile_Touch[num].oldX;
  _Y := Mobile_Touch[num].oldY;
  {$Else}
  _X := mouseX;
  _Y := mouseY;
  {$EndIf}
  for i := 35 to 45 do
  begin
    if ((_X > TouchKey.StringButton[i].X) and (_X < (TouchKey.StringButton[i].X + TouchKey.StringButton[i].Width)) and
          (_Y > TouchKey.StringButton[i].Y) and (_Y < (TouchKey.StringButton[i].Y + TouchKey.Height))) then
    begin
      if (i = _Rus) then
        Continue;
      lastKey := TouchKey.StringButton[i]._key;
      if firstTapKey = num then
        firstTapKey := is_notTouch;
      keyboardUp(lastKey);
      mouseLastVKey[num] := 0;
      exit;
    end;
  end;
  for i := 1 to TouchKey.count do
  begin
    if ((_X > TouchKey.OneButton[i].X) and (_X < (TouchKey.OneButton[i].X + TouchKey.OWidth)) and
          (_Y > TouchKey.OneButton[i].Y) and (_Y < (TouchKey.OneButton[i].Y + TouchKey.Height))) then
    begin
      lastKey := TouchKey.OneButton[i]._key;
      if firstTapKey = num then
        firstTapKey := is_notTouch;
      keyboardUp(lastKey);
      break;
    end;
  end;
  mouseLastVKey[num] := 0;
end;

procedure TouchSymbolUp(num: LongWord);
var
  i: Integer;
  lastKey: LongWord;
  _X, _Y: Integer;
begin
  {$IfDef MOBILE}
  _X := Mobile_Touch[num].oldX;
  _Y := Mobile_Touch[num].oldY;
  {$Else}
  _X := mouseX;
  _Y := mouseY;
  {$EndIf}
  for i := 1 to TouchKeySymb.count do
  begin
    if ((_X > TouchKeySymb.OneDoubleButton[i].X) and (_X < (TouchKeySymb.OneDoubleButton[i].X + TouchKeySymb.OWidth)) and
          (_Y > TouchKeySymb.OneDoubleButton[i].Y) and (_Y < (TouchKeySymb.OneDoubleButton[i].Y + TouchKeySymb.Height))) then
    begin
      lastKey := TouchKeySymb.OneDoubleButton[i]._key;
      if firstTapKey = num then
        firstTapKey := is_notTouch;
      keyboardUp(lastKey);
      mouseLastVKey[num] := 0;
      exit;
    end;
  end;
  for i := 24 to 27 do
  begin
    if ((_X > TouchKeySymb.BArrow[i].X) and (_X < (TouchKeySymb.BArrow[i].X + TouchKeySymb.OWidth)) and
          (_Y > TouchKeySymb.BArrow[i].Y) and (_Y < (TouchKeySymb.BArrow[i].Y + TouchKeySymb.Height))) then
    begin
      lastKey := TouchKeySymb.BArrow[i]._key;
      if firstTapKey = num then
        firstTapKey := is_notTouch;
      keyboardUp(lastKey);
      mouseLastVKey[num] := 0;
      exit;
    end;
  end;
  for i := 36 to 44 do
  Begin
    if ((_X > TouchKeySymb.StringButton[i].X) and (_X < (TouchKeySymb.StringButton[i].X + TouchKeySymb.StringButton[i].Width)) and
          (_Y > TouchKeySymb.StringButton[i].Y) and (_Y < (TouchKeySymb.StringButton[i].Y + TouchKeySymb.Height))) then
    begin
      lastKey := TouchKeySymb.StringButton[i]._key;
      if firstTapKey = num then
        firstTapKey := is_notTouch;
      keyboardUp(lastKey);
//      if (i = _Shift) or (i = _Ctrl) then
      break;
    end;
  end;
  mouseLastVKey[num] := 0;
end;

end.
