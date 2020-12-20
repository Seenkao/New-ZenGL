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
unit zgl_threads;

{$I zgl_config.cfg}

interface
{$IFDEF UNIX}
  uses cthreads;
{$ENDIF}
{$IFNDEF FPC}
  uses Windows;
{$ENDIF}

type
  zglTThreadCallback = TThreadFunc;

  zglTThread = record
    ID    : {$IFDEF FPC} TThreadID {$ELSE} LongWord {$ENDIF};
    Handle: {$IFDEF FPC} TThreadID {$ELSE} THandle {$ENDIF};
  end;

  zglTCriticalSection = TRTLCriticalSection;                
  zglTEvent           = Pointer;

procedure thread_Create(var Thread: zglTThread; Callback: zglTThreadCallback; Data: Pointer = nil);
procedure thread_Close(var Thread: zglTThread);
procedure thread_CSInit(var CS: TRTLCriticalSection);
procedure thread_CSDone(var CS: TRTLCriticalSection);
procedure thread_CSEnter(var CS: TRTLCriticalSection);
procedure thread_CSLeave(var CS: TRTLCriticalSection);
procedure thread_EventCreate(var Event: zglTEvent);
procedure thread_EventDestroy(var Event: zglTEvent);
procedure thread_EventSet(var Event: zglTEvent);
procedure thread_EventReset(var Event: zglTEvent);
procedure thread_EventWait(var Event: zglTEvent; Milliseconds: LongWord = $FFFFFFFF);

implementation

procedure thread_Create(var Thread: zglTThread; Callback: zglTThreadCallback; Data: Pointer = nil);
begin
  {$IFDEF FPC}
  Thread.Handle := BeginThread(Callback, Data, Thread.ID);
  {$ELSE}
  Thread.Handle := BeginThread(nil, 0, Callback, Data, 0, Thread.ID);
  {$ENDIF}
end;

procedure thread_Close(var Thread: zglTThread);
begin
  {$IFDEF FPC}
  CloseThread(Thread.Handle);
  {$ELSE}
  CloseHandle(Thread.Handle);
  {$ENDIF}
end;

procedure thread_CSInit(var CS: TRTLCriticalSection);
begin
  {$IFDEF FPC}
  InitCriticalSection(CS);
  {$ELSE}
  InitializeCriticalSection(CS);
  {$ENDIF}
end;

procedure thread_CSDone(var CS: TRTLCriticalSection);
begin
  {$IFDEF FPC}
  DoneCriticalSection(CS);
  {$ELSE}
  DeleteCriticalSection(CS);
  {$ENDIF}
end;

procedure thread_CSEnter(var CS: TRTLCriticalSection);
begin
  EnterCriticalSection(CS);
end;

procedure thread_CSLeave(var CS: TRTLCriticalSection);
begin
  LeaveCriticalSection(CS);
end;

procedure thread_EventCreate(var Event: zglTEvent);
begin
  {$IFDEF FPC}
  Event := Pointer(RTLEventCreate());
  {$ELSE}
  Event := Pointer(CreateEvent(nil, TRUE, FALSE, nil));
  {$ENDIF}
end;

procedure thread_EventDestroy(var Event: zglTEvent);
begin
  {$IFDEF FPC}
  RTLEventDestroy(PRTLEvent(Event));
  {$ELSE}
  CloseHandle(LongWord(Event));
  {$ENDIF}
  Event := nil;
end;

procedure thread_EventSet(var Event: zglTEvent);
begin
  {$IFDEF FPC}
  RTLEventSetEvent(PRTLEvent(Event));
  {$ELSE}
  SetEvent(LongWord(Event));
  {$ENDIF}
end;

procedure thread_EventReset(var Event: zglTEvent);
begin
  {$IFDEF FPC}
  RTLEventResetEvent(PRTLEvent(Event));
  {$ELSE}
  ResetEvent(LongWord(Event));
  {$ENDIF}
end;

procedure thread_EventWait(var Event: zglTEvent; Milliseconds: LongWord = $FFFFFFFF);
begin
  {$IFDEF FPC}
  if Milliseconds = $FFFFFFFF Then
    RTLeventWaitFor(PRTLEvent(Event))
  else
    RTLeventWaitFor(PRTLEvent(Event), Milliseconds);
  {$ELSE}
  WaitForSingleObject(LongWord(Event), Milliseconds);
  {$ENDIF}
end;

end.
