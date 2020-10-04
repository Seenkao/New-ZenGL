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

unit zgl_text;

{$I zgl_config.cfg}

interface
uses
  zgl_font,
  zgl_math_2d;

const
  TEXT_HALIGN_LEFT    = $000001;
  TEXT_HALIGN_CENTER  = $000002;
  TEXT_HALIGN_RIGHT   = $000004;
  TEXT_HALIGN_JUSTIFY = $000008;
  TEXT_VALIGN_TOP     = $000010;
  TEXT_VALIGN_CENTER  = $000020;
  TEXT_VALIGN_BOTTOM  = $000040;
  TEXT_CLIP_RECT      = $000080;
  TEXT_FX_VCA         = $000100;
  TEXT_FX_LENGTH      = $000200;

procedure text_Draw(Font: zglPFont; X, Y: Single; const Text: UTF8String; Flags: LongWord = 0);
procedure text_DrawEx(Font: zglPFont; X, Y, Scale, Step: Single; const Text: UTF8String; Alpha: Byte = 255; Color: LongWord = $FFFFFF; Flags: LongWord = 0);
procedure text_DrawInRect(Font: zglPFont; const Rect: zglTRect; const Text: UTF8String; Flags: LongWord = 0);
procedure text_DrawInRectEx(Font: zglPFont; const Rect: zglTRect; Scale, Step: Single; const Text: UTF8String; Alpha: Byte = 0; Color: LongWord = $FFFFFF; Flags: LongWord = 0);
function  text_GetWidth(Font: zglPFont; const Text: UTF8String; Step: Single = 0.0): Single;
function  text_GetHeight(Font: zglPFont; Width: Single; const Text: UTF8String; Scale: Single = 1.0; Step: Single = 0.0): Single;
procedure textFx_SetLength(Length: Integer; LastCoord: zglPPoint2D = nil; LastCharDesc: zglPCharDesc = nil);
procedure setTextScale(Index: Single);
procedure setTextColor(Color: Cardinal);

var
  TextScaleStandart : Single = 72;
  TextScaleNormal   : Single;
  textScale         : Single;

implementation
uses
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render,
  zgl_render_2d,
  zgl_fx,
  zgl_utils;

type
  zglTTextWord = record
    X, Y, W: Integer;
    Str    : UTF8String;
end;

var
  textRGBA      : array[0..3] of Byte = (255, 255, 255, 255);
  textStep      : Single = 0.0;
  textLength    : Integer;
  textLCoord    : zglPPoint2D;
  textLCharDesc : zglPCharDesc;
  textWords     : array of zglTTextWord;
  textWordsCount: Integer;
  textLinesCount: Integer;

procedure setTextScale(Index: Single);
begin
  textScale := TextScaleNormal * Index;
end;

procedure setTextColor(Color: Cardinal);
begin
  textRGBA[0] := Color shr 24;
  textRGBA[1] := (Color and $FF0000) shr 16;
  textRGBA[2] := (Color and $FF00) shr 8;
  textRGBA[3] := Color and $FF;
end;

procedure text_CalcRect(Font: zglPFont; const Rect: zglTRect; const Text: UTF8String; Flags: LongWord = 0);
  var
    x, y, sX  : Integer;
    b, i, imax: Integer;
    c, lc     : LongWord;
    curWord, j: Integer;
    newLine   : Integer;
    lineWidth : Integer;
    startWord : Boolean;
    newWord   : Boolean;
    lineEnd   : Boolean;
    lineFeed  : Boolean;
