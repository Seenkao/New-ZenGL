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

 !!! modification from Serge 25.02.2022
}
unit zgl_window;

{$I zgl_config.cfg}
{$IF defined(iOS) or defined(MAC_COCOA)}
  {$modeswitch objectivec1}
{$IfEnd}

interface

uses
  {$IFDEF UNIX}
  sysutils,
  {$ENDIF}
  {$IFDEF USE_X11}
  X, XLib, XUtil, xrandr,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF MACOSX}
  MacOSAll,
  {$IfDef MAC_COCOA}
  CocoaAll,
  {$ENDIF}{$EndIf}
  {$IFDEF iOS}
  iPhoneAll, CGGeometry,
  {$ENDIF}
  zgl_gltypeconst,
  zgl_types;

const
  cs_ZenGL    = 'ZenGL - 0.3.29';
  cs_Date     = '26.02.2022';
  cv_major    = 0;
  cv_minor    = 3;
  cv_revision = 29;

  // zgl_Reg
  SYS_APP_INIT           = $000001;
  SYS_LOAD               = $000003;
  SYS_DRAW               = $000004;
  SYS_UPDATE             = $000005;
  SYS_EXIT               = $000006;
  SYS_ACTIVATE           = $000007;

  SYS_EVENTS             = $000009;                         // keyboard, mouse, touchpad
  SYS_POSTDRAW           = $000012;                         // процедура постотрисовки (после того как вывелось всё на экран)
  SYS_RESET              = $000013;                         // процедура обнуления
  {$IfNDef ANDROID}
  SYS_CLOSE_QUERY        = $000008;
  SYS_APP_LOOP           = $000002;
  {$EndIf}
  {$IFDEF iOS}
  SYS_iOS_MEMORY_WARNING     = $000010;
  SYS_iOS_CHANGE_ORIENTATION = $000011;
  {$ENDIF}
  {$IFDEF ANDROID}
  SYS_ANDROID_RESTORE = $000015;
  {$ENDIF}

  TEXTURE_FORMAT_EXTENSION   = $000100;                     // расширение файла
  TEXTURE_FORMAT_FILE_LOADER = $000101;                     // процедура загрузки
  TEXTURE_FORMAT_MEM_LOADER  = $000102;                     // процедура загрузки из памяти
  TEXTURE_CURRENT_EFFECT     = $000103;                     // процедура дополнительных эффектов

  SND_FORMAT_EXTENSION   = $000110;
  SND_FORMAT_FILE_LOADER = $000111;
  SND_FORMAT_MEM_LOADER  = $000112;
  SND_FORMAT_DECODER     = $000113;

  VIDEO_FORMAT_DECODER   = $000130;

  // zgl_Get
  ZENGL_VERSION           = 1;
  ZENGL_VERSION_STRING    = 2;
  ZENGL_VERSION_DATE      = 3;

  DIRECTORY_APPLICATION   = 101;
  DIRECTORY_HOME          = 102;

  LOG_FILENAME            = 203;

  DESKTOP_WIDTH           = 300;
  DESKTOP_HEIGHT          = 301;
  RESOLUTION_LIST         = 302;

  WINDOW_HANDLE           = 400;
  WINDOW_X                = 401;
  WINDOW_Y                = 402;
  WINDOW_WIDTH            = 403;
  WINDOW_HEIGHT           = 404;

  GAPI_CONTEXT            = 500;
  GAPI_MAX_TEXTURE_SIZE   = 501;
  GAPI_MAX_TEXTURE_UNITS  = 502;
  GAPI_MAX_ANISOTROPY     = 503;
  GAPI_CAN_BLEND_SEPARATE = 504;
  GAPI_CAN_AUTOGEN_MIPMAP = 505;

  VIEWPORT_WIDTH          = 600;
  VIEWPORT_HEIGHT         = 601;
  VIEWPORT_OFFSET_X       = 602;
  VIEWPORT_OFFSET_Y       = 603;

  RENDER_FPS              = 700;
  RENDER_BATCHES_2D       = 701;
  RENDER_CURRENT_MODE     = 702;
  RENDER_CURRENT_TARGET   = 703;
  RENDER_VRAM_USED        = 704;

  MANAGER_TIMER           = 800;
  MANAGER_TEXTURE         = 801;
  MANAGER_FONT            = 802;
  MANAGER_RTARGET         = 803;
  MANAGER_SOUND           = 804;
  MANAGER_EMITTER2D       = 805;

  // zgl_Enable/zgl_Disable
  COLOR_BUFFER_CLEAR    = $000001;
  DEPTH_BUFFER          = $000002;
  DEPTH_BUFFER_CLEAR    = $000004;
  DEPTH_MASK            = $000008;
  STENCIL_BUFFER_CLEAR  = $000010;
  CORRECT_RESOLUTION    = $000020;
  CORRECT_WIDTH         = $000040;
  CORRECT_HEIGHT        = $000080;
  APP_USE_AUTOPAUSE     = $000100;
  APP_USE_LOG           = $000200;
  APP_USE_ENGLISH_INPUT = $000400;
  APP_USE_DT_CORRECTION = $000800;
  WND_USE_AUTOCENTER    = $001000;
  SND_CAN_PLAY          = $002000;
  SND_CAN_PLAY_FILE     = $004000;
  CLIP_INVISIBLE        = $008000;

  XY_IN_CENTER_WINDOW   = $020000;               // окно выводится от центра экрана
                                                 // при этом надо перерабатывать прорисовку примитивов
                                                 // весь ZenGL сделан от края окна, могут быть не состыковки.
  {$IFDEF iOS}
  SND_ALLOW_BACKGROUND_MUSIC = $100000;
  {$ENDIF}

{$IfDef MAC_COCOA}
type

  { zglNSWindow }
  zglNSWindow = objcclass(NSWindow)
    private
      procedure close; override;
      procedure resignMainWindow; message'resignMainWindow'; override;
      procedure becomeMainWindow; message'becomeMainWindow'; override;
  end;

  zglNSView = objcclass(NSView)
    public
//      procedure drawRect(rect: NSRect); override;
      procedure windowWillClose(note: NSNotification); message 'windowWillClose:';
  end;
{$EndIf}

{$IfNDef ANDROID}
{$IFDEF WND_USE}
// Rus: создание окна.
// Eng: create window
function  wnd_Create(): Boolean;
// Rus: уничтожение окна.
// Eng: destroy window
procedure wnd_Destroy;
{$EndIf}
{$IfNDef USE_INIT_HANDLE}
// Rus: обновление окна.
// Eng: update window
procedure wnd_Update;
// Rus: обновление "имени" окна.
// Eng:
procedure wnd_UpdateCaption();

// Rus: установка "имени" окна.
// Eng: setting the "name" of the window.
procedure wnd_SetCaption(Caption: UTF8String);
// Rus: установка видимости/не видимости курсора.
// Eng: setting the visibility/non-visibility of the cursor.
procedure wnd_ShowCursor(Show : Boolean );
{$EndIf}
{$EndIf}
// Rus: установка размеров окна.
// Eng: window size setting.
procedure wnd_SetSize(Width, Height: Integer);
// Rus: установка позиции окна.
// Eng: setting the window position.
procedure wnd_SetPos(X, Y: Integer);

