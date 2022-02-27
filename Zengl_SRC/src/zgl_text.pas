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

 !!! modification from Serge 24.02.2022
}

unit zgl_text;

{$I zgl_config.cfg}

interface
uses
  zgl_font,
  zgl_gltypeconst,
  zgl_types
  {$IfNDef OLD_METHODS}
  , gegl_color
  {$EndIf}
  ;

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

// Rus: процедура вывода текста.
// Eng:
procedure text_Draw(fnt: LongWord; X, Y: Single; const Text: UTF8String; Flags: LongWord = 0);
// Rus: расширенная процедура вывода текста.
// Eng:
procedure text_DrawEx(fnt: LongWord; X, Y, Scale, Step: Single; const Text: UTF8String; {$IfDef OLD_METHODS} Alpha: Byte = 255; Color: LongWord = $FFFFFFFF;{$Else} Color: LongWord = cl_White;{$EndIf} Flags: LongWord = 0);
// Rus: процедура вывода текста в определённую область (прямоугольник).
// Eng:
procedure text_DrawInRect(fnt: LongWord; const Rect: zglTRect2D; const Text: UTF8String; Flags: LongWord = 0);
// Rus: расширенная процедура вывода текста в определённую область (прямоугольник).
// Eng:
procedure text_DrawInRectEx(fnt: LongWord; const Rect: zglTRect2D; Scale, Step: Single; const Text: UTF8String; {$IfDef OLD_METHODS} Alpha: Byte = 0; Color: LongWord = $FFFFFF;{$Else} Color: LongWord = cl_White;{$EndIf} Flags: LongWord = 0);
// Rus: возвращаем ширину текста.
// Eng:
function  text_GetWidth(fnt: LongWord; const Text: UTF8String; Step: Single = 0.0): Single;
// Rus: возвращаем высоту текста.
// Eng:
function  text_GetHeight(fnt: LongWord; Width: Single; const Text: UTF8String; Step: Single = 0.0): Single;
procedure textFx_SetLength(Length: Integer; LastCoord: zglPPoint2D = nil; LastCharDesc: zglPCharDesc = nil);
// Index - size, fnt - num font
procedure setFontTextScale(Index: LongWord; fnt: LongWord);
// Rus: установка флага отключения шкалы размерности. Только для функций,
//      которые используют свою собственную шкалу.
// Eng:
procedure setScallingOnOff(flag: Boolean); {$IfDef FPC}inline;{$EndIf}
// Rus: устанавливаем размер шкалы, для отключенного флага.
//      !!!Внимательние!!! Процедура меняет временную переменную - она будет
//      действовать для любого шрифта, даже если вы выбирали для какого-то
//      определённого, потому устанавливать размер шрифта, именно перед моментом
//      вывода шрифта значение переменной, может меняться, если вы использовали
//      procedure text_DrawEx или procedure text_DrawInRectEx - это правильное
//      поведение данной переменной.
// Eng:
procedure setTextScaleEx(Scale: Single; fnt:LongWord); {$IfDef FPC}inline;{$EndIf}
// Rus: возвращаем размер шкалы данного шрифта.
// Eng:
function getTextScale(fnt: LongWord): LongWord;
// Rus: возвращаем размерность шкалы, которая используется вне шрифтов.
// Eng:
function getTextScaleEx(): Single;
// Rus: устанавливаем стандартные значения цвета для любого текста.
//      Color - значение цвета.
// Eng:
procedure setTextColor(Color: Cardinal);

// Rus: загрузка текстового файла в формате UTF-8.
// Eng:
procedure txt_LoadFromFile(const FileName: UTF8String; out Buf: UTF8String);
// Rus: сохранение текстового UTF-8 файла.
// Eng:
procedure txt_SaveFromFile(const FileName: UTF8String; const Buf: UTF8String);

var
  TextScaleStandart : Single;
  // Rus: флаг, отвечающий за выключение шкалы размерности.
  // Eng:
  Off_TextScale: Boolean = false;
  // Rus: шкала для отключённых флагов, будет использоваться данная шкала, а не
  //      шкала заданная в шрифте.
  // Eng:
  useScaleEx: Single;

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
  zgl_file,
  zgl_log,
  zgl_utils;

type
  zglTTextWord = record
    X, Y, W: Integer;
    Str    : UTF8String;
