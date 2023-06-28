{
 *  Copyright (c) 2012 Andrey Kemka
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

 !!! modification from Serge
}
unit zgl_keyboard;

{$I zgl_config.cfg}
{$IFDEF iOS}
  {$modeswitch objectivec1}
{$ENDIF}

interface
{$IfNDef MAC_COCOA}
uses
{$EndIf}
  {$IFDEF USE_X11}
  X, Xlib, keysym;
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows;
  {$ENDIF}
  {$IFDEF iOS}
  iPhoneAll, CGGeometry;
  {$ENDIF}
  {$IFDEF ANDROID}
  jni;
  {$ENDIF}

const
  K_SYSRQ      = $B7;
  K_PAUSE      = $C5;
  K_ESCAPE     = $01;
  K_ENTER      = $1C;
  K_KP_ENTER   = $9C;

  K_UP         = $C8;
  K_DOWN       = $D0;
  K_LEFT       = $CB;
  K_RIGHT      = $CD;

  K_BACKSPACE  = $0E;
  K_SPACE      = $39;
  K_TAB        = $0F;
  K_TILDE      = $29;

  K_INSERT     = $D2;
  K_DELETE     = $D3;
  K_HOME       = $C7;
  K_END        = $CF;
  K_PAGEUP     = $C9;
  K_PAGEDOWN   = $D1;

  K_CTRL       = $FF - $01;
  K_CTRL_L     = $1D;
  K_CTRL_R     = $9D;
  K_ALT        = $FF - $02;
  K_ALT_L      = $38;
  K_ALT_R      = $B8;
  K_SHIFT      = $FF - $03;
  K_SHIFT_L    = $2A;
  K_SHIFT_R    = $36;
  K_SUPER      = $FF - $04;
  K_SUPER_L    = $DB;
  K_SUPER_R    = $DC;
  K_APP_MENU   = $DD;

  K_CAPSLOCK   = $3A;
  K_NUMLOCK    = $45;
  K_SCROLL     = $46;

  K_BRACKET_L  = $1A; // [{
  K_BRACKET_R  = $1B; //] }
  K_BACKSLASH  = $2B; // \
  K_SLASH      = $35; // /
  K_SEPARATOR  = $33; // ,
  K_DECIMAL    = $34; // .
  K_SEMICOLON  = $27; //: ;
  K_APOSTROPHE = $28; // ' "

  K_0          = $0B;
  K_1          = $02;
  K_2          = $03;
  K_3          = $04;
  K_4          = $05;
  K_5          = $06;
  K_6          = $07;
  K_7          = $08;
  K_8          = $09;
  K_9          = $0A;

  K_MINUS      = $0C;
  K_EQUALS     = $0D;

  K_A          = $1E;
  K_B          = $30;
  K_C          = $2E;
  K_D          = $20;
  K_E          = $12;
  K_F          = $21;
  K_G          = $22;
  K_H          = $23;
  K_I          = $17;
  K_J          = $24;
  K_K          = $25;
  K_L          = $26;
  K_M          = $32;
  K_N          = $31;
  K_O          = $18;
  K_P          = $19;
  K_Q          = $10;
  K_R          = $13;
  K_S          = $1F;
  K_T          = $14;
  K_U          = $16;
  K_V          = $2F;
  K_W          = $11;
  K_X          = $2D;
  K_Y          = $15;
  K_Z          = $2C;

  K_KP_0       = $52;
  K_KP_1       = $4F;
  K_KP_2       = $50;
  K_KP_3       = $51;
  K_KP_4       = $4B;
  K_KP_5       = $4C;
  K_KP_6       = $4D;
  K_KP_7       = $47;
  K_KP_8       = $48;
  K_KP_9       = $49;

  K_KP_SUB     = $4A;
  K_KP_ADD     = $4E;
  K_KP_MUL     = $37;
  K_KP_DIV     = $B5;
  K_KP_DECIMAL = $53;

  K_F1         = $3B;
  K_F2         = $3C;
  K_F3         = $3D;
  K_F4         = $3E;
  K_F5         = $3F;
  K_F6         = $40;
  K_F7         = $41;
  K_F8         = $42;
  K_F9         = $43;
  K_F10        = $44;
  K_F11        = $57;
  K_F12        = $58;

  // основные события происходящие между интервалами очистки клавиатуры
  KA_DOWN      = 0;
  KA_UP        = 1;
  // события происходящие только при нажатии/отжатии клавиш
  KT_DOWN      = 2;
  KT_UP        = 3;

  keyboardLatinRus       = $00000001;
  keyboardLatRusDown     = $00000002;
  keyboardCaps           = $00000004;
  keyboardCapsDown       = $00000008;
  keyboardSymbol         = $00000010;
  keyboardSymbolDown     = $00000020;
  keyboardShift          = $00000040;
  keyboardCtrl           = $00000080;
  keyboardCommand        = $00000100;
  keyboardAlt            = $00000200;
  keyboardInsert         = $00000400;
  keyboardInsertDown     = $00000800;
  keyboardNumLock        = $00001000;
  keyboardNumLockDown    = $00002000;
  keyboardScrollLock     = $00004000;
  keyboardScrollLockDown = $00008000;

