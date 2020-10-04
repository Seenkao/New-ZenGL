object Form1: TForm1
  Left = 85
  Height = 644
  Top = 85
  Width = 810
  Caption = 'Form1'
  ClientHeight = 644
  ClientWidth = 810
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  Position = poDesktopCenter
  LCLVersion = '7.0'
  object Panel1: TPanel
    Left = 5
    Height = 600
    Top = 5
    Width = 800
    TabOrder = 0
  end
  object Button1: TButton
    Left = 5
    Height = 25
    Top = 613
    Width = 91
    Caption = 'Выбор окна'
    OnClick = Button1Click
    TabOrder = 1
  end
  object Button2: TButton
    Left = 730
    Height = 25
    Top = 613
    Width = 75
    Caption = 'Скрин'
    TabOrder = 2
  end
  object Label1: TLabel
    Left = 136
    Height = 15
    Top = 620
    Width = 34
    Caption = 'X = 0'
    ParentColor = False
  end
  object Label2: TLabel
    Left = 248
    Height = 15
    Top = 620
    Width = 33
    Caption = 'Y = 0'
    ParentColor = False
  end
  object Label3: TLabel
    Left = 400
    Height = 15
    Top = 620
    Width = 62
    Caption = 'Width = 0'
    ParentColor = False
  end
  object Label4: TLabel
    Left = 560
    Height = 15
    Top = 620
    Width = 66
    Caption = 'Height = 0'
    ParentColor = False
  end
  object UpDown1: TUpDown
    Left = 112
    Height = 31
    Top = 612
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 3
  end
  object UpDown2: TUpDown
    Left = 224
    Height = 31
    Top = 612
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 4
  end
  object UpDown3: TUpDown
    Left = 376
    Height = 31
    Top = 612
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 5
  end
  object UpDown4: TUpDown
    Left = 536
    Height = 31
    Top = 612
    Width = 17
    Min = 0
    Position = 0
    TabOrder = 6
  end
end
