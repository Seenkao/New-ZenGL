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

const
  // это всё для тестов, позже надо будет переименовать названия матриц или пронумеровать их просто.
  projectionMatrix          = 0;
  viewMatrix                = 1;
  viewProjectionMatrix      = 2;
  modelMatrix               = 3;
  modelViewProjectionMatrix = 4;

type
  // матрицы уже есть, но пока будем использовать одномерные матрицы вместо двумерных.
  PMatrix4x4s = ^TMatrix4x4s;
  PMatrix4x4d = ^TMatrix4x4d;
  // Single matrix.
  TMatrix4x4s = array [0..15] of Single;
  // Double matrix (not used in ZenGL).
  TMatrix4x4d = array [0..15] of Double;

// RU: матрица перспективы, заполняет матрицу "zgl_MatrixS[projectionMatrix]".
// EN: perspective matrix, fills the matrix "zgl_MatrixS[projectionMatrix]".
procedure Matrix4x4_Perspective(fovy, aspect, _near, _far: Single);
// RU: ортографическая матрица, заполняет матрицу "zgl_MatrixS[projectionMatrix]".
// EN: orthographic matrix, fills the matrix "zgl_MatrixS[projectionMatrix]".
procedure Matrix4x4_Orthographic(Left, Right, Bottom, Top, _Near, _Far: Single);
// RU: загрузка шейдера, компиляция и проверка на успех компиляции.
// EN: loading the shader, compiling and checking for compilation success.
function LoadAndCreateShader(name: string; shade: GLuint): Boolean;
// RU: матрица вращения.
// EN:
procedure Matrix4x4_Rotation(mat4x4: PMatrix4x4s; Const X, Y, Z: Single);
// RU: матрица перемещения.
// EN:
procedure Matrix4x4_Translation(mat4x4: PMatrix4x4s; Const X, Y, Z: Single);
// RU: перемножение матриц.
// EN:
procedure Matrix4x4Multiply4x4(A, B: PMatrix4x4s; C: PMatrix4x4s);

var
  // RU: массив матриц: projectionMatrix, viewMatrix, viewProjectionMatrix,
  //     modelMatrix, modelViewProjectionMatrix; и ещё пять не занятых.
  // EN: matrix array: projectionMatrix, viewMatrix, viewProjectionMatrix,
  //     modelMatrix, modelViewProjectionMatrix; and five more unoccupied.
  zgl_MatrixS: array[0..9, 0..15] of Single;

implementation

procedure Matrix4x4_Perspective(fovy, aspect, _near, _far: Single);
var
  f: Single;
begin
  f := 1 / tan(fovy * Pi / 180);
  zgl_Matrixs[projectionMatrix, 0] := f / aspect;
  zgl_Matrixs[projectionMatrix, 1] := 0;
  zgl_Matrixs[projectionMatrix, 2] := 0;
  zgl_Matrixs[projectionMatrix, 3] := 0;

  zgl_Matrixs[projectionMatrix, 4] := 0;
  zgl_Matrixs[projectionMatrix, 5] := f;
  zgl_Matrixs[projectionMatrix, 6] := 0;
  zgl_Matrixs[projectionMatrix, 7] := 0;

  zgl_Matrixs[projectionMatrix, 8] := 0;
  zgl_Matrixs[projectionMatrix, 9] := 0;
  zgl_Matrixs[projectionMatrix, 10] := (_far + _near) / (_near - _far);
  zgl_Matrixs[projectionMatrix, 11] := 2 * _far * _near / (_near - _far);

  zgl_Matrixs[projectionMatrix, 12] := 0;
  zgl_Matrixs[projectionMatrix, 13] := 0;
  zgl_Matrixs[projectionMatrix, 14] := - 1;
  zgl_Matrixs[projectionMatrix, 15] := 0;
end;

procedure Matrix4x4_Orthographic(Left, Right, Bottom, Top, _Near, _Far: Single);
var
  f: Single;
