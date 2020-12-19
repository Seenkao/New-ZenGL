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
unit zgl_render;

{$I zgl_config.cfg}

interface

procedure Set2DMode;
procedure Set3DMode(FOVY: Single = 45);
procedure SetCurrentMode;

procedure zbuffer_SetDepth(zNear, zFar: Single);
procedure zbuffer_Clear;

procedure scissor_Begin(X, Y, Width, Height: Integer; ConsiderCamera: Boolean = TRUE);
procedure scissor_End;

implementation
uses
  zgl_application,
  zgl_window,
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

var
  tSCount : Integer;
  tScissor: array of array[0..3] of Integer;

procedure Set2DMode;
begin
  oglMode := 2;
  batch2d_Flush();
  if cam2d.Apply Then glPopMatrix();
  cam2d := @cam2dTarget[oglTarget];

  glDisable(GL_DEPTH_TEST);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  if oglTarget = TARGET_SCREEN Then
  begin
    if appFlags and CORRECT_RESOLUTION > 0 Then
      {$IfDef USE_GLES} glOrthof{$Else}glOrtho{$EndIf}(0, Round(oglWidth - scrAddCX * 2 / scrResCX), Round(oglHeight - scrAddCY * 2 / scrResCY), 0, -1, 1)
    else
      {$IfDef USE_GLES} glOrthof{$Else}glOrtho{$EndIf}(0, wndWidth, wndHeight, 0, -1, 1);
  end else
    {$IfDef USE_GLES} glOrthof{$Else}glOrtho{$EndIf}(0, oglWidth, oglHeight, 0, -1, 1);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  scr_SetViewPort();

  if cam2d.Apply Then cam2d_Set(cam2d.Global);
end;

procedure Set3DMode(FOVY: Single = 45);
begin
  oglMode := 3;
  oglFOVY := FOVY;
  batch2d_Flush();
  if cam2d.Apply Then glPopMatrix();
  cam2d := @cam2dTarget[oglTarget];

  glColor4f(1, 1, 1, 1);

  glEnable(GL_DEPTH_TEST);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(oglFOVY, oglWidth / oglHeight, oglzNear, oglzFar);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  scr_SetViewPort();
end;

procedure SetCurrentMode;
begin
  if oglMode = 2 Then
    Set2DMode()
  else
    Set3DMode(oglFOVY);
  scrViewPort := False;
end;

procedure zbuffer_SetDepth(zNear, zFar: Single);
begin
  oglzNear := zNear;
  oglzFar  := zFar;
end;

procedure zbuffer_Clear;
begin
  batch2d_Flush();
  glClear(GL_DEPTH_BUFFER_BIT);
end;

procedure scissor_Begin(X, Y, Width, Height: Integer; ConsiderCamera: Boolean = TRUE);
begin
  batch2d_Flush();

  if (Width < 0) or (Height < 0) Then exit;
  if ConsiderCamera Then
  begin
    if cam2d.OnlyXY Then
    begin
      X := Trunc(X - cam2d.Global.X);
      Y := Trunc(Y - cam2d.Global.Y);
    end else
    begin
      X      := Trunc((X - cam2d.Global.Center.X - cam2d.Global.X) * cam2d.Global.Zoom.X + cam2d.Global.Center.X);
      Y      := Trunc((Y - cam2d.Global.Center.Y - cam2d.Global.Y) * cam2d.Global.Zoom.Y + cam2d.Global.Center.Y);
      Width  := Trunc(Width  * cam2d.Global.Zoom.X);
      Height := Trunc(Height * cam2d.Global.Zoom.Y);
    end;
  end;
  if (oglTarget = TARGET_SCREEN) and (appFlags and CORRECT_RESOLUTION > 0) Then
  begin
    X      := Round(X * scrResCX + scrAddCX);
    Y      := Round(Y * scrResCY + scrAddCY);
    Width  := Round(Width * scrResCX);
    Height := Round(Height * scrResCY);
  end;
  glEnable(GL_SCISSOR_TEST);
  glScissor(X, oglTargetH - Y - Height, Width, Height);

  INC(tSCount);
  SetLength(tScissor, tSCount);
  tScissor[tSCount - 1][0] := render2dClipX;
  tScissor[tSCount - 1][1] := render2dClipY;
  tScissor[tSCount - 1][2] := render2dClipW;
  tScissor[tSCount - 1][3] := render2dClipH;

  render2dClipX  := X;
  render2dClipY  := Y;
  render2dClipW  := Width;
  render2dClipH  := Height;
  render2dClipXW := render2dClipX + render2dClipW;
  render2dClipYH := render2dClipY + render2dClipH;
end;

procedure scissor_End;
begin
  batch2d_Flush();

  if tSCount - 1 < 0 Then exit;
  DEC(tSCount);
  render2dClipX := tScissor[tSCount][0];
  render2dClipY := tScissor[tSCount][1];
  render2dClipW := tScissor[tSCount][2];
  render2dClipH := tScissor[tSCount][3];
  SetLength(tScissor, tSCount);

  if tSCount > 0 Then
  begin
    glEnable(GL_SCISSOR_TEST);
    glScissor(render2dClipX, oglTargetH - render2dClipY - render2dClipH, render2dClipW, render2dClipH);
  end else
    glDisable(GL_SCISSOR_TEST);
end;

end.
