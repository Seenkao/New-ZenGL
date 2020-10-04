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
}
unit zgl_joystick;

{$I zgl_config.cfg}

interface
{$IFDEF UNIX}
uses
  BaseUnix;
type
  js_event = record
    time  : LongWord; // event timestamp in milliseconds
    value : SmallInt; // value
    _type : Byte;     // event type
    number: Byte;     // axis/button number
  end;

const
  ABS_MAX = $3F;

  JS_EVENT_BUTTON = $01; // button pressed/released
  JS_EVENT_AXIS   = $02; // joystick moved
  JS_EVENT_INIT   = $80; // initial state of device

  JSIOCGNAME    = -2142213613;
  JSIOCGAXMAP   = -2143262158;
  JSIOCGAXES    = -2147390959;
  JSIOCGBUTTONS = -2147390958;
{$ENDIF}
{$IFDEF WINDOWS}
  type
    PJOYCAPSW = ^TJOYCAPSW;
    TJOYCAPSW = packed record
      wMid: Word;
      wPid: Word;
      szPname: array[0..31] of WideChar;
      wXmin: LongWord;
      wXmax: LongWord;
      wYmin: LongWord;
      wYmax: LongWord;
      wZmin: LongWord;
      wZmax: LongWord;
      wNumButtons: LongWord;
      wPeriodMin: LongWord;
      wPeriodMax: LongWord;
      wRmin: LongWord;
      wRmax: LongWord;
      wUmin: LongWord;
      wUmax: LongWord;
      wVmin: LongWord;
      wVmax: LongWord;
      wCaps: LongWord;
      wMaxAxes: LongWord;
      wNumAxes: LongWord;
      wMaxButtons: LongWord;
      szRegKey: array[0..31] of WideChar;
      szOEMVxD: array[0..259] of WideChar;
  end;

  type
    PJOYINFOEX = ^TJOYINFOEX;
    TJOYINFOEX = packed record
      dwSize: LongWord;
      dwFlags: LongWord;
      wXpos: LongWord;
      wYpos: LongWord;
      wZpos: LongWord;
      dwRpos: LongWord;
      dwUpos: LongWord;
      dwVpos: LongWord;
      wButtons: LongWord;
      dwButtonNumber: LongWord;
      dwPOV: LongWord;
      dwReserved1: LongWord;
      dwReserved2: LongWord;
    end;

const
  JOY_POVCENTERED    = -1;
  JOY_POVFORWARD     = 0;
  JOY_POVRIGHT       = 9000;
  JOY_POVBACKWARD    = 18000;
  JOY_POVLEFT        = 27000;
  JOY_RETURNX        = 1;
  JOY_RETURNY        = 2;
  JOY_RETURNZ        = 4;
  JOY_RETURNR        = 8;
  JOY_RETURNU        = 16;
  JOY_RETURNV        = 32;
  JOY_RETURNPOV      = 64;
  JOY_RETURNBUTTONS  = 128;
  JOY_RETURNRAWDATA  = 256;
  JOY_RETURNPOVCTS   = 512;
  JOY_RETURNCENTERED = $400;
  JOY_USEDEADZONE    = $800;
  JOY_RETURNALL      = (JOY_RETURNX or JOY_RETURNY or JOY_RETURNZ or JOY_RETURNR or JOY_RETURNU or JOY_RETURNV or JOY_RETURNPOV or JOY_RETURNBUTTONS);

  JOYCAPS_HASZ    = 1;
  JOYCAPS_HASR    = 2;
  JOYCAPS_HASU    = 4;
  JOYCAPS_HASV    = 8;
  JOYCAPS_HASPOV  = 16;
  JOYCAPS_POV4DIR = 32;
  JOYCAPS_POVCTS  = 64;

  function joyGetNumDevs: LongWord; stdcall; external 'winmm.dll' name 'joyGetNumDevs';
  function joyGetDevCapsW(uJoyID: LongWord; lpCaps: PJOYCAPSW; uSize: LongWord): LongWord; stdcall; external 'winmm.dll' name 'joyGetDevCapsW';
  function joyGetPosEx(uJoyID: LongWord; lpInfo: PJOYINFOEX): LongWord; stdcall; external 'winmm.dll' name 'joyGetPosEx';
{$ENDIF}

type
  zglPJoyInfo = ^zglTJoyInfo;
  zglTJoyInfo = record
    Name  : UTF8String;
    Count : record
      Axes   : Integer;
      Buttons: Integer;
             end;
    Caps  : LongWord;
  end;

