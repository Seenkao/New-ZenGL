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

 !!! modification from Serge 26.02.2022
}
unit zgl_screen;

{$I zgl_config.cfg}
{$I GLdefine.cfg}

{$IF defined(iOS) or defined(MAC_COCOA)}
  {$modeswitch objectivec1}
{$IfEnd}

interface

uses
{$IFDEF USE_X11}
  X, XLib, XRandr, UnixType,
  zgl_glx_wgl,
{$ENDIF}
{$IFDEF WINDOWS}
  Windows,
  zgl_glx_wgl,
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  CocoaAll,
{$EndIf}
  MacOSAll,
{$ENDIF}
{$IFDEF iOS}
  iPhoneAll, CFBase, CFString,
{$ENDIF}
  zgl_gltypeconst,
  zgl_types;

const
  REFRESH_MAXIMUM = 0;
  REFRESH_DEFAULT = 1;

var
  SetViewPort: procedure;

{$IfNDef ANDROID}
// Rus: инициализация окна.
// Eng: window initialization.
procedure scr_Init;
{$IfNDef MAC_COCOA}
// Rus: сбросить настройки окна в исходное состояние.
// Eng: reset the window settings to their original state.
procedure scr_Reset;
{$EndIf}
// Rus: создание окна.
// Eng: window creation.
function  scr_Create: Boolean;
// Rus: уничтожение окна.
// Eng: window destruction.
procedure scr_Destroy;
{$EndIf}

// Rus: очистка окна.
// Eng: window cleaning.
procedure scr_Clear;
// Rus:
// Eng:
procedure scr_Flush;

// Rus: установка заданных значений окна. Значения заданы посредством
//      zgl_SetParam или по умолчанию.
// Eng: setting window preset values. Values are set via zgl_SetParam or by default.
function  scr_SetOptions(): Boolean;
// Rus: корректировка окна вывода заданным значениям.
// Eng: adjustment of the output window to the given values.
procedure scr_CorrectResolution(Width, Height: Word);
// Rus: установка порта вывода. На данное время только 2D.
// Eng: setting the output port. Currently only 2D.
procedure scr_SetViewPort2D;
// Rus: включение/выключение вертикальной синхронизации.
// Eng: enable/disable vertical sync.
procedure scr_SetVSync(WSync: Boolean);
// Rus: включение/выключение очистки окна заданным цветом и установка цвета
//      очистки. RGB, A = 255;
// Eng: enable/disable window cleaning with a specified color and set the
//      cleaning color. RGB, A=255;
procedure scr_SetClearColor(flag: Boolean = true; Color: Cardinal = 0);
// Rus: процедура вертикальной синхронизации. Вызывать не надо, происходит по
//      умолчанию, если включена вертикальная синхронизация.
// Eng: vertical synchronization procedure. Don't call, happens by default if
//      vertical sync is enabled.
procedure scr_VSync;
{$IfNDef USE_INIT_HANDLE}
// Rus: установка FPS. Требуется доработка на проверку частот монитора.
// Eng: FPS setting. Improvement is required to check the frequencies of the monitor.
procedure scr_SetFPS(FPS: LongWord);
{$EndIf}

//procedure scr_SetFSAA(FSAA: Byte);

// Rus: Чтение определённой области окна в память.
// Eng: Reading a specific region of a window into memory.
procedure scr_ReadPixels(var pData: Pointer; X, Y, Width, Height: Word);
{$IfNDef ANDROID}
// на данное время ни где не используется, кроме инициализации. Нужен будет
// выводимый список всех возможных разрешений экрана?
//procedure scr_GetResList;
{$EndIf}
// Rus: установка глубины для 2D режима. Можно использовать и для 3D, учитывая,
//      что Far не должно быть меньше нуля.
// Eng: depth setting for 2D mode. Can be used for 3D as well, given that Far
//      must not be less than zero.
procedure Set2DNearFar(newNear, newFar: {$IfNDef USE_GLES}Double{$Else}{$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}Double{$Else}Single{$IfEnd}{$EndIf});
{$IfDef GL_VERSION_3_0}
// Rus: установка версии OpenGL, маски и флагов. Вызывать обязательно до
//      создания окна (до zgl_Init)!!! Совместимые версии только до OpenGL 3.1,
//      далее они не совместимы со старым контекстом.
// Eng:
procedure SetGLVersionAndFlags({$IfNDef MAC_COCOA}major, minor: Integer; flag: LongWord = COMPATIBILITY_VERSION{$Else}mode: LongWord{$EndIf});
{$EndIf}

type
  zglPResolutionList = ^zglTResolutionList;
  zglTResolutionList = record
    Count : Integer;
    Width : array of Integer;
    Height: array of Integer;
  {$ifdef Windows}
    frequency: array of Integer;
  {$endif}
  end;

