(*
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
 *)

  // Модуль для создания кнопок и работы с ними? Или просто создание?
  // Мы не делаем здесь сами кнопки. Мы делаем их текстуры. Эти текстуры уже
  // будут использоваться в кнопках.

unit gegl_button;

{$I zgl_config.cfg}

interface

uses
  zgl_screen,
  zgl_primitives_2d,
  zgl_primitives_2dEX,
  zgl_textures,
  zgl_text,
  zgl_window,
  zgl_types,
  gegl_color,
  gegl_Types;

// Rus: создаём кнопку. Кнопка создаётся от меню. Но так же кнопки могут быть в игре.
//      Данные кнопки с двумя изображениями. Нажато/отжато. Если работать с текстурой
//      где используется изображения для нескольких кнопок, то надо работать с
//      фреймами данной текстуры.
// Eng:
function AddButton(x, y, w, h: Single; Texture: zglPTexture; passive: Boolean = False): LongWord;
(* решено было сделать создание кнопки, но в дальнейшем просто перевести в текстуру отрисованное.
  *)
// Rus: создаём кнопку с номером. Надо определиться, будут они массштабируемы или нет?
//      EndDraw - показывает, будут ещё кнопки прорисовываться или нет. Если будут, то надо сохранять фреймы
//      для текстуры общей. Иначе, надо сохранять текстуры.
//      Пока про это забываем и делаем только текстуры.
// Eng:
function AddNumButton(x, y, w, h: Single; num: LongWord; passive: Boolean = False{; EndDraw: Boolean = True}): LongWord;
// Rus: создаём кнопку с текстом. Надо определиться, будут они массштабируемы или нет?
// Eng:
function AddStrButton(x, y, w, h: Single; text: UTF8String; passive: Boolean = False): LongWord;
// Rus: процедура которая нужна чтоб получить текстуры кнопок.
// Eng:
procedure ButtonPostDraw(W, H: Single; text: UTF8String);

// пока создаю две процедуры для начала постотрисовки и конца, позже посмотрим как это реализовать.
procedure BeginPostDraw;
procedure EndPostDraw;


implementation

var
  // Rus: менеджер всех кнопок
  // Eng:
  managerButton: TButtonManager;
  PTRButton: PButtonObj;
  // текстура, которая будет действовать для постотрисовки и для создания "общей" текстуры, которая будет сохранена в дальнейшем.
  TexturePostDraw: zglPTexture;
  _xx, _yy, _ww, _hh: Single;

procedure _GetMemoryForButton;
begin
  // здесь задаётся только основная информация о кнопке
  if managerButton.Count >= managerButton.MaxButton then
  begin
    // подготовка к созданию кнопок, есл под кнопки не выделена область
    inc(managerButton.MaxButton, 20);
    SetLength(managerButton.thisButton, managerButton.MaxButton);
  end;
  // выделяем память
  zgl_GetMem(PTRButton, SizeOf(TButtonObj));
  managerButton.thisButton[managerButton.Count] := PTRButton;
end;

function AddButton(x, y, w, h: Single; Texture: zglPTexture; passive: Boolean): LongWord;
begin
  Result := managerButton.Count;
  _GetMemoryForButton;
  PTRButton^.rect.X := x;
  PTRButton^.rect.Y := y;
  PTRButton^.rect.W := w;
  PTRButton^.rect.H := h;
  PTRButton^.Texture := Texture;
  PTRButton^.passiv := passive;
  PTRButton^.ID := managerButton.Count;
  // сохранение указателя на кнопку.

  inc(managerButton.Count);
  PTRButton := nil;
end;

function AddNumButton(x, y, w, h: Single; num: LongWord; passive: Boolean): LongWord;
begin
  Result := managerButton.Count;
  _GetMemoryForButton;
  PTRButton^.Texture := ButtonPostDraw(round(w), round(h), u_IntToStr(num));

  PTRButton^.rect.X := x;
  PTRButton^.rect.Y := y;
  PTRButton^.rect.W := w;
  PTRButton^.rect.H := h;
  PTRButton^.passiv := passive;
  PTRButton^.ID := managerButton.Count;
  inc(managerButton.Count);
  PTRButton := nil;
end;

function AddStrButton(x, y, w, h: Single; text: UTF8String; passive: Boolean): LongWord;
begin
  Result := managerButton.Count;
  _GetMemoryForButton;
  PTRButton^.Texture := ButtonPostDraw(round(w), round(h), text);

  PTRButton^.rect.X := x;
  PTRButton^.rect.Y := y;
  PTRButton^.rect.W := w;
  PTRButton^.rect.H := h;
  PTRButton^.passiv := passive;
  PTRButton^.ID := managerButton.Count;
  inc(managerButton.Count);
  PTRButton := nil;
end;

procedure ButtonPostDraw(W, H: Single; text: UTF8String);
var
  point: zglTPoint2D;
  rect: zglTRect2D;
  pData: PByteArray;
begin
  if (_ww + W > 1024) and (_hh + H > 1024) then
  begin
    EndPostDraw;       // завершаем работу с предыдущей тестурой и начинаем работу с новой.
    BeginPostDraw;     // а значит, что нужен номер текстуры дополнительно
  end;
  // данную процедуру необходимо переделать под множество кнопок. И возвращать значения текстурных координат.
  pr2d_Rect(0, 0, W, H * 2, cl_Black, PR2D_FILL);
  pr2d_RectEX(0, 0, W, H, cl_Black, cl_Blue05, 3, PR2D_FILL);
  rect.X := 0;
  rect.Y := 0;
  rect.W := W;
  rect.H := H;
  point := text_GetXY(fntEdit, rect, text);
  text_Draw(fntEdit, point.x, point.y, text);
  pr2d_RectEX(0, H, W, H, cl_Black, cl_Gray, 3, PR2D_FILL);
  rect.Y := H;
  // point := text_GetXY(fntEdit, rect, text);   // возможно просто прибавить высоту?
  point.Y := point.Y + H;
  text_Draw(fntEdit, point.x, point.y, text);


  // получение фрейма текстуры.
  // основная ширина текстуры - 1 (= 1024), ширина фрейма - известна.   (1/1024 * wframe)
end;

procedure BeginPostDraw;
begin
  _xx := 0;
  _yy := 0;
  _ww := 0;
  _hh := 0;
  // полная очистка будующей текстуры
  // ставлю hh, чтоб паскаль взял последнее значение, а не в очередной раз извлекал его из регистра. Хотя... наверняка опять извлекать будет...
  pr2d_Rect(_hh, _hh, 1024, 1024, cl_transparent, PR2D_FILL);
end;

procedure EndPostDraw;
begin
  scr_ReadPixels(pData, 0, 0, 1024, 1024);
  // мы должны сохранить данную полученную текстуру
//  tex_CalcTransparent(pData, TEX_NO_COLORKEY, 1024, 1024);  // не обязательно, при таких данных.
  Result := tex_Create(pData, 1024, 1024);
  Freemem(pData);

  // надо отправить всем созданным "объектам" номер текстуры.

  // разбить текстуры надо по другому, а может и не надо вовсе.
  // tex_SetFrameSize(Result, W, H);
end;

end.

