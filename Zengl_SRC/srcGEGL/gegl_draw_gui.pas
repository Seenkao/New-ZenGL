unit gegl_draw_gui;

{/$I zgl_config.cfg}

interface

uses
  zgl_font, zgl_textures_png, zgl_textures;

var
  fontUse: Byte;
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
procedure DrawButton(x, y, w, h: Single; nColor: Byte);
procedure DrawGameJoy01;
procedure DrawGameJoy02;
procedure DrawTouchKeyboard;
procedure DrawTouchSymbol;

implementation

uses
  zgl_text, gegl_touch_menu, zgl_types, zgl_sprite_2d, zgl_keyboard, zgl_fx,
  {$IFNDEF USE_GLES}
  zgl_opengl_all
  {$ELSE}
  zgl_opengles_all
  {$ENDIF}
  ;

procedure DrawCircle(x, y, R: Single);
var
  dx, dy: single;
  n: byte;
begin
  dx := 0;
  dy := R;
  n := 0;
  while dy >= 0 do
  begin
    if (n and 1) > 0 then
    begin
      dy := dy - 1;
      dx := sqrt(sqr(R) - sqr(dy));
    end
    else begin
      dx := dx + 1;
      dy := sqrt(sqr(R) - sqr(dx));
      if dy < dx then
      begin
        n := 1;
        dy := round(dy);
      end;
    end;
    glBegin(GL_LINES);
      glVertex3f(x + dx - 0.5, y + dy - 0.5, 0);
      glVertex3f(x - (dx - 0.5), y + dy - 0.5, 0);
      glVertex3f(x + dx - 0.5, y - (dy - 0.5), 0);
      glVertex3f(x - (dx - 0.5), y - (dy - 0.5), 0);
    glEnd;
  end;
end;

procedure DrawButton(x, y, w, h: Single; nColor: Byte);
var
  Box: array[0..3, 0..2] of Single;
begin
  glEnable(GL_BLEND);
  Box[0, 2] := 0;
  Box[1, 2] := 0;
  Box[2, 2] := 0;
  Box[3, 2] := 0;
  Box[0, 0] := x + w;
  Box[0, 1] := y;
  Box[1, 0] := x + w;
  Box[1, 1] := y + h;
  Box[2, 0] := x;
  Box[2, 1] := y;
  Box[3, 0] := x;
  Box[3, 1] := y + h;
  glColor4f(MenuRed[nColor], MenuGreen[nColor], MenuBlue[nColor], MenuAlpha[nColor]);
  glVertexPointer(3, GL_FLOAT, 0, @Box);
  glEnableClientState(GL_VERTEX_ARRAY);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  Box[0, 0] := x + 1.5;
  Box[0, 1] := y + 1.5;
  Box[1, 0] := x + w - 1.5;
  Box[1, 1] := y + 1.5;
  Box[2, 0] := x + w - 1.5;
  Box[2, 1] := y + h - 1.5;
  Box[3, 0] := x + 1.5;
  Box[3, 1] := y + h - 1.5;
  glColor4f(MenuRed[1], MenuGreen[1], MenuBlue[1], MenuAlpha[1]);
  glDrawArrays(GL_LINE_LOOP, 0, 4);
  glDisableClientState(GL_VERTEX_ARRAY);
  glDisable(GL_BLEND);
end;

procedure DrawGameJoy01;
var
  r: zglTRect;
  i: Integer;
