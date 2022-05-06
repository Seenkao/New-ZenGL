{
 *  Copyright (c) 2021 SSW (Serge)
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
  // Rus: частота мигания курсора
  // Eng: cursor blinking frequency
  CUR_FLASH = 15;
  // Rus: максимальное количество символов в строке (сделать как переменную?)
  // Eng: maximum number of characters in a line
  MAX_SYMBOL_LINE = 80;

  // Rus: константы для менеджера элементов, их перечисление.
  // Eng: constants for the element manager, their enumeration.
  is_Edit        = 1;
  is_Label       = 2;
  is_Memo        = 3;
  is_Button      = 4;

// эти флаги параллельные. Один в элементе, другой в его свойствах.
  // флаги для поля ввода и для поля мемо
  vc_geMDown      = $01;               // мышь была нажата. выбираем точку и других действий не производим.
                                       // хотя тут может быть палка о двух концах, нажата была, но не попали ни в какой символ
                                       // это надо будет проверить
  vc_NumOnly      = $02;               // только цифры
  vc_NumDelimeter = $04;               // разделитель - точка и запятая
  vc_CurEndSymb   = $08;               // курсор на позиции последнего символа (смещается всё влево, буду использовать только для чисел) - не сделано
                                       // работать будет только BackSpace
  vc_RightToLeft  = $10;               // обратное направление?                                        - не сделано
  vc_OnTRightSide = $20;               // прижато к правой стороне                                     - не сделано
  vc_SymbOnly     = $40;               // только символы и цифры, ни каких пробелов и знаков препинания.
  vc_DelimetrTrue = $80;               // разделитель уже существует.

  // флаги для всех элементов (общие)
  el_Enable        = $01;              // Существует или нет
  el_Visible       = $02;              // виден ли
//  el_Highlighting  = $04;            // выделение (подсветка) элемента при наведениии на него.
                                       // тут обратить внимание, надо это делать или нет.
//  IsNotActive  = $04;                  // не может быть выбран (метка, поле вывода) - но элементы, которые выбрать нельзя, надо просто прорисовывать

  el_Enable_or_Visible = el_Enable or el_Visible;

type
  geglDefColor = record
    Text, Ground, Cursor: LongWord;    // цвет для всех элементов по умолчанию
  end;

  geglTCursor = record
    curRect: zglTRect2D;               // вид курсора
    NSleep: Byte;                      // задержка для "мигания"
    Flags: Boolean;                    // только для указания мигает или нет (будет больше что-то, то изменить)
    position: Word;                    // позиция в строке (именно по позиции символа, может и не надо тогда позиции курсора по XY)
//    xPos, yPos: Single;                  // текущая позиция курсора
  end;

  // строка - это непрерывный массив букв, оканчивающийся на "окончание каретки" (для Edit - просто нажатием Enter)
  geglPLine = ^geglTLine;
  geglTLine = record
    posY: LongWord;                                // позиция по Y, но это позиция первого символа, а значит у каждого символа
                                                   // должна быть своя позиция по Y
    Len, UseLen: Word;                             // общая длина строки в символах и данная длина
    // строка в LongWord (типо юникод, но 4 байта)
    CharSymb: array of LongWord;
    posX: array of Single;                         // позиция каждого Х
  end;

  // структура поля ввода.
  geglPEdit = ^geglTEdit;
  geglTEdit = record
    Rect: zglTRect2D;                              // !!!! прямоугольник поля ввода
    Scale: Single;                                 // шкала текста??? Или шкала всего поля ввода???
    ColorGround: LongWord;                         // цвет фона - не задействован
    ColorText: LongWord;                           // цвет текста
    ColorCursor: LongWord;                         // цвет мигающего курсора

    Cursor: geglTCursor;                           // курсор в строке для поля ввода (при мышке может уходить за пределы)
    EditString: geglTLine;                         // строка
    translateX: Single;                            // смещение по X для символов (строка одна, смещение по Y не обязательно).
    Rotate: Single;                                // ротация вокруг определённой точки. В данном случае вокруг левого верхнего угла.

    RotatePoint: zglTPoint2D;                      // задаваемая точка вращения. Тут стоит отметить, что подобные точки вращения
                                                   // должны работать для всех элементов. Получается точка вращения одна, а вращаться
                                                   // элементы будут именно вокруг этой одной точки. (либо разных, если панели общие разные.

    MaxLen: Cardinal;                              // максимальная длина строки
    font: LongWord;                                // фонт используемый в поле ввода
    procDraw: procedure;                           // процедура для вывода окантовки поля ввода (иначе выведется только текст)
    procLimit: function: Boolean;                  // функция для ограничения обрабатываемых символов (если она нужна)
    flags: LongWord;                               // указанные флаги. Была нажата мышь или нет. Вводим только цифры, цифры и разделитель,
                                                   // печатные символы подходящие для имён (пробелы нельзя). Указание направления и
                                                   // курсор только в конце (для цифр)
  end;

  // Внимание!!! Данный менеджер - это очень сложная система. Она будет вести контроль за объектами:
  // активен элемент или нет, существует или нет, выбран в данный момент или нет и многое другое.
  // этот менеджер содержит ссылки, на созданные элементы! И их надо обязательно уничтожать по окончанию работы программы!

  geglPPropertElement = ^geglTPropertElement;
  // "свойства" элементов. "Наименование" элемента и его флаги
  geglTPropertElement = record
    Element: LongWord;                             // хватило бы и байта, но для нормальной работы надо ставить большую размерность
                                                   // соответствует общему количеству эл-тов, чтоб не  заходить в сам элемент
    Flags: LongWord;                               // флаги для элемента, как минимум активен/не активен, существует/удалён
  end;

  // обрабатывающий менеджер всех элементов, для этого нужна ссылка, на любой элемент
  geglPSetOfToolsManager = ^geglTSetOfToolsManager;
  geglTSetOfToolsManager = record
    // каждый номер привязан к конкретному эл-ту указанному в байте, но COUNT может не указывать на данный элемент!!!
    count: Cardinal;

    // сам список элементов
    SetOfTools: array of Pointer;

    maxPossibleEl: Cardinal;                       // максимальное количество элементов на данный момент
    // свойства и флаги элемента
    propElement: array of geglTPropertElement;
    ActiveElement: Cardinal;                       // Активный элемент. 0 - ни какой. Определиться, какие элементы могут быть активными.
  end;

implementation

end.
