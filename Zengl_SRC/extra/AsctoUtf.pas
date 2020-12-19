unit AsctoUtf;          // Rus - only!!!

interface

uses
  zgl_utils;

// íå çíàþ, íóæíî ýòî áóäåò èëè íåò, íî åñëè ðàçðàáàòûâàòü íà Delphi7, òî íàäî áóäåò

function AscToUtf8Rus(text: AnsiString): UTF8String;
function ByteToUtf8Rus(myByte: Byte): UTF8String;
procedure EngToRus(var symb: Byte);

implementation

// áóäåò âðåìÿ, íàäî áóäåò ïîëíîñòüþ âñ¸ ïåðåðàáîòàòü!!! Âñå ðàáîòû ñî ñòðîêàìè!!!! Ýòî ïîëíûé ïèïåö, òîííó âðåìåíè íà íèõ óáèâàåòñÿ,
// äëÿ ïåðåâîäà èç ÷èñëà â ñèìâîë, èç ñèìâîëà â ÷èñëî... èç ASC â UTF... è ïðî÷åå

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

// ZenGL клавиатурные коды в русскую символику
procedure EngToRus(var symb: Byte);
begin
  case symb of
    102{70} : symb := 224{192};         // а
    44 {60} : symb := 225{193};         // б
    68 {100}: symb := 226{194};         // в
    85 {117}: symb := 227{195};         // г
    76 {108}: symb := 228{196};         // д
    84 {116}: symb := 229{197};         // е
    96 {126}: symb := 184{168};         // ё
    59 {58} : symb := 230{198};         // ж
    80 {112}: symb := 231{199};         // з
    66 {98} : symb := 232{200};         // и
    81 {113}: symb := 233{201};         // й

    82 {114}: symb := 234{202};         // к
    75 {107}: symb := 235{203};         // л
    86 {118}: symb := 236{204};         // м
    89 {121}: symb := 237{205};         // н
    74 {106}: symb := 238{206};         // о
    71 {103}: symb := 239{207};         // п
    72 {104}: symb := 240{208};         // р
    67 {99} : symb := 241{209};         // с
    78 {110}: symb := 242{210};         // т
    69 {101}: symb := 243{211};         // у
    65 {97} : symb := 244{212};         // ф

    91 {123}: symb := 245{213};         // х
    87 {119}: symb := 246{214};         // ц
    88 {120}: symb := 247{215};         // ч
    73 {105}: symb := 248{216};         // ш
    79 {111}: symb := 249{217};         // щ
    93 {125}: symb := 250{218};         // ъ
    83 {115}: symb := 251{219};         // ы
    77 {109}: symb := 252{220};         // ь
    39 {34} : symb := 253{221};         // э
    46 {62} : symb := 254{222};         // ю
    90 {122}: symb := 255{223};         // я

    {102}70 : symb := {224}192;         // а
    {44} 60 : symb := {225}193;         // б
    {68} 100: symb := {226}194;         // в
    {85} 117: symb := {227}195;         // г
    {76} 108: symb := {228}196;         // д
    {84} 116: symb := {229}197;         // е
    {96} 126: symb := {184}168;         // ё
    {59} 58 : symb := {230}198;         // ж
    {80} 112: symb := {231}199;         // з
    {66} 98 : symb := {232}200;         // и
    {81} 113: symb := {233}201;         // й

    {82} 114: symb := {234}202;         // к
    {75} 107: symb := {235}203;         // л
    {86} 118: symb := {236}204;         // м
    {89} 121: symb := {237}205;         // н
    {74} 106: symb := {238}206;         // о
    {71} 103: symb := {239}207;         // п
    {72} 104: symb := {240}208;         // р
    {67} 99 : symb := {241}209;         // с
    {78} 110: symb := {242}210;         // т
    {69} 101: symb := {243}211;         // у
    {65} 97 : symb := {244}212;         // ф

    {91} 123: symb := {245}213;         // х
    {87} 119: symb := {246}214;         // ц
    {88} 120: symb := {247}215;         // ч
    {73} 105: symb := {248}216;         // ш
    {79} 111: symb := {249}217;         // щ
    {93} 125: symb := {250}218;         // ъ
    {83} 115: symb := {251}219;         // ы
    {77} 109: symb := {252}220;         // ь
    {39} 34 : symb := {253}221;         // э
    {46} 62 : symb := {254}222;         // ю
    {90} 122: symb := {255}223;         // я

    35: symb := 185;         // №
  end;
end;

end.
