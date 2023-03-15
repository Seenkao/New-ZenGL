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

 !!! modification from Serge 04.08.2020
}
unit zgl_textures;

{$I zgl_config.cfg}
{$I GLdefine.cfg}

interface

uses
  zgl_types,
  zgl_math_2d,
  zgl_gltypeconst;

// Rus: добавление текстуры и выделение памяти под неё. Возвращает указатель на
//      заданную структуру. Текстура не загружается.
// Eng: adding a texture and allocating memory for it. Returns a pointer to the
//      given structure. The texture is not loading.
function  tex_Add: zglPTexture;
// Rus: удаление текстуры из видеопамяти и из менеджера текстур.
// Eng: deleting a texture from video memory and from the texture manager.
procedure tex_Del(var Texture: zglPTexture);

// Rus: загрузка текстуры в видеопамять. Вызывать не надо, вызывайте tex_Create.
// Eng: loading texture into video memory. No need to call, call tex_Create.
function  tex_CreateGL(var Texture: zglTTexture; pData: PByteArray): Boolean;
// Rus: создание текстуры с заданной шириной, высотой, форматом и заданными
//      флагами. Вы должны передать загруженное изображение массивом данных.
//      Возвращает указатель на созданную структуру.
// Eng: creating a texture with the given width, height, format and the given
//      flags. You must pass the uploaded image as an array of data. Returns a
//      pointer to the created structure.
function  tex_Create(var Data: PByteArray; Width, Height: Word; Format: Word = TEX_FORMAT_RGBA;
    Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
// Rus: создание текстуры с заданной шириной, высотой, цветом и заданными
//      флагами. В видеопамяти создаётся изображение с заданным цветом.
//      Возвращает указатель на созданную структуру.
// Eng: creating a texture with the given width, height, color and given flags.
//      An image with the specified color is created in the video memory.
//      Returns a pointer to the created structure.
function  tex_CreateZero(Width, Height: Word; Color: LongWord = $000000; Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
// Rus: загрузка текстуры из заданного файла, с заданой прозрачностью и флагами.
//      Возвращает указатель на созданную структуру.
// Eng: loading a texture from a given file, with a given transparency and flags.
//      Returns a pointer to the created structure.
function  tex_LoadFromFile(const FileName: UTF8String; TransparentColor: LongWord = TEX_NO_COLORKEY;
    Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
// Rus: загрузка текстуры из памяти. С указанием расширения файла (который был
//      загружен в память), с заданной прозрачностью и флагами. Возвращает
//      указатель на созданную структуру.
// Eng: loading texture from memory. Specifying the extension of the file (which
//      was loaded into memory), with the given transparency and flags. Returns
//      a pointer to the created structure.
function  tex_LoadFromMemory(const Memory: zglTMemory; const Extension: UTF8String;
    TransparentColor: LongWord = TEX_NO_COLORKEY; Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
{$IFDEF ANDROID}
// Rus: восстанавливаем данные в текстуре из указанного файла.
// Eng: restore the data in the texture from the specified file.
procedure tex_RestoreFromFile(var Texture: zglPTexture; const FileName: UTF8String;
    TransparentColor: LongWord = TEX_NO_COLORKEY; Flags: LongWord = TEX_DEFAULT_2D);
// Rus: восстанавливаем данные в текстуре из указанной памяти.
// Eng: Restore the data in the texture from the specified memory.
procedure tex_RestoreFromMemory(var Texture: zglPTexture; const Memory: zglTMemory;
    const Extension: UTF8String; TransparentColor: LongWord = TEX_NO_COLORKEY; Flags: LongWord = TEX_DEFAULT_2D);
{$ENDIF}
// Rus: разбивает текстуру на кадры заданной ширины и высоты. Все текстурные
//      координаты сохраняются в самой текстуре.
// Eng: splits the texture into frames of the specified width and height. All
//      texture coordinates are stored in the texture itself.
procedure tex_SetFrameSize(var Texture: zglPTexture; FrameWidth, FrameHeight: Word);
// Rus: накладываем маску на заданную текстуру. Размеры маски и текстуры должны
//      быть одинаковыми.
// Eng: apply a mask to the given texture. The dimensions of the mask and texture
//      must be the same.
procedure tex_SetMask(var Texture: zglPTexture; Mask: zglPTexture);
// Rus: сама процедура разбития текстуры на кадры. Используйте tex_SetFrameSize.
// Eng: the procedure for splitting the texture into frames. Use tex_SetFrameSize.
procedure tex_CalcTexCoords(var Texture: zglTTexture; FramesX: Integer = 1; FramesY: Integer = 1);

// Rus: фильтрация текстуры по заданным флагам.
// Eng: texture filtering by given flags.
procedure _tex_Filter(Texture: zglPTexture; Flags: LongWord);
// Rus: Устанавливает уровень анизотропной фильтрации для текстур.
// Eng: Sets the level of anisotropic filtering for textures.
procedure tex_SetAnisotropy(Level: Byte);

// Rus: вычисление преобразований текстуры согласно флагов.
// Eng: calculation of texture transformations according to flags.
procedure tex_CalcFlags(var Texture: zglTTexture; var pData: PByteArray);
// Rus: расширение текстуры до ближайшей текстуры с размерами 2^n (2, 4, 8, 16,
//      32 и т. д.).
// Eng: extending the texture to the nearest 2^n texture (2, 4, 8, 16, 32, etc.).
procedure tex_CalcPOT(var pData: PByteArray; var Width, Height: Word; var U, V: Single; PixelSize: Integer);
// Rus: конвертировать текстуру в градиент белый-серый-чёрный.
// Eng: convert texture to white-gray-black gradient.
procedure tex_CalcGrayScale(pData: PByteArray; Width, Height: Word);
// Rus: инвертировать текстуру.
// Eng: invert texture.
procedure tex_CalcInvert(pData: PByteArray; Width, Height: Word);
// Rus: вычисление прозрачности, согласно передаваемой TransparentColor.
// Eng: transparency calculation, according to the transmitted TransparentColor.
procedure tex_CalcTransparent(pData: PByteArray; TransparentColor: LongWord; Width, Height: Word);
// Rus: вычислить цвет для прозрачных пикселей для лучшего рендеринга
//      преобразованной текстуры.
// Eng: calculate color for transparent pixels for better rendering of
//      transformed texture.
procedure tex_CalcAlpha(pData: PByteArray; Width, Height: Word);

// Rus: устанавливает данные из массива в текстуру.
// Eng: sets the data from the array to the texture.
procedure tex_SetData(Texture: zglPTexture; pData: PByteArray; X, Y, Width, Height: Word; Stride: Integer = 0);
// Rus: возвращаем данные из текстуры в массив.
// Eng: return the data from the texture to the array.
procedure tex_GetData(Texture: zglPTexture; out pData: PByteArray);

var
  managerTexture      : zglTTextureManager;
  managerZeroTexture  : zglPTexture;
  tex_CalcCustomEffect: procedure(pData: PByteArray; Width, Height: Word);

implementation
uses
  zgl_window,
  {$IfDef USE_GLU}
  zgl_glu,
  {$EndIf}
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  zgl_pasOpenGL,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render_2d,
  zgl_resources,
  zgl_file,
  zgl_log,
  zgl_utils;

function tex_GetVRAM(Texture: zglPTexture): LongWord;
var
  size: LongWord;
begin
  if (not Assigned(Texture)) or (Texture.ID = 0) Then
  begin
    Result := 0;
    exit;
  end;

  size := Round(Texture.Width / Texture.U) * Round(Texture.Height / Texture.V);
  case Texture.Format of
    TEX_FORMAT_RGBA: Result := size * 4;
    TEX_FORMAT_RGBA_4444: Result := size * 2;
    {$IFDEF USE_GLES}
    TEX_FORMAT_RGBA_PVR2: Result := size div 4;
    TEX_FORMAT_RGBA_PVR4: Result := size div 2;
    {$ELSE}
    TEX_FORMAT_RGBA_DXT1: Result := size div 2;
    TEX_FORMAT_RGBA_DXT3: Result := size;
    TEX_FORMAT_RGBA_DXT5: Result := size;
    {$ENDIF}
  else
    Result := 0;
  end;
end;

function tex_Add: zglPTexture;
begin
  Result := @managerTexture.First;
  while Assigned(Result.next) do
    Result := Result.next;

  zgl_GetMem(Pointer(Result.next), SizeOf(zglTTexture));
  Result.next.U    := 1;
  Result.next.V    := 1;
  Result.next.prev := Result;
  Result.next.next := nil;
  Result := Result.next;
  INC(managerTexture.Count.Items);
end;

procedure tex_Del(var Texture: zglPTexture);
begin
  if (not Assigned(Texture)) or (Texture = managerZeroTexture) Then
  begin
    Texture := nil;
    exit;
  end;

  oglVRAMUsed := oglVRAMUsed - tex_GetVRAM(Texture);

  glDeleteTextures(1, @Texture.ID);
  if Assigned(Texture.prev) Then
    Texture.prev.next := Texture.next;
  if Assigned(Texture.next) Then
    Texture.next.prev := Texture.prev;
  SetLength(Texture.FramesCoord, 0);

//  SetLength(Texture.FrameID, 0);

  FreeMem(Texture);
  Texture := nil;

  DEC(managerTexture.Count.Items);
end;

function tex_CreateGL(var Texture: zglTTexture; pData: PByteArray): Boolean;
  var
    width : Integer;
    height: Integer;
    size  : LongWord;
begin
  if Texture.Flags and TEX_COMPRESS >= 1 Then
  {$IFNDEF USE_GLES}
    if not GL_EXT_texture_compression_s3tc Then
  {$ENDIF}
      Texture.Flags := Texture.Flags xor TEX_COMPRESS;

  glEnable(GL_TEXTURE_2D);
  glGenTextures(1, @Texture.ID);

  _tex_Filter(@Texture, Texture.Flags);
  glBindTexture(GL_TEXTURE_2D, Texture.ID);

  width  := Round(Texture.Width / Texture.U);
  height := Round(Texture.Height / Texture.V);
  size   := tex_GetVRAM(@Texture);
  Result := FALSE;

  {$IFDEF USE_GLES}
  if ((not oglCanPVRTC) and ((Texture.Format = TEX_FORMAT_RGBA_DXT1) or (Texture.Format = TEX_FORMAT_RGBA_DXT3) or (Texture.Format = TEX_FORMAT_RGBA_DXT5))) or
  {$ELSE}
  if ((not GL_EXT_texture_compression_s3tc) and ((Texture.Format = TEX_FORMAT_RGBA_PVR2) or (Texture.Format = TEX_FORMAT_RGBA_PVR4))) or
  {$ENDIF}
    ((width > oglMaxTexSize) or (height > oglMaxTexSize)) Then
    begin
      glDisable(GL_TEXTURE_2D);
      exit;
    end;

  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

  {$IFNDEF USE_GLES}
  if (not GL_SGIS_generate_mipmap) and (Texture.Flags and TEX_MIPMAP > 0) Then
    begin
      if Texture.Flags and TEX_COMPRESS = 0 Then
// izmenit i ubrat zavisimost ot GLU
        gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, width, height, GL_RGBA, GL_UNSIGNED_BYTE, pData)
      else
        gluBuild2DMipmaps(GL_TEXTURE_2D, GL_COMPRESSED_RGBA_S3TC_DXT5_EXT, width, height, GL_RGBA, GL_UNSIGNED_BYTE, pData);
    end else
  {$ENDIF}
    begin
      if Texture.Flags and TEX_COMPRESS = 0 Then
      begin
        case Texture.Format of
              TEX_FORMAT_RGBA: glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pData);
              TEX_FORMAT_RGBA_4444: glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_SHORT_4_4_4_4, pData);
              {$IFDEF USE_GLES}
              TEX_FORMAT_RGBA_PVR2: glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG, width, height, 0, size, pData);
              TEX_FORMAT_RGBA_PVR4: glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG, width, height, 0, size, pData);
              {$ELSE}
              TEX_FORMAT_RGBA_DXT1: glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT1_EXT, width, height, 0, size, pData);
              TEX_FORMAT_RGBA_DXT3: glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT3_EXT, width, height, 0, size, pData);
              TEX_FORMAT_RGBA_DXT5: glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT5_EXT, width, height, 0, size, pData);
              {$ENDIF}
        end;
          {$IFDEF USE_GLES}
      end;
          {$ELSE}
    end else
      glTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT5_EXT, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pData);
          {$ENDIF}
      end;

  oglVRAMUsed := oglVRAMUsed + size;
  glDisable(GL_TEXTURE_2D);
  Result := TRUE;
