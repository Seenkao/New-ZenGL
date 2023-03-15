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

unit zgl_sengine_2d;

{$I zgl_config.cfg}

interface

uses
  zgl_types;

type
  zglPSprite2D = ^zglTSprite2D;
  zglPSEngine2D = ^zglTSEngine2D;

  zglTSEngine2D = record
    Count: Integer;                                // общее количество спрайтов
    List : array of zglPSprite2D;                  // перепись всех "спрайтов"
  end;

  zglTSprite2D = record
    ID     : Integer;
    Manager: zglPSEngine2D;                        // указатель на менеджер спрайтов
    Texture: zglPTexture;
    Destroy: Boolean;
    Layer  : Integer;                              // что-то вроде глубины спрайта
    X, Y   : Single;
    W, H   : Single;
    Angle  : Single;                               // угол поворота?
    Frame  : Single;
    Alpha  : Integer;
    FxFlags: LongWord;

    OnInit : procedure(var Sprite);
    OnDraw : procedure(var Sprite);
    OnProc : procedure(var Sprite);
    OnFree : procedure(var Sprite);
  end;

function  sengine2d_AddSprite(Texture: zglPTexture; Layer: Integer; OnInit, OnDraw, OnProc, OnFree: Pointer): zglPSprite2D;
function  sengine2d_AddCustom(Texture: zglPTexture; Size: LongWord; Layer: Integer; OnInit, OnDraw, OnProc, OnFree: Pointer): zglPSprite2D;
procedure sengine2d_DelSprite(ID: Integer);
procedure sengine2d_ClearAll;

procedure sengine2d_Set(SEngine: zglPSEngine2D);
function  sengine2d_Get: zglPSEngine2D;
procedure sengine2d_Draw;
procedure sengine2d_Proc;

implementation
uses
  zgl_window,
  zgl_fx,
  zgl_sprite_2d;

var
  _sengine : zglTSEngine2D;
  sengine2d: zglPSEngine2D;
  {$IfDef LINUX}
  rs0: Single = 0;
  rs1: Single = 1;
  {$EndIf}

function sengine2d_AddSprite(Texture: zglPTexture; Layer: Integer; OnInit, OnDraw, OnProc, OnFree: Pointer): zglPSprite2D;
begin
  Result := sengine2d_AddCustom(Texture, SizeOf(zglTSprite2D), Layer, OnInit, OnDraw, OnProc, OnFree);
end;

function sengine2d_AddCustom(Texture: zglPTexture; Size: LongWord; Layer: Integer; OnInit, OnDraw, OnProc, OnFree: Pointer): zglPSprite2D;
var
  new: zglPSprite2D;
begin
  if sengine2d.Count + 1 > Length(sengine2d.List) Then
    SetLength(sengine2d.List, Length(sengine2d.List) + 1024);

  zgl_GetMem(Pointer(new), Size);
  sengine2d.List[sengine2d.Count] := new;

  new.ID      := sengine2d.Count;

  INC(sengine2d.Count);

  new.Manager := sengine2d;

  new.Texture := Texture;
  new.Layer   := Layer;
  new.X       := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  new.Y       := {$IfDef LINUX}rs0{$Else}0{$EndIf};

  new.W       := Round((Texture.FramesCoord[1, 1].X - Texture.FramesCoord[1, 0].X) * Texture.Width / Texture.U);
  new.H       := Round((Texture.FramesCoord[1, 0].Y - Texture.FramesCoord[1, 2].Y) * Texture.Height / Texture.V);

  new.Angle   := {$IfDef LINUX}rs0{$Else}0{$EndIf};
  new.Frame   := {$IfDef LINUX}rs1{$Else}1{$EndIf};
  new.Alpha   := 255;
  new.FxFlags := FX_BLEND;
  new.OnInit  := OnInit;
  new.OnDraw  := OnDraw;
  new.OnProc  := OnProc;
  new.OnFree  := OnFree;
  Result      := new;
  if Assigned(Result.OnInit) Then
    // инициализируем объект, если это надо.
    Result.OnInit(Result^);
end;

procedure sengine2d_DelSprite(ID: Integer);
var
  i: Integer;
begin
  if (ID < 0) or (ID > sengine2d.Count - 1) or (sengine2d.Count = 0) Then
    exit;

  if Assigned(sengine2d.List[ID].OnFree) Then
    sengine2d.List[ID].OnFree(sengine2d.List[ID]^);

  FreeMem(sengine2d.List[ID]);
  sengine2d.List[ID] := nil;
  for i := ID to sengine2d.Count - 2 do
  begin
    sengine2d.List[i]    := sengine2d.List[i + 1];
    sengine2d.List[i].ID := i;
  end;

  DEC(sengine2d.Count);
