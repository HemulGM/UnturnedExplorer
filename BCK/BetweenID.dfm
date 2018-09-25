object FormBID: TFormBID
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1087#1072#1079#1086#1085' ID '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
  ClientHeight = 167
  ClientWidth = 319
  Color = clBtnFace
  Constraints.MaxHeight = 196
  Constraints.MaxWidth = 325
  Constraints.MinHeight = 196
  Constraints.MinWidth = 325
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 127
    Width = 319
    Height = 40
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object ButtonCancel: TButton
      AlignWithMargins = True
      Left = 241
      Top = 3
      Width = 75
      Height = 32
      Align = alRight
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 232
      ExplicitTop = 4
      ExplicitHeight = 25
    end
    object ButtonOK: TButton
      AlignWithMargins = True
      Left = 160
      Top = 3
      Width = 75
      Height = 32
      Align = alRight
      Caption = #1054#1050
      TabOrder = 1
      OnClick = ButtonOKClick
      ExplicitLeft = 151
      ExplicitTop = 4
      ExplicitHeight = 25
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 319
    Height = 127
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 80
    ExplicitTop = 8
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 313
      Height = 30
      Align = alTop
      AutoSize = False
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1076#1080#1072#1087#1072#1079#1086#1085' ID '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072' '#1076#1083#1103' '#1082#1086#1090#1086#1088#1086#1075#1086' '#1087#1086#1076#1093#1086#1076#1080#1090' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 367
    end
    object Label2: TLabel
      Left = 148
      Top = 69
      Width = 20
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Layout = tlCenter
    end
    object EditBegin: TEdit
      Left = 69
      Top = 66
      Width = 73
      Height = 21
      TabOrder = 0
    end
    object EditEnd: TEdit
      Left = 174
      Top = 66
      Width = 72
      Height = 21
      TabOrder = 1
    end
  end
end