{$IFDEF WINDOWS}
type
  HMONITOR = THandle;
  MONITORINFOEX = record              // inormation monitor
    cbSize   : LongWord;
    rcMonitor: TRect;
    rcWork   : TRect;
    dwFlags  : LongWord;
    szDevice : array[0..CCHDEVICENAME - 1] of WideChar;
  end;
{$ENDIF}

var
  scrRefresh    : Integer = REFRESH_MAXIMUM;
  scrVSync      : Boolean = false;
  {$IfNDef ANDROID}
  scrResList    : zglTResolutionList;
  scrInitialized: Boolean;
  {$EndIf}

  // Viewport
  scrViewportX: Integer;
  scrViewportY: Integer;
  scrViewportW: Integer;
  scrViewportH: Integer;

  // Resolution Correct
  scrResW : Integer;
  scrResH : Integer;
  scrResCX: Single  = 1;
  scrResCY: Single  = 1;
  scrAddCX: Integer = 0;
  scrAddCY: Integer = 0;
  scrSubCX: Integer = 0;
  scrSubCY: Integer = 0;


  scrViewPort       : Boolean = True;  // этот флаг можно отключать, если мы не меняем поле прорисовки.
  scrClearColor     : Boolean = True;
  scr_UseClearColor : zglTColor;

  {$IFDEF USE_X11}
  scrDisplay  : PDisplay;
  scrDefault  : cint;
  scrSettings : Pointer;
  scrDesktop  : LongInt;
  scrCurrent  : LongInt;
  scrModeCount: LongInt;
  scrModeList : PXRRScreenSize;
  scrEventBase: cint;
  scrErrorBase: cint;
  scrRotation : Word;
  {$ENDIF}
  {$IFDEF WINDOWS}
  scrSettings: DEVMODEW;
  scrDesktop : DEVMODEW;
  scrMonInfo : MONITORINFOEX;
  {$ENDIF}
  {$IFDEF MACOSX}
  scrDisplay  : CGDirectDisplayID;
  scrDesktop  : {$IfDef MAC_COCOA}CGDisplayModeRef{$Else} CFDictionaryRef{$EndIf};
  scrDesktopW : Integer;
  scrDesktopH : Integer;
  scrSettings : CFDictionaryRef;
  scrModeCount: CFIndex;
  scrModeList : CFArrayRef;
  {$ENDIF}
  {$IFDEF iOS}
  scrDisplayLink : CADisplayLink;
  scrCurrModeW   : Integer;
  scrCurrModeH   : Integer;
  scrDesktopW    : Integer;
  scrDesktopH    : Integer;
  scrOrientation : UIInterfaceOrientation;
  scrCanLandscape: Boolean;
  scrCanPortrait : Boolean;
  {$ENDIF}
  {$IFDEF ANDROID}
  scrDesktopW: Integer;
  scrDesktopH: Integer;
  {$ENDIF}
  {$IfNDef USE_GLES}
  scrFar: Double = 1;
  scrNear: Double = - 1;
  {$Else}
  {$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}
  scrFar: Double = 1;
  scrNear: Double = - 1;
  {$Else}
  scrFar: Single = 1;
  scrNear: Single = - 1;
  {$IfEnd}
  {$EndIf}


implementation
uses
  zgl_application,
  zgl_window,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_render,
  zgl_render_2d,
  zgl_camera_2d,
  zgl_log,
  zgl_utils
  ;

{$IFDEF USE_X11}
function XOpenIM(para1:PDisplay; para2:PXrmHashBucketRec; para3:PAnsiChar; para4:Pchar):PXIM;cdecl;external;
function XCloseIM(im: PXIM): TStatus;cdecl;external;
function XCreateIC(para1: PXIM; para2: array of const):PXIC;cdecl;external;
procedure XDestroyIC(ic: PXIC);cdecl;external;
{$ENDIF}
{$IFDEF WINDOWS}
const
  MONITOR_DEFAULTTOPRIMARY = $00000001;
function MonitorFromWindow(hwnd: HWND; dwFlags: LongWord): THandle; stdcall; external 'user32.dll';
function GetMonitorInfoW(monitor: HMONITOR; var moninfo: MONITORINFOEX): BOOL; stdcall; external 'user32.dll';
{$ENDIF}

{$IfNDef ANDROID}
procedure scr_GetResList;
var
  i: Integer;
  {$IFDEF USE_X11}
  tmpSettings: PXRRScreenSize;
  {$ENDIF}
  {$IFDEF WINDOWS}
  tmpSettings: DEVMODEW;
  {$ENDIF}
  {$IFDEF MACOSX}
  tmpSettings  : UnivPtr;
  width, height: Integer;

  {$ENDIF}
  function Already(Width, Height: Integer): Boolean;
  var
    j: Integer;
  begin
    Result := FALSE;
    for j := 0 to scrResList.Count - 1 do
      if (scrResList.Width[j] = Width) and (scrResList.Height[j] = Height) Then Result := TRUE;
  end;