end;

function tex_Create(var Data: PByteArray; Width, Height: Word; Format: Word = TEX_FORMAT_RGBA;
    Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
begin
  Result        := tex_Add();
  Result.Width  := Width;
  Result.Height := Height;
  Result.Format := Format;
  Result.Flags  := Flags;
  tex_CalcFlags(Result^, Data);
  tex_CalcTexCoords(Result^);
  if not tex_CreateGL(Result^, Data) Then
  begin
    tex_Del(Result);
    Result := managerZeroTexture;
  end;
end;

function tex_CreateZero(Width, Height: Word; Color: LongWord = $000000; Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
  var
    i    : LongWord;
    pData: PLongWordArray;
begin
  // нулевая текстура создаётся в zgl_init (zgl_application)
  GetMem(pData, Width * Height * 4);
  for i := 0 to Width * Height - 1 do
    pData[i] := Color;

  Result := tex_Create(PByteArray(pData), Width, Height, TEX_FORMAT_RGBA, Flags);
  FreeMem(pData);
end;

function tex_LoadFromFile(const FileName: UTF8String; TransparentColor: LongWord = TEX_NO_COLORKEY;
    Flags: LongWord = TEX_DEFAULT_2D): zglPTexture;
  var
    i     : Integer;
    ext   : UTF8String;
    pData : PByteArray;
    w, h  : Word;
    format: Word;
    res   : zglTTextureResource;
begin
  Result := managerZeroTexture;
  pData  := nil;

  if (not resUseThreaded) and (not file_Exists(FileName)) Then
  begin
    log_Add('Cannot read "' + FileName + '"');
    exit;
  end;

  ext := u_StrUp(file_GetExtension(FileName));
  for i := managerTexture.Count.Formats - 1 downto 0 do
    if ext = managerTexture.Formats[i].Extension Then
      if resUseThreaded Then
      begin
        Result               := tex_Add();
        res.FileName         := FileName;
        res.Texture          := Result;
        res.FileLoader       := managerTexture.Formats[i].FileLoader;
        res.TransparentColor := TransparentColor;
        res.Flags            := Flags;
        res_AddToQueue(RES_TEXTURE, TRUE, @res);
        exit;
      end else
        managerTexture.Formats[i].FileLoader(FileName, pData, w, h, format);

  if not Assigned(pData) Then
  begin
    log_Add('Unable to load texture: "' + FileName + '"');
    exit;
  end;

  if format = TEX_FORMAT_RGBA Then
  begin
    if Flags and TEX_CALCULATE_ALPHA > 0 Then
    begin
      tex_CalcTransparent(pData, TransparentColor, w, h);
      tex_CalcAlpha(pData, w, h);
    end else
      tex_CalcTransparent(pData, TransparentColor, w, h);
  end;
  Result := tex_Create(pData, w, h, format, Flags);

  log_Add('Texture loaded: "' + FileName + '"');

  FreeMem(pData);
end;

function tex_LoadFromMemory(const Memory: zglTMemory; const Extension: UTF8String; TransparentColor, Flags: LongWord): zglPTexture;
  var
    i     : Integer;
    ext   : UTF8String;
    pData : PByteArray;
    w, h  : Word;
    format: Word;
    res   : zglTTextureResource;
begin
  Result := managerZeroTexture;
  pData  := nil;

  ext := u_StrUp(Extension);
  for i := managerTexture.Count.Formats - 1 downto 0 do
    if ext = managerTexture.Formats[i].Extension Then
      if resUseThreaded Then
      begin
        Result               := tex_Add();
        res.Memory           := Memory;
        res.Texture          := Result;
        res.MemLoader        := managerTexture.Formats[i].MemLoader;
        res.TransparentColor := TransparentColor;
        res.Flags            := Flags;
        res_AddToQueue(RES_TEXTURE, FALSE, @res);
        exit;
      end else
        managerTexture.Formats[i].MemLoader(Memory, pData, w, h, format);

  if not Assigned(pData) Then
  begin
    log_Add('Unable to load texture: From Memory');
    exit;
  end;

  if format = TEX_FORMAT_RGBA Then
  begin
    if Flags and TEX_CALCULATE_ALPHA > 0 Then
    begin
      tex_CalcTransparent(pData, TransparentColor, w, h);
      tex_CalcAlpha(pData, w, h);
    end else
      tex_CalcTransparent(pData, TransparentColor, w, h);
  end;
  Result := tex_Create(pData, w, h, format, Flags);

  FreeMem(pData);
end;

{$IFDEF ANDROID}
procedure tex_RestoreFromFile(var Texture: zglPTexture; const FileName: UTF8String;
    TransparentColor: LongWord = TEX_NO_COLORKEY; Flags: LongWord = TEX_DEFAULT_2D);
  var
    i     : Integer;
    ext   : UTF8String;
    pData : PByteArray;
    w, h  : Word;
    format: Word;
    res   : zglTTextureResource;
begin
  pData  := nil;

  if (not resUseThreaded) and (not file_Exists(FileName)) Then
  begin
    Texture.ID := managerZeroTexture.ID;
    log_Add('Cannot read "' + FileName + '"');
    exit;
  end;

  ext := u_StrUp(file_GetExtension(FileName));
  for i := managerTexture.Count.Formats - 1 downto 0 do
    if ext = managerTexture.Formats[i].Extension Then
      if resUseThreaded Then
      begin
        res.FileName         := FileName;
        res.Texture          := Texture;
        res.FileLoader       := managerTexture.Formats[i].FileLoader;
        res.TransparentColor := TransparentColor;
        res.Flags            := Flags;
        res_AddToQueue(RES_TEXTURE_RESTORE, TRUE, @res);
        exit;
      end else
        managerTexture.Formats[i].FileLoader(FileName, pData, w, h, format);

  if not Assigned(pData) Then
  begin
    Texture.ID := managerZeroTexture.ID;
    log_Add('Unable to restore texture: "' + FileName + '"');
    exit;
  end;

  if format = TEX_FORMAT_RGBA Then
  begin
    if Flags and TEX_CALCULATE_ALPHA > 0 Then
    begin
      tex_CalcTransparent(pData, TransparentColor, w, h);
      tex_CalcAlpha(pData, w, h);
    end else
      tex_CalcTransparent(pData, TransparentColor, w, h);
  end;
  Texture.Flags := Flags;
  tex_CalcFlags(Texture^, pData);
  tex_CreateGL(Texture^, pData);

  log_Add('Texture restored: "' + FileName + '"');

  FreeMem(pData);
end;

procedure tex_RestoreFromMemory(var Texture: zglPTexture; const Memory: zglTMemory; const Extension: UTF8String;
    TransparentColor: LongWord = TEX_NO_COLORKEY; Flags: LongWord = TEX_DEFAULT_2D);
  var
    i     : Integer;
    ext   : UTF8String;
    pData : PByteArray;
    w, h  : Word;
    format: Word;
    res   : zglTTextureResource;
begin
  pData  := nil;

  ext := u_StrUp(Extension);
  for i := managerTexture.Count.Formats - 1 downto 0 do
    if ext = managerTexture.Formats[i].Extension Then
      if resUseThreaded Then
      begin
        res.Memory           := Memory;
        res.Texture          := Texture;
        res.MemLoader        := managerTexture.Formats[i].MemLoader;
        res.TransparentColor := TransparentColor;
        res.Flags            := Flags;
        res_AddToQueue(RES_TEXTURE_RESTORE, FALSE, @res);
        exit;
      end else
        managerTexture.Formats[i].MemLoader(Memory, pData, w, h, format);

  if not Assigned(pData) Then
  begin
    Texture.ID := managerZeroTexture.ID;
    log_Add('Unable to restore texture: From Memory');
    exit;
  end;

  if format = TEX_FORMAT_RGBA Then
  begin
    if Flags and TEX_CALCULATE_ALPHA > 0 Then
    begin
      tex_CalcTransparent(pData, TransparentColor, w, h);
      tex_CalcAlpha(pData, w, h);
    end else
      tex_CalcTransparent(pData, TransparentColor, w, h);
  end;
  Texture.Flags := Flags;
  tex_CalcFlags(Texture^, pData);
  tex_CreateGL(Texture^, pData);

  FreeMem(pData);
end;
{$ENDIF}

procedure tex_SetFrameSize(var Texture: zglPTexture; FrameWidth, FrameHeight: Word);
var
  res: zglTTextureFrameSizeResource;
begin
  if not Assigned(Texture) Then
    exit;

  if resUseThreaded Then
  begin
    res.Texture     := Texture;
    res.FrameWidth  := FrameWidth;
    res.FrameHeight := FrameHeight;
    res_AddToQueue(RES_TEXTURE_FRAMESIZE, TRUE, @res);
  end else
    tex_CalcTexCoords(Texture^, Texture.Width div FrameWidth, Texture.Height div FrameHeight);
end;

procedure tex_SetMask(var Texture: zglPTexture; Mask: zglPTexture);
var
  i, j : Integer;
  tData: PByteArray;
  mData: PByteArray;
  rW   : Integer;
  res  : zglTTextureMaskResource;
begin
  if (not Assigned(Texture)) or (not Assigned(Mask)) Then exit;

  if resUseThreaded Then
  begin
    res.Texture := Texture;
    res.Mask    := Mask;
    res.tData   := nil;
    res.mData   := nil;
    res_AddToQueue(RES_TEXTURE_MASK, TRUE, @res);
  end else
  begin
    if (Texture.Width <> Mask.Width) or (Texture.Height <> Mask.Height) or (Texture.Format <> TEX_FORMAT_RGBA) or (Mask.Format <> TEX_FORMAT_RGBA) Then
      exit;

    rW := Round(Texture.Width / Texture.U);

    tex_GetData(Texture, tData);
    tex_GetData(Mask, mData);

    for j := 0 to Texture.Height - 1 do
    begin
      for i := 0 to rW - 1 do
        tData[i * 4 + 3] := mData[i * 4];
      INC(PByte(tData), rW * 4);
      INC(PByte(mData), rW * 4);
    end;
    DEC(PByte(tData), rW * Texture.Height * 4);
    DEC(PByte(mData), rW * Mask.Height * 4);
    tex_SetData(Texture, tData, 0, 0, rW, Texture.Height);

    FreeMem(tData);
    FreeMem(mData);
  end;
end;

procedure tex_CalcTexCoords(var Texture: zglTTexture; FramesX: Integer = 1; FramesY: Integer = 1);
var
  i, z, n, countVertex: Integer;
  tX, tY, u, v: Single;
begin
  if FramesX <= 0 Then
    FramesX := 1;
  if FramesY <= 0 Then
    FramesY := 1;

  SetLength(Texture.FramesCoord, FramesX * FramesY + 1);
  u := Texture.U / FramesX;
  v := Texture.V / FramesY;

  Texture.FramesCoord[0, 0].X := 0;
  Texture.FramesCoord[0, 0].Y := Texture.V;
  Texture.FramesCoord[0, 1].X := Texture.U;
  Texture.FramesCoord[0, 1].Y := Texture.V;
  Texture.FramesCoord[0, 2].X := Texture.U;
  Texture.FramesCoord[0, 2].Y := 0;
  Texture.FramesCoord[0, 3].X := 0;
  Texture.FramesCoord[0, 3].Y := 0;

  for i := 1 to FramesX * FramesY do
  begin
    tY := i div FramesX;
    tX := i - tY * FramesX;
    tY := FramesY - tY;
    if tX = 0 Then
    begin
      tX := FramesX;
      tY := tY + 1;
    end;
    tX := tX * u;
    tY := tY * v;

    Texture.FramesCoord[i, 0].X := tX - u;
    Texture.FramesCoord[i, 0].Y := tY;

    Texture.FramesCoord[i, 1].X := tX;
    Texture.FramesCoord[i, 1].Y := tY;

    Texture.FramesCoord[i, 2].X := tX;
    Texture.FramesCoord[i, 2].Y := tY - v;

    Texture.FramesCoord[i, 3].X := tX - u;
    Texture.FramesCoord[i, 3].Y := tY - v;
  end;
end;

procedure _tex_Filter(Texture: zglPTexture; Flags: LongWord);
var
  currentFilter: LongWord;
begin
  batch2d_Flush();

  Texture.Flags := Texture.Flags and TEXTURE_FILTER_CLEAR;

  glBindTexture(GL_TEXTURE_2D, Texture.ID);

  if Flags and TEX_CLAMP > 0 Then
  begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  end;
  if Flags and TEX_REPEAT > 0 Then
  begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  end;

  if {$IfNDef USE_GLES}GL_SGIS_generate_mipmap{$Else}oglCanAutoMipMap{$EndIf} Then
    glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP, Byte(Flags and TEX_MIPMAP > 0));

  if Flags and TEX_MIPMAP > 0 Then
  begin
    if Flags and TEX_FILTER_NEAREST > 0 Then
    begin
      Texture.Flags := Texture.Flags or TEX_FILTER_NEAREST;
      glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
      glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    end else
      if Flags and TEX_FILTER_LINEAR > 0 Then
      begin
        Texture.Flags := Texture.Flags or TEX_FILTER_LINEAR;
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
      end else
        if Flags and TEX_FILTER_BILINEAR > 0 Then
        begin
          Texture.Flags := Texture.Flags or TEX_FILTER_BILINEAR;
          glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
          glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        end else
          if (Flags and TEX_FILTER_TRILINEAR > 0) or ((not {$IfNDef USE_GLES}GL_EXT_texture_filter_anisotropic{$Else}oglCanAnisotropy{$EndIf}) and (Flags and TEX_FILTER_ANISOTROPY > 0)) Then
          begin
            Texture.Flags := Texture.Flags or TEX_FILTER_TRILINEAR;
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
          end else
            if Flags and TEX_FILTER_ANISOTROPY > 0 Then
            begin
              Texture.Flags := Texture.Flags or TEX_FILTER_ANISOTROPY;
              glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
              glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
              glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, oglAnisotropy);
            end;
  end else
  begin
    if (Flags and TEX_FILTER_NEAREST > 0) or ((Flags and TEX_FILTER_LINEAR = 0) and (Flags and TEX_FILTER_BILINEAR = 0) and
           (Flags and TEX_FILTER_TRILINEAR = 0) and (Flags and TEX_FILTER_ANISOTROPY = 0)) Then
    begin
      Texture.Flags := Texture.Flags or TEX_FILTER_NEAREST;
      glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
      glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    end else
    begin
      Texture.Flags := Texture.Flags or TEX_FILTER_LINEAR;
      glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
      glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    end;
  end;
