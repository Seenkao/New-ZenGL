unit gegl_xrandr;

// для Unix с поддержкой Xrandr.


// данный модуль может содержать ошибки!!!
interface

uses
  x, xlib, ctypes, xrender;

const
  libXrandr = 'Xrandr';
  RANDR_NAME                     = 'RANDR';
  RANDR_MAJOR                    = 1;
  RANDR_MINOR                    = 6;

  RRNumberErrors                 = 5;
  RRNumberEvents                 = 2;
  RRNumberRequests               = 47;

  X_RRQueryVersion               = 0;
{ we skip 1 to make old clients fail pretty immediately }
  X_RROldGetScreenInfo           = 1;
  X_RR1_0SetScreenConfig         = 2;
{ V1.0 apps share the same set screen config request id }
  X_RRSetScreenConfig            = 2;
  X_RROldScreenChangeSelectInput = 3;
{ 3 used to be ScreenChangeSelectInput; deprecated }
  X_RRSelectInput                = 4;
  X_RRGetScreenInfo              = 5;

  (* V1.2 additions *)
  X_RRGetScreenSizeRange	 = 6;
  X_RRSetScreenSize	         = 7;
  X_RRGetScreenResources	 = 8;
  X_RRGetOutputInfo	         = 9;
  X_RRListOutputProperties       = 10;
  X_RRQueryOutputProperty	 = 11;
  X_RRConfigureOutputProperty    = 12;
  X_RRChangeOutputProperty       = 13;
  X_RRDeleteOutputProperty       = 14;
  X_RRGetOutputProperty	         = 15;
  X_RRCreateMode		 = 16;
  X_RRDestroyMode		 = 17;
  X_RRAddOutputMode	         = 18;
  X_RRDeleteOutputMode	         = 19;
  X_RRGetCrtcInfo		 = 20;
  X_RRSetCrtcConfig	         = 21;
  X_RRGetCrtcGammaSize	         = 22;
  X_RRGetCrtcGamma	         = 23;
  X_RRSetCrtcGamma	         = 24;

(* V1.3 additions *)
  X_RRGetScreenResourcesCurrent  = 25;
  X_RRSetCrtcTransform	         = 26;
  X_RRGetCrtcTransform	         = 27;
  X_RRGetPanning		 = 28;
  X_RRSetPanning		 = 29;
  X_RRSetOutputPrimary	         = 30;
  X_RRGetOutputPrimary	         = 31;

  RRTransformUnit		 = 1 shl 0;
  RRTransformScaleUp	         = 1 shl 1;
  RRTransformScaleDown	         = 1 shl 2;
  RRTransformProjective	         = 1 shl 3;

(* v1.4 *)
  X_RRGetProviders	         = 32;
  X_RRGetProviderInfo	         = 33;
  X_RRSetProviderOffloadSink     = 34;
  X_RRSetProviderOutputSource    = 35;
  X_RRListProviderProperties     = 36;
  X_RRQueryProviderProperty      = 37;
  X_RRConfigureProviderProperty  = 38;
  X_RRChangeProviderProperty     = 39;
  X_RRDeleteProviderProperty     = 40;
  X_RRGetProviderProperty	 = 41;

(* v1.5 *)
  X_RRGetMonitors		 = 42;
  X_RRSetMonitor		 = 43;
  X_RRDeleteMonitor	         = 44;

(* v1.6 *)
  X_RRCreateLease		 = 45;
  X_RRFreeLease		         = 46;

(* Event selection bits *)
  RRScreenChangeNotifyMask       = 1 shl 0;
(* V1.2 additions *)
  RRCrtcChangeNotifyMask	 = 1 shl 1;
  RROutputChangeNotifyMask       = 1 shl 2;
  RROutputPropertyNotifyMask     = 1 shl 3;
(* V1.4 additions *)
  RRProviderChangeNotifyMask     = 1 shl 4;
  RRProviderPropertyNotifyMask   = 1 shl 5;
  RRResourceChangeNotifyMask     = 1 shl 6;
(* V1.6 additions *)
  RRLeaseNotifyMask              = 1 shl 7;

(* Event codes *)
  RRScreenChangeNotify           = 0;
(* V1.2 additions *)
  RRNotify		         = 1;
