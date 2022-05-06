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
unit gegl_utils;

{$I zgl_config.cfg}

interface

var
  // Rus: глобальная строка, для любого использования. Удобно для использования
  //      для загрузки разных ресурсов.
  // Eng:
  LoadText: UTF8String;
  // Rus: флаг, показывающий, занята глобальная строка или нет. Вы должны его
  //      включать если загрузили ресурс и отключать, когда больше этот ресурс
  //      не нужен. И желательно освобождать строку полностью.
  // Eng:
  fLoadTextClearing: Boolean = True;

{$IfDef DELPHI7_AND_DOWN}
// Delphi 7 and down - UTF8. Rus only.
function AscToUtf8Rus(text: AnsiString): UTF8String;
function ByteToUtf8Rus(myByte: Byte): UTF8String;
{$EndIf}
// Rus: переводим клавиатурные коды в русскую символику. Для других языков, надо
//      свою функцию делать. И знать клавиатурную раскладку.
// Eng: we translate keyboard codes into Russian symbols. For other languages, you
//      need to do your own function. It is imperative to know the keyboard layout
//      for this language.
procedure EngToRus(var symb: LongWord);
// Rus: то же самое, но только переводим в Unicode.
// Eng: the same, but only translating to Unicode.
procedure EngToRusUnicode(var symb: LongWord);
// Rus: установка значения флага для глобальной загружаемой строки. Указываем что
//      строка занята или свободна. Если освобождаем, то строка очистится.
// Eng:
procedure set_FlagForLoadText(flag: Boolean); {$IfDef USE_INLINE}inline;{$EndIf}
// Rus: возвращаем значение флага для глобальной строки. Занята строка или свободна?
// Eng:
function get_FlagForLoadText: Boolean; {$IfDef USE_INLINE}inline;{$EndIf}

implementation

{$IfDef DELPHI7_AND_DOWN}
function AscToUtf8Rus(text: AnsiString): UTF8String;
var
  i, len: Integer;
  n: Byte;
begin
  Result := '';
  len := Length(text);
  for i := 1 to len do
  begin
    n := byte(text[i]);
    case n of
      0..127: Result := Result + chr(n);
      192..255: Result := Result + chr($D0) + chr(n - $C0 + $90);
      168: Result := Result + chr($D0) + chr($81);                          // Ё
      184: Result := Result + chr($D1) + chr($91);                          // ё
      185: Result := Result + chr($E2) + chr($84) + chr($96);      // №
    end;
  end;
end;

function ByteToUtf8Rus(myByte: Byte): UTF8String;
begin
  case myByte of
    0..127: Result := chr(myByte);
    192..255: Result := chr($D0) + chr((myByte - $C0 + $90));
    168: Result := chr($D0) + chr($81);
    184: Result := chr($D1) + chr($91);
    185: Result := Result + chr($E2) + chr($84) + chr($96);
  end;
end;
{$EndIf}

procedure EngToRus(var symb: LongWord);
begin
  case symb of
    102 : symb := 224;         // а
    44  : symb := 225;         // б
    68  : symb := 194;         // в
    85  : symb := 195;         // г
    76  : symb := 196;         // д
    84  : symb := 197;         // е
    96  : symb := 184;         // ё
    59  : symb := 230;         // ж
    80  : symb := 199;         // з
    66  : symb := 200;         // и
    81  : symb := 201;         // й

    82  : symb := 202;         // к
    75  : symb := 203;         // л
    86  : symb := 204;         // м
    89  : symb := 205;         // н
    74  : symb := 206;         // о
    71  : symb := 207;         // п
    72  : symb := 208;         // р
    67  : symb := 209;         // с
    78  : symb := 210;         // т
    69  : symb := 211;         // у
    65  : symb := 212;         // ф

    91  : symb := 245;         // х
    87  : symb := 214;         // ц
    88  : symb := 215;         // ч
    73  : symb := 216;         // ш
    79  : symb := 217;         // щ
    93  : symb := 250;         // ъ
    83  : symb := 219;         // ы
    77  : symb := 220;         // ь
    39  : symb := 253;         // э
    46  : symb := 254;         // ю
    90  : symb := 223;         // я

    70  : symb := 192;         // А
    60  : symb := 193;         // Б
    100 : symb := 226;         // В
    117 : symb := 227;         // Г
    108 : symb := 228;         // Д
    116 : symb := 229;         // Е
    126 : symb := 168;         // Ё
    58  : symb := 198;         // Ж
    112 : symb := 231;         // З
    98  : symb := 232;         // И
    113 : symb := 233;         // Й

    114 : symb := 234;         // К
    107 : symb := 235;         // Л
    118 : symb := 236;         // М
    121 : symb := 237;         // Н
    106 : symb := 238;         // О
    103 : symb := 239;         // П
    104 : symb := 240;         // Р
    99  : symb := 241;         // С
    110 : symb := 242;         // Т
    101 : symb := 243;         // У
    97  : symb := 244;         // Ф

    123 : symb := 213;         // Х
    119 : symb := 246;         // Ц
    120 : symb := 247;         // Ч
    105 : symb := 248;         // Ш
    111 : symb := 249;         // Щ
    125 : symb := 218;         // Ъ
    115 : symb := 251;         // Ы
    109 : symb := 252;         // Ь
    34  : symb := 221;         // Э
    62  : symb := 222;         // Ю
    122 : symb := 255;         // Я

    35: symb := 185;         // №
  end;