end;

procedure tex_SetAnisotropy(Level: Byte);
begin
  if Level > oglMaxAnisotropy Then
    oglAnisotropy := oglMaxAnisotropy
  else
    oglAnisotropy := Level;
end;

procedure tex_CalcFlags(var Texture: zglTTexture; var pData: PByteArray);
begin
  if Texture.Format = TEX_FORMAT_RGBA Then
  begin
    if Texture.Flags and TEX_GRAYSCALE > 0 Then
      tex_CalcGrayScale(pData, Texture.Width, Texture.Height);
    if Texture.Flags and TEX_INVERT > 0 Then
      tex_CalcInvert(pData, Texture.Width, Texture.Height);
    if (Texture.Flags and TEX_CUSTOM_EFFECT > 0) and (Assigned(tex_CalcCustomEffect)) Then
      tex_CalcCustomEffect(pData, Texture.Width, Texture.Height);
  end;

  if Texture.Flags and TEX_CONVERT_TO_POT > 0 Then
  begin
    if Texture.Format = TEX_FORMAT_RGBA Then
      tex_CalcPOT(pData, Texture.Width, Texture.Height, Texture.U, Texture.V, 4)
    else
      if Texture.Format = TEX_FORMAT_RGBA_4444 Then
        tex_CalcPOT(pData, Texture.Width, Texture.Height, Texture.U, Texture.V, 2)
      else
        exit;

    Texture.Width  := Round(Texture.Width * Texture.U);
    Texture.Height := Round(Texture.Height * Texture.V);
  end;