type
  zglPJoyState = ^zglTJoyState;
  zglTJoyState = record
    Axis       : array[0..7] of Single;
    BtnUp      : array[0..31] of Boolean;
    BtnDown    : array[0..31] of Boolean;
    BtnPress   : array[0..31] of Boolean;
    BtnCanPress: array[0..31] of Boolean;
  end;

type
  zglPJoy = ^zglTJoy;
  zglTJoy = record
    {$IFDEF UNIX}
    device : LongInt;
    axesMap: array[0..ABS_MAX - 1] of Byte;
    {$ENDIF}
    {$IFDEF WINDOWS}
    caps   : TJOYCAPSW;
    axesMap: array[0..5] of Byte;
    {$ENDIF}
    Info   : zglTJoyInfo;
    State  : zglTJoyState;
  end;

const
  JOY_HAS_Z   = $000001;
  JOY_HAS_R   = $000002;
  JOY_HAS_U   = $000004;
  JOY_HAS_V   = $000008;
  JOY_HAS_POV = $000010;

  JOY_AXIS_X = 0;
  JOY_AXIS_Y = 1;
  JOY_AXIS_Z = 2;
  JOY_AXIS_R = 3;
  JOY_AXIS_U = 4;
  JOY_AXIS_V = 5;
  JOY_POVX   = 6;
  JOY_POVY   = 7;

{$IFDEF UNIX}
  JS_AXIS: array[0..17] of Byte = (JOY_AXIS_X, JOY_AXIS_Y, JOY_AXIS_Z, JOY_AXIS_U, JOY_AXIS_V, JOY_AXIS_R, JOY_AXIS_Z, JOY_AXIS_R, 0, 0, 0, 0, 0, 0, 0, 0, JOY_POVX, JOY_POVY);
{$ENDIF}
{$IFDEF WINDOWS}
  JS_AXIS: array[0..5] of LongWord = (17 {X}, 19 {Y}, 21 {Z}, 26 {R}, 28 {U}, 30 {V});
{$ENDIF}

function  joy_Init: Byte;
procedure joy_Close;
procedure joy_Proc;
function  joy_GetInfo(JoyID: Byte): zglPJoyInfo;
function  joy_AxisPos(JoyID, Axis: Byte): Single;
function  joy_Down(JoyID, Button: Byte): Boolean;
function  joy_Up(JoyID, Button: Byte): Boolean;
function  joy_Press(JoyID, Button: Byte): Boolean;
procedure joy_ClearState;

implementation
uses
  zgl_file,
  zgl_log,
  zgl_math_2d,
  zgl_utils;

var
  joyArray: array[0..15] of zglTJoy;
  joyCount: Integer;

function joy_Init: Byte;
  var
    i, j: Integer;
  {$IFDEF WINDOWS}
    axis: Integer;
    caps: PLongWord;
  {$ENDIF}
begin
  joyCount := 0;