// Rus: внутренняя работа с клавиатурой для всех систем, не надо трогать эту процедуру.
// Eng: internal work with the keyboard for all systems, do not touch this procedure.
procedure keyboardDown(keyCode: LongWord);
// Rus: внутренняя работа с клавиатурой для всех систем, не надо трогать эту процедуру.
// Eng: internal work with the keyboard for all systems, do not touch this procedure.
procedure keyboardUp(keyCode: LongWord);

{$IfDef LIBRARY_COMPILE}
// Rus: опрос, удержана ли клавиша.
// Eng: Polling if a key is held down.
function  key_Down(KeyCode: LongWord): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Rus: опрос, отжата клавиша или нет в данный момент времени.
// Eng: polling whether a key is released or not at a given time.
function  key_Up(KeyCode: LongWord): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}

// Rus: опрос, нажата клавиша или нет, в данный момент времени.
// Eng: polling whether a key is pressed or not, at a given time.
function  key_Press(KeyCode: LongWord): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}

// Rus: вернёт код последней нажатой/отжатой (НЕ УПРАВЛЯЮЩЕЙ!) клавиши
//      KeyAction = или KA_DOWN или KA_UP
// Eng: will return the code of the last pressed/released (NOT CONTROL!) key
//      KeyAction = either KA_DOWN or KA_UP
function  key_Last(KeyAction: LongWord): LongWord; {$IfDef USE_INLINE}inline;{$EndIf}
{$EndIf}

{$IfDef KEYBOARD_OLD_FUNCTION}
// Rus: старые способы использования поля ввода 3-я демка.
// Eng: old ways to use the input field 3rd demo.
procedure key_BeginReadText(const Text: UTF8String; MaxSymbols: Integer = -1);
procedure key_UpdateReadText(const Text: UTF8String; MaxSymbols: Integer = -1);
function  key_GetText: UTF8String; {$IfDef FPC}inline;{$EndIf}
procedure key_EndReadText;

procedure key_InputText(const Text: UTF8String);
function _key_GetText: PAnsiChar;
{$EndIf}

// Rus: очистка состояний клавиатуры. Прописано в рабочем коде. Если вы сами не
//      подменяете инициализацию - zgl_Reg(SYS_APP_INIT, ...), то вам не нужно
//      её использовать.
// Eng: clearing keyboard states. Registered in the working code. If you don't
//      change the initialization yourself - zgl_Reg(SYS_APP_INIT, ...), then
//      you don't need to use it.
procedure key_ClearState;
// Rus: возвращает код символа из кода клавиатуры. Только латиница.
// Eng: returns the character code from the keyboard code. Only Latin.
function scancode_to_utf8(ScanCode: LongWord): LongWord;

// Rus: Установка начальной задержки (при начальном нажатии) при зажатии клавиши.
// Eng: Sets the initial delay (when initially pressed) when the key is pressed.
procedure setKey_BeginRepeat(delay: Double); {$IfDef USE_INLINE}inline;{$EndIf}

// Rus: Установки задержки при зажатии клавиши.
//     эта задержка не может быть больше половины начальной задержки.
// Eng: Setting the delay when pressing a key.
//     This delay cannot be more than half of the initial delay.
procedure setKey_Repeat(delay: Double);
{$IfNDef MOBILE}
{$IfDef USE_VKEYBOARD}
// Rus: Установка задержки отключения виртуальной клавиатуры
//     (защита от одновременной работы клавиатуры и виртуальной клавиатуры)
//     Работает для не управляющих клавиш.
//     (Ctrl, Shif, Alt, Win/Command, CapsLock, ScrollLock, NumLock)
// Eng: Setting the delay for turning off the virtual keyboard
//     (protection against the simultaneous operation of the keyboard and virtual keyboard)
//     Works for non-control keys.
//     (Ctrl, Shif, Alt, Win/Command, CapsLock, ScrollLock, NumLock)
procedure setTimeLockVK(delay: Double); {$IfDef FPC}inline;{$EndIf}
{$EndIf}{$EndIf}

