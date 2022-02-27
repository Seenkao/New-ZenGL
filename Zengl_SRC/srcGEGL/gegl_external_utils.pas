(*
 *  Copyright (c) 2021-2022 Serg Shutkin
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

// Rus: требуется проверка при работе с флагами переполнения. На данный момент
//      проблем не возникало.
// Eng: validation is required when dealing with overflow flags. At the moment
//      there have been no problems.

unit gegl_external_Utils;
{$I gegl_config.cfg}

interface

const
  // Rus: константы задаваемые при вызове geStrToInt
  // Eng: constants set when calling geStrToInt
  isByte      = 0;
  isShortInt  = 0;
  {$IfDef USE_CPU16}
  isWord      = 1;
  isSmallInt  = 1;
  {$EndIf}
  {$IfDef USE_CPU32}
  isLongWord  = 2;
  isInteger   = 2;
  {$EndIf}
  {$IfDef USE_CPU64}
  isQWord     = 3;
  isInt64      = 3;
  {$EndIf}
  {$IfDef CPU8}
  maxSize     = 0;
  {$EndIf}
  {$IfDef CPU16}
  maxSize     = 1;
  {$EndIf}
  {$IfDef CPU32}
  maxSize     = 2;
  {$EndIf}
  {$IfDef CPU64}
  maxSize     = 3;
  {$EndIf}

type
  PmaxIntVal = ^maxIntVal;
  PmaxUIntVal = ^maxUIntVal;
  {$IfDef CPU8}
  maxIntVal = {$IfNDef UP_CPU}ShortInt{$Else}SmallInt{$EndIf};
  maxUIntVal = {$IfNDef UP_CPU}Byte{$Else}Word{$EndIf};
  {$EndIf}
  {$IfDef CPU16}
  maxIntVal = {$IfNDef UP_CPU}SmallInt{$Else}Integer{$EndIf};
  maxUIntVal = {$IfNDef UP_CPU}Word{$Else}LongWord{$EndIf};
  {$EndIf}
  {$IfDef CPU32}
  maxIntVal = {$IfNDef UP_CPU}Int64{$Else}Integer{$EndIf};
  maxUIntVal = {$IfNDef UP_CPU}LongWord{$Else}QWord{$EndIf};
  {$EndIf}
  {$IfDef CPU64}
  maxIntVal = Int64;
  maxUIntVal = QWord;
  {$EndIf}
  {$IfDef USE_STRING}
  useString = String;
  {$EndIf}
  {$IfDef USE_ANSISTRING}
  useString = AnsiString;
  {$EndIf}
  {$IfDef USE_UTF8STRING}
  useString = UTF8String;
  {$EndIf} 

// Rus: эта функция для десятичных чисел со знаком.
// Eng: this function is for signed decimal numbers.
{$IfNDef UNICODESTRING_ONLI}
function geCharToInt(const aStr: array of Char; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean;
function geStrToInt(const Str: useString; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; inline;
{$EndIf}
{$IfDef USE_UNICODESTRING}
function geWCharToInt(const aStr: array of WideChar; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean;
function geStrToInt(const Str: UnicodeString; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; inline;
{$EndIf}

// Rus: эта функция только для десятичных чисел без знака!!!
// Eng: this function is only for unsigned decimal numbers!!!
{$IfNDef UNICODESTRING_ONLI}
function geCharToUInt(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
function geStrToUInt(const Str: useString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
{$EndIf}
{$IfDef USE_UNICODESTRING}
function geWCharToUInt(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
function geStrToUInt(const Str: UnicodeString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
{$EndIf}

// Rus: для работы с шестнадцатеричными, восьмеричными и двоичными данными.
// Eng: for working with hexadecimal, octal and binary data.
{$IfNDef UNICODESTRING_ONLI}
function geHOBCharToUInt(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
function geHOBStrToUInt(const Str: useString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
{$EndIf}
{$IfDef USE_UNICODESTRING}
function geHOBWCharToUInt(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
function geHOBStrToUInt(const Str: UnicodeString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
{$EndIf}

(* Rus: Ниже реализованы стандартные функции для перевода строк в число. Их
 *      использование будет проще для большинства. Функции отмечены префиксом.
 *      s_ - функции возвращают результат (если операция была неудачной, то
 *      в результате вернётся ноль, но вы не узнаете, что операция была неудачной).
 *      sc_ - результат функций удачная или не удачная была операция. Сам
 *      конечный числовой результат считывайте в Value.
 * Eng: The standard functions for converting strings to numbers are implemented
 *      below. Their use will be easier for most. Functions are marked with a prefix.
 *      s_ - functions return a result (if the operation was unsuccessful, the result
 *      will be zero, but you will not know that the operation was unsuccessful).
 *      sc_ - the result of the functions - the operation was successful or
 *      unsuccessful. Read the final numerical result in Value.
 *)
// sc_ - speed + check
// s_ - speed (not check)

// Rus: Числа со знаком. Здесь нельзя использовать шестнадцатеричные, восьмеричные
//      и двоичные числа.
// Eng: Signed numbers. Hexadecimal, octal and binary numbers cannot be used here.
{$IfNDef UNICODESTRING_ONLI}
function sc_StrToShortInt(const Str: useString; out Value: ShortInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // byte
function s_StrToShortInt(const Str: useString): ShortInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // byte
{$IfDef USE_CPU16}
function sc_StrToSmallInt(const Str: useString; out Value: SmallInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // word
function s_StrToSmallInt(const Str: useString): SmallInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // word
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToInt(const Str: useString; out Value: Integer): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToInt(const Str: useString): Integer; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToInt64(const Str: useString; out Value: Int64): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToInt64(const Str: useString): Int64; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$EndIf}
{$IfDef USE_UNICODESTRING}
function sc_StrToShortInt(const Str: UnicodeString; out Value: ShortInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // byte
function s_StrToShortInt(const Str: UnicodeString): ShortInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // byte
{$IfDef USE_CPU16}
function sc_StrToSmallInt(const Str: UnicodeString; out Value: SmallInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // word
function s_StrToSmallInt(const Str: UnicodeString): SmallInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // word
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToInt(const Str: UnicodeString; out Value: Integer): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToInt(const Str: UnicodeString): Integer; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToInt64(const Str: UnicodeString; out Value: Int64): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToInt64(const Str: UnicodeString): Int64; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$EndIf}

// Rus: Числа без знака. Эти функции могут использоваться и для шестнадцатеричныи
//      и восьмеричных и двоичных чисел. Данные функции не должны содержать
//      ведущие нули для десятеричной системы счисления.
// Eng: Numbers without a sign. These functions can be used for hexadecimal, octal
//      and binary numbers as well. These functions must not contain leading zeros
//      for the decimal number system.
{$IfNDef UNICODESTRING_ONLI}
function sc_StrToByte(const Str: useString; out Value: Byte): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToByte(const Str: useString): Byte; {$IfDef ADD_FAST}inline;{$EndIf}
{$IfDef USE_CPU16}
function sc_StrToWord(const Str: useString; out Value: Word): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToWord(const Str: useString): Word; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToLongWord(const Str: useString; out Value: LongWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToLongWord(const Str: useString): LongWord; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToQWord(const Str: useString; out Value: QWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToQWord(const Str: useString): QWord; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$EndIf}
{$IfDef USE_UNICODESTRING}
function sc_StrToByte(const Str: UnicodeString; out Value: Byte): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToByte(const Str: UnicodeString): Byte; {$IfDef ADD_FAST}inline;{$EndIf}
{$IfDef USE_CPU16}
function sc_StrToWord(const Str: UnicodeString; out Value: Word): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToWord(const Str: UnicodeString): Word; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToLongWord(const Str: UnicodeString; out Value: LongWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToLongWord(const Str: UnicodeString): LongWord; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToQWord(const Str: UnicodeString; out Value: QWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
function s_StrToQWord(const Str: UnicodeString): QWord; {$IfDef ADD_FAST}inline;{$EndIf}
{$EndIf}
{$EndIf}

implementation
{$Goto on}

const
  dataHex: array[0..54] of Byte = (  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 16, 16, 16, 16, 16, 16,
                                    16, 10, 11, 12, 13, 14, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16,
                                    16,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 16, 16, 16, 16, 16,
                                    16, 10, 11, 12, 13, 14, 15);

type
  PgeUseParametr = ^geUseParametr;
  geUseParametr = record
    maxLen: LongWord;
    maxNumDiv10: maxUIntVal;
    maxNumeric: maxUIntVal;
  end;

  PgeHOBParameter = ^geHOBParameter;
  geHOBParameter = record
    maxLen16, maxLen8, maxLen2: maxUIntVal;
  end;
  
var
  allIntParametr, allUIntParametr: array[0..7] of geUseParametr;
  allHOBParametr: array[0..3] of geHOBParameter;

// Rus: выставляем необходимые параметры. Иначе geStrToInt работать не будет.
//      В блоке инициализации.
// Eng: set the required parameters. Otherwise geStrToInt won't work.
//      in the initialization block.
procedure SetNumberParametr;
begin
  allUIntParametr[isByte].maxLen := 3;
  allUIntParametr[isByte].maxNumeric := 255;
  allUIntParametr[isByte].maxNumDiv10 := 25;
  allIntParametr[isShortInt].maxLen := 4;
  allIntParametr[isShortInt].maxNumeric := 127;
  allIntParametr[isShortInt].maxNumDiv10 := 12;
  {$IfDef USE_CPU16}
  allUIntParametr[isWord].maxLen := 5;
  allUIntParametr[isWord].maxNumeric := 65535;
  allUIntParametr[isWord].maxNumDiv10 := 6553;
  allIntParametr[isSmallInt].maxLen := 6;
  allIntParametr[isSmallInt].maxNumeric := 32767;
  allIntParametr[isSmallInt].maxNumDiv10 := 3276;
  {$EndIf}
  {$IfDef USE_CPU32}
  allUIntParametr[isLongWord].maxLen := 10;
  allUIntParametr[isLongWord].maxNumeric := 4294967295;
  allUIntParametr[isLongWord].maxNumDiv10 := 429496729;
  allIntParametr[isInteger].maxLen := 11;
  allIntParametr[isInteger].maxNumeric := 2147483647;
  allIntParametr[isInteger].maxNumDiv10 := 214748364;
  {$EndIf}
  {$IfDef USE_CPU64}
  allUIntParametr[isQWord].maxLen := 20;
  allUIntParametr[isQWord].maxNumeric := 18446744073709551615;
  allUIntParametr[isQWord].maxNumDiv10 := 1844674407370955161;
  allIntParametr[isInt64].maxLen := 20;
  allIntParametr[isInt64].maxNumeric := 9223372036854775807;
  allIntParametr[isInt64].maxNumDiv10 := 922337203685477580;
  {$EndIf}

  allHOBParametr[isByte].maxLen16 := 3;
  allHOBParametr[isByte].maxLen8 := 4;
  allHOBParametr[isByte].maxLen2 := 9;
  {$IfDef USE_CPU16}
  allHOBParametr[isWord].maxLen16 := 5;
  allHOBParametr[isWord].maxLen8 := 7;
  allHOBParametr[isWord].maxLen2 := 17;
  {$EndIf}
  {$IfDef USE_CPU32}
  allHOBParametr[isLongWord].maxLen16 := 9;
  allHOBParametr[isLongWord].maxLen8 := 12;
  allHOBParametr[isLongWord].maxLen2 := 33;
  {$EndIf}
  {$IfDef USE_CPU64}
  allHOBParametr[isQWord].maxLen16 := 17;
  allHOBParametr[isQWord].maxLen8 := 23;
  allHOBParametr[isQWord].maxLen2 := 65;
  {$EndIf}
end;

{$IfNDef UNICODESTRING_ONLI}
function geStrToInt(const Str: useString; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; inline;
begin
  Result := geCharToInt(Str[1..Length(Str)], Value, Size);
end;

function geStrToUInt(const Str: useString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
begin
  Result := geCharToUInt(Str[1..Length(Str)], Value, Size);
end;

function geHOBStrToUInt(const Str: useString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
begin
  Result := geHOBCharToUInt(Str[1..Length(Str)], Value, Size);
end;

function sc_StrToShortInt(const Str: useString; out Value: ShortInt): Boolean;
var
  n: maxIntVal;
begin
  Result := geCharToInt(Str[1..Length(Str)], n, isShortInt);
  Value := n;
end;

function s_StrToShortInt(const Str: useString): ShortInt;
var
  n: maxIntVal;
begin
  geCharToInt(Str[1..Length(Str)], n, isShortInt);
  Result := n;
end;

{$IfDef USE_CPU16}
function sc_StrToSmallInt(const Str: useString; out Value: SmallInt): Boolean;
var
  n: maxIntVal;
begin
  Result := geCharToInt(Str[1..Length(Str)], n, isSmallInt);
  Value := n;
end;

function s_StrToSmallInt(const Str: useString): SmallInt;
var
  n: maxIntVal;
begin
  geCharToInt(Str[1..Length(Str)], n, isSmallInt);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU32}
function sc_StrToInt(const Str: useString; out Value: Integer): Boolean;
var
  n: maxIntVal;
begin
  Result := geCharToInt(Str[1..Length(Str)], n, isInteger);
  Value := n;
end;

function s_StrToInt(const Str: useString): Integer;
var
  n: maxIntVal;
begin
  geCharToInt(Str[1..Length(Str)], n, isInteger);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU64}
function sc_StrToInt64(const Str: useString; out Value: Int64): Boolean;
begin
  Result := geCharToInt(Str[1..Length(Str)], Value, isInt64);
end;

function s_StrToInt64(const Str: useString): Int64;
begin
  geCharToInt(Str[1..Length(Str)], Result, isInt64);
end;

{$EndIf}

function sc_StrToByte(const Str: useString; out Value: Byte): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBCharToUInt(Str[1..Length(Str)], n, isByte)
  else
    Result := geCharToUInt(Str[1..Length(Str)], n, isByte);
  Value := n;
end;

function s_StrToByte(const Str: useString): Byte;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBCharToUInt(Str[1..Length(Str)], n, isByte)
  else
    geCharToUInt(Str[1..Length(Str)], n, isByte);
  Result := n;
end;

{$IfDef USE_CPU16}
function sc_StrToWord(const Str: useString; out Value: Word): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBCharToUInt(Str[1..Length(Str)], n, isWord)
  else
    Result := geCharToUInt(Str[1..Length(Str)], n, isWord);
  Value := n;
end;

function s_StrToWord(const Str: useString): Word;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBCharToUInt(Str[1..Length(Str)], n, isWord)
  else
    geCharToUInt(Str[1..Length(Str)], n, isWord);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU32}
function sc_StrToLongWord(const Str: useString; out Value: LongWord): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBCharToUInt(Str[1..Length(Str)], n, isLongWord)
  else
    Result := geCharToUInt(Str[1..Length(Str)], n, isLongWord);
  Value := n;
end;

function s_StrToLongWord(const Str: useString): LongWord;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBCharToUInt(Str[1..Length(Str)], n, isLongWord)
  else
    geCharToUInt(Str[1..Length(Str)], n, isLongWord);
  Result := n;
end;
{$EndIf}

{$IfDef USE_CPU64}
function sc_StrToQWord(const Str: useString; out Value: QWord): Boolean;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBCharToUInt(Str[1..Length(Str)], Value, isQWord)
  else
    Result := geCharToUInt(Str[1..Length(Str)], Value, isQWord);
end;

function s_StrToQWord(const Str: useString): QWord;
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBCharToUInt(Str[1..Length(Str)], Result, isQWord)
  else
    geCharToUInt(Str[1..Length(Str)], Result, isQWord);
end;
{$EndIf}

function geCharToUInt(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, z: maxUIntVal;
  useParametr: PgeUseParametr;
  correct: maxUIntVal = 0;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    Exit;
  lenStr := Length(aStr);
  if lenStr = 0 then
    exit;
  m := Byte(aStr[0]);
  i := 1;

  while m = 48 do
  begin
    if (lenStr - correct) = 1 then
    begin
      Result := True;
      exit;
    end;
    m := Byte(aStr[i]);
    inc(i);
    inc(correct);
  end;
    
  m := m - 48;
  if m > 9 then
    exit;
  if (lenStr - correct) = 1 then
  begin
    Value := m;
    Result := true;
    Exit;
  end;
  useParametr := @allUIntParametr[Size];
  if lenStr > useParametr^.maxLen then
    Exit;
  while i < lenStr - 1 do
  begin
    n := (Byte(aStr[i]) - 48);
    if n > 9 then
      Exit;
    m := m * 10 + n;
    inc(i);
  end;
  if m > useParametr^.maxNumDiv10 then
    exit;
  m := m * 10;
  z := Byte(aStr[i]) - 48;
  if z > 9 then
    exit;
  n := useParametr^.maxNumeric - m;
  if z > n then
    exit;
  Value := m + z;
  Result := true;
  {$pop}
end;

function geHOBCharToUInt(const aStr: array of Char; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, nshl, z: maxUIntVal;
  Pnshl: PmaxUIntVal;
  correct: maxUIntVal = 0;
  useParametr: PgeHOBParameter;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    exit;
  lenStr := Length(aStr);
  if lenStr = 0 then
    exit;
    
  m := Byte(aStr[0]);
  n := Byte(aStr[1]);
  i := 1;
  if m = 48 then
  begin
    if n > 97 then
      n := n - 32;
    m := 38;
    if (n = 66) or (n = 88) or (n = 79) then
    begin
      correct := 1;
      i := 2;
      if n = 66 then
      begin
        m := 37;
      end
      else
        if n = 88 then
          m := 36;
      n := Byte(aStr[2]);
    end;
  end;

  while n = 48 do
  begin
    if (lenStr - correct) = 1 then
    begin
      Result := True;
      exit;
    end;
    inc(i);
    inc(correct);
    n := Byte(aStr[i]);
  end;    

  n := n - 48;
  useParametr := @allHOBParametr[Size];
  if m = 38 then
  begin
    if (lenStr - correct) > useParametr^.maxLen8 then
      exit;
    if useParametr^.maxLen8 = (lenStr - correct) then
      if (Size = isByte) or (Size = isLongWord) then
      begin
        if n > 3 then
          exit;
      end
      else
        if n > 1 then
          exit;
    nshl := 3;
    z := 7;
  end
  else
    if m = 37 then
    begin
      if (lenStr - correct) > useParametr^.maxLen2 then
        exit;
      nshl := 1;
      z := 1;
    end;
  if m = 36 then
  begin
    if (lenStr - correct) > useParametr^.maxLen16 then
      exit;
    m := 0;
    while i <= lenStr - 1 do
    begin
      m := m shl 4;
      n := Byte(aStr[i]) - 48;
      if n > 55 then
        exit;
      n := dataHex[n];
      if n = 16 then
        exit;
      m := m + n; 
      inc(i);
    end;
  end
  else begin
    Pnshl := @nshl;
    m := n;
    if m > z then
      exit;
    inc(i);
    while i <= lenStr - 1 do
    begin
      m := m shl Pnshl^;
      n := Byte(aStr[i]) - 48;
      if n > z then
        exit;
      m := m + n;
      inc(i);
    end;
  end;
  Value := m;
  Result := true;
  {$pop}
end;

function geCharToInt(const aStr: array of char; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, z: maxUIntVal;
  useParametr: PgeUseParametr;
  IntMinus: Boolean = False;
  correct: maxUIntVal = 0;
label
  jmpEndStr;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    Exit;

  lenStr := Length(aStr);
  if lenStr = 0 then
    exit;

  m := Byte(aStr[0]);

  i := 1;
  if m = 45 then
  begin
    if lenStr = 1 then
      exit;
    IntMinus := True;
    m := Byte(aStr[i]);
    inc(i);
  end;

  while m = 48 do
  begin
    if (lenStr - correct) = 1 then
    begin
      Result := True;
      exit;
    end;
    m := Byte(aStr[i]);
    inc(i);
    inc(correct);
  end;

  m := m - 48;
  if m > 9 then
    exit;

  useParametr := @allIntParametr[Size];
  if i > lenStr - 1 then
  begin
    z := 0;
    goto jmpEndStr;
  end;
  
  if (lenStr - correct) > useParametr^.maxLen then
    Exit;
  while i < lenStr - 1 do
  begin
    n := (Byte(aStr[i]) - 48);
    if n > 9 then
      Exit;
    m := m * 10 + n;
    inc(i);
  end;

  if m > useParametr^.maxNumDiv10 then
    exit;
  m := m * 10;
  z := Byte(aStr[i]) - 48;
  if z > 9 then
    exit;

jmpEndStr:
  if IntMinus then
    n := useParametr^.maxNumeric + 1 - m
  else
    n := useParametr^.maxNumeric - m;
  if z > n then
    exit;

  if IntMinus then
    Value := - m - z
  else
    Value := m + z;
  Result := true;
  {$pop}
end;
{$EndIf}

{$IfDef USE_UNICODESTRING}
function geStrToInt(const Str: UnicodeString; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean; inline;
begin
  Result := geWCharToInt(Str[1..Length(Str)], Value, Size);
end;

function geStrToUInt(const Str: UnicodeString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
begin
  Result := geWCharToUInt(Str[1..Length(Str)], Value, Size);;
end;

function geHOBStrToUInt(const Str: UnicodeString; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean; inline;
begin
  Result := geHOBWCharToUInt(Str[1..Length(Str)], Value, Size);
end;

function sc_StrToShortInt(const Str: UnicodeString; out Value: ShortInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // byte
var
  n: maxIntVal;
begin
  Result := geWCharToInt(Str[1..Length(Str)], n, isShortInt);
  Value := n;
end;

function s_StrToShortInt(const Str: UnicodeString): ShortInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // byte
var
  n: maxIntVal;
begin
  geWCharToInt(Str[1..Length(Str)], n, isShortInt);
  Result := n;
end;
{$IfDef USE_CPU16}
function sc_StrToSmallInt(const Str: UnicodeString; out Value: SmallInt): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}   // word
var
  n: maxIntVal;
begin
  Result := geWCharToInt(Str[1..Length(Str)], n, isSmallInt);
  Value := n;
end;

function s_StrToSmallInt(const Str: UnicodeString): SmallInt; {$IfDef ADD_FAST}inline;{$EndIf}                        // word
var
  n: maxIntVal;
begin
  geWCharToInt(Str[1..Length(Str)], n, isSmallInt);
  Result := n;
end;
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToInt(const Str: UnicodeString; out Value: Integer): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxIntVal;
begin
  Result := geWCharToInt(Str[1..Length(Str)], n, isInteger);
  Value := n;
end;

function s_StrToInt(const Str: UnicodeString): Integer; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxIntVal;
begin
  geWCharToInt(Str[1..Length(Str)], n, isInteger);
  Result := n;
end;
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToInt64(const Str: UnicodeString; out Value: Int64): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
begin
  Result := geWCharToInt(Str[1..Length(Str)], Value, isInt64);
end;

function s_StrToInt64(const Str: UnicodeString): Int64; {$IfDef ADD_FAST}inline;{$EndIf}
begin
  geWCharToInt(Str[1..Length(Str)], Result, isInt64);
end;
{$EndIf}

function sc_StrToByte(const Str: UnicodeString; out Value: Byte): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBWCharToUInt(Str[1..Length(Str)], n, isByte)
  else
    Result := geWCharToUInt(Str[1..Length(Str)], n, isByte);
  Value := n;
end;

function s_StrToByte(const Str: UnicodeString): Byte; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBWCharToUInt(Str[1..Length(Str)], n, isByte)
  else
    geWCharToUInt(Str[1..Length(Str)], n, isByte);
  Result := n;
end;
{$IfDef USE_CPU16}
function sc_StrToWord(const Str: UnicodeString; out Value: Word): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBWCharToUInt(Str[1..Length(Str)], n, isWord)
  else
    Result := geWCharToUInt(Str[1..Length(Str)], n, isWord);
  Value := n;
end;

function s_StrToWord(const Str: UnicodeString): Word; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBWCharToUInt(Str[1..Length(Str)], n, isWord)
  else
    geWCharToUInt(Str[1..Length(Str)], n, isWord);
  Result := n;
end;
{$EndIf}
{$IfDef USE_CPU32}
function sc_StrToLongWord(const Str: UnicodeString; out Value: LongWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBWCharToUInt(Str[1..Length(Str)], n, isLongWord)
  else
    Result := geWCharToUInt(Str[1..Length(Str)], n, isLongWord);
  Value := n;
end;

function s_StrToLongWord(const Str: UnicodeString): LongWord; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBWCharToUInt(Str[1..Length(Str)], n, isLongWord)
  else
    geWCharToUInt(Str[1..Length(Str)], n, isLongWord);
  Result := n;
end;
{$EndIf}
{$IfDef USE_CPU64}
function sc_StrToQWord(const Str: UnicodeString; out Value: QWord): Boolean; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    Result := geHOBWCharToUInt(Str[1..Length(Str)], Value, isQWord)
  else
    Result := geWCharToUInt(Str[1..Length(Str)], Value, isQWord);
end;

function s_StrToQWord(const Str: UnicodeString): QWord; {$IfDef ADD_FAST}inline;{$EndIf}
var
  n: maxUIntVal;
begin
  n := Byte(Str[1]);
  if (n = 48) or ((n >= 36) and (n <= 38)) then
    geHOBWCharToUInt(Str[1..Length(Str)], Result, isQWord)
  else
    geWCharToUInt(Str[1..Length(Str)], Result, isQWord);
end;

{$EndIf}

function geWCharToUInt(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, z: maxUIntVal;
  useParametr: PgeUseParametr;
  correct: maxUIntVal = 0;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    Exit;
  lenStr := Length(aStr);
  if lenStr = 0 then
    exit;
  m := Word(aStr[0]);

  i := 0;

  while m = 48 do
  begin
    if (lenStr - correct) = 1 then
    begin
      Result := True;
      exit;
    end;
    m := Word(aStr[i]);
    inc(i);
    inc(correct);
  end;

  m := m - 48;
  if m > 9 then
    exit;
  if (lenStr - correct) = 1 then
  begin
    Value := m;
    Result := true;
    Exit;
  end;
  useParametr := @allUIntParametr[Size];
  if lenStr > useParametr^.maxLen then
    Exit;
  while i < lenStr - 1 do
  begin
    n := (Word(aStr[i]) - 48);
    if n > 9 then
      Exit;
    m := m * 10 + n;
    inc(i);
  end;
  if m > useParametr^.maxNumDiv10 then
    exit;
  m := m * 10;
  z := Word(aStr[i]) - 48;
  if z > 9 then
    exit;
  n := useParametr^.maxNumeric - m;
  if z > n then
    exit;
  Value := m + z;
  Result := true;
  {$pop}
end;

function geHOBWCharToUInt(const aStr: array of WideChar; out Value: maxUIntVal; Size: maxIntVal = maxSize): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, nshl, z: maxUIntVal;
  Pnshl: PmaxUIntVal;
  correct: maxUIntVal = 0;
  useParametr: PgeHOBParameter;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    exit;
  lenStr := Length(aStr);
  if lenStr = 0 then
    exit;
    
  m := Word(aStr[0]);
  n := Word(aStr[1]);
  i := 1;
  if m = 48 then
  begin
    if lenStr = 1 then
    begin
      Result := True;
      exit;
    end;

    if n > 97 then
      n := n - 32;
    m := 38;
    if (n = 66) or (n = 88) or (n = 79) then
    begin
      correct := 1;
      i := 3;
      if n = 66 then
      begin
        m := 37;
      end
      else
        if n = 88 then
          m := 36;
      n := Word(aStr[2]);
    end;
  end;

  while n = 48 do
  begin
    if (lenStr - correct) = 1 then
    begin
      Result := True;
      exit;
    end;
    inc(i);
    inc(correct);
    n := Word(aStr[i]);
  end;

  n := n - 48;
  useParametr := @allHOBParametr[Size];
  if m = 38 then
  begin
    if (lenStr - correct) > useParametr^.maxLen8 then
      exit;
    if useParametr^.maxLen8 = (lenStr - correct) then
      if (Size = isByte) or (Size = isLongWord) then
      begin
        if n > 3 then
          exit;
      end
      else
        if n > 1 then
          exit;
    nshl := 3;
    z := 7;
  end
  else
    if m = 37 then
    begin
      if (lenStr - correct) > useParametr^.maxLen2 then
        exit;
      nshl := 1;
      z := 1;
    end;
  if m = 36 then
  begin
    if (lenStr - correct) > useParametr^.maxLen16 then
      exit;
    m := 0;
    while i <= lenStr do
    begin
      m := m shl 4;
      n := Word(aStr[i]) - 48;
      if n > 55 then
        exit;
      n := dataHex[n];
      if n = 16 then
        exit;
      m := m + n;
      inc(i);
    end;
  end
  else begin
    Pnshl := @nshl;
    m := n;
    if m > z then
      exit;
    inc(i);
    while i <= lenStr do
    begin
      m := m shl Pnshl^;
      n := Word(aStr[i]) - 48;
      if n > z then
        exit;
      m := m + n;
      inc(i);
    end;
  end;
  Value := m;
  Result := true;
  {$pop}
end;

function geWCharToInt(const aStr: array of WideChar; out Value: maxIntVal; Size: maxIntVal = maxSize): Boolean;
var
  lenStr, i: maxUIntVal;
  m, n, z: maxUIntVal;
  useParametr: PgeUseParametr;
  IntMinus: Boolean = False;
  correct: maxUIntVal = 0;
label
  jmpEndStr, loopZero;
begin
  {$push}
  {$Q-}{$R-}
  Result := False;
  Value := 0;
  if Size > maxSize then
    Exit;

  lenStr := Length(aStr);
  if lenStr = 0 then
    exit;
    
  m := Word(aStr[0]);
  if m > 57 then
    Exit;

  if (lenStr = 1) and (m = 48) then
  begin
    Result := True;
    exit;
  end;
  i := 1;
  if m = 45 then
  begin
    if lenStr = 1 then
      exit;
    IntMinus := True;
    m := Word(aStr[i]);                
    inc(i);
  end;

loopZero:
  if m = 48 then
  begin
    inc(i);
    inc(correct);
    m := Word(aStr[i]);
    goto loopZero;
  end;

  inc(i);
  m := m - 48;
  if m > 9 then
    exit;

  useParametr := @allIntParametr[Size];
  if i > lenStr - 1 then
  begin
    z := 0;
    goto jmpEndStr;
  end;
  if (lenStr - correct) > useParametr^.maxLen then
    Exit;
  while i < lenStr - 1 do              
  begin
    n := (Word(aStr[i]) - 48);         
    if n > 9 then
      Exit;
    m := m * 10 + n;
    inc(i);
  end;

  if m > useParametr^.maxNumDiv10 then
    exit;
  m := m * 10;
  z := Word(aStr[i]) - 48;           
  if z > 9 then
    exit;

jmpEndStr:
  if IntMinus then
    n := useParametr^.maxNumeric + 1 - m
  else
    n := useParametr^.maxNumeric - m;
  if z > n then
    exit;

  if IntMinus then
    Value := - m - z
  else
    Value := m + z;
  Result := true;
  {$pop}
end;
{$EndIf}

initialization

  SetNumberParametr;

end.
