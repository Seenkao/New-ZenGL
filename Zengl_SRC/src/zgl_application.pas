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

 !!! modification from Serge 16.07.2021
}
unit zgl_application;

{$I zgl_config.cfg}
{$IF defined(iOS) or defined(MAC_COCOA)}
  {$modeswitch objectivec1}
{$IfEnd}

interface
uses
  {$IFDEF USE_X11}
  X, XLib, XRandr
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows, Messages
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  CocoaAll,
  {$EndIf}
  MacOSAll
  {$ENDIF}
  {$IFDEF iOS}
  iPhoneAll, CFRunLoop, CGGeometry, CFBase, CFString
  {$ENDIF}
  {$IFDEF ANDROID}
  jni,
  zgl_threads
  {$ENDIF}
  ;

procedure app_Init;

{$IfNDef ANDROID}
procedure app_MainLoop;
procedure app_ProcessOS;
{$EndIf}
{$IfDef USE_VKEYBOARD}
procedure app_VirtualKeyboard;
{$EndIf}

{$IFDEF WINDOWS}
function app_ProcessMessages(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
{$ENDIF}
{$IfNDef USE_INIT_HANDLE}
{$IFDEF LINUX}
function app_ProcessMessages: LongWord;
{$ENDIF}
{$IFDEF MACOSX}
function app_ProcessMessages({$IfNDef MAC_COCOA}inHandlerCallRef: EventHandlerCallRef; inEvent: EventRef; inUserData: UnivPtr{$EndIf}): OSStatus; cdecl;
{$ENDIF}
{$Else}
procedure app_Draw;
{$EndIf}
{$IFDEF iOS}
procedure app_InitPool;
procedure app_FreePool;

type
  zglCAppDelegate = objcclass(NSObject)
    procedure EnterMainLoop; message 'EnterMainLoop';
    procedure MainLoop; message 'MainLoop';
    procedure applicationDidFinishLaunching(application: UIApplication); message 'applicationDidFinishLaunching:';
    procedure applicationWillResignActive(application: UIApplication); message 'applicationWillResignActive:';
    procedure applicationDidEnterBackground(application: UIApplication); message 'applicationDidEnterBackground:';
    procedure applicationWillTerminate(application: UIApplication); message 'applicationWillTerminate:';
    procedure applicationWillEnterForeground(application: UIApplication); message 'applicationWillEnterForeground:';
    procedure applicationDidBecomeActive(application: UIApplication); message 'applicationDidBecomeActive:';
    procedure applicationDidReceiveMemoryWarning(application: UIApplication); message 'applicationDidReceiveMemoryWarning:';

    // TextField
    function textFieldShouldBeginEditing(textField: UITextField): Boolean; message 'textFieldShouldBeginEditing:';
    function textField_shouldChangeCharactersInRange_replacementString(textField: UITextField; range: NSRange; string_: NSString): Boolean; message 'textField:shouldChangeCharactersInRange:replacementString:';
    function textFieldShouldReturn(textField: UITextField): Boolean; message 'textFieldShouldReturn:';
    function textFieldDidEndEditing(textField: UITextField): Boolean; message 'textFieldDidEndEditing:';
    procedure textFieldEditingChanged; message 'textFieldEditingChanged';
  end;

type
  zglCiOSViewController = objcclass(UIViewController)
  public
    function shouldAutorotateToInterfaceOrientation(interfaceOrientation: UIInterfaceOrientation): Boolean; override;
    procedure didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation); override;
    function supportedInterfaceOrientations: LongWord; message 'supportedInterfaceOrientations';
    function shouldAutorotate: Boolean; message 'shouldAutorotate';
  end;

type
  zglCiOSEAGLView = objcclass(UIView)
  protected
    procedure UpdateTouch(ID: Integer); message 'UpdateTouch:';
  public
    class function layerClass: Pobjc_class; override;

    procedure touchesBegan_withEvent(touches: NSSet; event: UIevent); override;
    procedure touchesMoved_withEvent(touches: NSSet; event: UIevent); override;
    procedure touchesEnded_withEvent(touches: NSSet; event: UIevent); override;
    procedure touchesCancelled_withEvent(touches: NSSet; event: UIevent); override;
    procedure didMoveToSuperview; override;
  end;
{$ENDIF}
{$IFDEF ANDROID}
function  JNI_OnLoad(vm: PJavaVM; reserved: Pointer): jint; cdecl;
function  JNI_OnUnload(vm: PJavaVM; reserved: Pointer): jint; cdecl;
procedure Java_zengl_android_ZenGL_zglNativeInit(env: PJNIEnv; thiz: jobject; AppDirectory, HomeDirectory: jstring); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeDestroy(env: PJNIEnv; thiz: jobject); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeSurfaceCreated(env: PJNIEnv; thiz: jobject); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeSurfaceChanged(env: PJNIEnv; thiz: jobject; Width, Height: jint); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeDrawFrame(env: PJNIEnv; thiz: jobject); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeActivate(env: PJNIEnv; thiz: jobject; Activate: jboolean); cdecl;

procedure Java_zengl_android_ZenGL_zglNativeCloseQuery(env: PJNIEnv; thiz: jobject);

procedure Java_zengl_android_ZenGL_zglNativeTouch(env: PJNIEnv; thiz: jobject; ID: jint; X, Y, Pressure: jfloat); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeInputText(env: PJNIEnv; thiz: jobject; text: jstring); cdecl;
procedure Java_zengl_android_ZenGL_zglNativeBackspace(env: PJNIEnv; thiz: jobject); cdecl;
function Java_zengl_android_ZenGL_bArrPasToJava(env: PJNIEnv; thiz: jobject): jByteArray; cdecl;         
procedure Java_zengl_android_ZenGL_bArrJavaToPas(env: PJNIEnv; thiz: jobject; arr: jbyteArray); cdecl;  
{$ENDIF}

var
  // to flags???
  appInitialized   : Boolean;
  appGotSysDirs    : Boolean;
  winOn            : Boolean = false;
  appWorkTime      : LongWord;
  appPause         : Boolean;
  appAutoPause     : Boolean = TRUE;
  appFocus         : Boolean = TRUE;
  appLog           : Boolean;
  appWorkDir       : UTF8String;
  appHomeDir       : UTF8String;
  {$IfDef MAC_COCOA}
  appLogDir        : UTF8String;
  {$EndIf}

  // call-back
  app_PInit      : procedure;
  {$IfNDef ANDROID}
  app_PLoop      : procedure;
  {$EndIf}

  app_PLoad      : procedure;
  app_PDraw      : procedure;
  app_PExit      : procedure;
  app_PUpdate    : procedure(dt: Double);
  app_PActivate  : procedure(activate: Boolean);
  app_PEvents    : procedure;

  app_PostPDraw  : procedure;

  {$IFDEF iOS}
  app_PMemoryWarn : procedure;
  app_POrientation: procedure(orientation: UIInterfaceOrientation);
  {$ENDIF}
  {$IFDEF ANDROID}
  app_PRestore: procedure;
  {$ENDIF}

  {$IfDef USE_VKEYBOARD}
  app_TouchMenu: procedure;
  app_UseMenuDown: procedure;
  app_UseMenuUp: procedure;
  app_DrawGui: procedure;

  MenuChange: Byte = 0;
  VisibleMenuChange: Boolean = true;
  MaxNumMenu: Byte = 4;
  {$EndIf}

  {$IFDEF USE_X11}
  appCursor: TCursor = None;
  appXIM   : PXIM;
  appXIC   : PXIC;
  {$ENDIF}
  {$IFDEF WINDOWS}
  appTimer    : LongWord;
  appMinimized: Boolean;
  {$ENDIF}
  {$IFDEF iOS}
threadvar
  appPool           : NSAutoreleasePool;
  appPoolInitialized: Boolean;
var
  appDelegate       : zglCAppDelegate;
  {$ENDIF}
  {$IFDEF ANDROID}
const
  NativeInit = 1;
  NativeSurfaceCreated = 2;
  NativeSurfaceChanged = 3;
  NativeActivate = 4;
  NativeBackspace = 5;

var
  appEnv         : PJNIEnv;
  appClass       : JClass;
  appObject      : JObject;
  appFinish      : JMethodID;
  appSwapBuffers : JMethodID;
  appShowKeyboard: JMethodID;
  appHideKeyboard: JMethodID;
  appLock        : zglTCriticalSection;
  MyByteArray: array of byte;

  //appIsLibrary   : Byte public name 'TC_SYSTEM_ISLIBRARY'; // workaround for the latest revisions of FreePascal 2.6.x
  {$ENDIF}

  appShowCursor: Boolean = true;

  appdt: Double;

  appFPS     : LongWord;
  appFPSCount: LongWord;
  appFPSAll  : LongWord;
  timeCalcFPS: Byte;

  appFlags   : LongWord;

  {$IfNDef USE_INIT_HANDLE}
  newTimeDraw, oldTimeDraw: Double;
  useFPS: Byte = 30;
  maxFPS: Single = 1000 / 30;
  timeAppEvents: Byte;
  appEventsTime: Cardinal = 8;
  {$EndIf}

