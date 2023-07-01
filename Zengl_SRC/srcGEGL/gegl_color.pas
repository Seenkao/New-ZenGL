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
unit gegl_color;
{$I zgl_config.cfg}

interface

uses
  zgl_types;

const
  // Rus: номер для определённого цвета.
  // Eng:
  cl_White        = 0;
  cl_Black        = 1;
  cl_Maroon       = 2;
  cl_Green        = 3;
  cl_Olive        = 4;
  cl_Navy         = 5;
  cl_Purple       = 6;
  cl_Teal         = 7;
  cl_Gray         = 8;
  cl_Silver       = 9;
  cl_Red          = 10;
  cl_Lime         = 11;
  cl_Yellow       = 12;
  cl_Blue         = 13;
  cl_Fuchsia      = 14;
  cl_Aqua         = 15;

  cl_White05      = 16;
  cl_Black05      = 17;
  cl_Maroon05     = 18;
  cl_Green05      = 19;
  cl_Olive05      = 20;
  cl_Navy05       = 21;
  cl_Purple05     = 22;
  cl_Teal05       = 23;
  cl_Gray05       = 24;
  cl_Silver05     = 25;
  cl_Red05        = 26;
  cl_Lime05       = 27;
  cl_Yellow05     = 28;
  cl_Blue05       = 29;
  cl_Fuchsia05    = 30;
  cl_Aqua05       = 31;
  // полностью прозрачный и бесцветный.
  cl_transparent  = 32;
  // цвет идёт задом-наперёд
  zglDefColor: array [0..32] of LongWord = ($FFFFFFFF, $FF000000, $FF000080, $FF008000, $FF008080, $FF800000, $FF800080, $FF808000,
                                            $FF808080, $FFC0C0C0, $FF0000FF, $FF00FF00, $FF00FFFF, $FFFF0000, $FFFF00FF, $FFFFFF00,
                                            $80FFFFFF, $80000000, $80000080, $80008000, $80008080, $80800000, $80800080, $80808000,
                                            $80808080, $80C0C0C0, $800000FF, $8000FF00, $8000FFFF, $80FF0000, $80FF00FF, $80FFFF00, 0);
  is_clRed        = 0;
  is_clGreen      = 1;
  is_clBlue       = 2;
  is_clAlpha      = 3;

type
  gePColorManager = ^geTColorManager;
  geTColorManager = record
//    Color: array of zglTColor;           // Single
    Color: array of LongWord;
    count, len: Cardinal;
  end;

// Rus: ищем или добавляем цвет. Цвет добавляется, если его нет в списке.
// Eng: looking for or adding color. The color is added if it is not in the list.
//      Color - RRGGBBAA
function Color_FindOrAdd(Color: LongWord): LongWord;
// Rus: добавляем цвет без проверки на существование.
// Eng: add a color without checking for existence.
function Color_UAdd(Color: LongWord): LongWord;
// Rus: уничтожаем менеждер цвета. Вызывать не требуется.
// Eng: destroy the color manager. Calling is not required.
procedure managerColorDestroy;
// Rus: корректируем (изменяем) цвет.
// Eng: correcting (change) the color.
procedure Correct_Color(num, Color: LongWord); {$IfDef USE_INLINE} inline;{$EndIf}
// Rus: устанавливаем цвет (для совместимости с OpenGL ES). Указывается номер
//      цвета, а не сам цвет.
// Eng: set the color (for compatibility with OpenGL ES). The color number is
//      specified, not the color itself.
procedure Set_ToNumColor(numColor: LongWord); {$IfDef USE_INLINE} inline;{$EndIf}
// Rus: получаем значение цвета. Значение цвета идёт в обратном порядке! Это
//      удобно для передачи ссылкой в glColor4ubv делая вид, что это ссылка на
//      массив байт.
// Eng: get the color value. The color value goes in reverse order! This is handy
//      for passing by reference to glColor4ubv. Pretending it's a reference to
//      an array of bytes.
function Get_Color(num: LongWord): LongWord; {$IfDef USE_INLINE} inline;{$EndIf}
// Rus: получаем одно из значений (Red, Green, Blue или Alpha) цвета.
//      num - номер цвета. El должно принимать одо из значений:
//         is_clRed, is_clGreen, is_clBlue, is_clAlpha.
//      Result = $FFFFFFFF - ошибка.
// Eng: we get one of the values (Red, Green, Blue or Alpha) of the color.
//      num - color number. El must take one of the following values:
//         is_clRed, is_clGreen, is_clBlue, is_clAlpha.
//      Result = $FFFFFFFF - error.
function Get_ElColor(num, El: LongWord): LongWord;
// Rus: устанавливаем одно из значений (Red, Green, Blue или Alpha) цвета.
//      num - номер цвета, только того цвета, которые идут не по умолчанию!
//      El должно принимать одо из значений:
//         is_clRed, is_clGreen, is_clBlue, is_clAlpha.
// Eng: set one of the values (Red, Green, Blue or Alpha) of the color.
//      num - color number, only those colors that do not come by default!
//      El must take one of the following values:
//         is_clRed, is_clGreen, is_clBlue, is_clAlpha.
function Set_ElColor(num, El: LongWord; value: LongWord): Boolean;

var
  managerColor: geTColorManager;

implementation

uses
  zgl_text,
  zgl_memory,
  zgl_log,
  {$IFNDEF USE_GLES}
  zgl_opengl_all,
  zgl_pasOpenGL
  {$ELSE}
  zgl_opengles_all
  {$ENDIF}
  ;

