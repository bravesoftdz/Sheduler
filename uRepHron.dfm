object fRepHron: TfRepHron
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083
  ClientHeight = 333
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 753
    Height = 333
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataSource = MSDataSource1
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    IndicatorOptions = [gioShowRowIndicatorEh]
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleBtnClick = DBGridEh1TitleBtnClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'UserName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1060#1048#1054
        Width = 215
      end
      item
        EditButtons = <>
        FieldName = 'TaskName'
        Footers = <>
        Title.Caption = #1047#1072#1076#1072#1095#1072
      end
      item
        EditButtons = <>
        FieldName = 'StartTime'
        Footers = <>
        Title.Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072
      end
      item
        EditButtons = <>
        FieldName = 'EndTime'
        Footers = <>
        Title.Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      end
      item
        EditButtons = <>
        FieldName = 'MIN'
        Footers = <>
        Title.Caption = #1055#1086#1090#1088#1072#1095#1077#1085#1086' ('#1084#1080#1085')'
      end
      item
        EditButtons = <>
        FieldName = 'Norm'
        Footers = <>
        Title.Caption = #1053#1086#1088#1084#1072#1090#1080#1074
      end
      item
        EditButtons = <>
        FieldName = 'Ratio'
        Footers = <>
        Title.Caption = #1082#1086#1083'-'#1074#1086
      end
      item
        EditButtons = <>
        FieldName = 'Note'
        Footers = <>
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MSQuery1: TMSQuery
    SQL.Strings = (
      'Select F.ID,'
      '       F.StartTime,'
      '       F.EndTime,'
      '       F.Deltatime,'
      '       F.[MIN],'
      '       F.[SEC],'
      '       F.TaskName,'
      '       F.Note,'
      '       F.Sender,'
      '       F.DayTask,'
      '       F.UserID,'
      '       U.UserName,'
      '       F.Norm,'
      '       F.Ratio'
      'from viewFactForUser F'
      'left join Users U on U.UserID = F.UserID')
    Left = 120
    Top = 40
    object MSQuery1ID: TIntegerField
      FieldName = 'ID'
    end
    object MSQuery1StartTime: TDateTimeField
      FieldName = 'StartTime'
    end
    object MSQuery1EndTime: TDateTimeField
      FieldName = 'EndTime'
    end
    object MSQuery1Deltatime: TDateTimeField
      FieldName = 'Deltatime'
      ReadOnly = True
    end
    object MSQuery1MIN: TIntegerField
      FieldName = 'MIN'
      ReadOnly = True
    end
    object MSQuery1SEC: TIntegerField
      FieldName = 'SEC'
      ReadOnly = True
    end
    object MSQuery1TaskName: TStringField
      FieldName = 'TaskName'
      ReadOnly = True
      FixedChar = True
      Size = 70
    end
    object MSQuery1Note: TStringField
      FieldName = 'Note'
      FixedChar = True
      Size = 300
    end
    object MSQuery1Sender: TIntegerField
      FieldName = 'Sender'
    end
    object MSQuery1DayTask: TDateTimeField
      FieldName = 'DayTask'
    end
    object MSQuery1UserID: TIntegerField
      FieldName = 'UserID'
    end
    object MSQuery1UserName: TStringField
      FieldName = 'UserName'
      ReadOnly = True
      FixedChar = True
      Size = 150
    end
    object MSQuery1Norm: TFloatField
      FieldName = 'Norm'
      ReadOnly = True
    end
    object MSQuery1Ratio: TFloatField
      FieldName = 'Ratio'
    end
  end
  object MSDataSource1: TMSDataSource
    DataSet = MSQuery1
    Left = 40
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Filter = #1060#1072#1081#1083#1099' Excel (xls)|*.xls'
    Left = 184
    Top = 40
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 40
    object N1: TMenuItem
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1092#1072#1081#1083
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100
      OnClick = N2Click
    end
  end
end
