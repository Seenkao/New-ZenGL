object Form1: TForm1
  Left = 287
  Height = 640
  Top = 141
  Width = 800
  Caption = 'Form1'
  ClientHeight = 640
  ClientWidth = 800
  OnDestroy = FormDestroy
  LCLVersion = '7.0'
  object Panel1: TPanel
    Left = 0
    Height = 600
    Top = 0
    Width = 800
    TabOrder = 0
  end
  object Button1: TButton
    Left = 0
    Height = 25
    Top = 608
    Width = 115
    Caption = 'Выбрать захват'
    OnClick = Button1Click
    TabOrder = 1
  end
  object Button2: TButton
    Left = 600
    Height = 25
    Top = 608
    Width = 187
    Caption = 'сделать и сохранить скрин'
    TabOrder = 2
  end
  object Label1: TLabel
    Left = 144
    Height = 15
    Top = 616
    Width = 34
    Caption = 'X = 0'
    ParentColor = False
  end
  object Label2: TLabel
    Left = 240
    Height = 15
    Top = 616
    Width = 33
    Caption = 'Y = 0'
    ParentColor = False
  end
  object Label3: TLabel
    Left = 344
    Height = 15
    Top = 616
    Width = 62
    Caption = 'Width = 0'
    ParentColor = False
  end
  object Label4: TLabel
    Left = 480
    Height = 15
    Top = 616
    Width = 66
    Caption = 'Height = 0'
    ParentColor = False
  end
  object UpDownX: TUpDown
    Left = 120
    Height = 31
    Top = 608
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 3
  end
  object UpDownY: TUpDown
    Left = 216
    Height = 31
    Top = 609
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 4
  end
  object UpDownW: TUpDown
    Left = 320
    Height = 31
    Top = 608
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 5
  end
  object UpDownH: TUpDown
    Left = 453
    Height = 31
    Top = 608
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 6
  end
end