begin
{$IFDEF USE_X11}
  tmpSettings := scrModeList;
  for i := 0 to scrModeCount - 1 do
  begin
    if not Already(tmpSettings.Width, tmpSettings.Height) Then
    begin
      INC(scrResList.Count);
      SetLength(scrResList.Width, scrResList.Count);
      SetLength(scrResList.Height, scrResList.Count);
      scrResList.Width[scrResList.Count - 1]  := tmpSettings.Width;
      scrResList.Height[scrResList.Count - 1] := tmpSettings.Height;
    end;
    INC(tmpSettings);
  end;
{$ENDIF}
{$IFDEF WINDOWS}
  i := 0;
  FillChar(tmpSettings, SizeOf(DEVMODEW), 0);
  tmpSettings.dmSize := SizeOf(DEVMODEW);
  while EnumDisplaySettingsW(scrMonInfo.szDevice, i, tmpSettings) <> FALSE do             
  begin
    if not Already(tmpSettings.dmPelsWidth, tmpSettings.dmPelsHeight) Then
    begin
      INC(scrResList.Count);                                                              
      SetLength(scrResList.Width, scrResList.Count);
      SetLength(scrResList.Height, scrResList.Count);
      SetLength(scrResList.frequency, scrResList.Count);
      scrResList.Width[scrResList.Count - 1]  := tmpSettings.dmPelsWidth;
      scrResList.Height[scrResList.Count - 1] := tmpSettings.dmPelsHeight;
      scrResList.frequency[scrResList.Count - 1] := tmpSettings.dmDisplayFrequency;       
    end;
    INC(i);
  end;
{$ENDIF}
{$IFDEF MACOSX}
  tmpSettings := scrModeList;
  for i := 0 to scrModeCount - 1 do
  begin
    tmpSettings := CFArrayGetValueAtIndex(scrModeList, i);

    CFNumberGetValue(CFDictionaryGetValue(tmpSettings, CFSTRP('Width')), kCFNumberIntType, @width);
    CFNumberGetValue(CFDictionaryGetValue(tmpSettings, CFSTRP('Height')), kCFNumberIntType, @height);
    if not Already(width, height) Then
    begin
      INC(scrResList.Count);
      SetLength(scrResList.Width, scrResList.Count);
      SetLength(scrResList.Height, scrResList.Count);
      scrResList.Width[scrResList.Count - 1]  := width;
      scrResList.Height[scrResList.Count - 1] := height;
    end;
  end;
{$ENDIF}
{$IFDEF iOS}
  scrResList.Count := 1;
  SetLength(scrResList.Width, 1);
  SetLength(scrResList.Height, 1);
  scrResList.Width[0] := scrDesktopW;
  scrResList.Height[0] := scrDesktopH;
{$ENDIF}
end;

procedure scr_Init;
  {$IFDEF iOS}
  var
    i           : Integer;
    orientations: NSArray;
    tmp         : array[0..255] of AnsiChar;
  {$ENDIF}
  {$ifdef windows}
  var
    scrMonitor: THandle;
    i: Integer;
  {$endif}
