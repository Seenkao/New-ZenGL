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
unit gegl_VElements;
{$I zgl_config.cfg}

interface

uses
  gegl_Types,
  zgl_types,
  zgl_utils,
  zgl_font,
  zgl_keyboard,
  zgl_timers,
  gegl_utils,
  zgl_mouse,
  zgl_collision_2d,
  zgl_window;

var
  // менеджер элементов
  managerSetOfTools: geglTSetOfToolsManager;

// RU: создание поля ввода. Заданный прямоугольник, шрифт, рзмер шрифта, заданная процедура, длина строки.
//     по умолчанию, заданной процедуры нет, длина строки = 80.
// EN: creating an input field. Specified rectangle, font, font size, specified procedure, line length.
//     there is no defined procedure by default, line length = 80.
function CreateEdit(Rect: zglTRect; fnt, Scale: Byte; UserData: Pointer = nil; Len: Word = MAX_SYMBOL_LINE): Word;         // функция с запасом на будущее
// RU: обработка событий поля ввода, вызывать не надо. Менеджер всё сделает за вас.
// EN: event handling of the input field, no need to call. The manager will do everything for you.
procedure EventsEdit(num: Word);
// RU: установка цвета фона создаваемого поля ввода (или какого-то другого элемента).
// EN: setting the background color of the created input field (or some other element).
procedure SetColorBackElement(Color: zglPColor); {$IfNDef DELPHI7_AND_DOWN} inline; {$EndIf}
// RU: установка цвета текста создаваемого элемента. Запускать до создания элемента API!!!
// EN: setting the text color of the created element. Run before API element is created !!!
procedure SetColorElementText(Color: zglPColor); {$IfNDef DELPHI7_AND_DOWN} inline; {$EndIf}
// RU: удаление определённого элемента API, по его номеру. И без разницы какой это элемент, он будет удалён, не выключен.
// EN: deleting a specific API element by its number. And no matter what element it is, it will be deleted, not turned off.
procedure DeleteElementSOT(ID: Byte);
// RU: уничтожение всех элементов API. Вызывать не нужно!!! Производится по закрытию программы!!!
// EN: destruction of all API elements. Don't Run !!! It is performed when the program is closed !!!
procedure DestroyManagerSOT();
// RU: Установка точки вращения и угла вращения (если это необходимо).
//     Обратить внимание! Заданная точка, будет работать для всех элементов!!! Потому, для создания нового элемента,
//     её надо пересчитать или обнулить. Запускать до создания элемента API!!!
// EN: Set pivot point and pivot angle (if necessary).
//     Note! The set point will work for all elements !!! Therefore, to create a new element, it must be recalculated
//     or reset to zero. Run before API element is created !!!
procedure SetOfRotateAngleAndPoint(x, y: Single; angle: Single = 0); {$IfNDef DELPHI7_AND_DOWN} inline; {$EndIf}
// RU: возвращаем текст из строки
// EN: return text from string
function GetEditToText(num: Word): UTF8String;
// RU: корректировка курсора, + - вниз. Курсор может быть не правильно скорректирован, это зависит от используемого шрифта.
//     Надо настраивать вручную для разных шрифтов.
// EN: cursor adjustment, + - down. The cursor may not be adjusted correctly, depending on the font used.
//     Must be manually configured for different fonts.
procedure CorrectEditCursor(num: Word; y: Single);
// RU: активация поля ввода. Сделано автоматическое, при нажатии мыши на поле ввода. Но это можно отключить и по своему
//     событию произвести активацию.
// EN: activation of the input field. Made automatic when clicking on the input field. But this can be turned off and
//     activated according to your event.
procedure ActivateEdit(num: Word);

implementation

var
  // RU: поле ввода (пока просто вывода текста)
  UseText: geglPEdit;
  StColorBackElement: array[0..3] of Single = (0, 0, 0, 1);
  StColorTextEl: array[0..3] of Single = (1, 1, 1, 1);
  pointManager: zglTPoint2D = (x: 0; y: 0);
  geAngle: Single = 0;