implementation
uses
  zgl_screen,
  zgl_window,
  zgl_file,
  {$IFNDEF USE_GLES}
  zgl_opengl,
  {$ELSE}
  zgl_opengles,
  {$ENDIF}
  zgl_render,
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  zgl_touch,
  {$IFEND}
  zgl_mouse,
  zgl_keyboard,
  {$IFDEF USE_JOYSTICK}
  zgl_joystick,
  {$ENDIF}
  zgl_timers,
  zgl_resources,
  zgl_textures,
  zgl_log,
  {$IFDEF USE_SOUND}
  zgl_sound,
  {$ENDIF}
  {$IfNDef OLD_METHODS}
  gegl_VElements,
  gegl_drawElement,
  gegl_Types,
  {$EndIf}
  {$IfDef USE_VKEYBOARD}
  gegl_menu_gui,
  {$EndIf}
  zgl_utils;

procedure app_Draw;
var
  i: Word;
begin
  if scrViewPort then
    SetCurrentMode();
  scr_Clear();
  if Assigned(app_PDraw) Then
  begin
    app_PDraw();
    {$IfNDef OLD_METHODS}
    if managerSetOfTools.count > 0 then
      for i := 0 to managerSetOfTools.count - 1 do
      begin
        if managerSetOfTools.propElement[i].Element = _Edit then
          EditDraw(i);
      end;
    {$EndIf}
    {$IfDef USE_VKEYBOARD}
    if VisibleMenuChange then
      if Assigned(app_DrawGui) then
        app_DrawGui;
    {$EndIf}
  end;

  {$IFNDEF ANDROID}
  scr_Flush();
  {$ENDIF}
  if not appPause Then
    INC(appFPSCount);

  if Assigned(app_PostPDraw) then
    app_PostPDraw;
end;

procedure app_CalcFPS;
begin
  appFPS      := appFPSCount;
  appFPSAll   := appFPSAll + appFPSCount;
  appFPSCount := 0;
  INC(appWorkTime);
end;

{$IfNDef USE_INIT_HANDLE}
procedure app_Events;
var
  i: Word;
begin
  if keysDown[K_F12] then
  begin
    keybFlags := keybFlags or keyboardLatRusDown;
  end;
  if keysUp[K_F12] then
  begin
    keybFlags := keybFlags and ($FFFFFFFF - keyboardLatRusDown) xor keyboardLatinRus;
  end;
  {$IfDef USE_VKEYBOARD}
  if keysUp[K_F2] then
  begin
    if MenuChange = 3 then
    begin
      SetMenuProcess(4);
      MenuChange := 4;
      keybFlags := keybFlags or keyboardSymbol;
    end
    else begin
      SetMenuProcess(3);
      MenuChange := 3;
      keybFlags := keybFlags xor keyboardSymbol;
    end;
  end;
  {$EndIf}

  if Assigned(app_PEvents) then
    app_PEvents;

  {$IfDef USE_EXIT_ESCAPE}
  if keysDown[K_ESCAPE] = True then
  begin
    winOn := False;
    log_Add('Terminate program');
  end;
  {$EndIf}

  {$IfNDef OLD_METHODS}
  if managerSetOfTools.count > 0 then
    for i := 0 to managerSetOfTools.count - 1 do
    begin
      if managerSetOfTools.propElement[i].Element = _Edit then
        EventsEdit(i);
      if managerSetOfTools.propElement[i].Element = _Memo then
        ;
    end;
  {$EndIf}

  key_ClearState;
  mouse_ClearState;
  {$IFDEF USE_JOYSTICK}
  joy_ClearState;
  {$EndIf}
  {$If (defined(ANDROID) or defined(iOS))}
  touch_ClearState;
  {$IfEnd}
end;
{$EndIf}

procedure app_Init;
begin
  managerZeroTexture := tex_CreateZero(4, 4, $FFFFFFFF, TEX_DEFAULT_2D);
  managerSetOfTools.count := 0;
  managerSetOfTools.maxPossibleEl := 0;
  managerSetOfTools.ActiveElement := 65535;
  if scrViewPort then
    SetCurrentMode();
  scr_Clear();
  if Assigned(app_PLoad) Then
    app_PLoad();
  scr_Flush();


  timer_Reset();
  timeCalcFPS := timer_Add(@app_CalcFPS, 1000, Start);
  {$IfNDef USE_INIT_HANDLE}
  timeAppEvents := timer_Add(@app_Events, appEventsTime, Start);
  {$EndIf}
end;

{$IfNDef ANDROID}
procedure app_MainLoop;
var
  timeLoop: Double;
begin
  {$IfNDef USE_INIT_HANDLE}
  while winOn do
  begin
    app_ProcessOS();
    {$IfDef MAC_COCOA}
    if (keysDown[K_SUPER_L] or keysDown[K_SUPER_R]) then
      if keysDown[K_Q] then
        winOn := False;
    {$EndIf}
  {$EndIf}
    res_Proc();
    {$IFDEF USE_JOYSTICK}
    joy_Proc();
    {$ENDIF}
    {$IFDEF USE_SOUND}
    snd_MainLoop();
    {$ENDIF}

    {$IfNDef USE_INIT_HANDLE}
    if appPause Then
    begin
      timer_Reset();
      u_Sleep(15);

      continue;

    end else
    begin
      timer_MainLoop();
    end;
    {$EndIf}

    timeLoop := timer_GetTicks();
    {$IFDEF WINDOWS}
      // Workaround for a bug with unstable time between frames(happens when videocard trying to reclock GPU frequency/etc.)...
    if Assigned(app_PUpdate) and (scrVSync) and (appFPS > 0) and (appFPS = scrRefresh) and (appFlags and APP_USE_DT_CORRECTION > 0) Then
      app_PUpdate(1000 / appFPS)
    else
    {$ENDIF}
      if Assigned(app_PUpdate) Then
        app_PUpdate(timer_GetTicks() - appdt);
    appdt := timeLoop;

    {$IfNDef USE_INIT_HANDLE}
    timeLoop := newTimeDraw;
    newTimeDraw := timer_GetTicks;

    if newTimeDraw >= (oldTimeDraw + maxFPS) then
    begin
      app_Draw();
      oldTimeDraw := oldTimeDraw + maxFPS;
    end
    else begin
      u_Sleep(1);
    end;
    {$Else}
    app_Draw;
    {$EndIf}

  {$IfNDef USE_INIT_HANDLE}
    if wndUpdateWin then
      wnd_Update;
  end;
  {$EndIf}
end;

procedure app_ProcessOS;
var
  xmouse, ymouse: Integer;
  {$IFDEF USE_X11}
    root_return  : TWindow;
    child_return : TWindow;
    root_x_return: Integer;
    root_y_return: Integer;
    mask_return  : LongWord;
  {$ENDIF}
  {$IFDEF WINDOWS}
    m        : tagMsg;
    cursorpos: TPoint;
  {$ENDIF}
  {$IFDEF MACOSX}{$IfNDef MAC_COCOA}
    event: EventRecord;
    mPos : Point;
  {$ENDIF}{$EndIf}
begin
  xmouse := mouseX;
  ymouse := mouseY;
{$IFDEF USE_X11}
  XQueryPointer(scrDisplay, wndHandle, @root_return, @child_return, @root_x_return, @root_y_return, @mouseX, @mouseY, @mask_return);
{$ENDIF}
{$IFDEF WINDOWS}
  GetCursorPos(cursorpos);
  if wndFullScreen Then
  begin
    mouseX := cursorpos.X;
    mouseY := cursorpos.Y;
  end else
  begin
    mouseX := cursorpos.X - wndX - wndBrdSizeX;
    mouseY := cursorpos.Y - wndY - wndBrdSizeY - wndCpnSize;
  end;
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  mouseX := gMouseX;
  mouseY := gMouseY;
{$Else}
  GetGlobalMouse(mPos);
  mouseX := mPos.h - wndX;
  mouseY := mPos.v - wndY;
{$ENDIF}{$EndIf}

  if appFlags and CORRECT_RESOLUTION > 0 Then
  begin
    mouseDX := Round((mouseX - wndWidth div 2 - scrAddCX) / scrResCX);
    mouseDY := Round((mouseY - wndHeight div 2 - scrAddCY) / scrResCY);
    mouseX  := Round((mouseX - scrAddCX) / scrResCX);
    mouseY  := Round((mouseY - scrAddCY) / scrResCY);
  end else
  begin
    mouseDX := mouseX - wndWidth div 2;
    mouseDY := mouseY - wndHeight div 2;
  end;
  if (mouseLX <> mouseX) or (mouseLY <> mouseY) Then
  begin
    mouseLX := mouseX;
    mouseLY := mouseY;
  end;

  if (mouseX < 0) or (mouseX > wndWidth) or (mouseY < 0) or (mouseY > wndHeight) then
  begin
    mouseX := xmouse;
    mouseY := ymouse;
  end;

