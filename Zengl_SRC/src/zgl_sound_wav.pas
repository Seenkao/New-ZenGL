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
unit zgl_sound_wav;

{$I zgl_config.cfg}

interface

uses
  zgl_types,
  zgl_memory;

const
  WAV_EXTENSION: UTF8String = 'WAV';

procedure wav_LoadFromFile(const FileName: UTF8String; out Data: PByteArray; out Size, Format, Frequency: LongWord);
procedure wav_LoadFromMemory(const Memory: zglTMemory; out Data: PByteArray; out Size, Format, Frequency: LongWord);

implementation
uses
  zgl_window,
  zgl_file,
  zgl_sound,
  zgl_log;

const
  WAV_STANDARD  = $0001;
  WAV_IMA_ADPCM = $0011;
  WAV_MP3       = $0055;

type
  zglTWAVHeader = record
    RIFFHeader      : array[1..4] of AnsiChar;
    FileSize        : Integer;
    WAVEHeader      : array[1..4] of AnsiChar;
    FormatHeader    : array[1..4] of AnsiChar;
    FormatHeaderSize: Integer;
    FormatCode      : Word;
    ChannelNumber   : Word;
    SampleRate      : LongWord;
    BytesPerSecond  : LongWord;
    BytesPerSample  : Word;
    BitsPerSample   : Word;
 end;

procedure wav_LoadFromFile(const FileName: UTF8String; out Data: PByteArray; out Size, Format, Frequency: LongWord);
  var
    wavMemory: zglTMemory;
begin
  mem_LoadFromFile(wavMemory, FileName);
  wav_LoadFromMemory(wavMemory, Data, Size, Format, Frequency);
  mem_Free(wavMemory);
end;

procedure wav_LoadFromMemory(const Memory: zglTMemory; out Data: PByteArray; out Size, Format, Frequency: LongWord);
  var
    wavMemory: zglTMemory;
    wavHeader: zglTWAVHeader;
    chunkName: array[0..3] of AnsiChar;
    skip     : Integer;
begin
  wavMemory := Memory;
  mem_Read(wavMemory, wavHeader, SizeOf(zglTWAVHeader));

  Frequency := wavHeader.SampleRate;

  if wavHeader.ChannelNumber = 1 Then
    case WavHeader.BitsPerSample of
      8:  format := SND_FORMAT_MONO8;
      16: format := SND_FORMAT_MONO16;
    end;

  if WavHeader.ChannelNumber = 2 then
    case WavHeader.BitsPerSample of
      8:  format := SND_FORMAT_STEREO8;
      16: format := SND_FORMAT_STEREO16;
    end;

  mem_Seek(wavMemory, (8 - 44) + 12 + 4 + wavHeader.FormatHeaderSize + 4, FSM_CUR);
  repeat
    mem_Read(wavMemory, chunkName, 4);
    if chunkName = 'data' then
    begin
      mem_Read(wavMemory, Size, 4);

      zgl_GetMem(Pointer(Data), Size);
      mem_Read(wavMemory, Data[0], Size);

      if wavHeader.FormatCode = WAV_IMA_ADPCM Then log_Add('Unsupported wav format - IMA ADPCM');
      if wavHeader.FormatCode = WAV_MP3 Then       log_Add('Unsupported wav format - MP3');
      wavHeader.FormatCode := WAV_STANDARD; // just for case, because some wav-encoders write here garbage...
    end else
    begin
      mem_Read(wavMemory, skip, 4);
      mem_Seek(wavMemory, skip, FSM_CUR);
    end;
  until wavMemory.Position >= wavMemory.Size;
end;

{$IFDEF USE_WAV}
initialization
  zgl_Reg(SND_FORMAT_EXTENSION,   @WAV_EXTENSION[1]);
  zgl_Reg(SND_FORMAT_FILE_LOADER, @wav_LoadFromFile);
  zgl_Reg(SND_FORMAT_MEM_LOADER,  @wav_LoadFromMemory);
{$ENDIF}

end.
