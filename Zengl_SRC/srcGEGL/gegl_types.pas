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
unit gegl_Types;

interface

uses
  zgl_font,
  zgl_types;

const
  // RU: частота мигания курсора
  // EN: cursor blinking frequency
  CUR_FLASH = 15;
  // RU: максимальное количество символов в строке (сделать как переменную?)
  // EN: maximum number of characters in a line
  MAX_SYMBOL_LINE = 80;

  // RU: константы для менеджера элементов, их перечисление.
  // EN: constants for the element manager, their enumeration.
  _Edit        = 1;
  _Label       = 2;
  _Memo        = 3;
  _Button      = 4;

  // флаги для поля ввода и для поля мемо
  geMDown      = $01;                  // мышь была нажата.

  // флаги для всех элементов (общие)
  Enable       = $01;                  // Существует или нет
  Visible      = $02;                  // виден ли
  IsNotActive  = $04;                  // не может быть выбран (метка, поле вывода)

type
  geglTCursor = record
    curRect: zglTRect;
    NSleep: Byte;
    Flags: Boolean;
    position: Word;
  end;

  geglPLine = ^geglTLine;
  geglTLine = record
    posY: LongWord;
    Len, UseLen: Word;
    CharSymb: array of LongWord;
    posX: array of Single;
  end;

  geglPEdit = ^geglTEdit;
  geglTEdit = record
    Rect: zglTRect;
    Scale: Single;
//    ColorGround: zglTColor;
    ColorText: zglTColor;

    Cursor: geglTCursor;
    EditString: geglTLine;
    translateX: Single;
    Rotate: Single;
    mainRPoint: zglTPoint2D;
    MaxLen: Cardinal;
    font: Byte;
    procEdit: procedure;
    flags: Byte;
  end;

  geglPropertElement = record
    Element: Byte;
    Flags: Byte;
  end;

  geglPSetOfToolsManager = ^geglTSetOfToolsManager;
  geglTSetOfToolsManager = record
    count: Cardinal;
    SetOfTools: array of Pointer;
    maxPossibleEl: Cardinal;
    propElement: array of geglPropertElement;
    ActiveElement: Cardinal;
  end;

implementation

end.

