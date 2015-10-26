unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Planner, ExtCtrls, InspectorBar, INIInspectorBar, AppEvnts, Menus,
  StdCtrls, DB, DBAccess, MSAccess, SdacVcl, IniFiles, PropStorageEh, AdvNavBar,
  DBGridEhGrouping, GridsEh, DBGridEh, DateUtils, MemDS, frxClass, frxDBSet,
  frxExportXML, frxExportRTF, frxExportXLS, frxExportPDF, frxADOComponents,
  frxDCtrl, frxCross, AdvCardList, AdvPanel, Buttons, ImgList, W7Classes,
  W7Buttons, AdvEdit, AdvEdBtn, PlannerDatePicker, ComCtrls, DBGridEhImpExp,
  AdvSplitter, ActnList, Registry;

type
  TfMain = class(TForm)
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    frxRTFExport1: TfrxRTFExport;
    frxXMLExport1: TfrxXMLExport;
    frxDialogControls1: TfrxDialogControls;
    frxCrossObject1: TfrxCrossObject;
    ImageList1: TImageList;
    MSConnection1: TMSConnection;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    HK_C1, HK_C2, HK_C3, HK_C4, HK_C5, HK_C6, HK_C7, HK_C8, HK_C9,
      HK_C0: Integer;
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
  public
    { Public declarations }
    CurrentUser: Integer;
    CurrentUserName: String;
    CurrentDay: TDateTime;
    IsUserController: Boolean;
    TrIcon: TTrayIcon;
    AppEvents: TApplicationEvents;
    // TFPlanner: TPlanner; --�������� �� ���� 21.01.2015
    FactTaskGrid: TDBGridEh;
    mMenu: TMainMenu;
    pmFT: TPopupMenu;
    // ----
    msCon: TMSConnection;
    msConDlg: TMSConnectDialog;
    msDS: TMSDataSource;
    msDS10: TMSDataSource;
    // msQFactTask: TMSQuery;
    msQ: TMSQuery; // --���������� ����� ��� ������
    msQFil: TMSQuery;
    msQ10: TMSQuery; // --���������� ����� Top10
    msFT: TMSQuery; // --������ FacktTask
    msFB: TMSQuery;
    msDSFactTask: TMSDataSource;
    msDSFactBreak: TMSDataSource;
    FocusedQuery: TMSQuery;
    FocusedNameField: String;
    // ----
    MenuBar: TAdvNavBar;
    SplitterL: TAdvSplitter;
    SplitterR: TAdvSplitter;
    FactPlanner: TPlanner;
    ButPanel: TAdvPanel;
    ButPanelTop: TAdvPanel;
    DatePicker: TDateTimePicker;
    AddButton: TW7SpeedButton;
    DelButton: TW7SpeedButton;
    BreakButton: TW7SpeedButton;
    ConnectButton: TW7SpeedButton;
    RefreshButton: TW7SpeedButton;
    TOP10Button: TW7SpeedButton;
    AddTaskButton: TW7SpeedButton;
    DBGrid: TDBGridEh;
    DBGridTop10: TDBGridEh;
    BreakTaskGrid: TDBGridEh;
    cnServer, cnDataBase: string;
    MyActionList : TActionList;
    SetEndTaskWithClose: Boolean;
    procedure CreateObjects;
    procedure CreateDataGrid;
    procedure CreateComponentsForConnect;
    procedure ConnectToDB(Sender: TObject);
    procedure showRep3(Sender: TObject);
    procedure showRep5(Sender: TObject);
    procedure showRep6(Sender: TObject);
    procedure showRef1(Sender: TObject);
    procedure showRef2(Sender: TObject);
    procedure showRef3(Sender: TObject);
    procedure showRef4(Sender: TObject);
    procedure showRef5(Sender: TObject);
    procedure showTop10(Sender: TObject);
    procedure showSetInterface(Sender: TObject);
    procedure showSetInterface2(Sender: TObject);
    procedure showAddTask(Sender: TObject);
    procedure StartParams();
    procedure MinimizeApp(Sender: TObject);
    procedure MaximizeApp(Sender: TObject);
    procedure CloseApp(Sender: TObject);
    procedure TrIconOnClick(Sender: TObject);
    procedure AddItem(owner: TMenuItem; caption: string; menuProc: Integer = 0;
      VS: Boolean = True);
    procedure LoadSettings;
    procedure RefreshData(Sender: TObject);
    procedure BreakTask(Sender: TObject);
    procedure CloseTask(Sender: TObject);
    procedure CloseLastTask(Sender: TObject);
    procedure DeleteTask(Sender: TObject);
    procedure ExportFactTsk(Sender: TObject);
    procedure InsertFaktTask(TaskID: Integer);
    procedure AddFaktTask(Sender: TObject);
    procedure AddBreakTask(Sender: TObject);
    procedure DBGridOnEnter(Sender: TObject);
    procedure DBGridTaskTop10OnDblClick(Sender: TObject);
    procedure DBGridOnKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridTop10OnEnter(Sender: TObject);
    procedure DBGridOnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridTTop10OnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FactTaskGridOnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FactTaskGridOnDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FactTaskGridOnEnter(Sender: TObject);
    procedure FactTaskGridOnExit(Sender: TObject);
    procedure GetStartParamFromDB;
    procedure NewTop10;
    procedure CtrlTask(NumTask: Integer);
    procedure FilterQuery(MSQFF: TDataSet; Str: String);
    procedure OpenReport(Sender: TObject);

    function masckDateTime(CurrentDate: TDateTime): string;
    function GetStateLastTask(var sText : String) : Integer;
    function CheckIntegerValue(sText: String): Boolean;
    function FoundLastTask(var Ratio,OldFactID: Integer):Integer;
  end;

  TBOB = function(ConnectionString: PChar): Integer; stdcall;

var
  fMain: TfMain;

implementation

USES
  uRefTask, uRepHron, uTaskTop10, uOtchSPP, uOtchFIO, uReference, uAddTask, uSettings,
  uMovingwnd;
{$R *.dfm}
{ TForm1 }

procedure TfMain.AddBreakTask(Sender: TObject);
var
  MSQQ: TMSQuery;
  OldTaskID, OldFactID, Ratio: Integer;
  InText: String;
