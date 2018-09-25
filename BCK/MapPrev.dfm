object FormMap: TFormMap
  Left = 0
  Top = 0
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1082#1072#1088#1090#1099
  ClientHeight = 556
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 666
    Height = 535
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    TabOrder = 0
    object ImageMap: TImage
      Left = 0
      Top = 0
      Width = 497
      Height = 433
      Proportional = True
      Stretch = True
      OnMouseDown = ImageMapMouseDown
      OnMouseMove = ImageMapMouseMove
      OnMouseUp = ImageMapMouseUp
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 535
    Width = 666
    Height = 21
    Align = alBottom
    ButtonHeight = 21
    ButtonWidth = 61
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'Zoom In +'
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 61
      Top = 0
      Caption = 'Zoom Out -'
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 122
      Top = 0
      Caption = '100'
      ImageIndex = 2
      OnClick = ToolButton3Click
    end
  end
end
