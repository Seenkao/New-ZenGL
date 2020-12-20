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
unit zgl_log;

{$I zgl_config.cfg}

interface
uses
  zgl_file;

procedure log_Init;
procedure log_Close;
procedure log_Add(const Message: UTF8String; Timings: Boolean = TRUE);
procedure log_Flush;
function  log_Timing: UTF8String;

var
  log     : zglTFile = FILE_ERROR;
  logStart: LongWord;
  logFile : PAnsiChar;

implementation
uses
  zgl_application,
  zgl_window,
  zgl_timers,
  zgl_utils;

procedure log_Init;
  var
    i : Integer;
    es: UTF8String;
begin
  if (appFlags and APP_USE_LOG = 0) Then exit;
  if log <> FILE_ERROR Then exit;
  appLog   := TRUE;
  logStart := Round(timer_GetTicks());

  {$IfDef UNIX}{$IfNDef MAC_COCOA}
  if not Assigned(logFile) Then
    logFile := utf8_GetPAnsiChar('log.txt')
  {$ENDIF}{$EndIf}
  {$IFDEF WINDOWS}
  if not Assigned(logFile) Then
    logFile := utf8_GetPAnsiChar('log.txt')
  {$ENDIF}
  {$IFDEF MACOSX}{$IfDef MAC_COCOA}
  if not Assigned(logFile) Then
    logFile := utf8_GetPAnsiChar('log.txt')
  {$Else}
  if not Assigned(logFile) Then
    logFile := utf8_GetPAnsiChar(appWorkDir + '../log.txt')
  {$ENDIF}{$EndIf}
  {$IFDEF iOS}
  if not Assigned(logFile) Then
    logFile := utf8_GetPAnsiChar(appHomeDir + 'log.txt')
  {$ENDIF}
  else
    logFile := utf8_GetPAnsiChar(logFile);

  {$IFNDEF ANDROID}
  file_Open(log, logFile, FOM_CREATE, true);
  {$ENDIF}
  // crazy code :)
  es := '';
  for i := 0 to Length(cs_ZenGL + ' (' + cs_Date + ')') + 7 do
    es := es + '=';
  log_Add(es, FALSE);
  log_Add('=== ' + cs_ZenGL + ' (' + cs_Date + ') ===', FALSE);
  log_Add(es, FALSE);
  log_Add('Begin');
end;

procedure log_Close;
begin
  appLog := FALSE;
  FreeMem(logFile);
  logFile := nil;

  if log <> FILE_ERROR Then
    file_Close(log);
end;

procedure log_Add(const Message: UTF8String; Timings: Boolean = TRUE);
  var
    str: UTF8String;
begin
  if not appLog Then exit;
  {$IF DEFINED(LINUX) or DEFINED(iOS)}
  if (appLog) and (Pos('ERROR: ', Message) = 0) and (Pos('WARNING: ', Message) = 0) Then
    printf(PAnsiChar(Message + #10), [nil]);
  {$IFEND}
  if Timings Then
    str := log_Timing + Message + #13#10
  else
    str := Message + #13#10;

  {$IFNDEF ANDROID}
  file_Write(log, str[1], Length(str));
  {$ELSE}
  __android_log_write(3, 'ZenGL', PAnsiChar(log_Timing + Message));
  {$ENDIF}

  {$IFDEF USE_LOG_FLUSH}
  log_Flush();
  {$ENDIF}
end;

procedure log_Flush;
begin
  if log <> FILE_ERROR Then
    file_Flush(log);
end;

function log_Timing: UTF8String;
  var
    v: LongWord;
begin
  v := Round(timer_GetTicks()) - logstart;
  case v of
    0..9:               Result := '[0000000' + u_IntToStr(v) + 'ms] ';
    10..99:             Result := '[000000'  + u_IntToStr(v) + 'ms] ';
    100..999:           Result := '[00000'   + u_IntToStr(v) + 'ms] ';
    1000..9999:         Result := '[0000'    + u_IntToStr(v) + 'ms] ';
    10000..99999:       Result := '[000'     + u_IntToStr(v) + 'ms] ';
    100000..999999:     Result := '[00'      + u_IntToStr(v) + 'ms] ';
    1000000..9999999:   Result := '[0'       + u_IntToStr(v) + 'ms] ';
    10000000..99999999: Result := '['        + u_IntToStr(v) + 'ms] ';
  else
    Result := '[00000000ms]';
  end;
end;

end.
