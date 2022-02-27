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

 !!! modification from Serge 04.08.2020
}
unit zgl_particles_2d;

{$I zgl_config.cfg}

interface
uses
  zgl_textures,
  zgl_types,
  zgl_math_2d,
  zgl_file,
  zgl_gltypeconst,
  zgl_memory;

const
  ZGL_EMITTER_2D : array[ 0..14 ] of AnsiChar = ( 'Z', 'G', 'L', '_', 'E', 'M', 'I', 'T', 'T', 'E', 'R', '_', '2', 'D', #0 );

  ZEF_CHUNK_TYPE      = $01;
  ZEF_CHUNK_PARAMS    = $02;
  ZEF_CHUNK_TEXTURE   = $03;
  ZEF_CHUNK_BLENDMODE = $04;
  ZEF_CHUNK_COLORMODE = $05;
  ZEF_CHUNK_LIFETIME  = $06;
  ZEF_CHUNK_FRAME     = $07;
  ZEF_CHUNK_COLOR     = $08;
  ZEF_CHUNK_SIZEXY    = $09;
  ZEF_CHUNK_ANGLE     = $0A;
  ZEF_CHUNK_VELOCITY  = $0B;
  ZEF_CHUNK_AVELOCITY = $0C;
  ZEF_CHUNK_SPIN      = $0D;

  EMITTER_MAX_PARTICLES = 1024;

  EMITTER_NONE      = 0;
  EMITTER_POINT     = 1;
  EMITTER_LINE      = 2;
  EMITTER_RECTANGLE = 3;
  EMITTER_CIRCLE    = 4;
  EMITTER_RING      = 5;

type
  PDiagramByte         = ^TDiagramByte;
  PDiagramLW           = ^TDiagramLW;
  PDiagramSingle       = ^TDiagramSingle;
  zglPParticle2D       = ^zglTParticle2D;
  zglPEmitterPoint     = ^zglTEmitterPoint;
  zglPEmitterLine      = ^zglTEmitterLine;
  zglPEmitterRect      = ^zglTEmitterRect;
  zglPEmitterCircle    = ^zglTEmitterCircle;
  zglPEmitterRing      = ^zglTEmitterRing;
  zglPParticleParams   = ^zglTParticleParams;
  zglPEmitter2D        = ^zglTEmitter2D;
  zglPPEmitter2D       = ^zglPEmitter2D;
  zglPPEngine2D        = ^zglTPEngine2D;
  zglPEmitter2DManager = ^zglTEmitter2DManager;

  TDiagramByte = record
    Life  : Single;
    Value : Byte;
  end;

  TDiagramLW = record
    Life  : Single;
    Value : LongWord;
  end;

  TDiagramSingle = record
    Life  : Single;
    Value : Single;
  end;

  zglTParticle2D = record
    _private   : record
      lColorID     : Integer;
      lAlphaID     : Integer;
      lSizeXID     : Integer;
      lSizeYID     : Integer;
      lVelocityID  : Integer;
      laVelocityID : Integer;
      lSpinID      : Integer;
                    end;

    ID         : Integer;

    Life       : Single;
    LifeTime   : Integer;
    Time       : Double;

    Frame      : Word;
    Color      : LongWord;
    Alpha      : Byte;

    Position   : zglTPoint2D;
    Size       : zglTPoint2D;
    SizeS      : zglTPoint2D;
    Angle      : Single;
    Direction  : Single;

    Velocity   : Single;
    VelocityS  : Single;
    aVelocity  : Single;
    aVelocityS : Single;
    Spin       : Single;
  end;

  zglTEmitterPoint = record
    Direction : Single;
    Spread    : Single;
  end;

  zglTEmitterLine = record
    Direction : Single;
    Spread    : Single;
    Size      : Single;
    TwoSide   : Boolean;
  end;

  zglTEmitterRect = record
    Direction : Single;
    Spread    : Single;
    Rect      : zglTRect2D;
  end;

  zglTEmitterCircle = record
    Direction : Single;
    Spread    : Single;
    cX, cY    : Single;
    Radius    : Single;
  end;

  zglTEmitterRing = record
    Direction : Single;
    Spread    : Single;
    cX, cY    : Single;
    Radius0   : Single;
    Radius1   : Single;
  end;

  zglTParticleParams = record
    Texture    : zglPTexture;
    BlendMode  : Byte;
    ColorMode  : Byte;

    LifeTimeS  : Integer;
    LifeTimeV  : Integer;
    Frame      : array[ 0..1 ] of Integer;
    Color      : array of TDiagramLW;
    Alpha      : array of TDiagramByte;
    SizeXYBind : Boolean;
    SizeXS     : Single;
    SizeYS     : Single;
    SizeXV     : Single;
    SizeYV     : Single;
    SizeXD     : array of TDiagramSingle;
    SizeYD     : array of TDiagramSingle;
    AngleS     : Single;
    AngleV     : Single;
    VelocityS  : Single;
    VelocityV  : Single;
    VelocityD  : array of TDiagramSingle;
    aVelocityS : Single;
    aVelocityV : Single;
    aVelocityD : array of TDiagramSingle;
    SpinS      : Single;
    SpinV      : Single;
    SpinD      : array of TDiagramSingle;
  end;

  zglTEmitter2D = record
    _private   : record
      pengine    : zglPPEngine2D;
      particle   : array[ 0..EMITTER_MAX_PARTICLES - 1 ] of zglTParticle2D;
      list       : array[ 0..EMITTER_MAX_PARTICLES - 1 ] of zglPParticle2D;
      parCreated : Integer;
      texFile    : UTF8String;
      texHash    : LongWord;
                 end;

    ID         : Integer;
    Type_      : Byte;
    Params     : record
      Layer    : Integer;
      LifeTime : Integer;
      Loop     : Boolean;
      Emission : Integer;
      Position : zglTPoint2D;
                 end;
    ParParams  : zglTParticleParams;

    Life       : Single;
    Time       : Double;
    LastSecond : Double;
    Particles  : Integer;
    BBox       : record
      MinX, MaxX : Single;
      MinY, MaxY : Single;
                  end;

    case Byte of
      EMITTER_POINT: ( AsPoint : zglTEmitterPoint );
      EMITTER_LINE: ( AsLine : zglTEmitterLine );
      EMITTER_RECTANGLE: ( AsRect : zglTEmitterRect );
      EMITTER_CIRCLE: ( AsCircle : zglTEmitterCircle );
      EMITTER_RING: ( AsRing : zglTEmitterRing );
  end;

  zglTPEngine2D = record
    Count : record
      Emitters  : Integer;
      Particles : Integer;
            end;
    List  : array of zglPEmitter2D;
    ListU : array of zglPPEmitter2D;
  end;

  zglTEmitter2DManager = record
    Count : Integer;
    List  : array of zglPEmitter2D;
  end;

procedure pengine2d_Set( PEngine : zglPPEngine2D );
function  pengine2d_Get : zglPPEngine2D;
procedure pengine2d_Draw;
procedure pengine2d_Proc( dt : Double );
procedure pengine2d_AddEmitter( Emitter : zglPEmitter2D; Result : zglPPEmitter2D = nil; X : Single = 0; Y : Single = 0 );
procedure pengine2d_DelEmitter( ID : Integer );
procedure pengine2d_ClearAll;

function  emitter2d_Add : zglPEmitter2D;
procedure emitter2d_Del( var Emitter : zglPEmitter2D );
function  emitter2d_Load( const FileName : UTF8String ) : zglPEmitter2D;
function  emitter2d_LoadFromFile( const FileName : UTF8String ) : zglPEmitter2D;
function  emitter2d_LoadFromMemory( const Memory : zglTMemory ) : zglPEmitter2D;
{$IFDEF ANDROID}
procedure emitter2d_RestoreAll;
{$ENDIF}
procedure emitter2d_SaveToFile( Emitter : zglPEmitter2D; const FileName : UTF8String );
procedure emitter2d_Init( Emitter : zglPEmitter2D );
procedure emitter2d_Free( var Emitter : zglPEmitter2D );
procedure emitter2d_Draw( Emitter : zglPEmitter2D );
procedure emitter2d_Proc( Emitter : zglPEmitter2D; dt : Double );

var
  managerEmitter2D : zglTEmitter2DManager;

implementation
uses
  zgl_window,
  zgl_log,
  {$IFNDEF USE_GLES}
  //zgl_opengl,
  zgl_opengl_all,
  {$ELSE}
  zgl_opengles,
  zgl_opengles_all,
  {$ENDIF}
  zgl_fx,
  zgl_render_2d,
  zgl_utils;

var
  _pengine     : zglTPEngine2D;
  pengine2d    : zglPPEngine2D;
  emitter2dMem : zglTMemory;
  emitter2dID  : array[ 0..14 ] of AnsiChar;

procedure pengine2d_Set( PEngine : zglPPEngine2D );
begin
  if Assigned( PEngine ) Then
    pengine2d := PEngine
  else
    pengine2d := @_pengine;
end;

function pengine2d_Get : zglPPEngine2D;
begin
  Result := pengine2d;
end;

procedure pengine2d_Sort( iLo, iHi : Integer );
  var
    lo, hi, mid : Integer;
    t  : zglPEmitter2D;
    tU : zglPPEmitter2D;
begin
  lo   := iLo;
  hi   := iHi;
  mid  := pengine2d.List[ ( lo + hi ) shr 1 ].Params.Layer;

  with pengine2d^ do
  repeat
    while List[ lo ].Params.Layer < mid do INC( lo );
    while List[ hi ].Params.Layer > mid do DEC( hi );
    if lo <= hi then
      begin
        t           := List[ lo ];
        List[ lo ]  := List[ hi ];
        List[ hi ]  := t;
        tU          := ListU[ lo ];
        ListU[ lo ] := ListU[ hi ];
        ListU[ hi ] := tU;
        INC( lo );
        DEC( hi );
      end;
  until lo > hi;

  if hi > iLo Then pengine2d_Sort( iLo, hi );
  if lo < iHi Then pengine2d_Sort( lo, iHi );
end;

procedure pengine2d_SortID( iLo, iHi : Integer );
  var
    lo, hi, mid : Integer;
    t  : zglPEmitter2D;
    tU : zglPPEmitter2D;
begin
  lo   := iLo;
  hi   := iHi;
  mid  := pengine2d.List[ ( lo + hi ) shr 1 ].ID;

  with pengine2d^ do
  repeat
    while List[ lo ].ID < mid do INC( lo );
    while List[ hi ].ID > mid do DEC( hi );
    if lo <= hi then
      begin
        t           := List[ lo ];
        List[ lo ]  := List[ hi ];
        List[ hi ]  := t;
        tU          := ListU[ lo ];
        ListU[ lo ] := ListU[ hi ];
        ListU[ hi ] := tU;
        INC( lo );
        DEC( hi );
      end;
  until lo > hi;

  if hi > iLo Then pengine2d_SortID( iLo, hi );
  if lo < iHi Then pengine2d_SortID( lo, iHi );
end;

procedure pengine2d_Draw;
  var
    i            : Integer;
    oldBlendMode : LongWord;
    oldColorMode : LongWord;
begin
  oldBlendMode := b2dCurBlendMode;
  oldColorMode := b2dCurColorMode;

  for i := 0 to pengine2d.Count.Emitters - 1 do
    emitter2d_Draw( pengine2d.List[ i ] );

  if oldBlendMode <> b2dCurBlendMode Then
    fx_SetBlendMode( Byte( oldBlendMode ) );
  if oldColorMode <> b2dCurColorMode Then
    fx_SetColorMode( Byte( oldColorMode ) );
end;

procedure pengine2d_Proc( dt : Double );
  var
    i, a, b, l : Integer;
    e          : zglPEmitter2D;
begin
  i := 0;
  pengine2d.Count.Particles := 0;
  while i < pengine2d.Count.Emitters do
    begin
      e := pengine2d.List[ i ];
      emitter2d_Proc( e, dt );
      if ( e.Life <= 0 ) and ( not e.Params.Loop ) and ( e.Particles = 0 ) Then
        pengine2d_DelEmitter( i )
      else
        begin
          INC( i );
          INC( pengine2d.Count.Particles, e.Particles );
        end;
    end;

  if pengine2d.Count.Emitters > 1 Then
    begin
      l := 0;
      for i := 0 to pengine2d.Count.Emitters - 1 do
        begin
          e := pengine2d.List[ i ];
          if e.Params.Layer > l Then l := e.Params.Layer;
          if e.Params.Layer < l Then
            begin
              pengine2d_Sort( 0, pengine2d.Count.Emitters - 1 );
              // TODO: provide parameter for enabling/disabling stable sorting
              l := pengine2d.List[ 0 ].Params.Layer;
              a := 0;
              for b := 0 to pengine2d.Count.Emitters - 1 do
                begin
                  e := pengine2d.List[ b ];
                  if ( l <> e.Params.Layer ) Then
                    begin
                      pengine2d_SortID( a, b - 1 );
                      a := b;
                      l := e.Params.Layer;
                    end;
                  if b = pengine2d.Count.Emitters - 1 Then
                    pengine2d_SortID( a, b );
                end;
              for a := 0 to pengine2d.Count.Emitters - 1 do
                pengine2d.List[ a ].ID := a;
              break;
            end;
        end;
    end;
end;

procedure pengine2d_AddEmitter( Emitter : zglPEmitter2D; Result : zglPPEmitter2D = nil; X : Single = 0; Y : Single = 0 );
  var
    new : zglPEmitter2D;
    len : Integer;
begin
  if not Assigned( Emitter ) Then exit;

  if pengine2d.Count.Emitters + 1 > Length( pengine2d.List ) Then
    begin
      SetLength( pengine2d.List, Length( pengine2d.List ) + 1024 );
      SetLength( pengine2d.ListU, Length( pengine2d.ListU ) + 1024 );
    end;

  zgl_GetMem( Pointer( new ), SizeOf( zglTEmitter2D ) );
  pengine2d.List[ pengine2d.Count.Emitters ]  := new;
  pengine2d.ListU[ pengine2d.Count.Emitters ] := Result;
  INC( pengine2d.Count.Emitters );

  with new^, new._private do
    begin
      pengine     := pengine2d;
      parCreated  := Emitter._private.parCreated;
      texFile     := Emitter._private.texFile;
      texHash     := Emitter._private.texHash;
      ID          := pengine2d.Count.Emitters - 1;
      Type_       := Emitter.Type_;
      Params      := Emitter.Params;
      Life        := Emitter.Life;
      Time        := Emitter.Time;
      LastSecond  := Emitter.LastSecond;
      Particles   := Emitter.Particles;
      BBox        := Emitter.BBox;
      case Type_ of
        EMITTER_POINT:     AsPoint  := Emitter.AsPoint;
        EMITTER_LINE:      AsLine   := Emitter.AsLine;
        EMITTER_RECTANGLE: AsRect   := Emitter.AsRect;
        EMITTER_CIRCLE:    AsCircle := Emitter.AsCircle;
        EMITTER_RING:      AsRing   := Emitter.AsRing;
      end;
      with ParParams do
        begin
          Texture   := Emitter.ParParams.Texture;
          BlendMode := Emitter.ParParams.BlendMode;
          ColorMode := Emitter.ParParams.ColorMode;

          LifeTimeS := Emitter.ParParams.LifeTimeS;
          LifeTimeV := Emitter.ParParams.LifeTimeV;
          Frame     := Emitter.ParParams.Frame;

          len := Length( Emitter.ParParams.Color );
          SetLength( Color, len );
          if len > 0 Then
            Move( Emitter.ParParams.Color[ 0 ], Color[ 0 ], len * SizeOf( Color[ 0 ] ) );

          len := Length( Emitter.ParParams.Alpha );
          SetLength( Alpha, len );
          if len > 0 Then
            Move( Emitter.ParParams.Alpha[ 0 ], Alpha[ 0 ], len * SizeOf( Alpha[ 0 ] ) );

          SizeXYBind := Emitter.ParParams.SizeXYBind;
          SizeXS := Emitter.ParParams.SizeXS;
          SizeYS := Emitter.ParParams.SizeYS;
          SizeXV := Emitter.ParParams.SizeXV;
          SizeYV := Emitter.ParParams.SizeYV;

          len := Length( Emitter.ParParams.SizeXD );
          SetLength( SizeXD, len );
          if len > 0 Then
            Move( Emitter.ParParams.SizeXD[ 0 ], SizeXD[ 0 ], len * SizeOf( SizeXD[ 0 ] ) );

          len := Length( Emitter.ParParams.SizeYD );
          SetLength( SizeYD, len );
          if len > 0 Then
            Move( Emitter.ParParams.SizeYD[ 0 ], SizeYD[ 0 ], len * SizeOf( SizeYD[ 0 ] ) );

          AngleS    := Emitter.ParParams.AngleS;
          AngleV    := Emitter.ParParams.AngleV;
          VelocityS := Emitter.ParParams.VelocityS;
          VelocityV := Emitter.ParParams.VelocityV;

          len := Length( Emitter.ParParams.VelocityD );
          SetLength( VelocityD, len );
          if len > 0 Then
            Move( Emitter.ParParams.VelocityD[ 0 ], VelocityD[ 0 ], len * SizeOf( VelocityD[ 0 ] ) );

          aVelocityS := Emitter.ParParams.aVelocityS;
          aVelocityV := Emitter.ParParams.aVelocityV;

          len := Length( Emitter.ParParams.aVelocityD );
          SetLength( aVelocityD, len );
          if len > 0 Then
            Move( Emitter.ParParams.aVelocityD[ 0 ], aVelocityD[ 0 ], len * SizeOf( aVelocityD[ 0 ] ) );

          SpinS := Emitter.ParParams.SpinS;
          SpinV := Emitter.ParParams.SpinV;

          len := Length( Emitter.ParParams.SpinD );
          SetLength( SpinD, len );
          if len > 0 Then
            Move( Emitter.ParParams.SpinD[ 0 ], SpinD[ 0 ], len * SizeOf( SpinD[ 0 ] ) );
        end;

      Params.Position.X := Params.Position.X + X;
      Params.Position.Y := Params.Position.Y + Y;
      Move( Emitter._private.particle[ 0 ], particle[ 0 ], Emitter.Particles * SizeOf( zglTParticle2D ) );
    end;

  emitter2d_Init( new );

  if Assigned( Result ) Then
    Result^ := new;
end;

procedure pengine2d_DelEmitter( ID : Integer );
begin
  if ( ID < 0 ) or ( ID > pengine2d.Count.Emitters - 1 ) Then exit;

  if Assigned( pengine2d.ListU[ ID ] ) Then
    pengine2d.ListU[ ID ]^ := nil;
  emitter2d_Free( pengine2d.List[ ID ] );
  pengine2d.List[ ID ]    := pengine2d.List[ pengine2d.Count.Emitters - 1 ];
  if pengine2d.List[ ID ] <> nil Then
    pengine2d.List[ ID ].ID := ID;
  pengine2d.ListU[ ID ]   := pengine2d.ListU[ pengine2d.Count.Emitters - 1 ];
  DEC( pengine2d.Count.Emitters );
end;

procedure pengine2d_ClearAll;
  var
    i : Integer;
begin
  for i := 0 to pengine2d.Count.Emitters - 1 do
    begin
      if Assigned( pengine2d.ListU[ i ] ) Then
        pengine2d.ListU[ i ]^ := nil;
      emitter2d_Free( pengine2d.List[ i ] );
    end;
  SetLength( pengine2d.List, 0 );
  SetLength( pengine2d.ListU, 0 );
  pengine2d.Count.Emitters := 0;
end;

procedure particle2d_Proc( Particle : zglPParticle2D; Params : zglPParticleParams; dt : Double );
  var
    coeff        : Single;
    speed        : Single;
    iLife        : Single;
    r, g, b      : Byte;
    rn, gn, bn   : Byte;
    rp, gp, bp   : Byte;
    prevB, nextB : PDiagramByte;
    prevL, nextL : PDiagramLW;
    prevS, nextS : PDiagramSingle;
begin
  with Particle^, Particle._private do
    begin
      Time  := Time + dt;
      iLife := Time / LifeTime;
      Life  := 1 - iLife;
      if Life > 0 Then
        begin
          // Frame
          Frame := Params.Frame[ 0 ] + Round( ( Params.Frame[ 1 ] - Params.Frame[ 0 ] ) * iLife );

          // Color
          if Length( Params.Color ) > 0 Then
            begin
              while iLife > Params.Color[ lColorID ].Life do INC( lColorID );
              prevL := @Params.Color[ lColorID - 1 ];
              nextL := @Params.Color[ lColorID ];
              coeff := ( iLife - prevL.Life ) / ( nextL.Life - prevL.Life );
              rn    :=   nextL.Value             shr 16;
              gn    := ( nextL.Value and $FF00 ) shr 8;
              bn    :=   nextL.Value and $FF;
              rp    :=   prevL.Value             shr 16;
              gp    := ( prevL.Value and $FF00 ) shr 8;
              bp    :=   prevL.Value and $FF;
              r     := rp + Round( ( rn - rp ) * coeff );
              g     := gp + Round( ( gn - gp ) * coeff );
              b     := bp + Round( ( bn - bp ) * coeff );
              Color := r shl 16 + g shl 8 + b;
            end else
              Color := $FFFFFF;

          // Alpha
          while iLife > Params.Alpha[ lAlphaID ].Life do INC( lAlphaID );
          prevB := @Params.Alpha[ lAlphaID - 1 ];
          nextB := @Params.Alpha[ lAlphaID ];
          Alpha := prevB.Value + Round( ( nextB.Value - prevB.Value ) * ( iLife - prevB.Life ) / ( nextB.Life - prevB.Life ) );

          // Size
          while iLife > Params.SizeXD[ lSizeXID ].Life do INC( lSizeXID );
          while iLife > Params.SizeYD[ lSizeYID ].Life do INC( lSizeYID );
          prevS  := @Params.SizeXD[ lSizeXID - 1 ];
          nextS  := @Params.SizeXD[ lSizeXID ];
          Size.X := SizeS.X * ( prevS.Value + ( nextS.Value - prevS.Value ) * ( iLife - prevS.Life ) / ( nextS.Life - prevS.Life ) );
          prevS  := @Params.SizeYD[ lSizeYID - 1 ];
          nextS  := @Params.SizeYD[ lSizeYID ];
          Size.Y := SizeS.Y * ( prevS.Value + ( nextS.Value - prevS.Value ) * ( iLife - prevS.Life ) / ( nextS.Life - prevS.Life ) );

          // Velocity
          while iLife > Params.VelocityD[ lVelocityID ].Life do INC( lVelocityID );
          prevS      := @Params.VelocityD[ lVelocityID - 1 ];
          nextS      := @Params.VelocityD[ lVelocityID ];
          Velocity   := VelocityS * ( prevS.Value + ( nextS.Value - prevS.Value ) * ( iLife - prevS.Life ) / ( nextS.Life - prevS.Life ) );
          coeff      := dt / 1000;
          speed      := Velocity * coeff;
          Direction  := Direction + aVelocity * coeff;
          Position.X := Position.X + cos( Direction ) * speed;
          Position.Y := Position.Y + sin( Direction ) * speed;

          // Angular Velocity
          while iLife > Params.aVelocityD[ laVelocityID ].Life do INC( laVelocityID );
          prevS     := @Params.aVelocityD[ laVelocityID - 1 ];
          nextS     := @Params.aVelocityD[ laVelocityID ];
          aVelocity := aVelocityS * ( prevS.Value + ( nextS.Value - prevS.Value ) * ( iLife - prevS.Life ) / ( nextS.Life - prevS.Life ) );

          // Spin
          while iLife > Params.SpinD[ lSpinID ].Life do INC( lSpinID );
          prevS := @Params.SpinD[ lSpinID - 1 ];
          nextS := @Params.SpinD[ lSpinID ];
          Angle := Angle + Spin * ( prevS.Value + ( nextS.Value - prevS.Value ) * ( iLife - prevS.Life ) / ( nextS.Life - prevS.Life ) ) * coeff * rad2deg;
        end else
          Life := 0;
    end;
end;

function emitter2d_LoadTexture( const FileName : UTF8String ) : zglPTexture;
  var
    i    : Integer;
    hash : LongWord;
begin
  Result := nil;
  hash   := u_Hash( FileName );
  for i := 0 to managerEmitter2D.Count - 1 do
    if managerEmitter2D.List[ i ]._private.texHash = hash Then
      begin
        Result := managerEmitter2D.List[ i ].ParParams.Texture;
        break;
      end;

  if not Assigned( Result ) Then
    Result := tex_LoadFromFile( FileName );
end;

function emitter2d_Add : zglPEmitter2D;
begin
  if managerEmitter2D.Count + 1 > Length( managerEmitter2D.List ) Then
    SetLength( managerEmitter2D.List, Length( managerEmitter2D.List ) + 128 );

  zgl_GetMem( Pointer( Result ), SizeOf( zglTEmitter2D ) );
  managerEmitter2D.List[ managerEmitter2D.Count ] := Result;
  INC( managerEmitter2D.Count );

  emitter2d_Init( Result );
end;

procedure emitter2d_Del( var Emitter : zglPEmitter2D );
  var
    i, j       : Integer;
    delTexture : Boolean;
begin
  if not Assigned( Emitter ) Then exit;

  for i := 0 to managerEmitter2D.Count - 1 do
    if managerEmitter2D.List[ i ] = Emitter Then
      begin
        delTexture := TRUE;
        for j := 0 to managerEmitter2D.Count - 1 do
          if managerEmitter2D.List[ i ]._private.texHash = Emitter._private.texHash Then
            begin
              delTexture := FALSE;
              break;
            end;
        if delTexture Then
          tex_Del( Emitter.ParParams.Texture );

        DEC( managerEmitter2D.Count );
        emitter2d_Free( Emitter );
        managerEmitter2D.List[ i ] := managerEmitter2D.List[ managerEmitter2D.Count ];
        managerEmitter2D.List[ managerEmitter2D.Count ] := nil;
        break;
      end;
end;

function emitter2d_Load( const FileName : UTF8String ) : zglPEmitter2D;
  var
    c     : LongWord;
    chunk : Word;
    size  : LongWord;
begin
  Result := emitter2d_Add();
  with Result^, Result._private do
    while mem_Read( emitter2dMem, chunk, 2 ) > 0 do
      begin
        mem_Read( emitter2dMem, size, 4 );
        case chunk of
          ZEF_CHUNK_TYPE:
            begin
              mem_Read( emitter2dMem, Type_, 1 );
              mem_Read( emitter2dMem, AsPoint, size - 1 );
            end;
          ZEF_CHUNK_PARAMS:
            begin
              mem_Read( emitter2dMem, Params, size );
            end;
          ZEF_CHUNK_TEXTURE:
            begin
              mem_Read( emitter2dMem, size, 4 );
              SetLength( texFile, size );
              mem_Read( emitter2dMem, texFile[ 1 ], size );
              texFile := file_GetDirectory( FileName ) + texFile;
              texHash := u_Hash( texFile );
              if FileName <> '' Then
                ParParams.Texture := emitter2d_LoadTexture( texFile );

              mem_Read( emitter2dMem, size, 4 );
              if Assigned( ParParams.Texture ) Then
                begin
                  SetLength( ParParams.Texture.FramesCoord, size div SizeOf( zglTTextureCoord ) );
                  mem_Read( emitter2dMem, ParParams.Texture.FramesCoord[ 0 ], size );
                end else
                  INC( emitter2dMem.Position, size );
            end;
          ZEF_CHUNK_BLENDMODE:
            begin
              mem_Read( emitter2dMem, ParParams.BlendMode, 1 );
            end;
          ZEF_CHUNK_COLORMODE:
            begin
              mem_Read( emitter2dMem, ParParams.ColorMode, 1 );
            end;
          ZEF_CHUNK_LIFETIME:
            begin
              mem_Read( emitter2dMem, ParParams.LifeTimeS, 4 );
              mem_Read( emitter2dMem, ParParams.LifeTimeV, 4 );
            end;
          ZEF_CHUNK_FRAME:
            begin
              mem_Read( emitter2dMem, ParParams.Frame[ 0 ], 8 );
            end;
          ZEF_CHUNK_COLOR:
            begin
              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.Color, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.Color[ 0 ], SizeOf( TDiagramLW ) * c );

              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.Alpha, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.Alpha[ 0 ], SizeOf( TDiagramByte ) * c );
            end;
          ZEF_CHUNK_SIZEXY:
            begin
              mem_Read( emitter2dMem, ParParams.SizeXYBind, 1 );
              mem_Read( emitter2dMem, ParParams.SizeXS, 4 );
              mem_Read( emitter2dMem, ParParams.SizeYS, 4 );
              mem_Read( emitter2dMem, ParParams.SizeXV, 4 );
              mem_Read( emitter2dMem, ParParams.SizeYV, 4 );

              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.SizeXD, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.SizeXD[ 0 ], SizeOf( TDiagramSingle ) * c );

              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.SizeYD, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.SizeYD[ 0 ], SizeOf( TDiagramSingle ) * c );
            end;
          ZEF_CHUNK_ANGLE:
            begin
              mem_Read( emitter2dMem, ParParams.AngleS, 4 );
              mem_Read( emitter2dMem, ParParams.AngleV, 4 );
            end;
          ZEF_CHUNK_VELOCITY:
            begin
              mem_Read( emitter2dMem, ParParams.VelocityS, 4 );
              mem_Read( emitter2dMem, ParParams.VelocityV, 4 );

              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.VelocityD, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.VelocityD[ 0 ], SizeOf( TDiagramSingle ) * c );
            end;
          ZEF_CHUNK_AVELOCITY:
            begin
              mem_Read( emitter2dMem, ParParams.aVelocityS, 4 );
              mem_Read( emitter2dMem, ParParams.aVelocityV, 4 );

              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.aVelocityD, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.aVelocityD[ 0 ], SizeOf( TDiagramSingle ) * c );
            end;
          ZEF_CHUNK_SPIN:
            begin
              mem_Read( emitter2dMem, ParParams.SpinS, 4 );
              mem_Read( emitter2dMem, ParParams.SpinV, 4 );

              mem_Read( emitter2dMem, c, 4 );
              SetLength( ParParams.SpinD, c );
              if c > 0 Then
                mem_Read( emitter2dMem, ParParams.SpinD[ 0 ], SizeOf( TDiagramSingle ) * c );
            end;
        else
          emitter2dMem.Position := emitter2dMem.Position + size;
        end;
      end;
