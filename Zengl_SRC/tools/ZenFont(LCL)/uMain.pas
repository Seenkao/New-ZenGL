unit uMain;

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, Spin,
  {$IFDEF LINUX}
  {$IFDEF LCLGTK}
  GLib, GTK, GDK,
  {$ENDIF}
  {$IFDEF LCLGTK2}
  GLib2, GTK2, GDK2, GDK2x,
  {$ENDIF}
  {$ENDIF}
  zgl_screen,
  zgl_window,
  zgl_utils,
  zgl_primitives_2d,
  zgl_sprite_2d,
  zgl_application,
  zgl_font,
  zgl_text,
  zgl_file,
  zgl_types,
  {$IfNDef OLD_METHODS}
  gegl_color,
  {$EndIf}
  zgl_font_gen;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonRebuildFont: TButton;
    ButtonImportSymbols: TButton;
    ButtonDefaultSymbols: TButton;
    ButtonExit: TButton;
    ButtonSaveFont: TButton;
    ButtonChooseFont: TButton;
    CheckBoxAntialiasing: TCheckBox;
    CheckBoxPack: TCheckBox;
    ComboBoxPageSize: TComboBox;
    EditChars: TEdit;
    EditTest: TEdit;
    FontDialog: TFontDialog;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelPageSize: TLabel;
    LabelCurrentPage: TLabel;
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    SaveFontDialog: TSaveDialog;
    SpinCurrentPage: TSpinEdit;
    SpinTop: TSpinEdit;
    SpinLeft: TSpinEdit;
    SpinRight: TSpinEdit;
    SpinBottom: TSpinEdit;
    Timer1: TTimer;
    procedure ButtonChooseFontClick(Sender: TObject);
    procedure ButtonDefaultSymbolsClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButtonImportSymbolsClick(Sender: TObject);
    procedure ButtonRebuildFontClick(Sender: TObject);
    procedure ButtonSaveFontClick(Sender: TObject);
    procedure CheckBoxAntialiasingChange(Sender: TObject);
    procedure CheckBoxPackChange(Sender: TObject);
    procedure ComboBoxPageSizeChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinCurrentPageChange(Sender: TObject);
    procedure SpinLeftChange(Sender: TObject);
    procedure SpinTopChange(Sender: TObject);
    procedure SpinBottomChange(Sender: TObject);
    procedure SpinRightChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure SetDefaultSymbolList;
    procedure UpdateSymbolList;
    procedure UpdateFont;
  end;

var
  Form1        : TForm1;

  zgl_Inited   : Boolean = False;
  fontMoving   : Boolean;
  fontX, fontY : Integer;
  lastX, lastY : Integer;
  utf8chars    : array[ 0..65535, 0..5 ] of AnsiChar;

  newColor     : LongWord;

implementation

{$R *.lfm}

procedure Init;
begin
  wnd_SetSize( Form1.Panel1.ClientWidth, Form1.Panel1.ClientHeight );
  scrVSync := True;
  fontgen_Init();
  fg_Font := font_Add();

  Form1.SetDefaultSymbolList();
  Form1.UpdateFont();
  fontX := ( Form1.Panel1.Width - fg_PageSize ) div 2;
  fontY := ( Form1.Panel1.Height - fg_PageSize ) div 2;
  newColor := Color_FindOrAdd($505050FF);
  setTextColor(Get_Color(cl_Yellow));
end;

procedure Draw;
var
  r: zglTRect2D;
begin
  pr2d_Rect( 0, 0, Form1.Panel1.Width, Form1.Panel1.Height, {$IfNDef OLD_METHODS}newColor,{$Else}$505050, 255,{$EndIf} PR2D_FILL );
  pr2d_Rect( fontX, fontY, fg_PageSize, fg_PageSize, {$IfNDef OLD_METHODS}cl_Black,{$Else}$000000, 255,{$EndIf} PR2D_FILL );

  if ( fg_Font <> 0) and Assigned(managerFont.Font[fg_Font].Pages) Then
    begin
      ssprite2d_Draw( managerFont.Font[fg_Font].Pages[ Form1.SpinCurrentPage.Value - 1 ], fontX, fontY, fg_PageSize, fg_PageSize, 0 );

      r.W := text_GetWidth( fg_Font, Form1.EditTest.Text );
      r.X := ( Form1.Panel1.Width - r.W ) / 2;
      r.Y := Form1.Panel1.Height - managerFont.Font[fg_Font].MaxShiftY - managerFont.Font[fg_Font].MaxHeight;
      r.H := managerFont.Font[fg_Font].MaxShiftY + managerFont.Font[fg_Font].MaxHeight;
      pr2d_Rect( r.X, r.Y, r.W, r.H, {$IfNDef OLD_METHODS}cl_Black,{$Else}$000000, 255,{$EndIf} PR2D_FILL );
      text_Draw( fg_Font, Form1.Panel1.Width div 2, Form1.Panel1.Height - managerFont.Font[fg_Font].MaxHeight, Form1.EditTest.Text, TEXT_HALIGN_CENTER );
    end;

  Application.ProcessMessages();
  u_Sleep( 10 );