function CreateEdit(Rect: zglTRect; fnt, Scale: Byte; UserData: Pointer = nil; Len: Word = MAX_SYMBOL_LINE): Word;
var
  {$IFDEF DELPHI7_AND_DOWN}
  z: Pointer;
  {$ENDIF}
  i: LongWord;
begin
  if managerSetOfTools.count >= managerSetOfTools.maxPossibleEl then
  begin
    managerSetOfTools.maxPossibleEl := managerSetOfTools.maxPossibleEl + 5;
    SetLength(managerSetOfTools.SetOfTools, managerSetOfTools.maxPossibleEl);
    SetLength(managerSetOfTools.propElement, managerSetOfTools.maxPossibleEl);

    for i := managerSetOfTools.count to managerSetOfTools.maxPossibleEl - 1 do
      managerSetOfTools.propElement[i].Flags := 0;
  end;

  for i := 0 to managerSetOfTools.maxPossibleEl - 1 do
  begin
    UseText := managerSetOfTools.SetOfTools[i];
    if not Assigned(UseText) then
      Break;
    if (managerSetOfTools.propElement[i].Flags and Enable) = 0 then
      Break;
  end;

  if not Assigned(UseText) then
  begin
    {$IFDEF DELPHI7_AND_DOWN}
    zgl_GetMem(z, SizeOf(geglTEdit));
    UseText := z;
    {$ELSE}
    zgl_GetMem(UseText, SizeOf(geglTEdit));
    {$ENDIF}
    managerSetOfTools.SetOfTools[managerSetOfTools.count] := UseText;
  end;

  managerSetOfTools.propElement[i].Element := _Edit;
  managerSetOfTools.propElement[i].Flags := managerSetOfTools.propElement[i].Flags or Enable or Visible;
  Result := i;

  UseText^.Rect.X := Rect.X;
  UseText^.Rect.Y := Rect.Y;
  UseText^.Rect.W := Rect.W;
  UseText^.Rect.H := Rect.H;
  UseText^.ColorText.R := StColorTextEl[0];
  UseText^.ColorText.G := StColorTextEl[1];
  UseText^.ColorText.B := StColorTextEl[2];
  UseText^.ColorText.A := StColorTextEl[3];
  UseText^.Scale := Scale;
  UseText^.Rotate := geAngle;
  UseText^.EditString.Len := Len;
  SetLength(UseText^.EditString.CharSymb, Len + 1);
  SetLength(UseText^.EditString.posX, len + 1);
  UseText^.EditString.UseLen := 0;
  i := 0;
  while i <= Len do
  begin
    UseText^.EditString.posX[i] := 0;
    inc(i);
  end;

  UseText^.Cursor.curRect.X := 0;
  UseText^.Cursor.curRect.Y := 1.2 * Scale;
  UseText^.Cursor.curRect.H := 2;
  UseText^.Cursor.curRect.W := 6 * Scale / 10;
  UseText^.Cursor.NSleep := CUR_FLASH;
  UseText^.Cursor.Flags := False;
  UseText^.Cursor.position := 1;
  UseText^.translateX := 0;
  UseText^.mainRPoint := pointManager;
  UseText^.font := fnt;
  UseText^.procEdit := UserData;
  inc(managerSetOfTools.count);
end;

procedure EventsEdit(num: Word);
var
  symb, i, j, n: LongWord;
  _JcharSymb: zglPCharDesc;
  t: Double;
  _ShiftP: Single;
  mDX, mDY: Single;

  useFont: zglPFont;

  sinAngle, cosAngle: Single;