end;

function emitter2d_LoadFromFile( const FileName : UTF8String ) : zglPEmitter2D;
begin
  Result := nil;
  if not file_Exists( FileName ) Then
    begin
      log_Add( 'Cannot read "' + FileName + '"' );
      exit;
    end;

  mem_LoadFromFile( emitter2dMem, FileName );
  mem_Read( emitter2dMem, emitter2dID, 14 );
  if emitter2dID <> ZGL_EMITTER_2D Then
    log_Add( FileName + ' - it''s not a ZenGL Emitter 2D file' )
  else
    Result := emitter2d_Load( FileName );
  mem_Free( emitter2dMem );
end;

function emitter2d_LoadFromMemory( const Memory : zglTMemory ) : zglPEmitter2D;
begin
  emitter2dMem.Size     := Memory.Size;
  emitter2dMem.Memory   := Memory.Memory;
  emitter2dMem.Position := Memory.Position;

  mem_Read( emitter2dMem, emitter2dID, 14 );
  if emitter2dID <> ZGL_EMITTER_2D Then
    begin
      Result := nil;
      log_Add( 'Unable to determinate ZenGL Emitter 2D: From Memory' );
    end else
      Result := emitter2d_Load( '' );
end;

{$IFDEF ANDROID}
procedure emitter2d_RestoreAll;
  var
    i, j          : Integer;
    restored      : array of zglPTexture;
    restoredCount : Integer;
    restore       : Boolean;
