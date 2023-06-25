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

 !!! modification from Serge 03.09.2022
}
unit zgl_camera_2d;

{$I zgl_config.cfg}

interface
uses
  zgl_types;

type
  zglPCameraSystem = ^zglTCameraSystem;
  zglTCameraSystem = record
    Global: zglPCamera2D;
    Apply : Boolean;
    OnlyXY: Boolean;
    CX    : Single;
    CY    : Single;
    ZoomX : Single;
    ZoomY : Single;
  end;

// Rus: инициализация камеры по умолчанию.
// Eng:
procedure cam2d_DefInit(out Camera: zglTCamera2D);
// Rus: инициализация камеры с заданными значениями.
// Eng:
procedure cam2d_Init(x, y, angle: Single; out Camera: zglTCamera2D; zoom: Single = 1);
// Rus: задать координаты центра камеры. Вы должны точно определить координаты
//      центра камеры, перед тем как их задать!!!
// Eng:
procedure cam2d_CenterSet(Camera: zglPCamera2D; x, y: Single);
// Rus: установка используемой камеры (для прорисовки).
// Eng:
procedure cam2d_Set(Camera: zglPCamera2D);

var
  constCamera2D: zglTCamera2D = (X: 0; Y: 0; Angle: 0; Zoom: (X: 1; Y: 1); Center: (X: 0; Y: 0));
  cam2d        : zglPCameraSystem;
  cam2dTarget  : array[1..2] of zglTCameraSystem;

implementation
uses
  zgl_screen,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render_2d;

procedure cam2d_DefInit(out Camera: zglTCamera2D);
begin
  Camera.X        := 0;
  Camera.Y        := 0;
  Camera.Angle    := 0;
  Camera.Zoom.X   := 1;
  Camera.Zoom.Y   := 1;
  Camera.Center.X := (oglWidth - scrSubCX) / 2;
  Camera.Center.Y := (oglHeight - scrSubCY) / 2;
end;

procedure cam2d_Init(x, y, angle: Single; out Camera: zglTCamera2D; zoom: Single = 1);
begin
  Camera.X        := x;
  Camera.Y        := y;
  Camera.Angle    := angle;
  Camera.Zoom.X   := zoom;
  Camera.Zoom.Y   := zoom;
  // что-то надо делать с центром... но надо понять что...
  Camera.Center.X := (oglWidth - scrSubCX) / 2;
  Camera.Center.Y := (oglHeight - scrSubCY) / 2;
end;

procedure cam2d_CenterSet(Camera: zglPCamera2D; x, y: Single);
begin
  Camera^.Center.X := x;
  Camera^.Center.Y := y;
end;

procedure cam2d_Set(Camera: zglPCamera2D);
begin
  batch2d_Flush();

  if cam2d.Apply Then
    glPopMatrix();

  if Assigned(Camera) Then
  begin
    cam2d.Global := Camera;
    cam2d.Apply  := TRUE;
    cam2d.OnlyXY := (cam2d.Global.Angle = 0) and (cam2d.Global.Zoom.X = 1) and (cam2d.Global.Zoom.Y = 1);
    if (cam2d.ZoomX <> cam2d.Global.Zoom.X) or (cam2d.ZoomY <> cam2d.Global.Zoom.Y) Then
      render2dClipR := Round(sqrt(sqr((oglWidth - scrSubCX) / cam2d.Global.Zoom.X) + sqr((oglHeight - scrSubCY) / cam2d.Global.Zoom.Y)) / 1.5);
    cam2d.CX     := cam2d.Global.X + Camera^.Center.X;
    cam2d.CY     := cam2d.Global.Y + Camera^.Center.Y;
    cam2d.ZoomX  := cam2d.Global.Zoom.X;
    cam2d.ZoomY  := cam2d.Global.Zoom.Y;

    glPushMatrix();
    if not cam2d.OnlyXY Then
    begin
      glTranslatef(Camera^.Center.X, Camera^.Center.Y, 0);
      if Camera.Angle <> 0 Then
        glRotatef(Camera.Angle, 0, 0, 1);
      if (Camera^.Zoom.X <> 1) or (Camera^.Zoom.Y <> 1) Then
        glScalef(Camera^.Zoom.X, Camera^.Zoom.Y, 1);
      glTranslatef(- Camera^.Center.X, - Camera^.Center.Y, 0);
    end;
    if (Camera^.X <> 0) or (Camera^.Y <> 0) Then
      glTranslatef(Camera^.X, Camera^.Y, 0);

    sprite2d_InScreen := sprite2d_InScreenCamera;
  end else
  begin
    cam2d.Global := @constCamera2D;
    cam2d.Apply  := FALSE;
    sprite2d_InScreen := sprite2d_InScreenSimple;
  end;
end;

function cam2d_Get: zglPCamera2D;
begin
  Result := cam2d.Global;       
end;

initialization
  cam2d := @cam2dTarget[TARGET_SCREEN];
  with cam2dTarget[TARGET_SCREEN] do
    begin
      Global := @constCamera2D;
      OnlyXY := TRUE;
    end;
  with cam2dTarget[TARGET_TEXTURE] do
    begin
      Global := @constCamera2D;
      OnlyXY := TRUE;
    end;

end.
