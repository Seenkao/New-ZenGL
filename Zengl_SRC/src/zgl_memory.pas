{
 *  Copyright (c) 2012 Andrey Kemka
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
unit zgl_memory;

{$I zgl_config.cfg}

interface
uses
  zgl_types;

// Rus: Загружаем файл FileName в память Memory.
// Eng: Load file FileName into Memory.
function  mem_LoadFromFile(out Memory: zglTMemory; const FileName: UTF8String): Boolean;
// Rus: Сохраняем в файл FileName данные взятые из памяти Memory.
// Eng: We save the data taken from Memory into the FileName file.
function  mem_SaveToFile(var Memory: zglTMemory; const FileName: UTF8String): Boolean;
// Rus: Установка позиции курсора. Mode указание положения "курсора".
//      FSM_SET - точное
//      FSM_CUR - смещение от текущего курсора
//      FSM_END - от конца
// Eng: Setting the cursor position. Mode indicating the position of the "cursor".
//      FSM_SET - exact
//      FSM_CUR - offset from the current cursor
//      FSM_END - from the end
function  mem_Seek(var Memory: zglTMemory; Offset, Mode: Integer): LongWord;
// Rus: Чтение из памяти в указанный буфер. Указанное количество байт.
// Eng: Read from memory into the specified buffer. The specified number of bytes.
function  mem_Read(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
// Rus: Копирование из памяти в указанный буфер. Указанное количество байт.
// Eng: Copy from memory to the specified buffer. The specified number of bytes.
function  mem_Copy(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
// Rus: Чтение из памяти в указанный буфер. Указанное количество байт. Обратный
//      порядок байт.
// Eng: Read from memory into the specified buffer. The specified number of
//      bytes. Big endian.
function  mem_ReadSwap(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
// Rus: Копирование из памяти в указанный буфер. Указанное количество байт.
//      Обратный порядок байт.
// Eng: Copy from memory to the specified buffer. The specified number of bytes.
//      Big endian.
function  mem_CopySwap(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
// Rus: Записываем в память данные из буфера.
// Eng: We write data from the buffer into memory.
function  mem_Write(var Memory: zglTMemory; const Buffer; Bytes: LongWord): LongWord;
// Rus: Изменение/установка размеров памяти.
// Eng: Changing/setting memory sizes.
procedure mem_SetSize(var Memory: zglTMemory; Size: LongWord);
// Rus: Очистка памяти.
// Eng: Clearing memory.
procedure mem_Free(var Memory: zglTMemory);

{$IFDEF ENDIAN_BIG}
threadvar
  forceNoSwap: Boolean;
{$ENDIF}

implementation
uses
  zgl_window,
  zgl_file;

function mem_LoadFromFile(out Memory: zglTMemory; const FileName: UTF8String): Boolean;
  var
    f: zglTFile;
begin
  Result := FALSE;
  if not file_Exists(FileName) Then exit;

  if file_Open(f, FileName, FOM_OPENR) Then
  begin
    Memory.Size     := file_GetSize(f);
    Memory.Position := 0;
    zgl_GetMem(Memory.Memory, Memory.Size);
    file_Read(f, Memory.Memory^, Memory.Size);
    file_Close(f);
    Result := TRUE;
  end;
end;

function mem_SaveToFile(var Memory: zglTMemory; const FileName: UTF8String): Boolean;
  var
    f: zglTFile;
begin
  Result := file_Open(f, FileName, FOM_CREATE);

  if Result Then
  begin
    file_Write(f, Memory.Memory^, Memory.Size);
    file_Close(f);
  end;
end;

function mem_Seek(var Memory: zglTMemory; Offset, Mode: Integer): LongWord;
begin
  case Mode of
    FSM_SET: Memory.Position := Offset;
    FSM_CUR: Memory.Position := Memory.Position + Offset;
    FSM_END: Memory.Position := Memory.Size + Offset;
  end;
  Result := Memory.Position;
end;

function mem_Read(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
begin
  {$IFDEF ENDIAN_BIG}
  if (Bytes <= 4) and (not forceNoSwap) Then
  begin
    Result := mem_ReadSwap(Memory, Buffer, Bytes);
    exit;
  end;
  {$ENDIF}
  if Bytes > 0 Then
  begin
    Result := Memory.Size - Memory.Position;
    if Result > 0 Then
    begin
      if Result > Bytes Then
        Result := Bytes;
      Move(PByteArray(Memory.Memory)[Memory.Position], Buffer, Result);
      INC(Memory.Position, Result);
      exit;
    end;
  end;
  Result := 0;
end;

function  mem_Copy(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
var
  pos: LongWord;
begin
  {$IFDEF ENDIAN_BIG}
  if (Bytes <= 4) and (not forceNoSwap) Then
  begin
    Result := mem_CopySwap(Memory, Buffer, Bytes);
    exit;
  end;
  {$ENDIF}
  pos := Memory.Position;
  if Bytes > 0 Then
  begin
    Result := Memory.Size - pos;
    if Result > 0 Then
    begin
      if Result > Bytes Then
        Result := Bytes;
      Move(PByteArray(Memory.Memory)[pos], Buffer, Result);
      INC(pos, Result);
      exit;
    end;
  end;
  Result := 0;
end;

function mem_ReadSwap(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
var
  i: LongWord;
begin
  {$IFDEF ENDIAN_BIG}
  if forceNoSwap Then
  begin
    Result := mem_Read(Memory, Buffer, Bytes);
    exit;
  end;
  {$ENDIF}
  if Bytes > 0 Then
  begin
    Result := Memory.Size - Memory.Position;
    if Result > 0 Then
    begin
      if Result > Bytes Then
        Result := Bytes;
      for i := 0 to Result - 1 do
      begin
        PByteArray(@Buffer)[Result - i - 1] := PByteArray(Memory.Memory)[Memory.Position];
        INC(Memory.Position);
      end;
      exit;
    end;
  end;
  Result := 0;
end;

function  mem_CopySwap(var Memory: zglTMemory; var Buffer; Bytes: LongWord): LongWord;
var
  i, pos: LongWord;
begin

  {$IFDEF ENDIAN_BIG}
  if forceNoSwap Then
  begin
    Result := mem_Copy(Memory, Buffer, Bytes);
    exit;
  end;
  {$ENDIF}
  pos := Memory.Position;
  if Bytes > 0 Then
  begin
    Result := Memory.Size - pos;
    if Result > 0 Then
    begin
      if Result > Bytes Then
        Result := Bytes;
      for i := 0 to Result - 1 do
      begin
        PByteArray(@Buffer)[Result - i - 1] := PByteArray(Memory.Memory)[pos];
        INC(pos);
      end;
      exit;
    end;
  end;
  Result := 0;
end;

function mem_Write(var Memory: zglTMemory; const Buffer; Bytes: LongWord): LongWord;
begin
  if Bytes = 0 Then
    begin
      Result := 0;
      exit;
    end;
  if Memory.Position + Bytes > Memory.Size Then
    mem_SetSize(Memory, Memory.Position + Bytes);
  Move(Buffer, PByteArray(Memory.Memory)[Memory.Position], Bytes);
  INC(Memory.Position, Bytes);
  Result := Bytes;
end;

procedure mem_SetSize(var Memory: zglTMemory; Size: LongWord);
begin
  Memory.Memory := ReAllocMemory(Memory.Memory, Size);
  Memory.Size   := Size;
end;

procedure mem_Free(var Memory: zglTMemory);
begin
  FreeMem(Memory.Memory);
  Memory.Memory   := nil;
  Memory.Size     := 0;
  Memory.Position := 0;
end;

end.