end;

procedure tex_CalcPOT(var pData: PByteArray; var Width, Height: Word; var U, V: Single; PixelSize: Integer);
  var
    i, j: Integer;
    w, h: Integer;
    data: PByteArray;
begin
  w := u_GetPOT(Width);
  h := u_GetPOT(Height);
  if (w = Width) and (h = Height) Then
  begin
    U := 1;
    V := 1;
    exit;
  end;
  U := Width  / w;
  V := Height / h;

  data := pData;
  GetMem(pData, w * h * PixelSize);

  for i := 0 to Height - 1 do
    Move(data[i * Width * PixelSize], pData[i * w * PixelSize], Width * PixelSize);

  for i := Height to h - 1 do
    Move(pData[(Height - 1) * w * PixelSize], pData[i * w * PixelSize], Width * PixelSize);

  if PixelSize = 4 Then
    begin
      for i := 0 to h - 1 do
        for j := Width to w - 1 do
          PLongWordArray(pData)[j + i * w] := PLongWordArray(pData)[Width - 1 + i * w];
    end else
      for i := 0 to h - 1 do
        for j := Width to w - 1 do
          PWordArray(pData)[j + i * w] := PWordArray(pData)[Width - 1 + i * w];

  Width  := w;
  Height := h;
  FreeMem(data);