begin
    OldTaskID := FoundLastTask(Ratio, OldFactID);
    InText := '1';
    MSQQ := TMSQuery.Create(Nil);
    if OldTaskID > 0 then begin
      with MSQQ do
      begin
        Connection := msCon;
        Close;
        SQL.Clear;
        SQL.Add(' Select getRatio, TaskName from TaskList where ID = :ID ');
        ParamByName('ID').AsInteger := OldTaskID;
        Open;
        First;
      end;
      if MSQQ.FieldByName('getRatio').AsBoolean then begin
        repeat
          InText := InputBox('���� ���������', '��� ������: '+MSQQ.FieldByName('TaskName').AsString+#10#13+'��������� ����/�������� ���������', IntToStr(Ratio));
        until CheckIntegerValue(InText) = True;
        if length(InText)>0 then begin
          with MSQQ do begin
            Close;
            SQL.Clear;
            SQL.Add(' Update FactTask SET Ratio = :Ratio WHERE ID = :ID ');
            ParamByName('Ratio').AsInteger := StrToInt(InText);
            ParamByName('ID').AsInteger := OldFactID;
            Execute;
          end;
        end;
      end;
    end;

  with MSQQ do
  begin
    Connection := msCon;
    Close;
    SQL.Clear;
    SQL.Add(' EXEC dbo.procInsertNewFactTask :inPlan,:dat,:TaskId,:UserID, Null,:DayTask,Null,Null,:Completed,:Parent');
    ParamByName('inPlan').AsBoolean := False;
    ParamByName('dat').AsDateTime := CurrentDay;
    ParamByName('TaskID').AsInteger := msFB.FieldByName('TaskID').AsInteger;
    ParamByName('UserID').AsInteger := CurrentUser;
    ParamByName('DayTask').AsDateTime := CurrentDay;
    ParamByName('Completed').AsBoolean := False;
    ParamByName('Parent').AsInteger := msFB.FieldByName('Parent').AsInteger;
    Execute;
    Free;
  end;
  RefreshData(Nil);
end;

procedure TfMain.AddFaktTask(Sender: TObject);
begin
  InsertFaktTask(FocusedQuery.FieldByName(FocusedNameField).AsInteger);
end;

procedure TfMain.AddItem(owner: TMenuItem; caption: string;
  menuProc: Integer = 0; VS: Boolean = True);
var
  item: TMenuItem;
begin
  item := TMenuItem.Create(owner);
  item.caption := caption;
  item.Visible := VS;
  case menuProc of
    0:
      item.OnClick := nil;
    1:
      item.OnClick := CloseApp;
    2:
      item.OnClick := RefreshData;
    3:
      item.OnClick := ConnectToDB;
    12:
      item.OnClick := showRep3;
    14:
      item.OnClick := showRep5;
    15:
      item.OnClick := showRep6;
    16:
      item.OnClick := OpenReport;
    21:
      item.OnClick := showRef1;
    22:
      item.OnClick := showRef2;
    23:
      item.OnClick := showRef3;
    24:
      item.OnClick := showRef4;
    25:
      item.OnClick := showRef5;
    31:
      item.OnClick := showTop10;
    32:
      item.OnClick := showSetInterface;
    33:
      item.OnClick := showSetInterface2;
    101:
      item.OnClick := BreakTask;
    102:
      item.OnClick := CloseTask;
    103:
      item.OnClick := DeleteTask;
    104:
      item.OnClick := ExportFactTsk;
  end;

  owner.Add(item);
end;

procedure TfMain.BreakTask(Sender: TObject);
var
  MSQQ: TMSQuery;
begin
  // ��������� ������
  if msFT.RecordCount > 0 then
    case MessageDlg('�������� ������: ' + msFT.FieldByName('TaskName').AsString
      + '?', mtConfirmation, mbOKCancel, 0) of
      mrOk:
        Begin
          MSQQ := TMSQuery.Create(Self);
          with MSQQ do
          begin
            Connection := msCon;
            SQL.Add('exec dbo.procBreakTask :TaskID');
            ParamByName('TaskID').AsInteger := msFT.FieldByName('ID').AsInteger;
            Execute;
            Free;
          end;
        End;
    end;
  RefreshData(Self);
end;

function TfMain.CheckIntegerValue(sText: String): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(sText) do begin
    if not (sText[I] in ['0'..'9']) then begin
      Result:=False;
      Break;
    end;
  end;

end;

procedure TfMain.CloseApp(Sender: TObject);
var
  RegParam : TRegIniFile;
begin
  // ��������� �����
  case MessageDlg('������� ���������?', mtConfirmation, mbOKCancel, 0) of
    mrOk: begin
      CloseLastTask(nil);
      RegParam := TRegIniFile.Create('Software\MyProg');
      RegParam.OpenKey('Sheduler2',true);
      FactTaskGrid.SaveGridLayout(RegParam);
      RegParam.Free;
//      CloseLastTask(nil);
      Application.Terminate;
    end;
  end;

end;

procedure TfMain.CloseLastTask(Sender: TObject);
var
  msQ1: TMSQuery;
  MSQQ: TMSQuery;
  TaskID: Integer;
  TaskName: String;
  flg: Boolean;
begin
  flg:=SetEndTaskWithClose;
  if msFT.RecordCount > 0 then begin
    TaskID := 0;
    msQ1 := TMSQuery.Create(nil);

    with msQ1 do begin
      Connection := msCon;
      SQl.Clear;
      SQL.Add(' Select ID, FT.TaskName, GETDATE() as [TIME] from viewFact FT where FT.UserID = :UserID and FT.DayTask = :DayTask and FT.[State] = 1  and FT.EndTime is null ');
      ParamByName('UserID').AsInteger := CurrentUser;
      ParamByName('DayTask').AsDateTime := CurrentDay;
      Open;
      First;
    end;

    if not SetEndTaskWithClose then
      if (Frac(msQ1.FieldByName('TIME').AsDateTime) > StrToTime('17:00:00')) and (msQ1.RecordCount > 0) then
        case  MessageDlg('���� �������� � ����������. ��������� ������: ' + TaskName + '?', mtConfirmation, mbOKCancel, 0) of
          mrOk:
            flg := True;
          mrCancel:
            flg := False;
        end; //end Case

    if flg then
      Begin
        TaskID := msQ1.FieldByName('ID').AsInteger;
        TaskName := msQ1.FieldByName('TaskName').AsString;
        MSQQ := TMSQuery.Create(Self);
        with MSQQ do
        begin
          Connection := msCon;
          SQL.Add('exec dbo.procCloseTask :TaskID');
          ParamByName('TaskID').AsInteger := TaskID;
          Execute;
          Free;
        end;
      End;



    msQ1.Free;
  end;
end;

procedure TfMain.CloseTask(Sender: TObject);
var
  MSQQ: TMSQuery;
begin
  // ��������� ������
  if msFT.RecordCount > 0 then
    case MessageDlg('��������� ������: ' + msFT.FieldByName('TaskName').AsString
      + '?', mtConfirmation, mbOKCancel, 0) of
      mrOk:
        Begin
          MSQQ := TMSQuery.Create(Self);
          with MSQQ do
          begin
            Connection := msCon;
            SQL.Add('exec dbo.procCloseTask :TaskID');
            ParamByName('TaskID').AsInteger := msFT.FieldByName('ID').AsInteger;
            Execute;
            Free;
          end;
        End;
    end;
  RefreshData(Self);
end;

procedure TfMain.ConnectToDB(Sender: TObject);
begin
  try
    begin
      msCon.Connect;
      RefreshData(Nil);
      ConnectButton.Enabled := False;
      Timer1.Interval := 1000 * 60;
      Timer1.Enabled := True;
    end
  except
    on E: Exception do
    begin
      if not E.ClassNameIs('EAbort') then
        ShowMessage('������ ����������� � �������: ' + msCon.Server + '[' +
          E.ClassName + ': ' + E.Message + ']');
    end;
  end;
end;

procedure TfMain.CreateComponentsForConnect;
begin
  // ������� ���������� ��� ����������� � ��
  // MSConnectionDialog
  msConDlg := TMSConnectDialog.Create(Self);
  with msConDlg do
  begin
    LabelSet := lsRussian;
    StoreLogInfo := True;
  end;

  // MSConnection
  msCon := TMSConnection.Create(Self);
  with msCon do
  begin
    LoginPrompt := True;
    ConnectDialog := msConDlg;
    ConnectString := '';
    Server := cnServer;
    Database := cnDataBase;
  end;

  // MSQuery
  // ������ �����
  msQ := TMSQuery.Create(Self);
  with msQ do
  begin
    CommandTimeout := 0;
    Close;
    Connection := msCon;
    SQL.Clear;
//    SQL.Add('Select * from TaskList where OldTask = 0 and DepartmentID = (Select DepartmentID from Users where UserID = (User_ID())) order by TaskName');
    SQL.Add(' Select * from TaskList ');
    SQL.Add(' where OldTask = 0 ');
    SQL.Add('	and ( DepartmentID = (Select DepartmentID from Users where UserID = (User_ID())) ');
    SQL.Add('    or DepartmentID = (select D.DepartmetOwner from Departments D where D.ID = (Select DepartmentID from Users where UserID = User_ID()) ) ) ');
    SQL.Add(' order by TaskName ');
  end;

  msQFil := TMSQuery.Create(Self);
  msQFil.Connection := msCon;

  msQ10 := TMSQuery.Create(Self);
  with msQ10 do
  begin
    CommandTimeout := 0;
    Close;
    Connection := msCon;
    SQL.Clear;
    SQL.Add('Select * from viewTaskListTop10 where UserID = User_ID() order by NumPos');
  end;
  // ������ FacktTask
  msFT := TMSQuery.Create(Self);
  with msFT do
  begin
    CommandTimeout := 0;
    Close;
    Connection := msCon;
    SQL.Clear;
    SQL.Add('Select * from viewFact where UserID = :UserID and DayTask = :DayTask ORDER BY StartTime');
    ParamByName('UserID').AsInteger := CurrentUser;
    ParamByName('DayTask').AsDateTime := CurrentDay;
  end;
  msFB := TMSQuery.Create(Self);
  with msFB do
  begin
    CommandTimeout := 0;
    Close;
    Connection := msCon;
    SQL.Clear;
    SQL.Add('Select * from viewBreakTask F where UserID = :UserID order by StartTime');
    ParamByName('UserID').AsInteger := CurrentUser;
  end;
  // MSDataSource
  msDS := TMSDataSource.Create(Self);
  msDS.DataSet := msQ;

  msDSFactTask := TMSDataSource.Create(Self);
  msDSFactTask.DataSet := msFT;

  msDSFactBreak := TMSDataSource.Create(Self);
  msDSFactBreak.DataSet := msFB;

  msDS10 := TMSDataSource.Create(Self);
  msDS10.DataSet := msQ10;
  // msQ.Open;
  RefreshData(nil);
end;

procedure TfMain.CreateDataGrid;
var
  RegParam: TRegIniFile;
begin
  // ������ �����
  DBGrid := TDBGridEh.Create(MenuBar.Panels[0]);
  with DBGrid do
  begin
    Parent := MenuBar.Panels[0];
    Align := alClient;
    DataSource := msDS;
    Enabled := False;
    Visible := False;
    Options := [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines,
      dgTabs, dgConfirmDelete, dgCancelOnExit];
    OptionsEh := [dghFixed3D, dghHighlightFocus, dghClearSelection,
      dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines,
      dghIncSearch, dghPreferIncSearch];
    ReadOnly := True;
    IndicatorOptions := [];
    AutoFitColWidths := True;
    if GetSystemMetrics(SM_CXSCREEN) > 1200 then
    begin
      Font.Size := 12;
      TitleFont.Size := 12;
    end
    else
    begin
      Font.Size := 8;
      TitleFont.Size := 8;
    end;
    Columns.Add;
    Columns[0].FieldName := 'TaskName';
    Columns[0].Title.caption := '';
    Columns[0].TextEditing := False;
    Columns[0].Width := 120;
    Columns[0].Visible := True;
    Columns[0].ReadOnly := True;
    Columns[0].ToolTips := True;
    Visible := True;
    Enabled := True;
    OnEnter := DBGridOnEnter;
    OnDblClick := AddFaktTask;
    OnKeyDown := DBGridOnKeyDown;
    OnKeyPress := DBGridOnKeyPress;
  end;
  // ������ ����� Top10
  DBGridTop10 := TDBGridEh.Create(MenuBar.Panels[0]);
  with DBGridTop10 do
  begin
    Parent := MenuBar.Panels[0];
    Align := alBottom;
    DataSource := msDS10;
    Enabled := False;
    Visible := False;
    Options := [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines,
      dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitles];
    OptionsEh := [dghFixed3D, dghHighlightFocus, dghClearSelection,
      dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines,
      dghIncSearch, dghPreferIncSearch];
    ReadOnly := True;
    IndicatorOptions := [];
    AutoFitColWidths := True;

    if GetSystemMetrics(SM_CXSCREEN) > 1200 then
    begin
      Font.Size := 12;
      TitleFont.Size := 12;
      RowHeight := 22;
      Height := RowHeight * 12;
    end
    else
    begin
      Font.Size := 8;
      TitleFont.Size := 8;
      Height := 202;
    end;
    Columns.Add;
    Columns[0].FieldName := 'NumPos';
    Columns[0].Title.caption := '�';
    Columns[0].TextEditing := False;
    Columns[0].Width := 10;
    Columns[0].Visible := True;
    Columns[0].ReadOnly := True;
    Columns.Add;
    Columns[1].FieldName := 'TaskName';
    Columns[1].Title.caption := '��� 10';
    Columns[1].TextEditing := False;
    Columns[1].Width := 110;
    Columns[1].Visible := True;
    Columns[1].ReadOnly := True;
    Columns[1].ToolTips := True;
    Visible := True;
    Enabled := True;
    OnEnter := DBGridTop10OnEnter;
    OnDblClick := DBGridTaskTop10OnDblClick;
    OnKeyDown := DBGridTTop10OnKeyDown;
  end;
  // ���� �����
  FactTaskGrid := TDBGridEh.Create(fMain);
  with FactTaskGrid do
  begin
    Parent := fMain;
    Align := alClient;
    DataSource := msDSFactTask;
    Enabled := False;
    Visible := False;
    Options := [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines,
      dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitles];
    OptionsEh := [dghFixed3D, dghHighlightFocus, dghClearSelection,
      dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines];
    ReadOnly := False;
    IndicatorOptions := [];
//    AutoFitColWidths := True;
    TitleLines := 2;
    Height := 202;
//    Scro
    if GetSystemMetrics(SM_CXSCREEN) > 1200 then
    begin
      Font.Size := 12;
      TitleFont.Size := 12;
    end
    else
    begin
      Font.Size := 8;
      TitleFont.Size := 8;
    end;
    with Columns.Add do
    begin
      FieldName := 'TaskName';
      Title.caption := '������';
      TextEditing := False;
      Width := 250;
      Visible := True;
      ReadOnly := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    with Columns.Add do
    begin
      FieldName := 'StartTime';
      Title.caption := '����� ���.';
      Width := 50;
      Visible := True;
      ReadOnly := False;
      DisplayFormat := 'hh:mm';
      EditMask := '!90:00:00;1;_';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
      ButtonStyle := cbsNone;
    end;
    with Columns.Add do
    begin
      FieldName := 'EndTime';
      Title.caption := '����� ���.';
      Width := 50;
      Visible := True;
      ReadOnly := False;
      DisplayFormat := 'hh:mm';
      EditMask := '!90:00:00;1;_';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
      ButtonStyle := cbsNone;
    end;
    with Columns.Add do
    begin
      FieldName := 'MIN';
      Title.caption := '���';
      TextEditing := False;
      ReadOnly := True;
      Width := 40;
      Visible := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    with FactTaskGrid.Columns.Add do
    begin
      FieldName := 'Ratio';
      Title.caption := '���-��';
      TextEditing := True;
      ReadOnly := False;
      Width := 60;
      Visible := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    with FactTaskGrid.Columns.Add do
    begin
      FieldName := 'NormR';
      Title.caption := '��������';
      ReadOnly := True;
      TextEditing := False;
      Width := 80;
      Visible := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    with FactTaskGrid.Columns.Add do
    begin
      FieldName := 'NormDelta';
      Title.caption := '����������';
      ReadOnly := True;
      TextEditing := False;
      Width := 90;
      Visible := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    with FactTaskGrid.Columns.Add do
    begin
      FieldName := 'StateStr';
      Title.caption := '���������';
      ReadOnly := True;
      TextEditing := False;
      Width := 80;
      Visible := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    with FactTaskGrid.Columns.Add do
    begin
      FieldName := 'Note';
      Title.caption := '����������';
      TextEditing := True;
      Width := 600;
      Visible := True;
      ReadOnly := False;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := True;
      Title.Alignment := taCenter;
    end;

    Visible := True;
    Enabled := True;
    PopupMenu := pmFT;
    OnDrawColumnCell := FactTaskGridOnDrawColumnCell;
    OnKeyDown := FactTaskGridOnKeyDown;
    OnEnter := FactTaskGridOnEnter;
    OnExit := FactTaskGridOnExit;
    RegParam := TRegIniFile.Create('Software\MyProg');
    RegParam.OpenKey('Sheduler2',true);
    FactTaskGrid.RestoreGridLayout(RegParam,[grpColIndexEh, grpColWidthsEh, grpSortMarkerEh, grpColVisibleEh, grpRowHeightEh, grpDropDownRowsEh, grpDropDownWidthEh, grpRowPanelColPlacementEh]);
    RegParam.Free
  end;

  // ���������� ������
  BreakTaskGrid := TDBGridEh.Create(fMain);
  with BreakTaskGrid do
  begin
    Parent := fMain;
    Align := alRight;
    DataSource := msDSFactBreak;
    Enabled := False;
    Visible := False;
    Options := [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines,
      dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitles];
    OptionsEh := [dghFixed3D, dghHighlightFocus, dghClearSelection,
      dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines];
    ReadOnly := False;
    IndicatorOptions := [];
    AutoFitColWidths := True;
    TitleLines := 1;
    Width := 300;
    if GetSystemMetrics(SM_CXSCREEN) > 1200 then
    begin
      Font.Size := 12;
      TitleFont.Size := 12;
    end
    else
    begin
      Font.Size := 8;
      TitleFont.Size := 8;
    end;
    with Columns.Add do
    begin
      FieldName := 'TaskName';
      Title.caption := '���������� ������';
      ReadOnly := True;
      TextEditing := False;
      Width := 70;
      Visible := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := True;
      Title.Alignment := taCenter;
    end;
    with Columns.Add do
    begin
      FieldName := 'MIN';
      Title.caption := '���';
      TextEditing := False;
      Width := 35;
      Visible := True;
      ReadOnly := True;
      EditMask := '';
      DisplayFormat := '';
      AutoFitColWidth := False;
      Title.Alignment := taCenter;
    end;
    OnEnter := DBGridTop10OnEnter;
    OnDblClick := AddBreakTask;
  end;
  SplitterR := TAdvSplitter.Create(fMain);
  with SplitterR do
  begin
    Parent := fMain;
    Align := alRight;
    Width := 5;
    Visible := False;
  end;
end;

function TfMain.masckDateTime(CurrentDate: TDateTime): string;
var
  Itog: String;
  I: Integer;
begin
  I := 1;
  Itog := DateToStr(CurrentDate);
  while I <= Length(Itog) do
  begin
    Insert('\', Itog, I);
    I := I + 2;
  end;

  Result := Itog + ' ' + '90:00;1;_';
end;

procedure TfMain.CreateObjects;
const
  MOD_CONTROL = 2;
  MOD_SHIFT = 4;
  VK_S = $53;
  VK_X = $58;
  VK_D = $44;
  VK_1 = $31;
  VK_2 = $32;
  VK_3 = $33;
  VK_4 = $34;
  VK_5 = $35;
  VK_6 = $36;
  VK_7 = $37;
  VK_8 = $38;
  VK_9 = $39;
  VK_0 = $30;

  VK_ESC = $1B;
  MI_CLOSE = 1;
  MI_REF = 2;
  MI_CON = 3;
  MI_REP1 = 10;
  MI_REP2 = 11;
  MI_REP3 = 12;
  MI_REP4 = 13;
  MI_REP5 = 14;
  MI_REP6 = 15;
  MI_REP7 = 16;

  MI_REF1 = 21;
  MI_REF2 = 22;
  MI_REF3 = 23;
  MI_REF4 = 24;
  MI_REF5 = 25;
  MI_SET1 = 31;
  MI_SET2 = 32;
  MI_SET3 = 33;
  MI_BF = 101;
  MI_CF = 102;
  MI_DF = 103;
  MI_EF = 104;

begin
  // --------------------------------------------------------------------
  // ������� ���������� ������� �������
  HK_C1 := GlobalAddAtom('HotkeyC1');
  RegisterHotKey(Handle, HK_C1, MOD_CONTROL, VK_1);
  HK_C2 := GlobalAddAtom('HotkeyC2');
  RegisterHotKey(Handle, HK_C2, MOD_CONTROL, VK_2);
  HK_C3 := GlobalAddAtom('HotkeyC3');
  RegisterHotKey(Handle, HK_C3, MOD_CONTROL, VK_3);
  HK_C4 := GlobalAddAtom('HotkeyC4');
  RegisterHotKey(Handle, HK_C4, MOD_CONTROL, VK_4);
  HK_C5 := GlobalAddAtom('HotkeyC5');
  RegisterHotKey(Handle, HK_C5, MOD_CONTROL, VK_5);
  HK_C6 := GlobalAddAtom('HotkeyC6');
  RegisterHotKey(Handle, HK_C6, MOD_CONTROL, VK_6);
  HK_C7 := GlobalAddAtom('HotkeyC7');
  RegisterHotKey(Handle, HK_C7, MOD_CONTROL, VK_7);
  HK_C8 := GlobalAddAtom('HotkeyC8');
  RegisterHotKey(Handle, HK_C8, MOD_CONTROL, VK_8);
  HK_C9 := GlobalAddAtom('HotkeyC9');
  RegisterHotKey(Handle, HK_C9, MOD_CONTROL, VK_9);
  HK_C0 := GlobalAddAtom('HotkeyC0');
  RegisterHotKey(Handle, HK_C0, MOD_CONTROL, VK_0);
  // end �������
  // --------------------------------------------------------------------

  MyActionList := TActionList.Create(Self);
  with TAction.Create(Self) do
    begin
      ShortCut := 27;     {esc}
      OnExecute := RefreshData;
      ActionList := MyActionList;
    end;
  with TAction.Create(Self) do
    begin
      ShortCut := 16452;  {Ctrl+D}
      OnExecute := MinimizeApp;
      ActionList := MyActionList;
    end;
  with TAction.Create(Self) do
    begin
      ShortCut := 16472;  {Ctrl+X}
      OnExecute := CloseApp;
      ActionList := MyActionList;
    end;



  // MainMenu
  mMenu := TMainMenu.Create(fMain);
  AddItem(mMenu.Items, '&����');
  AddItem(mMenu.Items, '&�����������');
  AddItem(mMenu.Items, '&������');

  AddItem(mMenu.Items[0], '&����������', MI_CON);
  AddItem(mMenu.Items[0], '&��������', MI_REF);
  AddItem(mMenu.Items[0], '&���������');
  AddItem(mMenu.Items[0], '��������',MI_SET3);
  AddItem(mMenu.Items[0], '&�����', MI_CLOSE);
  AddItem(mMenu.Items[0].Items[2], '������ ����� TOP10', MI_SET1);
  AddItem(mMenu.Items[0].Items[2], '���������', MI_SET2);
  // additem(mMenu.Items[0].Items[2],'Sub Sub item 2');
  AddItem(mMenu.Items[1], '������ �����', MI_REF1);
  AddItem(mMenu.Items[1], '������������',MI_REF2);
  AddItem(mMenu.Items[1], '���������',MI_REF3);
  AddItem(mMenu.Items[1], '��������',MI_REF4);
  AddItem(mMenu.Items[1], '�������������',MI_REF5);
  AddItem(mMenu.Items[2], '��� ������', MI_REP7);
  AddItem(mMenu.Items[2], '������ �������� ������� �� ���', MI_REP5);
  AddItem(mMenu.Items[2], '������ �������� ������� �� ���', MI_REP6);
  AddItem(mMenu.Items[2], '������', MI_REP3);

  Menu := mMenu;
  // end MainMenu

  pmFT := TPopupMenu.Create(Self);
  AddItem(pmFT.Items, '&��������', MI_BF);
  AddItem(pmFT.Items, '&���������', MI_CF);
  AddItem(pmFT.Items, '&�������', MI_DF);
  AddItem(pmFT.Items, '&�������', MI_EF);

  // AdvPanel's
  ButPanelTop := TAdvPanel.Create(fMain);
  with ButPanelTop do
  begin
    Parent := fMain;
    Align := alTop;
    Width := 40;
    Height := 40;
  end;

  ButPanel := TAdvPanel.Create(fMain);
  with ButPanel do
  begin
    Parent := fMain;
    Align := alLeft;
    Width := 40;
  end;
  // endAdvPanel's

  SplitterL := TAdvSplitter.Create(fMain);
  with SplitterL do
  begin
    Parent := fMain;
    Align := alLeft;
    Width := 5;
  end;

  // BitBtn's
  AddButton := TW7SpeedButton.Create(ButPanel);
  with AddButton do
  begin
    Parent := ButPanel;
    Flat := True;
    IconSize := is32px;
    Hint := '�������� � ����';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 10;
      Left := 1;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alTop;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 0;
    OnClick := AddFaktTask;
  end;

  BreakButton := TW7SpeedButton.Create(ButPanel);
  with BreakButton do
  begin
    Parent := ButPanel;
    Flat := True;
    IconSize := is32px;
    Hint := '�������� ����';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 10;
      Left := 1;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alTop;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 4;
    OnClick := BreakTask;
  end;

  DelButton := TW7SpeedButton.Create(ButPanel);
  with DelButton do
  begin
    Parent := ButPanel;
    Flat := True;
    IconSize := is32px;
    Hint := '������� ����';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 10;
      Left := 1;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alTop;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 1;
    OnClick := DeleteTask;
  end;

  DatePicker := TDateTimePicker.Create(ButPanelTop);
  with DatePicker do
  begin
    Parent := ButPanelTop;
    Hint := '������� ����';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 8;
      Top := 7;
      Left := 10;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alLeft;
    Width := 100;
    Height := 21;
    DatePicker.Date := Date;
    DatePicker.Time := 0;
    OnChange := RefreshData;
  end;

  AddTaskButton := TW7SpeedButton.Create(ButPanelTop);
  with AddTaskButton do
  begin
    Parent := ButPanelTop;
    Flat := True;
    IconSize := is32px;
    Hint := '�������� ������';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 1;
      Left := 10;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alLeft;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 6;
    OnClick := showAddTask;
  end;

  TOP10Button := TW7SpeedButton.Create(ButPanelTop);
  with TOP10Button do
  begin
    Parent := ButPanelTop;
    Flat := True;
    IconSize := is32px;
    Hint := '������������� TOP10';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 1;
      Left := 10;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alLeft;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 5;
    OnClick := showTop10;
  end;

  RefreshButton := TW7SpeedButton.Create(ButPanelTop);
  with RefreshButton do
  begin
    Parent := ButPanelTop;
    Flat := True;
    IconSize := is32px;
    Hint := '��������';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 1;
      Left := 10;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alLeft;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 3;
    OnClick := RefreshData;
  end;
  ConnectButton := TW7SpeedButton.Create(ButPanelTop);
  with ConnectButton do
  begin
    Parent := ButPanelTop;
    Flat := True;
    IconSize := is32px;
    Hint := '����������';
    ShowHint := True;
    with Margins do
    begin
      Bottom := 1;
      Top := 1;
      Left := 10;
      Right := 1;
    end;
    AlignWithMargins := True;
    Align := alLeft;
    Width := 38;
    Height := 38;
    PressButtonEffect := False;
    Images := ImageList1;
    ImageIndex := 2;
    OnClick := ConnectToDB;
  end;

  // endBitBtn's

  // AdvNavBar
  MenuBar := TAdvNavBar.Create(fMain);
  with MenuBar do
  begin
    Parent := fMain;
    Align := alLeft;
    Width := 300;
    PanelOrder := poTopToBottom;
    Style := esOffice2010Silver;
    PopupIndicator := False;
    with AddPanel do
    begin
      caption := '������ �����';
    end;
    ActivePanel := MenuBar.Panels[0];
    ShowSplitter := True;
    SplitterPosition := 1;
  end;
  // end AdvNavBar

  // ApplicationEvents
  AppEvents := TApplicationEvents.Create(Self);
  with AppEvents do
  begin
    // ������ ��������
    OnMinimize := MinimizeApp;
  end;
  // end ApplicationEvents
  // TTrayIcon
  TrIcon := TTrayIcon.Create(Self);
  with TrIcon do
  begin
    // ������ ��������
    Animate := False;
    // Icon.LoadFromFile('Icon.ico');
    Hint := '������������ �������� �������';
    BalloonTitle := '���';
    BalloonHint := '������������ �������� �������';
    BalloonTimeout := 0;
    OnClick := TrIconOnClick;
  end;
  // end TTrayIcon
end;

procedure TfMain.CtrlTask(NumTask: Integer);
var
  MSQue, MSQQue: TMSQuery;
begin
  MSQue := TMSQuery.Create(nil);
  MSQue.Connection := msCon;

  MSQue.Close;
  MSQue.SQL.Clear;
  MSQue.SQL.Add
    ('SELECT TaskId From TaskListTop10 Where UserId = :UserId and NumPos = :NumPos');
  MSQue.ParamByName('UserId').AsInteger := CurrentUser;
  MSQue.ParamByName('NumPos').AsInteger := NumTask;
  MSQue.Open;

  if MSQue.RecordCount > 0 then
  begin

    MSQQue := TMSQuery.Create(Nil);
    with MSQQue do
    begin
      Connection := msCon;
      Close;
      SQL.Clear;
      SQL.Add(' EXEC dbo.procInsertNewFactTask :inPlan,:dat,:TaskId,:UserID,Null,:DayTask,Null,Null,:Completed');
      ParamByName('inPlan').AsBoolean := False;
      ParamByName('dat').AsDateTime := CurrentDay;
      ParamByName('TaskID').AsInteger := MSQue.FieldByName('TaskID').AsInteger;
      ParamByName('UserID').AsInteger := CurrentUser;
      ParamByName('DayTask').AsDateTime := CurrentDay;
      ParamByName('Completed').AsBoolean := False;
      Execute;
      Free;
    end;
  end;
  MSQue.Free;
  RefreshData(Nil);
end;

procedure TfMain.DBGridTaskTop10OnDblClick(Sender: TObject);
begin
  FocusedQuery := TMSQuery(TDBGridEh(Sender).DataSource.DataSet);
  FocusedNameField := 'TaskID';
  AddFaktTask(Nil);
end;

procedure TfMain.DBGridOnEnter(Sender: TObject);
begin
  FocusedQuery := TMSQuery(TDBGridEh(Sender).DataSource.DataSet);
  FocusedNameField := 'ID';
end;

procedure TfMain.DBGridOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    FocusedQuery := TMSQuery(TDBGridEh(Sender).DataSource.DataSet);
    FocusedNameField := 'ID';
    AddFaktTask(Nil);
  end;
end;

procedure TfMain.DBGridTop10OnEnter(Sender: TObject);
begin
  FocusedQuery := TMSQuery(TDBGridEh(Sender).DataSource.DataSet);
  FocusedNameField := 'TaskID';
end;

procedure TfMain.DBGridTTop10OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    FocusedQuery := TMSQuery(TDBGridEh(Sender).DataSource.DataSet);
    FocusedNameField := 'TaskID';
    AddFaktTask(Nil);
  end;
end;

procedure TfMain.DeleteTask(Sender: TObject);
var
  MSQQ: TMSQuery;
begin
  // ��������� ������
  if msFT.RecordCount > 0 then
    case MessageDlg('������� ������: ' + msFT.FieldByName('TaskName').AsString +
      '?', mtConfirmation, mbOKCancel, 0) of
      mrOk:
        Begin
          MSQQ := TMSQuery.Create(Self);
          with MSQQ do
          begin
            Connection := msCon;
            SQL.Add('exec dbo.procDelFactTask :FactID');
            ParamByName('FactID').AsInteger := msFT.FieldByName('ID').AsInteger;
            Execute;
            Free;
          end;
        End;
    end;
  RefreshData(Self);
end;

procedure TfMain.ExportFactTsk(Sender: TObject);
var
  SD: TSaveDialog;
  Path: String;
begin
  SD := TSaveDialog.Create(Self);
  with SD do
  begin
    Filter := '����� Excel (xls)|*.xls';
  end;
  if SD.Execute then
  begin
    Path := SD.FileName + '.xls';
    SaveDBGridEhToExportFile(TDBGridEhExportAsXLS, FactTaskGrid, Path, True);
  end;
  FreeAndNil(SD);
end;

procedure TfMain.FactTaskGridOnDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin

  if ((Sender as TDBGridEh).DataSource.DataSet.FieldByName('Parent').AsInteger >
    0) and ((Sender as TDBGridEh).DataSource.DataSet.FieldByName('State')
    .AsInteger = 2) then
    (Sender as TDBGridEh).Canvas.Brush.Color := clAqua;

  IF gdSelected IN State Then
  Begin
    TDBGridEh(Sender).Canvas.Brush.Color := clHighLight;
    TDBGridEh(Sender).Canvas.Font.Color := clHighLightText;
  End;
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfMain.FactTaskGridOnEnter(Sender: TObject);
begin
  TDBGridEh(FactTaskGrid).FieldColumns['StartTime'].EditMask :=
    masckDateTime(CurrentDay);
  TDBGridEh(FactTaskGrid).FieldColumns['EndTime'].EditMask :=
    masckDateTime(CurrentDay);
end;

procedure TfMain.FactTaskGridOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Sender as TDBGridEh).DataSource.DataSet.State = dsEdit) and
    (Key = VK_RETURN) then
  begin
    (Sender as TDBGridEh).DataSource.DataSet.Post;
  end;