begin
  if (Text = '') or (not Assigned(Font)) Then exit;

  i              := 1;
  b              := 1;
  c              := 32;
  curWord        := 0;
  newLine        := 0;
  lineWidth      := 0;
  textWordsCount := 0;
  textLinesCount := 0;
  startWord      := FALSE;
  newWord        := FALSE;
  lineEnd        := FALSE;
  lineFeed       := FALSE;
  x              := Round(Rect.X) + 1;
  y              := Round(Rect.Y) + 1 - Round(Font.MaxHeight * textScale);
  while i <= Length(Text) do
  begin
    lc   := c;
    j    := i;
    c    := utf8_GetID(Text, i, @i);
    imax := Integer(i > Length(Text));

    if (not startWord) and ((c = 32) or (c <> 10)) Then
    begin
      b := j - 1 * Integer(curWord > 0) + Integer(lc = 10);
      while lineEnd and (Text[b] = ' ') do
        INC(b);
      startWord := TRUE;
      lineEnd   := FALSE;
      if imax = 0 Then
        continue;
    end;

    if (c = 32) and (startWord) and (lc <> 10) and (lc <> 32) Then
    begin
      newWord   := TRUE;
      startWord := FALSE;
    end;

    if ((c = 10) and (lc <> 10) and (lc <> 32)) or (imax > 0) Then
    begin
      newWord   := TRUE;
      startWord := FALSE;
      lineFeed  := TRUE;
    end else
      if c = 10 Then
      begin
        startWord := FALSE;
        lineFeed  := TRUE;
      end;

    if newWord Then
    begin
      textWords[curWord].Str := Copy(Text, b, i - b - (1 - imax));
      textWords[curWord].W   := Round(text_GetWidth(Font, textWords[curWord].Str, textStep));// * textScale);
      lineWidth                := lineWidth + textWords[curWord].W;

      newWord := FALSE;
      INC(curWord);
      INC(textWordsCount);
      if (lineWidth > Rect.W - 2) and (curWord - newLine > 1) Then
      begin
        lineEnd := TRUE;
        i := b;
        while Text[i] = ' ' do
          INC(i);
        DEC(curWord);
        DEC(textWordsCount);
      end;
      if textWordsCount > High(textWords) Then
        SetLength(textWords, Length(textWords) + 1024);
    end;

    if lineFeed or lineEnd Then
    begin
      y := y + Round(Font.MaxHeight * textScale);
      textWords[newLine].X := x;
      textWords[newLine].Y := y;
      for j := newLine + 1 to curWord - 1 do
      begin
        textWords[j].X := textWords[j - 1].X + textWords[j - 1].W;
        textWords[j].Y := textWords[newLine].Y;
      end;

      if (Flags and TEXT_HALIGN_JUSTIFY > 0) and (curWord - newLine > 1) and (c <> 10) and (imax = 0) Then
      begin
        sX := Round(Rect.X + Rect.W - 1) - (textWords[curWord - 1].X + textWords[curWord - 1].W);
        while sX > (curWord - 1) - newLine do
        begin
          for j := newLine + 1 to curWord - 1 do
            INC(textWords[j].X, 1 + (j - (newLine + 1)));
          sX := Round(Rect.X + Rect.W - 1) - (textWords[curWord - 1].X + textWords[curWord - 1].W);
        end;
        textWords[curWord - 1].X := textWords[curWord - 1].X + sX;
      end else
        if Flags and TEXT_HALIGN_CENTER > 0 Then
        begin
          sX := (Round(Rect.X + Rect.W - 1) - (textWords[curWord - 1].X + textWords[curWord - 1].W)) div 2;
          for j := newLine to curWord do
            textWords[j].X := textWords[j].X + sX;
        end else
          if Flags and TEXT_HALIGN_RIGHT > 0 Then
          begin
            sX := Round(Rect.X + Rect.W - 1) - (textWords[curWord - 1].X + textWords[curWord - 1].W);
            for j := newLine to curWord do
            textWords[j].X := textWords[j].X + sX;
          end;

      newLine   := curWord;
      lineWidth := 0;
      lineFeed  := FALSE;
      INC(textLinesCount);
      if (Flags and TEXT_CLIP_RECT > 0) and ((textLinesCount + 1) * Font.MaxHeight > Rect.H) Then break;
    end;
  end;

  if Flags and TEXT_VALIGN_CENTER > 0 Then
  begin
    y := Round((Rect.Y + Rect.H - 1) - (textWords[textWordsCount - 1].Y + Font.MaxHeight * textScale)) div 2;
    for i := 0 to textWordsCount - 1 do
      textWords[i].Y := textWords[i].Y + y;
  end else
    if Flags and TEXT_VALIGN_BOTTOM > 0 Then
    begin
      y := Round((Rect.Y + Rect.H - 1) - (textWords[textWordsCount - 1].Y + Font.MaxHeight * textScale));
      for i := 0 to textWordsCount - 1 do
        textWords[i].Y := textWords[i].Y + y;
    end;
