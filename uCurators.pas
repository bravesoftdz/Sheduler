unit uCurators;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, MSAccess, DB, MemDS, DBAccess, Grids, DBGridEh, GridsEh, ComCtrls,
  ToolWin, ExtCtrls, DimTB, DBGridEhGrouping;

type
  TsprCurators = class(TFrame)
    DBGridEh1: TDBGridEh;
    MSQuery1: TMSQuery;
    MSTable1: TMSTable;
    MSTable2: TMSTable;
    MSDataSource1: TMSDataSource;
    MSQuery1ID: TIntegerField;
    MSQuery1UserID: TIntegerField;
    MSQuery1DepartmentID: TIntegerField;
    MSQuery1UserName: TStringField;
    MSQuery1DepartmentName: TStringField;
    DBPanel1: TDBPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
uses uMain;
end.