end;

var
  textRGBA      : {$IfDef OLD_METHODS} array[0..3] of Byte = (255, 255, 255, 255){$Else}LongWord = $FFFFFFFF{$EndIf};
  textStep      : Single = 0.0;
  textLength    : Integer;
  textLCoord    : zglPPoint2D;
  textLCharDesc : zglPCharDesc;
  textWords     : array of zglTTextWord;
  textWordsCount: Integer;
  textLinesCount: Integer;

procedure setFontTextScale(Index: LongWord; fnt: LongWord);
var
  i: Integer;
  charDesc: zglPCharDesc;
  useFont: zglPFont;
begin
  if fnt > MAX_USE_FONT then
    exit;
  useFont := managerFont.Font[fnt];
  useFont.Scale := useFont.ScaleNorm * Index / 10;
  for i := 0 to 65535 do
  begin

    if Assigned(useFont.CharDesc[i]) then
      charDesc := useFont.CharDesc[i]
    else
      Continue;

    charDesc.xx1 := charDesc._x1 * useFont.Scale;
    charDesc.yy1 := charDesc._y1 * useFont.Scale;
    charDesc.xx2 := charDesc._x2 * useFont.Scale;
    charDesc.yy2 := charDesc._y2 * useFont.Scale;
  end;
  useFont._ShiftP63 := useFont.CharDesc[63]^.ShiftP * useFont.Scale;
  useFont := nil;
end;

procedure setScallingOnOff(flag: Boolean);
begin
  Off_TextScale := flag;
end;

procedure setTextScaleEx(Scale: Single; fnt:LongWord);
begin
  useScaleEx := Scale * managerFont.Font[fnt].ScaleNorm;
end;

function getTextScale(fnt: LongWord): LongWord;
begin
  Result := Round((managerFont.Font[fnt].Scale * 10) / managerFont.Font[fnt].ScaleNorm);
end;

function getTextScaleEx(): Single;
begin
  Result := useScaleEx;
end;

procedure setTextColor(Color: Cardinal);
begin
  {$IfDef OLD_METHODS}
  textRGBA[0] := Color shr 24;
  textRGBA[1] := (Color and $FF0000) shr 16;
  textRGBA[2] := (Color and $FF00) shr 8;
  textRGBA[3] := Color and $FF;
  {$else}
  textRGBA := Color;
  {$EndIf}
end;

procedure text_CalcRect(fnt: LongWord; const Rect: zglTRect2D; const Text: UTF8String; Flags: LongWord = 0);
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
  useFont   : zglPFont;
begin
  if (Text = '') or ((managerFont.Font[fnt].Flags and UseFnt) = 0) Then exit;

  useFont := managerFont.Font[fnt];
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
  y              := Round(Rect.Y) + 1 - Round(useFont.MaxHeight * useFont.Scale);
  while i <= Length(Text) do
  begin
    lc   := c;
    j    := i;
    c    := utf8_toUnicode(Text, i, @i);
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

    if ((c = 10) and (lc <> 10) and (lc <> 32)) or ((imax > 0) and (c <> 10)) Then
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
      textWords[curWord].W   := Round(text_GetWidth(fnt, textWords[curWord].Str, textStep));
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
      y := y + Round(useFont.MaxHeight * useFont.Scale);
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
      if (Flags and TEXT_CLIP_RECT > 0) and ((textLinesCount + 1) * useFont.MaxHeight > Rect.H) Then break;
    end;
  end;

  if Flags and TEXT_VALIGN_CENTER > 0 Then
  begin
    y := Round((Rect.Y + Rect.H - 1) - (textWords[textWordsCount - 1].Y + useFont.MaxHeight * useFont.Scale)) div 2;
    for i := 0 to textWordsCount - 1 do
      textWords[i].Y := textWords[i].Y + y;
  end else
    if Flags and TEXT_VALIGN_BOTTOM > 0 Then
    begin
      y := Round((Rect.Y + Rect.H - 1) - (textWords[textWordsCount - 1].Y + useFont.MaxHeight * useFont.Scale));
      for i := 0 to textWordsCount - 1 do
        textWords[i].Y := textWords[i].Y + y;
    end;
  useFont := nil;
end;