begin
  if managerEmitter2D.Count = 0 Then exit;

  SetLength( restored, managerEmitter2D.Count );
  FillChar( restored[ 0 ], SizeOf( zglPTexture ) * managerEmitter2D.Count, 0 );
  restoredCount := 0;

  for i := 0 to managerEmitter2D.Count - 1 do
    begin
      restore := TRUE;
      for j := 0 to restoredCount - 1 do
        if managerEmitter2D.List[ i ]._private.texHash = managerEmitter2D.List[ j ]._private.texHash Then
          begin
            restore := FALSE;
            break;
          end;

      if restore Then
        begin
          tex_RestoreFromFile( managerEmitter2D.List[ i ].ParParams.Texture, managerEmitter2D.List[ i ]._private.texFile );
          INC( restoredCount );
        end;
    end;
end;
{$ENDIF}

procedure emitter2d_SaveToFile( Emitter : zglPEmitter2D; const FileName : UTF8String );
  var
    c : LongWord;
    f : zglTFile;
    chunk : Word;
    size  : LongWord;
begin
  if not Assigned( Emitter ) Then exit;

  file_Open( f, FileName, FOM_CREATE );
  file_Write( f, ZGL_EMITTER_2D, 14 );
  with Emitter^, Emitter._private do
    begin
      // ZEF_CHUNK_TYPE
      chunk := ZEF_CHUNK_TYPE;
      case Type_ of
        EMITTER_POINT: size := SizeOf( zglTEmitterPoint ) + 1;
        EMITTER_LINE: size := SizeOf( zglTEmitterLine ) + 1;
        EMITTER_RECTANGLE: size := SizeOf( zglTEmitterRect ) + 1;
        EMITTER_CIRCLE: size := SizeOf( zglTEmitterCircle ) + 1;
        EMITTER_RING: size := SizeOf( zglTEmitterRing ) + 1;
      end;
      file_Write( f, chunk, 2 );
      file_Write( f, size, 4 );

      file_Write( f, Type_, 1 );
      file_Write( f, PByte( @AsPoint )^, size - 1 );

      // ZEF_CHUNK_PARAMS
      chunk := ZEF_CHUNK_PARAMS;
      size  := SizeOf( Params );
      file_Write( f, chunk, 2 );
      file_Write( f, size, 4 );

      file_Write( f, Params, SizeOf( Params ) );

      with ParParams do
        begin
          // ZEF_CHUNK_TEXTURE
          chunk := ZEF_CHUNK_TEXTURE;
          size  := Length( texFile ) + Length( Texture.FramesCoord ) * SizeOf( zglTTextureCoord );
          if size > 0 Then
            begin
              file_Write( f, chunk, 2 );
              file_Write( f, size, 4 );

              size := Length( texFile );
              file_Write( f, size, 4 );
              file_Write( f, texFile[ 1 ], size );

              size := Length( Texture.FramesCoord ) * SizeOf( zglTTextureCoord );
              file_Write( f, size, 4 );
              file_Write( f, Texture.FramesCoord[ 0 ], size );
            end;

          // ZEF_CHUNK_BLENDMODE
          chunk := ZEF_CHUNK_BLENDMODE;
          size  := 1;
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, BlendMode, 1 );

          // ZEF_CHUNK_COLORMODE
          chunk := ZEF_CHUNK_COLORMODE;
          size  := 1;
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, ColorMode, 1 );

          // ZEF_CHUNK_LIFETIME
          chunk := ZEF_CHUNK_LIFETIME;
          size  := 4 + 4;
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, LifeTimeS, 4 );
          file_Write( f, LifeTimeV, 4 );

          // ZEF_CHUNK_FRAME
          chunk := ZEF_CHUNK_FRAME;
          size  := 8;
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, Frame[ 0 ], 8 );

          // ZEF_CHUNK_COLOR
          chunk := ZEF_CHUNK_COLOR;
          size  := 4 + Length( Color ) * SizeOf( TDiagramLW ) + 4 + Length( Alpha ) * SizeOf( TDiagramByte );
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          c := Length( Color );
          file_Write( f, c, 4 );
          file_Write( f, Color[ 0 ], SizeOf( TDiagramLW ) * c );

          c := Length( Alpha );
          file_Write( f, c, 4 );
          file_Write( f, Alpha[ 0 ], SizeOf( TDiagramByte ) * c );

          // ZEF_CHUNK_SIZEXY
          chunk := ZEF_CHUNK_SIZEXY;
          size  := 1 + 4 + 4 + 4 + 4 + ( 4 + Length( SizeXD ) * SizeOf( TDiagramSingle ) + 4 + Length( SizeYD ) * SizeOf( TDiagramSingle ) );
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, SizeXYBind, 1 );
          file_Write( f, SizeXS, 4 );
          file_Write( f, SizeYS, 4 );
          file_Write( f, SizeXV, 4 );
          file_Write( f, SizeYV, 4 );

          c := Length( SizeXD );
          file_Write( f, c, 4 );
          file_Write( f, SizeXD[ 0 ], SizeOf( TDiagramSingle ) * c );

          c := Length( SizeYD );
          file_Write( f, c, 4 );
          file_Write( f, SizeYD[ 0 ], SizeOf( TDiagramSingle ) * c );

          // ZEF_CHUNK_ANGLE
          chunk := ZEF_CHUNK_ANGLE;
          size  := 4 + 4;
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, AngleS, 4 );
          file_Write( f, AngleV, 4 );

          // ZEF_CHUNK_VELOCITY
          chunk := ZEF_CHUNK_VELOCITY;
          size  := 4 + 4 + ( 4 + Length( VelocityD ) * SizeOf( TDiagramSingle ) );
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, VelocityS, 4 );
          file_Write( f, VelocityV, 4 );

          c := Length( VelocityD );
          file_Write( f, c, 4 );
          file_Write( f, VelocityD[ 0 ], SizeOf( TDiagramSingle ) * c );

          // ZEF_CHUNK_AVELOCITY
          chunk := ZEF_CHUNK_AVELOCITY;
          size  := 4 + 4 + ( 4 + Length( aVelocityD ) * SizeOf( TDiagramSingle ) );
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, aVelocityS, 4 );
          file_Write( f, aVelocityV, 4 );

          c := Length( aVelocityD );
          file_Write( f, c, 4 );
          file_Write( f, aVelocityD[ 0 ], SizeOf( TDiagramSingle ) * c );

          // ZEF_CHUNK_SPIN
          chunk := ZEF_CHUNK_SPIN;
          size  := 4 + 4 + ( 4 + Length( SpinD ) * SizeOf( TDiagramSingle ) );
          file_Write( f, chunk, 2 );
          file_Write( f, size, 4 );

          file_Write( f, SpinS, 4 );
          file_Write( f, SpinV, 4 );

          c := Length( SpinD );
          file_Write( f, c, 4 );
          file_Write( f, SpinD[ 0 ], SizeOf( TDiagramSingle ) * c );
        end;
    end;

    file_Close( f );
