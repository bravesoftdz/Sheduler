unit uAddTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GridsEh, DBGridEh, DB, DBAccess, MSAccess, MemDS, ActnList,
  DBGridEhGrouping;

type
  TfAddTask = class(TForm)
    Edit1: TEdit;
    DBGridEh1: TDBGridEh;
    Button1: TButton;
    Button2: TButton;
    ActionList1: TActionList;
    MSQuery1: TMSQuery;
    MSDataSource1: TMSDataSource;
    MSQuery1ID: TIntegerField;
    MSQuery1TaskName: TStringField;
    ClearFilter: TAction;
    butAddFakt: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure butAddFaktExecute(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ClearFilterExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAddTask: TfAddTask;


implementation

{$R *.dfm}

USES uMain;

procedure TfAddTask.butAddFaktExecute(Sender: TObject);
var
  MSQ,MSQ2: TMSQuery;

begin
  MSQ := TMSQuery.Create(nil);
  MSQ.Connection := fMain.MSCon;

  MSQ2 := TMSQuery.Create(nil);
  MSQ2.Connection := fMain.MSCon;

  MSQ2.Close;
  MSQ2.SQL.Clear;
  MSQ2.SQL.Add('SELECT ID FROM TaskList WHERE (TaskName = '''+Edit1.Text+''') and (DepartmentID = dbo.funcUserDepartment(User_Id()))');
  MSQ2.Open;

  if MSQ2.RecordCount = 0 then begin
    MSQ.Close;
    MSQ.SQL.Clear;
    MSQ.SQL.Add(' INSERT INTO TaskList (TaskName, DepartmentID) ');
    MSQ.SQL.Add(' SELECT '''+Edit1.Text+''', DepartmentID from Users where UserID = USER_ID() ');
    MSQ.Execute;
    MSQ.Free;
    MSQuery1.Refresh;

    MSQ2.Close;
    MSQ2.SQL.Clear;
    MSQ2.SQL.Add('SELECT ID FROM TaskList WHERE TaskName = '''+Edit1.Text+'''');
    MSQ2.Open;

    fMain.InsertFaktTask(MSQ2.FieldByName('ID').AsInteger);
  end;
  MSQ2.Free;
  fAddTask.Edit1.Text := '';
  fAddTask.Close;
end;

procedure TfAddTask.ClearFilterExecute(Sender: TObject);
begin
  fAddTask.Edit1.Text:='';
  fAddTask.Close;
end;

procedure TfAddTask.DBGridEh1DblClick(Sender: TObject);
begin
  fMain.InsertFaktTask(MSQuery1.FieldByName('ID').AsInteger);
  ClearFilterExecute(Nil);
end;

procedure TfAddTask.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fMain.FilterQuery(fAddTask.MSQuery1, fAddTask.Edit1.Text);
end;

procedure TfAddTask.FormActivate(Sender: TObject);
begin
    Edit1.Text := '';
    MSQuery1.Connection := fMain.msCon;
    MSQuery1.Close;
    MSQuery1.SQL.Clear;
    MSQuery1.SQL.Add(' SELECT ID,TaskName ');
    MSQuery1.SQL.Add(' FROM dbo.TaskList TL ');
    MSQuery1.SQL.Add(' WHERE TL.DepartmentID = (select DepartmentID from Users where UserID = USER_ID()) ');
    MSQuery1.SQL.Add(' ORDER BY TL.TaskName ');
    MSQuery1.Open;
    Edit1.SetFocus;
end;

procedure TfAddTask.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  frmMain.RestoreExecute(Nil);
end;

end.