begin
{$IFDEF USE_X11}
  if not appInitialized Then
  begin
    log_Init();

    if Assigned(scrDisplay) Then
      XCloseDisplay(scrDisplay);

    scrDisplay := XOpenDisplay(nil);
    if not Assigned(scrDisplay) Then
    begin
      u_Error('Cannot connect to X server.');
      exit;
    end;

    scrDefault := DefaultScreen(scrDisplay);
    wndRoot    := DefaultRootWindow(scrDisplay);

    XRRSelectInput(scrDisplay, wndRoot, RRScreenChangeNotifyMask);
    XRRQueryExtension(scrDisplay, @scrEventBase, @scrErrorBase) ;
  end;

  scrModeList := XRRSizes(scrDisplay, XRRRootToScreen(scrDisplay, wndRoot), @scrModeCount);
  scrSettings := XRRGetScreenInfo(scrDisplay, wndRoot);
  scrDesktop  := XRRConfigCurrentConfiguration(scrSettings, @scrRotation);
{$ENDIF}
{$IFDEF WINDOWS}
  i := SizeOf(MONITORINFOEX);
  if scrMonInfo.cbSize <> i Then
  begin
    scrMonitor := MonitorFromWindow(wndHandle, MONITOR_DEFAULTTOPRIMARY);
    FillChar(scrMonInfo, i, 0);
    scrMonInfo.cbSize := i;
    GetMonitorInfoW(scrMonitor, scrMonInfo);
  end;

  i := SizeOf(DEVMODEW);
  FillChar(scrDesktop, i, 0);
  scrDesktop.dmSize := i;
  // Delphi: standard ENUM_REGISTRY_SETTINGS doesn't exist in Windows unit, no comments...
  EnumDisplaySettingsW(scrMonInfo.szDevice, LongWord(-2), scrDesktop);
{$ENDIF}
{$IFDEF MACOSX}
  scrDisplay  := CGMainDisplayID();
  scrDesktop  := {$IfNDef MAC_COCOA}CGDisplayCurrentMode(scrDisplay);{$Else}CGDisplayCopyDisplayMode(scrDisplay);{$EndIf}
  scrDesktopW := CGDisplayPixelsWide(scrDisplay);
  scrDesktopH := CGDisplayPixelsHigh(scrDisplay);

  scrModeList  := {$IfNDef MAC_COCOA}CGDisplayAvailableModes(scrDisplay){$Else}CGDisplayCopyAllDisplayModes(scrDisplay, nil){$EndIf};
  scrModeCount := CFArrayGetCount(scrModeList);
{$ENDIF}
{$IFDEF iOS}
  if not appInitialized Then exit;

  app_InitPool();

  orientations := NSBundle.mainBundle.infoDictionary.objectForKey(utf8_GetNSString('UISupportedInterfaceOrientations'));
  for i := 0 to orientations.count() - 1 do
  begin
    CFStringGetCString(CFStringRef(orientations.objectAtIndex(i)), @tmp[0], 255, kCFStringEncodingUTF8);
    if (tmp = 'UIInterfaceOrientationLandscapeLeft') or (tmp = 'UIInterfaceOrientationLandscapeRight') Then
      scrCanLandscape := TRUE;
    if (tmp = 'UIInterfaceOrientationPortrait') or (tmp = 'UIInterfaceOrientationPortraitUpsideDown') Then
      scrCanPortrait := TRUE;
  end;

  if UIDevice.currentDevice.systemVersion.floatValue >= 3.2 Then
  begin
    scrCurrModeW := Round(UIScreen.mainScreen.currentMode.size.width);
    scrCurrModeH := Round(UIScreen.mainScreen.currentMode.size.height);

    if (UIDevice.currentDevice.userInterfaceIdiom = UIUserInterfaceIdiomPhone) and (UIDevice.currentDevice.model.rangeOfString(utf8_GetNSString('iPad')).location <> NSNotFound) Then
    begin
      scrCurrModeW := Round(480 * UIScreen.mainScreen.scale);
      scrCurrModeH := Round(320 * UIScreen.mainScreen.scale);
    end;
  end else
  begin
    scrCurrModeW := Round(UIScreen.mainScreen.bounds.size.width);
    scrCurrModeH := Round(UIScreen.mainScreen.bounds.size.height);
  end;

  if (scrCurrModeW > scrCurrModeH) Then
  begin
    scrDesktopH  := scrCurrModeW;
    scrCurrModeW := scrCurrModeH;
    scrCurrModeH := scrDesktopH;
  end;

  scrOrientation := UIApplication.sharedApplication.statusBarOrientation();
  if scrCanPortrait and ((scrOrientation = UIInterfaceOrientationPortrait) or (scrOrientation = UIInterfaceOrientationPortraitUpsideDown)) Then
  begin
    wndPortrait := TRUE;
    scrDesktopW := scrCurrModeW;
    scrDesktopH := scrCurrModeH;
  end else
    if scrCanLandscape and ((scrOrientation = UIInterfaceOrientationLandscapeLeft) or (scrOrientation = UIInterfaceOrientationLandscapeRight)) Then
    begin
      wndPortrait := FALSE;
      scrDesktopW := scrCurrModeH;
      scrDesktopH := scrCurrModeW;
    end else
    begin
      wndPortrait := scrCanPortrait;
      scrDesktopW := scrCurrModeW;
      scrDesktopH := scrCurrModeH;
    end;

  oglWidth    := scrDesktopW;
  oglHeight   := scrDesktopH;
  oglTargetW  := scrDesktopW;
  oglTargetH  := scrDesktopH;
{$ENDIF}
{$IfNDef MAC_COCOA}
  scr_GetResList;
{$EndIf}
  scrInitialized := TRUE;
end;

{$IfNDef MAC_COCOA}
procedure scr_Reset;
begin
{$IFDEF USE_X11}
  XRRSetScreenConfig(scrDisplay, scrSettings, wndRoot, scrDesktop, scrRotation, CurrentTime);
{$ENDIF}
{$IFDEF WINDOWS}
  ChangeDisplaySettingsExW(scrMonInfo.szDevice, DEVMODEW(nil^), 0, CDS_FULLSCREEN, nil);
{$ENDIF}
{$IFDEF MACOSX}
  CGDisplaySwitchToMode(scrDisplay, scrDesktop);
  //CGDisplayRelease(scrDisplay);
{$ENDIF}
end;

procedure scr_SetWindowedMode;
  {$IFDEF WINDOWS}
  var
    settings: DEVMODEW;
  {$ENDIF}