end;

procedure emitter2d_Init( Emitter : zglPEmitter2D );
  var
    i : Integer;
begin
  if not Assigned( Emitter ) Then exit;

  for i := 0 to EMITTER_MAX_PARTICLES - 1 do
    with Emitter^, Emitter._private do
      begin
        list[ i ]    := @particle[ i ];
        list[ i ].ID := i;
      end;
end;

procedure emitter2d_Free( var Emitter : zglPEmitter2D );
begin
  if not Assigned( Emitter ) Then exit;

  Emitter._private.texFile := '';
  with Emitter.ParParams do
    begin
      SetLength( Color, 0 );
      SetLength( Alpha, 0 );
      SetLength( SizeXD, 0 );
      SetLength( SizeYD, 0 );
      SetLength( VelocityD, 0 );
      SetLength( aVelocityD, 0 );
      SetLength( SpinD, 0 );
    end;
  FreeMem( Emitter );
  Emitter := nil;
end;

procedure emitter2d_Draw( Emitter : zglPEmitter2D );
  var
    i      : Integer;
    p      : zglPParticle2D;
    quad   : array[ 0..3 ] of zglTPoint2D;
    tc     : zglPTextureCoord;
    x1, x2 : Single;
    y1, y2 : Single;
    cX, cY : Single;
    c, s   : Single;

    iColor: Byte;
