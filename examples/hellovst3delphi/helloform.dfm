object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 262
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelGain: TLabel
    Left = 60
    Top = 100
    Width = 52
    Height = 15
    Caption = 'LabelGain'
  end
  object TrackBarGain: TTrackBar
    Left = 50
    Top = 150
    Width = 400
    Height = 45
    Max = 10000
    Frequency = 1000
    TabOrder = 0
    OnChange = TrackBarGainChange
  end
  object ButtonReset: TButton
    Left = 60
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 1
    OnClick = ButtonResetClick
  end
end
