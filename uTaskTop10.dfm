object fTactTop10: TfTactTop10
  Left = 0
  Top = 0
  Caption = '10 '#1095#1072#1089#1090#1086' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1093' '#1079#1072#1076#1072#1095
  ClientHeight = 367
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 291
    Height = 361
    Align = alLeft
    AutoFitColWidths = True
    DataGrouping.GroupLevels = <>
    DataSource = MSDataSource1
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    IndicatorOptions = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NumPos'
        Footers = <>
        Title.Caption = #8470' '#1087'/'#1087
        Width = 35
      end
      item
        EditButtons = <>
        FieldName = 'TaskName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1063#1072#1089#1090#1086' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1077' '#1079#1072#1076#1072#1095#1080
        Width = 240
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBGridEh2: TDBGridEh
    AlignWithMargins = True
    Left = 369
    Top = 3
    Width = 291
    Height = 361
    Align = alClient
    AutoFitColWidths = True
    DataGrouping.GroupLevels = <>
    DataSource = MSDataSource2
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    IndicatorOptions = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        EditButtons = <>
        FieldName = 'TaskName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1076#1072#1095
        Width = 277
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 297
    Top = 0
    Width = 69
    Height = 367
    Align = alLeft
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 61
      Height = 32
      Align = alTop
      Caption = #1040#1074#1090#1086' '#1079#1072#1087#1086#1083#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 4
      Top = 42
      Width = 61
      Height = 30
      Align = alTop
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 4
      Top = 95
      Width = 61
      Height = 25
      Margins.Top = 20
      Align = alTop
      Caption = #1042#1074#1077#1088#1093
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 4
      Top = 126
      Width = 61
      Height = 25
      Align = alTop
      Caption = #1042#1085#1080#1079
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 4
      Top = 174
      Width = 61
      Height = 32
      Margins.Top = 20
      Align = alTop
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      TabOrder = 4
      WordWrap = True
      OnClick = Button5Click
    end
    object Button6: TButton
      AlignWithMargins = True
      Left = 4
      Top = 212
      Width = 61
      Height = 32
      Align = alTop
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      TabOrder = 5
      WordWrap = True
      OnClick = Button6Click
    end
    object Button7: TButton
      AlignWithMargins = True
      Left = 4
      Top = 250
      Width = 61
      Height = 32
      Align = alTop
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      TabOrder = 6
      WordWrap = True
      OnClick = Button7Click
      ExplicitLeft = 5
      ExplicitTop = 276
    end
  end
  object MSQuery1: TMSQuery
    SQL.Strings = (
      'SELECT *'
      'FROM viewTaskListTop10'
      'WHERE UserID = USER_ID()'
      'ORDER BY NumPos')
    Left = 120
    Top = 296
    object MSQuery1ID: TIntegerField
      FieldName = 'ID'
    end
    object MSQuery1NumPos: TIntegerField
      FieldName = 'NumPos'
    end
    object MSQuery1UserID: TIntegerField
      FieldName = 'UserID'
    end
    object MSQuery1TaskName: TStringField
      FieldName = 'TaskName'
      FixedChar = True
      Size = 70
    end
    object MSQuery1TaskID: TIntegerField
      FieldName = 'TaskID'
    end
  end
  object MSDataSource1: TMSDataSource
    DataSet = MSQuery1
    Left = 160
    Top = 296
  end
  object MSDataSource2: TMSDataSource
    Left = 472
    Top = 296
  end
end