{$IfNDef USE_INIT_HANDLE}
{$IFDEF USE_X11}
  app_ProcessMessages();
  keysRepeat := 0;
{$ENDIF}
{$IFDEF WINDOWS}
  while PeekMessageW(m, 0, 0, 0, PM_REMOVE) do
  begin
    TranslateMessage(m);
    DispatchMessageW(m);
  end;
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  app_ProcessMessages;
{$Else}
  while GetNextEvent(everyEvent, event) do;
{$ENDIF}{$EndIf}
{$EndIf}
{$IFDEF iOS}
  while CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, TRUE) = kCFRunLoopRunHandledSource do;
{$ENDIF}
  {$IfDef USE_VKEYBOARD}
  if not lockVirtualKeyboard then
  begin
    app_VirtualKeyboard;
  end
  else begin
    if timer_GetTicks - startTimeLockVK > timeLockVK then
    begin
      prevLockVK := False;
      lockVirtualKeyboard := false;
    end;
  end;
  {$EndIf}
end;

{$IfDef USE_VKEYBOARD}
procedure app_VirtualKeyboard;
begin
  if Assigned(app_DrawGui) then
  begin
    if keysDown[K_F11] then
    begin
      VisibleMenuChange := not VisibleMenuChange;
      lockVirtualKeyboard := true;
      startTimeLockVK := timer_GetTicks;
    end;
    if VisibleMenuChange then
    begin
      if (mouseUpDown and M_BLEFT_DOWN) > 0 then
        app_UseMenuDown;
      if (mouseUpDown and M_BLEFT_UP) > 0 then
        app_UseMenuUp;
    end;
  end;
end;

{$EndIf}

{$IFNDEF iOS}
{$IfDef WND_USE}
function app_ProcessMessages;
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  const
    MOUSELD      = $00000001;
    MOUSELU      = $00000002;
    MOUSERD      = $00000004;
    MOUSERU      = $00000008;
    MOUSEMD      = $00000010;
    MOUSEMU      = $00000020;
    MOUSEMOVE    = $00000040;
    KEYUPDOWN    = $00000100;
  {$Else}
  type
    zglTModifier = record
      bit: Integer;
      key: Integer;
    end;

  const
    Modifier: array[0..7] of zglTModifier = ((bit: $010000; key: K_NUMLOCK),
                                             (bit: $008000; key: K_CTRL_R),
                                             (bit: $004000; key: K_ALT_R),
                                             (bit: $002000; key: K_SHIFT_R),
                                             (bit: $001000; key: K_CTRL_L),
                                             (bit: $000800; key: K_ALT_L),
                                             (bit: $000200; key: K_SHIFT_L),
                                             (bit: $000100; key: K_SUPER));
  {$ENDIF}{$EndIf}

  var
  {$IFDEF USE_X11}
    event : TXEvent;
    keysym: TKeySym;
    status: TStatus;
  {$ENDIF}
  {$IFDEF MACOSX}
    eClass : UInt32;
    eKind  : UInt32;
    command: HICommand;
    mButton: EventMouseButton;
    mWheel : Integer;
    bounds : HIRect;
    SCAKey : LongWord;
    i      : Integer;
    wndMouseIn: Boolean;
  {$ENDIF}
    len: Integer;
    c  : array[0..5] of AnsiChar;
    str: UTF8String;
    key: LongWord;
  {$IfDef MAC_COCOA}
    ev: NSEvent;
    modFlags: NSUInteger;
    pool: NSAutoreleasePool;
    flagTrue: Word;
  label
    eventLoop;
  {$EndIf}
