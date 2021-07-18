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
  RusSymb: UTF8String;

{$IfDef DELPHI7_AND_DOWN}
// Delphi 7 and down - UTF8. Rus only.
function AscToUtf8Rus(text: AnsiString): UTF8String;
function ByteToUtf8Rus(myByte: Byte): UTF8String;
{$EndIf}
// RU: переводим клавиатурные коды в русскую символику. Для других языков, надо свою функцию делать.
//     И знать клавиатурную раскладку.
// EN: we translate keyboard codes into Russian symbols. For other languages, you need to do your own
//     function. It is imperative to know the keyboard layout for this language.
procedure EngToRus(var symb: LongWord);
// RU: то же самое, но только переводим в Unicode.
// EN: the same, but only translating to Unicode.
procedure EngToRusUnicode(var symb: LongWord);

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
      168: Result := Result + chr($D0) + chr($81);
      184: Result := Result + chr($D1) + chr($91);
      185: Result := Result + chr($E2) + chr($84) + chr($96);
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
    102 : symb := 224;
    44  : symb := 225;
    68  : symb := 194;
    85  : symb := 195;
    76  : symb := 196;
    84  : symb := 197;
    96  : symb := 184;
    59  : symb := 230;
    80  : symb := 199;
    66  : symb := 200;
    81  : symb := 201;

    82  : symb := 202;
    75  : symb := 203;
    86  : symb := 204;
    89  : symb := 205;
    74  : symb := 206;
    71  : symb := 207;
    72  : symb := 208;
    67  : symb := 209;
    78  : symb := 210;
    69  : symb := 211;
    65  : symb := 212;

    91  : symb := 245;
    87  : symb := 214;
    88  : symb := 215;
    73  : symb := 216;
    79  : symb := 217;
    93  : symb := 250;
    83  : symb := 219;
    77  : symb := 220;
    39  : symb := 253;
    46  : symb := 254;
    90  : symb := 223;

    70  : symb := 192;
    60  : symb := 193;
    100 : symb := 226;
    117 : symb := 227;
    108 : symb := 228;
    116 : symb := 229;
    126 : symb := 168;
    58  : symb := 198;
    112 : symb := 231;
    98  : symb := 232;
    113 : symb := 233;

    114 : symb := 234;
    107 : symb := 235;
    118 : symb := 236;
    121 : symb := 237;
    106 : symb := 238;
    103 : symb := 239;
    104 : symb := 240;
    99  : symb := 241;
    110 : symb := 242;
    101 : symb := 243;
    97  : symb := 244;

    123 : symb := 213;
    119 : symb := 246;
    120 : symb := 247;
    105 : symb := 248;
    111 : symb := 249;
    125 : symb := 218;
    115 : symb := 251;
    109 : symb := 252;
    34  : symb := 221;
    62  : symb := 222;
    122 : symb := 255;

    35: symb := 185;
  end;
end;

procedure EngToRusUnicode(var symb: LongWord);
begin
  case symb of
    102 : symb := 1072;
    44  : symb := 1073;
    100 : symb := 1074;
    117 : symb := 1075;
    108 : symb := 1076;
    116 : symb := 1077;
    96  : symb := 1105;
    59  : symb := 1078;
    112 : symb := 1079;
    98  : symb := 1080;
    113 : symb := 1081;

    114 : symb := 1082;
    107 : symb := 1083;
    118 : symb := 1084;
    121 : symb := 1085;
    106 : symb := 1086;
    103 : symb := 1087;
    104 : symb := 1088;
    99  : symb := 1089;
    110 : symb := 1090;
    101 : symb := 1091;
    97  : symb := 1092;

    91  : symb := 1093;
    119 : symb := 1094;
    120 : symb := 1095;
    105 : symb := 1096;
    111 : symb := 1097;
    93  : symb := 1098;
    115 : symb := 1099;
    109 : symb := 1100;
    39  : symb := 1101;
    46  : symb := 1102;
    122 : symb := 1103;

    70  : symb := 1040;
    60  : symb := 1041;
    68  : symb := 1042;
    85  : symb := 1043;
    76  : symb := 1044;
    84  : symb := 1045;
    126 : symb := 1025;
    58  : symb := 1046;
    80  : symb := 1047;
    66  : symb := 1048;
    81  : symb := 1049;

    82  : symb := 1050;
    75  : symb := 1051;
    86  : symb := 1052;
    89  : symb := 1053;
    74  : symb := 1054;
    71  : symb := 1055;
    72  : symb := 1056;
    67  : symb := 1057;
    78  : symb := 1058;
    69  : symb := 1059;
    65  : symb := 1060;

    123 : symb := 1061;
    87  : symb := 1062;
    88  : symb := 1063;
    73  : symb := 1064;
    79  : symb := 1065;
    125 : symb := 1066;
    83  : symb := 1067;
    77  : symb := 1068;
    34  : symb := 1069;
    62  : symb := 1070;
    90  : symb := 1071;

    35  : symb := 8470;
  end;
end;

end.