begin
  if not Assigned( Emitter ) Then exit;

  if render2dClip Then
    with Emitter.BBox do
      if not sprite2d_InScreen( MinX, MinY, MaxX - MinX, MaxY - MinY, 0 ) Then exit;

  with Emitter^, Emitter._private do
    begin
      fx_SetBlendMode( ParParams.BlendMode );
      fx_SetColorMode( ParParams.ColorMode );

      if ( not b2dStarted ) or batch2d_Check( GL_QUADS, FX_BLEND or FX_COLOR, ParParams.Texture ) Then
      begin
        glEnable( GL_BLEND );
        glEnable( GL_TEXTURE_2D );
        glBindTexture( GL_TEXTURE_2D, ParParams.Texture^.ID );

        glBegin( GL_QUADS );
      end;
      iColor := Length(ParParams.Color);

      fx2d_SetColor($FFFFFF);

      for i := 0 to Particles - 1 do
      begin
        p  := list[ i ];
        tc := @ParParams.Texture.FramesCoord[ p.Frame ];
        if iColor <> 0 then
          fx2d_SetColor(p.Color);

        if p.Angle <> 0 Then
        begin
          x1 := -p.Size.X / 2;
          y1 := -p.Size.Y / 2;
          x2 := -x1;
          y2 := -y1;
          cX :=  p.Position.X;
          cY :=  p.Position.Y;

          m_SinCos( p.Angle * deg2rad, s, c );

          quad[0].X := x1 * c - y1 * s + cX;
          quad[0].Y := x1 * s + y1 * c + cY;
          quad[1].X := x2 * c - y1 * s + cX;
          quad[1].Y := x2 * s + y1 * c + cY;
          quad[2].X := x2 * c - y2 * s + cX;
          quad[2].Y := x2 * s + y2 * c + cY;
          quad[3].X := x1 * c - y2 * s + cX;
          quad[3].Y := x1 * s + y2 * c + cY;
        end else
        begin
          x1 := p.Position.X - p.Size.X / 2;
          y1 := p.Position.Y - p.Size.Y / 2;

          quad[0].X := x1;
          quad[0].Y := y1;
          quad[1].X := x1 + p.Size.X;
          quad[1].Y := y1;
          quad[2].X := x1 + p.Size.X;
          quad[2].Y := y1 + p.Size.Y;
          quad[3].X := x1;
          quad[3].Y := y1 + p.Size.Y;
        end;

        fx2dAlpha^ := p.Alpha / 255;        
        glColor4f(fx2dColor[0], fx2dColor[1], fx2dColor[2], fx2dColor[3]);

        glTexCoord2fv( @tc[ 0 ] );
        glVertex2fv( @quad[ 0 ] );

        glTexCoord2fv( @tc[ 1 ] );
        glVertex2fv( @quad[ 1 ] );

        glTexCoord2fv( @tc[ 2 ] );
        glVertex2fv( @quad[ 2 ] );

        glTexCoord2fv( @tc[ 3 ] );
        glVertex2fv( @quad[ 3 ] );
      end;

      if not b2dStarted Then
      begin
        glEnd();

        glDisable( GL_TEXTURE_2D );
        glDisable( GL_BLEND );
        glDisable( GL_ALPHA_TEST );
      end;
    end;
