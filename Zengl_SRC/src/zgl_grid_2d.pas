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
unit zgl_grid_2d;

{$I zgl_config.cfg}

interface

uses
  zgl_fx,
  zgl_textures,
  zgl_types;

type
  zglPGrid2D = ^zglTGrid2D;
  zglTGrid2D = record
    Cols: Integer;
    Rows: Integer;
    Grid: array of array of zglTPoint2D;
  end;

procedure sgrid2d_Draw(Texture: zglPTexture; X, Y: Single; Grid: zglPGrid2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
procedure agrid2d_Draw(Texture: zglPTexture; X, Y: Single; Grid: zglPGrid2D; Frame: Integer; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
procedure cgrid2d_Draw(Texture: zglPTexture; X, Y: Single; Grid: zglPGrid2D; const CutRect: zglTRect2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);

implementation
uses
  zgl_application,
  zgl_screen,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  zgl_gltypeconst,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render_2d,
  zgl_camera_2d;

procedure sgrid2d_Draw(Texture: zglPTexture; X, Y: Single; Grid: zglPGrid2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
  var
    quad: array[0..3] of zglTPoint2D;
    i, j: Integer;

    u, v: Single;
    iU, jV, iiU, ijV: Integer;
begin
  if (not Assigned(Texture)) or (not Assigned(Grid)) Then exit;

  if FX and FX2D_FLIPX > 0 Then
    begin
      iU  := (Grid.Cols - 1);
      iiU := -1;
    end else
      begin
        iU  := 0;
        iiU := 1;
      end;
  if FX and FX2D_FLIPY > 0 Then
    begin
      jV  := (Grid.Rows - 1);
      ijV := -1;
    end else
      begin
        jV  := 0;
        ijV := 1;
      end;
  u := Texture^.U / (Grid.Cols - 1);
  v := Texture^.V / (Grid.Rows - 1);

  if (not b2dStarted) or batch2d_Check(GL_QUADS, FX, Texture) Then
    begin
      if FX and FX_BLEND > 0 Then
        glEnable(GL_BLEND)
      else
        glEnable(GL_ALPHA_TEST);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Texture.ID);

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

  for i := 0 to Grid.Cols - 2 do
    begin
      for j := 0 to Grid.Rows - 2 do
        begin
          quad[0].X := X + Grid.Grid[i, j].X;
          quad[0].Y := Y + Grid.Grid[i, j].Y;
          quad[1].X := X + Grid.Grid[i + 1, j].X;
          quad[1].Y := Y + Grid.Grid[i + 1, j].Y;
          quad[2].X := X + Grid.Grid[i + 1, j + 1].X;
          quad[2].Y := Y + Grid.Grid[i + 1, j + 1].Y;
          quad[3].X := X + Grid.Grid[i, j + 1].X;
          quad[3].Y := Y + Grid.Grid[i, j + 1].Y;

          glTexCoord2f(iU * u, Texture^.V - jV * v);
          glVertex2fv(@quad[0]);

          glTexCoord2f((iU + iiU) * u, Texture^.V - jV * v);
          glVertex2fv(@quad[1]);

          glTexCoord2f((iU + iiU) * u, Texture^.V - (jV + ijV) * v);
          glVertex2fv(@quad[2]);

          glTexCoord2f(iU * u, Texture^.V - (jV + ijV) * v);
          glVertex2fv(@quad[3]);

          INC(jV, ijV);
        end;
      INC(iU, iiU);
      DEC(jV, ijV * (Grid.Rows - 1));
  end;

  if not b2dStarted Then
    begin
      glEnd();

      glDisable(GL_TEXTURE_2D);
      glDisable(GL_BLEND);
      glDisable(GL_ALPHA_TEST);
    end;
end;

procedure agrid2d_Draw(Texture: zglPTexture; X, Y: Single; Grid: zglPGrid2D; Frame: Integer; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
  var
    quad: array[0..3] of zglTPoint2D;
    i, j: Integer;

    tX, tY, u, v: Single;
    iU, jV, iiU, ijV: Integer;
begin
  if (not Assigned(Texture)) or (not Assigned(Grid)) Then exit;

  if FX and FX2D_FLIPX > 0 Then
    begin
      iU  := (Grid.Cols - 1);
      iiU := -1;
    end else
      begin
        iU  := 0;
        iiU := 1;
      end;
  if FX and FX2D_FLIPY > 0 Then
    begin
      jV  := (Grid.Rows - 1);
      ijV := -1;
    end else
      begin
        jV  := 0;
        ijV := 1;
      end;

  i := Length(Texture.FramesCoord) - 1;
  if Frame > i Then
    DEC(Frame, ((Frame - 1) div i) * i)
  else
    if Frame < 1 Then
      INC(Frame, (abs(Frame) div i + 1) * i);

  tX := Texture.FramesCoord[Frame, 0].X;
  tY := Texture.V - Texture.FramesCoord[Frame, 0].Y;
  u  := (Texture.FramesCoord[Frame, 1].X - Texture.FramesCoord[Frame, 0].X) / (Grid.Cols - 1);
  v  := (Texture.FramesCoord[Frame, 0].Y - Texture.FramesCoord[Frame, 2].Y) / (Grid.Rows - 1);

  if (not b2dStarted) or batch2d_Check(GL_QUADS, FX, Texture) Then
    begin
      if FX and FX_BLEND > 0 Then
        glEnable(GL_BLEND)
      else
        glEnable(GL_ALPHA_TEST);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Texture.ID);

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

  for i := 0 to Grid.Cols - 2 do
    begin
      for j := 0 to Grid.Rows - 2 do
        begin
          quad[0].X := X + Grid.Grid[i, j].X;
          quad[0].Y := Y + Grid.Grid[i, j].Y;
          quad[1].X := X + Grid.Grid[i + 1, j].X;
          quad[1].Y := Y + Grid.Grid[i + 1, j].Y;
          quad[2].X := X + Grid.Grid[i + 1, j + 1].X;
          quad[2].Y := Y + Grid.Grid[i + 1, j + 1].Y;
          quad[3].X := X + Grid.Grid[i, j + 1].X;
          quad[3].Y := Y + Grid.Grid[i, j + 1].Y;

          glTexCoord2f(iU * u + tX, Texture^.V - jV * v - tY);
          glVertex2fv(@quad[0]);

          glTexCoord2f((iU + iiU) * u + tX, Texture^.V - jV * v - tY);
          glVertex2fv(@quad[1]);

          glTexCoord2f((iU + iiU) * u + tX, Texture^.V - (jV + ijV) * v - tY);
          glVertex2fv(@quad[2]);

          glTexCoord2f(iU * u + tX, Texture^.V - (jV + ijV) * v - tY);
          glVertex2fv(@quad[3]);

          INC(jV, ijV);
        end;
      INC(iU, iiU);
      DEC(jV, ijV * (Grid.Rows - 1));
    end;

  if not b2dStarted Then
    begin
      glEnd();

      glDisable(GL_TEXTURE_2D);
      glDisable(GL_BLEND);
      glDisable(GL_ALPHA_TEST);
    end;
end;

procedure cgrid2d_Draw(Texture: zglPTexture; X, Y: Single; Grid: zglPGrid2D; const CutRect: zglTRect2D; Alpha: Byte = 255; FX: LongWord = FX_BLEND);
  var
    quad: array[0..3] of zglTPoint2D;
    i, j: Integer;

    tX, tY, u, v: Single;
    iU, jV, iiU, ijV: Integer;
begin
  if (not Assigned(Texture)) or (not Assigned(Grid)) Then exit;

  if FX and FX2D_FLIPX > 0 Then
    begin
      iU  := (Grid.Cols - 1);
      iiU := -1;
    end else
      begin
        iU  := 0;
        iiU := 1;
      end;
  if FX and FX2D_FLIPY > 0 Then
    begin
      jV  := (Grid.Rows - 1);
      ijV := -1;
    end else
      begin
        jV  := 0;
        ijV := 1;
      end;

  u  := 1 / (Texture.Width  / Texture.U);
  v  := 1 / (Texture.Height / Texture.V);
  tX := u * CutRect.X;
  tY := v * CutRect.Y;
  u  := u * CutRect.W / (Grid.Cols - 1);
  v  := v * CutRect.H / (Grid.Rows - 1);

  if (not b2dStarted) or batch2d_Check(GL_QUADS, FX, Texture) Then
    begin
      if FX and FX_BLEND > 0 Then
        glEnable(GL_BLEND)
      else
        glEnable(GL_ALPHA_TEST);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Texture.ID);

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

  for i := 0 to Grid.Cols - 2 do
    begin
      for j := 0 to Grid.Rows - 2 do
        begin
          quad[0].X := X + Grid.Grid[i, j].X;
          quad[0].Y := Y + Grid.Grid[i, j].Y;
          quad[1].X := X + Grid.Grid[i + 1, j].X;
          quad[1].Y := Y + Grid.Grid[i + 1, j].Y;
          quad[2].X := X + Grid.Grid[i + 1, j + 1].X;
          quad[2].Y := Y + Grid.Grid[i + 1, j + 1].Y;
          quad[3].X := X + Grid.Grid[i, j + 1].X;
          quad[3].Y := Y + Grid.Grid[i, j + 1].Y;

          glTexCoord2f(iU * u + tX, Texture^.V - jV * v - tY);
          glVertex2fv(@quad[0]);

          glTexCoord2f((iU + iiU) * u + tX, Texture^.V - jV * v - tY);
          glVertex2fv(@quad[1]);

          glTexCoord2f((iU + iiU) * u + tX, Texture^.V - (jV + ijV) * v - tY);
          glVertex2fv(@quad[2]);

          glTexCoord2f(iU * u + tX, Texture^.V - (jV + ijV) * v - tY);
          glVertex2fv(@quad[3]);

          INC(jV, ijV);
        end;
      INC(iU, iiU);
      DEC(jV, ijV * (Grid.Rows - 1));
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