{$IFDEF USE_X11}
function xkey_to_scancode(XKey, KeyCode: Integer): LongWord;
{$IfDef KEYBOARD_OLD_FUNCTION}
function Xutf8LookupString(ic: PXIC; event: PXKeyPressedEvent; buffer_return: PAnsiChar; bytes_buffer: Integer; keysym_return: PKeySym; status_return: PStatus): integer; cdecl; external;
{$EndIf}
{$ENDIF}
{$IFDEF WINDOWS}
function winkey_to_scancode(WinKey: Integer): LongWord;
{$ENDIF}
{$IFDEF MAC_COCOA}
function mackey_to_scancode(MacKey: Integer): LongWord;
{$ENDIF}
{$IFDEF iOS}
type
  zglCiOSTextField = objcclass(UITextField, UITextInputTraitsProtocol)
  public
    function textRectForBounds(bounds_: CGRect): CGRect; override;
    function editingRectForBounds(bounds_: CGRect): CGRect; override;
  end;
{$ENDIF}

var
  keysDown    : array[0..255] of Boolean;
  keysUp      : array[0..255] of Boolean;
  keysPress   : array[0..255] of Boolean;
  keysCanPress: array[0..255] of Boolean;
  {$IfDef KEYBOARD_OLD_FUNCTION}
  keysText    : UTF8String = '';
  keysCanText : Boolean;
  keysMax     : Integer;
  {$EndIf}
  keysLast    : array[0..3] of LongWord;

  mouseToKey: Boolean = false;

  {$IFDEF USE_X11}
  keysRepeat: Integer; // Workaround, yeah... :)
  {$ENDIF}
  {$IFDEF iOS}
  keysTextField  : zglCiOSTextField;
  keysTextTraits : UITextInputTraitsProtocol;
  keysTextFrame  : CGRect;
  keysTextChanged: Boolean;
  {$ENDIF}
  // Rus: длительность задержки, для повтора ввода клавиши.
  // Eng:
  keyDownRepeat: Double;
  // Rus: зажата клавиша (производится ли повторение?).
  // Eng:
  keyBoolRepeat: Boolean;
  // Rus: начальная задержка - удержание кнопки клавиатуры.
  // Eng:
  beginKeyDelay: Double = 500;
  // Rus: задержка при постоянном удержании кнопки клавиатуры.
  // Eng:
  repeatKeyDelay: Double = 60;
  // Rus: установленная рабочая задержка, для кнопки клавиатуры.
  // Eng:
  keyDelayWork: Double = 500;
  {$IfNDef MOBILE}
  {$IfDef USE_VKEYBOARD}
  // Rus: блокирует виртуальную клавиатуру.
  // Eng:
  lockVirtualKeyboard: Boolean = False;

  // Rus: оповещает, что надо блокировать виртуальную клавиатуру.
  // Eng:
//  prevLockVK: Boolean = False;

  // Rus: общее время блокировки виртуальной клавиатуры.
  // Eng:
  timeLockVK: Double = 500;
  // Rus: установка отсчёта времени отхода блокировки виртуальной клавиатуры.
  // Eng:
  startTimeLockVK: Double;
  {$EndIf}{$EndIf}
  //Rus: флаги для работы с клавиатурой.
  //     для понимания: управляющие клавиши не могут быть "последними"-нажатыми
  //     а если управляющие клавиши сработали, то часть их отображается в флагах,
  //     как сработавшие и как произошедшее событие
  //     эти флаги можно включить, при запуске программы и опросе системы.
  // Eng:
  keybFlags   : LongWord;
  PkeybFlags  : PCardinal = @keybFlags;

implementation
uses
  {$IfDef KEYBOARD_OLD_FUNCTION}
  zgl_application,
  zgl_utils,
  zgl_window,
  {$EndIf}
  {$IfDef USE_VKEYBOARD}
  gegl_menu_gui,
  {$Else}
//
  {$EndIf}
  zgl_timers;

procedure keyboardDown(keyCode: LongWord);
begin
  {$IfNDef MOBILE}
  {$If not(defined( WINDOWS) or defined(LINUX))}
  // грёбанный ситуэйшн... опять долбанные переводы, при нажатии определённых клавиш
  if (keybFlags and keyboardNumLock) > 0 then
  begin
    if (KeyCode >= $47) and (KeyCode <= $53) then
    begin
      case KeyCode of
        K_KP_0:       KeyCode := K_INSERT;
        K_KP_1:       KeyCode := K_END;
        K_KP_2:       KeyCode := K_DOWN;
        K_KP_3:       KeyCode := K_PAGEDOWN;
        K_KP_4:       KeyCode := K_LEFT;
        K_KP_6:       KeyCode := K_RIGHT;
        K_KP_7:       KeyCode := K_HOME;
        K_KP_8:       KeyCode := K_UP;
        K_KP_9:       KeyCode := K_PAGEUP;
        K_KP_DECIMAL: KeyCode := K_DELETE;
      end;
    end;
  end;
  {$IfEnd}{$EndIf}

  keysDown[KeyCode] := TRUE;
  keysUp[KeyCode] := FALSE;

  {$IFDEF USE_X11}