//--------------------------------------------------------------
{$IfNDef USE_INIT_HANDLE}
// Rus: инициализация рабочего окна и запуск программы.
// Eng: initialization of the working window and launching the program.
procedure zgl_Init(FSAA: Byte = 0; StencilBits: Byte = 0);
{$Else}
// Rus: инициализация рабочего LCL-окна и запуск программы.
// Eng: initialization of the working LCL window and launch of the program.
procedure zgl_InitToHandle(Handle: Ptr; FSAA: Byte = 0; StencilBits: Byte = 0);
{$EndIf}
{$IfNDef ANDROID}
// Rus: установка основных путей для запущенного приложения.
// Eng:
procedure zgl_GetSysDir;
{$EndIf}
// Rus: уничтожение ранее созданных ресурсов. Вызывать не надо.
// Eng:
procedure zgl_Destroy;
// Rus: указываем программе на завершение работы.
// Eng:
procedure zgl_Exit;
// Rus: регистрация функций для создания и работы приложения.
// Eng:
procedure zgl_Reg(What: LongWord; UserData: Pointer);
// нужна эта процедура или нет? Можно просто вызвать через zgl_Reg со значением nil.
//procedure zgl_UnReg(What: LongWord);
// Rus: возврат определённых значений для рабочего приложения.
// Eng:
function  zgl_Get(What: LongWord): Ptr;

// Rus: установка параметров окна. Ширина, высота, полноэкранное или нет и
//      вертикальная синхронизация.
// Eng:
procedure zgl_SetParam(width, height: Integer; FullScreen: Boolean = False; Vsync: Boolean = False);

// Rus: выделение участка памяти.
// Eng:
procedure zgl_GetMem(out Mem: Pointer; Size: LongWord);
// Rus: очистка участка памяти.
// Eng:
procedure zgl_FreeMem(var Mem: Pointer);
// Rus: очистка списка строк.
// Eng:
procedure zgl_FreeStrList(var List: zglTStringList);
// Rus: включение флагов ZenGL.
// Eng:
procedure zgl_Enable(What: LongWord);
// Rus: выключение флагов ZenGL.
// Eng:
procedure zgl_Disable(What: LongWord);
{$IfNDef USE_INIT_HANDLE}
// Rus: установка интервала обработки клавиатуры, мыши и др.
//      Определять до создания окна!!!
// Eng:
procedure zgl_SetEventsInterval(Interval: Cardinal);
{$EndIf}

var
  wndX         : Integer;
  wndY         : Integer;
  wndWidth     : Integer = 800;
  wndHeight    : Integer = 600;
  wndFullScreen: Boolean = false;
  wndCaption   : UTF8String = '';
  wndUpdateWin : Boolean = true;

  {$IFDEF USE_X11}
  wndHandle     : TWindow;
  wndRoot       : TWindow;
  wndClass      : TXClassHint;
  wndAttr       : TXSetWindowAttributes;
  wndTitle      : TXTextProperty;
  wndValueMask  : LongWord;
  wndDestroyAtom: TAtom;
  wndProtocols  : TAtom;
  {$ENDIF}
  {$IFDEF WINDOWS}
//  wndFirst    : Boolean = TRUE; // Microsoft Sucks! :)
  wndHandle   : HWND;
  wndDC       : HDC;
  wndINST     : HINST;
  wndClass    : TWndClassExW;
  wndClassName: PWideChar = 'ZenGL';
  wndStyle    : LongWord;
  wndCpnSize  : Integer;
  wndBrdSizeX : Integer;
  wndBrdSizeY : Integer;
  wndCaptionW : PWideChar;
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  zglView     : zglNSView;
  wndHandle   : zglNSWindow;
  viewNSRect  : NSRect;
//  pool      : NSAutoreleasePool;
  {$Else}
  wndHandle : WindowRef;
  wndAttr   : WindowAttributes;
  wndEvents : array[0..14] of EventTypeSpec;
  wndMouseIn: Boolean;
  {$ENDIF}{$EndIf}
  {$IFDEF iOS}
  wndHandle  : UIWindow;
  wndViewCtrl: UIViewController;
  wndPortrait: Boolean;
  {$ENDIF}

implementation
uses
  zgl_application,
  zgl_screen,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  zgl_opengl_all,
  zgl_pasOpenGL,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  {$IF DEFINED(UNIX) or DEFINED(WINDOWS) or DEFINED(iOS)}
  zgl_file,
  {$IFEND}
  zgl_timers,
  zgl_log,
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  zgl_touch,
  {$IFEND}
  zgl_mouse,
  zgl_keyboard,
  zgl_render,
  zgl_render_2d,
  zgl_resources,
  zgl_textures,
  zgl_render_target,
  zgl_font,
  zgl_text,
  {$IFDEF USE_SENGINE}
  zgl_sengine_2d,
  {$ENDIF}
  {$IFDEF USE_PARTICLES}
  zgl_particles_2d,
  {$ENDIF}
  {$IFDEF USE_SOUND}
  zgl_sound,
    {$IFDEF USE_OGG}
    zgl_lib_ogg,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF USE_VIDEO}
  zgl_video,
  {$IFDEF USE_THEORA}
  zgl_lib_theora,
  {$ENDIF}
  {$ENDIF}
  {$IfNDef OLD_METHODS}
  gegl_VElements,
  {$EndIf}
  zgl_utils;

{$IFNDEF FPC}
// Various versions of Delphi... sucks again
function LoadCursorW(hInstance: HINST; lpCursorName: PWideChar): HCURSOR; stdcall; external user32 name 'LoadCursorW';
{$ENDIF}

{$IfNDef USE_INIT_HANDLE}
{$IfDef MAC_COCOA}
procedure zglNSWindow.close;
begin
  winOn := false;
//  inherited;
end;

procedure zglNSWindow.resignMainWindow;
begin
  appPause := True;
  inherited resignMainWindow;
end;

procedure zglNSWindow.becomeMainWindow;
begin
  appPause := False;
  inherited becomeMainWindow;
end;

procedure zglNSView.windowWillClose(note: NSNotification);
begin
  winOn := False;
//  NSApp.terminate(nil);
end;

{$EndIf}

{$IFDEF USE_X11}
procedure wnd_SetHints(Initialized: Boolean = TRUE);
var
  sizehints: TXSizeHints;
begin
  FillChar(sizehints, SizeOf(TXSizeHints), 0);
  if wndFullScreen and Initialized Then
    sizehints.flags    := PBaseSize or PWinGravity
  else
    sizehints.flags    := PPosition or PSize or PMinSize or PMaxSize;
  sizehints.x          := wndX;
  sizehints.y          := wndY;
  sizehints.width      := wndWidth;
  sizehints.height     := wndHeight;
  sizehints.min_width  := wndWidth;
  sizehints.max_width  := wndWidth;
  sizehints.min_height := wndHeight;
  sizehints.max_height := wndHeight;
  XSetWMNormalHints(scrDisplay, wndHandle, @sizehints);
end;
{$ENDIF}
{$EndIf}

{$IfNDef ANDROID}
{$IFDEF WND_USE}
procedure wnd_Select;
begin
{$IFDEF USE_X11}
  XMapWindow(scrDisplay, wndHandle);
{$ENDIF}
{$IFDEF WINDOWS}
  BringWindowToTop(wndHandle);
{$ENDIF}
{$IFDEF MACOSX}{$IfNDef MAC_COCOA}
  SelectWindow(wndHandle);
  ShowWindow(wndHandle);
{$Else}
  if wndFullScreen Then
    wnd_SetPos(0, 0);
{$ENDIF}{$EndIf}
{$IFDEF iOS}
  wndHandle.makeKeyAndVisible();
{$ENDIF}
end;