begin
  Result := 0;
{$IFDEF USE_X11}
  while XPending(scrDisplay) <> 0 do
  begin
    XNextEvent(scrDisplay, @event);

    if (XRRUpdateConfiguration(@event) = 1) and (event._type - scrEventBase = RRScreenChangeNotify) Then
    begin
      scr_Init();
      continue;
    end;

    if winOn Then
    case event._type of
        ClientMessage:
            if (event.xclient.message_type = wndProtocols) and (event.xclient.data.l[0] = wndDestroyAtom) Then
              winOn := False;
        Expose:
            if winOn and appAutoPause Then
              app_Draw();
        FocusIn:
            begin
              appFocus := TRUE;
              appPause := FALSE;
              if winOn and Assigned(app_PActivate) Then
                app_PActivate(TRUE);
              FillChar(keysDown[0], 256, 0);
              mouseUpDown := 0;
            end;
        FocusOut:
            begin
              appFocus := FALSE;
              if appAutoPause Then appPause := TRUE;
              if winOn and Assigned(app_PActivate) Then
                app_PActivate(FALSE);
            end;
        ConfigureNotify:
            begin
              // For specially stupid window managers :)
              if wndFullScreen and ((event.xconfigure.x <> 0) or (event.xconfigure.y <> 0)) Then
                wnd_SetPos(0, 0);
              if (event.xconfigure.width <> wndWidth) or (event.xconfigure.height <> wndHeight) Then
                wnd_SetSize(wndWidth, wndHeight);
            end;

        ButtonPress:
            begin
              case event.xbutton.button of
                1: // Left
                  begin
                    mouseUpDown := (mouseUpDown and (255 - M_BLEFT_UP)) or M_BLEFT_DOWN;
                    mouseClickCanClick := mouseClickCanClick or M_BLEFT_CLICK;
                    if timer_GetTicks - mouseDblCTime[M_BLEFT] < mouseDblCInt Then
                      mouseDblClickWheel := mouseDblClickWheel or M_BLEFT_DBLCLICK;
                    mouseDblCTime[M_BLEFT] := timer_GetTicks();
                  end;
                2: // Middle
                  begin
                    mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_UP)) or M_BMIDDLE_DOWN;
                    mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CLICK;
                    if timer_GetTicks - mouseDblCTime[M_BMIDDLE] < mouseDblCInt Then
                      mouseDblClickWheel := mouseDblClickWheel or M_BMIDDLE_DBLCLICK;
                    mouseDblCTime[M_BMIDDLE] := timer_GetTicks();
                  end;
                3: // Right
                  begin
                    mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_UP)) or M_BRIGHT_DOWN;
                    mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CLICK;
                    if timer_GetTicks - mouseDblCTime[M_BRIGHT] < mouseDblCInt Then
                      mouseDblClickWheel := mouseDblClickWheel or M_BRIGHT_DBLCLICK;
                    mouseDblCTime[M_BRIGHT] := timer_GetTicks();
                  end;
              end;
            end;
        ButtonRelease:
            begin
              case event.xbutton.button of
                1: // Left
                  begin
                    mouseUpDown := (mouseUpDown and (255 - M_BLEFT_DOWN)) or M_BLEFT_UP;
                    mouseClickCanClick := mouseClickCanClick  or M_BLEFT_CANCLICK;
                  end;
                2: // Middle
                  begin
                    mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_DOWN)) or M_BMIDDLE_UP;
                    mouseClickCanClick := mouseClickCanClick  or M_BMIDDLE_CANCLICK;
                  end;
                3: // Right
                  begin
                    mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_DOWN)) or M_BRIGHT_UP;
                    mouseClickCanClick := mouseClickCanClick  or M_BRIGHT_CANCLICK;
                  end;
                4: // Up Wheel
                  begin
                    mouseDblClickWheel := mouseDblClickWheel or M_WHEEL_UP;
                  end;
                5: // Down Wheel
                  begin
                    mouseDblClickWheel := mouseDblClickWheel or M_WHEEL_DOWN;
                  end;
              end;
            end;

        KeyPress:
            begin
              INC(keysRepeat);
              key := xkey_to_scancode(XLookupKeysym(@event.xkey, 0), event.xkey.keycode);

              keyboardDown(key);
              {$IfDef USE_VKEYBOARD}
              if prevLockVK then
              begin
                lockVirtualKeyboard := True;
                startTimeLockVK := timer_GetTicks;
              end;
              {$EndIf}

              {$IfDef OLD_METHODS}
              if keysCanText Then
              case key of
                K_SYSRQ, K_PAUSE,
                K_ESCAPE, K_ENTER, K_KP_ENTER,
                K_UP, K_DOWN, K_LEFT, K_RIGHT,
                K_INSERT, K_DELETE, K_HOME, K_END,
                K_PAGEUP, K_PAGEDOWN,
                K_CTRL_L, K_CTRL_R,
                K_ALT_L, K_ALT_R,
                K_SHIFT_L, K_SHIFT_R,
                K_SUPER_L, K_SUPER_R,
                K_APP_MENU,
                K_CAPSLOCK, K_NUMLOCK, K_SCROLL:;
                K_BACKSPACE: utf8_Backspace(keysText);
                K_TAB:       key_InputText('  ');
              else
                len := Xutf8LookupString(appXIC, @event, @c[0], 6, @keysym, @status);
                if len > 0 Then
                begin
                  SetLength(str, len);
                  Move(c[0], str[1], len);
                  key_InputText(str);
                end;
              end;
              {$EndIf}
            end;
        KeyRelease:
            begin
              INC(keysRepeat);
              key := xkey_to_scancode(XLookupKeysym(@event.xkey, 0), event.xkey.keycode);

              keyboardUp(key);
              {$IfDef USE_VKEYBOARD}
              if prevLockVK then
              begin
                lockVirtualKeyboard := True;
                startTimeLockVK := timer_GetTicks;
              end;
              {$EndIf}
            end;
    end
  end;
{$ENDIF}
{$IFDEF WINDOWS}
  if (not winOn) and (Msg <> WM_ACTIVATEAPP) Then
  begin
    Result := DefWindowProcW(hWnd, Msg, wParam, lParam);
    exit;
  end;
  case Msg of
    WM_CLOSE, WM_DESTROY, WM_QUIT:
      winOn := False;

    WM_PAINT:
      begin
        app_Draw();
        ValidateRect(wndHandle, nil);
      end;
    WM_DISPLAYCHANGE:
      begin
        scr_Init();
        {$IfNDef USE_INIT_HANDLE}
        if not wndFullScreen Then
          wnd_Update();
        {$EndIf}
      end;
    WM_SETFOCUS:
      begin
        {$IfNDef USE_INIT_HANDLE}
        if (wndFullScreen)(* and (not wndFirst*) Then
          scr_SetOptions();
        {$EndIf}
      end;
    WM_ACTIVATEAPP:
      begin
        if appMinimized Then exit;
        if (wParam > 0) and (not appFocus) Then
        begin
          appFocus := TRUE;
          appPause := FALSE;
          if winOn and Assigned(app_PActivate) Then
            app_PActivate(TRUE);
          FillChar(keysDown[0], 256, 0);
          mouseUpDown := 0;
        end else
          if (wParam = 0) and (appFocus) Then
          begin
            appFocus := FALSE;
            if appAutoPause Then appPause := TRUE;
            if winOn Then
            begin
              if Assigned(app_PActivate) Then
                app_PActivate(FALSE);
              if (wndFullScreen) (*and (not wndFirst*) Then
              begin
                scr_Reset();
                {$IfNDef USE_INIT_HANDLE}
                wnd_Update();
                {$EndIf}
              end;
            end;
          end;
      end;
    WM_SIZE:
      begin
        if wParam = SIZE_MINIMIZED Then
        begin
          SendMessage(wndHandle, WM_ACTIVATEAPP, 0, 0);
          appMinimized := TRUE;
        end;
        if (wParam = SIZE_MAXIMIZED) or (wParam = SIZE_RESTORED) Then
        begin
          appMinimized := FALSE;
          SendMessage(wndHandle, WM_ACTIVATEAPP, 1, 0);
        end;
      end;
    WM_NCHITTEST:
      begin
        Result := DefWindowProcW(hWnd, Msg, wParam, lParam);
        if (not appFocus) and (Result = HTCAPTION) Then
          Result := HTCLIENT;
      end;
    WM_ENTERSIZEMOVE:
      begin
        if not appAutoPause Then
          appTimer := SetTimer(wndHandle, 1, 1, nil);
      end;
    WM_EXITSIZEMOVE:
      begin
        if appTimer > 0 Then
        begin
          KillTimer(wndHandle, appTimer);
          appTimer := 0;
        end;
      end;
    WM_MOVING:
      begin
        wndX := PRect(lParam).Left;
        wndY := PRect(lParam).Top;
        if appAutoPause Then
          timer_Reset();
      end;
    WM_TIMER:
      begin
        timer_MainLoop();
        app_Draw();
      end;
    WM_SETCURSOR:
      begin
        if (appFocus) and (LOWORD (lparam) = HTCLIENT) and (not appShowCursor) Then
          SetCursor(0)
        else
          SetCursor(LoadCursor(0, IDC_ARROW));
      end;

    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BLEFT_UP)) or M_BLEFT_DOWN;
        mouseClickCanClick := mouseClickCanClick or M_BLEFT_CLICK;
        if Msg = WM_LBUTTONDBLCLK then
        begin
          mouseDblClickWheel := mouseDblClickWheel or M_BLEFT_DBLCLICK;
        end;
      end;
    WM_MBUTTONDOWN, WM_MBUTTONDBLCLK:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_UP)) or M_BMIDDLE_DOWN;
        mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CLICK;
        if Msg = WM_MBUTTONDBLCLK then
        begin
          mouseDblClickWheel := mouseDblClickWheel or M_BMIDDLE_DBLCLICK;
        end;
      end;
    WM_RBUTTONDOWN, WM_RBUTTONDBLCLK:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_UP)) or M_BRIGHT_DOWN;
        mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CLICK;
        if Msg = WM_RBUTTONDBLCLK then
        begin
          mouseDblClickWheel := mouseDblClickWheel or M_BRIGHT_DBLCLICK;
        end;
      end;
    WM_LBUTTONUP:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BLEFT_DOWN)) or M_BLEFT_UP;
        mouseClickCanClick := mouseClickCanClick or M_BLEFT_CANCLICK;
      end;
    WM_MBUTTONUP:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_DOWN)) or M_BMIDDLE_UP;
        mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CANCLICK;
      end;
    WM_RBUTTONUP:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_DOWN)) or M_BRIGHT_UP;
        mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CANCLICK;
      end;
    WM_MOUSEWHEEL:
      begin
        if SmallInt(wParam shr 16) > 0 Then
        begin
          mouseDblClickWheel := mouseDblClickWheel or M_WHEEL_UP;
        end else
        begin
          mouseDblClickWheel := mouseDblClickWheel or M_WHEEL_DOWN;
        end;
      end;

    WM_KEYDOWN, WM_SYSKEYDOWN:
      begin
        key := winkey_to_scancode(wParam);
        keyboardDown(key);
        {$IfDef USE_VKEYBOARD}
        if prevLockVK then
        begin
          lockVirtualKeyboard := True;
          startTimeLockVK := timer_GetTicks;
        end;
        {$EndIf}

        if (Msg = WM_SYSKEYDOWN) and (key = K_F4) Then
          winOn := false;
      end;

    WM_KEYUP, WM_SYSKEYUP:
      begin
        key := winkey_to_scancode(wParam);
        keyboardUp(key);
        {$IfDef USE_VKEYBOARD}
        if prevLockVK then
        begin
          lockVirtualKeyboard := True;
          startTimeLockVK := timer_GetTicks;
        end;
        {$EndIf}
      end;
    {$IfDef OLD_METHODS}
    WM_CHAR:
      begin
        if keysCanText Then
        case winkey_to_scancode(wParam) of
            K_ENTER:;
            K_BACKSPACE: utf8_Backspace(keysText);
            K_TAB:       key_InputText('  ');
          else
            len := WideCharToMultiByte(CP_UTF8, 0, @wParam, 1, nil, 0, nil, nil);
            if len > 0 Then
            begin
              WideCharToMultiByte(CP_UTF8, 0, @wParam, 1, @c[0], 5, nil, nil);
              SetLength(str, len);
              Move(c[0], str[1], len);
              key_InputText(str);
            end;
        end;
      end;
    {$EndIf}
    WM_SYSCOMMAND:
      begin
        if wParam <> SC_KEYMENU then
          result := DefWindowProcW( hWnd, Msg, wParam, lParam );
      end;
  else
    Result := DefWindowProcW(hWnd, Msg, wParam, lParam);
  end;
{$ENDIF}
{$IFDEF MACOSX}{$IfDef MAC_COCOA}
  flagTrue := 0;