end;

procedure text_Draw(Font: zglPFont; X, Y: Single; const Text: UTF8String; Flags: LongWord = 0);
  var
    i, c, s : Integer;
    charDesc: zglPCharDesc;
    quad    : array[0..3] of zglTPoint2D;
    sx      : Single;
    lastPage: Integer;
    mode    : Integer;
begin
  if (Text = '') or (not Assigned(Font)) Then exit;
  for i := 0 to Font.Count.Pages - 1 do
    if not Assigned(Font.Pages[i]) Then exit;

  glColor4ubv(@textRGBA[0]);

  Y := Y - Font.MaxShiftY * textScale;
  if Flags and TEXT_HALIGN_CENTER > 0 Then
    X := X - Round(text_GetWidth(Font, Text, textStep) / 2)
  else
    if Flags and TEXT_HALIGN_RIGHT > 0 Then
      X := X - Round(text_GetWidth(Font, Text, textStep));
  sx := X;

  if Flags and TEXT_VALIGN_CENTER > 0 Then
    Y := Y - (Font.MaxHeight div 2) //* textScale
  else
    if Flags and TEXT_VALIGN_BOTTOM > 0 Then
      Y := Y - Font.MaxHeight; //* textScale;

  FillChar(quad[0], SizeOf(zglTPoint2D) * 4, 0);
  charDesc := nil;
  lastPage := -1;
  c := utf8_GetID(Text, 1, @i);
  s := 1;
  i := 1;
  if Flags and TEXT_FX_VCA > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_QUADS;
  if not b2dStarted Then
  begin
    if Assigned(Font.CharDesc[c]) Then
    begin
      lastPage := Font.CharDesc[c].Page;
      batch2d_Check(mode, FX_BLEND, Font.Pages[Font.CharDesc[c].Page]);

      glEnable(GL_BLEND);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, Font.Pages[Font.CharDesc[c].Page].ID);
      glBegin(mode);
    end else
    begin
      glEnable(GL_BLEND);
      glEnable(GL_TEXTURE_2D);
      glBegin(mode);
    end;
  end;
  while i <= Length(Text) do
  begin
    if Text[i] = #10 Then
    begin
      X := sx;
      Y := Y + Font.MaxHeight * textScale;
    end;
    c := utf8_GetID(Text, i, @i);

    if (Flags and TEXT_FX_LENGTH > 0) and (s > textLength) Then
    begin
      if s > 1 Then
      begin
        if Assigned(textLCoord) Then
        begin
          textLCoord.X := quad[0].X + Font.Padding[0] * textScale;
          textLCoord.Y := quad[0].Y + Font.Padding[1] * textScale;
        end;
        if Assigned(textLCharDesc) Then
          textLCharDesc^ := charDesc^;
      end;
      break;
    end;
    INC(s);

    charDesc := Font.CharDesc[c];
    if not Assigned(charDesc) Then continue;

    if lastPage <> charDesc.Page Then
    begin
      lastPage := charDesc.Page;

      if (not b2dStarted) Then
      begin
        glEnd();

        glBindTexture(GL_TEXTURE_2D, Font.Pages[charDesc.Page].ID);
        glBegin(mode);
      end else
        if batch2d_Check(mode, FX_BLEND, Font.Pages[charDesc.Page]) Then
        begin
          glEnable(GL_BLEND);

          glEnable(GL_TEXTURE_2D);
          glBindTexture(GL_TEXTURE_2D, Font.Pages[charDesc.Page].ID);
          glBegin(mode);
        end;
    end;

    quad[0].X := X + (charDesc.ShiftX - Font.Padding[0]) * textScale;
    quad[0].Y := Y + (charDesc.ShiftY + (Font.MaxHeight - charDesc.Height) - Font.Padding[1]) * textScale;
    quad[1].X := X + (charDesc.ShiftX + charDesc.Width + Font.Padding[2]) * textScale;
    quad[1].Y := Y + (charDesc.ShiftY + (Font.MaxHeight - charDesc.Height) - Font.Padding[1]) * textScale;
    quad[2].X := X + (charDesc.ShiftX + charDesc.Width + Font.Padding[2]) * textScale;
    quad[2].Y := Y + (charDesc.ShiftY + charDesc.Height + (Font.MaxHeight - charDesc.Height) + Font.Padding[3]) * textScale;
    quad[3].X := X + (charDesc.ShiftX - Font.Padding[0]) * textScale;
    quad[3].Y := Y + (charDesc.ShiftY + charDesc.Height + (Font.MaxHeight - charDesc.Height) + Font.Padding[3]) * textScale;

    if Flags and TEXT_FX_VCA > 0 Then
    begin
      glColor4f(fx2dVCA[0, 0], fx2dVCA[0, 1], fx2dVCA[0, 2], fx2dVCA[0, 3]);
      glTexCoord2fv(@charDesc.TexCoords[0]);
      glVertex2fv(@quad[0]);

      glColor4f(fx2dVCA[1, 0], fx2dVCA[1, 1], fx2dVCA[1, 2], fx2dVCA[1, 3]);
      glTexCoord2fv(@charDesc.TexCoords[1]);
      glVertex2fv(@quad[1]);

      glColor4f(fx2dVCA[2, 0], fx2dVCA[2, 1], fx2dVCA[2, 2], fx2dVCA[2, 3]);
      glTexCoord2fv(@charDesc.TexCoords[2]);
      glVertex2fv(@quad[2]);

      glColor4f(fx2dVCA[4, 0], fx2dVCA[4, 1], fx2dVCA[4, 2], fx2dVCA[4, 3]);
      glTexCoord2fv(@charDesc.TexCoords[2]);
      glVertex2fv(@quad[2]);

      glColor4f(fx2dVCA[5, 0], fx2dVCA[5, 1], fx2dVCA[5, 2], fx2dVCA[5, 3]);
      glTexCoord2fv(@charDesc.TexCoords[3]);
      glVertex2fv(@quad[3]);

      glColor4f(fx2dVCA[3, 0], fx2dVCA[3, 1], fx2dVCA[3, 2], fx2dVCA[3, 3]);
      glTexCoord2fv(@charDesc.TexCoords[0]);
      glVertex2fv(@quad[0]);
    end else
    begin
      glTexCoord2fv(@charDesc.TexCoords[0]);
      glVertex2fv(@quad[0]);

      glTexCoord2fv(@charDesc.TexCoords[1]);
      glVertex2fv(@quad[1]);

      glTexCoord2fv(@charDesc.TexCoords[2]);
      glVertex2fv(@quad[2]);

      glTexCoord2fv(@charDesc.TexCoords[3]);
      glVertex2fv(@quad[3]);
    end;

    X := X + (charDesc.ShiftP + textStep) * textScale;
  end;

  if not b2dStarted Then
  begin
    glEnd();

    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
  end;
