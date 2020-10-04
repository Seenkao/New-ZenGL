unit AsctoUtf;

interface

// не знаю, нужно это будет или нет, но если разрабатывать на Delphi7, то надо будет

function AscToUtf8Rus(text: AnsiString): UTF8String;
function ByteToUtf8Rus(myByte: Byte): UTF8String;

implementation

// будет время, надо будет полностью всё переработать!!! Все работы со строками!!!! Это полный пипец, тонну времени на них убивается,
// для перевода из числа в символ, из символа в число... из ASC в UTF... и прочее

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
    if (n >= 192) and (n <= 255) then
      Result := Result + chr($D0) + chr((n - $C0 + $90));
    if n = 168 then
      Result := Result + chr($D0) + chr($81);
    if n = 184 then
      Result := Result + chr($D1) + chr($91);
    if n = 185 then
      Result := Result + chr($E2) + chr($84) + chr($96);
    if (n >= 0) and (n <= 127) then
      Result := Result + text[i];
  end;
end;

function ByteToUtf8Rus(myByte: Byte): UTF8String;
begin
  if (myByte >= 192) and (myByte <= 255) then
    Result := chr($D0) + chr((myByte - $C0 + $90));
  if myByte = 168 then
    Result := chr($D0) + chr($81);
  if myByte = 184 then
    Result := chr($D1) + chr($91);
  if myByte = 185 then
      Result := Result + chr($E2) + chr($84) + chr($96);
  if (myByte >= 0) and (myByte <= 127) then
    Result := chr(myByte);
end;

end.