eventLoop:
  ev := wndHandle.nextEventMatchingMask_untilDate_inMode_dequeue(NSAnyEventMask, nil, NSDefaultRunLoopMode, true);
  if ev = nil then
  begin
    exit;
  end;
  case ev.type_ of
    NSMouseMoved, NSLeftMouseDragged, NSRightMouseDragged, NSOtherMouseDragged:
      begin
        if (flagTrue and MOUSEMOVE) = 0 then
        begin
          gMouseX := Trunc(ev.locationInWindow.x);
          gMouseY := Trunc(ev.locationInWindow.y);
          flagTrue := flagTrue or MOUSEMOVE;
        end;
      end;
    NSLeftMouseDown:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BLEFT_UP)) or M_BLEFT_DOWN;
        mouseClickCanClick := mouseClickCanClick or M_BLEFT_CLICK;
        if timer_GetTicks() - mouseDblCTime[M_BLEFT] < mouseDblCInt Then
          mouseDblClickWheel := mouseDblClickWheel or M_BLEFT_DBLCLICK;
        mouseDblCTime[M_BLEFT] := timer_GetTicks();
      end;
    NSLeftMouseUp:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BLEFT_DOWN)) or M_BLEFT_UP;
        mouseClickCanClick := mouseClickCanClick or M_BLEFT_CANCLICK;
      end;
    NSRightMouseDown:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_UP)) or M_BRIGHT_DOWN;
        mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CLICK;
        if timer_GetTicks() - mouseDblCTime[M_BRIGHT] < mouseDblCInt Then
          mouseDblClickWheel := mouseDblClickWheel or M_BRIGHT_DBLCLICK;
        mouseDblCTime[M_BRIGHT] := timer_GetTicks();
      end;
    NSRightMouseUp:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_DOWN)) or M_BRIGHT_UP;
        mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CANCLICK;
      end;
    NSOtherMouseDown:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_UP)) or M_BMIDDLE_DOWN;
        mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CLICK;
        if timer_GetTicks() - mouseDblCTime[M_BMIDDLE] < mouseDblCInt Then
          mouseDblClickWheel := mouseDblClickWheel or M_BMIDDLE_DBLCLICK;
        mouseDblCTime[M_BMIDDLE] := timer_GetTicks();
      end;
    NSOtherMouseUp:
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_DOWN)) or M_BMIDDLE_UP;
        mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CANCLICK;
      end;
    NSScrollWheel:
      begin
   //         s :={ s + }'wheel mouse ';
    //        s := s + FloatToStr(ev.scrollingDeltaY);
      end;
    NSFlagsChanged:
      begin
        modFlags := ev.modifierFlags;
        if ((modFlags and NSAlphaShiftKeyMask) > 0) or ((modFlags and 256) > 0) then
          keyboardDown(K_CAPSLOCK);
        if (modFlags and NSShiftKeyMask) > 0 then
        begin
          if (modFlags and 2) > 0 then
          begin
            keyboardDown(K_SHIFT_L);
          end
          else begin
            keyboardUp(K_SHIFT_L);
          end;
          if (modFlags and 4) > 0 then
          begin
            keyboardDown(K_SHIFT_R);
          end
          else begin
            keyboardUp(K_SHIFT_R);
          end;
        end;
        if (modFlags and NSControlKeyMask) > 0 then
        begin
          if (modFlags and 1) > 0 then
          begin
            keyboardDown(K_CTRL_L);
          end
          else begin
            keyboardUp(K_CTRL_L);
          end;
          if (modFlags and $2000) > 0 then
          begin
            keyboardDown(K_CTRL_R);
          end
          else begin
            keyboardUp(K_CTRL_R);
          end;
        end;
        if (modFlags and NSAlternateKeyMask) > 0 then
        begin
          if (modFlags and $20) > 0 then
          begin
            keyboardDown(K_ALT_L);
          end
          else begin
            keyboardUp(K_ALT_L);
          end;
          if (modFlags and $40) > 0 then
          begin
            keyboardDown(K_ALT_R);
          end
          else begin
            keyboardUp(K_ALT_R);
          end;
        end;
        if (modFlags and NSCommandKeyMask) > 0 then
        begin
          if (modFlags and 8) > 0 then
          begin
            keyboardDown(K_SUPER_L);
          end
          else begin
            keyboardUp(K_SUPER_L);
          end;
          if (modFlags and 16) > 0 then
          begin
            keyboardDown(K_SUPER_R);
          end
          else begin
            keyboardUp(K_SUPER_R);
          end;
        end;
      end;
    NSKeyDown, NSKeyDownMask:
      begin
        flagTrue := flagTrue or KEYUPDOWN;
        key := mackey_to_scancode(ev.keyCode);
        keyboardDown(key);
        {$IfDef USE_VKEYBOARD}
        if prevLockVK then
        begin
          lockVirtualKeyboard := True;
          startTimeLockVK := timer_GetTicks;
        end;
        {$EndIf}
      end;
    NSKeyUp, NSKeyUpMask:
      begin
        flagTrue := flagTrue or KEYUPDOWN;
        key := mackey_to_scancode(ev.keyCode);
        keyboardUp(key);
        {$IfDef USE_VKEYBOARD}
        if prevLockVK then
        begin
          lockVirtualKeyboard := True;
          startTimeLockVK := timer_GetTicks;
        end;
        {$EndIf}
      end;
  end;
  if (flagTrue and KEYUPDOWN) = 0 then
  begin
    NSApp.sendEvent(ev);
  end;
  goto eventLoop;
{$Else}
  eClass := GetEventClass(inEvent);
  eKind  := GetEventKind(inEvent);
  Result := CallNextEventHandler(inHandlerCallRef, inEvent);

  if winOn Then
  case eClass of
    kEventClassCommand:
      case eKind of
        kEventProcessCommand:
          begin
            GetEventParameter(inEvent, kEventParamDirectObject, kEventParamHICommand, nil, SizeOf(HICommand), nil, @command);
            if command.commandID = kHICommandQuit Then
              winOn := false;
          end;
      end;

    kEventClassWindow:
      case eKind of
        kEventWindowDrawContent:
          begin
            app_Draw();
          end;
        kEventWindowActivated:
          begin
            appFocus := TRUE;
            appPause := FALSE;
            if Assigned(app_PActivate) Then
              app_PActivate(TRUE);
            FillChar(keysDown[0], 256, 0);
            mouseUpDown := 0;
            if wndFullScreen Then
              scr_SetOptions();
          end;
        kEventWindowDeactivated:
          begin
            appFocus := FALSE;
            if appAutoPause Then appPause := TRUE;
            if Assigned(app_PActivate) Then
              app_PActivate(FALSE);
            if wndFullScreen Then scr_Reset();
          end;
        kEventWindowCollapsed:
          begin
            appFocus := FALSE;
            appPause := TRUE;
          end;
        kEventWindowClosed:
          begin
            wndHandle := nil;
            winOn := FALSE;
          end;
        kEventWindowBoundsChanged:
          begin
            if not wndFullScreen Then
            begin
              GetEventParameter(inEvent, kEventParamCurrentBounds, typeHIRect, nil, SizeOf(bounds), nil, @bounds);
              wndX := Round(bounds.origin.x - (bounds.size.width - wndWidth) / 2);
              wndY := Round(bounds.origin.y - (bounds.size.height - wndHeight) / 2);
            end else
            begin
              wndX := 0;
              wndY := 0;
            end;
          end;
      end;

    kEventClassKeyboard:
      begin
        GetEventParameter(inEvent, kEventParamKeyCode, typeUInt32, nil, 4, nil, @Key);

        case eKind of
          kEventRawKeyModifiersChanged:
            begin
              GetEventParameter(inEvent, kEventParamKeyModifiers, typeUInt32, nil, 4, nil, @SCAKey);
              for i := 0 to 7 do
                if SCAKey and Modifier[i].bit > 0 Then
                begin
                  if not keysDown[Modifier[i].key] Then
                    doKeyPress(Modifier[i].key);
                  keysDown[Modifier[i].key] := TRUE;
                  keysUp  [Modifier[i].key] := FALSE;
                  keysLast[KA_DOWN]           := Modifier[i].key;

                  key := SCA(Modifier[i].key);
                  if not keysDown[key] Then
                    doKeyPress(key);
                  keysDown[key] := TRUE;
                  keysUp  [key] := FALSE;
                end else
                begin
                  if keysDown[Modifier[i].key] Then
                  begin
                    keysUp[Modifier[i].key] := TRUE;
                    keysLast[KA_UP]           := Modifier[i].key;
                  end;
                  keysDown[Modifier[i].key] := FALSE;

                  key := SCA(Modifier[i].key);
                  if keysDown[key] Then
                    keysUp[key] := TRUE;
                  keysDown[key] := FALSE;
                end;
            end;
          kEventRawKeyDown, kEventRawKeyRepeat:
            begin
              key := mackey_to_scancode(key);
              keysDown[key]     := TRUE;
              keysUp  [key]     := FALSE;
              keysLast[KA_DOWN] := key;
              if eKind <> kEventRawKeyRepeat Then
                doKeyPress(key);

              key := SCA(key);
              keysDown[key] := TRUE;
              keysUp  [key] := FALSE;
              if eKind <> kEventRawKeyRepeat Then
                doKeyPress(key);

              {$IfDef OLD_METHODS}
              if keysCanText Then
              case key of
                K_SYSRQ, K_PAUSE,
                K_ESCAPE, K_ENTER, K_KP_ENTER,
                K_UP, K_DOWN, K_LEFT, K_RIGHT,
                K_INSERT, K_DELETE, K_HOME, K_END,
                K_PAGEUP, K_PAGEDOWN,
                K_CTRL_L, K_CTRL_R,
                K_ALT_L, K_ALT_R,
                K_SHIFT_L, K_SHIFT_R,
                K_SUPER_L, K_SUPER_R,
                K_APP_MENU,
                K_CAPSLOCK, K_NUMLOCK, K_SCROLL:;
                K_BACKSPACE: utf8_Backspace(keysText);
                K_TAB:       key_InputText('  ');
              else
                GetEventParameter(inEvent, kEventParamKeyUnicodes, typeUTF8Text, nil, 6, @len, @c[0]);
                if len > 0 Then
                begin
                  SetLength(str, len);
                  System.Move(c[0], str[1], len);
                  key_InputText(str);
                end;
              end;
              {$EndIf}
            end;
          kEventRawKeyUp:
            begin
              key := mackey_to_scancode(key);
              keysDown[key]   := FALSE;
              keysUp  [key]   := TRUE;
              keysLast[KA_UP] := key;

              key := SCA(key);
              keysDown[key] := FALSE;
              keysUp  [key] := TRUE;
            end;
        end;
      end;

    kEventClassMouse:
      case eKind of
        kEventMouseMoved, kEventMouseDragged:
          begin
            wndMouseIn := (mouseX >= 0) and (mouseX <= wndWidth) and (mouseY >= 0) and (mouseY <= wndHeight);
            if wndMouseIn Then
            begin
              if (not appShowCursor) and (CGCursorIsVisible = 1) Then
                CGDisplayHideCursor(scrDisplay);
              if (appShowCursor) and (CGCursorIsVisible = 0) Then
                CGDisplayShowCursor(scrDisplay);
            end else
              if CGCursorIsVisible = 0 Then
                CGDisplayShowCursor(scrDisplay);
          end;
        kEventMouseDown:
          begin
            GetEventParameter(inEvent, kEventParamMouseButton, typeMouseButton, nil, SizeOf(EventMouseButton), nil, @mButton);

            // Magic Mouse !!! XD
            if keysDown[K_SUPER] and (mButton = kEventMouseButtonPrimary) Then
              mButton := kEventMouseButtonSecondary;

            case mButton of
              kEventMouseButtonPrimary: // Left
                begin
                  mouseUpDown := (mouseUpDown and (255 - M_BLEFT_UP)) or M_BLEFT_DOWN;
                  mouseClickCanClick := mouseClickCanClick or M_BLEFT_CLICK;
                  if timer_GetTicks() - mouseDblCTime[M_BLEFT] < mouseDblCInt Then
                    mouseDblClickWheel := mouseDblClickWheel or M_BLEFT_DBLCLICK;
                  mouseDblCTime[M_BLEFT] := timer_GetTicks();
                end;
              kEventMouseButtonTertiary: // Middle
                begin
                  mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_UP)) or M_BMIDDLE_DOWN;
                  mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CLICK;
                  if timer_GetTicks() - mouseDblCTime[M_BMIDDLE] < mouseDblCInt Then
                    mouseDblClickWheel := mouseDblClickWheel or M_BMIDDLE_DBLCLICK;
                  mouseDblCTime[M_BMIDDLE] := timer_GetTicks();
                end;
              kEventMouseButtonSecondary: // Right
                begin
                  mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_UP)) or M_BRIGHT_DOWN;
                  mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CLICK;
                  if timer_GetTicks() - mouseDblCTime[M_BRIGHT] < mouseDblCInt Then
                    mouseDblClickWheel := mouseDblClickWheel or M_BRIGHT_DBLCLICK;
                  mouseDblCTime[M_BRIGHT] := timer_GetTicks();
                end;
            end;
          end;
        kEventMouseUp:
          begin
            GetEventParameter(inEvent, kEventParamMouseButton, typeMouseButton, nil, SizeOf(EventMouseButton), nil, @mButton);

            // Magic Mouse !!! XD
            if keysDown[K_SUPER] and (mButton = kEventMouseButtonPrimary) Then
              mButton := kEventMouseButtonSecondary;

            case mButton of
              kEventMouseButtonPrimary: // Left
                begin
                  mouseUpDown := (mouseUpDown and (255 - M_BLEFT_DOWN)) or M_BLEFT_UP;
                  mouseClickCanClick := mouseClickCanClick or M_BLEFT_CANCLICK;
                end;
              kEventMouseButtonTertiary: // Middle
                begin
                  mouseUpDown := (mouseUpDown and (255 - M_BMIDDLE_DOWN)) or M_BMIDDLE_UP;
                  mouseClickCanClick := mouseClickCanClick or M_BMIDDLE_CANCLICK;
                end;
              kEventMouseButtonSecondary: // Right
                begin
                  mouseUpDown := (mouseUpDown and (255 - M_BRIGHT_DOWN)) or M_BRIGHT_UP;
                  mouseClickCanClick := mouseClickCanClick or M_BRIGHT_CANCLICK;
                end;
            end;
          end;
        kEventMouseWheelMoved:
          begin
            GetEventParameter(inEvent, kEventParamMouseWheelDelta, typeSInt32, nil, 4, nil, @mWheel);

            if mWheel > 0 then
            begin
              mouseDblClickWheel := mouseDblClickWheel or M_WHEEL_UP;
            end else
            begin
              mouseDblClickWheel := mouseDblClickWheel or M_WHEEL_DOWN;
            end;
          end;
      end;
  end;
{$EndIf}
{$ENDIF}
end;
{$EndIf}
{$ELSE}
procedure app_InitPool;
begin
  if not Assigned(appPool) Then
    appPool := NSAutoreleasePool.alloc.init();