begin
  {$IFDEF USE_X11}
  scr_Reset();
  XMapWindow(scrDisplay, wndHandle);
  {$ENDIF}
  {$IFDEF WINDOWS}
  if scrDesktop.dmBitsPerPel <> 32 Then
  begin
    settings              := scrDesktop;
    settings.dmBitsPerPel := 32;

    if ChangeDisplaySettingsExW(scrMonInfo.szDevice, settings, 0, CDS_TEST, nil) <> DISP_CHANGE_SUCCESSFUL Then
    begin
      u_Error('Desktop doesn''t support 32-bit color mode.');
      winOn := FALSE;
    end else
      ChangeDisplaySettingsExW(scrMonInfo.szDevice, settings, 0, CDS_FULLSCREEN, nil);

    scrRefresh := scrDesktop.dmDisplayFrequency;
  end else
    scr_Reset();
  {$ENDIF}
  {$IFDEF MACOSX}
  scr_Reset();
  ShowMenuBar();
  {$ENDIF}
end;
{$EndIf}

function scr_Create: Boolean;
{$IfDef MAC_COCOA}
var
  pool: NSAutoreleasePool;
  mainMenu: NSMenu;
{$EndIf}
begin
  {$IfNDef ANDROID}
  scr_Init();
  {$EndIf}
  {$IFDEF USE_X11}
  if DefaultDepth(scrDisplay, scrDefault) < 24 Then
    begin
      u_Error('DefaultDepth not set to 24-bit.');
      winOn := false;
      Result := FALSE;
      exit;
    end;

  {$IfDef OLD_METHODS}
  appXIM := XOpenIM(scrDisplay, nil, nil, nil);
  if not Assigned(appXIM) Then
    log_Add('XOpenIM - Fail')
  else
    log_Add('XOpenIM - ok'); }

  appXIC := XCreateIC(appXIM, [XNInputStyle, XIMPreeditNothing or XIMStatusNothing, 0]);
  if not Assigned(appXIC) Then
    log_Add('XCreateIC - Fail')
  else
    log_Add('XCreateIC - ok');
  {$EndIf}
  {$ENDIF}
  {$IFDEF WINDOWS}
  if (not wndFullScreen) and (scrDesktop.dmBitsPerPel <> 32) Then
    scr_SetWindowedMode();
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  pool := NSAutoreleasePool.new;
  NSApp := NSApplication.sharedApplication;
  NSApp.setActivationPolicy(0);
  NSApp.activateIgnoringOtherApps(true);

  mainMenu := NSMenu.alloc.init.autorelease;
  NSApp.setMainMenu(mainMenu);
  mainMenu.setMenuBarVisible(false);        // menu not visible

  pool.dealloc;

  {$Else}
  if CGDisplayBitsPerPixel(scrDisplay) <> 32 Then
    begin
      u_Error('Desktop not set to 32-bit mode.');
      winOn := False;
      Result := FALSE;
      exit;
    end;
  {$ENDIF}{$EndIf}
  log_Add('Current mode: ' + u_IntToStr(zgl_Get(DESKTOP_WIDTH)) + ' x ' + u_IntToStr(zgl_Get(DESKTOP_HEIGHT)));
  Result := TRUE;
end;

procedure scr_Destroy;
begin
  {$IfNDef MAC_COCOA}
  if wndFullScreen Then
    scr_Reset();
  {$EndIf}
  {$IFDEF USE_X11}
  XRRFreeScreenConfigInfo(scrSettings);
  {$IfDef OLD_METHODS}
  XDestroyIC(appXIC);
  XCloseIM(appXIM);
  {$EndIf}
  {$ENDIF}

  scrResList.Count := 0;
  SetLength(scrResList.Width, 0);
  SetLength(scrResList.Height, 0);
  {$ifdef windows}
  SetLength(scrResList.frequency, 0);
  {$endif}

  scrInitialized := FALSE;
end;
{$EndIf}

procedure scr_Clear;
begin
  batch2d_Flush();
  if scrClearColor then
    glClearColor(scr_UseClearColor.R, scr_UseClearColor.G, scr_UseClearColor.b, scr_UseClearColor.A);
  glClear(GL_COLOR_BUFFER_BIT * Byte(appFlags and COLOR_BUFFER_CLEAR > 0) or GL_DEPTH_BUFFER_BIT * Byte(appFlags and DEPTH_BUFFER_CLEAR > 0) or
           GL_STENCIL_BUFFER_BIT * Byte(appFlags and STENCIL_BUFFER_CLEAR > 0));
end;

procedure scr_Flush;
begin
  batch2d_Flush();
{$IFNDEF USE_GLES}
  {$IFDEF LINUX}
  glXSwapBuffers(scrDisplay, wndHandle);
  {$ENDIF}
  {$IFDEF WINDOWS}
  SwapBuffers(wndDC);
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  oglContext.flushBuffer;
  {$Else}
  aglSwapBuffers(oglContext);
  {$ENDIF}{$EndIf}
{$ELSE}
  {$IFNDEF NO_EGL}
  eglSwapBuffers(oglDisplay, oglSurface);
  {$ENDIF}
  {$IFDEF iOS}
  eglContext.presentRenderbuffer(GL_RENDERBUFFER);
  {$ENDIF}
  {$IFDEF ANDROID}
  appEnv^.CallVoidMethod(appEnv, appObject, appSwapBuffers);
  {$ENDIF}
{$ENDIF}
end;