label
  smallJmp, jmpEnd, jmpMouse;

  procedure SetCursorPosAndWidth;
  begin
    UseText^.Cursor.curRect.x := UseText^.EditString.posX[UseText^.Cursor.position - 1];
    if (UseText^.Cursor.position <= UseText^.EditString.Len) and (UseText^.Cursor.position <= UseText^.EditString.UseLen) then
    begin
      _JcharSymb := useFont^.CharDesc[UseText^.EditString.CharSymb[UseText^.Cursor.position - 1]];
      if Assigned(_JcharSymb) then
        if UseText^.EditString.CharSymb[UseText^.Cursor.position - 1] <> 9 then
          UseText^.Cursor.curRect.W := _JcharSymb^.ShiftP * useFont^.Scale
        else
          UseText^.Cursor.curRect.W := useFont^._ShiftP63;
      end
      else
        UseText^.Cursor.curRect.W := 6 * UseText^.Scale / 10;
  end;

  procedure RollEditLeft;
  begin
    SetCursorPosAndWidth;

    if UseText^.translateX > 0 then
      if (UseText^.Cursor.curRect.X - 40) < UseText^.translateX then
        UseText^.translateX := UseText^.Cursor.curRect.X - 40;
    if UseText^.translateX < 0 then
      UseText^.translateX := 0;
  end;

  procedure RollEditRight;
  begin
    SetCursorPosAndWidth;

    if UseText^.EditString.UseLen < UseText^.Cursor.position then
    begin
      if (UseText^.Cursor.curRect.x + UseText^.Cursor.curRect.W + UseText^.translateX) > (UseText^.Rect.W) then
      begin
        UseText^.translateX := (UseText^.Cursor.curRect.x + UseText^.Cursor.curRect.W) - (UseText^.Rect.W );
      end;
    end
    else begin
      if ((UseText^.Cursor.curRect.X - UseText^.translateX) > (UseText^.Rect.W - 60)) and
            ((UseText^.EditString.posX[UseText^.EditString.UseLen] - UseText^.translateX) > UseText^.Rect.W) then
      begin
          UseText^.translateX := (UseText^.Cursor.curRect.x + 60) - (UseText^.Rect.W );
          if (UseText^.Rect.W + UseText^.translateX) > UseText^.EditString.posX[UseText^.EditString.UseLen] then
            UseText^.translateX := UseText^.EditString.posX[UseText^.EditString.UseLen] - UseText^.Rect.W;
      end;
    end;
  end;