//  if keysRepeat < 2 Then
  {$ENDIF}
    begin
      keysPress   [KeyCode] := TRUE;
      keysCanPress[KeyCode] := FALSE;
    end;
  case KeyCode of
    K_PAUSE: ;
    K_INSERT:   PkeybFlags^ := PkeybFlags^ or keyboardInsertDown;
    {$IfNDef MAC_COCOA}
    K_CTRL_L, K_CTRL_R:
      begin
        PkeybFlags^ := PkeybFlags^ or keyboardCtrl;
        keysDown[K_CTRL] := True;
        keysUp  [K_CTRL] := False;
      end;
    K_ALT_L, K_ALT_R:
      begin
        PkeybFlags^ := PkeybFlags^ or keyboardAlt;
        keysDown[K_ALT] := True;
        keysUp  [K_ALT] := False;
      end;
    K_SHIFT_L, K_SHIFT_R:
      begin
        PkeybFlags^ := PkeybFlags^ or keyboardShift;
        keysDown[K_SHIFT] := True;
        keysUp  [K_SHIFT] := False;
      end;
    K_SUPER_L, K_SUPER_R:
      begin
        PkeybFlags^ := PkeybFlags^ or keyboardCommand;
        keysDown[K_SUPER] := True;
        keysUp  [K_SUPER] := False;
      end;
    K_CAPSLOCK: PkeybFlags^ := PkeybFlags^ or keyboardCapsDown;
    {$EndIf}
    K_APP_MENU: ;
    K_NUMLOCK:  PkeybFlags^ := PkeybFlags^ or keyboardNumLockDown;
    K_SCROLL:   PkeybFlags^ := PkeybFlags^ or keyboardScrollLockDown;
    K_F1, K_F2, K_F3, K_F4, K_F5, K_F6, K_F7, K_F8, K_F9, K_F10, K_F11, K_F12: ;
  else
    begin
      keysLast[KA_DOWN] := KeyCode;
      {$IfNDef MOBILE}
      {$IfDef USE_VKEYBOARD}
      if not mouseToKey then
      begin
        //  prevLockVK := true;
        lockVirtualKeyboard := True;
        startTimeLockVK := timer_GetTicks;
      end;
      {$EndIf}{$EndIf}
    end;
  end;

  keysLast[KT_UP] := 0;
end;

procedure keyboardUp(keyCode: LongWord);
var
  _flag: Boolean;
