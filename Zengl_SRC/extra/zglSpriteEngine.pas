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
unit zglSpriteEngine;

{$I zglCustomConfig.cfg}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface
uses
  zgl_window,
  zgl_fx,
  zgl_sprite_2d,
  zgl_textures,
  zgl_types;

type
  zglCSprite2D  = class;
//  zglCSEngine2D = class;

  zglCSEngine2D = class
  protected
    FCount : Integer;
    FList  : array of zglCSprite2D;

    procedure SortByLayer( iLo, iHi : Integer );
    procedure SortByID( iLo, iHi : Integer );

    function  GetSprite( ID : Integer ) : zglCSprite2D;
    procedure SetSprite( ID : Integer; Sprite : zglCSprite2D );
  public
    destructor Destroy; override;

    function  AddSprite : Integer; overload; virtual;
    function  AddSprite( Texture : zglPTexture; Layer : Integer ) : zglCSprite2D; overload; virtual;
    procedure AddSprite( Sprite : zglCSprite2D; Layer : Integer ); overload; virtual;
    procedure DelSprite( ID : Integer ); virtual;
    procedure ClearAll; virtual;

    procedure Draw; virtual;
    procedure Proc; virtual;

    property Count: Integer read FCount;
    property List[ID : Integer]: zglCSprite2D read GetSprite write SetSprite;
  end;

  zglCSprite2D = class
  protected
  public
    ID      : Integer;
    Manager : zglCSEngine2D;
    Texture : zglPTexture;
    Kill    : Boolean;
    Layer   : Integer;
    X, Y    : Single;
    W, H    : Single;
    Angle   : Single;
    Frame   : Single;
    Alpha   : Integer;
    FxFlags : LongWord;

    constructor Create( _Manager : zglCSEngine2D; _ID : Integer ); virtual;
    destructor  Destroy; override;

    procedure OnInit( _Texture : zglPTexture; _Layer : Integer ); virtual;
    procedure OnDraw; virtual;
    procedure OnProc; virtual;
    procedure OnFree; virtual;
  end;

implementation

destructor zglCSEngine2D.Destroy;
begin
  ClearAll();
end;

procedure zglCSEngine2D.SortByLayer( iLo, iHi : Integer );
  var
    lo, hi, mid : Integer;
    t : zglCSprite2D;
begin
  lo   := iLo;
  hi   := iHi;
  mid  := FList[ ( lo + hi ) shr 1 ].Layer;

  repeat
    while FList[ lo ].Layer < mid do INC( lo );
    while FList[ hi ].Layer > mid do DEC( hi );
    if lo <= hi then
      begin
        t           := FList[ lo ];
        FList[ lo ] := FList[ hi ];
        FList[ hi ] := t;
        INC( lo );
        DEC( hi );
      end;
  until lo > hi;

  if hi > iLo Then SortByLayer( iLo, hi );
  if lo < iHi Then SortByLayer( lo, iHi );
end;

procedure zglCSEngine2D.SortByID( iLo, iHi : Integer );
  var
    lo, hi, mid : Integer;
    t : zglCSprite2D;
begin
  lo   := iLo;
  hi   := iHi;
  mid  := FList[ ( lo + hi ) shr 1 ].ID;

  repeat
    while FList[ lo ].ID < mid do INC( lo );
    while FList[ hi ].ID > mid do DEC( hi );
    if Lo <= Hi then
      begin
        t           := FList[ lo ];
        FList[ lo ] := FList[ hi ];
        FList[ hi ] := t;
        INC( lo );
        DEC( hi );
      end;
  until lo > hi;

  if hi > iLo Then SortByID( iLo, hi );
  if lo < iHi Then SortByID( lo, iHi );
end;

function zglCSEngine2D.GetSprite( ID : Integer ) : zglCSprite2D;
begin
  Result := FList[ ID ];
end;

procedure zglCSEngine2D.SetSprite( ID : Integer; Sprite : zglCSprite2D );
begin
  FList[ ID ] := Sprite;
end;

function zglCSEngine2D.AddSprite : Integer;
begin
  if FCount + 1 > Length( FList ) Then
    SetLength( FList, FCount + 16384 );
  Result := FCount;
  INC( FCount );
end;