end;

procedure text_DrawEx(Font: zglPFont; X, Y, Scale, Step: Single; const Text: UTF8String; Alpha: Byte = 255; Color: LongWord = $FFFFFF; Flags: LongWord = 0);
begin
  textRGBA[0] := Color shr 16;
  textRGBA[1] := (Color and $FF00) shr 8;
  textRGBA[2] := Color and $FF;
  textRGBA[3] := Alpha;
  textScale   := TextScaleNormal * Scale;
  textStep    := Step;
  text_Draw(Font, X, Y, Text, Flags);
  textRGBA[0] := 255;
  textRGBA[1] := 255;
  textRGBA[2] := 255;
  textRGBA[3] := 255;
  textScale   := TextScaleNormal;
  textStep    := 0;
end;

procedure text_DrawInRect(Font: zglPFont; const Rect: zglTRect; const Text: UTF8String; Flags: LongWord = 0);
  var
    i, j, b : Integer;
    NewFlags: Integer;
begin
  if (Text = '') or (not Assigned(Font)) Then exit;

  text_CalcRect(Font, Rect, Text, Flags);

  NewFlags := 0;
  if Flags and TEXT_FX_VCA > 0 Then
    NewFlags := NewFlags or TEXT_FX_VCA;
  if Flags and TEXT_FX_LENGTH > 0 Then
    NewFlags := NewFlags or TEXT_FX_LENGTH;

  j := 0;
  b := textLength;
  for i := 0 to textWordsCount - 1 do
  begin
    if Flags and TEXT_FX_LENGTH > 0 Then
    begin
      textFx_SetLength(b - j, textLCoord, textLCharDesc);
      if j > b Then continue;
      j := j + utf8_Length(textWords[i].Str);
    end;
    text_Draw(Font, textWords[i].X, textWords[i].Y, textWords[i].Str, NewFlags);
  end;