begin
  {$IfNDef MOBILE}
  {$If not(defined( WINDOWS) or defined(LINUX))}
  // грёбанный ситуэшн... опять долбанные переводы, при нажатии определённых клавиш
  if (keybFlags and keyboardNumLock) > 0 then
  begin
    if (KeyCode >= $47) and (KeyCode <= $53) then
    begin
      case KeyCode of
        K_KP_0:       KeyCode := K_INSERT;
        K_KP_1:       KeyCode := K_END;
        K_KP_2:       KeyCode := K_DOWN;
        K_KP_3:       KeyCode := K_PAGEDOWN;
        K_KP_4:       KeyCode := K_LEFT;
        K_KP_6:       KeyCode := K_RIGHT;
        K_KP_7:       KeyCode := K_HOME;
        K_KP_8:       KeyCode := K_UP;
        K_KP_9:       KeyCode := K_PAGEUP;
        K_KP_DECIMAL: KeyCode := K_DELETE;
      end;
    end;
  end;
  {$IfEnd}{$EndIf}

  if keysLast[KT_UP] = KeyCode then
    exit;

  keysDown[KeyCode] := FALSE;
  keysUp  [KeyCode] := TRUE;
  keysPress   [KeyCode] := False;
  keysCanPress[KeyCode] := True;

  case KeyCode of
    K_PAUSE: ;
    K_INSERT:   if ((PkeybFlags^ and keyboardInsertDown) > 0) then
                  PkeybFlags^ := PkeybFlags^ xor keyboardInsertDown xor keyboardInsert;
    K_APP_MENU: ;

    K_NUMLOCK:  if ((PkeybFlags^ and keyboardNumLockDown) > 0) then
                  PkeybFlags^ := PkeybFlags^ xor keyboardNumLock xor keyboardNumLockDown;
    K_SCROLL: if ((PkeybFlags^ and keyboardScrollLockDown) > 0) then
                  PkeybFlags^ := PkeybFlags^ xor keyboardScrollLock xor keyboardScrollLockDown;
    K_F1, K_F2, K_F3, K_F4, K_F5, K_F6, K_F7, K_F8, K_F9, K_F10, K_F11, K_F12: ;
    {$IfNDef MAC_COCOA}
    K_CAPSLOCK: if ((PkeybFlags^ and keyboardCapsDown) > 0)  then
                  PkeybFlags^ := PkeybFlags^ xor keyboardCapsDown xor keyboardCaps;
    K_CTRL_R, K_CTRL_L:
      begin
        if keyCode = K_CTRL_R then
          _flag := keysCanPress[K_CTRL_L]
        else
          _flag := keysCanPress[K_CTRL_R];

        if _flag then
        begin
          PkeybFlags^ := PkeybFlags^ and ($FFFFFFFF - keyboardCtrl);
          keysDown[K_CTRL] := FALSE;
          keysUp  [K_CTRL] := TRUE;
        end;
      end;
    K_ALT_L, K_ALT_R:
      begin
        if keyCode = K_ALT_R then
          _flag := keysCanPress[K_ALT_L]
        else
          _flag := keysCanPress[K_ALT_R];
        if _flag then
        begin
          PkeybFlags^ := PkeybFlags^ and ($FFFFFFFF - keyboardAlt);
          keysDown[K_ALT] := FALSE;
          keysUp  [K_ALT] := TRUE;
        end;
      end;
    K_SHIFT_L, K_SHIFT_R:
      begin
        if keyCode = K_SHIFT_R then
          _flag := keysCanPress[K_SHIFT_L]
        else
          _flag := keysCanPress[K_SHIFT_R];
        if _flag then
        begin
          PkeybFlags^ := PkeybFlags^ and ($FFFFFFFF - keyboardShift);
          keysDown[K_SHIFT] := FALSE;
          keysUp  [K_SHIFT] := TRUE;
        end;
      end;
    K_SUPER_R, K_SUPER_L:
      begin
        if keyCode = K_SUPER_R then
          _flag := keysCanPress[K_SUPER_L]
        else
          _flag := keysCanPress[K_SUPER_R];
        if _flag then
        begin
          PkeybFlags^ := PkeybFlags^ and ($FFFFFFFF - keyboardCommand);
          keysDown[K_SUPER] := FALSE;
          keysUp  [K_SUPER] := TRUE;
        end;
      end;
    {$EndIf}
  else
    begin
      keysLast[KA_UP] := KeyCode;
      keysLast[KT_UP] := KeyCode;
      {$IfNDef MOBILE}
      {$IfDef USE_VKEYBOARD}
      if not mouseToKey then
      begin
        //  prevLockVK := true;
        lockVirtualKeyboard := True;
        startTimeLockVK := timer_GetTicks;
      end;
      {$EndIf}{$EndIf}
    end;
  end;

  if (keysLast[KT_DOWN] = KeyCode) or (keysLast[KA_DOWN] = KeyCode) then
  begin
    keysLast[KA_DOWN] := 0;
    keysLast[KT_DOWN] := 0;
    keyDelayWork := beginKeyDelay;
  end;
end;

{$IfDef LIBRARY_COMPILE}
function key_Down(KeyCode: LongWord): Boolean;
begin
  Result := keysDown[KeyCode];
end;

function key_Up(KeyCode: LongWord): Boolean;
begin
  Result := keysUp[KeyCode];
end;

function key_Press(KeyCode: LongWord): Boolean;
begin
  Result := keysPress[KeyCode];
end;

function key_Last(KeyAction: LongWord): LongWord;
begin
  Result := keysLast[KeyAction];
end;
{$EndIf}


{$IfDef KEYBOARD_OLD_FUNCTION}
procedure key_BeginReadText(const Text: UTF8String; MaxSymbols: Integer = -1);
  {$IFDEF ANDROID}
  var
    env: PJNIEnv;
  {$ENDIF}
begin
  {$IFDEF iOS}
  if Assigned(keysTextField) and (keysText <> Text) Then
    keysTextField.setText(utf8_GetNSString(Text));
  {$ENDIF}

  keysText    := utf8_Copy(Text);
  keysMax     := MaxSymbols;
  keysCanText := TRUE;

  {$IFDEF iOS}
  if not Assigned(keysTextField) Then
  begin
    keysTextFrame := wndHandle.frame;
    keysTextField := zglCiOSTextField.alloc().initWithFrame(keysTextFrame);
    keysTextTraits := keysTextField;
    with keysTextField, keysTextTraits do
    begin
      setDelegate(appDelegate);
      setAutocapitalizationType(UITextAutocapitalizationTypeNone);
      setAutocorrectionType(UItextAutocorrectionTypeNo);
      setKeyboardAppearance(UIKeyboardAppearanceDefault);
      setReturnKeyType(UIReturnKeyDone);
      setSecureTextEntry(FALSE);
      addTarget_action_forControlEvents(appDelegate, objcselector('textFieldEditingChanged'), UIControlEventEditingChanged);
    end;
    keysTextField.setText(utf8_GetNSString(Text));
    wndHandle.addSubview(keysTextField);
  end;
  if appFlags and APP_USE_ENGLISH_INPUT > 0 Then
    keysTextTraits.setKeyboardType(UIKeyboardTypeASCIICapable)
  else
    keysTextTraits.setKeyboardType(UIKeyboardTypeDefault);

  wndHandle.addSubview(keysTextField);
  keysTextField.becomeFirstResponder();
  {$ENDIF}

  {$IFDEF ANDROID}
  appEnv^.CallVoidMethod(appEnv, appObject, appShowKeyboard);
  {$ENDIF}