begin
  UseText := managerSetOfTools.SetOfTools[num];
  useFont := managerFont.Font[UseText^.font];
  if managerSetOfTools.ActiveElement <> num then
    goto jmpMouse;

  if keysUp[K_INSERT] then
    if ((keybFlags and keyboardInsert) > 0) then
      UseText^.Cursor.curRect.H :=  - UseText^.Scale * 1.2
    else
      UseText^.Cursor.curRect.H := 2;

  if keysLast[KA_DOWN] > 0 then
  begin
    t := timer_GetTicks;
    if keysLast[KA_DOWN] <> keysLast[KT_DOWN] then
    begin
      keysLast[KT_DOWN] := keysLast[KA_DOWN];
      keyDownRepeat := t;
      keyDelayWork := beginKeyDelay;
    end
    else
      if t - keyDownRepeat > keyDelayWork then
      begin
        keyDownRepeat := t;
        keyDelayWork := repeatKeyDelay;
      end
      else
        Exit;

    case keysLast[KA_DOWN] of
      K_ESCAPE: exit;
      K_UP: ;
      K_DOWN: ;
      K_LEFT:
        begin
          if UseText^.Cursor.position = 1 then
            exit;
          if keysDown[K_CTRL] then
          begin
            i := UseText^.Cursor.position;
            j := 0;
            if (UseText^.EditString.CharSymb[i - 2] = 32) or (UseText^.EditString.CharSymb[i - 2] = 9) then
              dec(i, 2);
            while i > 1 do
            begin
              if (j > 0) and ((UseText^.EditString.CharSymb[i - 1] = 32) or (UseText^.EditString.CharSymb[i - 1] = 9)) then
              begin
                if (UseText^.EditString.CharSymb[i] <> 32) and (UseText^.EditString.CharSymb[i] <> 9) then
                begin
                  UseText^.Cursor.position := i + 1;
                  RollEditLeft;
                  exit;
                end;
              end
              else
                inc(j);

              dec(i);
            end;
            UseText^.Cursor.position := 1;
          end
          else begin
            dec(UseText^.Cursor.position);
          end;
          RollEditLeft;
        end;
      K_RIGHT:
        Begin
          if UseText^.Cursor.position > UseText^.EditString.UseLen then
            Exit;
          if keysDown[K_CTRL] then
          begin
            i := UseText^.Cursor.position;
            j := 0;
            if (UseText^.EditString.CharSymb[i] = 32) or (UseText^.EditString.CharSymb[i] = 9) then
              inc(i, 2);
            while i < UseText^.EditString.UseLen + 1 do
            begin
              if (j > 0) and ((UseText^.EditString.CharSymb[i - 1] = 32) or (UseText^.EditString.CharSymb[i - 1] = 9)) then
              begin
                if (UseText^.EditString.CharSymb[i - 2] <> 32) and (UseText^.EditString.CharSymb[i - 2] <> 9) then
                begin
                  UseText^.Cursor.position := i - 1;
                  RollEditRight;
                  exit;
                end;
              end
              else
                inc(j);

              inc(i);
            end;
            UseText^.Cursor.position := UseText^.EditString.UseLen + 1;
          end
          else begin
            inc(UseText^.Cursor.position);
          end;
          RollEditRight;
        end;
      K_BACKSPACE:
        begin
          if (UseText^.Cursor.position = 1) or (UseText^.EditString.UseLen = 0) then
            Exit;

          dec(UseText^.Cursor.position);
          dec(UseText^.EditString.UseLen);
          if UseText^.Cursor.position > UseText^.EditString.UseLen then
            UseText^.EditString.CharSymb[UseText^.EditString.UseLen] := 0
          else begin
            i :=  UseText^.EditString.UseLen - (UseText^.Cursor.position - 1);
            j := UseText^.Cursor.position;
            while i > 0 do
            begin
              UseText^.EditString.CharSymb[j - 1] := UseText^.EditString.CharSymb[j];
              UseText^.EditString.posX[j] := UseText^.EditString.posX[j - 1] +
                  useFont^.CharDesc[UseText^.EditString.CharSymb[j - 1]]^.ShiftP * useFont^.Scale;
              inc(j);
              dec(i);
            end;
            UseText^.EditString.CharSymb[j - 1] := 0;
          end;
          RollEditLeft;
        end;
      K_DELETE:
        begin
          if (UseText^.EditString.UseLen = 0) or (UseText^.EditString.UseLen < UseText^.Cursor.position) then
            Exit;

          dec(UseText^.EditString.UseLen);
          if UseText^.Cursor.position > UseText^.EditString.UseLen then
            UseText^.EditString.CharSymb[UseText^.Cursor.position - 1] := 0
          else begin
            j := UseText^.Cursor.position;
            while j <= UseText^.EditString.UseLen do
            begin
              UseText^.EditString.CharSymb[j - 1] := UseText^.EditString.CharSymb[j];
              UseText^.EditString.posX[j] := UseText^.EditString.posX[j - 1] +
                  useFont^.CharDesc[UseText^.EditString.CharSymb[j - 1]]^.ShiftP * useFont^.Scale;
              inc(j);
            end;
            UseText^.EditString.CharSymb[j - 1] := 0;
          end;
          RollEditLeft;
        end;
      K_HOME:
        begin
          if UseText^.EditString.UseLen = 0 then
          begin
            UseText^.Cursor.position := 1;
            exit;
          end;
          UseText^.Cursor.position := 1;
          RollEditLeft;
        end;
      K_END:
        begin
          if UseText^.EditString.UseLen = 0 then
          begin
            UseText^.Cursor.position := 1;
            exit;
          end;
          UseText^.Cursor.position := UseText^.EditString.UseLen + 1;
          RollEditRight;
        end;
      K_PAGEDOWN: ;
      K_PAGEUP: ;
      K_ENTER, K_KP_ENTER: managerSetOfTools.ActiveElement := 65535;
    else
      begin
        if UseText^.EditString.UseLen >= UseText^.EditString.Len then
          Exit;
        symb := scancode_to_utf8(keysLast[0]);

        if symb = 0 then
          goto jmpEnd;
        if (keybFlags and keyboardSymbol) > 0 then
        begin
          if keysLast[0] = K_KP_1 then
            symb := 124;
          if keysLast[0] = K_KP_2 then
            symb := 63;
          if keysLast[0] = K_KP_3 then
            symb := 8470;
          goto smallJmp;
        end;
        if (keybFlags and keyboardLatinRus) > 0 then
        begin
          if symb = 47 then
          begin
            symb := 46;
            goto smallJmp;
          end;
          if symb = 63 then
          begin
            symb := 44;
            goto smallJmp;
          end;
          EngToRusUnicode(symb);
        end;