function wnd_Create(): Boolean;
  {$IFDEF MACOSX}
  var
  {$IfDef MAC_COCOA}
    createFlags: LongWord = 0;
  {$Else}
    size  : MacOSAll.Rect;
    status: OSStatus;
  {$ENDIF}{$EndIf}
begin
  Result := TRUE;
  if wndHandle <> {$IFNDEF DARWIN} 0 {$ELSE} nil {$ENDIF} Then exit;

  Result    := FALSE;
  wndX      := 0;
  wndY      := 0;

{$IFNDEF ANDROID}
  {$IFNDEF IOS}
  if wndFullScreen then
    if (wndWidth <= 640) and (wndHeight <= 480) then
    begin
      wndWidth := 800;
      wndHeight := 600;
    end;
  {$ENDIF}
{$ENDIF}

  if (not wndFullScreen) and (appFlags and WND_USE_AUTOCENTER > 0) Then
  begin
    wndX := (zgl_Get(DESKTOP_WIDTH) - wndWidth) div 2;
    wndY := (zgl_Get(DESKTOP_HEIGHT) - wndHeight) div 2;
  end;

{$IFDEF USE_X11}
  FillChar(wndAttr, SizeOf(wndAttr), 0);
  wndAttr.colormap   := XCreateColormap(scrDisplay, wndRoot, oglVisualInfo.visual, AllocNone);
  wndAttr.event_mask := ExposureMask or FocusChangeMask or ButtonPressMask or ButtonReleaseMask or PointerMotionMask or
        KeyPressMask or KeyReleaseMask or StructureNotifyMask;
  wndValueMask       := CWColormap or CWEventMask or CWOverrideRedirect or CWBorderPixel or CWBackPixel;
  wndHandle          := XCreateWindow(scrDisplay, wndRoot, wndX, wndY, wndWidth, wndHeight, 0, oglVisualInfo.depth, InputOutput,
        oglVisualInfo.visual, wndValueMask, @wndAttr);

  if wndHandle = 0 Then
  begin
    u_Error('Cannot create window');
    exit;
  end;

  wnd_Select();

  wndClass.res_name  := 'ZenGL';
  wndClass.res_class := 'ZenGL Class';
  XSetClassHint(scrDisplay, wndHandle, @wndClass);
  wnd_SetHints(FALSE);

  wndDestroyAtom := XInternAtom(scrDisplay, 'WM_DELETE_WINDOW', FALSE);
  wndProtocols   := XInternAtom(scrDisplay, 'WM_PROTOCOLS', FALSE);
  XSetWMProtocols(scrDisplay, wndHandle, @wndDestroyAtom, 1);
{$ENDIF}
{$IFDEF WINDOWS}
  wndCpnSize  := GetSystemMetrics(SM_CYCAPTION);
  wndBrdSizeX := GetSystemMetrics(SM_CXDLGFRAME);
  wndBrdSizeY := GetSystemMetrics(SM_CYDLGFRAME);

  with wndClass do
  begin
    cbSize        := SizeOf(TWndClassExW);
    style         := CS_DBLCLKS or CS_OWNDC;
    lpfnWndProc   := @app_ProcessMessages;
    cbClsExtra    := 0;
    cbWndExtra    := 0;
    hInstance     := wndINST;
    hIcon         := LoadIconW  (wndINST, 'MAINICON');
    hIconSm       := 0;
    hCursor       := LoadCursorW(wndINST, PWideChar(IDC_ARROW));
    lpszMenuName  := nil;
    hbrBackGround := GetStockObject(BLACK_BRUSH);
    lpszClassName := wndClassName;
  end;

  if RegisterClassExW(wndClass) = 0 Then
  begin
    u_Error('Cannot register window class');
    exit;
  end;

  if wndFullScreen Then
    wndStyle := WS_POPUP or WS_VISIBLE or WS_SYSMENU
  else
    wndStyle := WS_CAPTION or WS_MINIMIZEBOX or WS_SYSMENU or WS_VISIBLE;
  {$IFNDEF USE_GLES}
  if oglFormat = 0 Then
    wndHandle := CreateWindowExW(WS_EX_TOOLWINDOW, wndClassName, wndCaptionW, WS_POPUP, 0, 0, 0, 0, 0, 0, 0, nil)
  else
  {$ENDIF}
    wndHandle := CreateWindowExW(WS_EX_APPWINDOW or WS_EX_TOPMOST * Byte(wndFullScreen), wndClassName, wndCaptionW, wndStyle, wndX, wndY,
                                  wndWidth  + (wndBrdSizeX * 2) * Byte(not wndFullScreen),
                                  wndHeight + (wndBrdSizeY * 2 + wndCpnSize) * Byte(not wndFullScreen), 0, 0, wndINST, nil);

  if wndHandle = 0 Then
  begin
    u_Error('Cannot create window');
    exit;
  end;

  wndDC := GetDC(wndHandle);
  if wndDC = 0 Then
  begin
    u_Error('Cannot get device context');
    exit;
  end;
  wnd_Select();
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  if wndFullScreen then
  begin
    viewNSRect.origin.x := 0;
    viewNSRect.origin.y := 0;
    viewNSRect.size.width := scrDesktopW;
    viewNSRect.size.height := scrDesktopH;
    createFlags := NSBorderlessWindowMask;
  end
  else begin
    viewNSRect.origin.x := wndX;
    viewNSRect.origin.y := wndY;
    viewNSRect.size.width := wndWidth;
    viewNSRect.size.height := wndHeight;
    createFlags := NSTitledWindowMask or NSClosableWindowMask;
  end;
  wndHandle := zglNSWindow.alloc;
  wndHandle.initWithContentRect_styleMask_backing_defer(viewNSRect, createFlags, NSBackingStoreBuffered, False).autorelease;

  // ???  zdes ili net
  zglView := zglNSView.alloc;
  zglView.initWithFrame(viewNSRect);
  wndHandle.setContentView(zglView);
  wndHandle.setDelegate(NSWindowDelegateProtocol(zglView));
  wndHandle.setAcceptsMouseMovedEvents(True);
  wndHandle.makeKeyAndOrderFront(nil);
{$Else}
  size.Left   := wndX;
  size.Top    := wndY;
  size.Right  := wndX + wndWidth;
  size.Bottom := wndY + wndHeight;
  wndAttr     := kWindowCloseBoxAttribute or kWindowCollapseBoxAttribute or kWindowStandardHandlerAttribute;// or kWindowCompositingAttribute;
  if wndFullScreen Then
    wndAttr := wndAttr or kWindowNoTitleBarAttribute;
  status      := CreateNewWindow(kDocumentWindowClass, wndAttr, size, wndHandle);

  if (status <> noErr) or (wndHandle = nil) Then
  begin
    u_Error('Cannot create window');
    exit;
  end;

  // Window
  wndEvents[0].eventClass := kEventClassWindow;
  wndEvents[0].eventKind  := kEventWindowClosed;
  wndEvents[1].eventClass := kEventClassWindow;
  wndEvents[1].eventKind  := kEventWindowActivated;
  wndEvents[2].eventClass := kEventClassWindow;
  wndEvents[2].eventKind  := kEventWindowDeactivated;
  wndEvents[3].eventClass := kEventClassWindow;
  wndEvents[3].eventKind  := kEventWindowCollapsed;
  wndEvents[4].eventClass := kEventClassWindow;
  wndEvents[4].eventKind  := kEventWindowBoundsChanged;
  // Keyboard
  wndEvents[5].eventClass := kEventClassKeyboard;
  wndEvents[5].eventKind  := kEventRawKeyDown;
  wndEvents[6].eventClass := kEventClassKeyboard;
  wndEvents[6].eventKind  := kEventRawKeyUp;
  wndEvents[7].eventClass := kEventClassKeyboard;
  wndEvents[7].eventKind  := kEventRawKeyRepeat;
  wndEvents[8].eventClass := kEventClassKeyboard;
  wndEvents[8].eventKind  := kEventRawKeyModifiersChanged;
  // Mouse
  wndEvents[9].eventClass  := kEventClassMouse;
  wndEvents[9].eventKind   := kEventMouseMoved;
  wndEvents[10].eventClass := kEventClassMouse;
  wndEvents[10].eventKind  := kEventMouseDown;
  wndEvents[11].eventClass := kEventClassMouse;
  wndEvents[11].eventKind  := kEventMouseUp;
  wndEvents[12].eventClass := kEventClassMouse;
  wndEvents[12].eventKind  := kEventMouseWheelMoved;
  wndEvents[13].eventClass := kEventClassMouse;
  wndEvents[13].eventKind  := kEventMouseDragged;
  // Command
  wndEvents[14].eventClass := kEventClassCommand;
  wndEvents[14].eventKind  := kEventProcessCommand;
  InstallEventHandler(GetApplicationEventTarget, NewEventHandlerUPP(@app_ProcessMessages), 15, @wndEvents[0], nil, nil);
  wnd_Select();
{$ENDIF}{$EndIf}
{$IFDEF iOS}
  // always fullscreen
  wndFullScreen := TRUE;

  UIApplication.sharedApplication.setStatusBarHidden(wndFullScreen);
  wndHandle := UIWindow.alloc().initWithFrame(UIScreen.mainScreen.bounds);
  wndViewCtrl := zglCiOSViewController.alloc().init();

  wnd_Select();
{$ENDIF}
  Result := TRUE;
