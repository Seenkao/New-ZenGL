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

 !!! modification from Serge 15.12.2020
}
unit zgl_timers;

{$I zgl_config.cfg}

interface
{$IfDef UNIX}
uses UnixType;
{$ENDIF}
{$IFDEF WINDOWS}
uses Windows;
{$ENDIF}

const
  MAX_TIMERS = 20;
  Stop = 1;
  Start = 2;
  Tiks = 4;
  SleepToStart = 8;
  SleepToStop = 16;
  Enable = 128;

type
  zglPTimer = ^zglTTimer;
  zglTTimer = record
    Interval, SInterval: Cardinal;
    Flags: Byte;
    LastTick, LastTickForSleep: Double;
    OnTimer: procedure;
  end;

  zglPTimerManager = ^zglTTimerManager;
  zglTTimerManager = record
    Count: Byte;
    Timers: array[1..MAX_TIMERS] of zglTTimer;
  end;

function  timer_GetTicks: Double;

function timer_Add(OnTimer: Pointer; Interval: Cardinal; Flags: Byte; SleepInterval: Cardinal = 5): Byte;
procedure timer_Del(var num: Byte);
procedure timers_Destroy;

function timer_StartStop(num: Byte; Flags: Byte): Boolean;
function timer_SleepStartStop(num: Byte; Flags: Byte; IntervalSleep: Cardinal = 1): Boolean;

procedure timer_MainLoop;
procedure timer_Reset;

var
  managerTimer : zglTTimerManager;

implementation
uses
  zgl_application,
  zgl_window;

{$IfDef UNIX}
function fpGetTimeOfDay(val: PTimeVal; tzp: Pointer): Integer; cdecl; external 'libc' name 'gettimeofday';
{$ENDIF}
{$IFDEF DARWIN}
type
  mach_timebase_info_t = record
    numer: LongWord;
    denom: LongWord;
  end;

  function mach_timebase_info(var info: mach_timebase_info_t): Integer; cdecl; external 'libc';
  function mach_absolute_time: QWORD; cdecl; external 'libc';
{$ENDIF}

var
  timersToKill : Byte = 0;
  aTimersToKill: array[1..200] of Byte;

  {$IfDef UNIX}{$IfNDef MAC_COCOA}
  timerTimeVal: TimeVal;
  {$Else}
  timerTimebaseInfo: mach_timebase_info_t;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF WINDOWS}
  timerFrequency: Int64;
  timerFreq     : Single;
  {$ENDIF}
  timerStart: Double;

function timer_Add(OnTimer: Pointer; Interval: Cardinal; Flags: Byte; SleepInterval: Cardinal = 5): Byte;
var
  i: Byte;
  t: Double;
begin
  Result := 255;
  if managerTimer.Count = MAX_TIMERS then exit;
  i := 1;
  while i <= MAX_TIMERS do
  begin
    if (managerTimer.Timers[i].Flags and Enable) = 0 then
      Break;
    inc(i);
  end;
  if i > MAX_TIMERS then
    exit;
  managerTimer.Timers[i].OnTimer := OnTimer;
  t := timer_GetTicks;
  if (Flags and SleepToStart) > 0 then
  begin
    Flags := Flags and (255 - Start);
    managerTimer.Timers[i].LastTickForSleep := t;
  end;
  managerTimer.Timers[i].LastTick := t;
  if (Flags and Start) > 0 then
    managerTimer.Timers[i].Flags := (managerTimer.Timers[i].Flags and (255 - Stop)) or Enable or Flags
  else
    managerTimer.Timers[i].Flags := (managerTimer.Timers[i].Flags and (255 - Start)) or Enable or Flags;
  managerTimer.Timers[i].Interval := Interval;
  managerTimer.Timers[i].SInterval := SleepInterval;
  inc(managerTimer.Count);
  Result := i;
end;

function timer_StartStop(num: Byte; Flags: Byte): Boolean;
begin
  Result := False;
  if (Flags and (Start or Stop or SleepToStop or SleepToStart) = 0) then exit;
  if (num = 0) or (num > MAX_TIMERS) then Exit;
  if (managerTimer.Timers[num].Flags and Enable) = 0 then Exit;
  if (Flags = Start) or (Flags = SleepToStart) then
  begin
    managerTimer.Timers[num].Flags := (managerTimer.Timers[num].Flags and (255 - Stop)) or Start;
    managerTimer.Timers[num].LastTick := timer_GetTicks;
  end
  else
    managerTimer.Timers[num].Flags := (managerTimer.Timers[num].Flags and (255 - Start)) or Stop;
  Result := True;
end;

function timer_SleepStartStop(num: Byte; Flags: Byte; IntervalSleep: Cardinal = 1): Boolean;
var
  t: Double;
begin
  Result := False;
  if (Flags and (Start or Stop or SleepToStop or SleepToStart) = 0) then exit;

  if (num = 0) or (num > MAX_TIMERS) then Exit;
  if (managerTimer.Timers[num].Flags and Enable) = 0 then Exit;
  managerTimer.Timers[num].SInterval := IntervalSleep;
  if (Flags = Start) or (Flags = SleepToStart) then
    managerTimer.Timers[num].Flags := (managerTimer.Timers[num].Flags or SleepToStart or Stop) and (255 - Start)
  else
    managerTimer.Timers[num].Flags := (managerTimer.Timers[num].Flags or SleepToStop or Start) and (255 - Stop);
  t := timer_GetTicks;
  managerTimer.Timers[num].LastTick := t;
  managerTimer.Timers[num].LastTickForSleep := t;

  Result := True;
