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
unit gegl_drawElement;

interface

uses
  zgl_font,
  zgl_types,
  zgl_opengl_all,
  zgl_window,
  gegl_Types,
  gegl_VElements,
  zgl_fx,
  zgl_primitives_2d,
  zgl_render_2d;

// подготовка к выводу текста поля ввода, а так же созданной пользователем процедуры вывода окантовки поля ввода
procedure EditDraw(num: Word);
// вывод текста поля ввода, при выходе за пределы поля, производится обрезание текста.
procedure DrawTextEdit(Edit: geglPEdit);

implementation

procedure EditDraw(num: Word);
var
  UseText: geglPEdit;
begin
  UseText := managerSetOfTools.SetOfTools[num];

  glPushMatrix;
  glTranslatef(UseText^.mainRPoint.X, UseText^.mainRPoint.Y, 0);
  glRotatef(UseText^.Rotate, 0, 0, 1);
  glTranslatef(UseText^.Rect.X - UseText^.mainRPoint.x, UseText^.Rect.Y - UseText^.mainRPoint.Y, 0);

  if Assigned(UseText^.procEdit) then
    UseText^.procEdit;

  glTranslatef(- UseText^.translateX, 0, 0);
  if UseText^.EditString.UseLen > 0 then
    DrawTextEdit(UseText);

  if managerSetOfTools.ActiveElement = num then
    if UseText^.Cursor.NSleep > 0 then
    begin
      if UseText^.Cursor.Flags then                 
      begin                                        
        pr2d_Rect(UseText^.Cursor.curRect.X, UseText^.Cursor.curRect.Y, UseText^.Cursor.curRect.W,
                                             UseText^.Cursor.curRect.H, $FFFFFF, 160, PR2D_FILL);
      end;
      dec(UseText^.Cursor.NSleep);
    end
    else begin
      UseText^.Cursor.NSleep := 15;
      UseText^.Cursor.Flags := not (UseText^.Cursor.Flags);
    end;
  glPopMatrix;

  UseText := nil;
end;

procedure DrawTextEdit(Edit: geglPEdit);
var
  i: LongWord;
  charDesc: zglPCharDesc;
  lastPage: Integer;
  XLoop, YLoop: Single;

  xx1, xx2, yy1, yy2: Single;
  xTex1, yTex1, xTex2, yTex2: Single;
  useFont: zglPFont;
label
  StartLoop, EndLoop, NextLoop;
begin
  glColor4fv(@Edit^.ColorText);

  useFont := managerFont.Font[Edit^.font];
  i := 0;
  lastPage := -1;
  XLoop := 0;
  YLoop :=  - useFont^.MaxShiftY * useFont^.Scale;

StartLoop:
  if Edit^.EditString.CharSymb[i] = 0 then
    goto EndLoop;
  charDesc := useFont^.CharDesc[Edit^.EditString.CharSymb[i]];

  if not Assigned(charDesc) Then
    charDesc := useFont^.CharDesc[63];

  XLoop := Edit^.EditString.posX[i];

  xx1 := XLoop + charDesc^.xx1;
  xx2 := XLoop + charDesc^.xx2;

  xTex1 := charDesc^.TexCoords[0].X;
  xTex2 := charDesc^.TexCoords[1].X;

  if xx1 > Edit^.translateX + Edit^.Rect.W then
    goto EndLoop;
  if xx2 < Edit^.translateX then
    goto NextLoop;

  if xx1 < Edit^.translateX then
  begin
    xTex1 := xTex2 - (xx2 - Edit^.translateX) * (xTex2 - xTex1) / (xx2 - xx1);
    xx1 := Edit^.translateX;
  end;

  if xx2 > Edit^.translateX + Edit^.Rect.W then
  begin
    xTex2 := xTex2 - (xx2 - Edit^.translateX - Edit^.Rect.W) * (xTex2 - xTex1) / (xx2 - xx1);
    xx2 := Edit^.translateX + Edit^.Rect.W;
  end;

  if lastPage <> charDesc^.Page Then
  begin
    lastPage := charDesc^.Page;

    if (not b2dStarted) Then
    begin
      glEnd();

      glEnable(GL_BLEND);
      glEnable(GL_TEXTURE_2D);

      glBindTexture(GL_TEXTURE_2D, useFont^.Pages[lastPage]^.ID);
      glBegin(GL_QUADS);
    end else
      if batch2d_Check(GL_QUADS, FX_BLEND, useFont^.Pages[lastPage]) Then
      begin
        glEnable(GL_BLEND);

        glEnable(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, useFont^.Pages[lastPage]^.ID);
        glBegin(GL_QUADS);
      end;
  end;
  yTex1 := charDesc^.TexCoords[2].Y;
  yTex2 := charDesc^.TexCoords[0].Y;

  yy1 := YLoop + charDesc^.yy1;
  yy2 := YLoop + charDesc^.yy2;

  glTexCoord2f(xTex1, yTex2);
  glVertex2f(xx1, yy1);

  glTexCoord2f(xTex2, yTex2);
  glVertex2f(xx2, yy1);

  glTexCoord2f(xTex2, yTex1);
  glVertex2f(xx2, yy2);

  glTexCoord2f(xTex1, yTex1);
  glVertex2f(xx1, yy2);

NextLoop:

  inc(i);
  if i < MAX_SYMBOL_LINE then
    goto StartLoop;
EndLoop:
  if not b2dStarted Then
  begin
    glEnd();

    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
  end;
end;

end.

