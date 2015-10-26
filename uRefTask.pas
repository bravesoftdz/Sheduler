unit uRefTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, GridsEh, DBGridEh, DB, DBAccess, MSAccess, MemDS,
  ExtCtrls, DBAdvNavigator, DimTB, Menus, DBGridEhImpExp, StdCtrls;

type
  TRefTask = class(TForm)
    MSQuery1: TMSQuery;
    MSDataSource1: TMSDataSource;
    DBGridEh1: TDBGridEh;
    DBPanel1: TDBPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    MSTable1: TMSTable;
    MSQuery1ID: TIntegerField;
    MSQuery1TaskName: TStringField;
    MSQuery1DepartmentID: TIntegerField;
    MSQuery1OldTask: TBooleanField;
    MSQuery1Norm: TFloatField;
    MSQuery1DepartmentName: TStringField;
    MSQuery1DepName: TStringField;
    MSQuery1getRatio: TBooleanField;
    procedure FormActivate(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    SearchEd: TEdit;
  public
    { Public declarations }
    procedure SearchOnKeyPress(Sender: TObject; var Key: Char);
  end;

var
  RefTask: TRefTask;

implementation
uses
  uMain;
{$R *.dfm}

procedure TRefTask.FormActivate(Sender: TObject);
begin
  MSQuery1.Connection := fMain.msCon;
  MSTable1.Connection := fMain.msCon;
  if fMain.msCon.Connected then begin
    if MSTable1.Active then MSTable1.Refresh else MSTable1.Open;
    if MSQuery1.Active then MSQuery1.Refresh else MSQuery1.Open;

  if not Assigned(SearchEd) then begin
    SearchEd := TEdit.Create(DBPanel1);
    with SearchEd do begin
      Parent := DBPanel1;
      with Margins do begin
        Top := 6;
        Bottom := 6;
        Right := 6;
      end;
      AlignWithMargins := True;
      Align := alRight;
      Hint := '����� �� ������������';
      TextHint := '������� ������������';
      ShowHint := True;
      Width := 200;
      Text := '';
      OnKeyPress := SearchOnKeyPress;
    end;
  end;


  end;
end;

procedure TRefTask.N1Click(Sender: TObject);
var
  Path: String;
begin
  if SaveDialog1.Execute then
    begin
      Path := SaveDialog1.FileName + '.xls';
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS, DBGridEh1, Path, True);
    end;
end;

procedure TRefTask.SearchOnKeyPress(Sender: TObject; var Key: Char);
var
  SearchStr: String;
begin
  SearchStr := SearchEd.Text;
  if Key = Char(#08) then SetLength(SearchStr,Length(SearchStr)-1) else SearchStr := SearchStr + Key;
    with MSQuery1 do begin
      Close;
      if (Length(SearchStr) = 0) or (Key = Char(#$1B)) then
        DeleteWhere
      else begin
        DeleteWhere;
        AddWhere(Format('TaskName like ''%%%s%%''',[SearchStr]));
      end;
      Open;
    end
end;

end.