end;

procedure app_FreePool;
begin
  if Assigned(appPool) Then
    appPool.release();
end;

procedure zglCAppDelegate.EnterMainLoop;
begin
  zgl_Init(oglFSAA, oglStencil);
end;

procedure zglCAppDelegate.MainLoop;
  var
    t: Double;
begin
  res_Proc();
  {$IFDEF USE_JOYSTICK}
  joy_Proc();
  {$ENDIF}
  {$IFDEF USE_SOUND}
  snd_MainLoop();
  {$ENDIF}

  if appPause Then
  begin
    timer_Reset();
    exit;
  end else
    timer_MainLoop();

  t := timer_GetTicks();
  if Assigned(app_PUpdate) Then
    app_PUpdate(timer_GetTicks() - appdt);
  appdt := t;

  app_Draw();
end;

procedure zglCAppDelegate.applicationDidFinishLaunching(application: UIApplication);
begin
  appDelegate := Self;

  scr_Init();
  performSelector_withObject_afterDelay(objcselector('EnterMainLoop'), nil, 0.2{magic});
end;

procedure zglCAppDelegate.applicationWillResignActive(application: UIApplication);
begin
  {$IFDEF USE_SOUND}
  if sndInitialized Then AudioSessionSetActive(FALSE);
  {$ENDIF}

  if appAutoPause Then appPause := TRUE;
  if winOn and Assigned(app_PActivate) Then
    app_PActivate(FALSE);

  FillChar(touchActive[0], MAX_TOUCH, 0);
  FillChar(touchDown[0], MAX_TOUCH, 0);
  FillChar(mouseDown[0], 3, 0);
  touch_ClearState();
  mouse_ClearState();
end;

procedure zglCAppDelegate.applicationDidEnterBackground(application: UIApplication);
begin
  winOn := FALSE;
end;

procedure zglCAppDelegate.applicationWillTerminate(application: UIApplication);
begin
  winOn := FALSE;
end;

procedure zglCAppDelegate.applicationWillEnterForeground(application: UIApplication);
begin
end;

procedure zglCAppDelegate.applicationDidBecomeActive(application: UIApplication);
begin
  {$IFDEF USE_SOUND}
  if sndInitialized Then AudioSessionSetActive(TRUE);
  {$ENDIF}

  appPause := FALSE;
  if winOn and Assigned(app_PActivate) Then
    app_PActivate(TRUE);
end;

procedure zglCAppDelegate.applicationDidReceiveMemoryWarning;
begin
  if Assigned(app_PMemoryWarn) Then
    app_PMemoryWarn();
end;

function zglCAppDelegate.textFieldShouldBeginEditing(textField: UITextField): Boolean;
begin
  Result := keysCanText;
end;

function zglCAppDelegate.textField_shouldChangeCharactersInRange_replacementString(textField: UITextField; range: NSRange; string_: NSString): Boolean;
  var
    buffer: array[0..3] of AnsiChar;
begin
  Result := TRUE;
  keysTextChanged := TRUE;

  FillChar(buffer, 4, 0);
  CFStringGetCString(CFStringRef(string_), @buffer[0], 4, kCFStringEncodingUTF8);

  if buffer[0] = #0 Then
    utf8_Backspace(keysText)
  else
    key_InputText(buffer);
end;

function zglCAppDelegate.textFieldShouldReturn(textField: UITextField): Boolean;
begin
  Result := TRUE;
  keysCanText := FALSE;
  keysTextField.resignFirstResponder();
  keysTextField.removeFromSuperview();
end;

function zglCAppDelegate.textFieldDidEndEditing(textField: UITextField): Boolean;
begin
  Result := textFieldShouldReturn(textField);
end;

procedure zglCAppDelegate.textFieldEditingChanged;
var
  i, len: Integer;
  buffer: PAnsiChar;
begin
  if not keysTextChanged Then
  begin
    len := CFStringGetLength(CFStringRef(keysTextField.text())) * 2;
    zgl_GetMem(buffer, len);
    CFStringGetCString(CFStringRef(keysTextField.text()), @buffer[0], len, kCFStringEncodingUTF8);
    keysText := PAnsiChar(@buffer[0]);
    zgl_FreeMem(buffer);
  end else
    keysTextChanged := FALSE;
end;

function zglCiOSViewController.shouldAutorotateToInterfaceOrientation(interfaceOrientation: UIInterfaceOrientation): Boolean;
begin
  Result := (scrCanPortrait and ((interfaceOrientation = UIInterfaceOrientationPortrait) or (interfaceOrientation = UIInterfaceOrientationPortraitUpsideDown))) or
            (scrCanLandscape and ((interfaceOrientation = UIInterfaceOrientationLandscapeLeft) or (interfaceOrientation = UIInterfaceOrientationLandscapeRight)));