(* RRNotify Subcodes *)
   RRNotify_CrtcChange	         = 0;
   RRNotify_OutputChange	 = 1;
   RRNotify_OutputProperty       = 2;
   RRNotify_ProviderChange       = 3;
   RRNotify_ProviderProperty     = 4;
   RRNotify_ResourceChange       = 5;
(* V1.6 additions *)
   RRNotify_Lease                = 6;
(* used in the rotation field; rotation and reflection in 0.1 proto. *)
  RR_Rotate_0                    = 1;
  RR_Rotate_90                   = 2;
  RR_Rotate_180                  = 4;
  RR_Rotate_270                  = 8;

(* new in 1.0 protocol, to allow reflection of screen *)
  RR_Reflect_X                   = 16;
  RR_Reflect_Y                   = 32;

  RRSetConfigSuccess             = 0;
  RRSetConfigInvalidConfigTime	 = 1;
  RRSetConfigInvalidTime	 = 2;
  RRSetConfigFailed		 = 3;

(* new in 1.2 protocol *)

  RR_HSyncPositive               = $00000001;
  RR_HSyncNegative               = $00000002;
  RR_VSyncPositive               = $00000004;
  RR_VSyncNegative               = $00000008;
  RR_Interlace                   = $00000010;
  RR_DoubleScan                  = $00000020;
  RR_CSync                       = $00000040;
  RR_CSyncPositive               = $00000080;
  RR_CSyncNegative               = $00000100;
  RR_HSkewPresent                = $00000200;
  RR_BCast                       = $00000400;
  RR_PixelMultiplex              = $00000800;
  RR_DoubleClock                 = $00001000;
  RR_ClockDivideBy2              = $00002000;

  RR_Connected                   = 0;
  RR_Disconnected                = 1;
  RR_UnknownConnection           = 2;

  BadRROutput                    = 0;
  BadRRCrtc                      = 1;
  BadRRMode                      = 2;
  BadRRProvider                  = 3;
  BadRRLease                     = 4;

(* Conventional RandR output properties *)

  RR_PROPERTY_BACKLIGHT          = 'Backlight';
  RR_PROPERTY_RANDR_EDID         = 'EDID';
  RR_PROPERTY_SIGNAL_FORMAT      = 'SignalFormat';
  RR_PROPERTY_SIGNAL_PROPERTIES  = 'SignalProperties';
  RR_PROPERTY_CONNECTOR_TYPE     = 'ConnectorType';
  RR_PROPERTY_CONNECTOR_NUMBER   = 'ConnectorNumber';
  RR_PROPERTY_COMPATIBILITY_LIST = 'CompatibilityList';
  RR_PROPERTY_CLONE_LIST         = 'CloneList';
  RR_PROPERTY_BORDER             = 'Border"';
  RR_PROPERTY_BORDER_DIMENSIONS  = 'BorderDimensions';
  RR_PROPERTY_GUID               = 'GUID';
  RR_PROPERTY_RANDR_TILE         = 'TILE';
  RR_PROPERTY_NON_DESKTOP        = 'non-desktop';

(* roles this device can carry out *)
  RR_Capability_None             = 0;
  RR_Capability_SourceOutput     = 1;
  RR_Capability_SinkOutput       = 2;
  RR_Capability_SourceOffload    = 4;
  RR_Capability_SinkOffload      = 8;


type
  PRotation      = ^TRotation;
  TRotation      = cushort;
  TConnection    = cushort;
  PSizeID        = ^TSizeID;
  TSizeID        = cushort;
  PSubpixelOrder = ^TSubpixelOrder;
  TSubpixelOrder = cushort;

  PAtom = ^TAtom;
  pbyte = ^byte;
  PChar = ^char;
  PDisplay = ^TDisplay;
  Pdword = ^dword;
  Plongint = ^longint;
  PRROutput = ^RROutput;
  RROutput = TXID;
  PRRCrtc = ^RRCrtc;
  RRCrtc = TXID;
  PRRMode = ^RRMode;
  RRMode = TXID;
  PRRProvider = ^RRProvider;
  RRProvider = TXID;
  Psmallint = ^smallint;
  PTime = ^TTime;
  PXEvent = ^TXEvent;
  PXFixed = ^XFixed;
  XFixed = LongInt;

  PXTransform = ^TXTransform;
(* взято из нового Xrender, из файла Xrender.h
  typedef struct _XTransform {
    XFixed matrix[3][3];
} XTransform;    *)
  TXTransform = record
    matrix: array[0..2] of array[0..2] of XFixed;
  end;