end;

procedure tex_CalcGrayScale(pData: PByteArray; Width, Height: Word);
  var
    i   : Integer;
    gray: Byte;
begin
  for i := 0 to Width * Height - 1 do
    begin
      gray       := Round(pData[0] * 0.299 + pData[1] * 0.587 + pData[2] * 0.114);
      pData[0] := gray;
      pData[1] := gray;
      pData[2] := gray;
      INC(PByte(pData), 4);
    end;
end;

procedure tex_CalcInvert(pData: PByteArray; Width, Height: Word);
var
  i: Integer;
begin
  for i := 0 to Width * Height - 1 do
  begin
    pData[0] := 255 - pData[0];
    pData[1] := 255 - pData[1];
    pData[2] := 255 - pData[2];
    INC(PByte(pData), 4);
  end;
end;

procedure tex_CalcTransparent(pData: PByteArray; TransparentColor: LongWord; Width, Height: Word);
var
  i      : Integer;
  r, g, b: Byte;
begin
  if TransparentColor = TEX_NO_COLORKEY Then
    exit;

  r := (TransparentColor and $FF0000) shr 16;
  g := (TransparentColor and $FF00  ) shr 8;
  b := (TransparentColor and $FF    );
  for i := 0 to Width * Height - 1 do
  begin
    if (pData[0] = r) and (pData[1] = g) and (pData[2] = b) Then
      pData[3] := 0;    // почему мы сюда записываем нуль? Это указание, что прозрачности нет?
    INC(PByte(pData), 4);
  end;