end;

procedure timer_Del(var num: Byte);
begin
  if (num = 0) or (num > MAX_TIMERS) then
    exit;
  if (managerTimer.Timers[num].Flags and Enable) > 0 then
  begin
    inc(timersToKill);
    aTimersToKill[timersToKill] := num;
    num := 0;
  end;
end;

procedure timers_Destroy;
var
  i: Byte;
begin
  if managerTimer.Count = 0 then Exit;
  for i := 1 to MAX_TIMERS do
  begin
    if Assigned(managerTimer.Timers[i].OnTimer) then
    begin
      managerTimer.Timers[i].OnTimer := nil;
      managerTimer.Timers[i].Flags := 0;
    end;
  end;
  managerTimer.Count := 0;
end;

procedure timer_MainLoop;
var
  i, j: Byte;
  t : Double;
begin
  j := managerTimer.Count;
  i := 1;
  while j > 0 do
  begin
    if i > MAX_TIMERS then Break;
    if ((managerTimer.Timers[i].Flags and Enable) > 0) then
    begin
      t := timer_GetTicks;
      if ((managerTimer.Timers[i].Flags and SleepToStart) > 0) then
      begin
        if (t - managerTimer.Timers[i].LastTickForSleep) > 1000 then
        begin
          dec(managerTimer.Timers[i].SInterval);
          managerTimer.Timers[i].LastTickForSleep := managerTimer.Timers[i].LastTickForSleep + 1000;
        end;
        if managerTimer.Timers[i].SInterval = 0 then
        begin
          managerTimer.Timers[i].Flags := (managerTimer.Timers[i].Flags or Start) and (255 - SleepToStart - Stop);
          managerTimer.Timers[i].LastTick := t;
        end;
        inc(j);
        inc(i);
        Continue;
      end;
      if ((managerTimer.Timers[i].Flags and Start ) > 0) then
      begin
        while ((t - managerTimer.Timers[i].LastTick) > managerTimer.Timers[i].Interval) do
        begin
          if (managerTimer.Timers[i].Flags and Tiks) = 0 then
          begin
            managerTimer.Timers[i].OnTimer;
            managerTimer.Timers[i].Flags := managerTimer.Timers[i].Flags or Tiks;
          end;
          managerTimer.Timers[i].LastTick :=  managerTimer.Timers[i].LastTick + managerTimer.Timers[i].Interval;
        end;
        managerTimer.Timers[i].Flags := managerTimer.Timers[i].Flags and (255 - Tiks);
        if (managerTimer.Timers[i].Flags and SleepToStop) > 0 then
        begin
          if (t - managerTimer.Timers[i].LastTickForSleep) > 1000 then
          begin
            managerTimer.Timers[i].LastTickForSleep := managerTimer.Timers[i].LastTickForSleep + 1000;
            dec(managerTimer.Timers[i].SInterval);
          end;
          if managerTimer.Timers[i].SInterval = 0 then
          begin
            managerTimer.Timers[i].Flags := (managerTimer.Timers[i].Flags or Stop) and (255 - SleepToStop - Start);
          end;
        end;
        dec(j);
      end;
    end;
    inc(i);
  end;

  for i := 1 to timersToKill do
  begin
    managerTimer.Timers[aTimersToKill[i]].Flags := managerTimer.Timers[aTimersToKill[i]].Flags and (255 - Enable);
    dec(managerTimer.Count);
  end;
  timersToKill := 0;
end;

function timer_GetTicks: Double;
  {$IFDEF WINDOWS}
  var
    t: int64;
    m: LongWord;
  {$ENDIF}
begin
{$IfDef UNIX}{$IfNDef MAC_COCOA}
  fpGetTimeOfDay(@timerTimeVal, nil);
  {$Q-}
  // FIXME: почему-то overflow вылетает с флагом -Co
  Result := timerTimeVal.tv_sec * 1000 + timerTimeVal.tv_usec / 1000 - timerStart;
  {$Q+}
{$Else}
  Result := mach_absolute_time() * timerTimebaseInfo.numer / timerTimebaseInfo.denom / 1000000 - timerStart;
{$ENDIF}{$EndIf}
{$IFDEF WINDOWS}
  m := SetThreadAffinityMask(GetCurrentThread(), 1);
  QueryPerformanceCounter(t);
  Result := 1000 * t * timerFreq - timerStart;
  SetThreadAffinityMask(GetCurrentThread(), m);
{$ENDIF}
end;

procedure timer_Reset;
var
  i: Byte;
begin
  appdt := timer_GetTicks();
  for i := 1 to MAX_TIMERS do
  begin
    if Assigned(managerTimer.Timers[i].OnTimer) then
    begin
      managerTimer.Timers[i].LastTick := timer_GetTicks ;
      managerTimer.Timers[i].LastTickForSleep := timer_GetTicks;                    
    end;
  end;
end;

initialization
{$IFDEF WINDOWS}
  SetThreadAffinityMask(GetCurrentThread(), 1);
  QueryPerformanceFrequency(timerFrequency);
  timerFreq := 1 / timerFrequency;
{$ENDIF}
{$IFDEF DARWIN}
  mach_timebase_info(timerTimebaseInfo);
{$ENDIF}
  timerStart := timer_GetTicks();

end.