begin
  setTextScale(22, fontUse);
  setTextColor(MenuColorText);
  glColor4f(CircleRed[0], CircleGreen[0], CircleBlue[0], CircleAlpha[0]);
  DrawCircle(TouchJoyRolling.Rolling.X, TouchJoyRolling.Rolling.Y, TouchJoyRolling.Rolling.R);

  if (TouchJoyRolling.Rolling.bPush and 1) > 0 then                             
  begin
    glColor4f(CircleRed[1], CircleGreen[1], CircleBlue[1], CircleAlpha[1]);
    DrawCircle(TouchJoyRolling.Rolling._x, TouchJoyRolling.Rolling._y, 5);
  end;

  glColor4f(CircleRed[2], CircleGreen[2], CircleBlue[2], CircleAlpha[2]);      
  DrawCircle(TouchJoyRolling.Rolling.X, TouchJoyRolling.Rolling.Y, 10);

  r.W := TouchJoyRolling.Width;
  r.H := TouchJoyRolling.Height;
  for i := 1 to TouchJoyRolling.count do
  Begin
    r.X := TouchJoyRolling.OneButton[i].X;
    r.Y := TouchJoyRolling.OneButton[i].Y + 3;

    if ((TouchJoyRolling.OneButton[i].bPush and 1) > 0) then
    begin
      setTextScale(21, fontUse);
      DrawButton(TouchJoyRolling.OneButton[i].X + 1, TouchJoyRolling.OneButton[i].Y + 1, TouchJoyRolling.Width - 2, TouchJoyRolling.Height - 2, 2);
      text_DrawInRect(fontUse, r, TouchJoyRolling.OneButton[i].symb, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      setTextScale(22, fontUse);
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
  r: zglTRect;
begin
  setTextScale(22, fontUse);
  setTextColor(MenuColorText);
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
    r.Y := TouchJoy.OneButton[i].Y + 3;
    if (TouchJoy.OneButton[i].bPush and 1) > 0 then
    begin
      setTextScale(21, fontUse);
      DrawButton(TouchJoy.OneButton[i].X + 1, TouchJoy.OneButton[i].Y + 1, TouchJoy.Width - 2, TouchJoy.Height - 2, 2);
      text_DrawInRect(fontUse, r, TouchJoy.OneButton[i].symb,  TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      setTextScale(22, fontUse);
    end
    else begin
      DrawButton(TouchJoy.OneButton[i].X, TouchJoy.OneButton[i].Y, TouchJoy.Width, TouchJoy.Height, 0);
      text_DrawInRect(fontUse, r, TouchJoy.OneButton[i].symb,  TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end;
  end;
end;

procedure DrawTouchKeyboard;
var
  n: Byte;
  i: Integer;
  r: zglTRect;
begin
  setTextScale(TouchKey.textScale, fontUse);
  setTextColor(MenuColorText);
  if (TouchKey.Flags and keyboardLatinRus) > 0 then           
    if ((TouchKey.Flags and keyboardCaps) > 0) or ((TouchKey.bPush and 128) > 0) then     
      n := 3
    else
      n := 4
  else
    if ((TouchKey.Flags and keyboardCaps) > 0) or ((TouchKey.bPush and 128) > 0) then     
      n := 1
    else
      n := 2;
  r.W := TouchKey.OWidth;
  r.H := TouchKey.Height;
  for i := 1 to TouchKey.count do
  Begin
    r.X := TouchKey.OneButton[i].X;
    r.Y := TouchKey.OneButton[i].Y + 2;
    if keysDown[TouchKey.OneButton[i]._key] then
    begin
      r.X := r.X + 1;
      r.Y := r.Y + 1;
      DrawButton(TouchKey.OneButton[i].X + 1, TouchKey.OneButton[i].Y + 1, TouchKey.OWidth, TouchKey.Height, 2);
      text_DrawInRect(fontUse, r, TouchKey.OneButton[i].symb[n], TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      Continue;                 
    end;

    DrawButton(TouchKey.OneButton[i].X, TouchKey.OneButton[i].Y, TouchKey.OWidth, TouchKey.Height, 0);
    text_DrawInRect(fontUse, r, TouchKey.OneButton[i].symb[n], TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
  end;
  for i := 35 to 44 do
  Begin
    if (i = _Rus) and ((TouchKey.Flags and keyboardLatinRus) > 0) then
      Continue;
    if (i = _Latin) and not((TouchKey.Flags and keyboardLatinRus) > 0) then
      Continue;
    r.X := TouchKey.StringButton[i].X;
    r.Y := TouchKey.StringButton[i].Y + 2;
    r.W := TouchKey.StringButton[i].Width;
    if (keysDown[TouchKey.StringButton[i]._key]) or (((TouchKey.Flags and keyboardCaps) > 0) and (i = _CapsLock)) or
          (((TouchKey.Flags and keyboardInsert) > 0) and (i = _Insert)) or ((i = _Shift) and
          (keysDown[TouchKey.StringButton[i]._key])) then
    begin
      r.X := r.X + 1;
      r.Y := r.Y + 1;
      DrawButton(TouchKey.StringButton[i].X + 1, TouchKey.StringButton[i].Y + 1, TouchKey.StringButton[i].Width, TouchKey.Height, 2);
      text_DrawInRect(fontUse, r, TouchKey.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      Continue;                
    end;

    DrawButton(TouchKey.StringButton[i].X, TouchKey.StringButton[i].Y, TouchKey.StringButton[i].Width, TouchKey.Height, 0);
    text_DrawInRect(fontUse, r, TouchKey.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
  end;
end;

procedure DrawTouchSymbol;
var
  n: Byte;
  i: Integer;
  r: zglTRect;
begin
  setTextScale(TouchKeySymb.textScale, fontUse);
  setTextColor(MenuColorText);
  if keysDown[K_SHIFT] then           
    n := 2
  else
    n := 1;
  r.W := TouchKeySymb.OWidth;
  r.H := TouchKeySymb.Height;
  for i := 1 to TouchKeySymb.count do
  Begin
    r.X := TouchKeySymb.OneDoubleButton[i].X;
    r.Y := TouchKeySymb.OneDoubleButton[i].Y + 2;

    if keysDown[TouchKeySymb.OneDoubleButton[i]._key] then
    begin
      r.X := r.X + 1;
      r.Y := r.Y + 1;
      DrawButton(TouchKeySymb.OneDoubleButton[i].X + 1, TouchKeySymb.OneDoubleButton[i].Y + 1, TouchKeySymb.OWidth, TouchKeySymb.Height, 2);
      text_DrawInRect(fontUse, r, TouchKeySymb.OneDoubleButton[i].symb[n], TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
      Continue;                 
    end;

    DrawButton(TouchKeySymb.OneDoubleButton[i].X, TouchKeySymb.OneDoubleButton[i].Y, TouchKeySymb.OWidth, TouchKeySymb.Height, 0);
    text_DrawInRect(fontUse, r, TouchKeySymb.OneDoubleButton[i].symb[n], TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
  end;
  for i := 36 to 44 do
  Begin
    r.X := TouchKeySymb.StringButton[i].X;
    r.Y := TouchKeySymb.StringButton[i].Y + 2;
    r.W := TouchKeySymb.StringButton[i].Width;
    if (i = _home) or (i = _end) then
      setTextScale(Round(TouchKeySymb.textScale / 2), fontUse);
    if ((keysDown[TouchKey.StringButton[i]._key]) or (((TouchKey.Flags and keyboardInsert) > 0) and (i = _Insert))) or
           ((i = _Shift) and (keysDown[TouchKey.StringButton[i]._key])) or
           (keysDown[TouchKeySymb.StringButton[i]._key]) then
    begin
      r.X := r.X + 1;
      r.Y := r.Y + 1;
      DrawButton(TouchKeySymb.StringButton[i].X + 1, TouchKeySymb.StringButton[i].Y + 1, TouchKeySymb.StringButton[i].Width, TouchKeySymb.Height, 2);
      text_DrawInRect(fontUse, r, TouchKeySymb.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end
    else begin
      DrawButton(TouchKeySymb.StringButton[i].X, TouchKeySymb.StringButton[i].Y, TouchKeySymb.StringButton[i].Width, TouchKeySymb.Height, 0);
      text_DrawInRect(fontUse, r, TouchKeySymb.StringButton[i].bString, TEXT_HALIGN_CENTER or TEXT_VALIGN_CENTER);
    end;
    if (i = _home) or (i = _end) then
      setTextScale(TouchKeySymb.textScale, fontUse);
  end;
  for i := 24 to 27 do
  begin
    fx2d_SetColor(0);
    if (TouchKeySymb.BArrow[i].Angle = 90) or (TouchKeySymb.BArrow[i].Angle = 270) then
    begin
      r.W := 16;
      r.H := 0;
    end
    else begin
      r.W := 0;
      r.H := 16;
    end;
    if keysDown[TouchKeySymb.BArrow[i]._key] then
    begin
      DrawButton(TouchKeySymb.BArrow[i].X + 1, TouchKeySymb.BArrow[i].Y + 1, TouchKeySymb.OWidth, TouchKeySymb.Height, 2);
      asprite2d_Draw(JoyArrow, TouchKeySymb.BArrow[i].X + 1 + r.W / 2, TouchKeySymb.BArrow[i].Y + 1 + r.H / 2, TouchKeySymb.OWidth - 1 - r.W, TouchKeySymb.Height - 1 - r.H,
            TouchKeySymb.BArrow[i].Angle, TouchKeySymb.TextureDown, 192, FX_COLOR or FX_BLEND);
    end
    else begin
      DrawButton(TouchKeySymb.BArrow[i].X, TouchKeySymb.BArrow[i].Y, TouchKeySymb.OWidth, TouchKeySymb.Height, 0);
      asprite2d_Draw(JoyArrow, TouchKeySymb.BArrow[i].X + r.W / 2, TouchKeySymb.BArrow[i].Y + r.H / 2, TouchKeySymb.OWidth - r.W, TouchKeySymb.Height - r.H,
            TouchKeySymb.BArrow[i].Angle, TouchKeySymb.TextureUp, 192, FX_COLOR or FX_BLEND);
    end;
  end;
end;

end.