{$IFDEF UNIX}
  for i := 0 to 15 do
    begin
      joyArray[joyCount].device := FpOpen('/dev/input/js' + u_IntToStr(i), O_RDONLY or O_NONBLOCK);
      if joyArray[joyCount].device = FILE_ERROR Then
        joyArray[joyCount].device := FpOpen('/dev/js' + u_IntToStr(i), O_RDONLY or O_NONBLOCK);

      if joyArray[joyCount].device <> FILE_ERROR Then
        begin
          SetLength(joyArray[joyCount].Info.Name, 256);
          FpIOCtl(joyArray[joyCount].device, JSIOCGNAME,    @joyArray[joyCount].Info.Name[1]);
          FpIOCtl(joyArray[joyCount].device, JSIOCGAXMAP,   @joyArray[joyCount].axesMap[0]);
          FpIOCtl(joyArray[joyCount].device, JSIOCGAXES,    @joyArray[joyCount].Info.Count.Axes);
          FpIOCtl(joyArray[joyCount].device, JSIOCGBUTTONS, @joyArray[joyCount].Info.Count.Buttons);

          for j := 0 to joyArray[joyCount].Info.Count.Axes - 1 do
            with joyArray[joyCount].Info do
              case joyArray[joyCount].axesMap[j] of
                2, 6:   Caps := Caps or JOY_HAS_Z;
                5, 7:   Caps := Caps or JOY_HAS_R;
                3:      Caps := Caps or JOY_HAS_U;
                4:      Caps := Caps or JOY_HAS_V;
                16, 17: Caps := Caps or JOY_HAS_POV;
              end;

          for j := 1 to 255 do
            if joyArray[joyCount].Info.Name[j] = #0 Then
              begin
                SetLength(joyArray[joyCount].Info.Name, j - 1);
                break;
              end;

          // Checking if joystick is a real one, because laptops with accelerometer can be detected as a joystick :)
          if (joyArray[joyCount].Info.Count.Axes >= 2) and (joyArray[joyCount].Info.Count.Buttons > 0) Then
            begin
              log_Add('Joy: Find "' + joyArray[joyCount].Info.Name + '" (ID: ' + u_IntToStr(joyCount) +
                       '; Axes: ' + u_IntToStr(joyArray[joyCount].Info.Count.Axes) +
                       '; Buttons: ' + u_IntToStr(joyArray[joyCount].Info.Count.Buttons) + ')');

              INC(joyCount);
            end;
        end else
          break;
    end;
{$ENDIF}
{$IFDEF WINDOWS}
  j := joyGetNumDevs();
  for i := 0 to j - 1 do
    if joyGetDevCapsW(i, @joyArray[i].caps, SizeOf(TJOYCAPSW)) = 0 Then
      begin
        joyArray[i].Info.Name          := utf16_GetUTF8String(joyArray[i].caps.szPname);
        joyArray[i].Info.Count.Axes    := joyArray[i].caps.wNumAxes;
        joyArray[i].Info.Count.Buttons := joyArray[i].caps.wNumButtons;

        caps  := @joyArray[i].Info.Caps;
        joyArray[i].axesMap[0] := JOY_AXIS_X;
        joyArray[i].axesMap[1] := JOY_AXIS_Y;
        axis := 2;
        if joyArray[i].caps.wCaps and JOYCAPS_HASZ > 0 Then
          begin
            caps^ := caps^ or JOY_HAS_Z;
            joyArray[i].axesMap[axis] := JOY_AXIS_Z;
            INC(axis);
          end;
        if joyArray[i].caps.wCaps and JOYCAPS_HASR > 0 Then
          begin
            caps^ := caps^ or JOY_HAS_R;
            joyArray[i].axesMap[axis] := JOY_AXIS_R;
            INC(axis);
          end;
        if joyArray[i].caps.wCaps and JOYCAPS_HASU > 0 Then
          begin
            caps^ := caps^ or JOY_HAS_U;
            joyArray[i].axesMap[axis] := JOY_AXIS_U;
            INC(axis);
          end;
        if joyArray[i].caps.wCaps and JOYCAPS_HASV > 0 Then
          begin
            caps^ := caps^ or JOY_HAS_V;
            joyArray[i].axesMap[axis] := JOY_AXIS_V;
            //INC(axis);
          end;
        if joyArray[i].caps.wCaps and JOYCAPS_HASPOV > 0 Then
          begin
            caps^ := caps^ or JOY_HAS_POV;
            INC(joyArray[i].Info.Count.Axes, 2);
          end;

        log_Add('Joy: Find "' + joyArray[i].Info.Name + '" (ID: ' + u_IntToStr(i) +
                 '; Axes: ' + u_IntToStr(joyArray[i].Info.Count.Axes) +
                 '; Buttons: ' + u_IntToStr(joyArray[i].Info.Count.Buttons) + ')');

        INC(joyCount);
      end else
        break;
{$ENDIF}

  Result := joyCount;
  if Result = 0 Then
    log_Add('Joy: Couldn''t find joysticks');
end;

procedure joy_Close;
  {$IFDEF UNIX}
  var
    i: Integer;
  {$ENDIF}
begin
  {$IFDEF UNIX}
  for i := 0 to joyCount - 1 do
    FpClose(joyArray[i].device);
  {$ENDIF}
end;

procedure joy_Proc;
  var
    i: Integer;
  {$IFDEF UNIX}
    event: js_event;
  {$ENDIF}
  {$IFDEF WINDOWS}
    j, a : Integer;
    btn  : Integer;
    state: TJOYINFOEX;
    pcaps: PLongWord;
    value: PLongWord;
    vMin : LongWord;
    vMax : LongWord;
  {$ENDIF}
begin
  if joyCount = 0 Then exit;