end;

procedure key_UpdateReadText(const Text: UTF8String; MaxSymbols: Integer = -1);
begin
  if keysCanText Then
  begin
    {$IFDEF iOS}
    if Assigned(keysTextField) and (keysText <> Text) Then
      keysTextField.setText(utf8_GetNSString(Text));
    {$ENDIF}

    keysText := utf8_Copy(Text);
    keysMax  := MaxSymbols;
  end;
end;

function key_GetText: UTF8String;
begin
  Result := keysText;
end;

procedure key_EndReadText;
begin
  keysText    := '';
  keysCanText := FALSE;

  {$IFDEF iOS}
  if Assigned(keysTextField) Then
    keysTextField.removeFromSuperview();
  {$ENDIF}
  {$IFDEF ANDROID}
  appEnv^.CallVoidMethod(appEnv, appObject, appHideKeyboard);
  {$ENDIF}
end;
{$EndIf}

procedure key_ClearState;
  var
    i: Integer;
begin
  {$IFDEF USE_X11}
  if keysRepeat < 2 Then
  {$ENDIF}
    for i := 0 to 255 do
    begin
      keysUp      [i] := FALSE;
      keysPress   [i] := FALSE;
      keysCanPress[i] := TRUE;
    end;
  keysLast[KA_DOWN] := 0;
  keysLast[KA_UP  ] := 0;
//  keyBoolRepeat := False;
end;

function scancode_to_utf8(ScanCode: LongWord): LongWord;
begin
  Result := 0;
  case ScanCode of
    K_TAB: Result := 9;
    K_TILDE:  Result := 96;
    K_MINUS,
    K_KP_SUB: Result := 45;
    K_EQUALS: Result := 61;
    K_SPACE: Result := 32;

    K_0, K_KP_0: Result := 48;
    K_1, K_KP_1: Result := 49;
    K_2, K_KP_2: Result := 50;
    K_3, K_KP_3: Result := 51;
    K_4, K_KP_4: Result := 52;
    K_5, K_KP_5: Result := 53;
    K_6, K_KP_6: Result := 54;
    K_7, K_KP_7: Result := 55;
    K_8, K_KP_8: Result := 56;
    K_9, K_KP_9: Result := 57;

    K_KP_MUL: Result := 42;
    K_KP_ADD: Result := 43;

    K_A: Result := 97;
    K_B: Result := 98;
    K_C: Result := 99;
    K_D: Result := 100;
    K_E: Result := 101;
    K_F: Result := 102;
    K_G: Result := 103;
    K_H: Result := 104;
    K_I: Result := 105;
    K_J: Result := 106;
    K_K: Result := 107;
    K_L: Result := 108;
    K_M: Result := 109;
    K_N: Result := 110;
    K_O: Result := 111;
    K_P: Result := 112;
    K_Q: Result := 113;
    K_R: Result := 114;
    K_S: Result := 115;
    K_T: Result := 116;
    K_U: Result := 117;
    K_V: Result := 118;
    K_W: Result := 119;
    K_X: Result := 120;
    K_Y: Result := 121;
    K_Z: Result := 122;

    K_BRACKET_L:  Result := 91;
    K_BRACKET_R:  Result := 93;
    K_BACKSLASH:  Result := 92;
    K_SLASH,
    K_KP_DIV:     Result := 47;
    K_SEPARATOR:  Result := 44;
    K_DECIMAL,
    K_KP_DECIMAL: Result := 46;
    K_SEMICOLON:  Result := 59;
    K_APOSTROPHE: Result := 39;
  end;

  if ((PkeybFlags^ and keyboardCaps) > 0) then
  begin
    if (Result >= 97) and (Result <= 122) then
      Result := Result - 32;
    // эта часть должна быть другой, если используется не русский язык и не латиница
    if ((PkeybFlags^ and keyboardLatinRus) > 0) then
    begin
      if Result = 96 then
        Result := 126;
      if Result = 91 then
        Result := 123;
      if Result = 93 then
        Result := 125;
      if Result = 59 then
        Result := 58;
      if Result = 39 then
        Result := 34;
      if Result = 44 then
        Result := 60;
      if Result = 46 then
        Result := 62;
    end;
  end else
    if keysDown[K_SHIFT] then
    begin
      case Result of
        96: Result := 126; // ~
        45: Result := 95;  // _
        61: Result := 43;  // +

        48: Result := 41; // (
        49: Result := 33; // !
        50: Result := 64; // @
        51: Result := 35; // #
        52: Result := 36; // $
        53: Result := 37; // %
        54: Result := 94; // ^
        55: Result := 38; // &
        56: Result := 42; // *
        57: Result := 40; // (

        97..122: Result := Result - 32;

        91: Result := 123; // {
        93: Result := 125; // }
        92: Result := 124; // |
        47: Result := 63;  // ?
        44: Result := 60;  // <
        46: Result := 62;  // >
        59: Result := 58;  // :
        39: Result := 34;  // "
      end;
    end;
