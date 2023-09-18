unit zgl_matrix;
{$mode delphi}
{$I zgl_config.cfg}
interface

uses
  Math,
  zgl_window,
  zgl_types,
  zgl_gltypeconst,
  zgl_pasOpenGL,
  zgl_file;

// RU: матрица перспективы.
// EN: perspective matrix.
procedure Matrix4_Perspective(fovy, aspect, _near, _far: Single);
// RU: ортографическая матрица.
// EN: orthographic matrix.
procedure Matrix4_Orthographic(Left, Right, Bottom, Top, _Near, _Far: Single);
// RU: загрузка шейдера, компиляция и проверка на успех компиляции.
// EN: loading the shader, compiling and checking for compilation success.
function LoadAndCreateShader(name: string; shade: GLuint): Boolean;

var
  // RU: массив матрицы проекции.
  // EN:
  projMatr: array[0..15] of Single;

implementation

procedure Matrix4_Perspective(fovy, aspect, _near, _far: Single);
var
  f: Single;
begin
  f := 1 / tan(fovy * Pi / 180);
  projMatr[0] := f / aspect;
  projMatr[1] := 0;
  projMatr[2] := 0;
  projMatr[3] := 0;

  projMatr[4] := 0;
  projMatr[5] := f;
  projMatr[6] := 0;
  projMatr[7] := 0;

  projMatr[8] := 0;
  projMatr[9] := 0;
  projMatr[10] := (_far + _near) / (_near - _far);
  projMatr[11] := 2 * _far * _near / (_near - _far);

  projMatr[12] := 0;
  projMatr[13] := 0;
  projMatr[14] := - 1;
  projMatr[15] := 0;
end;

procedure Matrix4_Orthographic(Left, Right, Bottom, Top, _Near, _Far: Single);
var
  f: Single;
begin
  f := Right - Left;
  projMatr[0] := 2 / f;
  projMatr[1] := 0;
  projMatr[2] := 0;
  projMatr[3] := -(Right + Left) / f;

  f := Top - Bottom;
  projMatr[4] := 0;
  projMatr[5] := 2 / f;
  projMatr[6] := 0;
  projMatr[7] := -(top + Bottom) / f;

  f := _Far - _Near;
  projMatr[8] := 0;
  projMatr[9] := 0;
  projMatr[10] := - 2 / f;
  projMatr[11] := -(_Far + _Near) / f;

  projMatr[12] := 0;
  projMatr[13] := 0;
  projMatr[14] := 0;
  projMatr[15] := 1;
end;

function LoadAndCreateShader(name: string; shade: GLuint): Boolean;
var
  Ftext: zglTFile;
  Fmem: zglTMemory;
  status: GLint;
begin
  Result := False;
  // RU: проверка существования загружаемого файла.
  // EN: Checking the existence of the downloaded file.
  if not file_Exists(name) then
    Exit;
  // RU: открываем файл.
  // EN: open the file.
  if file_Open(Ftext, name, FOM_OPENR)then
  begin
    Fmem.Size := file_GetSize(Ftext);
    Fmem.Position := 0;
    // RU: подготавливаем память для загрузки шейдера.
    // EN: prepare memory for loading the shader.
    zgl_GetMem(Fmem.Memory, Fmem.Size);
    // RU: загружаем шейдер в память.
    // EN: load the shader into memory.
    file_Read(Ftext, Fmem.Memory^, Fmem.Size);
    file_Close(Ftext);
    // RU: исходный код шейдера и его компиляция. Обратите внимание, "Fmem.Memory"
    //     это указатель на память, где находится строка. И мы передаём указатель
    //     на данный участок памяти. Это работает правильно, потому что данные
    //     должны идти под двойным указателем (PPGLchar).
    // EN: shader source code and its compilation. Note that "Fmem.Memory" is a
    //     pointer to the memory where the string is located. And we pass a
    //     pointer to this memory location. This works correctly because the data
    //     must go under a double pointer (PPGLchar).
    glShaderSource(shade, 1, @Fmem.Memory, @Fmem.Size);
    glCompileShader(shade);
    // RU: освобождаем память, данный текст больше не нужен.
    // EN: freeing up memory, this text is no longer needed.
    zgl_FreeMem(Fmem.Memory);
  end;

  // RU: проверяем на успех компиляции шейдера.
  // EN: check for success of shader compilation.
  glGetShaderiv(shade, GL_COMPILE_STATUS, @status);
  if status <> 1 then
    Exit;
  Result := True;
end;

end.