function zglCSEngine2D.AddSprite( Texture : zglPTexture; Layer : Integer ) : zglCSprite2D;
  var
    id : Integer;
begin
  id := AddSprite();

  FList[ id ] := zglCSprite2D.Create( Self, id );
  Result := FList[ id ];
  Result.OnInit( Texture, Layer );
end;

procedure zglCSEngine2D.AddSprite( Sprite : zglCSprite2D; Layer : Integer );
  var
    id : Integer;
begin
  if not Assigned( Sprite ) Then exit;
  id := AddSprite();

  FList[ id ]         := Sprite;
  FList[ id ].Manager := Self;
  FList[ id ].ID      := id;
  FList[ id ].OnInit( Sprite.Texture, Layer );
end;

procedure zglCSEngine2D.DelSprite( ID : Integer );
  var
    i : Integer;
begin
  if ( ID < 0 ) or ( ID > FCount - 1 ) or ( FCount = 0 ) Then exit;

  FList[ ID ].Free;

  for i := ID to FCount - 2 do
    begin
      FList[ i ]    := FList[ i + 1 ];
      FList[ i ].ID := i;
    end;

  DEC( FCount );
end;

procedure zglCSEngine2D.ClearAll;
  var
    i : Integer;
begin
  for i := 0 to FCount - 1 do
    FList[ i ].Destroy();
  SetLength( FList, 0 );
  FCount := 0;
end;

procedure zglCSEngine2D.Draw;
  var
    i : Integer;
    s : zglCSprite2D;
begin
  i := 0;
  while i < FCount do
    begin
      s := FList[ i ];
      s.OnDraw();

      if s.Kill Then
        DelSprite( s.ID )
      else
        INC( i );
    end;
end;

procedure zglCSEngine2D.Proc;
  var
    i, a, b, l : Integer;
    s          : zglCSprite2D;
begin
  i := 0;
  while i < FCount do
    begin
      s := FList[ i ];
      s.OnProc();

      if s.Kill Then
        DelSprite( s.ID )
      else
        INC( i );
    end;

  if FCount > 1 Then
    begin
      l := 0;
      for i := 0 to FCount - 1 do
        begin
          s := FList[ i ];
          if s.Layer > l Then l := s.Layer;
          if s.Layer < l Then
            begin
              SortByLayer( 0, FCount - 1 );
              // TODO: provide parameter for enabling/disabling stable sorting
              l := FList[ 0 ].Layer;
              a := 0;
              for b := 0 to FCount - 1 do
                begin
                  s := FList[ b ];
                  if ( l <> s.Layer ) Then
                    begin
                      SortByID( a, b - 1 );
                      a := b;
                      l := s.Layer;
                    end;
                  if b = FCount - 1 Then
                    SortByID( a, b );
                end;
              for a := 0 to FCount - 1 do
                FList[ a ].ID := a;
              break;
            end;
        end;
    end;
end;

constructor zglCSprite2D.Create( _Manager : zglCSEngine2D; _ID : Integer );
begin
  Manager := _Manager;
  ID      := _ID;

  OnInit( nil, 0 );
end;

destructor zglCSprite2D.Destroy;
begin
  OnFree();
end;

procedure zglCSprite2D.OnInit( _Texture : zglPTexture; _Layer : Integer );
begin
  Texture := _Texture;
  Layer   := _Layer;
  X       := 0;
  Y       := 0;
  if Assigned( Texture ) Then
    begin
      W := Round( ( Texture.FramesCoord[ 1, 1 ].X - Texture.FramesCoord[ 1, 0 ].X ) * Texture.Width / Texture.U );
      H := Round( ( Texture.FramesCoord[ 1, 0 ].Y - Texture.FramesCoord[ 1, 2 ].Y ) * Texture.Height / Texture.V );
    end else
      begin
        W := 0;
        H := 0;
      end;
  Angle   := 0;
  Frame   := 1;
  Alpha   := 255;
  FxFlags := FX_BLEND;
end;

procedure zglCSprite2D.OnDraw;
begin
  asprite2d_Draw( Texture, X, Y, W, H, Angle, Round( Frame ), Alpha, FxFlags );
end;

procedure zglCSprite2D.OnProc;
begin
end;

procedure zglCSprite2D.OnFree;
begin
end;

end.
