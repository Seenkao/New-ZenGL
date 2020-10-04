object Form2: TForm2
  Left = 691
  Top = 397
  BorderStyle = bsDialog
  Caption = 'Processing text, please wait...'
  ClientHeight = 20
  ClientWidth = 320
  Color = clBtnFace
  Constraints.MaxHeight = 56
  Constraints.MaxWidth = 334
  Constraints.MinHeight = 20
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 0
    Width = 320
    Height = 20
    Align = alClient
    Smooth = True
    Step = 1
    TabOrder = 0
  end
end
