unit uRepHron;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MultiFilter, DBGridEhGrouping, DB, DBAccess, MSAccess, MemDS,
  GridsEh, DBGridEh, Menus,DBGridEhImpExp, EHLibADO;

type
  TfRepHron = class(TForm)
    DBGridEh1: TDBGridEh;
    MSQuery1: TMSQuery;
    MSDataSource1: TMSDataSource;
    MSQuery1ID: TIntegerField;
    MSQuery1StartTime: TDateTimeField;
    MSQuery1EndTime: TDateTimeField;
    MSQuery1Deltatime: TDateTimeField;
    MSQuery1MIN: TIntegerField;
    MSQuery1SEC: TIntegerField;
    MSQuery1TaskName: TStringField;
    MSQuery1Note: TStringField;
    MSQuery1Sender: TIntegerField;
    MSQuery1DayTask: TDateTimeField;
    MSQuery1UserID: TIntegerField;
    MSQuery1UserName: TStringField;
    MSQuery1Norm: TFloatField;
    MSQuery1Ratio: TFloatField;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MF: TMultiFilter;
  end;

var
  fRepHron: TfRepHron;

implementation
uses
  uMain;
{$R *.dfm}

procedure TfRepHron.DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
var
  SortM: string;
begin
  if Column.Title.SortMarker = smDownEh
  then begin
    Column.Title.SortMarker := smUpEh;
    SortM := ' ASC ';
  end else begin
    Column.Title.SortMarker := smDownEh;
    SortM := ' DESC ';
  end;

  MSQuery1.Close;
  MSQuery1.SQL.Clear;
  MSQuery1.SQL.Add(' Select F.ID,F.StartTime,F.EndTime,F.Deltatime,F.[MIN],F.[SEC],F.TaskName,F.Note,F.Sender,F.DayTask,F.UserID,U.UserName,F.Norm,F.Ratio from viewFactForUser F left join Users U on U.UserID = F.UserID ');
  MSQuery1.SQL.Add( MF.FilterWhere );
  MSQuery1.SQL.Add( ' Order By '+Column.FieldName + SortM );

  MSQuery1.Open;

end;

procedure TfRepHron.FormActivate(Sender: TObject);
begin
  MSQuery1.Connection := fMain.msCon;
  if fMain.msCon.Connected then begin
    if MSQuery1.Active then MSQuery1.Refresh else MSQuery1.Open;
  end;
end;

procedure TfRepHron.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  if not Assigned(mf) then begin
    MF := TMultiFilter.Create(fRepHron);
    with mf do begin
      Parent := fRepHron;
      MF.DS := MSQuery1;
      MF.Grid := DBGridEh1;
    end;
  end;

  if Assigned(DbGridEh1) then begin
    For i:=0 to DbGridEh1.Columns.Count-1 do begin
      DbGridEh1.Columns[i].Title.TitleButton := TRUE;  //��������� "������"
    end;
  {
  DbGridEh1.OptionsEh := DbGridEh1.OptionsEh + [dghAutoSortMarking]; //�������������� ����������
  DbGridEh1.SortLocal:= True;
  }
  end;

end;

procedure TfRepHron.N1Click(Sender: TObject);
var
  Path:String;
begin
  if SaveDialog1.Execute then
    begin
      Path := SaveDialog1.FileName + '.xls';
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS, DBGridEh1, Path, True);
    end;
end;

procedure TfRepHron.N2Click(Sender: TObject);
var
  MSQQ: TMSQuery;
begin
  // ��������� ������
  if MSQuery1.RecordCount > 0 then
    case MessageDlg('��������� ������: ' + MSQuery1.FieldByName('TaskName').AsString
      + '?', mtConfirmation, mbOKCancel, 0) of
      mrOk:
        Begin
          MSQQ := TMSQuery.Create(Self);
          with MSQQ do
          begin
            Connection := fMain.msCon;
            SQL.Add('exec dbo.procCloseTask :TaskID');
            ParamByName('TaskID').AsInteger := MSQuery1.FieldByName('ID').AsInteger;
            Execute;
            Free;
          end;
        End;
    end;
    MSQuery1.Refresh;
end;

end.