procedure text_Draw(fnt: LongWord; X, Y: Single; const Text: UTF8String; Flags: LongWord = 0);
  var
    i, c, s : LongWord;
    charDesc: zglPCharDesc;
    quad    : array[0..3] of zglTPoint2D;
    sx      : Single;
    lastPage: Integer;
    mode    : Integer;
    useFont : zglPFont;
begin
  if fnt > MAX_USE_FONT then
    exit;
  if (Text = '') or ((managerFont.Font[fnt].Flags and UseFnt) = 0) Then
    exit;
  useFont := managerFont.Font[fnt];
  for i := 0 to useFont.Count.Pages - 1 do
    if not Assigned(useFont.Pages[i]) Then exit;

  glColor4ubv(@textRGBA{$IfDef OLD_METHODS}[0]{$EndIf});

  if Off_TextScale then
    Y := Y - useFont.MaxShiftY * useScaleEx
  else
    Y := Y - useFont.MaxShiftY * useFont.Scale;

  if Flags and TEXT_HALIGN_CENTER > 0 Then
    X := X - Round(text_GetWidth(fnt, Text, textStep) / 2)
  else
    if Flags and TEXT_HALIGN_RIGHT > 0 Then
      X := X - Round(text_GetWidth(fnt, Text, textStep));
  sx := X;

  if Flags and TEXT_VALIGN_CENTER > 0 Then
    Y := Y - (useFont.MaxHeight div 2)
  else
    if Flags and TEXT_VALIGN_BOTTOM > 0 Then
      Y := Y - useFont.MaxHeight;

  FillChar(quad[0], SizeOf(zglTPoint2D) * 4, 0);
  charDesc := nil;
  lastPage := -1;
  c := utf8_toUnicode(Text, 1, @i);
  s := 1;
  i := 1;
  if Flags and TEXT_FX_VCA > 0 Then
    mode := GL_TRIANGLES
  else
    mode := GL_QUADS;
  if not b2dStarted Then
  begin
    if Assigned(useFont.CharDesc[c]) Then
    begin
      lastPage := useFont.CharDesc[c].Page;
      batch2d_Check(mode, FX_BLEND, useFont.Pages[useFont.CharDesc[c].Page]);

      glEnable(GL_BLEND);
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D, useFont.Pages[useFont.CharDesc[c].Page].ID);
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
      if Off_TextScale then
        Y := Y + useFont.MaxHeight * useScaleEx
      else
        Y := Y + useFont.MaxHeight * useFont.Scale;
    end;
    c := utf8_toUnicode(Text, i, @i);

    if (Flags and TEXT_FX_LENGTH > 0) and (s > textLength) Then
    begin
      if s > 1 Then
      begin
        if Assigned(textLCoord) Then
        begin
          if Off_TextScale then
          begin
            textLCoord.X := quad[0].X + useFont.Padding[PaddingX1] * useScaleEx;
            textLCoord.Y := quad[0].Y + useFont.Padding[PaddingY1] * useScaleEx;
          end
          else begin
            textLCoord.X := quad[0].X + useFont.Padding[PaddingX1] * useFont.Scale;
            textLCoord.Y := quad[0].Y + useFont.Padding[PaddingY1] * useFont.Scale;
          end;
        end;
        if Assigned(textLCharDesc) Then
          textLCharDesc^ := charDesc^;
      end;
      break;
    end;
    INC(s);

    charDesc := useFont.CharDesc[c];
    if (c = 10) and (c = 13) then
      Continue;
    if not Assigned(charDesc) Then
      charDesc := useFont.CharDesc[63];


    if lastPage <> charDesc.Page Then
    begin
      lastPage := charDesc.Page;

      if (not b2dStarted) Then
      begin
        glEnd();

        glBindTexture(GL_TEXTURE_2D, useFont.Pages[charDesc.Page].ID);
        glBegin(mode);
      end else
        if batch2d_Check(mode, FX_BLEND, useFont.Pages[charDesc.Page]) Then
        begin
          glEnable(GL_BLEND);

          glEnable(GL_TEXTURE_2D);
          glBindTexture(GL_TEXTURE_2D, useFont.Pages[charDesc.Page].ID);
          glBegin(mode);
        end;
    end;

    if Off_TextScale then
    begin
      quad[0].X := X + (charDesc.ShiftX - useFont.Padding[PaddingX1]) * useScaleEx;
      quad[0].Y := Y + (charDesc.ShiftY + useFont.MaxHeight - charDesc.Height - useFont.Padding[PaddingY1]) * useScaleEx;

      quad[1].X := X + (charDesc.ShiftX + charDesc.Width + useFont.Padding[PaddingX2]) * useScaleEx;
      quad[1].Y := quad[0].Y;

      quad[2].X := quad[1].X;
      quad[2].Y := Y + (charDesc.ShiftY + useFont.MaxHeight + useFont.Padding[PaddingY2]) * useScaleEx;

      quad[3].X := quad[0].X;
      quad[3].Y := quad[2].Y;
    end else
    begin
      quad[0].X := X + charDesc.xx1;
      quad[0].Y := Y + charDesc.yy1;

      quad[1].X := X + charDesc.xx2;
      quad[1].Y := Y + charDesc.yy1;

      quad[2].X := X + charDesc.xx2;
      quad[2].Y := Y + charDesc.yy2;

      quad[3].X := X + charDesc.xx1;
      quad[3].Y := Y + charDesc.yy2;
    end;

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

    if Off_TextScale then
      X := X + (charDesc.ShiftP + textStep) * useScaleEx
    else
      X := X + (charDesc.ShiftP + textStep) * useFont.Scale;
  end;

  if not b2dStarted Then
  begin
    glEnd();

    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
  end;
  useFont := nil;
