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
unit zgl_touch;

{$I zgl_config.cfg}

interface

const
  MAX_TOUCH = 16;

function touch_X(Finger: Byte): Integer;
function touch_Y(Finger: Byte): Integer;
function touch_Down(Finger: Byte): Boolean;
function touch_Up(Finger: Byte): Boolean;
function touch_Tap(Finger: Byte): Boolean;
procedure touch_ClearState;

var
  touchX     : array[0..MAX_TOUCH - 1] of Integer;
  touchY     : array[0..MAX_TOUCH - 1] of Integer;
  touchDown  : array[0..MAX_TOUCH - 1] of Boolean;
  touchUp    : array[0..MAX_TOUCH - 1] of Boolean;
  touchTap   : array[0..MAX_TOUCH - 1] of Boolean;
  touchCanTap: array[0..MAX_TOUCH - 1] of Boolean;
  touchActive: array[0..MAX_TOUCH - 1] of Boolean;

implementation

function touch_X(Finger: Byte): Integer;
begin
  if Finger > MAX_TOUCH - 1 Then
    Result := -1
  else
    Result := touchX[Finger];
end;

function touch_Y(Finger: Byte): Integer;
begin
  if Finger > MAX_TOUCH - 1 Then
    Result := -1
  else
    Result := touchY[Finger];
end;

function touch_Down(Finger: Byte): Boolean;
begin
  if Finger > MAX_TOUCH - 1 Then
    Result := FALSE
  else
    Result := touchDown[Finger];
end;

function touch_Up(Finger: Byte): Boolean;
begin
  if Finger > MAX_TOUCH - 1 Then
    Result := FALSE
  else
    Result := touchUp[Finger];
end;

function touch_Tap(Finger: Byte): Boolean;
begin
  if Finger > MAX_TOUCH - 1 Then
    Result := FALSE
  else
    Result := touchTap[Finger];
end;

procedure touch_ClearState;
begin
  FillChar(touchUp[0], MAX_TOUCH, 0);
  FillChar(touchTap[0], MAX_TOUCH, 0);
  FillChar(touchCanTap[0], MAX_TOUCH, 1);
end;

end.
