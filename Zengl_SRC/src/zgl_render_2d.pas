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
unit zgl_render_2d;

{$I zgl_config.cfg}

interface
uses
  zgl_gltypeconst,
  zgl_textures;

procedure batch2d_Begin;
procedure batch2d_End;
procedure batch2d_Flush;
function  batch2d_Check(Mode, FX: LongWord; Texture: zglPTexture): Boolean;

function sprite2d_InScreenSimple(X, Y, W, H, Angle: Single): Boolean;
function sprite2d_InScreenCamera(X, Y, W, H, Angle: Single): Boolean;

var
  render2dClip     : Boolean;
  render2dClipX    : Integer;
  render2dClipY    : Integer;
  render2dClipW    : Integer;
  render2dClipH    : Integer;
  render2dClipXW   : Integer;
  render2dClipYH   : Integer;
  render2dClipR    : Integer;
  b2dStarted       : Boolean;
  b2dNew           : Boolean;
  b2dBatches       : LongWord;
  b2dCurMode       : LongWord;
  b2dCurFX         : LongWord;
  b2dCurBlend      : LongWord;
  b2dCurBlendMode  : LongWord;
  b2dCurColorMode  : LongWord;
  b2dCurColorMask  : LongWord;
  b2dCurTexture    : zglPTexture;
  b2dCurSmooth     : LongWord;
  sprite2d_InScreen: function(X, Y, W, H, Angle: Single): Boolean;

implementation
uses
  {$IFNDEF USE_GLES}
  //zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_fx,
  zgl_camera_2d,
  zgl_primitives_2d;

procedure batch2d_Begin;
begin
  b2dNew     := TRUE;
  b2dStarted := TRUE;
  b2dBatches := 0;
end;

procedure batch2d_End;
begin
  batch2d_Flush();
  b2dStarted := FALSE;
end;

procedure batch2d_Flush;
begin
  if b2dStarted and (not b2dNew) Then
  begin
    INC(b2dBatches);
    b2dNew := TRUE;
    glEnd();

    glDisable(GL_TEXTURE_2D);
    if b2dCurBlend = 0 Then
      glDisable(GL_ALPHA_TEST)
    else
      glDisable(GL_BLEND);

    if b2dCurSmooth > 0 Then
    begin
      b2dCurSmooth := 0;
      glDisable(GL_LINE_SMOOTH);
      {$IFNDEF USE_GLES}
      glDisable(GL_POLYGON_SMOOTH);
      {$ENDIF}
    end;
  end;
end;

function batch2d_Check(Mode, FX: LongWord; Texture: zglPTexture): Boolean;
begin
  if (b2dCurMode <> Mode) or (Mode = GL_LINE_LOOP) or (b2dCurTexture <> Texture) or (b2dCurBlend <> FX and FX_BLEND) or (b2dCurSmooth <> FX and PR2D_SMOOTH) Then
  begin
    if not b2dNew Then
      batch2d_Flush();
    b2dNew := TRUE;
  end;

  b2dCurMode    := Mode;
  b2dCurTexture := Texture;
  b2dCurFX      := FX;
  b2dCurBlend   := FX and FX_BLEND;
  b2dCurSmooth  := FX and PR2D_SMOOTH;

  Result := b2dNew;
  b2dNew := FALSE;
end;

function sprite2d_InScreenSimple(X, Y, W, H, Angle: Single): Boolean;
begin
  if Angle <> 0 Then
    Result := ((X + W + H / 2 > render2dClipX) and (X - W - H / 2 < render2dClipXW) and
                (Y + H + W / 2 > render2dClipY) and (Y - W - H / 2 < render2dClipYH))
  else
    Result := ((X + W > render2dClipX) and (X < render2dClipXW) and
                (Y + H > render2dClipY) and (Y < render2dClipYH));
end;

function sprite2d_InScreenCamera(X, Y, W, H, Angle: Single): Boolean;
  var
    sx, sy, srad: Single;
begin
  if not cam2d.OnlyXY Then
  begin
    sx   := X + W / 2;
    sy   := Y + H / 2;
    srad := (W + H) / 2;

    Result := sqr(sx - cam2d.CX) + sqr(sy - cam2d.CY) < sqr(srad + render2dClipR);
  end else
  if Angle <> 0 Then
    Result := ((X + W + H / 2 > render2dClipX + cam2d.Global.X) and (X - W - H / 2 < render2dClipXW + cam2d.Global.X) and
                    (Y + H + W / 2 > render2dClipY + cam2d.Global.Y) and (Y - W - H / 2 < render2dClipYH + cam2d.Global.Y))
  else
    Result := ((X + W > render2dClipX + cam2d.Global.X) and (X < render2dClipXW + cam2d.Global.X) and
                    (Y + H > render2dClipY + cam2d.Global.Y) and (Y < render2dClipYH + cam2d.Global.Y));
end;

initialization
  sprite2d_InScreen := sprite2d_InScreenSimple;
  
end.