end;

procedure EngToRusUnicode(var symb: LongWord);
begin
  case symb of
    102 : symb := 1072;         // а     !!
    44  : symb := 1073;         // б     !!
    100 : symb := 1074;         // в     !!
    117 : symb := 1075;         // г     !!
    108 : symb := 1076;         // д     !!
    116 : symb := 1077;         // е     !!
    96  : symb := 1105;         // ё     !!
    59  : symb := 1078;         // ж     !!
    112 : symb := 1079;         // з     !!
    98  : symb := 1080;         // и     !!
    113 : symb := 1081;         // й     !!

    114 : symb := 1082;         // к     !!
    107 : symb := 1083;         // л     !!
    118 : symb := 1084;         // м     !!
    121 : symb := 1085;         // н     !!
    106 : symb := 1086;         // о     !!
    103 : symb := 1087;         // п     !!
    104 : symb := 1088;         // р     !!
    99  : symb := 1089;         // с     !!
    110 : symb := 1090;         // т     !!
    101 : symb := 1091;         // у     !!
    97  : symb := 1092;         // ф     !!

    91  : symb := 1093;         // х     !!
    119 : symb := 1094;         // ц     !!
    120 : symb := 1095;         // ч     !!
    105 : symb := 1096;         // ш     !!
    111 : symb := 1097;         // щ     !!
    93  : symb := 1098;         // ъ     !!
    115 : symb := 1099;         // ы     !!
    109 : symb := 1100;         // ь     !!
    39  : symb := 1101;         // э     !!
    46  : symb := 1102;         // ю     !!
    122 : symb := 1103;         // я

    70  : symb := 1040;         // А     !!
    60  : symb := 1041;         // Б     !!
    68  : symb := 1042;         // В     !!
    85  : symb := 1043;         // Г     !!
    76  : symb := 1044;         // Д     !!
    84  : symb := 1045;         // Е     !!
    126 : symb := 1025;         // Ё     !!
    58  : symb := 1046;         // Ж     !!
    80  : symb := 1047;         // З     !!
    66  : symb := 1048;         // И     !!
    81  : symb := 1049;         // Й     !!

    82  : symb := 1050;         // К     !!
    75  : symb := 1051;         // Л     !!
    86  : symb := 1052;         // М     !!
    89  : symb := 1053;         // Н     !!
    74  : symb := 1054;         // О     !!
    71  : symb := 1055;         // П     !!
    72  : symb := 1056;         // Р     !!
    67  : symb := 1057;         // С     !!
    78  : symb := 1058;         // Т     !!
    69  : symb := 1059;         // У     !!
    65  : symb := 1060;         // Ф     !!

    123 : symb := 1061;         // Х     !!
    87  : symb := 1062;         // Ц     !!
    88  : symb := 1063;         // Ч     !!
    73  : symb := 1064;         // Ш     !!
    79  : symb := 1065;         // Щ     !!
    125 : symb := 1066;         // Ъ     !!
    83  : symb := 1067;         // Ы     !!
    77  : symb := 1068;         // Ь     !!
    34  : symb := 1069;         // Э
    62  : symb := 1070;         // Ю
    90  : symb := 1071;         // Я

    35  : symb := 8470;         // №
  end;
end;

procedure set_FlagForLoadText(flag: Boolean);
begin
  if flag = True then
    LoadText := '';
  fLoadTextClearing := flag;
end;

function get_FlagForLoadText: Boolean;
begin
  Result := fLoadTextClearing;
end;

end.
