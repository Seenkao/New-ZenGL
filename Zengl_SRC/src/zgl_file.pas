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
unit zgl_file;

{$I zgl_config.cfg}
{$IFDEF iOS}
  {$modeswitch objectivec1}
{$ENDIF}

interface
uses
  {$IFDEF UNIX}
  BaseUnix,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF iOS}
  iPhoneAll, CFBase, CFString,
  {$ENDIF}
  {$IFDEF USE_ZIP}
  zgl_lib_zip,
  {$ENDIF}
  zgl_types;

type
  zglTFile     = Ptr;
  zglTFileList = zglTStringList;

const
  FILE_ERROR = {$IFNDEF WINDOWS} 0 {$ELSE} Ptr(-1) {$ENDIF};

  // Open Mode
  FOM_CREATE = $01; // Create
  FOM_OPENR  = $02; // Read
  FOM_OPENW  = $03; // Write
  FOM_OPENRW = $04; // Read&Write


  // Seek Mode
  FSM_SET    = $01;
  FSM_CUR    = $02;
  FSM_END    = $03;

function  file_Open(out FileHandle: zglTFile; const FileName: UTF8String; Mode: Byte{$IfDef MAC_COCOA}; log: Boolean = false{$EndIf}): Boolean;
function  file_MakeDir(const Directory: UTF8String): Boolean;
function  file_Remove(const Name: UTF8String): Boolean;
function  file_Exists(const Name: UTF8String): Boolean;
function  file_Seek(FileHandle: zglTFile; Offset, Mode: Integer): LongWord;
function  file_GetPos(FileHandle: zglTFile): LongWord;
function  file_Read(FileHandle: zglTFile; var Buffer; Bytes: LongWord): LongWord;
function  file_Write(FileHandle: zglTFile; const Buffer; Bytes: LongWord): LongWord;
function  file_GetSize(FileHandle: zglTFile): LongWord;
procedure file_Flush(FileHandle: zglTFile);
procedure file_Close(var FileHandle: zglTFile);
procedure file_Find(const Directory: UTF8String; out List: zglTFileList; FindDir: Boolean);
function  file_GetName(const FileName: UTF8String): UTF8String;
function  file_GetExtension(const FileName: UTF8String): UTF8String;
function  file_GetDirectory(const FileName: UTF8String): UTF8String;
procedure file_SetPath(const Path: UTF8String);

{$IFDEF USE_ZIP}
function  file_OpenArchive(const FileName: UTF8String; const Password: UTF8String = ''): Boolean;
procedure file_CloseArchive;
{$ENDIF}

function _file_GetName(const FileName: UTF8String): PAnsiChar;
function _file_GetExtension(const FileName: UTF8String): PAnsiChar;
function _file_GetDirectory(const FileName: UTF8String): PAnsiChar;

{$IFDEF DARWIN}
function platform_GetRes(const FileName: UTF8String): UTF8String;
{$ENDIF}

implementation
uses
  {$IFDEF DARWIN}
  zgl_application,
  {$ENDIF}
  zgl_window,
  zgl_resources,
  zgl_log,
  zgl_utils;

{$IFDEF UNIX}
const
  { read/write search permission for everyone }
  MODE_MKDIR = S_IWUSR or S_IRUSR or
               S_IWGRP or S_IRGRP or
               S_IWOTH or S_IROTH or
               S_IXUSR or S_IXGRP or S_IXOTH;
{$ENDIF}

var
  filePath: UTF8String = '';
  filePathArchive: UTF8String = '';
  {$IFDEF iOS}
  iosFileManager: NSFileManager;
  {$ENDIF}

{$IFDEF WINDOWS}
threadvar
  wideStr: PWideChar;
{$ENDIF}

function GetDir(const Path: UTF8String): UTF8String;
  var
    len: Integer;