end;

procedure wnd_Destroy;
begin
{$IFDEF USE_X11}
  XDestroyWindow(scrDisplay, wndHandle);
  XSync(scrDisplay, X_FALSE);
{$ENDIF}
{$IFDEF WINDOWS}
  if (wndDC > 0) and (ReleaseDC(wndHandle, wndDC) = 0) Then
  begin
    u_Error('Cannot release device context');
    wndDC := 0;
  end;

//  if wndFirst Then
  begin
    if (wndHandle <> 0) and (not DestroyWindow(wndHandle)) Then
    begin
      u_Error('Cannot destroy window');
      wndHandle := 0;
    end;

    if not UnRegisterClassW(wndClassName, wndINST) Then
    begin
      u_Error('Cannot unregister window class');
      wndINST := 0;
    end;
  end;
{$ENDIF}
{$IfDef MAC_COCOA}
  wndHandle.close;

{$Else}
{$IFDEF MACOSX}
  ReleaseWindow(wndHandle);
{$ENDIF}
  wndHandle := {$IFNDEF DARWIN} 0 {$ELSE} nil {$ENDIF};
{$EndIf}
end;
{$EndIf}

{$IfNDef USE_INIT_HANDLE}
procedure wnd_Update;
  {$IFDEF USE_X11}
  var
    event: TXEvent;
  {$ENDIF}
  {$IFDEF WINDOWS}
  var
    FullScreen: Boolean;
  {$ENDIF}
begin
{$IFDEF USE_X11}
  XSync(scrDisplay, X_TRUE);
  wnd_SetHints();

  FillChar(event, SizeOf(TXEvent), 0);
  event._type                := ClientMessage;
  event.xclient._type        := ClientMessage;
  event.xclient.send_event   := X_TRUE;
  event.xclient.window       := wndHandle;
  event.xclient.message_type := XInternAtom(scrDisplay, '_NET_WM_STATE', FALSE);
  event.xclient.format       := 32;
  event.xclient.data.l[0]  := Integer(wndFullScreen);
  event.xclient.data.l[1]  := XInternAtom(scrDisplay, '_NET_WM_STATE_FULLSCREEN', FALSE);
  XSendEvent(scrDisplay, wndRoot, False, SubstructureRedirectMask or SubstructureNotifyMask, @event);
{$ENDIF}
{$IFDEF WINDOWS}
  if appFocus Then
    FullScreen := wndFullScreen
  else
  begin
    FullScreen := FALSE;
    if (wndWidth >= zgl_Get(DESKTOP_WIDTH)) and (wndHeight >= zgl_Get(DESKTOP_HEIGHT)) Then
    begin
      ShowWindow(wndHandle, SW_MINIMIZE);
      exit;
    end;
  end;

  if FullScreen Then
    wndStyle := WS_POPUP or WS_VISIBLE or WS_SYSMENU
  else
    wndStyle := WS_CAPTION or WS_MINIMIZEBOX or WS_SYSMENU or WS_VISIBLE;

  SetWindowLongW(wndHandle, GWL_STYLE, LongInt(wndStyle));
  SetWindowLongW(wndHandle, GWL_EXSTYLE, WS_EX_APPWINDOW or WS_EX_TOPMOST * Byte(FullScreen));
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}

{$Else}
  if wndFullScreen Then
    ChangeWindowAttributes(wndHandle, kWindowNoTitleBarAttribute, kWindowResizableAttribute)
  else
    ChangeWindowAttributes(wndHandle, kWindowResizableAttribute, kWindowNoTitleBarAttribute);
  // Apple and their magic driving me crazy...
  ChangeWindowAttributes(wndHandle, 0, kWindowResizableAttribute);

  aglSetCurrentContext(oglContext);
{$ENDIF}{$EndIf}
{$IFDEF iOS}
  UIApplication.sharedApplication.setStatusBarHidden(wndFullScreen);
{$ENDIF}
//  winOn := TRUE;

  wnd_UpdateCaption();
  wndUpdateWin := False;


  if (not wndFullScreen) and (appFlags and WND_USE_AUTOCENTER > 0) Then
    wnd_SetPos((zgl_Get(DESKTOP_WIDTH) - wndWidth) div 2, (zgl_Get(DESKTOP_HEIGHT) - wndHeight) div 2);
  wnd_SetSize(wndWidth, wndHeight);
end;

procedure wnd_SetCaption(Caption: UTF8String);
begin
  if Caption = '' then
    wndCaption := cs_ZenGL
  else
    wndCaption := Caption;
  wndUpdateWin := true;;
end;

procedure wnd_UpdateCaption();
  {$IFDEF USE_X11}
  var
    err: Integer;
    str: PAnsiChar;
  {$ENDIF}
  {$IFDEF WINDOWS}
  var
    len: Integer;
  {$ENDIF}
  {$IFDEF MACOSX}
  var
    str: CFStringRef;
  {$ENDIF}
