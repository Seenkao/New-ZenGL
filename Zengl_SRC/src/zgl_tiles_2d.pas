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
unit zgl_tiles_2d;

{$I zgl_config.cfg}

interface

uses
  zgl_types,
  zgl_fx,
  zgl_textures,
  zgl_math_2d;

type
  zglPTiles2D = ^zglTTiles2D;
  zglTTiles2D = record
    X, Y: Integer;
    Width, Height: Integer;
    Tiles: array of array of Integer;
  end;

procedure tiles2d_Draw(Texture: zglPTexture; X, Y: Single; Tiles: zglPTiles2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);

implementation
uses
  zgl_application,
  zgl_screen,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render_2d,
  zgl_camera_2d;

const
  FLIP_TEXCOORD: array[0..3] of zglTTexCoordIndex = ((0, 1, 2, 3), (1, 0, 3, 2), (3, 2, 1, 0), (2, 3, 0, 1));

// TODO: rewrite the code with optimizations and fix for using with camera in some cases
procedure tiles2d_Draw(Texture: zglPTexture; X, Y: Single; Tiles: zglPTiles2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
  var
    tX, tY, tU, tV: Single;
    i, j, aI, aJ, bI, bJ: Integer;
    _sin, _cos, x1, y1, x2, y2, x3, y3, x4, y4: Single;
    tc: zglPTextureCoord;
    tci: zglPTexCoordIndex;
begin
  if (not Assigned(Texture)) or (not Assigned(Tiles)) Then exit;
  if X < 0 Then
    begin
      aI := Round(-X) div Tiles.Width;
      bI := render2dClipW div Tiles.Width + aI;
    end else
      begin
        aI := 0;
        bI := render2dClipW div Tiles.Width - Round(X) div Tiles.Width;
      end;

  if Y < 0 Then
    begin
      aJ := Round(-Y) div Tiles.Height;
      bJ := render2dClipH div Tiles.Height + aJ;
    end else
      begin
        aJ := 0;
        bJ := render2dClipH div Tiles.Height - Round(Y) div Tiles.Height;
      end;

  if not cam2d.OnlyXY Then
    begin
      tX := - cam2d.CX;
      tY := - cam2d.CY;
      tU := render2dClipW - cam2d.CX;
      tV := render2dClipH - cam2d.CY;

      m_SinCos(-cam2d.Global.Angle * deg2rad, _sin, _cos);

      x1 := tX * _cos - tY * _sin + cam2d.CX;
      y1 := tX * _sin + tY * _cos + cam2d.CY;
      x2 := tU * _cos - tY * _sin + cam2d.CX;
      y2 := tU * _sin + tY * _cos + cam2d.CY;
      x3 := tU * _cos - tV * _sin + cam2d.CX;
      y3 := tU * _sin + tV * _cos + cam2d.CY;
      x4 := tX * _cos - tV * _sin + cam2d.CX;
      y4 := tX * _sin + tV * _cos + cam2d.CY;

      if x1 > x2 Then tX := x2 else tX := x1;
      if tX > x3 Then tX := x3;
      if tX > x4 Then tX := x4;
      if y1 > y2 Then tY := y2 else tY := y1;
      if tY > y3 Then tY := y3;
      if tY > y4 Then tY := y4;
      if x1 < x2 Then tU := x2 else tU := x1;
      if tU < x3 Then tU := x3;
      if tU < x4 Then tU := x4;
      if y1 < y2 Then tV := y2 else tV := y1;
      if tV < y3 Then tV := y3;
      if tV < y4 Then tV := y4;

      aI := aI - Round(-tX / Tiles.Width);
      bI := bI + Round((tU - render2dClipW) / Tiles.Height);
      aJ := aJ - Round(-tY / Tiles.Height);
      bJ := bJ + Round((tV - render2dClipH) / Tiles.Height);

      x1 := cam2d.Global.X * _cos - cam2d.Global.Y * _sin;
      y1 := cam2d.Global.X * _sin + cam2d.Global.Y * _cos;

      aI := aI + Round(x1 / Tiles.Width) - 1;
      bI := bI + Round(x1 / Tiles.Width) + 1;
      aJ := aJ + Round(y1 / Tiles.Height) - 1;
      bJ := bJ + Round(y1 / Tiles.Height) + 1;
    end else
      begin
        if X >= 0 Then
          aI := aI + Round((cam2d.Global.X - X) / Tiles.Width) - 1
        else
          aI := aI + Round(cam2d.Global.X / Tiles.Width) - 1;

        bI := bI + Round((cam2d.Global.X) / Tiles.Width) + 1;

        if Y >= 0 Then
          aJ := aJ + Round((cam2d.Global.Y - Y) / Tiles.Height) - 1
        else
          aJ := aJ + Round(cam2d.Global.Y / Tiles.Height) - 1;

        bJ := bJ + Round(cam2d.Global.Y / Tiles.Height) + 1;
      end;

  if aI < 0 Then aI := 0;
  if aJ < 0 Then aJ := 0;

  if bI >= Tiles.X Then bI := Tiles.X - 1;
  if bJ >= Tiles.Y Then bJ := Tiles.Y - 1;

  if (not b2dStarted) or batch2d_Check(GL_QUADS, FX, Texture) Then
    begin
      if FX and FX_BLEND > 0 Then
        glEnable(GL_BLEND)
      else
        glEnable(GL_ALPHA_TEST);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Texture^.ID);

      glBegin(GL_QUADS);
    end;

  if FX and FX_COLOR > 0 Then
    begin
      fx2dAlpha^ := Alpha / 255;
      glColor4f(fx2dColor[0], fx2dColor[1], fx2dColor[2], fx2dColor[3]);
    end else
      begin
        fx2dAlphaDef^ := Alpha / 255;
        glColor4f(fx2dColorDef[0], fx2dColorDef[1], fx2dColorDef[2], fx2dColorDef[3]);
      end;

  tci := @FLIP_TEXCOORD[FX and FX2D_FLIPX + FX and FX2D_FLIPY];

  for i := aI to bI do
    for j := aJ to bJ do
      begin
        if (Tiles.Tiles[i, j] < 1) or (Tiles.Tiles[i, j] >= Length(Texture.FramesCoord)) Then continue;
        tc := @Texture.FramesCoord[Tiles.Tiles[i, j]];

        glTexCoord2fv(@tc[tci[0]]);
        x1 := x + i * Tiles.Width;
        y1 := y + j * Tiles.Height;
        x2 := x1 + Tiles.Width;
        y2 := y1 + Tiles.Height;
        glVertex2f(x1, y1);
        glTexCoord2fv(@tc[tci[1]]);
        glVertex2f(x2, y1);
        glTexCoord2fv(@tc[tci[2]]);
        glVertex2f(x2, y2);
        glTexCoord2fv(@tc[tci[3]]);
        glVertex2f(x1, y2);
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
