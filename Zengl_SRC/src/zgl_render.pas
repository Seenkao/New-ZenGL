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
{$I GLdefine.cfg}

interface

uses
  zgl_types,
  zgl_gltypeconst;

// Rus: установки 2D режима.
// Eng: 2D mode settings.
procedure Set2DMode;
// Rus: установки 3D режима.
// Eng: 3D mode settings.
procedure Set3DMode(FOVY: Single = 45);
// Rus: выбор режима 2D, 3D или пользовательского.
// Eng: select 2D, 3D or custom mode.
procedure SetCurrentMode(mode: LongWord = Mode2D);

// Rus: установка глубины для 3D. То что будет за нулевой точкой (в минусе)
//      видно не будет. Читаем документацию OpenGL.
// Eng: depth setting for 3D. What will be beyond the zero point (negative
//      numbers) will not be visible. Reading the OpenGL documentation.
procedure zbuffer_SetDepth(zNear, zFar: Single);
// Rus: очистка буфера глубины, но его можно очистить и при обычной очистке.
// Eng: clearing the depth buffer, but it can be cleared with a normal clear as well.
procedure zbuffer_Clear;

// Rus: начало вырезки. Вставить в том месте, где хотим вырезать.
// Eng: start of cut. Paste where you want to cut.
procedure scissor_Begin(X, Y, Width, Height: Integer; ConsiderCamera: Boolean = TRUE);
// Rus: конец вырезки.
// Eng: end of cut.
procedure scissor_End;

var
  SetUserMode: procedure;

implementation
uses
  zgl_application,
  zgl_window,
  zgl_screen,
  {$IfDef USE_GLU}
  zgl_glu,
  {$EndIf}
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
  rs1: Single = 1;
  {$IfDef LINUX}
    {$IfNDef USE_GLES}
    rsd0: Double = 0;
    rsd2: Double = 2;
    {$Else}
    rsd0: Single = 0;
    rsd2: Single = 2;
    {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
    rs0: Double = 0;
    rs2: Double = 2;
    {$Else}
    rs0: Single = 0;
    rs2: Single = 2;
    {$IfEnd}
    {$EndIf}
  {$EndIf}

procedure Set2DMode;
var
{$IfNDef USE_GLES}
  scrLeft, scrRight, scrTop, scrBottom: Double;
{$Else}
{$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  scrLeft, scrRight, scrTop, scrBottom: Double;
{$Else}
  scrLeft, scrRight, scrTop, scrBottom: Single;
{$IfEnd}
{$EndIf}
begin
  oglMode := Mode2D;
  batch2d_Flush();
  if cam2d.Apply Then
    glPopMatrix();
  cam2d := @cam2dTarget[oglTarget];

  glDisable(GL_DEPTH_TEST);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  // нулевые координаты в центре окна
  if (appFlags and XY_IN_CENTER_WINDOW) > 0 then
  begin
    if oglTarget = TARGET_SCREEN Then
    begin
      if (appFlags and CORRECT_RESOLUTION) > 0 Then
      begin
        scrRight := (oglWidth - scrAddCX * {$IfDef LINUX}rsd2{$Else}2{$EndIf} / scrResCX) / {$IfDef LINUX}rsd2{$Else}2{$EndIf};
        scrLeft := - scrRight;
        scrBottom := (oglHeight - scrAddCY * {$IfDef LINUX}rsd2{$Else}2{$EndIf} / scrResCY) / {$IfDef LINUX}rsd2{$Else}2{$EndIf};
        scrTop := - scrBottom;
      end
      else begin
        scrRight := wndWidth / {$IfDef LINUX}rsd2{$Else}2{$EndIf};
        scrLeft := - scrRight;
        scrBottom := wndHeight / {$IfDef LINUX}rsd2{$Else}2{$EndIf};
        scrTop := - scrBottom;
      end;
    end
    else begin
      // вывод в текстуру (в часть окна)
      scrRight := oglWidth / {$IfDef LINUX}rsd2{$Else}2{$EndIf};
      scrLeft := - scrRight;
      scrBottom := oglHeight / {$IfDef LINUX}rsd2{$Else}2{$EndIf};
      scrTop := - scrBottom;
    end;
  // нулевые координаты от левого верхнего угла
  end else
    if oglTarget = TARGET_SCREEN Then
    begin
      if (appFlags and CORRECT_RESOLUTION) > 0 Then
      begin
        scrLeft := {$IfDef LINUX}rsd0{$Else}0{$EndIf};
        scrRight := (oglWidth - scrAddCX * {$IfDef LINUX}rsd2{$Else}2{$EndIf} / scrResCX);
        scrTop := {$IfDef LINUX}rsd0{$Else}0{$EndIf};
        scrBottom := (oglHeight - scrAddCY * {$IfDef LINUX}rsd2{$Else}2{$EndIf} / scrResCY);
      end
      else begin
        scrLeft := {$IfDef LINUX}rsd0{$Else}0{$EndIf};
        scrRight := wndWidth;
        scrTop := {$IfDef LINUX}rsd0{$Else}0{$EndIf};
        scrBottom := wndHeight;
      end;
    end
    else begin
   //    вывод в текстуру (в часть окна)
      scrLeft := {$IfDef LINUX}rsd0{$Else}0{$EndIf};
      scrRight := oglWidth;
      scrTop := {$IfDef LINUX}rsd0{$Else}0{$EndIf};
      scrBottom := oglHeight;
    end;
  {$IfDef USE_GLES} glOrthof{$Else}glOrtho{$EndIf}(scrLeft, scrRight, scrBottom, scrTop, scrNear, scrFar);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
//  scr_SetViewPort();

  if cam2d.Apply Then
    cam2d_Set(cam2d.Global);
end;

procedure Set3DMode(FOVY: Single = 45);
begin
  oglMode := Mode3D;
  oglFOVY := FOVY;
  batch2d_Flush();
  if cam2d.Apply Then
    glPopMatrix();
  cam2d := @cam2dTarget[oglTarget];

//  glColor4f(rs1, rs1, rs1, rs1);

  glEnable(GL_DEPTH_TEST);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(oglFOVY, oglWidth / oglHeight, oglzNear, oglzFar);
//  {$IfDef USE_GLES}glFrustumf{$Else}glFrustum{$EndIf}(- oglWidth / 2, oglWidth / 2, oglHeight / 2, - oglHeight / 2, oglzNear, oglzFar);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
//  scr_SetViewPort();

  if cam2d.Apply Then
    cam2d_Set(cam2d.Global);
end;

procedure SetCurrentMode(mode: LongWord = Mode2D);
begin
  if (mode > 3) or ((mode = ModeUser) and not Assigned(SetUserMode)) then
    mode := Mode2D;

  oglMode := mode;
  if not winOn then
    exit;

  if mode = Mode2D Then
    Set2DMode()
  else
    if mode = Mode3D then
      Set3DMode(oglFOVY)
    else
      SetUserMode;
  if Assigned(SetViewPort) then
    SetViewPort;
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