begin
{$IFDEF USE_X11}
  if wndHandle <> 0 Then
  begin
    str := utf8_GetPAnsiChar(wndCaption);
    err := Xutf8TextListToTextProperty(scrDisplay, @str, 1, XUTF8StringStyle, @wndTitle);

    if err = 0 Then
    begin
      XSetWMName(scrDisplay, wndHandle, @wndTitle);
      XSetWMIconName(scrDisplay, wndHandle, @wndTitle);
    end;
    FreeMem(str);
    XFree(wndTitle.value);
  end;
{$ENDIF}
{$IFDEF WINDOWS}
  if wndHandle <> 0 Then
  begin
    len := MultiByteToWideChar(CP_UTF8, 0, @wndCaption[1], Length(wndCaption), nil, 0);
    if Assigned(wndCaptionW) Then
      FreeMem(wndCaptionW);
    GetMem(wndCaptionW, len * 2 + 2);
    wndCaptionW[len] := #0;
    MultiByteToWideChar(CP_UTF8, 0, @wndCaption[1], Length(wndCaption), wndCaptionW, len);

    SetWindowTextW(wndHandle, wndCaptionW);
  end;
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  wndHandle.setTitle(NSSTR(wndCaption));
{$Else}
  if Assigned(wndHandle) Then
  begin
    str := CFStringCreateWithPascalString(nil, wndCaption, kCFStringEncodingUTF8);
    SetWindowTitleWithCFString(wndHandle, str);
    CFRelease(str);
    wnd_Select();
  end;
{$ENDIF}{$EndIf}
end;
{$EndIf}
{$EndIf}

procedure wnd_SetSize(Width, Height: Integer);
begin
  if (wndWidth <> Width) or (wndHeight <> Height) then
  begin
    wndWidth  := Width;
    wndHeight := Height;
    scrViewPort := True;
  end;
{$IfNDef USE_INIT_HANDLE}
  {$IFDEF USE_X11}
  if wndHandle <> 0 Then
  begin
    wnd_SetHints();
    XResizeWindow(scrDisplay, wndHandle, wndWidth, wndHeight);
  end;
  {$EndIf}
  {$IFDEF WINDOWS}
    wnd_SetPos(wndX, wndY);
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  viewNSRect.size.width := wndWidth;
  viewNSRect.size.height := wndHeight;
  {$Else}
  if Assigned(wndHandle) Then
    begin
      begin
        SizeWindow(wndHandle, wndWidth, wndHeight, TRUE);
        aglUpdateContext(oglContext);
        wnd_Select();
      end else
        wnd_SetPos(wndX, wndY);
    end;
  {$ENDIF}{$EndIf}
{$ENDIF}
{$IFDEF iOS}
  eglContext.renderbufferStorage_fromDrawable(GL_RENDERBUFFER, eglSurface);
{$ENDIF}
  oglWidth   := Width;
  oglHeight  := Height;
  oglTargetW := Width;
  oglTargetH := Height;
  if appFlags and CORRECT_RESOLUTION > 0 Then
    scr_CorrectResolution(scrResW, scrResH)
  else
    SetCurrentMode();
end;

procedure wnd_SetPos(X, Y: Integer);
  {$IFDEF MACOSX}
  var
    clipRgn: RgnHandle;
  {$ENDIF}
begin
  wndX := X;
  wndY := Y;
{$IfDef USE_INIT_HANDLE}
    {$IFDEF MACOSX}
    clipRgn := NewRgn();
    SetRectRgn(clipRgn, X, Y, X + wndWidth, Y + wndHeight);
    aglSetInteger(oglContext, AGL_CLIP_REGION, clipRgn);
    aglEnable(oglContext, AGL_CLIP_REGION);
    DisposeRgn(clipRgn);
    {$ENDIF}
    exit;
{$Else}

  {$IFDEF USE_X11}
  if wndHandle <> 0 Then
    if not wndFullScreen Then
      XMoveWindow(scrDisplay, wndHandle, X, Y)
    else
      XMoveWindow(scrDisplay, wndHandle, 0, 0);
  {$ENDIF}
  {$IFDEF WINDOWS}
  if wndHandle <> 0 Then
    if (not wndFullScreen) or (not appFocus) Then
      SetWindowPos(wndHandle, HWND_NOTOPMOST, wndX, wndY, wndWidth + (wndBrdSizeX * 2), wndHeight + (wndBrdSizeY * 2 + wndCpnSize), SWP_NOACTIVATE)
    else
      SetWindowPos(wndHandle, HWND_TOPMOST, 0, 0, wndWidth, wndHeight, SWP_NOACTIVATE);
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  viewNSRect.origin.x := wndX;
  viewNSRect.origin.y := wndY;
  {$Else}
  if Assigned(wndHandle) Then
    if not wndFullScreen Then
      MoveWindow(wndHandle, wndX, wndY, TRUE)
    else
      MoveWindow(wndHandle, 0, 0, TRUE);
  {$ENDIF}{$EndIf}
  {$IFDEF iOS}
  wndX := 0;
  wndY := 0;
  {$ENDIF}
{$EndIf}
  appFlags := appFlags and ($FFFFFFFF - WND_USE_AUTOCENTER);
end;

{$IfNDef USE_INIT_HANDLE}
procedure wnd_ShowCursor( Show : Boolean );
{$IFDEF USE_X11}
  var
    mask   : TPixmap;
    xcolor : TXColor;
begin
  appShowCursor := Show;

  if wndHandle = 0 Then exit;
  if Show Then
    begin
      if appCursor <> None Then
        begin
          XFreeCursor( scrDisplay, appCursor );
          appCursor := None;
          XDefineCursor( scrDisplay, wndHandle, appCursor );
        end;
    end else
      begin
        mask := XCreatePixmap( scrDisplay, wndRoot, 1, 1, 1 );
        FillChar( xcolor, SizeOf( xcolor ), 0 );
        appCursor := XCreatePixmapCursor( scrDisplay, mask, mask, @xcolor, @xcolor, 0, 0 );
        XDefineCursor( scrDisplay, wndHandle, appCursor );
      end;
{$ENDIF}
{$IF DEFINED(WINDOWS) or DEFINED(MACOSX) or DEFINED(iOS) or DEFINED(ANDROID)}
begin
  appShowCursor := Show;
{$IFEND}
end;
{$EndIf}

procedure InitSoundVideo;
begin
  {$IFDEF USE_OGG}
  if not InitVorbis() Then
    {$IFNDEF USE_OGG_STATIC}
    log_Add('Ogg: Error while loading libraries: ' + libogg + ', ' + libvorbis + ', ' + libvorbisfile)
    {$ENDIF}
  else
    log_Add('Ogg: Initialized');
  {$ENDIF}
  {$IFDEF USE_THEORA}
  if not InitTheora() Then
    {$IFNDEF USE_THEORA_STATIC}
    log_Add(('Theora: Error while loading library: ERROR Theora') + libtheoradec)
    {$ENDIF}
  else
    log_Add('Theora: Initialized');
  {$ENDIF}
end;

{$IfNDef USE_INIT_HANDLE}
procedure zgl_Init(FSAA: Byte = 0; StencilBits: Byte = 0);
begin
  {$IfNDef ANDROID}