var
  nP: PByte;

function Color_FindOrAdd(Color: LongWord): LongWord;
var
  i, n: LongWord;
  ColR, ColG,ColB, ColA: LongWord;
begin
  ColR := Color shr 24;
  ColG := (Color and $FF0000) shr 16;
  ColB := (Color and $FF00) shr 8;
  ColA := Color and $FF;
  if managerColor.count <= managerColor.len then
  begin
    inc(managerColor.len, 100);
    SetLength(managerColor.Color, managerColor.len);
  end;
  n := ColA * $1000000 + ColB * $10000 + ColG * $100 + ColR;
  if managerColor.count > 0 then
  begin
    for i := 0 to managerColor.count - 1 do
      if managerColor.Color[i] = n then
      begin
        Result := i;
        Exit;
      end;
  end;
  managerColor.Color[managerColor.count] := n;
  Result := managerColor.count;
  inc(managerColor.count);
end;

function Color_UAdd(Color: LongWord): LongWord;
var
  ColR, ColG,ColB, ColA: LongWord;
begin
  if managerColor.count <= managerColor.len then
  begin
    inc(managerColor.len, 100);
    SetLength(managerColor.Color, managerColor.len);
  end;
  ColR := Color shr 24;
  ColG := (Color and $FF0000) shr 16;
  ColB := (Color and $FF00) shr 8;
  ColA := Color and $FF;
  managerColor.Color[managerColor.count] := ColA * $1000000 + ColB * $10000 + ColG * $100 + ColR;
  Result := managerColor.count;
  inc(managerColor.count);
end;

procedure managerColorDestroy;
begin
  nP := nil;
  SetLength(managerColor.Color, 0);
end;

procedure Correct_Color(num, Color: LongWord); {$IfDef USE_INLINE} inline;{$EndIf}
var
  ColR, ColG,ColB, ColA: LongWord;
begin
  if (num < 32) or (num >= managerColor.count) then
    Exit;
  managerColor.Color[num] := Color;
end;

procedure Set_ToNumColor(numColor: LongWord); {$IfDef USE_INLINE} inline;{$EndIf}
begin
  if numColor >= managerColor.count then
    exit;
  glColor4ubv(@managerColor.Color[numColor]);
end;

function Get_Color(num: LongWord): LongWord; {$IfDef USE_INLINE} inline;{$EndIf}
begin
  if num >= managerColor.count then
    num := cl_Black05;
  Result := managerColor.Color[num];
end;

function Get_ElColor(num, El: LongWord): LongWord;
begin
  Result := $FFFFFFFF;
  if (El > is_clAlpha) or (num >= managerColor.count) then
    Exit;
  nP := @managerColor.Color[num];
  case El of
    is_clRed: ;  //Result := n and $FF;
    is_clGreen: inc(nP);//Result := (n and $FF00) shr 8;
    is_clBlue:  inc(nP, 2);//Result := (n and $FF0000) shr 16;
    is_clAlpha: inc(nP, 3);//Result := (n and $FF000000) shr 24;
  end;
  Result := nP^;
end;

function Set_ElColor(num, El: LongWord; value: LongWord): Boolean;
begin
  Result := False;
  if (num < 32) or (El > is_clAlpha) then
    Exit;
  // "простое" решение
  nP := @managerColor.Color[num];
  case El of
    is_clRed:   ; //n^ := n^ and $FFFFFF00 + value;
    is_clGreen: inc(nP); //n^ := n^ and $FFFF00FF or (value shl 8);
    is_clBlue:  inc(nP, 2);//n^ := n^ and $FF00FFFF + (value shl 16);
    is_clAlpha: inc(nP, 3);//n^ := n^ and $00FFFFFF + (value shl 24);
  end;
  nP^ := value;
  Result := True;
end;

// Rus: установка заранее определённых цветов по умолчанию.
// Eng:
procedure SetAndAddDefaultColor;
var
  i, j: LongWord;
  useMem: zglTMemory;
begin
{  if file_Open(f, 'myColor.txt', FOM_CREATE) then
  begin
    for i := 0 to 31 do
    begin
      file_Write(f, managerColor.BColor[i].R, SizeOf(Byte));
      file_Write(f, managerColor.BColor[i].G, SizeOf(Byte));
      file_Write(f, managerColor.BColor[i].B, SizeOf(Byte));
      file_Write(f, managerColor.BColor[i].A, SizeOf(Byte));
    end;
    file_Close(f);
  end;          }
 { if not mem_LoadFromFile(useMem, dir + 'myColor.txt') then
  begin
    log_Add('File myColor.txt not load!');
    exit;
  end;
  i := 0;
  j := useMem.Size shr 2;     // делим на 4
  while i < j do
  begin
    if managerColor.count >= managerColor.len then
    begin
      inc(managerColor.len, 100);
      SetLength(managerColor.Color, managerColor.len);
    end;
    // читаем из памяти
    mem_Read(useMem, managerColor.Color[i], 4);
    inc(i);
    inc(managerColor.count);
  end;
  mem_Free(useMem);  }
  SetLength(managerColor.Color, 33);
  for i := 0 to 32 do
  begin
    managerColor.Color[i] := zglDefColor[i];
  end;
  managerColor.len := 33;
  managerColor.count := 33;
end;

initialization

  managerColor.len := 0;
  SetAndAddDefaultColor();

end.