end;

procedure emitter2d_Sort( Emitter : zglPEmitter2D; iLo, iHi : Integer );
  var
    lo, hi, mid : Integer;
    t           : zglPParticle2D;
begin
  if not Assigned( Emitter ) Then exit;

  lo   := iLo;
  hi   := iHi;
  mid  := Emitter._private.list[ ( lo + hi ) shr 1 ].ID;

  with Emitter^, Emitter._private do
    repeat
      while list[ lo ].ID < mid do INC( lo );
      while list[ hi ].ID > mid do DEC( hi );
      if lo <= hi then
        begin
          t          := list[ lo ];
          list[ lo ] := list[ hi ];
          list[ hi ] := t;
          INC( lo );
          DEC( hi );
        end;
    until lo > hi;

  if hi > iLo Then emitter2d_Sort( Emitter, iLo, hi );
  if lo < iHi Then emitter2d_Sort( Emitter, lo, iHi );
end;

procedure emitter2d_Proc( Emitter : zglPEmitter2D; dt : Double );
  var
    i        : Integer;
    p        : zglPParticle2D;
    parCount : Integer;
    angle    : Integer;
    size     : Single;
begin
  if not Assigned( Emitter ) Then exit;

  with Emitter^, Emitter._private do
    begin
      BBox.MinX := Params.Position.X;
      BBox.MaxX := Params.Position.X;
      BBox.MinY := Params.Position.Y;
      BBox.MaxY := Params.Position.Y;

      i := 0;
      while i < Particles do
        begin
          particle2d_Proc( list[ i ], @Emitter.ParParams, dt );
          if list[ i ].Life = 0 Then
            begin
              p                     := list[ i ];
              list[ i ]             := list[ Particles - 1 ];
              list[ Particles - 1 ] := p;
              DEC( Particles );
            end else
              INC( i );
        end;
      if Particles > 2 Then
        emitter2d_Sort( Emitter, 0, Particles - 1 );

      Time := Time + dt;
      Life := Params.LifeTime - Time;
      if Life > 0 Then
        Life := 1 / Life;
      if ( Time >= Params.LifeTime ) and ( not Params.Loop ) Then
        exit;

      parCount   := Round( ( Time - LastSecond ) * ( Params.Emission / 1000 ) - parCreated );
      if Particles + parCount > EMITTER_MAX_PARTICLES Then
        parCount := EMITTER_MAX_PARTICLES - ( Particles + parCount );
      parCreated := parCreated + parCount;

      for i := 0 to parCount - 1 do
        begin
          p := list[ Particles ];
          with p._private do
            begin
              lColorID     := 1;
              lAlphaID     := 1;
              lSizeXID     := 1;
              lSizeYID     := 1;
              lVelocityID  := 1;
              laVelocityID := 1;
              lSpinID      := 1;
            end;

          p.Life       := 1;
          p.LifeTime   := ParParams.LifeTimeS + Random( ParParams.LifeTimeV ) - Round( ParParams.LifeTimeV / 2 );
          p.Time       := 0;
          p.Frame      := ParParams.Frame[ 0 ];
          if Length( ParParams.Color ) > 0 Then
            p.Color    := ParParams.Color[ 0 ].Value
          else
            p.Color    := $FFFFFF;
          p.Alpha      := ParParams.Alpha[ 0 ].Value;
          p.SizeS.X    := ParParams.SizeXS + Random( Round( ParParams.SizeXV * 1000 ) ) / 1000 - ParParams.SizeXV / 2;
          if ParParams.SizeXYBind Then
            p.SizeS.Y  := p.SizeS.X
          else
            p.SizeS.Y  := ParParams.SizeYS + Random( Round( ParParams.SizeYV * 1000 ) ) / 1000 - ParParams.SizeYV / 2;
          p.Size.X     := p.SizeS.X;
          p.Size.Y     := p.SizeS.Y;
          p.Angle      := ParParams.AngleS + Random( Round( ParParams.AngleV * 1000 ) ) / 1000 - ParParams.AngleV / 2;
          p.VelocityS  := ParParams.VelocityS + Random( Round( ParParams.VelocityV * 1000 ) ) / 1000 - ParParams.VelocityV / 2;
          p.Velocity   := p.VelocityS;
          p.aVelocityS := ParParams.aVelocityS + Random( Round( ParParams.aVelocityV * 1000 ) ) / 1000 - ParParams.aVelocityV / 2;
          p.aVelocity  := p.aVelocityS;
          p.Spin       := ParParams.SpinS + Random( Round( ParParams.SpinV * 1000 ) ) / 1000 - ParParams.SpinV / 2;

          case Type_ of
            EMITTER_POINT:
              begin
                p.Direction := AsPoint.Direction + Random( Round( AsPoint.Spread * 1000 ) ) / 1000 - AsPoint.Spread / 2;
                p.Position  := Params.Position;
              end;
            EMITTER_LINE:
              begin
                p.Direction  := AsLine.Direction + Random( Round( AsLine.Spread * 1000 ) ) / 1000 - AsLine.Spread / 2;
                size         := ( AsLine.Size / 2 - Random( Round( AsLine.Size * 1000 ) ) / 1000 );
                p.Position.X := Params.Position.X + cos( AsLine.Direction + 90 * deg2rad ) * size;
                p.Position.Y := Params.Position.Y + sin( AsLine.Direction + 90 * deg2rad ) * size;
                if AsLine.TwoSide Then
                  p.Direction := p.Direction + 180 * ( Random( 2 ) - 1 ) * deg2rad;
              end;
            EMITTER_RECTANGLE:
              begin
                p.Direction  := AsRect.Direction + Random( Round( AsRect.Spread * 1000 ) ) / 1000 - AsRect.Spread / 2;
                p.Position.X := Params.Position.X + AsRect.Rect.X + Random( Round( AsRect.Rect.W ) );
                p.Position.Y := Params.Position.Y + AsRect.Rect.Y + Random( Round( AsRect.Rect.H ) );
              end;
            EMITTER_CIRCLE:
              begin
                angle        := Random( 360 );
                size         := Random( Round( AsCircle.Radius * 1000 ) ) / 1000;
                p.Direction  := AsCircle.Direction + Random( Round( AsCircle.Spread * 1000 ) ) / 1000 - AsCircle.Spread / 2;
                p.Position.X := Params.Position.X + AsCircle.cX + cos( angle * deg2rad ) * size;
                p.Position.Y := Params.Position.Y + AsCircle.cY + sin( angle * deg2rad ) * size;
              end;
            EMITTER_RING:
              begin
                angle        := Random( 360 );
                size         := ( AsRing.Radius1 + AsRing.Radius0 ) / 2 + Random( Round( abs( AsRing.Radius1 - AsRing.Radius0 ) * 1000 ) ) / 1000 - abs( AsRing.Radius1 - AsRing.Radius0 ) / 2;
                p.Direction  := AsRing.Direction + AsRing.Spread / 2 - Random( Round( AsRing.Spread * 1000 ) ) / 1000;
                p.Position.X := Params.Position.X + AsRing.cX + cos( angle * deg2rad ) * size;
                p.Position.Y := Params.Position.Y + AsRing.cY + sin( angle * deg2rad ) * size;
              end;
          end;

          particle2d_Proc( p, @Emitter.ParParams, ( parCount - i ) * dt / parCount );
          INC( Particles );
        end;

        for i := 0 to Particles - 1 do
          begin
            p    := list[ i ];
            size := ( p.Size.X + p.Size.Y ) / 2;
            if p.Position.X - size < Emitter.BBox.MinX Then
              Emitter.BBox.MinX := p.Position.X - size;
            if p.Position.X + size > Emitter.BBox.MaxX Then
              Emitter.BBox.MaxX := p.Position.X + size;
            if p.Position.Y - size < Emitter.BBox.MinY Then
              Emitter.BBox.MinY := p.Position.Y - size;
            if p.Position.Y + size > Emitter.BBox.MaxY Then
              Emitter.BBox.MaxY := p.Position.Y + size;
          end;

      if Time >= Params.LifeTime Then
        begin
          Time       := 0;
          LastSecond := 0;
          parCreated := 0;
        end;

      if Time - LastSecond >= 1000 Then
        begin
          parCreated := 0;
          LastSecond := Time;
        end;
    end;
end;

initialization
  pengine2d := @_pengine;

end.
