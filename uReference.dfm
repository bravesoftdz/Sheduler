object frmReference: TfrmReference
  Left = 0
  Top = 0
  AlphaBlendValue = 100
  BorderStyle = bsSizeToolWin
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082
  ClientHeight = 400
  ClientWidth = 703
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
  inline sprUsers1: TsprUsers
    Left = 0
    Top = 0
    Width = 703
    Height = 400
    Align = alClient
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 703
    ExplicitHeight = 400
    inherited DBGridEh1: TDBGridEh
      Top = 59
      Width = 703
    end
    inherited DBPanel1: TDBPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
  inline sprPosts1: TsprPosts
    Left = 0
    Top = 0
    Width = 703
    Height = 400
    Align = alClient
    TabOrder = 1
    TabStop = True
    ExplicitWidth = 703
    ExplicitHeight = 400
    inherited DBGridEh1: TDBGridEh
      Width = 703
      Height = 367
    end
    inherited DBPanel1: TDBPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
  inline sprCurators1: TsprCurators
    Left = 0
    Top = 0
    Width = 703
    Height = 400
    Align = alClient
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 703
    ExplicitHeight = 400
    inherited DBGridEh1: TDBGridEh
      Width = 703
      Height = 367
    end
    inherited DBPanel1: TDBPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
  inline sprDepartments1: TsprDepartments
    Left = 0
    Top = 0
    Width = 703
    Height = 400
    Align = alClient
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 703
    ExplicitHeight = 400
    inherited DBGridEh1: TDBGridEh
      Width = 703
      Height = 367
    end
    inherited DBPanel1: TDBPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
end