//  scr_GetResList;
  zgl_GetSysDir();
  {$EndIf}

  scr_SetOptions;

  oglFSAA    := FSAA;
  oglStencil := StencilBits;

  {$IFDEF iOS}
  if not appPoolInitialized Then
  begin
    appPoolInitialized := TRUE;
    app_InitPool();
    ExitCode := UIApplicationMain(argc, argv, nil, utf8_GetNSString('zglCAppDelegate'));
    app_FreePool();
    exit;
  end;
  {$ENDIF}

  log_Init();

  {$IfNDef ANDROID}
  if not scr_Create() Then
    exit;
  {$EndIf}
  if not gl_Create() Then
    exit;
  {$IfNDef ANDROID}
  if not wnd_Create() Then
    exit;
  {$Else}
  wndX      := 0;
  wndY      := 0;
  {$EndIf}
  if not gl_Initialize() Then
  begin
    wnd_Destroy;
    exit;
  end;

  appInitialized := TRUE;

  InitSoundVideo();

  {$IFDEF USE_X11}
  wnd_ShowCursor(appShowCursor);
  {$ENDIF}
  {$IfNDef ANDROID}
  if wndCaption = '' then
    wndCaption := cs_ZenGL;
  wnd_UpdateCaption();
  {$EndIf}
  winOn := TRUE;

  {$IFDEF iOS}
  key_BeginReadText('');
  key_EndReadText();
  {$ENDIF}

  app_PInit();
  {$IFDEF iOS}
  if (UIDevice.currentDevice.systemVersion.floatValue() >= 3.1) Then
  begin
    scrDisplayLink := CADisplayLink.displayLinkWithTarget_selector(appDelegate, objcselector('MainLoop'));
    scrDisplayLink.setFrameInterval(1);
    scrDisplayLink.addToRunLoop_forMode(NSRunLoop.currentRunLoop(), NSDefaultRunLoopMode);
  end else
    NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(1 / 60, appDelegate, objcselector('MainLoop'), nil, TRUE);
  exit;
  {$ENDIF}
  {$IFDEF ANDROID}
  exit;
  {$Else}

  oldTimeDraw := timer_GetTicks;
  app_PLoop();
  zgl_Destroy();
  {$EndIf}
end;

{$Else}
procedure zgl_InitToHandle(Handle: Ptr; FSAA: Byte = 0; StencilBits: Byte = 0);
begin
  zgl_GetSysDir();
  log_Init();

  oglFSAA    := FSAA;
  oglStencil := StencilBits;

  if not scr_Create() Then exit;
  if not gl_Create() Then exit;
  {$IFDEF USE_X11}
  wndHandle := TWindow(Handle);

  // -----------------------------------------------
  wndAttr.colormap   := XCreateColormap(scrDisplay, wndRoot, oglVisualInfo.visual, AllocNone);
  wndAttr.event_mask := ExposureMask or FocusChangeMask or ButtonPressMask or ButtonReleaseMask or PointerMotionMask or
        KeyPressMask or KeyReleaseMask or StructureNotifyMask;
  // -----------------------------------------------
  {$ENDIF}
  {$IFDEF WINDOWS}
  wndHandle := HWND(Handle);
  wndDC     := GetDC(wndHandle);
  {$ENDIF}
  {$IFDEF MACOSX}
  wndHandle := WindowRef(Handle);
  {$ENDIF}

  if not gl_Initialize() Then exit;


  InitSoundVideo();

  winOn := TRUE;

  app_PInit();
end;
{$EndIf}

procedure zgl_Destroy;
  var
    i: Integer;
    p: Pointer;
begin
  {$IfDef USE_MENUGUI}
  app_TouchMenu := nil;
  app_UseMenuDown := nil;
  app_UseMenuUp := nil;
  app_DrawGui := nil;
  {$EndIf}

  if appWorkTime <> 0 Then
    log_Add('Average FPS: ' + u_IntToStr(Round(appFPSAll / appWorkTime)));

  if Assigned(app_PExit) Then
    app_PExit();
  res_Free();

  {$IfNDef OLD_METHODS}
  if managerSetOfTools.count > 0 then
  begin
    log_Add('Destroy GE-Elements: ' + u_IntToStr(managerSetOfTools.count));
    DestroyManagerSOT();
  end;
  {$EndIf}

  if managerTimer.Count <> 0 Then
    log_Add('Timers to free: ' + u_IntToStr(managerTimer.Count));
  timers_Destroy;

  if managerFont.Count <> 0 Then
    log_Add('Fonts to free: ' + u_IntToStr(managerFont.Count));
  allFont_Destroy;

  if managerRTarget.Count <> 0 Then
    log_Add('Render Targets to free: ' + u_IntToStr(managerRTarget.Count))
  else
    log_Add('Render Targets not free!!!' );
  while managerRTarget.Count > 0 do
    begin
      p := managerRTarget.First.next;
      {$IfNDef MAC_COCOA}
      rtarget_Del(zglPRenderTarget(p));
      {$EndIf}
    end;

  managerZeroTexture := nil;
  if managerTexture.Count.Items <> 0 Then
    log_Add('Textures to free: ' + u_IntToStr(managerTexture.Count.Items));
  while managerTexture.Count.Items > 0 do
    begin
      p := managerTexture.First.next;
      tex_Del(zglPTexture(p));
    end;

  {$IFDEF USE_SENGINE}
  sengine2d_Set(nil);
  sengine2d_ClearAll();
  {$ENDIF}

  {$IFDEF USE_PARTICLES}
  if managerEmitter2D.Count <> 0 Then
    log_Add('Emitters2D to free: ' + u_IntToStr(managerEmitter2D.Count));
  for i := 0 to managerEmitter2D.Count - 1 do
    emitter2d_Free(managerEmitter2D.List[i]);
  SetLength(managerEmitter2D.List, 0);
  pengine2d_Set(nil);
  pengine2d_ClearAll();
  {$ENDIF}

  {$IFDEF USE_SOUND}
  snd_Free();
  {$ENDIF}

  {$IFDEF USE_VIDEO}
  if managerVideo.Count.Items <> 0 Then
    log_Add('Videos to free: ' + u_IntToStr(managerVideo.Count.Items));
  while managerVideo.Count.Items > 0 do
    begin
      p := managerVideo.First.next;
      video_Del(zglPVideoStream(p));
    end;
  {$ENDIF}

  {$IfNDef ANDROID}
  scr_Destroy();
  {$Else}
  {$EndIf}
  {$IfNDef MAC_COCOA}
  gl_Destroy();
  {$EndIf}

  {$IFDEF USE_OGG}
  FreeVorbis();
  {$ENDIF}
  {$IFDEF USE_THEORA}
  FreeTheora();
  {$ENDIF}

  appInitialized := FALSE;

  log_Add('End');
  log_Close();
  {$IfNDef ANDROID}
  {$IfNDef USE_INIT_HANDLE}
  wnd_Destroy();
  {$EndIf}
  {$EndIf}
end;

procedure zgl_Exit;
begin
  winOn := FALSE;
end;

procedure zgl_Reg(What: LongWord; UserData: Pointer);
var
  i: Integer;