end;

procedure setKey_BeginRepeat(delay: Double);
begin
  beginKeyDelay := delay;
  keyDelayWork := delay;
end;

procedure setKey_Repeat(delay: Double);
begin
  if delay > (beginKeyDelay / 2) then
    repeatKeyDelay := delay
  else
    repeatKeyDelay := beginKeyDelay / 2;
end;

{$IfNDef MOBILE}
{$IfDef USE_VKEYBOARD}
procedure setTimeLockVK(delay: Double);
begin
  timeLockVK := delay;
end;
{$EndIf}{$EndIf}

{$IfDef KEYBOARD_OLD_FUNCTION}
procedure key_InputText(const Text: UTF8String);
  var
    c: AnsiChar;
begin
  if (utf8_Length(keysText) < keysMax) or (keysMax = -1) Then
  begin
    {$IF (not DEFINED(iOS)) and (not DEFINED(ANDROID))}
    if (appFlags and APP_USE_ENGLISH_INPUT > 0) and (Text[1] <> ' ')  Then
    begin
      c := AnsiChar(scancode_to_utf8(keysLast[0]));
      if c <> #0 Then
        keysText := keysText + UTF8String(c);
    end else
    {$ELSE}
    if appFlags and APP_USE_ENGLISH_INPUT > 0  Then
    begin
      if (Length(Text) = 1) and (Byte(Text[1]) < 128) Then
        keysText := keysText + Text;
    end else
    {$IFEND}
      keysText := keysText + Text;
  end;
end;

function _key_GetText: PAnsiChar;
begin
  Result := utf8_GetPAnsiChar(key_GetText());
end;
{$EndIf}

{$IFDEF USE_X11}
// Most of scancodes can be get via simple trick.
function xkey_to_scancode(XKey, KeyCode: Integer): LongWord;
begin
  case XKey of
    XK_Pause:        Result := K_PAUSE;

    XK_Up:           Result := K_UP;
    XK_Down:         Result := K_DOWN;
    XK_Left:         Result := K_LEFT;
    XK_Right:        Result := K_RIGHT;

    XK_Insert:       Result := K_INSERT;
    XK_Delete:       Result := K_DELETE;
    XK_Home:         Result := K_HOME;
    XK_End:          Result := K_END;
    XK_Page_Up:      Result := K_PAGEUP;
    XK_Page_Down:    Result := K_PAGEDOWN;

    XK_Control_R:    Result := K_CTRL_R;
    XK_Alt_R:        Result := K_ALT_R;
    XK_Super_L:      Result := K_SUPER_L;
    XK_Super_R:      Result := K_SUPER_R;
    XK_Menu:         Result := K_APP_MENU;

    XK_KP_Divide:    Result := K_KP_DIV;
    XK_KP_Enter:     Result := K_KP_ENTER;
  else
    Result := (KeyCode - 8) and $FF;
  end;
  if (PkeybFlags^ and keyboardNumLock) > 0 then
  begin
    // сразу избавлюсь от тонны символов
    if (Result >= $47) and (Result <= $53) then
    begin
      case Result of
        K_KP_0:       Result := K_INSERT;
        K_KP_1:       Result := K_END;
        K_KP_2:       Result := K_DOWN;
        K_KP_3:       Result := K_PAGEDOWN;
        K_KP_4:       Result := K_LEFT;
        K_KP_6:       Result := K_RIGHT;
        K_KP_7:       Result := K_HOME;
        K_KP_8:       Result := K_UP;
        K_KP_9:       Result := K_PAGEUP;
        K_KP_DECIMAL: Result := K_DELETE;
      end;
    end;
  end;
end;
{$ENDIF}

