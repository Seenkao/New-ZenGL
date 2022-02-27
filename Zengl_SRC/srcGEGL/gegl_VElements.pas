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
  {$IfNDef MOBILE}
  zgl_mouse,
  {$Else}
  zgl_touch,
  {$EndIf}
  zgl_collision_2d,
  zgl_window;

var
  managerSetOfTools: geglTSetOfToolsManager;

// RU: создание поля ввода. Заданный прямоугольник; шрифт; размер шрифта;
//     заданные процедуры: вывода поля ввода и ограничению вводимых символов;
//     длина строки. По умолчанию, заданных процедур нет, длина строки = 80.
//
// EN: creating an input field. The specified rectangle; font; font size; the
//     specified procedures: output of the input field and the limitation of the
//     entered characters; the length of the string. By default, there are no
//     specified procedures, line length = 80.
function CreateEdit(Rect: zglTRect2D; fnt, Scale: LongWord; UserData1: Pointer = nil; UserData2: Pointer = nil; Len: Word = MAX_SYMBOL_LINE): Word;         // функция с запасом на будущее
// RU: обработка событий поля ввода, вызывать не надо. Менеджер всё сделает
//     за вас.
// EN: event handling of the input field, no need to call. The manager will do
//     everything for you.
procedure EventsEdit(num: LongWord);
// RU: удаление определённого элемента API, по его номеру. И без разницы какой
//     это элемент, он будет удалён, не выключен.
// EN: deleting a specific API element by its number. And no matter what element
//     it is, it will be deleted, not turned off.
procedure DeleteElementSOT(num: LongWord);
// Ru: Установка цвета в уже созданном поле ввода (а точнее указание номеров
//     использыемых цветов). Вы можете использовать эту функцию для настройки
//     как после создания поля ввода, так и во время работы программы (в меню
//     настроек).
procedure SetEditColor(num: LongWord; ColorText, ColorBackground: LongWord; ColorCursor: LongWord = 0);
// RU: уничтожение всех элементов API. Вызывать не нужно!!! Производится по
//     закрытию программы!!!
// EN: destruction of all API elements. Don't Run !!! It is performed when the
//     program is closed !!!
procedure DestroyManagerSOT();
// RU: Установка точки вращения и угла вращения (если это необходимо).
//     Обратить внимание! Заданная точка, будет работать для всех элементов!!!
//     Потому, для создания нового элемента, её надо пересчитать или обнулить.
//     Запускать до создания элемента API!!!
// EN: Set pivot point and pivot angle (if necessary).
//     Note! The set point will work for all elements !!! Therefore, to create a
//     new element, it must be recalculated or reset to zero.
//     Run before API element is created !!!
procedure SetOfRotateAngleAndPoint(x, y: Single; angle: Single = 0); {$IfDef USE_INLINE} inline; {$EndIf}
// RU: возвращаем текст из строки
// EN: return text from string
function GetEditToText(num: LongWord): UTF8String;
// RU: корректировка курсора, + - вниз. Курсор может быть не правильно
//     скорректирован, это зависит от используемого шрифта. Надо настраивать
//     вручную для разных шрифтов.
// EN: cursor adjustment, + - down. The cursor may not be adjusted correctly,
//     depending on the font used. Must be manually configured for
//     different fonts.
procedure CorrectEditCursor(num: LongWord; y: Single);
// RU: активация поля ввода. Сделано автоматическое, при нажатии мыши на поле
//     ввода. Но это можно отключить и по своему событию произвести активацию.
// EN: activation of the input field. Made automatic when clicking on the input
//     field. But this can be turned off and activated according to your event.
procedure ActivateEdit(num: LongWord);
// Ru: Установить флаги поля ввода.
//     NumOnly      - только цифры
//     NumDelimeter - цифры и разделитель - точка и запятая
//     CurEndSymb   - курсор не дальше последнего символа (смещается всё влево)
//     RightToLeft  - обратное направление?
//     OnTRightSide - прижато к правой стороне
//     SymbOnly     - только символы и цифры, ни каких пробелов и знаков препинания.
//     DelimetrTrue - разделитель уже существует.
// En:
procedure SetFlagsEdit(num: LongWord; var newFlags: Byte);
// Ru: функции обработки (ограничения) поля ввода. Вызывать не надо,
//     устанавливаются по функции устновки флагов - SetFlagsEdit.
// Ru: только числа
function EditNumeric: Boolean;
// Ru: только числа и разделитель
function EditNumericAndDelimetr: Boolean;
// Ru: символы кроме не учавствующих в именах (буквы, цифры) и исключая пробел - в общем всё для создания имени.
function EditNotSymbolic: Boolean;

