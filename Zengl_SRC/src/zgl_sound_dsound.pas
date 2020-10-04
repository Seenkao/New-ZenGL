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
unit zgl_sound_dsound;

{$I zgl_config.cfg}

interface
uses
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  zgl_types;

const
  _FACDS                      = $878; { DirectSound's facility code }
  MAKE_DSHRESULT_R            = (1 shl 31) or (_FACDS shl 16);

  DS_OK                       = $00000000;
  DSSCL_PRIORITY              = $00000002;
  DSSCL_EXCLUSIVE             = $00000003;

  DSBCAPS_PRIMARYBUFFER       = $00000001;
  DSBCAPS_STATIC              = $00000002;
  DSBCAPS_LOCHARDWARE         = $00000004;
  DSBCAPS_LOCSOFTWARE         = $00000008;
  DSBCAPS_CTRLFREQUENCY       = $00000020;
  DSBCAPS_CTRLPAN             = $00000040;
  DSBCAPS_CTRLVOLUME          = $00000080;
  DSBCAPS_CTRLPOSITIONNOTIFY  = $00000100;
  DSBCAPS_GLOBALFOCUS         = $00008000;
  DSBCAPS_GETCURRENTPOSITION2 = $00010000;

  DSBSTATUS_PLAYING           = $00000001;
  DSBSTATUS_BUFFERLOST        = $00000002;
  DSBSTATUS_LOOPING           = $00000004;

  DSBPLAY_LOOPING             = $00000001;

  DSERR_BUFFERLOST            = MAKE_DSHRESULT_R or 150;

type
  zglTBufferDesc = record
    FormatCode      : Word;
    ChannelNumber   : Word;
    SampleRate      : LongWord;
    BytesPerSecond  : LongWord;
    BytesPerSample  : Word;
    BitsPerSample   : Word;
    cbSize          : Word;
  end;


  IDirectSoundBuffer = interface;
  IDirectSound       = interface;

  TDSBUFFERDESC = packed record
    dwSize         : LongWord;
    dwFlags        : LongWord;
    dwBufferBytes  : LongWord;
    dwReserved     : LongWord;
    lpwfxFormat    : Pointer;
    guid3DAlgorithm: TGUID;
  end;

  PDSBPositionNotify = ^TDSBPositionNotify;
  TDSBPositionNotify = packed record
    dwOffset: DWORD;
    hEventNotify: THandle;
  end;

  IDirectSound = interface (IUnknown)
    ['{279AFA83-4981-11CE-A521-0020AF0BE560}']
    function CreateSoundBuffer(const lpDSBufferDesc: TDSBufferDesc;
        out lpIDirectSoundBuffer: IDirectSoundBuffer;
        pUnkOuter: IUnknown): HResult; stdcall;
    function GetCaps(lpDSCaps: Pointer): HResult; stdcall;
    function DuplicateSoundBuffer(lpDsbOriginal: IDirectSoundBuffer;
        out lpDsbDuplicate: IDirectSoundBuffer): HResult; stdcall;
    function SetCooperativeLevel(hwnd: HWND; dwLevel: LongWord): HResult; stdcall;
    function Compact: HResult; stdcall;
    function GetSpeakerConfig(out lpdwSpeakerConfig: LongWord): HResult; stdcall;
    function SetSpeakerConfig(dwSpeakerConfig: LongWord): HResult; stdcall;
    function Initialize(lpGuid: PGUID): HResult; stdcall;
  end;

  IDirectSoundBuffer = interface (IUnknown)
    ['{279AFA85-4981-11CE-A521-0020AF0BE560}']
    function GetCaps(lpDSCaps: Pointer): HResult; stdcall;
    function GetCurrentPosition
        (lpdwPlayPosition, lpdwReadPosition: PLongWord): HResult; stdcall;
    function GetFormat(lpwfxFormat: Pointer; dwSizeAllocated: LongWord;
        lpdwSizeWritten: PLongWord): HResult; stdcall;
    function GetVolume(out lplVolume: integer): HResult; stdcall;
    function GetPan(out lplPan: integer): HResult; stdcall;
    function GetFrequency(out lpdwFrequency: LongWord): HResult; stdcall;
    function GetStatus(out lpdwStatus: LongWord): HResult; stdcall;
    function Initialize(lpDirectSound: IDirectSound;
        const lpcDSBufferDesc: TDSBufferDesc): HResult; stdcall;
    function Lock(dwWriteCursor, dwWriteBytes: LongWord;
        out lplpvAudioPtr1: Pointer; out lpdwAudioBytes1: LongWord;
        out lplpvAudioPtr2: Pointer; out lpdwAudioBytes2: LongWord;
        dwFlags: LongWord): HResult; stdcall;
    function Play(dwReserved1,dwReserved2,dwFlags: LongWord): HResult; stdcall;
    function SetCurrentPosition(dwPosition: LongWord): HResult; stdcall;
    function SetFormat(lpcfxFormat: Pointer): HResult; stdcall;
    function SetVolume(lVolume: integer): HResult; stdcall;
    function SetPan(lPan: integer): HResult; stdcall;
    function SetFrequency(dwFrequency: LongWord): HResult; stdcall;
    function Stop: HResult; stdcall;
    function Unlock(lpvAudioPtr1: Pointer; dwAudioBytes1: LongWord;
        lpvAudioPtr2: Pointer; dwAudioBytes2: LongWord): HResult; stdcall;
    function Restore: HResult; stdcall;
  end;

  IDirectSoundNotify = interface(IUnknown)
    ['{b0210783-89cd-11d0-af08-00a0c925cd16}']
    function SetNotificationPositions(dwPositionNotifies: DWORD; pcPositionNotifies: PDSBPositionNotify): HResult; stdcall;
  end;

function  InitDSound: Boolean;
procedure FreeDSound;

procedure dsu_CreateBuffer(var Buffer: IDirectSoundBuffer; BufferSize: LongWord; Format: Pointer);
procedure dsu_FillData(var Buffer: IDirectSoundBuffer; Data: PByteArray; DataSize: LongWord; Pos: LongWord = 0);
function  dsu_CalcPos(X, Y, Z: Single; out Volume: Single): Integer;
function  dsu_CalcVolume(Volume: Single): Integer;

var
  dsoundLibrary    : HMODULE;
  DirectSoundCreate: function (lpGuid: PGUID; out ppDS: IDirectSound; pUnkOuter: IUnknown): HResult; stdcall;

  dsDevice     : IDirectSound;
  dsPosition   : array[0..2] of Single;
  dsPlane      : array[0..2] of Single;
  dsOrientation: array[0..5] of Single = (0.0, 0.0, -1.0, 0.0, 1.0, 0.0);

implementation
uses
  zgl_sound,
  zgl_utils;

function CoInitialize(pvReserved: Pointer): HResult; stdcall; external 'ole32.dll' name 'CoInitialize';
procedure CoUninitialize; stdcall; external 'ole32.dll' name 'CoUninitialize';

function InitDSound: Boolean;
begin
  CoInitialize(nil);
  dsoundLibrary     := dlopen('DSound.dll');
  DirectSoundCreate := dlsym(dsoundLibrary, 'DirectSoundCreate');
  Result            := dsoundLibrary <> 0;
end;

procedure FreeDSound;
begin
  dlclose(dsoundLibrary);
  CoUninitialize();
end;

procedure dsu_CreateBuffer(var Buffer: IDirectSoundBuffer; BufferSize: LongWord; Format: Pointer);
  var
    bufferDesc: TDSBufferDesc;
begin
  FillChar(bufferDesc, SizeOf(TDSBUFFERDESC), 0);
  with bufferDesc do
    begin
      dwSize  := SizeOf(TDSBUFFERDESC);
      dwFlags := DSBCAPS_LOCSOFTWARE or DSBCAPS_CTRLPAN or DSBCAPS_CTRLVOLUME or DSBCAPS_CTRLFREQUENCY or DSBCAPS_CTRLPOSITIONNOTIFY or
                 DSBCAPS_GETCURRENTPOSITION2;
      dwBufferBytes := BufferSize;
      lpwfxFormat   := Format;
    end;

  dsDevice.CreateSoundBuffer(bufferDesc, Buffer, nil);
end;

procedure dsu_FillData(var Buffer: IDirectSoundBuffer; Data: PByteArray; DataSize: LongWord; Pos: LongWord = 0);
  var
    block1, block2: Pointer;
    b1Size, b2Size: LongWord;
begin
  Buffer.Lock(Pos, DataSize, block1, b1Size, block2, b2Size, 0);
  Move(Data^, block1^, b1Size);
  if b2Size <> 0 Then Move(Data[b1Size], block2^, b2Size);
  Buffer.Unlock(block1, b1Size, block2, b2Size);
end;

function dsu_CalcPos(X, Y, Z: Single; out Volume: Single): Integer;
  var
    dist, angle: Single;
begin
  dsPlane[0] := dsOrientation[1] * dsOrientation[5] - dsOrientation[2] * dsOrientation[4];
  dsPlane[1] := dsOrientation[2] * dsOrientation[3] - dsOrientation[0] * dsOrientation[5];
  dsPlane[2] := dsOrientation[0] * dsOrientation[4] - dsOrientation[1] * dsOrientation[3];

  dist := sqrt(sqr(X - dsPosition[0]) + sqr(Y - dsPosition[1]) + sqr(Z - dsPosition[2]));
  if dist = 0 then
    angle := 0
  else
    angle := (dsPlane[0] * (X - dsPosition[0]) + dsPlane[1] * (Y - dsPosition[1]) + dsPlane[2] * (Z - dsPosition[2])) * dist;
  Result := Trunc(10000 * angle);
  if Result < -10000 Then Result := -10000;
  if Result > 10000  Then Result := 10000;

  Volume := 1 - dist / 100;
  if Volume < 0 Then Volume := 0;
end;

function dsu_CalcVolume(Volume: Single): Integer;
begin
  if Volume = 0 Then
    Result := -10000
  else
    Result := - Round(1000 * ln(1 / Volume));
end;

end.