begin
  case What of
    // Callback
    SYS_APP_INIT:
      begin
        app_PInit := UserData;
        if not Assigned(UserData) Then
          app_PInit := @app_Init;
      end;
    {$IfNDef ANDROID}
    SYS_APP_LOOP:
      begin
        app_PLoop := UserData;
        if not Assigned(UserData) Then
          app_PLoop := @app_MainLoop;
      end;
    {$EndIf}
    SYS_LOAD:
      begin
        app_PLoad := UserData;
      end;
    SYS_DRAW:
      begin
        app_PDraw := UserData;
      end;
    SYS_UPDATE:
      begin
        app_PUpdate := UserData;
      end;
    SYS_EXIT:
      begin
        app_PExit := UserData;
      end;
    SYS_ACTIVATE:
      begin
        app_PActivate := UserData;
      end;
    {$IfNDef USE_INIT_HANDLE}
    SYS_EVENTS: app_PEvents := UserData;
    {$EndIf}
    SYS_POSTDRAW: app_PostPDraw := UserData;
    SYS_RESET: app_PReset := UserData;
    {$IFDEF iOS}
    SYS_iOS_MEMORY_WARNING:
      begin
        app_PMemoryWarn := UserData;
      end;
    SYS_iOS_CHANGE_ORIENTATION:
      begin
        app_POrientation := UserData;
      end;
    {$ENDIF}
    {$IFDEF ANDROID}
    SYS_ANDROID_RESTORE:
      begin
        app_PRestore := UserData;
      end;
    {$ENDIF}
    // Input events          delete

    // Textures
    TEXTURE_FORMAT_EXTENSION:
      begin
        SetLength(managerTexture.Formats, managerTexture.Count.Formats + 1);
        managerTexture.Formats[managerTexture.Count.Formats].Extension := u_StrUp(PAnsiChar(UserData));
      end;
    TEXTURE_FORMAT_FILE_LOADER:
      begin
        managerTexture.Formats[managerTexture.Count.Formats].FileLoader := UserData;
      end;
    TEXTURE_FORMAT_MEM_LOADER:
      begin
        managerTexture.Formats[managerTexture.Count.Formats].MemLoader := UserData;
        INC(managerTexture.Count.Formats);
      end;
    TEXTURE_CURRENT_EFFECT:
      begin
        tex_CalcCustomEffect := UserData;
      end;
    // Sound
    {$IFDEF USE_SOUND}
    SND_FORMAT_EXTENSION:
      begin
        SetLength(managerSound.Formats, managerSound.Count.Formats + 1);
        managerSound.Formats[managerSound.Count.Formats].Extension := u_StrUp(PAnsiChar(UserData));
        managerSound.Formats[managerSound.Count.Formats].Decoder   := nil;
      end;
    SND_FORMAT_FILE_LOADER:
      begin
        managerSound.Formats[managerSound.Count.Formats].FileLoader := UserData;
      end;
    SND_FORMAT_MEM_LOADER:
      begin
        managerSound.Formats[ managerSound.Count.Formats].MemLoader := UserData;
        INC(managerSound.Count.Formats);
      end;
    SND_FORMAT_DECODER:
      begin
        for i := 0 to managerSound.Count.Formats - 1 do
          if managerSound.Formats[i].Extension = zglPSoundDecoder(UserData).Ext Then
            managerSound.Formats[i].Decoder := UserData;
      end;
    {$ENDIF}
    // Video
    {$IFDEF USE_VIDEO}
    VIDEO_FORMAT_DECODER:
      begin
        SetLength(managerVideo.Decoders, managerVideo.Count.Decoders + 1);
        managerVideo.Decoders[managerVideo.Count.Decoders] := UserData;
        INC(managerVideo.Count.Decoders);
      end;
    {$ENDIF}

  end;
end;

function zgl_Get(What: LongWord): Ptr;
begin
  Result := 0;

  {$IfNDef ANDROID}
  if (not appGotSysDirs) and ((What = DIRECTORY_APPLICATION) or (What = DIRECTORY_HOME)) Then
    zgl_GetSysDir();

  if (not scrInitialized) and ((What = DESKTOP_WIDTH) or (What = DESKTOP_HEIGHT) or (What = RESOLUTION_LIST)) Then
    scr_Init();
  {$EndIf}

  case What of
    ZENGL_VERSION: Result := cv_major shl 16 + cv_minor shl 8 + cv_revision;
    ZENGL_VERSION_STRING: Result := Ptr(PAnsiChar(cs_ZenGL));
    ZENGL_VERSION_DATE: Result := Ptr(PAnsiChar(cs_Date));

    DIRECTORY_APPLICATION: Result := Ptr(PAnsiChar(appWorkDir));
    DIRECTORY_HOME: Result := Ptr(PAnsiChar(appHomeDir));

    LOG_FILENAME:
      if not winOn Then
        Result := Ptr(@logfile);

    DESKTOP_WIDTH:
    {$IFDEF USE_X11}
      Result := PXRRScreenSize(scrModeList + scrDesktop).width;
    {$ENDIF}
    {$IFDEF WINDOWS}
      Result := scrDesktop.dmPelsWidth;
    {$ENDIF}
    {$IF DEFINED(DARWIN) or DEFINED(ANDROID)}
      Result := scrDesktopW;
    {$IFEND}
    DESKTOP_HEIGHT:
    {$IFDEF USE_X11}
      Result := PXRRScreenSize(scrModeList + scrDesktop).height;
    {$ENDIF}
    {$IFDEF WINDOWS}
      Result := scrDesktop.dmPelsHeight;
    {$ENDIF}
    {$IF DEFINED(DARWIN) or DEFINED(ANDROID)}
      Result := scrDesktopH;
    {$IFEND}
    {$IfNDef ANDROID}
    RESOLUTION_LIST: Result := Ptr(@scrResList);

    {$IFNDEF iOS}
    WINDOW_HANDLE: Result := Ptr(wndHandle);
    {$ENDIF}
    {$EndIf}
    WINDOW_X: Result := Ptr(wndX);
    WINDOW_Y: Result := Ptr(wndY);
    WINDOW_WIDTH: Result := Ptr(wndWidth);
    WINDOW_HEIGHT: Result := Ptr(wndHeight);

    {$IFNDEF NO_EGL}
    GAPI_CONTEXT: Result := Ptr(oglContext);
    {$ENDIF}
    GAPI_MAX_TEXTURE_SIZE: Result := oglMaxTexSize;
    GAPI_MAX_TEXTURE_UNITS: Result := oglMaxTexUnits;
    GAPI_MAX_ANISOTROPY: Result := oglMaxAnisotropy;
    GAPI_CAN_BLEND_SEPARATE: Result := Ptr(oglSeparate);
    GAPI_CAN_AUTOGEN_MIPMAP: Result := Ptr(GL_SGIS_generate_mipmap);

    RENDER_FPS: Result := appFPS;
    RENDER_BATCHES_2D: Result := b2dBatches + 1;
    RENDER_CURRENT_MODE: Result := oglMode;
    RENDER_CURRENT_TARGET: Result := oglTarget;
    RENDER_VRAM_USED: Result := oglVRAMUsed;

    VIEWPORT_WIDTH: Result := oglWidth - scrSubCX;
    VIEWPORT_HEIGHT: Result := oglHeight - scrSubCY;
    VIEWPORT_OFFSET_X: Result := scrAddCX;
    VIEWPORT_OFFSET_Y: Result := scrAddCY;

    // Managers
    MANAGER_TIMER:     Result := Ptr(@managerTimer);
    MANAGER_TEXTURE:   Result := Ptr(@managerTexture);
    MANAGER_FONT:      Result := Ptr(@managerFont);
    MANAGER_RTARGET:   Result := Ptr(@managerRTarget);
    {$IFDEF USE_SOUND}
    MANAGER_SOUND:     Result := Ptr(@managerSound);
    {$ENDIF}
    {$IFDEF USE_PARTICLES}
    MANAGER_EMITTER2D: Result := Ptr(@managerEmitter2D);
    {$ENDIF}
  end;
end;