end;

procedure text_DrawEx(fnt: LongWord; X, Y, Scale, Step: Single; const Text: UTF8String; {$IfDef OLD_METHODS} Alpha: Byte = 255; Color: LongWord = $FFFFFFFF;{$Else} Color: LongWord = cl_White;{$EndIf} Flags: LongWord = 0);
var
  oldTextRGBA: {$IfDef OLD_METHODS} array[0..3] of Byte = (255, 255, 255, 255){$Else}LongWord{$EndIf};
  oldTextStep: Single;
begin
  oldTextStep := textStep;
  {$IfDef OLD_METHODS}
  oldTextRGBA[0] := textRGBA[0];
  oldTextRGBA[1] := textRGBA[1];
  oldTextRGBA[2] := textRGBA[2];
  oldTextRGBA[3] := textRGBA[3];
  textRGBA[0] := Color shr 16;
  textRGBA[1] := (Color and $FF00) shr 8;
  textRGBA[2] := Color and $FF;
  textRGBA[3] := Alpha;
  {$Else}
  oldTextRGBA := textRGBA;
  textRGBA := Get_Color(Color);
  {$EndIf}
  Off_TextScale := True;
  useScaleEx := Scale * managerFont.Font[fnt].ScaleNorm;
  textStep    := Step;
  text_Draw(fnt, X, Y, Text, Flags);
  {$IfDef OLD_METHODS}
  textRGBA[0] := oldTextRGBA[0];
  textRGBA[1] := oldTextRGBA[1];
  textRGBA[2] := oldTextRGBA[2];
  textRGBA[3] := oldTextRGBA[3];
  {$Else}
  textRGBA := oldTextRGBA;
  {$EndIf}
  Off_TextScale := False;
  textStep    := oldTextStep;
end;

procedure text_DrawInRect(fnt: LongWord; const Rect: zglTRect2D; const Text: UTF8String; Flags: LongWord = 0);
  var
    i, j, b : Integer;
    NewFlags: Integer;
begin
  if (Text = '') or ((managerFont.Font[fnt].Flags and UseFnt) = 0) Then exit;

  text_CalcRect(fnt, Rect, Text, Flags);

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
    text_Draw(fnt, textWords[i].X, textWords[i].Y, textWords[i].Str, NewFlags);
  end;
end;

procedure text_DrawInRectEx(fnt: LongWord; const Rect: zglTRect2D; Scale, Step: Single; const Text: UTF8String; {$IfDef OLD_METHODS} Alpha: Byte = 0; Color: LongWord = $FFFFFF;{$Else} Color: LongWord = cl_White;{$EndIf} Flags: LongWord = 0);
var
  oldTextRGBA: {$IfDef OLD_METHODS} array[0..3] of Byte = (255, 255, 255, 255){$Else}LongWord{$EndIf};
  oldTextStep: Single;
