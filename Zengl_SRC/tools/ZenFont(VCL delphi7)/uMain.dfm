object Form1: TForm1
  Left = 207
  Top = 0
  ActiveControl = Panel1
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'ZenFont 0.2.6(LCL)'
  ClientHeight = 692
  ClientWidth = 1013
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 552
    Width = 1013
    Height = 140
    Align = alBottom
    Caption = 'Parameters'
    TabOrder = 0
    DesignSize = (
      1013
      140)
    object LabelCurrentPage: TLabel
      Left = 10
      Top = 39
      Width = 68
      Height = 13
      Caption = 'Current Page:'
      Color = clBtnFace
      ParentColor = False
    end
    object LabelPageSize: TLabel
      Left = 10
      Top = 15
      Width = 50
      Height = 13
      Caption = 'Page Size:'
      Color = clBtnFace
      ParentColor = False
    end
    object CheckBoxAntialiasing: TCheckBox
      Left = 10
      Top = 55
      Width = 93
      Height = 21
      Caption = 'Antialiasing'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBoxAntialiasingChange
    end
    object CheckBoxPack: TCheckBox
      Left = 106
      Top = 56
      Width = 52
      Height = 21
      Caption = 'Pack'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBoxPackChange
    end
    object ComboBoxPageSize: TComboBox
      Left = 90
      Top = 10
      Width = 70
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 2
      Text = '256'
      OnChange = ComboBoxPageSizeChange
      Items.Strings = (
        '128'
        '256'
        '512'
        '1024'
        '2048')
    end
    object ButtonChooseFont: TButton
      Left = 10
      Top = 86
      Width = 150
      Height = 25
      Caption = 'Choose Font'
      TabOrder = 3
      OnClick = ButtonChooseFontClick
    end
    object ButtonSaveFont: TButton
      Left = 853
      Top = 40
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save Font'
      TabOrder = 5
      OnClick = ButtonSaveFontClick
    end
    object ButtonExit: TButton
      Left = 853
      Top = 110
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Exit'
      TabOrder = 6
      OnClick = ButtonExitClick
    end
    object ButtonRebuildFont: TButton
      Left = 853
      Top = 10
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Rebuild Font'
      TabOrder = 4
      OnClick = ButtonRebuildFontClick
    end
    object GroupBox2: TGroupBox
      Left = 170
      Top = 104
      Width = 673
      Height = 39
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Char Padding'
      TabOrder = 7
      object Label1: TLabel
        Left = 120
        Top = 15
        Width = 22
        Height = 13
        Caption = 'Top:'
        Color = clBtnFace
        ParentColor = False
      end
      object Label2: TLabel
        Left = 10
        Top = 15
        Width = 23
        Height = 13
        Caption = 'Left:'
        Color = clBtnFace
        ParentColor = False
      end
      object Label3: TLabel
        Left = 220
        Top = 15
        Width = 29
        Height = 13
        Caption = 'Right:'
        Color = clBtnFace
        ParentColor = False
      end
      object Label4: TLabel
        Left = 340
        Top = 15
        Width = 38
        Height = 13
        Caption = 'Bottom:'
        Color = clBtnFace
        ParentColor = False
      end
      object SpinTop: TSpinEdit
        Left = 160
        Top = 10
        Width = 50
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 2
        OnChange = SpinTopChange
      end
      object SpinLeft: TSpinEdit
        Left = 60
        Top = 10
        Width = 50
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 2
        OnChange = SpinLeftChange
      end
      object SpinRight: TSpinEdit
        Left = 280
        Top = 10
        Width = 50
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 2
        OnChange = SpinRightChange
      end
      object SpinBottom: TSpinEdit
        Left = 400
        Top = 10
        Width = 50
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 2
        OnChange = SpinBottomChange
      end
    end
    object SpinCurrentPage: TSpinEdit
      Left = 110
      Top = 34
      Width = 50
      Height = 22
      MaxValue = 1
      MinValue = 1
      TabOrder = 8
      Value = 1
      OnChange = SpinCurrentPageChange
    end
    object GroupBox3: TGroupBox
      Left = 295
      Top = 8
      Width = 548
      Height = 95
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Chars'
      TabOrder = 9
      DesignSize = (
        548
        95)
      object ButtonDefaultSymbols: TButton
        Left = 11
        Top = 45
        Width = 150
        Height = 25
        Caption = 'Set default'
        TabOrder = 0
        OnClick = ButtonDefaultSymbolsClick
      end
      object ButtonImportSymbols: TButton
        Left = 383
        Top = 45
        Width = 150
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Import from file'
        TabOrder = 1
        OnClick = ButtonImportSymbolsClick
      end
      object EditChars: TEdit
        Left = 10
        Top = 10
        Width = 523
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
    end
    object GroupBox4: TGroupBox
      Left = 170
      Top = 8
      Width = 120
      Height = 95
      Caption = 'Test String'
      TabOrder = 10
      object EditTest: TEdit
        Left = 10
        Top = 10
        Width = 95
        Height = 21
        TabOrder = 0
        Text = 'Test'
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1013
    Height = 552
    Align = alClient
    Caption = 'Processing...'
    TabOrder = 1
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
    OnMouseUp = Panel1MouseUp
  end
  object SaveFontDialog: TSaveDialog
    Filter = 'Zen Font Info|*.zfi'
    Title = 'Save Font'
    Left = 130
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Sans'
    Font.Style = []
    Left = 230
  end
  object OpenDialog: TOpenDialog
    Filter = 'Any UTF-8 file|*.*'
    Title = 'Open text file'
    Left = 30
  end
end