smallJmp:
        _JcharSymb := useFont^.CharDesc[symb];
        if Assigned(_JcharSymb) then
          _ShiftP := _JcharSymb^.ShiftP * useFont^.Scale
        else
          _ShiftP := useFont^._ShiftP63;

        if UseText^.Cursor.position > UseText^.EditString.UseLen then
        begin
          UseText^.EditString.CharSymb[UseText^.Cursor.position - 1] := symb;

          UseText^.EditString.posX[UseText^.Cursor.position] := UseText^.EditString.posX[UseText^.Cursor.position - 1] + _ShiftP;

          inc(UseText^.EditString.UseLen);
        end
        else begin
          j := UseText^.Cursor.position - 1;
          if (keybFlags and keyboardInsert) = 0 then
          begin
            i := UseText^.EditString.UseLen;
            while i >= (UseText^.Cursor.position) do
            begin
              UseText^.EditString.CharSymb[i] := UseText^.EditString.CharSymb[i - 1];
              dec(i);
            end;
          end;
          UseText^.EditString.CharSymb[UseText^.Cursor.position - 1] := symb;
          while j <= UseText^.EditString.UseLen do
          begin
            _JcharSymb := useFont^.CharDesc[UseText^.EditString.CharSymb[j]];
            if Assigned(_JcharSymb) then
              _ShiftP := _JcharSymb^.ShiftP * useFont^.Scale
            else
              _ShiftP := useFont^._ShiftP63;

            UseText^.EditString.posX[j + 1] := UseText^.EditString.posX[j] + _ShiftP;
            inc(j);
          end;
          if (keybFlags and keyboardInsert) = 0 then
            inc(UseText^.EditString.UseLen);
        end;
        inc(UseText^.Cursor.position);
        RollEditRight;
      end;

    end;
    exit;
  end;

jmpMouse:
  if (mouseUpDown and M_BLEFT_UP) > 0 then
    UseText^.flags := UseText^.flags and (255 - geMDown);
  if ((mouseUpDown and M_BLEFT_DOWN) > 0) and ((UseText^.flags and geMDown) = 0) then
  begin
    sinAngle := sin(Pi * (360 - UseText^.Rotate) / 180);
    cosAngle := cos(Pi * (360 - UseText^.Rotate) / 180);
    mDX := UseText^.mainRPoint.X + (mouseX - UseText^.mainRPoint.x) * cosAngle - (mouseY - UseText^.mainRPoint.Y) * sinAngle;
    mDY := UseText^.mainRPoint.Y + (mouseY - UseText^.mainRPoint.Y) * cosAngle + (mouseX - UseText^.mainRPoint.x) * sinAngle;

    if col2d_PointInRect(mDX, mDY, UseText^.Rect) then
    begin
      UseText^.flags := UseText^.flags or geMDown;

      {$IfDef ACTIVATE_MOUSE}
      if managerSetOfTools.ActiveElement <> num then
      begin
        managerSetOfTools.ActiveElement := num;
        goto jmpEnd;
      end;
      {$EndIf}
      if UseText^.EditString.UseLen > 0 then
      begin
        if (mDX - UseText^.Rect.X) < (UseText^.EditString.posX[UseText^.EditString.UseLen] - UseText^.translateX) then
        begin
          i := 0;
          while (UseText^.EditString.posX[i] + useFont^.CharDesc[UseText^.EditString.CharSymb[i]]^.xx2) < UseText^.translateX do
            inc(i);
          n := i;
          j := UseText^.EditString.UseLen;
          while (UseText^.EditString.posX[j - 1] + useFont^.CharDesc[UseText^.EditString.CharSymb[j - 1]]^.xx1) > (UseText^.translateX + UseText^.Rect.W) do
            dec(j);
          while i <= j do
          begin
            if (mDX - UseText^.Rect.X) < (UseText^.EditString.posX[i] - UseText^.translateX) then
              Break;
            inc(i);
          end;
          UseText^.Cursor.position := i;
          SetCursorPosAndWidth;
          if i >= j then
          begin
            if (UseText^.Cursor.curRect.X + UseText^.Cursor.curRect.W - UseText^.translateX) > (UseText^.Rect.W) then
              UseText^.translateX := UseText^.Cursor.curRect.X + UseText^.Cursor.curRect.W - UseText^.Rect.w;
            goto jmpEnd;
          end;

          if n = i - 1 then
            if (UseText^.EditString.posX[n] + useFont^.CharDesc[UseText^.EditString.CharSymb[n]]^.xx1) < UseText^.translateX then
            begin
              UseText^.translateX := UseText^.Cursor.curRect.X;
              if UseText^.translateX < 0 then
                UseText^.translateX := 0;
            end;     
        end
        else begin
          UseText^.Cursor.position := UseText^.EditString.UseLen + 1;
          RollEditRight;
        end;
      end;
    end;
  end;