end;

{ TForm1 }

procedure TForm1.SetDefaultSymbolList;
begin
  EditChars.Text := ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}' +
                    '~¡¢£¤¥¦§¨©ª«¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ' +
                    'ЁЄІЇАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяёєіїҐґ' + '№';
end;

procedure TForm1.UpdateSymbolList;
  var
    i, j, len : Integer;
    c : Word;
begin
  len := length(EditChars.Text);

  Panel1.Canvas.Clear();
  Application.ProcessMessages();

  i := 1;
  FillChar(fg_CharsUse, 65536, 0);
  managerFont.Font[fg_Font].Count.Chars := 0;

  while i <= len do
    begin
      c := utf8_toUnicode(EditChars.Text, i, @j);
      if not fg_CharsUse[c] Then
      begin
        fg_CharsUse[c] := TRUE;
        FillChar(utf8chars[ c, 0], 6, 0);
        Move(EditChars.Text[i], utf8chars[c, 0], j - i);
        inc(managerFont.Font[fg_Font].Count.Chars);
      end;
      i := j;
    end;

  EditChars.Text := '';
  for i := 0 to 65535 do
    if fg_CharsUse[ i ] Then
      EditChars.Text := EditChars.Text + utf8chars[ i ];

  Application.ProcessMessages();
end;

procedure TForm1.UpdateFont;
begin
  UpdateSymbolList();
  fontgen_BuildFont( fg_Font, FontDialog.Font.Name );
  SpinCurrentPage.MaxValue := managerFont.Font[fg_Font].Count.Pages;
  if (managerFont.Font[fg_Font].Count.Pages = 0) or (managerFont.Font[fg_Font].Count.Pages = 1) then
  begin
    SpinCurrentPage.Enabled := False;
    SpinCurrentPage.Value := managerFont.Font[fg_Font].Count.Pages;
    Exit;
  end
  else
    SpinCurrentPage.Enabled := True;
  if SpinCurrentPage.Value > SpinCurrentPage.MaxValue Then
    SpinCurrentPage.Value := SpinCurrentPage.MaxValue;

end;

procedure TForm1.ButtonChooseFontClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  if FontDialog.Execute() Then
    begin
      fg_FontSize   := FontDialog.Font.Size;
      fg_FontBold   := fsBold in FontDialog.Font.Style;
      fg_FontItalic := fsItalic in FontDialog.Font.Style;
      UpdateFont();
    end;
  Timer1.Enabled := true;
end;

procedure TForm1.ButtonDefaultSymbolsClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  SetDefaultSymbolList();
  UpdateFont();
  Timer1.Enabled := true;
end;

procedure TForm1.ButtonExitClick(Sender: TObject);
begin
  form1.Close;
end;

procedure TForm1.ButtonImportSymbolsClick(Sender: TObject);
  var
    i : Integer;
    s : TStrings;
begin
  Timer1.Enabled := False;
  s := TStringList.Create;
  if OpenDialog.Execute() Then
    begin
      s.LoadFromFile( OpenDialog.FileName );
      for i := 0 to s.Count - 1 do
        EditChars.Text := EditChars.Text + s.Strings[ i ];

      UpdateFont();
    end;
  Timer1.Enabled := true;
end;

procedure TForm1.ButtonRebuildFontClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  UpdateFont();
  Timer1.Enabled := True;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled := false;
  winOn := FALSE;
  zgl_Destroy;
  Application.Terminate;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  wnd_SetSize( Panel1.ClientWidth, Panel1.ClientHeight );
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not fontMoving Then
    begin
      fontMoving := TRUE;
      lastX := X;
      lastY := Y;
    end;
end;

procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if fontMoving Then
    begin
      fontX := fontX + ( X - lastX );
      fontY := fontY + ( Y - lastY );
      lastX := X;
      lastY := Y;
    end;
end;

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  fontMoving := FALSE;
end;

procedure TForm1.SpinCurrentPageChange(Sender: TObject);
begin
  if SpinCurrentPage.Value < 1 then
    SpinCurrentPage.Value := 1;
end;

procedure TForm1.SpinLeftChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  if fg_FontPadding[ 0 ] <> SpinLeft.Value Then
    begin
      fg_FontPadding[ 0 ] := SpinLeft.Value;
      UpdateFont();
    end;
  Timer1.Enabled := true;
end;

procedure TForm1.SpinTopChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  if fg_FontPadding[ 1 ] <> SpinTop.Value Then
    begin
      fg_FontPadding[ 1 ] := SpinTop.Value;
      UpdateFont();
    end;
  Timer1.Enabled := true;
end;

procedure TForm1.SpinRightChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  if fg_FontPadding[ 2 ] <> SpinRight.Value Then
    begin
      fg_FontPadding[ 2 ] := SpinRight.Value;
      UpdateFont();
    end;
  Timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  app_PLoop;
end;

procedure TForm1.SpinBottomChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  if fg_FontPadding[ 3 ] <> SpinBottom.Value Then
    begin
      fg_FontPadding[ 3 ] := SpinBottom.Value;
      UpdateFont();
    end;
  Timer1.Enabled := true;
end;

procedure TForm1.ButtonSaveFontClick(Sender: TObject);
  var
    style : String;
    _name  : String;
    dir   : String;
begin
  if fg_FontBold and fg_FontItalic Then
    style := 'BoldItalic'
  else
    if fg_FontBold Then
      style := 'Bold'
    else
      if fg_FontItalic Then
        style := 'Italic'
      else
        style := 'Regular';

  Timer1.Enabled := False;
  SaveFontDialog.FileName := FontDialog.Font.Name + '-' + style + '-' + IntToStr( fg_FontSize ) + 'pt';

//  if SaveFontDialog.Execute() Then
//    begin
      _name := file_GetName( SaveFontDialog.FileName );
      dir  := file_GetDirectory( SaveFontDialog.FileName );
      fontgen_SaveFont( fg_Font, _name );

  ShowMessage(_name + ' save');
//    end;
  Timer1.Enabled := True;
end;

procedure TForm1.CheckBoxAntialiasingChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  fg_FontAA := CheckBoxAntialiasing.Checked;
  UpdateFont();
  Timer1.Enabled := true;
end;

procedure TForm1.CheckBoxPackChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  fg_FontPack := CheckBoxPack.Checked;
  UpdateFont();
  Timer1.Enabled := true;
end;

procedure TForm1.ComboBoxPageSizeChange(Sender: TObject);
begin
  Timer1.Enabled := False;
  fg_PageSize := StrToInt( ComboBoxPageSize.Items[ ComboBoxPageSize.ItemIndex ] );
  UpdateFont();
  Timer1.Enabled := true;
end;

procedure TForm1.FormActivate(Sender: TObject);
{$IFDEF LINUX}
  var
    widget : PGtkWidget;
    socket : PGtkWidget;
    glist  : PGlist;
{$ENDIF}
begin
  if not zgl_Inited then
  begin
    zgl_Inited := True;
//    zgl_Disable( APP_USE_LOG );

    zgl_Reg( SYS_LOAD, @Init );
    zgl_Reg( SYS_DRAW, @Draw );
    {$IFDEF LINUX}
    glist  := gtk_container_children( GTK_CONTAINER( PGtkWidget( Panel1.Handle ) ) );
    widget := PGtkWidget( glist^.data );
    socket := gtk_socket_new();
    gtk_container_add( GTK_CONTAINER( widget ), socket );

    gtk_widget_show( socket );
    gtk_widget_show( widget );

    gtk_widget_realize( socket );
    {$IFDEF LCLGTK}
    zgl_InitToHandle( ( PGdkWindowPrivate( widget.window ) ).xwindow );
    {$ENDIF}
    {$IFDEF LCLGTK2}
    zgl_InitToHandle( GDK_WINDOW_XID( widget^.window ) );
    {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}
    zgl_InitToHandle( Panel1.Handle );
    {$ENDIF}
    timer1.Enabled := true;
  end;
end;

end.
