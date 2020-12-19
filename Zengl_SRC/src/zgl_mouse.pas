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

 !!! modification from Serge 04.08.2020
}
unit zgl_mouse;

{$I zgl_config.cfg}

interface
{$IFDEF USE_X11}
  uses X, XLib;
{$ENDIF}
{$IFDEF WINDOWS}
  uses Windows;
{$ENDIF}
{$IFDEF MACOSX}
  uses MacOSAll;
{$ENDIF}

const
  M_BLEFT_DOWN        =  1;
  M_BMIDDLE_DOWN      =  2;
  M_BRIGHT_DOWN       =  4;
  M_BLEFT_UP          =  8;
  M_BMIDDLE_UP        = 16;
  M_BRIGHT_UP         = 32;

  M_BLEFT_CLICK       =  1;
  M_BMIDDLE_CLICK     =  2;
  M_BRIGHT_CLICK      =  4;
  M_BLEFT_CANCLICK    =  8;
  M_BMIDDLE_CANCLICK  = 16;
  M_BRIGHT_CANCLICK   = 32;

  M_BLEFT_DBLCLICK    =  1;
  M_BMIDDLE_DBLCLICK  =  2;
  M_BRIGHT_DBLCLICK   =  4;
  M_WHEEL_UP          =  8;
  M_WHEEL_DOWN        = 16;

  M_BLEFT   = 0;
  M_BMIDDLE = 1;
  M_BRIGHT  = 2;

{$IfDef LIBRARY_COMPILE}
function mouse_X : Integer;
function mouse_Y : Integer;
function mouse_DX : Integer;
function mouse_DY : Integer;
{$EndIf}

function mBUpDown(action: Byte): Boolean;
function mBClickCanClick(action: Byte): Boolean;
function mBDblClickWheel(action: Byte): Boolean;
procedure mouse_ClearState;
{$IfNDef ANDROID}
{$IfNDef iOS}
procedure mouse_Lock(X: Integer = -1; Y: Integer = -1);
{$EndIf}
{$EndIf}

var
  mouseX       : Integer;
  mouseY       : Integer;
  mouseDX      : Integer;
  mouseDY      : Integer;
  mouseLX      : Integer;
  mouseLY      : Integer;

  mouseUpDown, mouseClickCanClick, mouseDblClickWheel: Byte;

  mouseDblCTime: array[0..2] of Double;
  mouseDblCInt : Integer = 250;
  mouseLock    : Boolean;

implementation
uses
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

function mouse_DX : Integer;
begin
  Result := mouseDX;
end;

function mouse_DY : Integer;
begin
  Result := mouseDY;
end;
{$EndIf}

function mBUpDown(action: Byte): Boolean;
begin
    Result := (action and mouseUpDown) > 0;
end;

function mBClickCanClick(action: Byte): Boolean;
begin
    Result := (action and mouseClickCanClick) > 0;
end;

function mBDblClickWheel(action: Byte): Boolean;
begin
    Result := (action and mouseDblClickWheel) > 0;
end;

procedure mouse_ClearState;
begin
  mouseClickCanClick := 0;
  mouseDblClickWheel := 0;
end;

{$IfNDef ANDROID}
{$IfNDef iOS}
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
{$ENDIF}
{$ENDIF}

end.