{$IfNDef ANDROID}
procedure zgl_GetSysDir;
{$IFDEF WINDOWS}
const
    APPDATA: PWideChar = 'APPDATA';         // workaround for Delphi 7
  var
    fn : PWideChar;
    len: Integer;
{$ENDIF}
{$IFDEF MACOSX}
  var
    appBundle  : CFBundleRef;
    appCFURLRef: CFURLRef;
    appCFString: CFStringRef;
    appPath    : array[0..8191] of AnsiChar;
{$ENDIF}
begin
{$IFDEF LINUX}
  appWorkDir := utf8_Copy(GetCurrentDir);
  appHomeDir := GetEnvironmentVariable('XDG_CONFIG_HOME');
  if appHomeDir = '' Then
    appHomeDir :=  GetEnvironmentVariable('HOME') + '/.config/'
  else
    appHomeDir := appHomeDir + '/';
  // for some old distros
  if not file_Exists(appHomeDir) Then
    file_MakeDir(appHomeDir);
{$ENDIF}
{$IFDEF WINDOWS}
  wndINST := GetModuleHandle(nil);
  GetMem(fn, 32768 * 2);
  GetModuleFileNameW(wndINST, fn, 32768);
  len := WideCharToMultiByte(CP_UTF8, 0, fn, 32768, nil, 0, nil, nil);
  SetLength(appWorkDir, len);
  WideCharToMultiByte(CP_UTF8, 0, fn, 32768, @appWorkDir[1], len, nil, nil);
  appWorkDir := file_GetDirectory(appWorkDir);
  FreeMem(fn);

  GetMem(fn, 32768 * 2);
  len := GetEnvironmentVariableW(APPDATA, fn, 32768);
  len := WideCharToMultiByte(CP_UTF8, 0, fn, len, nil, 0, nil, nil);
  SetLength(appHomeDir, len + 1);
  WideCharToMultiByte(CP_UTF8, 0, fn, 32768, @appHomeDir[1], len, nil, nil);
  appHomeDir[len + 1] := '\';
  FreeMem(fn);
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  appWorkDir := ExtractFileDir(ParamStr(0));
  appLogDir := file_GetDirectory(appWorkDir);
  appWorkDir := appLogDir + utf8_Copy('Resources/');
  appLogDir := copy(appLogDir, 0, Length(appLogDir) - 1);
  appLogDir := file_GetDirectory(appLogDir);
  appLogDir := copy(appLogDir, 0, Length(appLogDir) - 1);
  appLogDir := file_GetDirectory(appLogDir);
  appHomeDir  := FpGetEnv('HOME') + '/Library/Preferences/';
{$Else}
  appBundle   := CFBundleGetMainBundle();
  appCFURLRef := CFBundleCopyBundleURL(appBundle);
  appCFString := CFURLCopyFileSystemPath(appCFURLRef, kCFURLPOSIXPathStyle);
  CFStringGetFileSystemRepresentation(appCFString, @appPath[0], 8192);
  appWorkDir  := appPath + '/Contents/Resources/';
  appHomeDir  := FpGetEnv('HOME') + '/Library/Preferences/';
{$ENDIF}{$EndIf}
{$IFDEF iOS}
  appWorkDir := file_GetDirectory(ParamStr(0));
  appHomeDir := FpGetEnv('HOME') + '/Documents/';
  if not file_Exists(appHomeDir) Then
    file_MakeDir(appHomeDir);
{$ENDIF}
  file_SetPath(appWorkDir);
  appGotSysDirs := TRUE;
end;
{$EndIf}

procedure zgl_GetMem(out Mem: Pointer; Size: LongWord);
begin
  if Size > 0 Then
  begin
    GetMem(Mem, Size);
    FillChar(Mem^, Size, 0);
  end else
    Mem := nil;
end;

procedure zgl_FreeMem(var Mem: Pointer);
begin
  FreeMem(Mem);
  Mem := nil;
end;

procedure zgl_FreeStrList(var List: zglTStringList);
  var
    i: Integer;
begin
  for i := 0 to List.Count - 1 do
    List.Items[i] := '';
  List.Count := 0;
  SetLength(List.Items, 0);
end;

procedure zgl_Enable(What: LongWord);
begin
  appFlags := appFlags or What;

  if What and DEPTH_BUFFER > 0 Then
  begin
    glEnable(GL_DEPTH_TEST);
    appFlags := appFlags or DEPTH_BUFFER_CLEAR;
  end;

  if What and DEPTH_MASK > 0 Then
    glDepthMask(GL_TRUE);

  if What and CORRECT_RESOLUTION > 0 Then
    appFlags := appFlags or CORRECT_WIDTH or CORRECT_HEIGHT;

  if What and APP_USE_AUTOPAUSE > 0 Then
    appAutoPause := TRUE;

  if What and APP_USE_LOG > 0 Then
    appLog := TRUE;

  {$IFDEF USE_SOUND}
  if What and SND_CAN_PLAY > 0 Then
    sndCanPlay := TRUE;

  if What and SND_CAN_PLAY_FILE > 0 Then
    sndCanPlayFile := TRUE;
  {$ENDIF}

  if What and CLIP_INVISIBLE > 0 Then
    render2dClip := TRUE;


  if What and XY_IN_CENTER_WINDOW > 0 then
    appFlags := appFlags or XY_IN_CENTER_WINDOW;
{$IFDEF iOS}
  if What and SND_ALLOW_BACKGROUND_MUSIC > 0 Then
    begin
      sndAllowBackgroundMusic := 1;
      if sndInitialized Then
        AudioSessionSetProperty(LongWord(kAudioSessionProperty_OverrideCategoryMixWithOthers), SizeOf(sndAllowBackgroundMusic), @sndAllowBackgroundMusic);
    end;
{$ENDIF}
end;

procedure zgl_Disable(What: LongWord);
begin
  if appFlags and What > 0 Then
    appFlags := appFlags xor What;

  if What and DEPTH_BUFFER > 0 Then
  begin
    glDisable(GL_DEPTH_TEST);
    appFlags := appFlags and ($FFFFFFFF - DEPTH_BUFFER_CLEAR);
  end;

  if What and DEPTH_MASK > 0 Then
    glDepthMask(GL_FALSE);

  if What and CORRECT_RESOLUTION > 0 Then
  begin
    scrResCX := 1;
    scrResCY := 1;
    scrAddCX := 0;
    scrAddCY := 0;
    scrSubCX := 0;
    scrSubCY := 0;
  end;

  if What and APP_USE_AUTOPAUSE > 0 Then
    appAutoPause := FALSE;

  if What and APP_USE_LOG > 0 Then
    appLog := FALSE;

  {$IFDEF USE_SOUND}
  if What and SND_CAN_PLAY > 0 Then
    sndCanPlay := FALSE;

  if What and SND_CAN_PLAY_FILE > 0 Then
    sndCanPlayFile := FALSE;
  {$ENDIF}

  if What and CLIP_INVISIBLE > 0 Then
    render2dClip := FALSE;

  if What and XY_IN_CENTER_WINDOW > 0 then
    appFlags := appFlags and ($FFFFFFFF - XY_IN_CENTER_WINDOW);

{$IFDEF iOS}
  if What and SND_ALLOW_BACKGROUND_MUSIC > 0 Then
    begin
      sndAllowBackgroundMusic := 0;
      if sndInitialized Then
        AudioSessionSetProperty(LongWord(kAudioSessionProperty_OverrideCategoryMixWithOthers), SizeOf(sndAllowBackgroundMusic), @sndAllowBackgroundMusic);
    end;
{$ENDIF}
end;

{$IfNDef USE_INIT_HANDLE}
procedure zgl_SetEventsInterval(Interval: Cardinal);
begin
  appEventsTime := Interval;
end;
{$EndIf}

procedure zgl_SetParam(width, height: Integer; FullScreen, Vsync: Boolean);
begin
  if (wndWidth <> width) or (wndHeight <> height) or (wndFullScreen <> FullScreen) then
    scrViewPort := true;
  wndWidth := Width;
  wndHeight := Height;
  wndFullScreen := FullScreen;
  scrVSync := VSync;
end;

initialization
  wndCaption := cs_ZenGL;

{$IFDEF WINDOWS}
finalization
  FreeMem(wndCaptionW);
{$ENDIF}

end.
