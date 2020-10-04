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
unit zgl_textures_pvr;

{$I zgl_config.cfg}

interface

uses
  zgl_types,
  zgl_memory;

const
  PVR_EXTENSION: UTF8String = 'PVR';

procedure pvr_LoadFromFile(const FileName: UTF8String; out Data: PByteArray; out W, H, Format: Word);
procedure pvr_LoadFromMemory(const Memory: zglTMemory; out Data: PByteArray; out W, H, Format: Word);

implementation
uses
  CFByteOrders,
  zgl_main,
  zgl_file,
  zgl_textures;

const
  PVR_RGBA_4444 = $10;
  PVR_RGBA_5551 = $11;
  PVR_RGBA_8888 = $12;
  PVR_RGB_565   = $13;
  PVR_RGB_555   = $14;
  PVR_RGB_888   = $15;
  PVR_I_8       = $16;
  PVR_AI_88     = $17;
  PVR_PVRTC2    = $18;
  PVR_PVRTC4    = $19;

type
  zglTPVRHeader = record
    HeaderLength: LongWord;
    Height      : LongWord;
    Width       : LongWord;
    NumMipmaps  : LongWord;
    Flags       : LongWord;
    DataLength  : LongWord;
    BPP         : LongWord;
    BitmaskRed  : LongWord;
    BitmaskGreen: LongWord;
    BitmaskBlue : LongWord;
    BitmaskAlpha: LongWord;
    PVRTag      : LongWord;
    NumSurfs    : LongWord;
  end;

procedure pvr_LoadFromFile(const FileName: UTF8String; out Data: PByteArray; out W, H, Format: Word);
  var
    pvrMem: zglTMemory;
begin
  mem_LoadFromFile(pvrMem, FileName);
  pvr_LoadFromMemory(pvrMem, Data, W, H, Format);
  mem_Free(pvrMem);
end;

procedure pvr_LoadFromMemory(const Memory: zglTMemory; out Data: PByteArray; out W, H, Format: Word);
  var
    pvrMem   : zglTMemory;
    pvrHeader: zglTPVRHeader;
    size     : LongWord;
    flags    : LongWord;
begin
  pvrMem := Memory;
  mem_Read(pvrMem, pvrHeader, SizeOf(zglTPVRHeader));
  W     := CFSwapInt32LittleToHost(pvrHeader.Width);
  H     := CFSwapInt32LittleToHost(pvrHeader.Height);
  size  := CFSwapInt32LittleToHost(pvrHeader.DataLength);
  flags := CFSwapInt32LittleToHost(pvrHeader.Flags) and $FF;
  case flags of
    PVR_RGBA_4444: Format := TEX_FORMAT_RGBA_4444;
    PVR_RGBA_8888: Format := TEX_FORMAT_RGBA;
    PVR_PVRTC2: Format := TEX_FORMAT_RGBA_PVR2;
    PVR_PVRTC4: Format := TEX_FORMAT_RGBA_PVR4;
  else
    Data := nil;
    exit;
  end;

  GetMem(Data, size);
  Move(PByteArray(pvrMem.Memory)[pvrMem.Position], Data[0], size);
end;

{$IFDEF USE_PVR}
initialization
  zgl_Reg(TEXTURE_FORMAT_EXTENSION,   @PVR_EXTENSION[1]);
  zgl_Reg(TEXTURE_FORMAT_FILE_LOADER, @pvr_LoadFromFile);
  zgl_Reg(TEXTURE_FORMAT_MEM_LOADER,  @pvr_LoadFromMemory);
{$ENDIF}

end.
