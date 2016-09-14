object FormStartSet: TFormStartSet
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1055#1077#1088#1074#1086#1085#1072#1095#1072#1083#1100#1085#1072#1103' '#1085#1072#1089#1090#1088#1086#1081#1082#1072
  ClientHeight = 129
  ClientWidth = 496
  Color = clBtnFace
  Constraints.MaxHeight = 167
  Constraints.MaxWidth = 512
  Constraints.MinHeight = 167
  Constraints.MinWidth = 512
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    496
    129)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 16
    Top = 30
    Width = 154
    Height = 13
    Caption = #1055#1091#1090#1100' '#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1102' Unturned:'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 198
    Height = 16
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1087#1091#1090#1100' '#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 1
    Top = 86
    Width = 497
    Height = 6
    Shape = bsTopLine
  end
  object EditHandlePath: TEdit
    Left = 8
    Top = 49
    Width = 401
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    AutoSelect = False
    AutoSize = False
    HideSelection = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 414
    Top = 47
    Width = 75
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 1
    OnClick = Button1Click
  end
  object ButtonOK: TButton
    Left = 414
    Top = 94
    Width = 75
    Height = 25
    Caption = #1043#1086#1090#1086#1074#1086
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 8
    Top = 94
    Width = 129
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
    TabOrder = 3
    OnClick = Button2Click
  end
  object FileOpenDialogApp: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' Unturned'
        FileMask = 'Unturned.exe'
      end>
    Options = [fdoFileMustExist]
    Title = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1072#1090#1072#1083#1086#1075' '#1089' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077#1084' Unturned'
    Left = 340
  end
end