end;

procedure TfMain.FactTaskGridOnExit(Sender: TObject);
begin
  if TDBGridEh(FactTaskGrid).DataSource.DataSet.Modified then
    TDBGridEh(FactTaskGrid).DataSource.DataSet.Post;
end;

procedure TfMain.FilterQuery(MSQFF: TDataSet; Str: String);
var
  MSQQ: TMSQuery;
begin
  MSQQ := TMSQuery(MSQFF);
  With MSQQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT ID,TaskName ');
    SQL.Add(' FROM dbo.TaskList TL ');
    SQL.Add(' WHERE TL.DepartmentID = (Select DepartmentID from Users where UserID = (User_ID())) and OldTask = 0');
    SQL.Add(' AND TL.TaskName Like ''%' + Str + '%'' ');
    SQL.Add(' ORDER BY TL.TaskName ');
    Open;
  end;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  DBGrid.SetFocus;
  RefreshData(Self);
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  CloseApp(Self);
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  StartParams; { 1 }
  CreateObjects; { 2 }
  LoadSettings; { 3 }
  CreateComponentsForConnect; { 4 }
  CreateDataGrid; { 5 }
  ConnectToDB(Nil); { 6 }
  RefreshData(Nil); { 7 }
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  // ������
  // ����������� ��������� ����������
  if Assigned(AppEvents) then
    FreeAndNil(AppEvents);
  if Assigned(TrIcon) then
    FreeAndNil(TrIcon);
  if Assigned(mMenu) then
    FreeAndNil(mMenu);
  if Assigned(msCon) then
    FreeAndNil(msCon);
  if Assigned(msConDlg) then
    FreeAndNil(msConDlg);
  if Assigned(msQ) then
    FreeAndNil(msQ);
  if Assigned(msQ10) then
    FreeAndNil(msQ10);
  if Assigned(msQFil) then
    FreeAndNil(msQFil);
  if Assigned(DBGrid) then
    FreeAndNil(DBGrid);
  if Assigned(DBGridTop10) then
    FreeAndNil(DBGrid);
  if Assigned(MenuBar) then
    FreeAndNil(MenuBar);

  // ������� �������
  UnRegisterHotKey(Handle, HK_C1);
  GlobalDeleteAtom(HK_C1);
  UnRegisterHotKey(Handle, HK_C2);
  GlobalDeleteAtom(HK_C2);
  UnRegisterHotKey(Handle, HK_C3);
  GlobalDeleteAtom(HK_C3);
  UnRegisterHotKey(Handle, HK_C4);
  GlobalDeleteAtom(HK_C4);
  UnRegisterHotKey(Handle, HK_C5);
  GlobalDeleteAtom(HK_C5);
  UnRegisterHotKey(Handle, HK_C6);
  GlobalDeleteAtom(HK_C6);
  UnRegisterHotKey(Handle, HK_C7);
  GlobalDeleteAtom(HK_C7);
  UnRegisterHotKey(Handle, HK_C8);
  GlobalDeleteAtom(HK_C8);
  UnRegisterHotKey(Handle, HK_C9);
  GlobalDeleteAtom(HK_C9);
  UnRegisterHotKey(Handle, HK_C0);
  GlobalDeleteAtom(HK_C0);

  // end ������
end;

function TfMain.FoundLastTask(var Ratio, OldFactID: Integer): Integer;
var
  MSQQ: TMSQuery;
begin
  Result := 0;
  Ratio := 1;
  MSQQ := TMSQuery.Create(nil);

  with MSQQ do begin
    Connection := msCon;
    SQL.Clear;
    SQL.Add(' SELECT TOP 1 ID, TaskID, Ratio FROM FactTask WHERE UserId = USER_ID() and EndTime IS NULL and StartTime < GETDATE() and DayTask = dbo.funcDateNoTime(GetDate()) ');
    Open;
    First;
  end;
  if MSQQ.RecordCount > 0 then begin
    Result := MSQQ.FieldByName('TaskID').AsInteger;
    Ratio := MSQQ.FieldByName('Ratio').AsInteger;
    OldFactID := MSQQ.FieldByName('ID').AsInteger;
  end;
  MSQQ.Free;
end;

procedure TfMain.DBGridOnKeyPress(Sender: TObject; var Key: Char);
var
  Str: String;
begin
  if not(Key = Char(#$0D)) then
  begin
    TDBGridEh(Sender).DataSource.DataSet := msQFil;
    Str := DBGrid.Columns[0].Title.caption;
    if Key = Char(#08) then
      SetLength(Str, Length(Str) - 1)
    else
      Str := Str + Key;
    DBGrid.Options := [dgEditing, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitles];
    DBGrid.Columns[0].Title.caption := Str;
    FilterQuery(TDBGridEh(Sender).DataSource.DataSet, Str);
    FocusedQuery := msQFil;
  end;
end;

procedure TfMain.GetStartParamFromDB;
var
  MSQQue: TMSQuery;
begin
  IsUserController := False;
  if msCon.Connected then
  begin

    MSQQue := TMSQuery.Create(Nil);
    with MSQQue do
    begin
      Connection := msCon;
      Close;
      SQL.Clear;
      SQL.Add('Select User_ID() as UserID, dbo.FuncDateNoTime(GetDate()) as Now, UserName, controller, P.EndTaskWithClose from Users U left join Properties P on P.UserID = U.UserID where U.UserID = User_ID()');
      Open;
      First;
      CurrentUser := MSQQue.FieldByName('UserID').AsInteger;
      CurrentUserName := MSQQue.FieldByName('UserName').AsString;
      CurrentDay := MSQQue.FieldByName('Now').AsDateTime;
      IsUserController := MSQQue.FieldByName('controller').AsBoolean;
      SetEndTaskWithClose := MSQQue.FieldByName('EndTaskWithClose').AsBoolean;
      Free;
    end;
  end;
end;

function TfMain.GetStateLastTask(var sText: String): Integer;
var
  MSQQ: TMSQuery;
begin
  sText := '';
  Result := 0;
if msCon.Connected then begin

  MSQQ := TMSQuery.Create(Nil);
  with MSQQ do
  begin
    Connection := msCon;
    Close;
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from viewLastTask ');
    Open;
  end;
  if MSQQ.RecordCount > 0 then begin
    MSQQ.First;
    sText := MSQQ.FieldByName('TaskName').AsString;
    Result := MSQQ.FieldByName('Per').AsInteger;
  end;

  MSQQ.Free;
end;

end;

procedure TfMain.InsertFaktTask(TaskID: Integer);
var
  MSQQ: TMSQuery;
  InText: String;
  OldTaskID, OldFactID, Ratio: Integer;

begin
  if msQ.RecordCount > 0 then
  begin
    OldTaskID := FoundLastTask(Ratio, OldFactID);
    InText := '1';
    MSQQ := TMSQuery.Create(Nil);
    if OldTaskID > 0 then begin
      with MSQQ do
      begin
        Connection := msCon;
        Close;
        SQL.Clear;
        SQL.Add(' Select getRatio, TaskName from TaskList where ID = :ID ');
        ParamByName('ID').AsInteger := OldTaskID;
        Open;
        First;
      end;
      if MSQQ.FieldByName('getRatio').AsBoolean then begin
        repeat
          InText := InputBox('���� ���������', '��� ������: '+MSQQ.FieldByName('TaskName').AsString+#10#13+'��������� ����/�������� ���������', IntToStr(Ratio));
        until CheckIntegerValue(InText) = True;
        if length(InText)>0 then begin
          with MSQQ do begin
            Close;
            SQL.Clear;
            SQL.Add(' Update FactTask SET Ratio = :Ratio WHERE ID = :ID ');
            ParamByName('Ratio').AsInteger := StrToInt(InText);
            ParamByName('ID').AsInteger := OldFactID;
            Execute;
          end;
        end;
      end;
    end;


    with MSQQ do
    begin
      Connection := msCon;
      Close;
      SQL.Clear;
      SQL.Add(' EXEC dbo.procInsertNewFactTask :inPlan,:dat,:TaskId,:UserID,Null,:DayTask,Null,Null,:Completed, null, :Ratio ');
      ParamByName('inPlan').AsBoolean := False;
      ParamByName('dat').AsDateTime := CurrentDay;
      ParamByName('TaskID').AsInteger := TaskID;
      ParamByName('UserID').AsInteger := CurrentUser;
      ParamByName('DayTask').AsDateTime := CurrentDay;
      ParamByName('Completed').AsBoolean := False;
      ParamByName('Ratio').AsInteger := 1;
      Execute;
    end;
  end;
  MSQQ.Free;
  RefreshData(Nil);
end;

procedure TfMain.LoadSettings;
var
  IniF: TIniFile;
begin
  IniF := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\settings.ini');
  cnServer := IniF.ReadString('Connect', 'Server', 'LOCALHOST');
  cnDataBase := IniF.ReadString('Connect', 'DataBase', 'Planner');
end;

procedure TfMain.MaximizeApp(Sender: TObject);
begin
  TrIcon.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfMain.MinimizeApp(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrIcon.Visible := True;
  TrIcon.ShowBalloonHint;
end;

procedure TfMain.NewTop10;
var
  MSQue: TMSQuery;
begin
  MSQue := TMSQuery.Create(Nil);
  with MSQue do
  begin
    Connection := msCon;
    Close;
    SQL.Clear;
    SQL.Add('dbo.procTop10 :UserID, :StartD, :EndD');
    ParamByName('UserID').AsInteger := CurrentUser;
    ParamByName('StartD').AsDateTime := Date - 30;
    ParamByName('EndD').AsDateTime := Date;
    Execute;
    Free;
  end;
end;

procedure TfMain.OpenReport(Sender: TObject);
var
  BOB: TBOB;
  hDLLInst: THandle;
begin
  hDLLInst := LoadLibrary('ReportDesigner.dll');
  if (hDLLInst <= 0) then
    raise Exception.Create('[��������� ����� LoadLibrary]');
  try
    @BOB := GetProcAddress(hDLLInst, 'ShowForm');
    if not Assigned(BOB) then
      raise Exception.Create('[��������� ����� GetProcAddress]');
    BOB(PWideChar('Provider=SQLOLEDB.1;' + msCon.ConnectString));
  finally
    if (hDLLInst > 0) then
  end;
end;

procedure TfMain.RefreshData(Sender: TObject);
var
  FTRecNo: Integer;
begin
  FTRecNo := 0;
  if msCon.Connected then
  begin
    // NewTop10;
    // �������� ������ �����
    mMenu.Items[2].Visible := True;//IsUserController;
    mMenu.Items[1].Visible := IsUserController;
    CurrentDay := DatePicker.Date;
    msDS.DataSet := msQ;
    FocusedQuery := msQ;
    DBGrid.Columns[0].Title.caption := '';
    DBGrid.Options := [dgEditing, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
    if msQ.Active then
      msQ.Refresh
    else
      msQ.Open;
    if msQ10.Active then
      msQ10.Refresh
    else
      msQ10.Open;
    if msFB.Active then
      msFB.Refresh
    else
      msFB.Open;
    // �������� FacktTask
    if msFT.Active then
      with msFT do
      begin
        FTRecNo := msFT.RecNo;
        Close;
        ParamByName('UserID').AsInteger := CurrentUser;
        ParamByName('DayTask').AsDateTime := CurrentDay;
      end;
    msFT.Open;
    msFT.RecNo := FTRecNo;
    if Date > CurrentDay then
      msFT.ReadOnly := True
    else
      msFT.ReadOnly := False;

    if msFB.Active then
      with msFB do
      begin
        Close;
        ParamByName('UserID').AsInteger := CurrentUser;
      end;
    msFB.Open;
    if msFB.RecordCount > 0 then
    begin
      BreakTaskGrid.Visible := True;
      BreakTaskGrid.Enabled := True;
      SplitterR.Visible := Visible;
    end
    else
    begin
      BreakTaskGrid.Visible := False;
      BreakTaskGrid.Enabled := False;
      SplitterR.Visible := False;
    end;
  end
  else
  begin
    mMenu.Items[2].Visible := IsUserController;
    mMenu.Items[1].Visible := IsUserController;
  end;
  if (CurrentUser = 0) or (CurrentDay = 0) then
    GetStartParamFromDB;
end;

procedure TfMain.showAddTask(Sender: TObject);
begin
  fAddTask.Show;
end;

procedure TfMain.showRef1(Sender: TObject);
begin
  RefTask.Show;
end;

procedure TfMain.showRef2(Sender: TObject);
begin
  frmReference := TfrmReference.Create(Application);
  with frmReference do begin
    Position := poMainFormCenter;
    Show;
    Refresh;
  end;
  frmReference.sprPosts1.Visible := False;
  frmReference.sprCurators1.Visible := False;
  frmReference.sprUsers1.Visible := True;
  frmReference.sprDepartments1.Visible := False;
end;

procedure TfMain.showRef3(Sender: TObject);
begin
  frmReference := TfrmReference.Create(Application);
  with frmReference do begin
    Position := poMainFormCenter;
    Show;
    Refresh;
  end;
  frmReference.sprPosts1.Visible := True;
  frmReference.sprUsers1.Visible := False;
  frmReference.sprCurators1.Visible := False;
  frmReference.sprDepartments1.Visible := False;
end;

procedure TfMain.showRef4(Sender: TObject);
begin
  frmReference := TfrmReference.Create(Application);
  with frmReference do begin
    Position := poMainFormCenter;
    Show;
    Refresh;
  end;
  frmReference.sprPosts1.Visible := False;
  frmReference.sprUsers1.Visible := False;
  frmReference.sprCurators1.Visible := True;
  frmReference.sprDepartments1.Visible := False;
end;

procedure TfMain.showRef5(Sender: TObject);
begin
  frmReference := TfrmReference.Create(Application);
  with frmReference do begin
    Position := poMainFormCenter;
    Show;
    Refresh;
  end;
  frmReference.sprPosts1.Visible := False;
  frmReference.sprUsers1.Visible := False;
  frmReference.sprCurators1.Visible := False;
  frmReference.sprDepartments1.Visible := True;
end;

procedure TfMain.showRep3(Sender: TObject);
begin
  FRepHron.Show;
end;

procedure TfMain.showRep6(Sender: TObject);
begin
  fOtchFIO := TfOtchFIO.Create(Application);
  with fOtchFIO do
  begin
    Position := poMainFormCenter;
    Show;
    Refresh;
  end;
end;

procedure TfMain.showSetInterface(Sender: TObject);
begin
  fSettings.Show;
end;

procedure TfMain.showSetInterface2(Sender: TObject);
var
  InText : string;
begin
  repeat
    InText := InputBox('���� ���������', '����������, ������� ��������� ��������', '0');
  until CheckIntegerValue(InText) = True;

end;

procedure TfMain.showRep5(Sender: TObject);
begin
  fOtchSPP := TfOtchSPP.Create(Application);
  with fOtchSPP do
  begin
    Position := poMainFormCenter;
    Show;
    Refresh;
  end;
end;

procedure TfMain.showTop10(Sender: TObject);
begin
  fTactTop10.Show;
end;

procedure TfMain.StartParams;
begin
  with fMain do
  begin
    Width := GetSystemMetrics(SM_CXSCREEN) - 150;
    if GetSystemMetrics(SM_CYSCREEN) - 200 > 600 then
      Height := GetSystemMetrics(SM_CYSCREEN) - 200
    else
      Height := 550;
    Position := poScreenCenter;
  end;
  CurrentUser := 0;
  CurrentDay := 0;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
var
  txt: String;
begin
  if GetStateLastTask(txt) > 0 then begin
    txt := '����������� � ������:'+#10#13+txt;
    ShowMovingWindow(txt);
  end;
end;

procedure TfMain.TrIconOnClick(Sender: TObject);
begin
  MaximizeApp(Sender);
end;

procedure TfMain.WMHotKey(var Msg: TWMHotKey);
begin
  if Msg.HotKey = HK_C1 then
    CtrlTask(1);
  if Msg.HotKey = HK_C2 then
    CtrlTask(2);
  if Msg.HotKey = HK_C3 then
    CtrlTask(3);
  if Msg.HotKey = HK_C4 then
    CtrlTask(4);
  if Msg.HotKey = HK_C5 then
    CtrlTask(5);
  if Msg.HotKey = HK_C6 then
    CtrlTask(6);
  if Msg.HotKey = HK_C7 then
    CtrlTask(7);
  if Msg.HotKey = HK_C8 then
    CtrlTask(8);
  if Msg.HotKey = HK_C9 then
    CtrlTask(9);
  if Msg.HotKey = HK_C0 then
    CtrlTask(10);
end;

end.