jmpEnd:
  useFont := nil;
end;

procedure SetColorBackElement(Color: zglPColor);
begin
  StColorBackElement[0] := Color^.R;
  StColorBackElement[1] := Color^.G;
  StColorBackElement[2] := Color^.B;
  StColorBackElement[3] := Color^.A;
end;

procedure SetColorElementText(Color: zglPColor);
begin
  StColorTextEl[0] := Color^.R;
  StColorTextEl[1] := Color^.G;
  StColorTextEl[2] := Color^.B;
  StColorTextEl[3] := Color^.A;
  StColorTextEl[3] := 1;
end;

procedure DeleteElementSOT(ID: Byte);
begin
  managerSetOfTools.propElement[ID].Flags := 0;
end;

procedure DestroyManagerSOT();
var
  i: LongWord;
begin
  if managerSetOfTools.count = 0 then
    Exit;
  for i := 0 to managerSetOfTools.maxPossibleEl - 1 do
  begin
    if managerSetOfTools.propElement[i].Element = _Edit then
    begin
      UseText := managerSetOfTools.SetOfTools[i];
      SetLength(UseText^.EditString.CharSymb, 0);
      SetLength(UseText^.EditString.posX, 0);
      Freemem(UseText);
      managerSetOfTools.SetOfTools[i] := nil;

    end;

    // ...
    dec(managerSetOfTools.count);
    if managerSetOfTools.count = 0 then
      Break;
  end;

  UseText := nil;
  SetLength(managerSetOfTools.SetOfTools, 0);
  SetLength(managerSetOfTools.propElement, 0);
end;

procedure SetOfRotateAngleAndPoint(x, y: Single; angle: Single = 0);
begin
  geAngle := angle;
  pointManager.X := x;
  pointManager.Y := y;
end;

function GetEditToText(num: Word): UTF8String;
var
  i, j: Word;
begin
   UseText := managerSetOfTools.SetOfTools[num];
   Result := '';
   j := UseText^.EditString.UseLen;
   i := 0;
   while i <= j - 1 do
   begin
     Result := Result + Unicode_toUTF8(UseText^.EditString.CharSymb[i]);
     inc(i);
   end;
end;

procedure CorrectEditCursor(num: Word; y: Single);
begin
  UseText := managerSetOfTools.SetOfTools[num];
  UseText^.Cursor.curRect.Y := UseText^.Cursor.curRect.Y + y;
end;

procedure ActivateEdit(num: Word);
begin
  if not Assigned(managerSetOfTools.SetOfTools[num]) then
    exit;
  UseText := managerSetOfTools.SetOfTools[num];
  if ((keybFlags and keyboardInsert) > 0) then
    UseText^.Cursor.curRect.H :=  - UseText^.Scale * 1.1
  else
    UseText^.Cursor.curRect.H := 2;
  managerSetOfTools.ActiveElement := num;
end;

end.