begin
  len := Length(Path);
  if (len > 0) and (Path[len] <> '/') {$IFDEF WINDOWS} and (Path[len] <> '\') {$ENDIF} Then
    Result := Path + '/'
  else
    Result := utf8_Copy(Path);
end;

function file_Open(out FileHandle: zglTFile; const FileName: UTF8String; Mode: Byte{$IfDef MAC_COCOA}; log: Boolean = false{$EndIf}): Boolean;
var
  s: UTF8String;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
  begin
    if (Mode = FOM_CREATE) or (Mode = FOM_OPENRW) or (Mode = FOM_OPENW) Then
    begin
      FileHandle := 0;
      Result := FALSE;
      exit;
    end;

    zgl_GetMem(Pointer(FileHandle), SizeOf(zglZipFile));
    zglPZipFile(FileHandle).file_ := zip_fopen(zipCurrent, PAnsiChar(filePathArchive + FileName), ZIP_FL_UNCHANGED);
    if not Assigned(zglPZipFile(FileHandle).file_) Then
      zgl_FreeMem(Pointer(FileHandle))
    else
      zglPZipFile(FileHandle).name := utf8_GetPAnsiChar(filePathArchive + FileName);

    Result := FileHandle <> 0;
    exit;
  end;
  {$ENDIF}

{$IfDef UNIX}{$IfNDef DARWIN}
  case Mode of
    FOM_CREATE: FileHandle := FpOpen(filePath + FileName, O_Creat or O_Trunc or O_RdWr);
    FOM_OPENR:  FileHandle := FpOpen(filePath + FileName, O_RdOnly);
    FOM_OPENRW: FileHandle := FpOpen(filePath + FileName, O_RdWr);
    FOM_OPENW:  FileHandle := FpOpen(filePath + FileName, O_WRONLY);
  end;
{$ENDIF}{$EndIf}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(filePath + FileName);
  case Mode of
    FOM_CREATE: FileHandle := CreateFileW(wideStr, GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    FOM_OPENR:  FileHandle := CreateFileW(wideStr, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
    FOM_OPENRW: FileHandle := CreateFileW(wideStr, GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
    FOM_OPENW:  FileHandle := CreateFileW(wideStr, GENERIC_READ, FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  end;
  FreeMem(wideStr);
{$ENDIF}
{$IFDEF DARWIN}{$IfDef MAC_COCOA}
  if log then
    s := appLogDir
  else
    s := filePath;
  case Mode of
    FOM_CREATE: FileHandle := FpOpen(platform_GetRes(s + FileName), O_Creat or O_Trunc or O_RdWr);
    FOM_OPENR:  FileHandle := FpOpen(platform_GetRes(s + FileName), O_RdOnly);
    FOM_OPENRW: FileHandle := FpOpen(platform_GetRes(s + FileName), O_RdWr);
    FOM_OPENW:  FileHandle := FpOpen(platform_GetRes(s + FileName), O_WRONLY);
  end;
{$Else}
  case Mode of
    FOM_CREATE: FileHandle := FpOpen(platform_GetRes(filePath + FileName), O_Creat or O_Trunc or O_RdWr);
    FOM_OPENR:  FileHandle := FpOpen(platform_GetRes(filePath + FileName), O_RdOnly);
    FOM_OPENRW: FileHandle := FpOpen(platform_GetRes(filePath + FileName), O_RdWr);
    FOM_OPENW:  FileHandle := FpOpen(platform_GetRes(filePath + FileName), O_WRONLY);
  end;
{$ENDIF}{$EndIf}
  Result := FileHandle <> FILE_ERROR;
end;

function file_MakeDir(const Directory: UTF8String): Boolean;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
    begin
      Result := FALSE;
      exit;
    end;
  {$ENDIF}

{$IfDef UNIX}
{$IfDef DARWIN}
  Result := FpMkdir(filePath + Directory, MODE_MKDIR) = FILE_ERROR;
{$ENDIF}
{$EndIf}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(filePath + Directory);
  Result := CreateDirectoryW(wideStr, nil);
  FreeMem(wideStr);
{$ENDIF}
{$IFDEF DARWIN}
  Result := FpMkdir(platform_GetRes(filePath + Directory), MODE_MKDIR) = FILE_ERROR;
{$ENDIF}
end;

function file_Remove(const Name: UTF8String): Boolean;
  var
  {$IF defined(UNIX) or DEFINED(MACOSX)}
    status: Stat;
  {$IFEND}
  {$IFDEF iOS}
    error: NSErrorPointer;
  {$ENDIF}
    i   : Integer;
    dir : Boolean;
    path: UTF8String;
    list: zglTFileList;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
    begin
      Result := FALSE;
      exit;
    end;
  {$ENDIF}

  if not file_Exists(Name) Then
    begin
      Result := FALSE;
      exit;
    end;

{$IfDef UNIX}{$IfNDef DARWIN}
  FpStat(filePath + Name, status);
  dir := fpS_ISDIR(status.st_mode);
{$ENDIF}{$EndIf}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(filePath + Name);
  dir := GetFileAttributesW(wideStr) and FILE_ATTRIBUTE_DIRECTORY > 0;
  FreeMem(wideStr);
{$ENDIF}
{$IFDEF MACOSX}
  FpStat(platform_GetRes(filePath + Name), status);
  dir := fpS_ISDIR(status.st_mode);
{$ENDIF}
{$IFDEF iOS}
  iosFileManager.fileExistsAtPath_isDirectory(utf8_GetNSString(platform_GetRes(filePath + Name)), @dir);
{$ENDIF}

  if dir Then
    begin
      path := GetDir(Name);

      file_Find(path, list, FALSE);
      for i := 0 to list.Count - 1 do
        file_Remove(path + list.Items[i]);

      file_Find(path, list, TRUE);
      for i := 2 to list.Count - 1 do
        file_Remove(path + list.Items[i]);

      {$IfDef UNIX}{$IfNDef DARWIN}
      Result := FpRmdir(filePath + Name) = 0;
      {$ENDIF}{$EndIf}
      {$IFDEF WINDOWS}
      wideStr := utf8_GetPWideChar(filePath + Name);
      Result  := RemoveDirectoryW(wideStr);
      FreeMem(wideStr);
      {$ENDIF}
      {$IFDEF MACOSX}
      Result := FpRmdir(platform_GetRes(filePath + Name)) = 0;
      {$ENDIF}
      {$IFDEF iOS}
      Result := iosFileManager.removeItemAtPath_error(utf8_GetNSString(platform_GetRes(filePath + Name)), error);
      {$ENDIF}
    end else
      {$IfDef UNIX}{$IfNDef DARWIN}
      Result := FpUnlink(filePath + Name) = 0;
      {$ENDIF}{$EndIf}
      {$IFDEF WINDOWS}
      begin
        wideStr := utf8_GetPWideChar(filePath + Name);
        Result  := DeleteFileW(wideStr);
        FreeMem(wideStr);
      end;
      {$ENDIF}
      {$IFDEF MACOSX}
      Result := FpUnlink(platform_GetRes(filePath + Name)) = 0;
      {$ENDIF}
      {$IFDEF iOS}
      Result := iosFileManager.removeItemAtPath_error(utf8_GetNSString(platform_GetRes(filePath + Name)), error);
      {$ENDIF}
end;

function file_Exists(const Name: UTF8String): Boolean;
  {$IFDEF UNIX}
  var
    status: Stat;
  {$ENDIF}
  {$IFDEF USE_ZIP}
  var
    zipStat: Tzip_stat;
  {$ENDIF}
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
    begin
      Result := zip_stat( zipCurrent, PAnsiChar( Name ), 0, zipStat ) = 0;
      exit;
    end;
  {$ENDIF}

{$IfDef UNIX}{$IfNDef DARWIN}
  Result := FpStat(filePath + Name, status) = 0;
{$ENDIF}{$EndIf}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(filePath + Name);
  Result  := GetFileAttributesW(wideStr) <> $FFFFFFFF;
  FreeMem(wideStr);
{$ENDIF}
{$IFDEF MACOSX}
  Result := FpStat(platform_GetRes(filePath + Name), status) = 0;
{$ENDIF}
{$IFDEF iOS}
  Result := iosFileManager.fileExistsAtPath(utf8_GetNSString(platform_GetRes(filePath + Name)));
{$ENDIF}
end;

function file_Seek(FileHandle: zglTFile; Offset, Mode: Integer): LongWord;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
  begin
    Result := 0;
    exit;
  end;
  {$ENDIF}

{$IFDEF UNIX}
  case Mode of
    FSM_SET: Result := FpLseek(FileHandle, Offset, SEEK_SET);
    FSM_CUR: Result := FpLseek(FileHandle, Offset, SEEK_CUR);
    FSM_END: Result := FpLseek(FileHandle, Offset, SEEK_END);
  else
    Result := 0;
  end;
{$ENDIF}
{$IFDEF WINDOWS}
  case Mode of
    FSM_SET: Result := SetFilePointer(FileHandle, Offset, nil, FILE_BEGIN);
    FSM_CUR: Result := SetFilePointer(FileHandle, Offset, nil, FILE_CURRENT);
    FSM_END: Result := SetFilePointer(FileHandle, Offset, nil, FILE_END);
  else
    Result := 0;
  end;
{$ENDIF}
end;

function file_GetPos(FileHandle: zglTFile): LongWord;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
  begin
    Result := 0;
    exit;
  end;
  {$ENDIF}

{$IFDEF UNIX}
  Result := FpLseek(FileHandle, 0, SEEK_CUR);
{$ENDIF}
{$IFDEF WINDOWS}
  Result := SetFilePointer(FileHandle, 0, nil, FILE_CURRENT);
{$ENDIF}
end;

function file_Read(FileHandle: zglTFile; var Buffer; Bytes: LongWord): LongWord;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
  begin
    Result := zip_fread(zglPZipFile(FileHandle).file_, Buffer, Bytes);
    exit;
  end;
  {$ENDIF}

{$IFDEF UNIX}
  Result := FpLseek(FileHandle, 0, SEEK_CUR);
  if Result + Bytes > file_GetSize(FileHandle) Then
    Result := file_GetSize(FileHandle) - Result
  else
    Result := Bytes;
  FpRead(FileHandle, Buffer, Bytes);
{$ENDIF}
{$IFDEF WINDOWS}
  ReadFile(FileHandle, Buffer, Bytes, Result, nil);
{$ENDIF}
end;

function file_Write(FileHandle: zglTFile; const Buffer; Bytes: LongWord): LongWord;
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) and (FileHandle <> log {FIXME}) Then
  begin
    Result := 0;
    exit;
  end;
  {$ENDIF}

{$IFDEF UNIX}
  Result := FpLseek(FileHandle, 0, SEEK_CUR);
  if Result + Bytes > file_GetSize(FileHandle) Then
    Result := file_GetSize(FileHandle) - Result
  else
    Result := Bytes;
  FpWrite(FileHandle, Buffer, Bytes);
{$ENDIF}
{$IFDEF WINDOWS}
  WriteFile(FileHandle, Buffer, Bytes, Result, nil);
{$ENDIF}
end;

function file_GetSize(FileHandle: zglTFile): LongWord;
  {$IFDEF UNIX}
  var
    tmp: LongWord;
  {$ENDIF}
  {$IFDEF USE_ZIP}
  var
    zipStat: Tzip_stat;
  {$ENDIF}
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) and (FileHandle <> log {FIXME}) Then
  begin
    if zip_stat(zipCurrent, zglPZipFile(FileHandle).name, 0, zipStat) = 0 Then
      Result := zipStat.size
    else
      Result := 0;
    exit;
  end;
  {$ENDIF}

{$IFDEF UNIX}
  // Crazy implementation 8)
  tmp    := FpLseek(FileHandle, 0, SEEK_CUR);
  Result := FpLseek(FileHandle, 0, SEEK_END);
  FpLseek(FileHandle, tmp, SEEK_SET);
{$ENDIF}
{$IFDEF WINDOWS}
  Result := GetFileSize(FileHandle, nil);
{$ENDIF}
end;

procedure file_Flush(FileHandle: zglTFile);
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) and (FileHandle <> log {FIXME}) Then exit;
  {$ENDIF}

{$IFDEF UNIX}
  //fflush(FileHandle);
{$ENDIF}
{$IFDEF WINDOWS}
  FlushFileBuffers(FileHandle);
{$ENDIF}
end;

procedure file_Close(var FileHandle: zglTFile);
begin
  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) and (FileHandle <> log {FIXME}) Then
  begin
    zip_fclose(zglPZipFile(FileHandle).file_);
    zgl_FreeMem(Pointer(zglPZipFile(FileHandle).name));
    zgl_FreeMem(Pointer(FileHandle));
    FileHandle := 0;
    exit;
  end;
  {$ENDIF}

{$IFDEF UNIX}
  FpClose(FileHandle);
{$ENDIF}
{$IFDEF WINDOWS}
  CloseHandle(FileHandle);
{$ENDIF}
  FileHandle := FILE_ERROR;
end;

procedure file_Find(const Directory: UTF8String; out List: zglTFileList; FindDir: Boolean);
  var
  {$IF defined(UNIX) or DEFINED(MACOSX)}
    dir   : PDir;
    dirent: PDirent;
    type_ : Integer;
  {$IFEND}
  {$IFDEF WINDOWS}
    First: THandle;
    FList: WIN32_FIND_DATAW;
  {$ENDIF}
  {$IFDEF iOS}
    i          : Integer;
    dirContent : NSArray;
    path       : NSString;
    fileName   : array[0..255] of AnsiChar;
    error      : NSErrorPointer;
    isDirectory: Boolean;
  {$ENDIF}
  {$IFDEF USE_ZIP}
    count: Integer;
    name : PAnsiChar;
    name2: UTF8String;
    len  : Integer;
  {$ENDIF}
begin
  List.Count := 0;

  {$IFDEF USE_ZIP}
  if Assigned(zipCurrent) Then
  begin
    for count := 0 to zip_get_num_entries(zipCurrent, ZIP_FL_UNCHANGED) - 1 do
    begin
      name := zip_get_name(zipCurrent, count, ZIP_FL_UNCHANGED);
      len  := Length(name);
      if FindDir Then
      begin
        if name[len - 1] = '/' Then
        begin
          name2 := name;
          SetLength(name2, len - 1);
        end else
          continue;

        if file_GetDirectory(name2) = Directory Then
        begin
          SetLength(List.Items, List.Count + 1);
          List.Items[List.Count] := copy(name2, Length(Directory) + 1, len - 1);
          INC(List.Count);
        end;
      end else
      if (name[len - 1] <> '/') and (file_GetDirectory(name) = Directory) Then
      begin
        SetLength(List.Items, List.Count + 1);
        List.Items[List.Count] := utf8_Copy(file_GetName(name) + '.' + file_GetExtension(name));
        INC(List.Count);
      end;
    end;

    if List.Count > 2 Then
      u_SortList(List, 0, List.Count - 1);
    exit;
  end;
  {$ENDIF}

{$IF defined(UNIX) or DEFINED(MACOSX)}
  if FindDir Then
    type_ := 4
  else
    type_ := 8;

  {/$IfDef UNIX}{$IfNDef MACOSX}
  dir := FpOpenDir(filePath + Directory);
  {$ELSE}
  dir := FpOpenDir(platform_GetRes(filePath + Directory));
  {$ENDIF}
  repeat
    dirent := FpReadDir(dir^);
    if Assigned(dirent) and (dirent^.d_type = type_) Then
      begin
        SetLength(List.Items, List.Count + 1);
        List.Items[List.Count] := dirent^.d_name;
        INC(List.Count);
      end;
  until not Assigned(dirent);
  FpCloseDir(dir^);
{$IFEND}
{$IFDEF WINDOWS}
  wideStr := utf8_GetPWideChar(filePath + Directory + '*');
  First   := FindFirstFileW(wideStr, FList);
  FreeMem(wideStr);
  repeat
    if FindDir Then
    begin
      if FList.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0 Then
        continue;
    end else
      if FList.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY > 0 Then
        continue;
    SetLength(List.Items, List.Count + 1);
    List.Items[List.Count] := utf16_GetUTF8String(FList.cFileName);
    INC(List.Count);
  until not FindNextFileW(First, FList);
  FindClose(First);
{$ENDIF}
{$IFDEF iOS}
  path       := utf8_GetNSString(platform_GetRes(filePath + Directory));
  dirContent := iosFileManager.contentsOfDirectoryAtPath_error(path, error);
  iosFileManager.changeCurrentDirectoryPath(path);
  for i := 0 to dirContent.count() - 1 do
  begin
    if FindDir Then
    begin
      if (iosFileManager.fileExistsAtPath_isDirectory(dirContent.objectAtIndex(i), @isDirectory)) and (not isDirectory) Then
        continue;
    end else
      if (iosFileManager.fileExistsAtPath_isDirectory(dirContent.objectAtIndex(i), @isDirectory)) and (isDirectory) Then
        continue;

    SetLength(List.Items, List.Count + 1);
    FillChar(fileName[0], 256, 0);
    CFStringGetCString(CFStringRef(dirContent.objectAtIndex(i)), @fileName[0], 255, kCFStringEncodingUTF8);
    List.Items[List.Count] := PAnsiChar(@fileName[0]);
    INC(List.Count);
  end;
{$ENDIF}

  if List.Count > 2 Then
    u_SortList(List, 0, List.Count - 1);
end;

function GetStr(const Str: UTF8String; const Simbol: AnsiChar; const b: Boolean): UTF8String;
var
  i, pos, lenStr: Integer;
begin
  pos := 0;
  lenStr := Length(Str);
  for i := lenStr downto 1 do
    if Str[i] = Simbol Then
    begin
      pos := i;
      break;
    end;
  if b Then
    Result := copy(Str, 1, pos)
  else
    Result := copy(Str, lenStr - (lenStr - pos) + 1, (lenStr - pos));
end;

// èìÿ
function file_GetName(const FileName: UTF8String): UTF8String;
  var
    tmp: UTF8String;
begin
  Result := GetStr(FileName, '/', FALSE);
  {$IFDEF WINDOWS}
  if Result = FileName Then
    Result := GetStr(FileName, '\', FALSE);
  {$ENDIF}
  tmp := GetStr(Result, '.', FALSE);
  if Result <> tmp Then
    Result := copy(Result, 1, Length(Result) - Length(tmp) - 1);
end;

function file_GetExtension(const FileName: UTF8String): UTF8String;
var
  tmp: UTF8String;
begin
  tmp := GetStr(FileName, '/', FALSE);
  {$IFDEF WINDOWS}
  if tmp = FileName Then
    tmp := GetStr(FileName, '\', FALSE);
  {$ENDIF}
  Result := GetStr(tmp, '.', FALSE);
  if tmp = Result Then
    Result := '';
end;

function file_GetDirectory(const FileName: UTF8String): UTF8String;
begin

  {$IfNDef USE_INIT_HANDLE}
  Result := GetStr(FileName, '/', TRUE);
  {$IFDEF WINDOWS}
  if Result = '' Then
    Result := GetStr(FileName, '\', TRUE);
  {$ENDIF}
  {$Else}
  {$IfDef WINDOWS}
  Result := GetStr(FileName, '\', TRUE);
  {$Else}
  Result := GetStr(FileName, '/', TRUE);
  {$EndIf}
  {$EndIf}
end;

procedure file_SetPath(const Path: UTF8String);
begin
  filePath := GetDir(Path);
end;

{$IFDEF MACOSX}
function platform_GetRes(const FileName: UTF8String): UTF8String;
begin
  if (Length(FileName) > 0) and (FileName[1] <> '/') Then
    Result := appWorkDir + 'Contents/Resources/' + FileName
  else
    Result := FileName;
end;
{$ENDIF}
{$IFDEF iOS}
function platform_GetRes(const FileName: UTF8String): UTF8String;
begin
  if (Length(FileName) > 0) and (FileName[1] <> '/') Then
    Result := appWorkDir + FileName
  else
    Result := FileName;
end;
{$ENDIF}

{$IFDEF USE_ZIP}
function file_OpenArchive(const FileName: UTF8String; const Password: UTF8String = ''): Boolean;
var
  error: Integer;
  res  : zglTZIPResource;
begin
  if resUseThreaded Then
  begin
    Result       := TRUE;
    res.FileName := FileName;
    res.Password := Password;
    res_AddToQueue(RES_ZIP_OPEN, TRUE, @res);
    exit;
  end;

  {$IF DEFINED(MACOSX) or DEFINED(iOS)}
  zipCurrent := zip_open(PAnsiChar(platform_GetRes(filePath + FileName)), 0, error);
  {$ELSE}
  zipCurrent := zip_open(PAnsiChar(filePath + FileName), 0, error);                 
  {$IFEND}
  Result     := zipCurrent <> nil;
  log_Add('path: ' + filePath);
  log_Add('Name: ' + file_GetName(FileName) + '.' + file_GetExtension(FileName));

  if not Result Then
  begin
    log_Add('Unable to open archive: ' + FileName);
    exit;
  end;

  if Password = '' Then
    zip_set_default_password(zipCurrent, nil)
  else
    zip_set_default_password(zipCurrent, PAnsiChar(Password));
end;

procedure file_CloseArchive;
  var
    res: zglTZIPResource;
begin
  if resUseThreaded Then
    begin
      res.FileName := '';
      res.Password := '';
      res_AddToQueue(RES_ZIP_CLOSE, TRUE, @res);
      exit;
    end;

  zip_close(zipCurrent);
  zipCurrent := nil;
end;
{$ENDIF}

function _file_GetName(const FileName: UTF8String): PAnsiChar;
begin
  Result := utf8_GetPAnsiChar(file_GetName(FileName));
end;

function _file_GetExtension(const FileName: UTF8String): PAnsiChar;
begin
  Result := utf8_GetPAnsiChar(file_GetExtension(FileName));
end;

function _file_GetDirectory(const FileName: UTF8String): PAnsiChar;
begin
  Result := utf8_GetPAnsiChar(file_GetDirectory(FileName));
end;

{$IFDEF iOS}
initialization
  app_InitPool();
  iosFileManager := NSFileManager.alloc().init();

finalization
  iosFileManager.dealloc();
{$ENDIF}

end.
