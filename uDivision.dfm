object sprDepartments: TsprDepartments
  Left = 0
  Top = 0
  Width = 508
  Height = 304
  TabOrder = 0
  TabStop = True
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 33
    Width = 508
    Height = 271
    Align = alClient
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
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Title.Caption = #1050#1086#1076
        Width = 44
      end
      item
        EditButtons = <>
        FieldName = 'DepartmentName'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1090#1076#1077#1083#1072
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'DepNameSubDivision'
        Footers = <>
        Title.Caption = #1043#1083#1072#1074#1085#1099#1081' '#1086#1090#1076#1077#1083
        Width = 200
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBPanel1: TDBPanel
    Left = 0
    Top = 0
    Width = 508
    Height = 33
    Align = alTop
    Caption = ' '
    TabOrder = 1
    DataSource = MSDataSource1
  end
  object MSTable1: TMSTable
    TableName = 'dbo.Departments'
    OrderFields = 'DepartmentName'
    Connection = fMain.MSConnection1
    Left = 80
    Top = 120
    object MSTable1ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      ReadOnly = True
    end
    object MSTable1DepartmentName: TStringField
      FieldName = 'DepartmentName'
      FixedChar = True
      Size = 60
    end
    object MSTable1DepartmetOwner: TIntegerField
      FieldName = 'DepartmetOwner'
    end
    object MSTable1DepNameSubDivision: TStringField
      FieldKind = fkLookup
      FieldName = 'DepNameSubDivision'
      LookupDataSet = MSTable2
      LookupKeyFields = 'ID'
      LookupResultField = 'DepartmentName'
      KeyFields = 'DepartmetOwner'
      Lookup = True
    end
  end
  object MSDataSource1: TMSDataSource
    DataSet = MSTable1
    Left = 144
    Top = 120
  end
  object MSTable2: TMSTable
    TableName = 'Departments'
    Left = 80
    Top = 184
  end
end