function scr_SetOptions(): Boolean;
  {$IFDEF USE_X11}
  var
    modeToSet: Integer;
    mode     : PXRRScreenSize;
  {$ENDIF}
  {$IFDEF WINDOWS}
  var
    i: Integer;
    r: Integer;
  {$ENDIF}
  {$IFDEF MACOSX}
  var
    b: Integer;
  {$ENDIF}
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  wndWidth      := scrDesktopW;
  wndHeight     := scrDesktopH;
  scrRefresh    := REFRESH_DEFAULT;
  wndFullScreen := TRUE;
  scrVsync      := TRUE;
{$IFEND}

  Result        := TRUE;
  if not appInitialized Then
  begin
    oglWidth   := wndWidth;
    oglHeight  := wndHeight;
    oglTargetW := wndWidth;
    oglTargetH := wndHeight;
    exit;
  end;
  scr_VSync;

{$IFDEF USE_X11}
  if wndFullScreen Then
  begin
    scrCurrent := -1;
    mode       := scrModeList;

    for modeToSet := 0 to scrModeCount - 1 do
      if (mode.Width = wndWidth) and (mode.Height = wndHeight) Then
      begin
        scrCurrent := modeToSet;
        break;
      end else
        INC(mode);

    if (scrCurrent = -1) or (XRRSetScreenConfig(scrDisplay, scrSettings, wndRoot, scrCurrent, scrRotation, CurrentTime) <> 0) Then
    begin
      u_Warning('Cannot set fullscreen mode: ' + u_IntToStr(wndWidth) + 'x' + u_IntToStr(wndHeight));
      scrCurrent    := scrDesktop;
      wndFullScreen := FALSE;
      Result        := FALSE;
      exit;
    end;
  end else
    scr_SetWindowedMode();
{$ENDIF}
{$IFDEF WINDOWS}
  if wndFullScreen Then
  begin
    i := 0;
    r := 0;
    FillChar(scrSettings, SizeOf(DEVMODEW), 0);
    scrSettings.dmSize := SizeOf(DEVMODEW);
    while EnumDisplaySettingsW(scrMonInfo.szDevice, i, scrSettings) <> FALSE do
      with scrSettings do
      begin
        dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL or DM_DISPLAYFREQUENCY;
        if (dmPelsWidth = wndWidth) and (dmPelsHeight = wndHeight) and (dmBitsPerPel = 32) and (dmDisplayFrequency > r) and
               (dmDisplayFrequency <= scrDesktop.dmDisplayFrequency) Then
        begin
          if ChangeDisplaySettingsExW(scrMonInfo.szDevice, scrSettings, 0, CDS_TEST, nil) = DISP_CHANGE_SUCCESSFUL Then
            r := dmDisplayFrequency
          else
            break;
        end;
        INC(i);
      end;

    with scrSettings do
    begin
      if scrRefresh = REFRESH_MAXIMUM Then scrRefresh := r;
      if scrRefresh = REFRESH_DEFAULT Then scrRefresh := 0;

      dmPelsWidth        := wndWidth;
      dmPelsHeight       := wndHeight;
      dmBitsPerPel       := 32;
      dmDisplayFrequency := scrRefresh;
      dmFields           := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL or DM_DISPLAYFREQUENCY;
    end;

    if ChangeDisplaySettingsExW(scrMonInfo.szDevice, scrSettings, 0, CDS_TEST, nil) <> DISP_CHANGE_SUCCESSFUL Then
    begin
      u_Warning('Cannot set fullscreen mode: ' + u_IntToStr(wndWidth) + 'x' + u_IntToStr(wndHeight));
      wndFullScreen := FALSE;
      Result        := FALSE;
      exit;
    end else
      ChangeDisplaySettingsExW(scrMonInfo.szDevice, scrSettings, 0, CDS_FULLSCREEN, nil);

    scrRefresh := scrDesktop.dmDisplayFrequency;
  end else
    scr_SetWindowedMode();
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  if winOn then
  begin
    if wndFullScreen then
    begin
      viewNSRect.origin.x := 0;
      viewNSRect.origin.y := 0;
      viewNSRect.size.width := scrDesktopW;
      viewNSRect.size.height := scrDesktopH;
      wndHandle.setStyleMask(NSBorderlessWindowMask);
      wndHandle.setFrame_display(viewNSRect, True);
    end
    else begin
      viewNSRect.origin.x := wndX;
      viewNSRect.origin.y := wndY;
      viewNSRect.size.width := wndWidth;
      viewNSRect.size.height := wndHeight + 0;
      wndHandle.setStyleMask(NSTitledWindowMask or NSClosableWindowMask);
      wndHandle.setFrame_display(viewNSRect, True);
    end;
  end;
{$Else}
  if wndFullScreen Then
  begin
    if (scrRefresh <> 0) and (scrRefresh <> 1) Then
    begin
      scrSettings := CGDisplayBestModeForParametersAndRefreshRate(scrDisplay, 32, wndWidth, wndHeight, scrRefresh, b);
      scrRefresh  := b;
    end;
    if (scrRefresh = 0) or (scrRefresh = 1) Then
      scrSettings := CGDisplayBestModeForParameters(scrDisplay, 32, wndWidth, wndHeight, b);

    if (b <> 1) or (CGDisplaySwitchToMode(scrDisplay, scrSettings) <> kCGErrorSuccess) Then
    begin
      u_Warning('Cannot set fullscreen mode: ' + u_IntToStr(wndWidth) + 'x' + u_IntToStr(wndHeight));
      wndFullScreen := FALSE;
      Result        := FALSE;
      exit;
    end;

    HideMenuBar();
  end else
    scr_SetWindowedMode();
{$ENDIF}{$EndIf}
  if wndFullScreen Then
    log_Add('Screen options changed to: ' + u_IntToStr(wndWidth) + ' x ' + u_IntToStr(wndHeight) + ' fullscreen')
  else
    log_Add('Screen options changed to: ' + u_IntToStr(wndWidth) + ' x ' + u_IntToStr(wndHeight) + ' windowed');

  {$IfDef USE_INIT_HANDLE}
  if (not wndFullScreen) and (appFlags and WND_USE_AUTOCENTER > 0) Then
    wnd_SetPos((zgl_Get(DESKTOP_WIDTH) - wndWidth) div 2, (zgl_Get(DESKTOP_HEIGHT) - wndHeight) div 2);
  wnd_SetSize(wndWidth, wndHeight);
  {$Else}
  {$IfNDef ANDROID}
  if winOn Then
    wnd_Update();
  {$Else}
  wnd_SetSize(wndWidth, wndHeight);
  {$EndIf}{$EndIf}