{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  {
   * Copyright © 2000 Compaq Computer Corporation, Inc.
   * Copyright © 2002 Hewlett-Packard Company, Inc.
   * Copyright © 2006 Intel Corporation
   * Copyright © 2008 Red Hat, Inc.
   *
   * Permission to use, copy, modify, distribute, and sell this software and its
   * documentation for any purpose is hereby granted without fee, provided that
   * the above copyright notice appear in all copies and that both that copyright
   * notice and this permission notice appear in supporting documentation, and
   * that the name of the copyright holders not be used in advertising or
   * publicity pertaining to distribution of the software without specific,
   * written prior permission.  The copyright holders make no representations
   * about the suitability of this software for any purpose.  It is provided "as
   * is" without express or implied warranty.
   *
   * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
   * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
   * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
   * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
   * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
   * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
   * OF THIS SOFTWARE.
   *
   * Author:  Jim Gettys, HP Labs, Hewlett-Packard, Inc.
   *      Keith Packard, Intel Corporation
    }

{.$include <X11/extensions/randr.h>}
{.$include <X11/extensions/Xrender.h>}
{.$include <X11/Xfuncproto.h>}


type
  PXRRScreenSize = ^TXRRScreenSize;
  TXRRScreenSize = record
    Width: longint;
    Height: longint;
    mwidth: longint;
    mheight: longint;
  end;

    {*  Events. }

  TXRRScreenChangeNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool ;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    root: TWindow;                            { Root window for changed screen  }
    timestamp: TTime;                         { when the screen change occurred  }
    config_timestamp: TTime;                  { when the last configuration change  }
    size_index: TSizeID;
    subpixel_order: TSubpixelOrder;
    rotation: TRotation;
    Width: longint;
    Height: longint;
    mwidth: longint;
    mheight: longint;
  end;

  TXRRNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_ subtype  }
  end;

  TXRROutputChangeNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_OutputChange  }
    output: RROutput;                        { affected output  }
    crtc: RRCrtc;                            { current crtc (or None)  }
    mode: RRMode;                            { current mode (or None)  }
    rotation: TRotation;                     { current rotation of associated crtc  }
    connection: TConnection;                  { current connection status  }
    subpixel_order: TSubpixelOrder;
  end;

  TXRRCrtcChangeNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_CrtcChange  }
    crtc: RRCrtc;                            { current crtc (or None)  }
    mode: RRMode;                            { current mode (or None)  }
    rotation: TRotation;                     { current rotation of associated crtc  }
    x: longint;                              { position  }
    y: longint;
    Width: dword;                            { size  }
    Height: dword;
  end;

  TXRROutputPropertyNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_OutputProperty  }
    output: RROutput;                        { related output  }
    _property: TAtom;                        { changed property  }
    timestamp: TTime;                         { time of change  }
    state: longint;                          { NewValue, Deleted  }
  end;

  TXRRProviderChangeNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_ProviderChange  }
    provider: RRProvider;                    { current provider (or None)  }
    timestamp: TTime;                         { time of change  }
    current_role: dword;
  end;

  TXRRProviderPropertyNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_ProviderProperty  }
    provider: RRProvider;                    { related provider  }
    _property: TAtom;                        { changed property  }
    timestamp: TTime;                         { time of change  }
    state: longint;                          { NewValue, Deleted  }
  end;

  TXRRResourceChangeNotifyEvent = record
    _type: longint;                          { event base  }
    serial: dword;                           { # of last request processed by server  }
    send_event: TBool;                        { true if this came from a SendEvent request  }
    display: PDisplay;                       { Display the event was read from  }
    window: TWindow;                          { window which selected for this event  }
    subtype: longint;                        { RRNotify_ResourceChange  }
    timestamp: TTime;                         { time of change  }
  end;

  { internal representation is private to the library  }
//  _XRRScreenConfiguration = XRRScreenConfiguration;
  PXRRScreenConfiguration = ^TXRRScreenConfiguration;
  TXRRScreenConfiguration = record end;



function XRRQueryExtension(dpy: PDisplay; event_base_return: Plongint; error_base_return: Plongint): TBoolResult; cdecl; external libXrandr;
function XRRQueryVersion(dpy: PDisplay; major_version_return: Plongint; minor_version_return: Plongint): TStatus; cdecl; external libXrandr;
function XRRGetScreenInfo(dpy: PDisplay; window: TWindow): PXRRScreenConfiguration; cdecl; external libXrandr;
procedure XRRFreeScreenConfigInfo(config: PXRRScreenConfiguration); cdecl; external libXrandr;

    {
     * Note that screen configuration changes are only permitted if the client can
     * prove it has up to date configuration information.  We are trying to
     * insist that it become possible for screens to change dynamically, so
     * we want to ensure the client knows what it is talking about when requesting
     * changes.

      Обратите внимание, что изменения конфигурации экрана разрешены только в том
      случае, если клиент может доказать, что у него есть обновленная информация о
      конфигурации. Мы пытаемся настоять на том, чтобы экраны могли изменяться
      динамически, поэтому мы хотим, чтобы клиент знал, о чем он говорит, запрашивая
      изменения.
      }
function XRRSetScreenConfig(dpy: PDisplay; config: PXRRScreenConfiguration;
  draw: TDrawable; size_index: longint; rotation: TRotation; timestamp: TTime): TStatus; cdecl; external libXrandr;

{ added in v1.1, sorry for the lame name  }
function XRRSetScreenConfigAndRate(dpy: PDisplay; config: PXRRScreenConfiguration;
  draw: TDrawable; size_index: longint; rotation: TRotation; rate: smallint; timestamp: TTime): TStatus; cdecl; external libXrandr;
function XRRConfigRotations(config: PXRRScreenConfiguration;current_rotation: PRotation): TRotation; cdecl; external libXrandr;
function XRRConfigTimes(config: PXRRScreenConfiguration; config_timestamp: PTime): TTime; cdecl; external libXrandr;
function XRRConfigSizes(config: PXRRScreenConfiguration; nsizes: Plongint): PXRRScreenSize; cdecl; external libXrandr;
function XRRConfigRates(config: PXRRScreenConfiguration; TsizeID: longint; nrates: Plongint): Psmallint; cdecl; external libXrandr;
function XRRConfigCurrentConfiguration(config: PXRRScreenConfiguration; rotation: PRotation): TSizeID; cdecl; external libXrandr;
function XRRConfigCurrentRate(config: PXRRScreenConfiguration): smallint; cdecl; external libXrandr;
function XRRRootToScreen(dpy: PDisplay; root: TWindow): longint; cdecl; external libXrandr;

    {
     * returns the screen configuration for the specified screen; does a lazy
     * evaluation to delay getting the information, and caches the result.
     * These routines should be used in preference to XRRGetScreenInfo
     * to avoid unneeded round trips to the X server.  These are new
     * in protocol version 0.1.

      возвращает конфигурацию экрана для указанного экрана; выполняет ленивую
      оценку, чтобы задержать получение информации, и кэширует результат. Эти
      процедуры следует использовать вместо XRRGetScreenInfo, чтобы избежать
      ненужных обращений к X-серверу. Это новые возможности протокола версии 0.1.
      }
procedure XRRSelectInput(dpy: PDisplay; window: TWindow; mask: longint); cdecl; external libXrandr;

    {
     * the following are always safe to call, even if RandR is not implemented
     * on a screen

      всегда безопасно вызывать следующие действия, даже если RandR не реализован на
      экране
      }
function XRRRotations(dpy: PDisplay; screen: longint; current_rotation: PRotation): TRotation; cdecl; external libXrandr;
function XRRSizes(dpy: PDisplay; screen: longint; nsizes: Plongint): PXRRScreenSize; cdecl; external libXrandr;
function XRRRates(dpy: PDisplay; screen: longint; TsizeID: longint; nrates: Plongint): Psmallint; cdecl; external libXrandr;
function XRRTimes(dpy: PDisplay; screen: longint; config_timestamp: PTime): TTime; cdecl; external libXrandr;

{ Version 1.2 additions  }
function XRRGetScreenSizeRange(dpy: PDisplay; window: TWindow;
  minWidth: Plongint; minHeight: Plongint; maxWidth: Plongint; maxHeight: Plongint): TStatus; cdecl; external libXrandr;
procedure XRRSetScreenSize(dpy: PDisplay; window: TWindow; Width: longint; Height: longint; mmWidth: longint; mmHeight: longint); cdecl; external libXrandr;

type
  TXRRModeFlags = dword;

  PXRRModeInfo = ^TXRRModeInfo;
  TXRRModeInfo = record
    id: RRMode;
    Width: dword;
    Height: dword;
    dotClock: dword;
    hSyncStart: dword;
    hSyncEnd: dword;
    hTotal: dword;
    hSkew: dword;
    vSyncStart: dword;
    vSyncEnd: dword;
    vTotal: dword;
    Name: Pchar;
    nameLength: dword;
    modeFlags: TXRRModeFlags;
  end;
//  XRRModeInfo = _XRRModeInfo;

  PXRRScreenResources = ^TXRRScreenResources;
  TXRRScreenResources = record
    timestamp: TTime;
    configTimestamp: TTime;
    ncrtc: longint;
    crtcs: PRRCrtc;
    noutput: longint;
    outputs: PRROutput;
    nmode: longint;
    modes: PXRRModeInfo;
  end;
//  XRRScreenResources = _XRRScreenResources;

function XRRGetScreenResources(dpy: PDisplay; window: TWindow): PXRRScreenResources; cdecl; external libXrandr;
procedure XRRFreeScreenResources(resources: PXRRScreenResources); cdecl; external libXrandr;

type
  PXRROutputInfo = ^TXRROutputInfo;
  TXRROutputInfo = record
    timestamp: TTime;
    crtc: RRCrtc;
    Name: Pchar;
    nameLen: longint;
    mm_width: dword;
    mm_height: dword;
    connection: TConnection;
    subpixel_order: TSubpixelOrder;
    ncrtc: longint;
    crtcs: PRRCrtc;
    nclone: longint;
    clones: PRROutput;
    nmode: longint;
    npreferred: longint;
    modes: PRRMode;
  end;
//  XRROutputInfo = _XRROutputInfo;

function XRRGetOutputInfo(dpy: PDisplay; resources: PXRRScreenResources; output: RROutput): PXRROutputInfo; cdecl; external libXrandr;
procedure XRRFreeOutputInfo(outputInfo: PXRROutputInfo); cdecl; external libXrandr;
function XRRListOutputProperties(dpy: PDisplay; output: RROutput; nprop: Plongint): PAtom; cdecl; external libXrandr;

type
  PXRRPropertyInfo = ^TXRRPropertyInfo;
  TXRRPropertyInfo = record
    pending: TBool;
    range: TBool;
    immutable: TBool;
    num_values: longint;
    values: Plongint;
  end;

function XRRQueryOutputProperty(dpy: PDisplay; output: RROutput; _property: TAtom): PXRRPropertyInfo; cdecl; external libXrandr;

procedure XRRConfigureOutputProperty(dpy: PDisplay; output: RROutput;
  _property: TAtom; pending: TBool; range: TBool; num_values: longint; values: Plongint); cdecl; external libXrandr;
procedure XRRChangeOutputProperty(dpy: PDisplay; output: RROutput; _property: TAtom; _type: TAtom; format: longint;
  mode: longint; Data: pbyte {_Xconst } {PChar}; nelements: longint); cdecl; external libXrandr;
procedure XRRDeleteOutputProperty(dpy: PDisplay; output: RROutput; _property: TAtom); cdecl; external libXrandr;
function XRRGetOutputProperty(dpy: PDisplay; output: RROutput; _property: TAtom; offset: longint; length: longint; _delete: TBool;
  pending: TBool; req_type: TAtom; actual_type: PAtom; actual_format: Plongint; nitems: Pdword; bytes_after: Pdword; prop: PPbyte {PPChar}): longint; cdecl; external libXrandr;
function XRRAllocModeInfo(Name: PChar {_Xconst }; nameLength: longint): PXRRModeInfo; cdecl; external libXrandr;
function XRRCreateMode(dpy: PDisplay; window: TWindow; modeInfo: PXRRModeInfo): RRMode; cdecl; external libXrandr;
procedure XRRDestroyMode(dpy: PDisplay; mode: RRMode); cdecl; external libXrandr;
procedure XRRAddOutputMode(dpy: PDisplay; output: RROutput; mode: RRMode); cdecl; external libXrandr;
procedure XRRDeleteOutputMode(dpy: PDisplay; output: RROutput; mode: RRMode); cdecl; external libXrandr;
procedure XRRFreeModeInfo(modeInfo: PXRRModeInfo); cdecl; external libXrandr;

type
  PXRRCrtcInfo = ^TXRRCrtcInfo;
  TXRRCrtcInfo = record
    timestamp: TTime;
    x: longint;
    y: longint;
    Width: dword;
    Height: dword;
    mode: RRMode;
    rotation: TRotation;
    noutput: longint;
    outputs: PRROutput;
    rotations: TRotation;
    npossible: longint;
    possible: PRROutput;
  end;
//  XRRCrtcInfo = _XRRCrtcInfo;

function XRRGetCrtcInfo(dpy: PDisplay; resources: PXRRScreenResources; crtc: RRCrtc): PXRRCrtcInfo; cdecl; external libXrandr;
procedure XRRFreeCrtcInfo(crtcInfo: PXRRCrtcInfo); cdecl; external libXrandr;
function XRRSetCrtcConfig(dpy: PDisplay; resources: PXRRScreenResources;
  crtc: RRCrtc; timestamp: TTime; x: longint; y: longint; mode: RRMode; rotation: TRotation; outputs: PRROutput; noutputs: longint): TStatus; cdecl; external libXrandr;
function XRRGetCrtcGammaSize(dpy: PDisplay; crtc: RRCrtc): longint; cdecl; external libXrandr;

type
  PXRRCrtcGamma = ^TXRRCrtcGamma;
  TXRRCrtcGamma = record
    size: longint;
    red: Pword;
    green: Pword;
    blue: Pword;
  end;
//  XRRCrtcGamma = _XRRCrtcGamma;

function XRRGetCrtcGamma(dpy: PDisplay; crtc: RRCrtc): PXRRCrtcGamma; cdecl; external libXrandr;
function XRRAllocGamma(size: longint): PXRRCrtcGamma; cdecl; external libXrandr;
procedure XRRSetCrtcGamma(dpy: PDisplay; crtc: RRCrtc; gamma: PXRRCrtcGamma); cdecl; external libXrandr;
procedure XRRFreeGamma(gamma: PXRRCrtcGamma); cdecl; external libXrandr;

{ Version 1.3 additions  }
function XRRGetScreenResourcesCurrent(dpy: PDisplay; window: TWindow): PXRRScreenResources; cdecl; external libXrandr;
procedure XRRSetCrtcTransform(dpy: PDisplay; crtc: RRCrtc; transform: PXTransform; filter: PChar{_Xconst }; params: PXFixed; nparams: longint); cdecl; external libXrandr;

type
  PPXRRCrtcTransformAttributes = ^PXRRCrtcTransformAttributes;
  PXRRCrtcTransformAttributes = ^TXRRCrtcTransformAttributes;
  TXRRCrtcTransformAttributes = record
    pendingTransform: TXTransform;
    pendingFilter: Pchar;
    pendingNparams: longint;
    pendingParams: PXFixed;
    currentTransform: TXTransform;
    currentFilter: Pchar;
    currentNparams: longint;
    currentParams: PXFixed;
  end;
//  XRRCrtcTransformAttributes = _XRRCrtcTransformAttributes;

    {
     * Get current crtc transforms and filters.
     * Pass *attributes to XFree to free
      }

function XRRGetCrtcTransform(dpy: PDisplay; crtc: RRCrtc; attributes: PPXRRCrtcTransformAttributes): TStatus; cdecl; external libXrandr;

    {
     * intended to take RRScreenChangeNotify,  or
     * ConfigureNotify (on the root window)
     * returns 1 if it is an event type it understands, 0 if not

      предназначенный для получения RRScreenChangeNotify или ConfigurationNotify (в
      корневом окне), возвращает 1, если это тип события, который он понимает, и 0,
      если нет
      }
function XRRUpdateConfiguration(event: PXEvent): longint; cdecl; external libXrandr;

type
  PXRRPanning = ^TXRRPanning;
  TXRRPanning = record
    timestamp: TTime;
    left: dword;
    top: dword;
    Width: dword;
    Height: dword;
    track_left: dword;
    track_top: dword;
    track_width: dword;
    track_height: dword;
    border_left: longint;
    border_top: longint;
    border_right: longint;
    border_bottom: longint;
  end;
//  XRRPanning = _XRRPanning;

function XRRGetPanning(dpy: PDisplay; resources: PXRRScreenResources; crtc: RRCrtc): PXRRPanning; cdecl; external libXrandr;
procedure XRRFreePanning(panning: PXRRPanning); cdecl; external libXrandr;
function XRRSetPanning(dpy: PDisplay; resources: PXRRScreenResources; crtc: RRCrtc; panning: PXRRPanning): TStatus; cdecl; external libXrandr;
procedure XRRSetOutputPrimary(dpy: PDisplay; window: TWindow; output: RROutput); cdecl; external libXrandr;
function XRRGetOutputPrimary(dpy: PDisplay; window: TWindow): RROutput; cdecl; external libXrandr;

type
  PXRRProviderResources = ^TXRRProviderResources;
  TXRRProviderResources = record
    timestamp: TTime;
    nproviders: longint;
    providers: PRRProvider;
  end;
//  XRRProviderResources = _XRRProviderResources;

function XRRGetProviderResources(dpy: PDisplay; window: TWindow): PXRRProviderResources; cdecl; external libXrandr;
procedure XRRFreeProviderResources(resources: PXRRProviderResources); cdecl; external libXrandr;

type
  PXRRProviderInfo = ^TXRRProviderInfo;
  TXRRProviderInfo = record
    capabilities: dword;
    ncrtcs: longint;
    crtcs: PRRCrtc;
    noutputs: longint;
    outputs: PRROutput;
    Name: Pchar;
    nassociatedproviders: longint;
    associated_providers: PRRProvider;
    associated_capability: Pdword;
    nameLen: longint;
  end;
//  XRRProviderInfo = _XRRProviderInfo;

function XRRGetProviderInfo(dpy: PDisplay; resources: PXRRScreenResources; provider: RRProvider): PXRRProviderInfo; cdecl; external libXrandr;
procedure XRRFreeProviderInfo(provider: PXRRProviderInfo); cdecl; external libXrandr;
function XRRSetProviderOutputSource(dpy: PDisplay; provider: TXID; source_provider: TXID): longint; cdecl; external libXrandr;
function XRRSetProviderOffloadSink(dpy: PDisplay; provider: TXID; sink_provider: TXID): longint; cdecl; external libXrandr;
function XRRListProviderProperties(dpy: PDisplay; provider: RRProvider; nprop: Plongint): PAtom; cdecl; external libXrandr;
function XRRQueryProviderProperty(dpy: PDisplay; provider: RRProvider; _property: TAtom): PXRRPropertyInfo; cdecl; external libXrandr;
procedure XRRConfigureProviderProperty(dpy: PDisplay; provider: RRProvider; _property: tAtom; pending: TBool; range: TBool; num_values: longint; values: Plongint); cdecl; external libXrandr;
procedure XRRChangeProviderProperty(dpy: PDisplay; provider: RRProvider; _property: TAtom; _type: TAtom; format: longint;
  mode: longint; Data: pbyte {_Xconst } {PChar}; nelements: longint); cdecl; external libXrandr;
procedure XRRDeleteProviderProperty(dpy: PDisplay; provider: RRProvider; _property: TAtom); cdecl; external libXrandr;
function XRRGetProviderProperty(dpy: PDisplay; provider: RRProvider; _property: TAtom; offset: longint; length: longint; _delete: TBool;
  pending: TBool; req_type: TAtom; actual_type: PAtom; actual_format: Plongint; nitems: Pdword; bytes_after: Pdword; prop: PPbyte {PPChar}): longint; cdecl; external libXrandr;

type
  PXRRMonitorInfo = ^TXRRMonitorInfo;
  TXRRMonitorInfo = record
    Name: TAtom;
    primary: TBool;
    automatic: TBool;
    noutput: longint;
    x: longint;
    y: longint;
    Width: longint;
    Height: longint;
    mwidth: longint;
    mheight: longint;
    outputs: PRROutput;
  end;
//  XRRMonitorInfo = _XRRMonitorInfo;

function XRRAllocateMonitor(dpy: PDisplay; noutput: longint): PXRRMonitorInfo; cdecl; external libXrandr;
function XRRGetMonitors(dpy: PDisplay; window: TWindow; get_active: TBool; nmonitors: Plongint): PXRRMonitorInfo; cdecl; external libXrandr;
procedure XRRSetMonitor(dpy: PDisplay; window: TWindow; monitor: PXRRMonitorInfo); cdecl; external libXrandr;
procedure XRRDeleteMonitor(dpy: PDisplay; window: TWindow; Name: TAtom); cdecl; external libXrandr;
procedure XRRFreeMonitors(monitors: PXRRMonitorInfo); cdecl; external libXrandr;

implementation

end.