implementation

uses
  {$IfDef FULL_LOGGING}
  zgl_log,
  {$EndIf}
  gegl_color;

var
  // RU: поле ввода (пока просто вывода текста)
  UseText: geglPEdit;
  // точка поворота
  pointManager: zglTPoint2D = (x: 0; y: 0);
  // угол поворота
  geAngle: Single = 0;

function CreateEdit(Rect: zglTRect2D; fnt, Scale: LongWord; UserData1: Pointer = nil; UserData2: Pointer = nil; Len: Word = MAX_SYMBOL_LINE): Word;
var
  {$IFDEF DELPHI7_AND_DOWN}
  z: Pointer;
  {$ENDIF}
  i: LongWord;
  pFlags: PLongWord;
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
    pFlags := @managerSetOfTools.propElement[i].Flags;
    if not Assigned(UseText) then
      Break;
    if (pFlags^ and el_Enable) = 0 then
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

  managerSetOfTools.propElement[i].Element := is_Edit;
  pFlags^ := pFlags^ or el_Enable_or_Visible;
  pFlags := nil;
  Result := i;

  UseText^.Rect.X := Rect.X;
  UseText^.Rect.Y := Rect.Y;
  UseText^.Rect.W := Rect.W;
  UseText^.Rect.H := Rect.H;
  UseText^.ColorText := cl_Black;
  UseText^.ColorGround := cl_White;
  UseText^.ColorCursor := cl_Black;
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
  UseText^.RotatePoint := pointManager;
  UseText^.font := fnt;
  UseText^.procDraw := UserData1;
  UseText^.procLimit := UserData2;
  inc(managerSetOfTools.count);
end;

procedure EventsEdit(num: LongWord);
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
  {$IfDef FULL_LOGGING}
  if (managerSetOfTools.count = 0) or (managerSetOfTools.SetOfTools[num] = nil) then
  BEGIN
    log_add('Error is EventsEdit!');
    exit;
  end;
  {$EndIf}

  UseText := managerSetOfTools.SetOfTools[num];
  useFont := managerFont.Font[UseText^.font];
  if managerSetOfTools.ActiveElement <> num then
    goto jmpMouse;

  if keysUp[K_INSERT] then
    if ((PkeybFlags^ and keyboardInsert) > 0) then
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

        if (UseText^.flags and (vc_NumOnly or vc_NumDelimeter or vc_SymbOnly)) > 0 then
          if (UseText^.flags and vc_NumOnly) > 0 then
          begin
            if not EditNumeric then
              exit;
          end
          else
            if (UseText^.flags and vc_NumDelimeter) > 0 then
            begin
              if not EditNumericAndDelimetr then
                Exit;
            end
            else
              if not EditNotSymbolic then
                exit;

        symb := scancode_to_utf8(keysLast[KA_DOWN]);

        if symb = 0 then
          Exit;
        {$IfDef USE_VKEYBOARD}
        if (keybFlags and keyboardSymbol) > 0 then
        begin
          if keysLast[KA_DOWN] = K_KP_1 then
            symb := 124;
          if keysLast[KA_DOWN] = K_KP_2 then
            symb := 63;
          if keysLast[KA_DOWN] = K_KP_3 then
            symb := 8470;
          goto smallJmp;
        end;
        {$EndIf}
        if (PkeybFlags^ and keyboardLatinRus) > 0 then
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

        if Assigned(UseText^.procLimit) then
          if not (UseText^.procLimit) then
            exit;

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
          if (PkeybFlags^ and keyboardInsert) = 0 then
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
          if (PkeybFlags^ and keyboardInsert) = 0 then
            inc(UseText^.EditString.UseLen);
        end;
        inc(UseText^.Cursor.position);
        RollEditRight;
      end;
    end;
    exit;
  end;