end;

procedure tex_CalcAlpha(pData: PByteArray; Width, Height: Word);
  var
    i: Integer;
begin
  for i := 0 to Width * Height - 1 do
    if pData[i * 4 + 3] = 0 Then
    begin
      PLongWordArray(pData)[i] := 0;

        // bottom
      if i + Width <= Width * Height - 1 Then
        if pData[(i + Width) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i + Width) * 4];
          pData[i * 4 + 1] := pData[(i + Width) * 4 + 1];
          pData[i * 4 + 2] := pData[(i + Width) * 4 + 2];
          continue;
        end;

        // bottom right
      if (i + 1 <= Width * Height - 1) and (i + Width <= Width * Height - 1) Then
        if pData[(i + Width + 1) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i + Width + 1) * 4];
          pData[i * 4 + 1] := pData[(i + Width + 1) * 4 + 1];
          pData[i * 4 + 2] := pData[(i + Width + 1) * 4 + 2];
          continue;
        end;

        // right
      if i + 1 <= Width * Height - 1 Then
        if pData[(i + 1) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i + 1) * 4];
          pData[i * 4 + 1] := pData[(i + 1) * 4 + 1];
          pData[i * 4 + 2] := pData[(i + 1) * 4 + 2];
          continue;
        end;

        // top right
      if (i + 1 <= Width * Height - 1) and (i - Width > 0) Then
        if pData[(i - Width + 1) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i - Width + 1) * 4];
          pData[i * 4 + 1] := pData[(i - Width + 1) * 4 + 1];
          pData[i * 4 + 2] := pData[(i - Width + 1) * 4 + 2];
          continue;
        end;

        // top
      if i - Width > 0 Then
        if pData[(i - Width) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i - Width) * 4];
          pData[i * 4 + 1] := pData[(i - Width) * 4 + 1];
          pData[i * 4 + 2] := pData[(i - Width) * 4 + 2];
          continue;
        end;

        // top left
      if (i - 1 > 0) and (i - Width > 0) Then
        if pData[(i - Width - 1) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i - Width - 1) * 4];
          pData[i * 4 + 1] := pData[(i - Width - 1) * 4 + 1];
          pData[i * 4 + 2] := pData[(i - Width - 1) * 4 + 2];
          continue;
        end;

        // left
      if i - 1 > 0 Then
        if pData[(i - 1) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i - 1) * 4];
          pData[i * 4 + 1] := pData[(i - 1) * 4 + 1];
          pData[i * 4 + 2] := pData[(i - 1) * 4 + 2];
          continue;
        end;

        // bottom left
      if (i - 1 > 0) and (i + Width <= Width * Height - 1) Then
        if pData[(i + Width - 1) * 4 + 3] > 0 Then
        begin
          pData[i * 4]     := pData[(i + Width - 1) * 4];
          pData[i * 4 + 1] := pData[(i + Width - 1) * 4 + 1];
          pData[i * 4 + 2] := pData[(i + Width - 1) * 4 + 2];
          continue;
        end;
    end;