end;

procedure text_DrawInRectEx(Font: zglPFont; const Rect: zglTRect; Scale, Step: Single; const Text: UTF8String; Alpha: Byte = 0; Color: LongWord = $FFFFFF; Flags: LongWord = 0);
begin
  textRGBA[0] :=   Color             shr 16;
  textRGBA[1] := (Color and $FF00) shr 8;
  textRGBA[2] :=   Color and $FF;
  textRGBA[3] := Alpha;
  textScale     := TextScaleNormal * Scale;
  textStep      := Step;
  text_DrawInRect(Font, Rect, Text, Flags);
  textRGBA[0] := 255;
  textRGBA[1] := 255;
  textRGBA[2] := 255;
  textRGBA[3] := 255;
  textScale     := TextScaleNormal;
  textStep      := 0;
end;

function text_GetWidth(Font: zglPFont; const Text: UTF8String; Step: Single = 0.0): Single;
  var
    i: Integer;
    c: LongWord;
    lResult: Single;
begin
  lResult := 0;
  Result  := 0;
  if (Text = '') or (not Assigned(Font)) Then exit;
  i  := 1;
  while i <= Length(Text) do
  begin
    c := utf8_GetID(Text, i, @i);
    if c = 10 Then
    begin
      lResult := Result;
      Result  := 0;
    end else
      if Assigned(Font.CharDesc[c]) Then
        Result := Result + Font.CharDesc[c].ShiftP * textScale + Step;
  end;
  if lResult > Result Then
    Result := lResult;
end;

function text_GetHeight(Font: zglPFont; Width: Single; const Text: UTF8String; Scale: Single = 1.0; Step: Single = 0.0): Single;
  var
    Rect: zglTRect;
begin
  if (Text = '') or (not Assigned(Font)) Then
  begin
    Result := 0;
    exit;
  end;

  Rect.X    := 0;
  Rect.Y    := 0;
  Rect.W    := Width;
  Rect.H    := 0;
  textScale := TextScaleNormal * Scale;
  textStep  := Step;
  text_CalcRect(Font, Rect, Text, TEXT_HALIGN_LEFT);
  Result := textWords[textWordsCount - 1].Y - textWords[0].Y + Font.MaxHeight * Scale;
  textScale := TextScaleNormal;
  textStep  := 0;
end;

procedure textFx_SetLength(Length: Integer; LastCoord: zglPPoint2D = nil; LastCharDesc: zglPCharDesc = nil);
begin
  textLength    := Length;
  textLCoord    := LastCoord;
  textLCharDesc := LastCharDesc;
end;

initialization
  SetLength(textWords, 1024);

end.