jmpMouse:
  if (mouseAction[M_BLEFT].state and is_up) > 0 then
    UseText^.flags := UseText^.flags and (255 - vc_geMDown);
  if ((mouseAction[M_BLEFT].state and is_down) > 0) and ((UseText^.flags and vc_geMDown) = 0) then
  begin
    sinAngle := sin(Pi * (360 - UseText^.Rotate) / 180);
    cosAngle := cos(Pi * (360 - UseText^.Rotate) / 180);
    mDX := UseText^.RotatePoint.X + (mouseX - UseText^.RotatePoint.x) * cosAngle - (mouseY - UseText^.RotatePoint.Y) * sinAngle;
    mDY := UseText^.RotatePoint.Y + (mouseY - UseText^.RotatePoint.Y) * cosAngle + (mouseX - UseText^.RotatePoint.x) * sinAngle;

    if col2d_PointInRect(mDX, mDY, UseText^.Rect) then
    begin
      UseText^.flags := UseText^.flags or vc_geMDown;

      {$IfDef ACTIVATE_MOUSE}
      if managerSetOfTools.ActiveElement <> num then
      begin
        managerSetOfTools.ActiveElement := num;
        if ((PkeybFlags^ and keyboardInsert) > 0) then
          UseText^.Cursor.curRect.H :=  - UseText^.Scale * 1.1
        else
          UseText^.Cursor.curRect.H := 2;
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

procedure DeleteElementSOT(num: LongWord);
begin
  {$IfDef FULL_LOGGING}
  if (managerSetOfTools.count = 0) or (managerSetOfTools.SetOfTools[num] = nil) then
  begin
    log_add('Error in DeleteElementSOT!');
    exit;
  end;
  {$EndIf}
  managerSetOfTools.propElement[num].Flags := 0;
end;

procedure SetEditColor(num: LongWord; ColorText, ColorBackground: LongWord; ColorCursor: LongWord);
begin
  {$IfDef FULL_LOGGING}
  if (managerSetOfTools.count = 0) or (managerSetOfTools.SetOfTools[num] = nil) then
  begin
    log_add('Error in SetEditColor!');
    exit;
  end;
  {$EndIf}
  UseText := managerSetOfTools.SetOfTools[num];
  UseText^.ColorText := ColorText;
  UseText^.ColorGround := ColorBackground;
  UseText^.ColorCursor := ColorCursor;
end;

procedure DestroyManagerSOT();
var
  i: LongWord;
begin
  if managerSetOfTools.count = 0 then
    Exit;
  for i := 0 to managerSetOfTools.maxPossibleEl - 1 do
  begin
    if managerSetOfTools.propElement[i].Element = is_Edit then
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

function GetEditToText(num: LongWord): UTF8String;
var
  i, j: Word;
begin
  Result := '';
  {$IfDef FULL_LOGGING}
  if (managerSetOfTools.count = 0) or (managerSetOfTools.SetOfTools[num] = nil) then
  begin
    log_Add('Error in GetEditToText!');
    exit;
  end;
  {$EndIf}
  UseText := managerSetOfTools.SetOfTools[num];
  j := UseText^.EditString.UseLen - 1;
  i := 0;
  while i <= j do
  begin
    Result := Result + Unicode_toUTF8(UseText^.EditString.CharSymb[i]);
    inc(i);
  end;
end;

procedure CorrectEditCursor(num: LongWord; y: Single);
begin
  {$IfDef FULL_LOGGING}
  if (managerSetOfTools.count = 0) or (managerSetOfTools.SetOfTools[num] = nil) then
  begin
    log_Add('Error in CorrectEditCursor!');
    exit;
  end;
  {$EndIf}
  UseText := managerSetOfTools.SetOfTools[num];
  UseText^.Cursor.curRect.Y := UseText^.Cursor.curRect.Y + y;
