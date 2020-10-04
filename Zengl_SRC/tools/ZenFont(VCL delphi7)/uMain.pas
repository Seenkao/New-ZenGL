unit uMain;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls,
  zgl_main,
  zgl_application,
  zgl_screen,
  zgl_window,
  zgl_utils,
  zgl_primitives_2d,
  zgl_sprite_2d,
  zgl_font,
  zgl_text,
  zgl_file,
  zgl_font_gen,
  Spin;

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
    procedure SpinLeftChange(Sender: TObject);
    procedure SpinTopChange(Sender: TObject);
    procedure SpinBottomChange(Sender: TObject);
    procedure SpinRightChange(Sender: TObject);
    procedure SpinCurrentPageChange(Sender: TObject);
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

  zglInited    : Boolean;
  fontMoving   : Boolean;
  fontX, fontY : Integer;
  lastX, lastY : Integer;
  utf8chars    : array[0..65535, 0..5] of AnsiChar;

implementation
uses
  uProcessing;

{$R *.dfm}

procedure Init;
  var
    i : Integer;
begin
  wnd_SetSize( Form1.Panel1.ClientWidth, Form1.Panel1.ClientHeight);
  scrVSync := True;
  scr_SetOptions();

  fontgen_Init();                                                         // это "установка" (выбор) шрифта
  fg_Font := font_Add();

  Form1.SetDefaultSymbolList();
  Form1.UpdateFont();
  fontX := (Form1.Panel1.Width - fg_PageSize) div 2;
  fontY := (Form1.Panel1.Height - fg_PageSize) div 2;
end;

procedure Draw;
  var
    w : Single;
begin
  pr2d_Rect(0, 0, Form1.Panel1.Width, Form1.Panel1.Height, $505050, 255, PR2D_FILL);
  pr2d_Rect(fontX, fontY, fg_PageSize, fg_PageSize, $000000, 255, PR2D_FILL);

  if Assigned(fg_Font) and Assigned(fg_Font.Pages) Then
  begin
    ssprite2d_Draw(fg_Font.Pages[Form1.SpinCurrentPage.Value - 1], fontX, fontY, fg_PageSize, fg_PageSize, 0);

    w := text_GetWidth(fg_Font, Form1.EditTest.Text);
    pr2d_Rect((Form1.Panel1.Width - w) / 2, Form1.Panel1.Height - fg_Font.MaxShiftY - fg_Font.MaxHeight, w, fg_Font.MaxShiftY + fg_Font.MaxHeight, $000000, 255, PR2D_FILL);
    text_Draw(fg_Font, Form1.Panel1.Width div 2, Form1.Panel1.Height - fg_Font.MaxHeight, Form1.EditTest.Text, TEXT_HALIGN_CENTER);
  end;

  Application.ProcessMessages();
  u_Sleep(10);
end;

{ TForm1 }

procedure TForm1.SetDefaultSymbolList;
begin
  EditChars.Text := ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}' +
                    '~ВЎВўВЈВ¤ВҐВ¦В§ВЁВ©ВЄВ«В¬В®ВЇВ°В±ВІВіВґВµВ¶В·ВёВ№ВєВ»ВјВЅВѕВїв„–' +
                    // 'ГЂГЃГ‚ГѓГ„Г…Г†Г‡Г€Г‰ГЉГ‹ГЊГЌГЋГЏГђГ‘Г’Г“Г”Г•Г–Г—ГГ™ГљГ›ГњГќГћГџГ ГЎГўГЈГ¤ГҐГ¦Г§ГЁГ©ГЄГ«Г¬Г­Г®ГЇГ°Г±ГІГіГґГµГ¶Г·ГёГ№ГєГ»ГјГЅГѕГї' +
                    'РЃР„Р†Р‡РђР‘Р’Р“Р”Р•Р–Р—РР™РљР›РњРќРћРџР РЎРўРЈР¤РҐР¦Р§РЁР©РЄР«Р¬Р­Р®РЇР°Р±РІРіРґРµР¶Р·РёР№РєР»РјРЅРѕРїСЂСЃС‚СѓС„С…С†С‡С€С‰СЉС‹СЊСЌСЋСЏС‘С”С–С—ТђТ‘';
end;

procedure TForm1.UpdateSymbolList;
  var
    i, j, len : Integer;
    c : Word;
begin
  Form2.Show();
  Form2.Left := Form1.Left + (Form1.Width - Form2.Width) div 2;
  Form2.Top := Form1.Top + (Form1.Height - Form2.Height) div 2;
  Form2.ProgressBar1.Position := 0;

//  Panel1.Canvas.Clear();
  Application.ProcessMessages();

  i := 1;
  FillChar(fg_CharsUse, 65536, 0);
  fg_Font.Count.Chars := 0;
  len := length(EditChars.Text);
  Form2.ProgressBar1.Max := len;
  while i <= len do
  begin
    Form2.ProgressBar1.Position := i;
    Form2.ProgressBar1.Update();

    c := utf8_GetID(EditChars.Text, i, @j);
    if not fg_CharsUse[c] Then                          // если не прописан(не назначен) символ
    begin
      fg_CharsUse[c] := TRUE;                           // назначаем
      FillChar(utf8chars[c, 0], 6, 0);                  // заполняем 6 значений нулями
      Move(EditChars.Text[i], utf8chars[c, 0], j - i);  // и перемещаем туда символ???
      INC(fg_Font.Count.Chars);
    end;
    i := j;
  end;

  EditChars.Text := '';