end;

function zglCiOSViewController.supportedInterfaceOrientations: LongWord;
begin
  Result := (1 shl UIInterfaceOrientationPortrait + 1 shl UIInterfaceOrientationPortraitUpsideDown) * Byte(scrCanPortrait) +
            (1 shl UIInterfaceOrientationLandscapeLeft + 1 shl UIInterfaceOrientationLandscapeRight) * Byte(scrCanLandscape);
end;

function zglCiOSViewController.shouldAutorotate: Boolean;
begin
  Result := TRUE;
end;

procedure zglCiOSViewController.didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation);
begin
  FillChar(touchActive[0], MAX_TOUCH, 0);
  FillChar(touchDown[0], MAX_TOUCH, 0);
  FillChar(mouseDown[0], 3, 0);
  touch_ClearState();
  mouse_ClearState();

  scrOrientation := Self.interfaceOrientation;

  if scrCanPortrait and ((scrOrientation = UIInterfaceOrientationPortrait) or (scrOrientation = UIInterfaceOrientationPortraitUpsideDown)) Then
  begin
    wndPortrait := TRUE;
    scrDesktopW := scrCurrModeW;
    scrDesktopH := scrCurrModeH;
  end;

  if scrCanLandscape and ((scrOrientation = UIInterfaceOrientationLandscapeLeft) or (scrOrientation = UIInterfaceOrientationLandscapeRight)) Then
  begin
    wndPortrait := FALSE;
    scrDesktopW := scrCurrModeH;
    scrDesktopH := scrCurrModeW;
  end;

  wndFullScreen := true;
  scrVSync := true;
  scr_SetOptions();

  if winOn and Assigned(app_POrientation) Then
    app_POrientation(scrOrientation);
end;

class function zglCiOSEAGLView.layerClass: Pobjc_class;
begin
  Result := CAEAGLLayer.classClass;
end;

procedure zglCiOSEAGLView.UpdateTouch(ID: Integer);
begin
  if not touchActive[ID] Then
  begin
    touchDown[ID]   := FALSE;
    touchUp[ID]     := TRUE;
    touchTap[ID]    := FALSE;
    touchCanTap[ID] := TRUE;
  end else
  begin
    if (not touchDown[ID]) and (not touchTap[ID]) and (touchCanTap[ID]) Then
    begin
      touchTap[ID]    := TRUE;
      touchCanTap[ID] := FALSE;
    end;

    touchDown[ID] := TRUE;
    touchUp[ID]   := FALSE;
  end;

  // mouse emulation
  if ID = 0 Then
  begin
    mouseX := touchX[0];
    mouseY := touchY[0];

    if (mouseLX <> mouseX) or (mouseLY <> mouseY) Then
    begin
      mouseLX := mouseX;
      mouseLY := mouseY;

      if Assigned(mouse_PMove) Then
        mouse_PMove(mouseX, mouseY);
    end;

    if (touchDown[0]) and (not mouseDown[M_BLEFT]) Then
    begin
      mouseDown[M_BLEFT] := TRUE;
      if mouseCanClick[M_BLEFT] Then
      begin
        mouseClick[M_BLEFT] := TRUE;
        mouseCanClick[M_BLEFT] := FALSE;

        if Assigned(mouse_PPress) Then
          mouse_PPress(M_BLEFT);
      end;
    end else
      if (not touchDown[0]) and (mouseDown[M_BLEFT]) Then
      begin
        mouseDown[M_BLEFT]     := FALSE;
        mouseUp  [M_BLEFT]     := TRUE;
        mouseCanClick[M_BLEFT] := TRUE;

        if Assigned(mouse_PRelease) Then
          mouse_PRelease(M_BLEFT);
      end else
        if touchDown[0] Then
        begin
          if timer_GetTicks - mouseDblCTime[M_BLEFT] < mouseDblCInt Then
            mouseDblClick[M_BLEFT] := TRUE;
            mouseDblCTime[M_BLEFT] := timer_GetTicks();
        end;
  end;
end;

procedure zglCiOSEAGLView.touchesBegan_withEvent(touches: NSSet; event: UIevent);
var
  i, j : Integer;
  touch: UITouch;
  scale: Single;
begin
  scale := eglView.contentScaleFactor;

  for i := 0 to touches.allObjects().count - 1 do
  begin
    touch := UITouch(touches.allObjects().objectAtIndex(i));
    for j := 0 to MAX_TOUCH - 1 do
      if ((not touchActive[j]) and (not touchUp[j])) or (touch.tapCount = 2) Then
      begin
        if appFlags and CORRECT_RESOLUTION > 0 Then
        begin
          touchX[j] := Round((touch.locationInView(Self).x * scale - scrAddCX) / scrResCX);
          touchY[j] := Round((touch.locationInView(Self).y * scale - scrAddCY) / scrResCY);
        end else
        begin
          touchX[j] := Round(touch.locationInView(Self).x * scale);
          touchY[j] := Round(touch.locationInView(Self).y * scale);
        end;
        touchActive[j] := TRUE;
        UpdateTouch(j);
        break;
      end;
  end;
end;

procedure zglCiOSEAGLView.touchesMoved_withEvent(touches: NSSet; event: UIevent);
var
  i, j : Integer;
  touch: UITouch;
  prevX: Integer;
  prevY: Integer;
  scale: Single;
begin
  scale := eglView.contentScaleFactor;

  for i := 0 to touches.allObjects().count - 1 do
  begin
    touch := UITouch(touches.allObjects().objectAtIndex(i));

    if appFlags and CORRECT_RESOLUTION > 0 Then
    begin
      prevX := Round((touch.previousLocationInView(Self).x * scale - scrAddCX) / scrResCX);
      prevY := Round((touch.previousLocationInView(Self).y * scale - scrAddCY) / scrResCY);
    end else
    begin
      prevX := Round(touch.previousLocationInView(Self).x * scale);
      prevY := Round(touch.previousLocationInView(Self).y * scale);
    end;

    for j := 0 to MAX_TOUCH - 1 do
      if (touchX[j] = prevX) and (touchY[j] = prevY) Then
      begin
        if appFlags and CORRECT_RESOLUTION > 0 Then
        begin
          touchX[j] := Round((touch.locationInView(Self).x * scale - scrAddCX) / scrResCX);
          touchY[j] := Round((touch.locationInView(Self).y * scale - scrAddCY) / scrResCY);
        end else
        begin
          touchX[j] := Round(touch.locationInView(Self).x * scale);
          touchY[j] := Round(touch.locationInView(Self).y * scale);
        end;
        touchActive[j] := TRUE;
        UpdateTouch(j);
        break;
      end;
  end;
end;

procedure zglCiOSEAGLView.touchesEnded_withEvent(touches: NSSet; event: UIevent);
var
  i, j : Integer;
  touch: UITouch;
  currX: Integer;
  currY: Integer;
  prevX: Integer;
  prevY: Integer;
  scale: Single;
begin
  scale := eglView.contentScaleFactor;

  for i := 0 to touches.allObjects().count - 1 do
  begin
    touch := UITouch(touches.allObjects().objectAtIndex(i));

    if appFlags and CORRECT_RESOLUTION > 0 Then
    begin
      currX := Round((touch.locationInView(Self).x * scale - scrAddCX) / scrResCX);
      currY := Round((touch.locationInView(Self).y * scale - scrAddCY) / scrResCY);
      prevX := Round((touch.previousLocationInView(Self).x * scale - scrAddCX) / scrResCX);
      prevY := Round((touch.previousLocationInView(Self).y * scale - scrAddCY) / scrResCY);
    end else
    begin
      currX := Round(touch.locationInView(Self).x * scale);
      currY := Round(touch.locationInView(Self).y * scale);
      prevX := Round(touch.previousLocationInView(Self).x * scale);
      prevY := Round(touch.previousLocationInView(Self).y * scale);
    end;

    for j := 0 to MAX_TOUCH - 1 do
      if ((touchX[j] = currX) and (touchY[j] = currY)) or ((touchX[j] = prevX) and (touchY[j] = prevY)) Then
      begin
        touchX[j] := currX;
        touchY[j] := currY;
        touchActive[j] := FALSE;
        UpdateTouch(j);
        break;
      end;
  end;
end;

procedure zglCiOSEAGLView.touchesCancelled_withEvent(touches: NSSet; event: UIevent);
begin
  touchesEnded_withEvent(touches, event);
end;

procedure zglCiOSEAGLView.didMoveToSuperview;
begin
  FillChar(touchActive[0], MAX_TOUCH, 0);
  FillChar(mouseDown[0], 3, 0);
  touch_ClearState();
  mouse_ClearState();