{$IFDEF WINDOWS}
function winkey_to_scancode(WinKey: Integer): LongWord;
begin
  case WinKey of
    $26: Result := K_UP;
    $28: Result := K_DOWN;
    $25: Result := K_LEFT;
    $27: Result := K_RIGHT;

    $2D: Result := K_INSERT;
    $2E: Result := K_DELETE;
    $24: Result := K_HOME;
    $23: Result := K_END;
    $21: Result := K_PAGEUP;
    $22: Result := K_PAGEDOWN;
  else
    Result := MapVirtualKey(WinKey, 0);
  end;
end;
{$ENDIF}

{$IFDEF MAC_COCOA}
function mackey_to_scancode(MacKey: Integer): LongWord;
begin
  case MacKey of
    $71: Result := K_PAUSE;
    $35: Result := K_ESCAPE;
    $24: Result := K_ENTER;
    $4C: Result := K_KP_ENTER;

    $7E: Result := K_UP;
    $7D: Result := K_DOWN;
    $7B: Result := K_LEFT;
    $7C: Result := K_RIGHT;

    $33: Result := K_BACKSPACE;
    $31: Result := K_SPACE;
    $30: Result := K_TAB;

    $72: Result := K_INSERT;
    $75: Result := K_DELETE;
    $73: Result := K_HOME;
    $77: Result := K_END;
    $74: Result := K_PAGEUP;
    $79: Result := K_PAGEDOWN;

    $3B: Result := K_CTRL_L;
    $3A: Result := K_ALT_L;
    $38: Result := K_SHIFT_L;
    $37: Result := K_SUPER_L;

    $39: Result := K_CAPSLOCK;
    $47: Result := K_NUMLOCK;
    $6B: Result := K_SCROLL;

    $21: Result := K_BRACKET_L;
    $1E: Result := K_BRACKET_R;
    $2A: Result := K_BACKSLASH;
    $2C: Result := K_SLASH;
    $2B: Result := K_SEPARATOR;
    $2F: Result := K_DECIMAL;
    $29: Result := K_SEMICOLON;
    $27: Result := K_APOSTROPHE; // FIXME: Check!

    $1D: Result := K_0;
    $12: Result := K_1;
    $13: Result := K_2;
    $14: Result := K_3;
    $15: Result := K_4;
    $17: Result := K_5;
    $16: Result := K_6;
    $1A: Result := K_7;
    $1C: Result := K_8;
    $19: Result := K_9;

    $1B: Result := K_MINUS;
    $18: Result := K_EQUALS;

    $00: Result := K_A;
    $0B: Result := K_B;
    $08: Result := K_C;
    $02: Result := K_D;
    $0E: Result := K_E;
    $03: Result := K_F;
    $05: Result := K_G;
    $04: Result := K_H;
    $22: Result := K_I;
    $26: Result := K_J;
    $28: Result := K_K;
    $25: Result := K_L;
    $2E: Result := K_M;
    $2D: Result := K_N;
    $1F: Result := K_O;
    $23: Result := K_P;
    $0C: Result := K_Q;
    $0F: Result := K_R;
    $01: Result := K_S;
    $11: Result := K_T;
    $20: Result := K_U;
    $09: Result := K_V;
    $0D: Result := K_W;
    $07: Result := K_X;
    $10: Result := K_Y;
    $06: Result := K_Z;

    $52: Result := K_KP_0;
    $53: Result := K_KP_1;
    $54: Result := K_KP_2;
    $55: Result := K_KP_3;
    $56: Result := K_KP_4;
    $57: Result := K_KP_5;
    $58: Result := K_KP_6;
    $59: Result := K_KP_7;
    $5B: Result := K_KP_8;
    $5C: Result := K_KP_9;

    $4E: Result := K_KP_SUB;
    $45: Result := K_KP_ADD;
    $43: Result := K_KP_MUL;
    $4B: Result := K_KP_DIV;
    $41: Result := K_KP_DECIMAL;

    $7A: Result := K_F1;
    $78: Result := K_F2;
    $63: Result := K_F3;
    $76: Result := K_F4;
    $60: Result := K_F5;
    $61: Result := K_F6;
    $62: Result := K_F7;
    $64: Result := K_F8;
    $65: Result := K_F9;
    $6D: Result := K_F10;
    $67: Result := K_F11;
    $6F: Result := K_F12;
  end;
end;
{$ENDIF}

{$IFDEF iOS}
// Good bye standard EditBox... :)
function zglCiOSTextField.textRectForBounds(bounds_: CGRect): CGRect;
begin
  Result := CGRectMake(0, 4096, 0, 0);
end;

function zglCiOSTextField.editingRectForBounds(bounds_: CGRect): CGRect;
begin
  Result := CGRectMake(0, 4096, 0, 0);
end;
{$ENDIF}

initialization
  PkeybFlags^ := 0;


end.