{$IFDEF UNIX}
  for i := 0 to joyCount - 1 do
    begin
      while FpRead(joyArray[i].device, event, 8) = 8 do
        case event._type of
          JS_EVENT_AXIS:
            begin
              joyArray[i].State.Axis[JS_AXIS[joyArray[i].axesMap[event.number]]] := Round((event.value / 32767) * 1000) / 1000;
            end;
          JS_EVENT_BUTTON:
            case event.value of
              0:
                begin
                  if joyArray[i].State.BtnDown[event.number] Then
                    joyArray[i].State.BtnUp[event.number] := TRUE;

                  joyArray[i].State.BtnDown[event.number] := FALSE;
                end;
              1:
                begin
                  joyArray[i].State.BtnDown[event.number] := TRUE;
                  joyArray[i].State.BtnUp  [event.number] := FALSE;
                  if joyArray[i].State.BtnCanPress[event.number] Then
                    begin
                      joyArray[i].State.BtnPress   [event.number] := TRUE;
                      joyArray[i].State.BtnCanPress[event.number] := FALSE;
                    end;
                end;
            end;
        end;
    end;
{$ENDIF}
{$IFDEF WINDOWS}
  state.dwSize := SizeOf(TJOYINFOEX);
  for i := 0 to joyCount - 1 do
    begin
      state.dwFlags := JOY_RETURNALL or JOY_USEDEADZONE;
      if joyArray[i].caps.wCaps and JOYCAPS_POVCTS > 0 Then
        state.dwFlags := state.dwFlags or JOY_RETURNPOVCTS;

      if joyGetPosEx(i, @state) = 0 Then
        begin
          for j := 0 to joyArray[i].Info.Count.Axes - 1 do
            begin
              // Say "no" to if's, and do everything trciky :)
              a     := joyArray[i].axesMap[j];
              pcaps := @joyArray[i].caps;
              INC(pcaps, JS_AXIS[a]);
              vMin  := pcaps^;
              INC(pcaps);
              vMax  := pcaps^;
              value := @state;
              INC(value, 2 + a);

              joyArray[i].State.Axis[a] := Round((value^ / (vMax - vMin) * 2 - 1) * 1000) / 1000;
            end;

          FillChar(joyArray[i].State.Axis[JOY_POVX], 8, 0);
          if (joyArray[i].Info.Caps and JOY_HAS_POV > 0) and (state.dwPOV and $FFFF <> $FFFF)Then
            begin
              joyArray[i].State.Axis[JOY_POVX] := Round(m_Sin(state.dwPOV and $FFFF div 100));
              joyArray[i].State.Axis[JOY_POVY] := -Round(m_Cos(state.dwPOV and $FFFF div 100));
            end;

          for j := 0 to joyArray[i].Info.Count.Buttons - 1 do
            begin
              btn := state.wButtons and (1 shl j);
              if (joyArray[i].State.BtnDown[j]) and (btn = 0) Then
                joyArray[i].State.BtnUp[j] := TRUE;

              if (joyArray[i].State.BtnCanPress[j]) and (not joyArray[i].State.BtnDown[j]) and (btn <> 0) Then
                begin
                  joyArray[i].State.BtnPress   [j] := TRUE;
                  joyArray[i].State.BtnCanPress[j] := FALSE;
                end;
              joyArray[i].State.BtnDown[j] := btn <> 0;
            end;
        end;
    end;
{$ENDIF}
end;

function joy_GetInfo(JoyID: Byte): zglPJoyInfo;
begin
  Result := nil;
  if JoyID >= joyCount Then exit;

  Result := @joyArray[JoyID].Info;
end;

function joy_AxisPos(JoyID, Axis: Byte): Single;
begin
  Result := 0;
  if (JoyID >= joyCount) or (Axis > 7) Then exit;

  Result := joyArray[JoyID].State.Axis[Axis];
end;

function joy_Down(JoyID, Button: Byte): Boolean;
begin
  Result := FALSE;
  if (JoyID >= joyCount) or (Button >= joyArray[JoyID].Info.Count.Buttons) Then exit;

  Result := joyArray[JoyID].State.BtnDown[Button];
end;

function joy_Up(JoyID, Button: Byte): Boolean;
begin
  Result := FALSE;
  if (JoyID >= joyCount) or (Button >= joyArray[JoyID].Info.Count.Buttons) Then exit;

  Result := joyArray[JoyID].State.BtnUp[Button];
end;

function joy_Press(JoyID, Button: Byte): Boolean;
begin
  Result := FALSE;
  if (JoyID >= joyCount) or (Button >= joyArray[JoyID].Info.Count.Buttons) Then exit;

  Result := joyArray[JoyID].State.BtnPress[Button];
end;

procedure joy_ClearState;
  var
    i, j : Integer;
    state: zglPJoyState;
begin
  for i := 0 to joyCount - 1 do
    for j := 0 to joyArray[i].Info.Count.Buttons - 1 do
      begin
        state := @joyArray[i].State;
        state.BtnUp[j]       := FALSE;
        state.BtnPress[j]    := FALSE;
        state.BtnCanPress[j] := TRUE;
      end;
end;

initialization

finalization
  joy_Close();

end.