end;
{$ENDIF}
{$Else}
function JNI_OnLoad(vm: PJavaVM; reserved: Pointer): jint;
begin
  vm^.GetEnv(vm, @appEnv, JNI_VERSION_1_6);

  appClass := appEnv^.FindClass(appEnv, 'zengl/android/ZenGL');

  appFinish       := appEnv^.GetMethodID(appEnv, appClass, 'Finish', '()V');
  appSwapBuffers  := appEnv^.GetMethodID(appEnv, appClass, 'SwapBuffers', '()V');

  appShowKeyboard := appEnv^.GetMethodID(appEnv, appClass, 'ShowKeyboard', '()V');
  appHideKeyboard := appEnv^.GetMethodID(appEnv, appClass, 'HideKeyboard', '()V');

  Result := JNI_VERSION_1_6;
end;

function JNI_OnUnload(vm: PJavaVM; reserved: Pointer): jint;
begin
  Result := 0;
end;

procedure Java_zengl_android_ZenGL_zglNativeInit(env: PJNIEnv; thiz: jobject; AppDirectory, HomeDirectory: jstring);
var
  P: PAnsiChar;
begin
  appEnv        := env;
  appObject     := thiz;

  P := env^.GetStringUTFChars(env, AppDirectory, nil);
  appWorkDir := utf8_Copy(P);
  env^.ReleaseStringUTFChars(env, AppDirectory, P);

  P := env^.GetStringUTFChars(env, HomeDirectory, nil);
  appHomeDir := utf8_Copy(P);
  env^.ReleaseStringUTFChars(env, HomeDirectory, P);

  appGotSysDirs := TRUE;

  thread_CSInit(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeDestroy(env: PJNIEnv; thiz: jobject);
begin
  MyByteArray := nil;
  appEnv    := env;
  appObject := thiz;
  winOn := FALSE;
  zgl_Destroy();

  thread_CSDone(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeSurfaceCreated(env: PJNIEnv; thiz: jobject);
begin
  thread_CSEnter(appLock);

  appEnv    := env;
  appObject := thiz;

  if appInitialized Then
  begin
    oglVRAMUsed := 0;
    gl_ResetState();
    if Assigned(app_PRestore) Then
      app_PRestore();
    timer_Reset();
  end;

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeSurfaceChanged(env: PJNIEnv; thiz: jobject; Width, Height: jint);
begin
  thread_CSEnter(appLock);

  appEnv    := env;
  appObject := thiz;

  if not appInitialized Then
  begin
    scrDesktopW := Width;
    scrDesktopH := Height;
    wndWidth    := Width;
    wndHeight   := Height;

    zgl_Init();
  end else
    wnd_SetSize(Width, Height);

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeDrawFrame(env: PJNIEnv; thiz: jobject);
  var
    t: Double;
begin
  thread_CSEnter(appLock);

  appEnv    := env;
  appObject := thiz;
  if not winOn Then
  begin
    Env^.CallVoidMethod(Env, appObject, appFinish);
    thread_CSLeave(appLock);
    exit;
  end;

  res_Proc();
  {$IFDEF USE_JOYSTICK}
  joy_Proc();
  {$ENDIF}
  {$IFDEF USE_SOUND}
  snd_MainLoop();
  {$ENDIF}

  if appPause Then
  begin
    timer_Reset();
    exit;
  end else
    timer_MainLoop();

  t := timer_GetTicks();
  if Assigned(app_PUpdate) Then
    app_PUpdate(timer_GetTicks() - appdt);
  appdt := t;

  app_Draw();

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeActivate(env: PJNIEnv; thiz: jobject; Activate: jboolean);
begin
  thread_CSEnter(appLock);

  appEnv    := env;
  appObject := thiz;
  if Activate > 0 Then
  begin
    appFocus := TRUE;
    appPause := FALSE;
    if winOn and Assigned(app_PActivate) Then
      app_PActivate(TRUE);
    FillChar(keysDown[0], 256, 0);
    key_ClearState();
    mouseUpDown := 0;
    mouse_ClearState();
    touch_ClearState();

    timer_Reset();
  end else
  begin
    appFocus := FALSE;
    appPause := TRUE;
    if winOn and Assigned(app_PActivate) Then
       app_PActivate(FALSE);
    {$IFDEF USE_SOUND}
    snd_MainLoop();
    {$ENDIF}
  end;

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeCloseQuery(env: PJNIEnv; thiz: jobject);
begin
  thread_CSEnter(appLock);

  winOn := False;

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeTouch(env: PJNIEnv; thiz: jobject; ID: jint; X, Y, Pressure: jfloat);
var
  dX, dY: Integer;
begin
  thread_CSEnter(appLock);

  dX := Abs(round((X - scrAddCX) / scrResCX) - touchX[ID]);
  dY := Abs(round((Y - scrAddCY) / scrResCY) - touchY[ID]);

  if appFlags and CORRECT_RESOLUTION > 0 Then
  begin
    touchX[ID]  := Round((X - scrAddCX) / scrResCX);
    touchY[ID]  := Round((Y - scrAddCY) / scrResCY);
  end else
  begin
    touchX[ID] := Round(X);
    touchY[ID] := Round(Y);
  end;

  if (not touchDown[ID]) and (Pressure > 0) Then
  begin
    touchDown[ID] := TRUE;
    touchUp[ID]   := FALSE;
    if touchCanTap[ID] Then
      touchTap[ID] := TRUE;
  end else
    if (touchDown[ID]) and (Pressure <= 0) Then
    begin
      touchDown[ID]   := FALSE;
      touchUp[ID]     := TRUE;
      touchTap[ID]    := FALSE;
      touchCanTap[ID] := TRUE;
    end;


  // mouse emulation
  if ID = 0 Then
  begin
    mouseX := touchX[0];
    mouseY := touchY[0];

    if (mouseLX <> mouseX) or (mouseLY <> mouseY) Then
    begin
      mouseLX := mouseX;
      mouseLY := mouseY;
    end;

    if (Pressure > 0) and (not ((mouseUpDown and M_BLEFT_DOWN) > 0) ) Then
    begin
      mouseUpDown := mouseUpDown or M_BLEFT_DOWN;

      {$IfDef USE_VKEYBOARD}
      if (MenuChange and 255) > 0 then
        app_UseMenuDown;
      {$EndIf}

      if ((mouseClickCanClick and M_BLEFT_CANCLICK) > 0) Then
      begin
        mouseClickCanClick := (mouseClickCanClick and (255 - M_BLEFT_CANCLICK)) or M_BLEFT_CLICK;
        if (dX <= 10) and (dy <= 10) then
        begin
          if (timer_GetTicks - mouseDblCTime[M_BLEFT] < mouseDblCInt) Then
          begin
            mouseDblClickWheel := mouseDblClickWheel or M_BLEFT_DBLCLICK;
          end;
        end;
        mouseDblCTime[M_BLEFT] := timer_GetTicks();
      end;
    end else
      if (Pressure <= 0) and ((mouseUpDown and M_BLEFT_DOWN) > 0) Then
      begin
        mouseUpDown := (mouseUpDown and (255 - M_BLEFT_DOWN)) or M_BLEFT_UP;

        {$IfDef USE_VKEYBOARD}
        if (MenuChange and 255) > 0 then            
          app_UseMenuUp;
        {$EndIf}
        mouseClickCanClick := (mouseClickCanClick and (255 - M_BLEFT_CLICK)) or M_BLEFT_CANCLICK;
      end;
  end;

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeInputText(env: PJNIEnv; thiz: jobject; text: jstring);
var
  P: PAnsiChar;
begin
  thread_CSEnter(appLock);

  appEnv    := env;
  appObject := thiz;

  P := Env^.GetStringUTFChars(Env, text, nil);
  key_InputText(P);
  Env^.ReleaseStringUTFChars(Env, text, P);

  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_zglNativeBackspace(env: PJNIEnv; thiz: jobject);
begin
  thread_CSEnter(appLock);
  utf8_Backspace(keysText);
  thread_CSLeave(appLock);
end;

function Java_zengl_android_ZenGL_bArrPasToJava(env: PJNIEnv; thiz: jobject): jByteArray;
var
  myArr: jbyteArray;
  i: Integer;
begin
  thread_CSEnter(appLock);
  i := High(MyByteArray) + 1;
  myArr := env^.NewByteArray(env, i);
  env^.SetByteArrayRegion(env, myArr, 0, i, @MyByteArray[0]);
  result := myArr;
  thread_CSLeave(appLock);
end;

procedure Java_zengl_android_ZenGL_bArrJavaToPas(env: PJNIEnv; thiz: jobject; arr: jbyteArray);
var
  _size: Integer;
begin
  thread_CSEnter(appLock);
  _size := env^.GetArrayLength(env, arr);            
  SetLength(MyByteArray, _size);
  env^.GetByteArrayRegion(env, arr, 0, _size, @MyByteArray[0]);
  thread_CSLeave(appLock);
end;

{$ENDIF}

initialization
  app_PInit       := @app_Init;
  {$IfNDef ANDROID}
  app_PLoop       := @app_MainLoop;
  {$EndIf}

  appFlags := WND_USE_AUTOCENTER or APP_USE_LOG or COLOR_BUFFER_CLEAR or CLIP_INVISIBLE or APP_USE_AUTOPAUSE {$IFDEF WINDOWS} or APP_USE_DT_CORRECTION {$ENDIF};

end.