end;

procedure ActivateEdit(num: LongWord);
begin
  {$IfDef FULL_LOGGING}
  if (managerSetOfTools.count = 0) or (managerSetOfTools.SetOfTools[num] = nil) then
  begin
    log_Add('Error in ActivateEdit!');
    exit;
  end;
  {$EndIf}
  if not Assigned(managerSetOfTools.SetOfTools[num]) then
    exit;
  UseText := managerSetOfTools.SetOfTools[num];
  if ((PkeybFlags^ and keyboardInsert) > 0) then
    UseText^.Cursor.curRect.H :=  - UseText^.Scale * 1.1
  else
    UseText^.Cursor.curRect.H := 2;
  managerSetOfTools.ActiveElement := num;
end;

procedure SetFlagsEdit(num: LongWord; var newFlags: Byte);
begin
  if ((newFlags and (vc_NumOnly or vc_NumDelimeter)) > 0) and ((newFlags and vc_SymbOnly) > 0) then
  begin
    newFlags := 0;                 // error;
    exit;
  end;
  UseText := managerSetOfTools.SetOfTools[num];
  UseText^.flags := UseText^.flags and vc_geMDown or (newFlags and (255 - vc_geMDown));
  if (newFlags and (vc_NumOnly or vc_NumDelimeter or vc_SymbOnly)) > 0 then
    UseText^.procLimit := nil;
end;

function EditNumeric: Boolean;
var
  n: Byte;
begin
  n := keysLast[KA_DOWN];
  Result := false;
  UseText := managerSetOfTools.SetOfTools[managerSetOfTools.ActiveElement];
  if (UseText^.EditString.UseLen = 0) and ((n = K_0) or (n = K_KP_0)) then
    exit;
  case n of
    K_1..K_0, K_KP_7..K_KP_9, K_KP_4..K_KP_6, K_KP_1..K_KP_0:
      Result := true;
  end;
end;

function EditNumericAndDelimetr: Boolean;
var
  n: Byte;
begin
  n := keysLast[KA_DOWN];
  Result := false;
  UseText := managerSetOfTools.SetOfTools[managerSetOfTools.ActiveElement];
  if (UseText^.EditString.UseLen = 0) and ((n = K_0) or (n = K_KP_0)) then
    exit;
  case n of
    K_1..K_0, K_KP_7..K_KP_9, K_KP_4..K_KP_6, K_KP_1..k_kp_0, K_DECIMAL, K_SEMICOLON:
      Result := true;
  end;
end;

function EditNotSymbolic: Boolean;
var
  m: Byte;
begin
  Result := False;
  m := keysLast[KA_DOWN];
  // список кодов: $0C $0D $0F $1A $1B $27 $28 $29 $2B $33 $34 $35 $37 $39 $4A $4E $53 $B5 - которые не должны производить действие.
  // исключения есть, знак "-", при шифте - это подчёркивание. Так же, большинство цифровых клавиш.
  // исключение - русский алфавит.

  if keysDown[K_SHIFT] then
  begin
    if (m >= K_1) and (m <= K_0) then
      exit;
  end
  else
    if m = K_MINUS then
      exit;
  if (keybFlags and keyboardNumLock) > 0 then
    if (m = K_KP_MUL) or (m = K_KP_SUB) or (m = K_KP_ADD) or (m = K_KP_DECIMAL) or (m = K_KP_DIV) then
      exit;
  if (PkeybFlags^ and keyboardLatinRus) = 0 then
    if (m = K_BRACKET_L) or (m = K_BRACKET_R) or ((m >= K_SEMICOLON) and (m <= K_TILDE)) or (m = K_SEPARATOR) or (m = K_DECIMAL) then
      exit;
  if (m = K_SLASH) or (m = K_EQUALS) or (m = K_BACKSPACE) or (m = K_BACKSLASH) or (m = K_SPACE) or (m = K_TAB) then
    exit;
  Result := True;
end;

end.