end;

procedure scr_CorrectResolution(Width, Height: Word);
begin
  {$IfDef MAC_COCOA}
  zgl_Disable(CORRECT_RESOLUTION);
  {$Else}
  scrResW        := Width;
  scrResH        := Height;
  scrResCX       := wndWidth  / Width;
  scrResCY       := wndHeight / Height;
  render2dClipW  := Width;
  render2dClipH  := Height;
  render2dClipXW := render2dClipX + render2dClipW;
  render2dClipYH := render2dClipY + render2dClipH;

  if scrResCX < scrResCY Then
  begin
    scrAddCX := 0;
    scrAddCY := Round((wndHeight - Height * scrResCX) / 2);
    scrResCY := scrResCX;
  end else
  begin
    scrAddCX := Round((wndWidth - Width * scrResCY) / 2);
    scrAddCY := 0;
    scrResCX := scrResCY;
  end;

  if appFlags and CORRECT_HEIGHT = 0 Then
  begin
    scrResCY := wndHeight / Height;
    scrAddCY := 0;
  end;
  if appFlags and CORRECT_WIDTH = 0 Then
  begin
    scrResCX := wndWidth / Width;
    scrAddCX := 0;
  end;

  oglWidth  := Round(wndWidth / scrResCX);
  oglHeight := Round(wndHeight / scrResCY);
  scrSubCX  := oglWidth - Width;
  scrSubCY  := oglHeight - Height;
  SetCurrentMode(oglMode);
  {$EndIf}
end;

procedure scr_SetViewPort2D;
begin
  if oglTarget = TARGET_SCREEN Then
  begin
    if (appFlags and CORRECT_RESOLUTION > 0) and (oglMode = 2) Then
    begin
      scrViewportX := scrAddCX;
      scrViewportY := scrAddCY;
      scrViewportW := wndWidth - scrAddCX * 2;
      scrViewportH := wndHeight - scrAddCY * 2;
    end else
    begin
      scrViewportX := 0;
      scrViewportY := 0;
      scrViewportW := wndWidth;
      scrViewportH := wndHeight;
    end;
  end else
  begin
    scrViewportX := 0;
    scrViewportY := 0;
    scrViewportW := oglTargetW;
    scrViewportH := oglTargetH;
  end;

  if appFlags and CORRECT_RESOLUTION > 0 Then
  begin
    render2dClipW  := scrResW;
    render2dClipH  := scrResH;
    render2dClipXW := render2dClipX + render2dClipW;
    render2dClipYH := render2dClipY + render2dClipH;
  end else
  begin
    render2dClipW  := scrViewportW;
    render2dClipH  := scrViewportH;
    render2dClipXW := render2dClipX + render2dClipW;
    render2dClipYH := render2dClipY + render2dClipH;
  end;

  glViewPort(scrViewportX, scrViewportY, scrViewportW, scrViewportH);
end;

procedure scr_SetVSync(WSync: Boolean);
begin
  {$IfNDef USE_INIT_HANDLE}
  if (useFPS > 60) and WSync then
    scr_SetFPS(60);
  {$EndIf}
  scrVSync := WSync;
