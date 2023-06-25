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
unit gegl_draw_gui;

{$I zgl_config.cfg}

interface

uses
  zgl_textures_png,
  zgl_utils,
  zgl_render_2d,
  zgl_types;

var
  // Rus: шрифт по умолчанию для клавиатуры.
  // Eng; the default font for the keyboard.
  fontUse: LongWord;
  JoyArrow: zglPTexture;

  MenuRed: array[0..2] of Single    = ($AF / 255, $7F / 255, $7F / 255);
  MenuGreen: array[0..2] of Single  = ($AF / 255, $1F / 255, $7F / 255);
  MenuBlue: array[0..2] of Single   = ($AF / 255, $5F / 255, $7F / 255);
  MenuAlpha: array[0..2] of Single  = (224 / 255, 224 / 255, 224 / 255);
  CircleRed: array[0..2] of Single    = (1, 1, 1);
  CircleGreen: array[0..2] of Single  = (0, 1, 1);
  CircleBlue: array[0..2] of Single   = (0, 1, 128 / 255);
  CircleAlpha: array[0..2] of Single  = (192 / 255, 192 / 255, 192 / 255);

  MenuColorText: Cardinal = $000000B0;

procedure DrawCircle(x, y, R: Single);
procedure DrawButton(x, y, w, h: Single; numColor: LongWord);
procedure DrawGameJoy01;
procedure DrawGameJoy02;
procedure DrawTouchKeyboard;
procedure DrawTouchSymbol;

implementation

uses
  zgl_text,
  zgl_font,
  gegl_menu_gui,
  zgl_sprite_2d,
  zgl_keyboard,
  zgl_fx,
  zgl_log,
  zgl_gltypeconst,
  {$IFNDEF USE_GLES}
  zgl_opengl_all
  {$ELSE}
  zgl_opengles_all
  {$ENDIF}
  ;

{$IfDef LINUX}
var
  rs0:   Single = 0;
  rs05:  Single = 0.5;
  rs1:   Single = 1;
  rs1_5: Single = 1.5;
  rs2:   Single = 2;
  rs3:   Single = 3;
  rs5:   Single = 5;
  rs10:  Single = 10;
  rs16:  Single = 16;
  rs90:  Single = 90;
  rs270: Single = 270;
{$EndIf}

procedure DrawCircle(x, y, R: Single);
var
  dx, dy, dx_05add, dx_05sub, dy_05add, dy_05sub: single;
  n: LongWord;
begin
  dx := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  dy := R;
  n := 0;
  while dy >= 0 do
  begin
    if (n and 1) > 0 then
    begin
      dy := dy - {$IfDef LINUX}rs1{$Else}1{$EndIf};
      dx := sqrt(sqr(R) - sqr(dy));
    end
    else begin
      dx := dx + {$IfDef LINUX}rs1{$Else}1{$EndIf};
      dy := sqrt(sqr(R) - sqr(dx));
      if dy < dx then
      begin
        n := 1;
        dy := round(dy);
      end;
    end;
    dx_05add := x + dx - {$IfDef LINUX}rs05{$Else}0.5{$EndIf};
    dx_05sub := x - dx - {$IfDef LINUX}rs05{$Else}0.5{$EndIf};
    dy_05add := y + dy - {$IfDef LINUX}rs05{$Else}0.5{$EndIf};
    dy_05sub := y - dy - {$IfDef LINUX}rs05{$Else}0.5{$EndIf};
    glBegin(GL_LINES);
      glVertex3f(dx_05add, dy_05add, {$IfDef LINUX}rs0{$Else}0{$EndIf});
      glVertex3f(dx_05sub, dy_05add, {$IfDef LINUX}rs0{$Else}0{$EndIf});
      glVertex3f(dx_05add, dy_05sub, {$IfDef LINUX}rs0{$Else}0{$EndIf});
      glVertex3f(dx_05sub, dy_05sub, {$IfDef LINUX}rs0{$Else}0{$EndIf});
    glEnd;
  end;