begin
  f := Right - Left;
  zgl_Matrixs[projectionMatrix, 0] := 2 / f;
  zgl_Matrixs[projectionMatrix, 1] := 0;
  zgl_Matrixs[projectionMatrix, 2] := 0;
  zgl_Matrixs[projectionMatrix, 3] := -(Right + Left) / f;

  f := Top - Bottom;
  zgl_Matrixs[projectionMatrix, 4] := 0;
  zgl_Matrixs[projectionMatrix, 5] := 2 / f;
  zgl_Matrixs[projectionMatrix, 6] := 0;
  zgl_Matrixs[projectionMatrix, 7] := -(top + Bottom) / f;

  f := _Far - _Near;
  zgl_Matrixs[projectionMatrix, 8] := 0;
  zgl_Matrixs[projectionMatrix, 9] := 0;
  zgl_Matrixs[projectionMatrix, 10] := - 2 / f;
  zgl_Matrixs[projectionMatrix, 11] := -(_Far + _Near) / f;

  zgl_Matrixs[projectionMatrix, 12] := 0;
  zgl_Matrixs[projectionMatrix, 13] := 0;
  zgl_Matrixs[projectionMatrix, 14] := 0;
  zgl_Matrixs[projectionMatrix, 15] := 1;
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

procedure Matrix4x4_Rotation(mat4x4: PMatrix4x4s; const X, Y, Z: Single);
Var
  cosX, sinX, cosY, sinY, cosZ, sinZ, sinXsinY, cosXsinY: Single;
Begin
  cosX := Cos(X);
  sinX := Sin(X);
  cosY := Cos(Y);
  sinY := Sin(Y);
  cosZ := Cos(Z);
  sinZ := Sin(Z);

  mat4x4[0] := cosY * cosZ;
  mat4x4[1] := cosY * sinZ;
  mat4x4[2] := -sinY;

  If mat4x4[2] = -0 Then
    mat4x4[2] := 0;
  mat4x4[3] := 0.0;

  sinXsinY := sinX * sinY;
  cosXsinY := cosX * sinY;

  mat4x4[4] := (sinXsinY * cosZ) - (cosX * sinZ);
  mat4x4[5] := (sinXsinY * sinZ) + (cosX * cosZ);
  mat4x4[6] := (sinX * cosY);
  mat4x4[7] := 0.0;

  mat4x4[8] := (cosXsinY * cosZ) + (sinX * sinZ);
  mat4x4[9] := (cosXsinY * sinZ) - (sinX * cosZ);
  mat4x4[10] := (cosX * cosY);
  mat4x4[11] := 0.0;

  mat4x4[12] := 0.0;
  mat4x4[13] := 0.0;
  mat4x4[14] := 0.0;
  mat4x4[15] := 1.0;
end;

// изменить процедуру, тут можно многое сразу заполнить нулями, как и в других матрицах. Будет только вопрос в одном, будет ли это быстрее?
procedure Matrix4x4_Translation(mat4x4: PMatrix4x4s; Const X, Y, Z: Single);
Begin
  mat4x4[0] := 1.0;
  mat4x4[1] := 0.0;
  mat4x4[2] := 0.0;
  mat4x4[3] := 0.0;
  mat4x4[4] := 0.0;
  mat4x4[5] := 1.0;
  mat4x4[6] := 0.0;
  mat4x4[7] := 0.0;
  mat4x4[8] := 0.0;
  mat4x4[9] := 0.0;
  mat4x4[10] := 1.0;
  mat4x4[11] := 0.0;
  mat4x4[12] := X;
  mat4x4[13] := Y;
  mat4x4[14] := Z;
  mat4x4[15] := 1.0;
End;

{/$If defined(CPUAARCH64) or defined(CPUARM)}
procedure Matrix4x4Multiply4x4(A, B: PMatrix4x4s; C: PMatrix4x4s);
begin
  C[0]  := A[0] * B[0] + A[4] * B[1] + A[8]  * B[2] + A[12] * B[3];
  C[1]  := A[1] * B[0] + A[5] * B[1] + A[9]  * B[2] + A[13] * B[3];
  C[2]  := A[2] * B[0] + A[6] * B[1] + A[10] * B[2] + A[14] * B[3];
  C[3]  := A[3] * B[0] + A[7] * B[1] + A[11] * B[2] + A[15] * B[3];

  C[4]  := A[0] * B[4] + A[4] * B[5] + A[8]  * B[6] + A[12] * B[7];
  C[5]  := A[1] * B[4] + A[5] * B[5] + A[9]  * B[6] + A[13] * B[7];
  C[6]  := A[2] * B[4] + A[6] * B[5] + A[10] * B[6] + A[14] * B[7];
  C[7]  := A[3] * B[4] + A[7] * B[5] + A[11] * B[6] + A[15] * B[7];

  C[8]  := A[0] * B[8] + A[4] * B[9] + A[8]  * B[10] + A[12] * B[11];
  C[9]  := A[1] * B[8] + A[5] * B[9] + A[9]  * B[10] + A[13] * B[11];
  C[10] := A[2] * B[8] + A[6] * B[9] + A[10] * B[10] + A[14] * B[11];
  C[11] := A[3] * B[8] + A[7] * B[9] + A[11] * B[10] + A[15] * B[11];

  C[12] := A[0] * B[12] + A[4] * B[13] + A[8]  * B[14] + A[12] * B[15];
  C[13] := A[1] * B[12] + A[5] * B[13] + A[9]  * B[14] + A[13] * B[15];
  C[14] := A[2] * B[12] + A[6] * B[13] + A[10] * B[14] + A[14] * B[15];
  C[15] := A[3] * B[12] + A[7] * B[13] + A[11] * B[14] + A[15] * B[15];