end;

procedure scr_SetClearColor(flag: Boolean = true; Color: Cardinal = 0);
begin
  scrClearColor := flag;
  scr_UseClearColor.R := (Color shr 16) / 255;
  scr_UseClearColor.G := ((Color and $FF00) shr 8) / 255;
  scr_UseClearColor.B := (Color and $FF) / 255;
  scr_UseClearColor.A := 1;
end;

procedure scr_VSync;                  
begin
{$IFNDEF USE_GLES}
  {$IFDEF USE_X11}
  if oglCanVSync Then
    glXSwapIntervalSGI(Integer(scrVSync));
  {$ENDIF}
  {$IFDEF WINDOWS}
  if oglCanVSync Then
    wglSwapIntervalEXT(Integer(scrVSync));
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
//  oglContext.setValues_forParameter(30, NSOpenGLCPSwapInterval);
  {$Else}
  if Assigned(oglContext) Then
    aglSetInt(oglContext, AGL_SWAP_INTERVAL, Byte(scrVSync));
  {$ENDIF}{$EndIf}
{$ELSE}
  {$IFNDEF NO_EGL}
  if oglCanVSync Then
    eglSwapInterval(oglDisplay, Integer(scrVSync));
  {$ENDIF}
{$ENDIF}
end;

{$IfNDef USE_INIT_HANDLE}
procedure scr_SetFPS(FPS: LongWord);
begin
  if FPS < 30 then
    FPS := 30;
  if (FPS <> 60) and (FPS <> 75) and (FPS <> 85) and (FPS <> 90) and (FPS <> 100) and (FPS <> 120) and (FPS <> 144) then
    FPS := 60;
  useFPS := FPS;
  if useFPS > 60 then
  begin
    scrVSync := True;
    scr_VSync;
  end;
  maxFPS := 1000 / FPS;
end;
{$EndIf}

{procedure scr_SetFSAA(FSAA: Byte);
begin
  if oglFSAA = FSAA Then exit;
  oglFSAA := FSAA;

  gl_Destroy();
  log_Add('Start reinitialization of OpenGL');

  gl_Create();
  wnd_Destroy();
  wnd_Create();
//  wnd_SetCaption();
  gl_Initialize();
  if oglFSAA <> 0 Then
    log_Add('FSAA changed to: ' + u_IntToStr(oglFSAA) + 'x')
  else
    log_Add('FSAA changed to: off');
end;}

procedure scr_ReadPixels(var pData: Pointer; X, Y, Width, Height: Word);
begin
  batch2d_Flush();
  GetMem(pData, Width * Height * 4);
  glReadPixels(X, oglHeight - Height - Y, Width, Height, GL_RGBA, GL_UNSIGNED_BYTE, pData);
end;

procedure Set2DNearFar(newNear, newFar: {$IfNDef USE_GLES}Double{$Else}{$IF DEFINED(USE_GLES_ON_DESKTOP) and DEFINED(USE_AMD_DRIVERS)}Double{$Else}Single{$IfEnd}{$EndIf});
begin
  scrFar := newFar;
  scrNear := newNear;
end;

{$IfDef GL_VERSION_3_0}
procedure SetGLVersionAndFlags({$IfNDef MAC_COCOA}major, minor: Integer; flag: LongWord = COMPATIBILITY_VERSION{$Else}mode: LongWord{$EndIf});
  {$IfNDef MAC_COCOA}
  procedure MajorMinor;
  begin
    if major > 4 then
      major := 4;
    maxGLVerMajor := major;
    if major = 4 then
    begin
      if minor > 6 then
        minor := 6;
      maxGLVerMinor := minor;
      exit;
    end;
    if major = 3 then
    begin
      if minor > 3 then
        minor := 3;
      maxGLVerMinor := minor;
      exit;
    end;
    if major = 2 then
    begin
      if minor > 1 then
        minor := 1;
      maxGLVerMinor := minor;
      exit;
    end;
    if major = 1 then
    begin
      if minor > 5 then
        minor := 5;
      maxGLVerMinor := minor;
    end;
  end;
  {$EndIf}

begin
  {$IfDef MACOSX}
  if (mode > CORE_4_1) or (mode = 0) then
    mode := CORE_2_1;
  if mode = CORE_3_2 then
  begin
    oglAttr[8] := $3200;
    exit;
  end;
  if mode = CORE_4_1 then
  begin
    oglAttr[8] := $4100;
    exit;
  end;
  oglAttr[8] := $1000;
  {$Else}

  if (flag and 3) = 3 then
    flag := flag and 13;
  contextMask := flag and 3;
  contextFlags := (flag and 12) shr 2;

  MajorMinor;
  {$IfDef LINUX}
  if (major > 3) or ((major = 3) and (minor >= 2)) then
  begin
    if contextMask = 2 then
      contextMask := 1;
  end;
  {$EndIf}
  {$EndIf}
end;
{$EndIf}

end.
