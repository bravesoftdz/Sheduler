object sprUsers: TsprUsers
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  TabStop = True
  OnResize = FrameResize
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = -37
    Width = 451
    Height = 341
    Align = alBottom
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
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghPreferIncSearch, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 3
    Columns = <
      item
        EditButtons = <>
        FieldName = 'UserID'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = 'ID '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1074' '#1041#1044
        Width = 77
      end
      item
        EditButtons = <>
        FieldName = 'UserName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        Title.ToolTips = True
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'DepartmentName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1090#1076#1077#1083#1072
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'PostName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'controller'
        Footers = <>
        Title.Caption = #1055#1088#1086#1074#1077#1088#1103#1102#1097#1080#1081
        Width = 104
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Button1: TButton
    Left = 218
    Top = 35
    Width = 105
    Height = 21
    Caption = 'ID '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 3
    Top = 35
    Width = 209
    Height = 21
    TabOrder = 0
  end
  object DBPanel1: TDBPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 33
    Align = alTop
    Caption = ' '
    TabOrder = 3
    DataSource = MSDataSource1
  end
  object Departments: TMSTable
    TableName = 'dbo.Departments'
    OrderFields = 'DepartmentName'
    Left = 216
    Top = 160
  end
  object Posts: TMSTable
    TableName = 'dbo.Posts'
    OrderFields = 'PostName'
    Left = 248
    Top = 160
  end
  object MSQuery1: TMSQuery
    SQL.Strings = (
      'select *'
      'from viewUsers'
      'order by DepartmentName, UserName')
    Left = 8
    Top = 160
    object MSQuery1UserID: TIntegerField
      FieldName = 'UserID'
      Origin = 'dbo.Users.UserID'
    end
    object MSQuery1UserName: TStringField
      FieldName = 'UserName'
      Origin = 'dbo.Users.UserName'
      FixedChar = True
      Size = 150
    end
    object MSQuery1DepartmentID: TIntegerField
      FieldName = 'DepartmentID'
      Origin = 'dbo.Users.DepartmentID'
    end
    object MSQuery1PostID: TIntegerField
      FieldName = 'PostID'
      Origin = 'dbo.Users.PostID'
    end
    object MSQuery1DepartmentName: TStringField
      FieldKind = fkLookup
      FieldName = 'DepartmentName'
      LookupDataSet = Departments
      LookupKeyFields = 'ID'
      LookupResultField = 'DepartmentName'
      KeyFields = 'DepartmentID'
      Origin = 'dbo.Departments.DepartmentName'
      Size = 60
      Lookup = True
    end
    object MSQuery1PostName: TStringField
      FieldKind = fkLookup
      FieldName = 'PostName'
      LookupDataSet = Posts
      LookupKeyFields = 'ID'
      LookupResultField = 'PostName'
      KeyFields = 'PostID'
      Origin = 'dbo.Posts.PostName'
      FixedChar = True
      Size = 70
      Lookup = True
    end
    object MSQuery1controller: TBooleanField
      FieldName = 'controller'
    end
  end
  object MSDataSource1: TMSDataSource
    DataSet = MSQuery1
    Left = 40
    Top = 160
  end
end
