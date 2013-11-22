object Form1: TForm1
  Left = 408
  Top = 99
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26539#21494#39321#34121'v3.1.0.2'
  ClientHeight = 107
  ClientWidth = 574
  Color = clScrollBar
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 208
    Top = 32
    Width = 297
    Height = 57
    AutoSize = False
    Caption = #19987#19994#39640#36895#32763#22681
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object WebBrowser1: TWebBrowser
    Left = 128
    Top = 73
    Width = 9
    Height = 16
    TabOrder = 0
    ControlData = {
      4C000000EE000000A70100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 568
    Top = 192
    object N14: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Caption = '       '#26539#21494#39321#34121#23448#32593
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = '      '#26174#31034#20027#38754#26495
      OnClick = N5Click
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = N1Click
    end
    object N15: TMenuItem
      Caption = '      '#21462#28040#20195#29702
      Enabled = False
      OnClick = N15Click
    end
    object N2: TMenuItem
      Caption = '       '#20840#23616#20195#29702
      Enabled = False
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '       '#26234#33021#20195#29702
      Enabled = False
      OnClick = N3Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = '        '#36864#20986
      OnClick = N4Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 8000
    OnTimer = Timer1Timer
    Left = 568
    Top = 232
  end
  object MainMenu1: TMainMenu
    Left = 568
    Top = 112
    object N9: TMenuItem
      Caption = #20851#20110#26539#21494#39321#34121
      object N10: TMenuItem
        Caption = #26539#21494#39321#34121#25512#29305
        OnClick = N10Click
      end
      object N11: TMenuItem
        Caption = #21338#23458
        OnClick = N11Click
      end
      object N13: TMenuItem
        Caption = #36148#21543
        OnClick = N13Click
      end
      object N12: TMenuItem
        Caption = #20851#20110
        OnClick = N12Click
      end
    end
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer2Timer
    Left = 568
    Top = 280
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 2000
    Left = 568
    Top = 64
  end
end
