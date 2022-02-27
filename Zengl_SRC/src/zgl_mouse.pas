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

 !!! modification from Serge 21.09.2021
}
unit zgl_mouse;

{$I zgl_config.cfg}

interface

uses
{$IFDEF USE_X11}
  X, XLib,
{$ENDIF}
{$IFDEF WINDOWS}
  Windows,
{$ENDIF}
{$IFDEF MACOSX}
  MacOSAll,
{$ENDIF}
  sysutils,
  zgl_types;

{$IfDef LIBRARY_COMPILE}
// Ru: возвращаем координату "X".
// En: return the "X" coordinate.
function mouse_X : Integer; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем координату "Y".
// En: return the "Y" coordinate.
function mouse_Y : Integer; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем координаты "X", "Y".
// En: return coordinates "X", "Y".
function mouse_XY : zglTPoint2D; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем "DX" (дельта X).
// En: return "DX" (delta X).
function mouse_DX : Integer; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем "DY" (дельта Y).
// En: return "DY" (delta Y).
function mouse_DY : Integer; {$IfDef USE_INLINE}inline;{$EndIf}

//    Ru: состояния: Button = M_BLEFT или M_BMIDDLE или M_BRIGHT.
//    En: states: Button = M_BLEFT or M_BMIDDLE or M_BRIGHT.

// Ru: обработка клавиш мыши на нажатие.
// En: processing of mouse keys on pressing.
function mouseBDown(Button: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: обработка клавиш мыши на отжатие. (по сути бесполезная функция, если не нажата клавиша, то по умолчанию отпущена).
// En: processing of mouse keys for releasing.
function mouseBUp(Button: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: обработка клавиш мыши на клик.
// En: handling mouse keys per click.
function mouseBClick(Button: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: обработка клавиш мыши на двойной клик.
// En: processing of mouse keys on a double click.
function mouseBDblClick(Button: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: обработка клавишь мыши на отклик.
// En: processing of mouse keys on the response.
function mouseBCanClick(Button: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: обработка работы ролика мыши.
// En: processing of the operation of the mouse roller.
function mouseWheelUp: Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
function mouseWheelDown: Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
{$EndIf}
// Ru: очистка состояний мыши. Вызывать не нужно, производится автоматически.
// En: clearing mouse states. You do not need to call, it is done automatically.
procedure mouse_ClearState; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: блокирование координат мыши.
// En: locking mouse coordinates.
procedure mouse_Lock(X: Integer = -1; Y: Integer = -1);

var
  mouseX       : Integer;
  mouseY       : Integer;
  mouseDX      : Integer;
  mouseDY      : Integer;

//  mouseUpDown, mouseClickCanClick, mouseDblClickWheel: Byte;
  // три кнопки, с событиями, и у каждой кнопки споя задержка времени
  mouseAction: array[0..2] of km_Button;

//  mouseDblCTime: array[0..2] of Double;
  mouseDblCInt : Integer = 250;
  mouseLock    : Boolean;
  {$IfDef MAC_COCOA}
  gMouseX, gMouseY: Integer;
  {$EndIf}
  {$IfDef USE_VKEYBOARD}
  // события отвечающее за клавиатуру, если их нет, то виртуальная клавиатура будет "залипать"
  // это же нужно и для тачпада
  mouseLastVKey: array[0..3] of Byte;
  {$EndIf}

implementation
uses
  {$IfDef FULL_LOGGING}
  zgl_log,
  {$EndIf}
  zgl_window,
  zgl_screen;

{$IfDef LIBRARY_COMPILE}
function mouse_X : Integer;
begin
  Result := mouseX;
end;

function mouse_Y : Integer;
begin
  Result := mouseY;
end;

function mouse_XY: zglTPoint2D;
begin
  Result.X := mouseX;
  Result.Y := mouseY;
end;

function mouse_DX : Integer;
begin
  Result := mouseDX;
end;

function mouse_DY : Integer;
begin
  Result := mouseDY;
end;

function mouseBDown(Button: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if Button > 2 then
  begin
    log_Add('Error! Out of range in mouseBDown!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if (mouseAction[Button].state and is_Press) > 0 then
    Result := true
  else
    Result := False;
end;

function mouseBUp(Button: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if Button > 2 then
  begin
    log_Add('Error! Out of range in mouseBUp!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if (mouseAction[Button].state and is_canPress) > 0 then
    Result := true
  else
    Result := False;
end;

function mouseBClick(Button: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if Button > 2 then
  begin
    log_Add('Error! Out of range in mouseBClick!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if (mouseAction[Button].state and is_down) > 0 then
    Result := true
  else
    Result := False;
end;

function mouseBDblClick(Button: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if Button > 2 then
  begin
    log_Add('Error! Out of range in mouseBClick!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if (mouseAction[Button].state and is_DoubleDown) > 0 then
    Result := true
  else
    Result := False;
end;

function mouseBCanClick(Button: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if Button > 2 then
  begin
    log_Add('Error! Out of range in mouseBCanClick!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if (mouseAction[Button].state and is_up) > 0 then
    Result := true
  else
    Result := False;
end;

function mouseWheelUp: Boolean;
begin
  if (mouseAction[M_BMIDDLE].state and is_mWheelUp) > 0 then
    Result := true
  else
    Result := False;
end;

function mouseWheelDown: Boolean;
begin
  if (mouseAction[M_BMIDDLE].state and is_mWheelDown) > 0 then
    Result := true
  else
    Result := False;
end;
{$EndIf}

procedure mouse_ClearState;
begin
  mouseAction[M_BLEFT].state := mouseAction[M_BLEFT].state and (is_canPress or is_Press);
  mouseAction[M_BMIDDLE].state := mouseAction[M_BMIDDLE].state and (is_canPress or is_Press);
  mouseAction[M_BRIGHT].state := mouseAction[M_BRIGHT].state and (is_canPress or is_Press);
end;

procedure mouse_Lock(X: Integer = -1; Y: Integer = -1);
  {$IFDEF MACOSX}
  var
    Point: CGPoint;
  {$ENDIF}
begin
{$IFDEF USE_X11}
  if (X = -1) and (Y = -1) Then
  begin
    X := wndWidth div 2;
    Y := wndHeight div 2;
  end;

  XWarpPointer(scrDisplay, None, wndHandle, 0, 0, 0, 0, X, Y);
{$ENDIF}
{$IFDEF WINDOWS}
  if (X = -1) and (Y = -1) Then
  begin
    if wndFullScreen Then
    begin
      X := wndWidth div 2;
      Y := wndHeight div 2;
    end else
    begin
      X := wndX + wndBrdSizeX + wndWidth div 2;
      Y := wndY + wndBrdSizeY + wndCpnSize + wndHeight div 2;
    end;
  end else
  begin
    X := wndX + X;
    Y := wndY + Y;
  end;

  SetCursorPos(X, Y);
{$ENDIF}
{$IFDEF MACOSX}
  if (X = -1) and (Y = -1) Then
  begin
    Point.X := wndX + wndWidth / 2;
    Point.Y := wndY + wndHeight / 2;
  end else
  begin
    Point.X := wndX + X;
    Point.Y := wndY + Y;
  end;
  CGWarpMouseCursorPosition(Point);
{$ENDIF}
end;

end.
