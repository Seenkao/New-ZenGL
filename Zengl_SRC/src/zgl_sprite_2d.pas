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

 !!! modification from Serge 25.07.2022
}
unit zgl_sprite_2d;

{$I zgl_config.cfg}

interface

uses
  zgl_types,
  zgl_fx,
  zgl_textures,
  zgl_gltypeconst,
  zgl_math_2d;

procedure texture2d_Draw(Texture: zglPTexture; const TexCoord: array of zglTPoint2D; X, Y, W, H, Angle: Single; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
procedure ssprite2d_Draw(Texture: zglPTexture; X, Y, W, H, Angle: Single; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
procedure asprite2d_Draw(Texture: zglPTexture; X, Y, W, H, Angle: Single; Frame: Word; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
procedure csprite2d_Draw(Texture: zglPTexture; X, Y, W, H, Angle: Single; const CutRect: zglTRect2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);

implementation
uses
  zgl_application,
  zgl_screen,
  {$IFNDEF USE_GLES}
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render_2d,
  zgl_camera_2d;

const
  FLIP_TEXCOORD: array[0..3] of zglTTexCoordIndex = ((0, 1, 2, 3), (1, 0, 3, 2), (3, 2, 1, 0), (2, 3, 0, 1));

  {$IfDef LINUX}
var
  rs2: Single = 2;
  {$EndIf}

procedure texture2d_Draw(Texture: zglPTexture; const TexCoord: array of zglTPoint2D; X, Y, W, H, Angle: Single; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
var
  quad: array[0..3] of zglTPoint2D;
  tci : zglPTexCoordIndex;
  mode: Integer;

  x1, x2: Single;
  y1, y2: Single;
  cX, cY: Single;
  c, s  : Single;
  mX, mY: Single;
  mW, mH: Single;
  x1c, x2c, _y1c, _y2c: Single;
  x1s, x2s, _y1s, _y2s: Single;
begin
  if not Assigned(Texture) Then
    exit;

  if FX and FX2D_SCALE > 0 Then
  begin
    X := X + (W - W * fx2dSX) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    Y := Y + (H - H * fx2dSY) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    W := W * fx2dSX;
    H := H * fx2dSY;
  end;

  if render2dClip Then
    if FX and FX2D_VCHANGE = 0 Then
    begin
      if not sprite2d_InScreen(X, Y, W, H, Angle) Then
        Exit;
    end else
    begin
      mX := min(X + fx2dVX1, X + W + fx2dVX2);
      mY := min(Y + fx2dVY1, Y + H + fx2dVY2);
      mW := max(X + fx2dVX1, X + W + fx2dVX2) - mx;
      mH := max(Y + fx2dVY1, Y + H + fx2dVY2) - mY;
      if not sprite2d_InScreen(mX, mY, mW + abs(X - mX) + abs(mW - W), mH + abs(Y - mY) + abs(mH - H), Angle) Then
        Exit;
    end;

  tci := @FLIP_TEXCOORD[FX and FX2D_FLIPX + FX and FX2D_FLIPY];

  if Angle <> 0 Then
  begin
    if FX and FX2D_RPIVOT = 0 Then
    begin
      x1 := -W / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      y1 := -H / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      x2 := -x1;
      y2 := -y1;
      cX :=  X + x2;
      cY :=  Y + y2;
    end else
    begin
      x1 := -fx2dRPX;
      y1 := -fx2dRPY;
      x2 := W + x1;
      y2 := H + y1;
      cX := X + fx2dRPX;
      cY := Y + fx2dRPY;
    end;

    m_SinCos(Angle * deg2rad, s, c);

    if FX and FX2D_VCHANGE = 0 Then
    begin
      x1c := x1 * c;
      x1s := x1 * s;
      x2c := x2 * c;
      x2s := x2 * s;
      _y1c := y1 * c + cY;
      _y2c := y2 * c + cY;
      _y1s := y1 * s - cX;
      _y2s := y2 * s - cX;
    end else
    begin
      x1c := (x1 + fx2dVX1) * c;
      x1s := (x1 + fx2dVX1) * s;
      x2c := (x2 + fx2dVX2) * c;
      x2s := (x2 + fx2dVX2) * s;
      _y1c := (y1 + fx2dVY1) * c + cY;
      _y2c := (y2 + fx2dVY2) * c + cY;
      _y1s := (y1 + fx2dVY1) * s - cX;
      _y2s := (y2 + fx2dVY2) * s - cX;
    end;
    quad[0].X := x1c - _y1s;
    quad[0].Y := x1s + _y1c;
    quad[1].X := x2c - _y1s;
    quad[1].Y := x2s + _y1c;
    quad[2].X := x2c - _y2s;
    quad[2].Y := x2s + _y2c;
    quad[3].X := x1c - _y2s;
    quad[3].Y := x1s + _y2c;
  end else
  begin
    if FX and FX2D_VCHANGE = 0 Then
    begin
      quad[0].X := X;
      quad[1].X := X + W;
      quad[0].Y := Y;
      quad[2].Y := Y + H;
    end else
    begin
      quad[0].X := X     + fx2dVX1;
      quad[0].Y := Y     + fx2dVY1;
      quad[1].X := X + W + fx2dVX2;
      quad[2].Y := Y + H + fx2dVY2;
    end;
    quad[1].Y := quad[0].Y;
    quad[2].X := quad[1].X;
    quad[3].X := quad[0].X;
    quad[3].Y := quad[2].Y;
  end;

  if FX and FX2D_VCA > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_QUADS;
  if (not b2dStarted) or batch2d_Check(mode, FX, Texture) Then
    begin
      if FX and FX_BLEND > 0 Then
        glEnable(GL_BLEND)
      else
        glEnable(GL_ALPHA_TEST);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Texture.ID);

      glBegin(mode);
    end;

  if FX and FX_COLOR > 0 Then
    begin
      fx2dAlpha^ := Alpha / 255;
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColor[0], fx2dColor[1], fx2dColor[2], fx2dColor[3]);
    end else
    begin
      fx2dAlphaDef^ := Alpha / 255;
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColorDef[0], fx2dColorDef[1], fx2dColorDef[2], fx2dColorDef[3]);
    end;

  if FX and FX2D_VCA > 0 Then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glTexCoord2fv(@TexCoord[tci[0]]);
      glVertex2fv(@quad[0]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
      glTexCoord2fv(@TexCoord[tci[1]]);
      glVertex2fv(@quad[1]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glTexCoord2fv(@TexCoord[tci[2]]);
      glVertex2fv(@quad[2]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glTexCoord2fv(@TexCoord[tci[2]]);
      glVertex2fv(@quad[2]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
      glTexCoord2fv(@TexCoord[tci[3]]);
      glVertex2fv(@quad[3]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glTexCoord2fv(@TexCoord[tci[0]]);
      glVertex2fv(@quad[0]);
    end else
      begin
        glTexCoord2fv(@TexCoord[tci[0]]);
        glVertex2fv(@quad[0]);

        glTexCoord2fv(@TexCoord[tci[1]]);
        glVertex2fv(@quad[1]);

        glTexCoord2fv(@TexCoord[tci[2]]);
        glVertex2fv(@quad[2]);

        glTexCoord2fv(@TexCoord[tci[3]]);
        glVertex2fv(@quad[3]);
      end;

  if not b2dStarted Then
    begin
      glEnd();

      glDisable(GL_TEXTURE_2D);
      glDisable(GL_BLEND);
      glDisable(GL_ALPHA_TEST);
    end;
end;

procedure ssprite2d_Draw(Texture: zglPTexture; X, Y, W, H, Angle: Single; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
var
  quad: array[0..3] of zglTPoint2D;
  tc  : zglPTextureCoord;
  tci : zglPTexCoordIndex;
  mode: Integer;

  x1, x2: Single;
  y1, y2: Single;
  cX, cY: Single;
  c, s  : Single;
  mX, mY: Single;
  mW, mH: Single;
  x1c, x2c, _y1c, _y2c: Single;
  x1s, x2s, _y1s, _y2s: Single;
begin
  if not Assigned(Texture) Then
    exit;

  if FX and FX2D_SCALE > 0 Then
  begin
    X := X + (W - W * fx2dSX) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    Y := Y + (H - H * fx2dSY) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    W := W * fx2dSX;
    H := H * fx2dSY;
  end;

  if render2dClip Then
    if FX and FX2D_VCHANGE = 0 Then
    begin
      if not sprite2d_InScreen(X, Y, W, H, Angle) Then
        Exit;
    end else
    begin
      mX := min(X + fx2dVX1, X + W + fx2dVX2);
      mY := min(Y + fx2dVY1, Y + H + fx2dVY2);
      mW := max(X + fx2dVX1, X + W + fx2dVX2) - mx;
      mH := max(Y + fx2dVY1, Y + H + fx2dVY2) - mY;
      if not sprite2d_InScreen(mX, mY, mW + abs(X - mX) + abs(mW - W), mH + abs(Y - mY) + abs(mH - H), Angle) Then
        Exit;
    end;

  tci := @FLIP_TEXCOORD[FX and FX2D_FLIPX + FX and FX2D_FLIPY];
  tc  := @Texture.FramesCoord[0];

  if Angle <> 0 Then
  begin
    if FX and FX2D_RPIVOT = 0 Then
    begin
      x1 := -W / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      y1 := -H / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      x2 := -x1;
      y2 := -y1;
      cX :=  X + x2;
      cY :=  Y + y2;
    end else
    begin
      x1 := -fx2dRPX;
      y1 := -fx2dRPY;
      x2 := W + x1;
      y2 := H + y1;
      cX := X + fx2dRPX;
      cY := Y + fx2dRPY;
    end;

    m_SinCos(Angle * deg2rad, s, c);

    if FX and FX2D_VCHANGE = 0 Then
    begin
      x1c := x1 * c;
      x1s := x1 * s;
      x2c := x2 * c;
      x2s := x2 * s;
      _y1c := y1 * c + cY;
      _y2c := y2 * c + cY;
      _y1s := y1 * s - cX;
      _y2s := y2 * s - cX;
    end else
    begin
      x1c := (x1 + fx2dVX1) * c;
      x1s := (x1 + fx2dVX1) * s;
      x2c := (x2 + fx2dVX2) * c;
      x2s := (x2 + fx2dVX2) * s;
      _y1c := (y1 + fx2dVY1) * c + cY;
      _y2c := (y2 + fx2dVY2) * c + cY;
      _y1s := (y1 + fx2dVY1) * s - cX;
      _y2s := (y2 + fx2dVY2) * s - cX;
    end;
    quad[0].X := x1c - _y1s;
    quad[0].Y := x1s + _y1c;
    quad[1].X := x2c - _y1s;
    quad[1].Y := x2s + _y1c;
    quad[2].X := x2c - _y2s;
    quad[2].Y := x2s + _y2c;
    quad[3].X := x1c - _y2s;
    quad[3].Y := x1s + _y2c;
  end else
  begin
    if FX and FX2D_VCHANGE = 0 Then
    begin
      quad[0].X := X;
      quad[1].X := X + W;
      quad[0].Y := Y;
      quad[2].Y := Y + H;
    end else
    begin
      quad[0].X := X     + fx2dVX1;
      quad[0].Y := Y     + fx2dVY1;
      quad[1].X := X + W + fx2dVX2;
      quad[2].Y := Y + H + fx2dVY2;
    end;
    quad[1].Y := quad[0].Y;
    quad[2].X := quad[1].X;
    quad[3].X := quad[0].X;
    quad[3].Y := quad[2].Y;
  end;

  if FX and FX2D_VCA > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_QUADS;
  if (not b2dStarted) or batch2d_Check(mode, FX, Texture) Then
    begin
      if FX and FX_BLEND > 0 Then
        glEnable(GL_BLEND)
      else
        glEnable(GL_ALPHA_TEST);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Texture.ID);

      glBegin(mode);
    end;

  if FX and FX_COLOR > 0 Then
    begin
      fx2dAlpha^ := Alpha / 255;
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColor[0], fx2dColor[1], fx2dColor[2], fx2dColor[3]);
    end else
      begin
        fx2dAlphaDef^ := Alpha / 255;
        {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColorDef[0], fx2dColorDef[1], fx2dColorDef[2], fx2dColorDef[3]);
      end;

  if FX and FX2D_VCA > 0 Then
    begin
      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glTexCoord2fv(@tc[tci[0]]);
      glVertex2fv(@quad[0]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
      glTexCoord2fv(@tc[tci[1]]);
      glVertex2fv(@quad[1]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glTexCoord2fv(@tc[tci[2]]);
      glVertex2fv(@quad[2]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glTexCoord2fv(@tc[tci[2]]);
      glVertex2fv(@quad[2]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
      glTexCoord2fv(@tc[tci[3]]);
      glVertex2fv(@quad[3]);

      {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glTexCoord2fv(@tc[tci[0]]);
      glVertex2fv(@quad[0]);
    end else
      begin
        glTexCoord2fv(@tc[tci[0]]);
        glVertex2fv(@quad[0]);

        glTexCoord2fv(@tc[tci[1]]);
        glVertex2fv(@quad[1]);

        glTexCoord2fv(@tc[tci[2]]);
        glVertex2fv(@quad[2]);

        glTexCoord2fv(@tc[tci[3]]);
        glVertex2fv(@quad[3]);
      end;

  if not b2dStarted Then
    begin
      glEnd();

      glDisable(GL_TEXTURE_2D);
      glDisable(GL_BLEND);
      glDisable(GL_ALPHA_TEST);
    end;
end;

procedure asprite2d_Draw(Texture: zglPTexture; X, Y, W, H, Angle: Single; Frame: Word; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
var
  quad: array[0..3] of zglTPoint2D;
  tc  : zglPTextureCoord;
  tci : zglPTexCoordIndex;
  fc  : Integer;
  mode: Integer;

  x1, x2: Single;
  y1, y2: Single;
  cX, cY: Single;
  c, s  : Single;
  mX, mY: Single;
  mW, mH: Single;
  x1c, x2c, _y1c, _y2c: Single;
  x1s, x2s, _y1s, _y2s: Single;
begin
  if not Assigned(Texture) Then
    exit;

  if FX and FX2D_SCALE > 0 Then
  begin
    X := X + (W - W * fx2dSX) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    Y := Y + (H - H * fx2dSY) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    W := W * fx2dSX;
    H := H * fx2dSY;
  end;

  if render2dClip Then
    if FX and FX2D_VCHANGE = 0 Then
    begin
      if not sprite2d_InScreen(X, Y, W, H, Angle) Then
        Exit;
    end else
    begin
      mX := min(X + fx2dVX1, X + W + fx2dVX2);
      mY := min(Y + fx2dVY1, Y + H + fx2dVY2);
      mW := max(X + fx2dVX1, X + W + fx2dVX2) - mx;
      mH := max(Y + fx2dVY1, Y + H + fx2dVY2) - mY;
      if not sprite2d_InScreen(mX, mY, mW + abs(X - mX) + abs(mW - W), mH + abs(Y - mY) + abs(mH - H), Angle) Then
        Exit;
    end;

  fc := Length(Texture.FramesCoord) - 1;
  if Frame > fc Then
    DEC(Frame, ((Frame - 1) div fc) * fc)
  else
    if Frame < 1 Then
      INC(Frame, (abs(Frame) div fc + 1) * fc);
  tci := @FLIP_TEXCOORD[FX and FX2D_FLIPX + FX and FX2D_FLIPY];
  tc  := @Texture.FramesCoord[Frame];

  if Angle <> 0 Then
  begin
    if FX and FX2D_RPIVOT = 0 Then
    begin
      x1 := -W / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      y1 := -H / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      x2 := -x1;
      y2 := -y1;
      cX :=  X + x2;
      cY :=  Y + y2;
    end else
    begin
      x1 := -fx2dRPX;
      y1 := -fx2dRPY;
      x2 := W + x1;
      y2 := H + y1;
      cX := X + fx2dRPX;
      cY := Y + fx2dRPY;
    end;

    m_SinCos(Angle * deg2rad, s, c);

    if FX and FX2D_VCHANGE = 0 Then
    begin
      x1c := x1 * c;
      x1s := x1 * s;
      x2c := x2 * c;
      x2s := x2 * s;
      _y1c := y1 * c + cY;
      _y2c := y2 * c + cY;
      _y1s := y1 * s - cX;
      _y2s := y2 * s - cX;
    end else
    begin
      x1c := (x1 + fx2dVX1) * c;
      x1s := (x1 + fx2dVX1) * s;
      x2c := (x2 + fx2dVX2) * c;
      x2s := (x2 + fx2dVX2) * s;
      _y1c := (y1 + fx2dVY1) * c + cY;
      _y2c := (y2 + fx2dVY2) * c + cY;
      _y1s := (y1 + fx2dVY1) * s - cX;
      _y2s := (y2 + fx2dVY2) * s - cX;
    end;
    quad[0].X := x1c - _y1s;
    quad[0].Y := x1s + _y1c;
    quad[1].X := x2c - _y1s;
    quad[1].Y := x2s + _y1c;
    quad[2].X := x2c - _y2s;
    quad[2].Y := x2s + _y2c;
    quad[3].X := x1c - _y2s;
    quad[3].Y := x1s + _y2c;
  end else
  begin
    if FX and FX2D_VCHANGE = 0 Then
    begin
      quad[0].X := X;
      quad[1].X := X + W;
      quad[0].Y := Y;
      quad[2].Y := Y + H;
    end else
    begin
      quad[0].X := X     + fx2dVX1;
      quad[0].Y := Y     + fx2dVY1;
      quad[1].X := X + W + fx2dVX2;
      quad[2].Y := Y + H + fx2dVY2;
    end;
    quad[1].Y := quad[0].Y;
    quad[2].X := quad[1].X;
    quad[3].X := quad[0].X;
    quad[3].Y := quad[2].Y;
  end;

  if FX and FX2D_VCA > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_QUADS;
  if (not b2dStarted) or batch2d_Check(mode, FX, Texture) Then
  begin
    if FX and FX_BLEND > 0 Then
      glEnable(GL_BLEND)
    else
      glEnable(GL_ALPHA_TEST);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, Texture^.ID);

    glBegin(mode);
  end;

  if FX and FX_COLOR > 0 Then
  begin
    fx2dAlpha^ := Alpha / 255;
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColor[0], fx2dColor[1], fx2dColor[2], fx2dColor[3]);
  end else
  begin
    fx2dAlphaDef^ := Alpha / 255;
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColorDef[0], fx2dColorDef[1], fx2dColorDef[2], fx2dColorDef[3]);
  end;

  if FX and FX2D_VCA > 0 Then
  begin
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glTexCoord2fv(@tc[tci[0]]);
    glVertex2fv(@quad[0]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glTexCoord2fv(@tc[tci[1]]);
    glVertex2fv(@quad[1]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glTexCoord2fv(@tc[tci[2]]);
    glVertex2fv(@quad[2]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glTexCoord2fv(@tc[tci[2]]);
    glVertex2fv(@quad[2]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
    glTexCoord2fv(@tc[tci[3]]);
    glVertex2fv(@quad[3]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glTexCoord2fv(@tc[tci[0]]);
    glVertex2fv(@quad[0]);
  end else
  begin
    glTexCoord2fv(@tc[tci[0]]);
    glVertex2fv(@quad[0]);

    glTexCoord2fv(@tc[tci[1]]);
    glVertex2fv(@quad[1]);

    glTexCoord2fv(@tc[tci[2]]);
    glVertex2fv(@quad[2]);

    glTexCoord2fv(@tc[tci[3]]);
    glVertex2fv(@quad[3]);
  end;

  if not b2dStarted Then
  begin
    glEnd();

    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
    glDisable(GL_ALPHA_TEST);
  end;
end;

procedure csprite2d_Draw(Texture: zglPTexture; X, Y, W, H, Angle: Single; const CutRect: zglTRect2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
var
  quad: array[0..3] of zglTPoint2D;
  mode: Integer;

  tU, tV, tX, tY, tW, tH: Single;

  x1, x2: Single;
  y1, y2: Single;
  cX, cY: Single;
  c, s  : Single;
  mX, mY: Single;
  mW, mH: Single;
  x1c, x2c, _y1c, _y2c: Single;
  x1s, x2s, _y1s, _y2s: Single;
begin
  if not Assigned(Texture) Then exit;

  if FX and FX2D_SCALE > 0 Then
  begin
    X := X + (W - W * fx2dSX) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    Y := Y + (H - H * fx2dSY) / {$IfDef LINUX}rs2{$Else}2{$EndIf};
    W := W * fx2dSX;
    H := H * fx2dSY;
  end;

  if render2dClip Then
  if FX and FX2D_VCHANGE = 0 Then
  begin
    if not sprite2d_InScreen(X, Y, W, H, Angle) Then
      Exit;
  end else
  begin
    mX := min(X + fx2dVX1, X + W + fx2dVX2);
    mY := min(Y + fx2dVY1, Y + H + fx2dVY2);
    mW := max(X + fx2dVX1, X + W + fx2dVX2) - mx;
    mH := max(Y + fx2dVY1, Y + H + fx2dVY2) - mY;
    if not sprite2d_InScreen(mX, mY, mW + abs(X - mX) + abs(mW - W), mH + abs(Y - mY) + abs(mH - H), Angle) Then
      Exit;
  end;

  tU := 1 / (Texture.Width  / Texture.U);
  tV := 1 / (Texture.Height / Texture.V);
  tX := tU * CutRect.X;
  tY := tV * (Texture.Height - CutRect.Y);
  tW := tX + tU * CutRect.W;
  tH := tY - tV * CutRect.H;

  if FX and FX2D_FLIPX > 0 Then
    tU := tW - tX
  else
    tU := 0;
  if FX and FX2D_FLIPY > 0 Then
    tV := tH - tY
  else
    tV := 0;

  if Angle <> 0 Then
  begin
    if FX and FX2D_RPIVOT = 0 Then
    begin
      x1 := -W / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      y1 := -H / {$IfDef LINUX}rs2{$Else}2{$EndIf};
      x2 := -x1;
      y2 := -y1;
      cX :=  X + x2;
      cY :=  Y + y2;
    end else
    begin
      x1 := -fx2dRPX;
      y1 := -fx2dRPY;
      x2 := W + x1;
      y2 := H + y1;
      cX := X + fx2dRPX;
      cY := Y + fx2dRPY;
    end;

    m_SinCos(Angle * deg2rad, s, c);

    if FX and FX2D_VCHANGE = 0 Then
    begin
      x1c := x1 * c;
      x1s := x1 * s;
      x2c := x2 * c;
      x2s := x2 * s;
      _y1c := y1 * c + cY;
      _y2c := y2 * c + cY;
      _y1s := y1 * s - cX;
      _y2s := y2 * s - cX;
    end else
    begin
      x1c := (x1 + fx2dVX1) * c;
      x1s := (x1 + fx2dVX1) * s;
      x2c := (x2 + fx2dVX2) * c;
      x2s := (x2 + fx2dVX2) * s;
      _y1c := (y1 + fx2dVY1) * c + cY;
      _y2c := (y2 + fx2dVY2) * c + cY;
      _y1s := (y1 + fx2dVY1) * s - cX;
      _y2s := (y2 + fx2dVY2) * s - cX;
    end;
    quad[0].X := x1c - _y1s;
    quad[0].Y := x1s + _y1c;
    quad[1].X := x2c - _y1s;
    quad[1].Y := x2s + _y1c;
    quad[2].X := x2c - _y2s;
    quad[2].Y := x2s + _y2c;
    quad[3].X := x1c - _y2s;
    quad[3].Y := x1s + _y2c;
  end else
  begin
    if FX and FX2D_VCHANGE = 0 Then
    begin
      quad[0].X := X;
      quad[1].X := X + W;
      quad[0].Y := Y;
      quad[2].Y := Y + H;
    end else
    begin
      quad[0].X := X     + fx2dVX1;
      quad[0].Y := Y     + fx2dVY1;
      quad[1].X := X + W + fx2dVX2;
      quad[2].Y := Y + H + fx2dVY2;
    end;
    quad[1].Y := quad[0].Y;
    quad[2].X := quad[1].X;
    quad[3].X := quad[0].X;
    quad[3].Y := quad[2].Y;
  end;

  if FX and FX2D_VCA > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_QUADS;
  if (not b2dStarted) or batch2d_Check(mode, FX, Texture) Then
  begin
    if FX and FX_BLEND > 0 Then
      glEnable(GL_BLEND)
    else
      glEnable(GL_ALPHA_TEST);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, Texture^.ID);

    glBegin(mode);
  end;

  if FX and FX_COLOR > 0 Then
  begin
    fx2dAlpha^ := Alpha / 255;
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColor[0], fx2dColor[1], fx2dColor[2], fx2dColor[3]);
  end else
  begin
    fx2dAlphaDef^ := Alpha / 255;
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dColorDef[0], fx2dColorDef[1], fx2dColorDef[2], fx2dColorDef[3]);
  end;

  if FX and FX2D_VCA > 0 Then
  begin
    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glTexCoord2f(tX + tU, tY + tV);
    glVertex2fv(@quad[0]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
    glTexCoord2f(tW - tU, tY + tV);
    glVertex2fv(@quad[1]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glTexCoord2f(tW - tU, tH - tV);
    glVertex2fv(@quad[2]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
    glTexCoord2f(tW - tU, tH - tV);
    glVertex2fv(@quad[2]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
    glTexCoord2f(tX + tU, tH - tV);
    glVertex2fv(@quad[3]);

    {$IfDef USE_GLES}_glColor4f{$Else}glColor4f{$EndIf}(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
    glTexCoord2f(tX + tU, tY + tV);
    glVertex2fv(@quad[0]);
  end else
  begin
    glTexCoord2f(tX + tU, tY + tV);
    glVertex2fv(@quad[0]);

    glTexCoord2f(tW - tU, tY + tV);
    glVertex2fv(@quad[1]);

    glTexCoord2f(tW - tU, tH - tV);
    glVertex2fv(@quad[2]);

    glTexCoord2f(tX + tU, tH - tV);
    glVertex2fv(@quad[3]);
  end;

  if not b2dStarted Then
  begin
    glEnd();

    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
    glDisable(GL_ALPHA_TEST);
  end;
end;

end.
