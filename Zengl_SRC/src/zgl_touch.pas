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

 !!! modification from Serge 02.05.2022
}
unit zgl_touch;

{$I zgl_config.cfg}

interface

uses
  zgl_types;

// Ru: возвращаем координату "X" для данного касания!!!
// En: return coordinates "X" for this touch !!!
function touch_X(ID: Byte): Integer;
// Ru: возвращаем координату "Y" для данного касания!!!
// En: return coordinates "Y" for this touch !!!
function touch_Y(ID: Byte): Integer;
// Ru: возвращаем координаты "X", "Y" для данного касания!!!
// En: return coordinates "X", "Y" for this touch !!!
function touch_XY(ID: Byte): zglTPoint2D;
{$IfDef LIBRARY_COMPILE}
// Ru: возвращаем состояние нажатия в данный момент. Для эмуляции мыши можно
//     использовать константы M_BLEFT и M_BRIGHT.
// En: we return the state of pressing at the moment. To emulate a mouse, you
//     can use the constants M_BLEFT and M_BRIGHT.
function touch_Click(ID: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем состояние отжатия в данный момент. Для эмуляции мыши можно
//     использовать константы M_BLEFT и M_BRIGHT.
// En: we return the state of the release at the moment. To emulate a mouse, you
//     can use the constants M_BLEFT and M_BRIGHT.
function touch_Up(ID: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем состояние удержания (постоянное удержание). Для эмуляции мыши
//     можно использовать константы M_BLEFT и M_BRIGHT.
// En: we return the hold state (constant hold). To emulate a mouse, you
//     can use the constants M_BLEFT and M_BRIGHT.
function touch_Tap(ID: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем состояние двойного клика. Для эмуляции мыши можно
//     использовать константы M_BLEFT и M_BRIGHT.
// En: return the double-click state. To emulate a mouse, you
//     can use the constants M_BLEFT and M_BRIGHT.
function touch_DoubleClick(ID: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
// Ru: возвращаем состояние тройного клика.
// En: we return the state of the triple click.
function touch_TripleClick(ID: Byte): Boolean; {$IfDef USE_INLINE}inline;{$EndIf}
{$EndIf}
// Ru: очистка всех нажатий.
// En: clearing all clicks.
procedure touch_ClearState; {$IfDef USE_INLINE}inline;{$EndIf}

var
  // Rus: состояния всех клавиш.
  // Eng: the states of all keys.
  Mobile_Touch: array[0..MAX_TOUCH - 1] of m_touch;
  // Rus: какой из тапов первым попал на клавиатуру. 255 - ни какой.
  // Eng:
  firstTapKey: LongWord = is_notTouch;

implementation

{$IfDef FULL_LOGGING}
uses
  zgl_log;
{$EndIf}

function touch_X(ID: Byte): Integer;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_X!');
    Result := - 1;
    Exit;
  end;
  {$EndIf}
  if (ID > MAX_TOUCH - 1) or ((Mobile_Touch[ID].state and is_Press) = 0) then
    Result := - 1
  else
    Result := Mobile_Touch[ID].newX;
end;

function touch_Y(ID: Byte): Integer;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_Y!');
    Result := - 1;
    Exit;
  end;
  {$EndIf}
  if (ID > MAX_TOUCH - 1) or ((Mobile_Touch[ID].state and is_Press) = 0) then
    Result := - 1
  else
    Result := Mobile_Touch[ID].newY;
end;

function touch_XY(ID: Byte): zglTPoint2D;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_XY!');
    Result.X := - 1;
    Result.Y := - 1;
    Exit;
  end;
  {$EndIf}
  if (ID > MAX_TOUCH - 1) or ((Mobile_Touch[ID].state and is_Press) = 0) then
  begin
    Result.X := - 1;
    Result.Y := - 1;
  end
  else begin
    Result.Y := Mobile_Touch[ID].newY;
    Result.X := Mobile_Touch[ID].newX;
  end;
end;

{$IfDef LIBRARY_COMPILE}
function touch_Click(ID: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_Down!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if ((Mobile_Touch[ID].state and is_down) > 0) then
    Result := True
  else
    Result := False;
end;

function touch_Up(ID: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_Up!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if ((Mobile_Touch[ID].state and is_up) > 0) then
    Result := True
  else
    Result := False;
end;

function touch_Tap(ID: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_Tap!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if ((Mobile_Touch[ID].state and is_Press) > 0) then
    Result := True
  else
    Result := False;
end;

function touch_DoubleClick(ID: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_DoubleTap!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if ((Mobile_Touch[ID].state and is_DoubleDown) > 0) then
    Result := True
  else
    Result := False;
end;
{$EndIf}

function touch_TripleClick(ID: Byte): Boolean;
begin
  {$IfDef FULL_LOGGING}
  if ID > 9 then
  begin
    log_Add('Error! ID out of range in touch_DoubleTap!');
    Result := False;
    Exit;
  end;
  {$EndIf}
  if ((Mobile_Touch[ID].state and is_TripleDown) > 0) then
    Result := True
  else
    Result := False;
end;

procedure touch_ClearState;
var
  i: LongWord;
  ps: Pm_touch;
begin
  ps := @Mobile_Touch[0];
  for i := 0 to MAX_TOUCH - 1 do
  begin
    ps^.state := ps^.state and (is_Press or is_canPress);
    inc(ps);
  end;
  ps := nil;
end;

end.