end;

procedure sengine2d_ClearAll;
  var
    i: Integer;
    s: zglPSprite2D;
begin
  for i := 0 to sengine2d.Count - 1 do
    begin
      s := sengine2d.List[i];
      if Assigned(s.OnFree) Then
        sengine2d.List[i].OnFree(s^);
      FreeMem(s);
    end;
  SetLength(sengine2d.List, 0);
  sengine2d.Count := 0;
end;

procedure sengine2d_Set(SEngine: zglPSEngine2D);
begin
  if Assigned(SEngine) Then
    sengine2d := SEngine
  else
    sengine2d := @_sengine;
end;

function sengine2d_Get: zglPSEngine2D;
begin
  Result := sengine2d;
end;

procedure sengine2d_Draw;
var
  i: Integer;
  s: zglPSprite2D;
begin
  i := 0;
  while i < sengine2d.Count do
  begin
    s := sengine2d.List[i];
    if Assigned(s.OnDraw) Then
      s.OnDraw(s^)
    else
      asprite2d_Draw(s.Texture, s.X, s.Y, s.W, s.H, s.Angle, Round(s.Frame), s.Alpha, s.FxFlags);

    if Assigned(s) Then
    begin
      if s.Destroy Then
        sengine2d_DelSprite(s.ID)
      else
        INC(i);
    end;
  end;
end;

procedure sengine2d_Sort(iLo, iHi: Integer);
var
  lo, hi, mid: Integer;
  t: zglPSprite2D;
begin
  lo   := iLo;
  hi   := iHi;
  mid  := sengine2d.List[(lo + hi) shr 1].Layer;

  with sengine2d^ do
  repeat
    while List[lo].Layer < mid do
      INC(lo);
    while List[hi].Layer > mid do
      DEC(hi);
    if lo <= hi then
    begin
      t          := List[lo];
      List[lo] := List[hi];
      List[hi] := t;
      INC(lo);
      DEC(hi);
    end;
  until lo > hi;

  if hi > iLo Then
    sengine2d_Sort(iLo, hi);
  if lo < iHi Then
    sengine2d_Sort(lo, iHi);
end;

procedure sengine2d_SortID(iLo, iHi: Integer);
var
  lo, hi, mid: Integer;
  t: zglPSprite2D;
begin
  lo   := iLo;
  hi   := iHi;
  mid  := sengine2d.List[(lo + hi) shr 1].ID;

  with sengine2d^ do
  repeat
    while List[lo].ID < mid do
      INC(lo);
    while List[hi].ID > mid do
      DEC(hi);
    if lo <= hi then
    begin
      t          := List[lo];
      List[lo] := List[hi];
      List[hi] := t;
      INC(lo);
      DEC(hi);
    end;
  until lo > hi;

  if hi > iLo Then
    sengine2d_SortID(iLo, hi);
  if lo < iHi Then
    sengine2d_SortID(lo, iHi);
end;

procedure sengine2d_Proc;
var
  i, a, b, l: Integer;
  s         : zglPSprite2D;
begin
  i := 0;
  while i < sengine2d.Count do
  begin
    s := sengine2d.List[i];
    if Assigned(s.OnProc) Then
      s.OnProc(s^);                       

    if Assigned(s) Then
    begin
      if s.Destroy Then
        sengine2d_DelSprite(s.ID)
      else
        INC(i);
    end;
  end;

  if sengine2d.Count > 1 Then
  begin
    l := 0;
    for i := 0 to sengine2d.Count - 1 do
    begin
      s := sengine2d.List[i];
      if s.Layer > l Then
        l := s.Layer;
      if s.Layer < l Then
      begin
        sengine2d_Sort(0, sengine2d.Count - 1);
        // TODO: provide parameter for enabling/disabling stable sorting
        l := sengine2d.List[0].Layer;
        a := 0;
        for b := 0 to sengine2d.Count - 1 do
        begin
          s := sengine2d.List[b];
          if (l <> s.Layer) Then
          begin
            sengine2d_SortID(a, b - 1);
            a := b;
            l := s.Layer;
          end;
          if b = sengine2d.Count - 1 Then
            sengine2d_SortID(a, b);
        end;
        for a := 0 to sengine2d.Count - 1 do
          sengine2d.List[a].ID := a;
        break;
      end;
    end;
  end;
end;

initialization
  sengine2d := @_sengine;

end.