end;

procedure DrawButton(x, y, w, h: Single; numColor: LongWord);
var
  Box: array[0..3, 0..2] of Single;
begin
  glEnable(GL_BLEND);
  Box[0, 2] := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  Box[1, 2] := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  Box[2, 2] := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  Box[3, 2] := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  Box[0, 0] := x + w;
  Box[0, 1] := y;
  Box[1, 0] := x + w;
  Box[1, 1] := y + h;
  Box[2, 0] := x;
  Box[2, 1] := y;
  Box[3, 0] := x;
  Box[3, 1] := y + h;
  glColor4f(MenuRed[numColor], MenuGreen[numColor], MenuBlue[numColor], MenuAlpha[numColor]);
  glVertexPointer(3, GL_FLOAT, 0, @Box);
  glEnableClientState(GL_VERTEX_ARRAY);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  Box[0, 0] := x + {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[0, 1] := y + {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[1, 0] := x + w - {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[1, 1] := y + {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[2, 0] := x + w - {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[2, 1] := y + h - {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[3, 0] := x + {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  Box[3, 1] := y + h - {$IfDef LINUX}rs1_5{$Else}1.5{$EndIf};
  glColor4f(MenuRed[1], MenuGreen[1], MenuBlue[1], MenuAlpha[1]);
  glDrawArrays(GL_LINE_LOOP, 0, 4);
  glDisableClientState(GL_VERTEX_ARRAY);
  glDisable(GL_BLEND);
end;

procedure DrawGameJoy01;
var
  r: zglTRect2D;
  i: Integer;
begin
//  setTextScale(22, fontUse);
//  setTextColor(MenuColorText);
  glColor4f(CircleRed[0], CircleGreen[0], CircleBlue[0], CircleAlpha[0]);
  DrawCircle(TouchJoyRolling.Rolling.X, TouchJoyRolling.Rolling.Y, TouchJoyRolling.Rolling.R);

  if (TouchJoyRolling.Rolling.bPush and 1) > 0 then                             
  begin
    glColor4f(CircleRed[1], CircleGreen[1], CircleBlue[1], CircleAlpha[1]);
    DrawCircle(TouchJoyRolling.Rolling._x, TouchJoyRolling.Rolling._y, {$IfDef LINUX}rs5{$Else}5{$EndIf});
  end;

  glColor4f(CircleRed[2], CircleGreen[2], CircleBlue[2], CircleAlpha[2]);
  DrawCircle(TouchJoyRolling.Rolling.X, TouchJoyRolling.Rolling.Y, {$IfDef LINUX}rs10{$Else}10{$EndIf});

  r.W := TouchJoyRolling.Width;
  r.H := TouchJoyRolling.Height;
  for i := 1 to TouchJoyRolling.count do
  Begin
    r.X := TouchJoyRolling.OneButton[i].X;
    r.Y := TouchJoyRolling.OneButton[i].Y + {$IfDef LINUX}rs3{$Else}3{$EndIf};

    if ((TouchJoyRolling.OneButton[i].bPush and 1) > 0) then
    begin
      setFontTextScale(21, fontUse);
      DrawButton(TouchJoyRolling.OneButton[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchJoyRolling.OneButton[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf},
                        TouchJoyRolling.Width - {$IfDef LINUX}rs2{$Else}2{$EndIf}, TouchJoyRolling.Height - {$IfDef LINUX}rs2{$Else}2{$EndIf}, 2);
      text_DrawInRect(fontUse, r, TouchJoyRolling.OneButton[i].symb, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      setFontTextScale(22, fontUse);
    end
    else begin
      DrawButton(TouchJoyRolling.OneButton[i].X, TouchJoyRolling.OneButton[i].Y, TouchJoyRolling.Width, TouchJoyRolling.Height, 0);
      text_DrawInRect(fontUse, r, TouchJoyRolling.OneButton[i].symb, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end;
  end;
end;

procedure DrawGameJoy02;
var
  i: Integer;
  r: zglTRect2D;
begin
//  setTextScale(22, fontUse);
//  setTextColor(MenuColorText);
  for i := 1 to 9 do
  begin
    if i <> 5 then
      if (TouchJoy.BArrow[i].bPush and 1) > 0 then
        asprite2d_Draw(JoyArrow, TouchJoy.BArrow[i].X, TouchJoy.BArrow[i].Y, TouchJoy.Width, TouchJoy.Height, TouchJoy.BArrow[i].Angle, TouchJoy.TextureDown)
      else
        asprite2d_Draw(JoyArrow, TouchJoy.BArrow[i].X, TouchJoy.BArrow[i].Y, TouchJoy.Width, TouchJoy.Height, TouchJoy.BArrow[i].Angle, TouchJoy.TextureUp);
  end;

  r.W := TouchJoy.Width;
  r.H := TouchJoy.Height;
  for i := 1 to TouchJoy.count do
  Begin
    r.X := TouchJoy.OneButton[i].X;
    r.Y := TouchJoy.OneButton[i].Y + {$IfDef LINUX}rs3{$Else}3{$EndIf};
    if (TouchJoy.OneButton[i].bPush and 1) > 0 then
    begin
      setFontTextScale(21, fontUse);
      DrawButton(TouchJoy.OneButton[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchJoy.OneButton[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf},
                          TouchJoy.Width - {$IfDef LINUX}rs2{$Else}2{$EndIf}, TouchJoy.Height - {$IfDef LINUX}rs2{$Else}2{$EndIf}, 2);
      text_DrawInRect(fontUse, r, TouchJoy.OneButton[i].symb,  TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      setFontTextScale(22, fontUse);
    end
    else begin
      DrawButton(TouchJoy.OneButton[i].X, TouchJoy.OneButton[i].Y, TouchJoy.Width, TouchJoy.Height, 0);
      text_DrawInRect(fontUse, r, TouchJoy.OneButton[i].symb,  TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end;
  end;
end;

procedure DrawTouchKeyboard;
var
  n: LongWord;
  i: Integer;
  r: zglTRect2D;
  oldTextScaleEx: Single;
begin
  oldTextScaleEx := getTextScaleEx();
  setTextFontScaleEx(TouchKey.textScale / {$IfDef LINUX}rs10{$Else}10{$EndIf}, fontUse);
  setScallingOff(True);                 // отключаем шкалу
//  Off_TextScale := True;
//  useScaleEx := TouchKey.textScale * managerFont.Font[fontUse].ScaleNorm;
//  setTextColor(MenuColorText);
  if (keybFlags and keyboardLatinRus) > 0 then
    if ((keybFlags and keyboardCaps) > 0) or ((keybFlags and keyboardShift) > 0) then
      n := 3
    else
      n := 4
  else
    if ((keybFlags and keyboardCaps) > 0) or ((keybFlags and keyboardShift) > 0) then
      n := 1
    else
      n := 2;
  r.W := TouchKey.OWidth;
  r.H := TouchKey.Height;
  for i := 1 to TouchKey.count do
  Begin
    r.X := TouchKey.OneButton[i].X;
    r.Y := TouchKey.OneButton[i].Y + {$IfDef LINUX}rs2{$Else}2{$EndIf};
    if keysDown[TouchKey.OneButton[i]._key] then
    begin
      r.X := r.X + 1;
      r.Y := r.Y + 1;
      DrawButton(TouchKey.OneButton[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKey.OneButton[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKey.OWidth, TouchKey.Height, 2);
      text_DrawInRect(fontUse, r, ID_toUTF8( TouchKey.OneButton[i].symb[n]), TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      // log_Add(ID_toUTF8(TouchKey.OneButton[i].symb[n]));
      Continue;                 
    end;

    DrawButton(TouchKey.OneButton[i].X, TouchKey.OneButton[i].Y, TouchKey.OWidth, TouchKey.Height, 0);
    text_DrawInRect(fontUse, r, ID_toUTF8(TouchKey.OneButton[i].symb[n]), TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
  end;
  for i := 35 to 44 do
  Begin
    if (i = _Rus) and ((keybFlags and keyboardLatinRus) > 0) then
      Continue;
    if (i = _Latin) and ((keybFlags and keyboardLatinRus) = 0) then
      Continue;
    r.X := TouchKey.StringButton[i].X;
    r.Y := TouchKey.StringButton[i].Y + {$IfDef LINUX}rs2{$Else}2{$EndIf};
    r.W := TouchKey.StringButton[i].Width;
    if (keysDown[TouchKey.StringButton[i]._key]) or (((keybFlags and keyboardCaps) > 0) and (i = _CapsLock)) or
          (((keybFlags and keyboardInsert) > 0) and (i = _Insert)) or
          ((i = _Shift) and ((keybFlags and keyboardShift) > 0)) then
    begin
      r.X := r.X + {$IfDef LINUX}rs1{$Else}1{$EndIf};
      r.Y := r.Y + {$IfDef LINUX}rs1{$Else}1{$EndIf};
      DrawButton(TouchKey.StringButton[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKey.StringButton[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKey.StringButton[i].Width, TouchKey.Height, 2);
      text_DrawInRect(fontUse, r, TouchKey.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      Continue;                
    end;

    DrawButton(TouchKey.StringButton[i].X, TouchKey.StringButton[i].Y, TouchKey.StringButton[i].Width, TouchKey.Height, 0);
    text_DrawInRect(fontUse, r, TouchKey.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
  end;
  setScallingOff(False);
  setTextScaleEx(oldTextScaleEx);
end;

procedure DrawTouchSymbol;
var
  n: LongWord;
  i: Integer;
  r: zglTRect2D;
begin
//  setTextScale(TouchKeySymb.textScale, fontUse);
//  Off_TextScale := True;
//  useScaleEx := TouchKey.textScale * managerFont.Font[fontUse].ScaleNorm;
//  setTextColor(MenuColorText);
  if (keybFlags and keyboardShift) > 0 then
    n := 2
  else
    n := 1;
  r.W := TouchKeySymb.OWidth;
  r.H := TouchKeySymb.Height;
  for i := 1 to TouchKeySymb.count do
  Begin
    r.X := TouchKeySymb.OneDoubleButton[i].X;
    r.Y := TouchKeySymb.OneDoubleButton[i].Y + {$IfDef LINUX}rs2{$Else}2{$EndIf};

    if keysDown[TouchKeySymb.OneDoubleButton[i]._key] then
    begin
      r.X := r.X + {$IfDef LINUX}rs1{$Else}1{$EndIf};
      r.Y := r.Y + {$IfDef LINUX}rs1{$Else}1{$EndIf};
      DrawButton(TouchKeySymb.OneDoubleButton[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKeySymb.OneDoubleButton[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKeySymb.OWidth, TouchKeySymb.Height, 2);
      text_DrawInRect(fontUse, r, TouchKeySymb.OneDoubleButton[i].symb[n], TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      Continue;                 
    end;

    DrawButton(TouchKeySymb.OneDoubleButton[i].X, TouchKeySymb.OneDoubleButton[i].Y, TouchKeySymb.OWidth, TouchKeySymb.Height, 0);
    text_DrawInRect(fontUse, r, TouchKeySymb.OneDoubleButton[i].symb[n], TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
  end;
  for i := 36 to 44 do
  Begin
    r.X := TouchKeySymb.StringButton[i].X;
    r.Y := TouchKeySymb.StringButton[i].Y + {$IfDef LINUX}rs2{$Else}2{$EndIf};
    r.W := TouchKeySymb.StringButton[i].Width;
    if (i = _home) or (i = _end) then
      setFontTextScale(Round(TouchKeySymb.textScale / 2), fontUse);
    if ((keysDown[TouchKeySymb.StringButton[i]._key]) or (((keybFlags and keyboardInsert) > 0) and (i = _Insert))) or
           (*((i = _Shift) and (keysDown[TouchKeySymb.StringButton[i]._key])) or*) (((keybFlags and keyboardCtrl) > 0) and (i = _Ctrl)) then
    begin
      r.X := r.X + 1;
      r.Y := r.Y + 1;
      DrawButton(TouchKeySymb.StringButton[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKeySymb.StringButton[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKeySymb.StringButton[i].Width, TouchKeySymb.Height, 2);
      text_DrawInRect(fontUse, r, TouchKeySymb.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end
    else begin
      DrawButton(TouchKeySymb.StringButton[i].X, TouchKeySymb.StringButton[i].Y, TouchKeySymb.StringButton[i].Width, TouchKeySymb.Height, 0);
      text_DrawInRect(fontUse, r, TouchKeySymb.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end;
    if (i = _home) or (i = _end) then
      setFontTextScale(TouchKeySymb.textScale, fontUse);
  end;
  for i := 24 to 27 do
  begin
    fx2d_SetColor(0);
    if (TouchKeySymb.BArrow[i].Angle = {$IfDef LINUX}rs90{$Else}90{$EndIf}) or (TouchKeySymb.BArrow[i].Angle = {$IfDef LINUX}rs270{$Else}270{$EndIf}) then
    begin
      r.W := {$IfDef LINUX}rs16{$Else}16{$EndIf};
      r.H := {$IfDef LINUX}rs0{$Else}0{$EndIf};
    end
    else begin
      r.W := {$IfDef LINUX}rs0{$Else}0{$EndIf};
      r.H := {$IfDef LINUX}rs16{$Else}16{$EndIf};
    end;
    if keysDown[TouchKeySymb.BArrow[i]._key] then
    begin
      DrawButton(TouchKeySymb.BArrow[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKeySymb.BArrow[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf}, TouchKeySymb.OWidth, TouchKeySymb.Height, 2);
      asprite2d_Draw(JoyArrow, TouchKeySymb.BArrow[i].X + {$IfDef LINUX}rs1{$Else}1{$EndIf} + r.W / {$IfDef LINUX}rs2{$Else}2{$EndIf},
                     TouchKeySymb.BArrow[i].Y + {$IfDef LINUX}rs1{$Else}1{$EndIf} + r.H / {$IfDef LINUX}rs2{$Else}2{$EndIf},
                     TouchKeySymb.OWidth - {$IfDef LINUX}rs1{$Else}1{$EndIf} - r.W, TouchKeySymb.Height - {$IfDef LINUX}rs1{$Else}1{$EndIf} - r.H,
                     TouchKeySymb.BArrow[i].Angle, TouchKeySymb.TextureDown, 192, FX_COLOR or FX_BLEND);
    end
    else begin
      DrawButton(TouchKeySymb.BArrow[i].X, TouchKeySymb.BArrow[i].Y, TouchKeySymb.OWidth, TouchKeySymb.Height, 0);
      asprite2d_Draw(JoyArrow, TouchKeySymb.BArrow[i].X + r.W / {$IfDef LINUX}rs2{$Else}2{$EndIf}, TouchKeySymb.BArrow[i].Y + r.H / {$IfDef LINUX}rs2{$Else}2{$EndIf},
                     TouchKeySymb.OWidth - r.W, TouchKeySymb.Height - r.H,
                     TouchKeySymb.BArrow[i].Angle, TouchKeySymb.TextureUp, 192, FX_COLOR or FX_BLEND);
    end;
  end;
//  Off_TextScale := False;
end;

end.
