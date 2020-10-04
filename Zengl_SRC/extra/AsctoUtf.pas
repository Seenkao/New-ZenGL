unit AsctoUtf;

interface

// �� ����, ����� ��� ����� ��� ���, �� ���� ������������� �� Delphi7, �� ���� �����

function AscToUtf8Rus(text: AnsiString): UTF8String;
function ByteToUtf8Rus(myByte: Byte): UTF8String;

implementation

// ����� �����, ���� ����� ��������� �� ������������!!! ��� ������ �� ��������!!!! ��� ������ �����, ����� ������� �� ��� ���������,
// ��� �������� �� ����� � ������, �� ������� � �����... �� ASC � UTF... � ������

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