End;
{/$Else}
(*    требуется переделка под процедуру, когда переделаю, тогда будем всё тестировать по полной, сейчас нужен рабочий код.
Function Matrix4x4Multiply4x4(Const A,B:Matrix4x4):Matrix4x4;
Asm
  movss xmm0, dword ptr [edx]
  movups xmm1,  [eax]
  shufps xmm0, xmm0, 0
  movss xmm2, dword ptr [edx+4]
  mulps xmm0, xmm1
  shufps xmm2, xmm2, 0
  movups xmm3,  [eax+10h]
  movss xmm7, dword ptr [edx+8]
  mulps xmm2, xmm3
  shufps xmm7, xmm7, 0
  addps xmm0, xmm2
  movups xmm4,  [eax+20h]
  movss xmm2, dword ptr [edx+0Ch]
  mulps xmm7, xmm4
  shufps xmm2, xmm2, 0
  addps xmm0, xmm7
  movups xmm5,  [eax+30h]
  movss xmm6, dword ptr [edx+10h]
  mulps xmm2, xmm5
  movss xmm7, dword ptr [edx+14h]
  shufps xmm6, xmm6, 0
  addps xmm0, xmm2
  shufps xmm7, xmm7, 0
  movlps qword ptr [ecx], xmm0
  movhps qword ptr [ecx+8], xmm0
  mulps xmm7, xmm3
  movss xmm0, dword ptr [edx+18h]
  mulps xmm6, xmm1
  shufps xmm0, xmm0, 0
  addps xmm6, xmm7
  mulps xmm0, xmm4
  movss xmm2, dword ptr [edx+24h]
  addps xmm6, xmm0
  movss xmm0, dword ptr [edx+1Ch]
  movss xmm7, dword ptr [edx+20h]
  shufps xmm0, xmm0, 0
  shufps xmm7, xmm7, 0
  mulps xmm0, xmm5
  mulps xmm7, xmm1
  addps xmm6, xmm0
  shufps xmm2, xmm2, 0
  movlps qword ptr [ecx+10h], xmm6
  movhps qword ptr [ecx+18h], xmm6
  mulps xmm2, xmm3
  movss xmm6, dword ptr [edx+28h]
  addps xmm7, xmm2
  shufps xmm6, xmm6, 0
  movss xmm2, dword ptr [edx+2Ch]
  mulps xmm6, xmm4
  shufps xmm2, xmm2, 0
  addps xmm7, xmm6
  mulps xmm2, xmm5
  movss xmm0, dword ptr [edx+34h]
  addps xmm7, xmm2
  shufps xmm0, xmm0, 0
  movlps qword ptr [ecx+20h], xmm7
  movss xmm2, dword ptr [edx+30h]
  movhps qword ptr [ecx+28h], xmm7
  mulps xmm0, xmm3
  shufps xmm2, xmm2, 0
  movss xmm6, dword ptr [edx+38h]
  mulps xmm2, xmm1
  shufps xmm6, xmm6, 0
  addps xmm2, xmm0
  mulps xmm6, xmm4
  movss xmm7, dword ptr [edx+3Ch]
  shufps xmm7, xmm7, 0
  addps xmm2, xmm6
  mulps xmm7, xmm5
  addps xmm2, xmm7
  movups  [ecx+30h], xmm2
End;       *)
{/$ENDIF}

end.