//  for i := 0 to 65535 do
  i := 0;
  while i < 65536 do
  begin
    if fg_CharsUse[i] Then
      EditChars.Text := EditChars.Text + utf8chars[i];
    inc(i);
  end;

  Form2.Hide();
  Application.ProcessMessages();
end;

procedure TForm1.UpdateFont;
begin
  UpdateSymbolList();
  fontgen_BuildFont(fg_Font, FontDialog.Font.Name);                       // генерация символов шрифта
  SpinCurrentPage.MaxValue := fg_Font.Count.Pages;
  if (fg_Font.Count.Pages = 0) or (fg_Font.Count.Pages = 1) then
  begin
    SpinCurrentPage.Enabled := False;
    SpinCurrentPage.Value := fg_Font.Count.Pages;
    Exit;
  end
  else
    SpinCurrentPage.Enabled := True;
  if SpinCurrentPage.Value > SpinCurrentPage.MaxValue Then
    SpinCurrentPage.Value := SpinCurrentPage.MaxValue;
end;

procedure TForm1.ButtonChooseFontClick(Sender: TObject);
begin
  if FontDialog.Execute() Then
  begin
    fg_FontSize   := FontDialog.Font.Size;
    fg_FontBold   := fsBold in FontDialog.Font.Style;
    fg_FontItalic := fsItalic in FontDialog.Font.Style;
    UpdateFont();
  end;
end;

procedure TForm1.ButtonDefaultSymbolsClick(Sender: TObject);
begin
  SetDefaultSymbolList();
  UpdateFont();
end;

procedure TForm1.ButtonExitClick(Sender: TObject);
begin
  winOn := false;
end;

procedure TForm1.ButtonImportSymbolsClick(Sender: TObject);
  var
    i : Integer;
    s : TStrings;
begin
  s := TStringList.Create;
  if OpenDialog.Execute() Then
  begin
    s.LoadFromFile(OpenDialog.FileName);
    for i := 0 to s.Count - 1 do
      EditChars.Text := EditChars.Text + s.Strings[i];

    UpdateFont();
  end;
end;

procedure TForm1.ButtonRebuildFontClick(Sender: TObject);
begin
  UpdateFont();
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  winOn := False;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if zglInited Then
    wnd_SetSize(Panel1.ClientWidth, Panel1.ClientHeight);
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
    fontX := fontX + (X - lastX);
    fontY := fontY + (Y - lastY);
    lastX := X;
    lastY := Y;
  end;
end;

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  fontMoving := FALSE;
end;

procedure TForm1.SpinLeftChange(Sender: TObject);
begin
  if SpinLeft.Value < 0 then
    SpinLeft.Value := 0;
  if fg_FontPadding[0] <> SpinLeft.Value Then
  begin
    fg_FontPadding[0] := SpinLeft.Value;
    UpdateFont();
  end;
end;

procedure TForm1.SpinTopChange(Sender: TObject);
begin
  if SpinTop.Value < 0 then
    SpinTop.Value := 0;
  if fg_FontPadding[1] <> SpinTop.Value Then
  begin
    fg_FontPadding[1] := SpinTop.Value;
    UpdateFont();
  end;
end;

procedure TForm1.SpinRightChange(Sender: TObject);
begin
  if SpinRight.Value < 0 then
    SpinRight.Value := 0;
  if fg_FontPadding[2] <> SpinRight.Value Then
  begin
    fg_FontPadding[2] := SpinRight.Value;
    UpdateFont();
  end;
end;

procedure TForm1.SpinBottomChange(Sender: TObject);
begin
  if SpinBottom.Value < 0 then
    SpinBottom.Value := 0;
  if fg_FontPadding[3] <> SpinBottom.Value Then
  begin
    fg_FontPadding[3] := SpinBottom.Value;
    UpdateFont();
  end;
end;

procedure TForm1.ButtonSaveFontClick(Sender: TObject);
  var
    style : String;
    name  : String;
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

  SaveFontDialog.FileName := FontDialog.Font.Name + '-' + style + '-' + IntToStr(fg_FontSize) + 'pt';

  if SaveFontDialog.Execute() Then
  begin
    name := file_GetName(SaveFontDialog.FileName);
    dir  := file_GetDirectory(SaveFontDialog.FileName);
    fontgen_SaveFont(fg_Font, dir + name);
  end;
end;

procedure TForm1.CheckBoxAntialiasingChange(Sender: TObject);
begin
  fg_FontAA := CheckBoxAntialiasing.Checked;
  UpdateFont();
end;

procedure TForm1.CheckBoxPackChange(Sender: TObject);
begin
  fg_FontPack := CheckBoxPack.Checked;
  UpdateFont();
end;

procedure TForm1.ComboBoxPageSizeChange(Sender: TObject);
begin
  fg_PageSize := StrToInt(ComboBoxPageSize.Items[ComboBoxPageSize.ItemIndex]);
  UpdateFont();
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if not zglInited Then
  begin
    zglInited := TRUE;

    zgl_Disable(APP_USE_LOG);

    zgl_Reg(SYS_LOAD, @Init);
    zgl_Reg(SYS_DRAW, @Draw);

    zgl_InitToHandle(Panel1.Handle);

    Application.Terminate();
  end;
end;

procedure TForm1.SpinCurrentPageChange(Sender: TObject);
begin
  if SpinCurrentPage.Value < 1 then
    SpinCurrentPage.Value := 1;
end;

end.