end;

procedure tex_SetData(Texture: zglPTexture; pData: PByteArray; X, Y, Width, Height: Word; Stride: Integer = 0);
  {$IFDEF USE_GLES}
  var
    pDataGLES: PByteArray;
    i        : Integer;
  {$ENDIF}
begin
  batch2d_Flush();

  if (not Assigned(Texture)) or (not Assigned(pData)) Then exit;

  {$IFDEF USE_GLES}
  if Stride > Width Then
    begin
      GetMem(pDataGLES, Width * Height * 4);
      for i := 0 to Height - 1 do
        Move(pData[i * Stride * 4], pDataGLES[i * Width * 4], Width * 4);
      pData := pDataGLES;
    end else
      pDataGLES := nil;
  {$ENDIF}

  glEnable(GL_TEXTURE_2D);
  {$IFNDEF USE_GLES}
  glPixelStorei(GL_UNPACK_ROW_LENGTH, Stride);
  {$ENDIF}
  glBindTexture(GL_TEXTURE_2D, Texture.ID);
  glTexSubImage2D(GL_TEXTURE_2D, 0, X, Texture.Height - Height - Y, Width, Height, GL_RGBA, GL_UNSIGNED_BYTE, pData);
  {$IFNDEF USE_GLES}
  glPixelStorei(GL_UNPACK_ROW_LENGTH, 0);
  {$ENDIF}
  glDisable(GL_TEXTURE_2D);

  {$IFDEF USE_GLES}
  FreeMem(pDataGLES);
  {$ENDIF}