begin
  oldTextStep := textStep;
  {$IfDef OLD_METHODS}
  oldTextRGBA[0] := textRGBA[0];
  oldTextRGBA[1] := textRGBA[1];
  oldTextRGBA[2] := textRGBA[2];
  oldTextRGBA[3] := textRGBA[3];
  textRGBA[0] := Color shr 16;
  textRGBA[1] := (Color and $FF00) shr 8;
  textRGBA[2] := Color and $FF;
  textRGBA[3] := Alpha;
  {$Else}
  oldTextRGBA := textRGBA;
  textRGBA := Get_Color(Color);
  {$EndIf}
  Off_TextScale := True;
  useScaleEx := Scale * managerFont.Font[fnt].ScaleNorm;
  textStep      := Step;
  text_DrawInRect(fnt, Rect, Text, Flags);
  {$IfDef OLD_METHODS}
  textRGBA[0] := oldTextRGBA[0];
  textRGBA[1] := oldTextRGBA[1];
  textRGBA[2] := oldTextRGBA[2];
  textRGBA[3] := oldTextRGBA[3];
  {$Else}
  textRGBA := oldTextRGBA;
  {$EndIf}
  Off_TextScale := False;
  textStep      := oldTextStep;
end;

function text_GetWidth(fnt: LongWord; const Text: UTF8String; Step: Single = 0.0): Single;
var
  i: Integer;
  c: LongWord;
  lResult: Single;
  useFont: zglPFont;
begin
  lResult := 0;
  Result  := 0;
  if (Text = '') or ((managerFont.Font[fnt].Flags and UseFnt) = 0) Then exit;
  i  := 1;
  useFont := managerFont.Font[fnt];
  while i <= Length(Text) do
  begin
    c := utf8_toUnicode(Text, i, @i);
    if c = 10 Then
    begin
      lResult := Result;
      Result  := 0;
    end else
      if Assigned(useFont.CharDesc[c]) Then
        if Off_TextScale Then
          Result := Result + useFont.CharDesc[c].ShiftP * useScaleEx + Step
        else
          Result := Result + useFont.CharDesc[c].ShiftP * useFont.Scale + Step;
  end;
  if lResult > Result Then
    Result := lResult;
end;

function text_GetHeight(fnt: LongWord; Width: Single; const Text: UTF8String; Step: Single = 0.0): Single;
  var
    Rect: zglTRect2D;
begin
  if (Text = '') or ((managerFont.Font[fnt].Flags and UseFnt) = 0) Then
  begin
    Result := 0;
    exit;
  end;

  Rect.X    := 0;
  Rect.Y    := 0;
  Rect.W    := Width;
  Rect.H    := 0;
  textStep  := Step;
  text_CalcRect(fnt, Rect, Text, TEXT_HALIGN_LEFT);
  if Off_TextScale Then
    Result := textWords[textWordsCount - 1].Y - textWords[0].Y + managerFont.Font[fnt].MaxHeight * useScaleEx
  else
    Result := textWords[textWordsCount - 1].Y - textWords[0].Y + managerFont.Font[fnt].MaxHeight * managerFont.Font[fnt].Scale;
  textStep  := 0;
end;

procedure textFx_SetLength(Length: Integer; LastCoord: zglPPoint2D = nil; LastCharDesc: zglPCharDesc = nil);
begin
  textLength    := Length;
  textLCoord    := LastCoord;
  textLCharDesc := LastCharDesc;
end;

procedure txt_LoadFromFile(const FileName: UTF8String; out Buf: UTF8String);
var
  Size: LongWord;
  f: zglTFile;
begin
  if not file_Exists(FileName) then
    exit;                      // file error = file not exist!!!

  if file_Open(f, FileName, FOM_OPENR) then
  begin
    Size := file_GetSize(f);
    SetLength(Buf, Size);
    file_Read(f, Buf[1], Size);
    file_Close(f);
    log_Add('File ' + FileName + ' loaded.');
  end;
end;

procedure txt_SaveFromFile(const FileName: UTF8String; const Buf: UTF8String);
var
  f: zglTFile;
begin
  if not file_Exists(FileName) then
    if file_Open(f, FileName, FOM_CREATE) then
    begin
      file_Write(f, Buf[1], Length(Buf));
      file_Close(f);
      log_Add('File ' + FileName + ' saved.');
    end else
      log_Add('File ' + FileName + ' not create!');
end;

initialization
  SetLength(textWords, 1024);

end.