end;

procedure tex_GetData(Texture: zglPTexture; out pData: PByteArray);
begin
  batch2d_Flush();

  if not Assigned(Texture) Then
  begin
    pData := nil;
    exit;
  end;

  GetMem(pData, Round(Texture.Width / Texture.U) * Round(Texture.Height / Texture.V) * 4);

  {$IFNDEF USE_GLES}
  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, Texture.ID);
  glGetTexImage(GL_TEXTURE_2D, 0, GL_RGBA, GL_UNSIGNED_BYTE, pData);
  glDisable(GL_TEXTURE_2D);
  {$ELSE}
  if not oglCanFBO Then exit;

  if oglReadPixelsFBO = 0 Then
  begin
    glGenFramebuffers(1, @oglReadPixelsFBO);
    glGenRenderbuffers(1, @oglReadPixelsRB);
  end;
  glBindFramebuffer(GL_FRAMEBUFFER, oglReadPixelsFBO);
  glBindRenderbuffer(GL_RENDERBUFFER, oglReadPixelsRB);
  glRenderbufferStorage(GL_RENDERBUFFER, GL_RGBA, Round(Texture.Width / Texture.U), Round(Texture.Height / Texture.V));

  glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, Texture.ID, 0);

  glReadPixels(0, 0, Round(Texture.Width / Texture.U), Round(Texture.Height / Texture.V), GL_RGBA, GL_UNSIGNED_BYTE, pData);

  if oglTarget = TARGET_SCREEN Then
  begin
    {$IFNDEF iOS}
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glBindRenderbuffer(GL_RENDERBUFFER, 0);
    {$ELSE}
    glBindFramebuffer(GL_FRAMEBUFFER, eglFramebuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, eglRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, eglRenderbuffer);
    {$ENDIF}
  end else
  begin
      // TODO:
  end;
  {$ENDIF}
end;

end.
