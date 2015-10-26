unit uMovingwnd;

interface
uses
{$ifdef useIDAF}
  idAntiFreeze,
{$endif}
  SysUtils, Classes, Windows, Forms, Controls, StdCtrls, Graphics, Dialogs;
type
  TMovingwnd = class
  public
    class procedure HintLabelClick(Sender: TObject);
  end;
  procedure ShowMovingWindow(aText:String);

implementation
{.$define useIDAF}
{.$define intwndproc}

class procedure TMovingwnd.HintLabelClick(Sender: TObject);
begin
(Sender as TLabel).Parent.Free;
//with HintForm do
//  begin
//{$ifdef useIDAF}
//      ida.Sleep(2000);
//{$else}
//      Sleep(2000);
//{$endif}
//    �������� ����
//    NeedTop:=Screen.Width-20;
//    while Top<NeedTop do
//    begin
//      Top:=Top+2;
//      Repaint;
//
//{$ifdef useIDAF}
//      ida.Sleep(10);
//      ida.Process;
//{$else}
//      Sleep(10);
//{$endif}
//    end;
//    HintLabel.Free;
//    Free;
//  end;
//{$ifdef useIDAF}
//  ida.Free;
//{$endif}
end;

procedure ShowMovingWindow(aText:String);
var
    ShellHandle:THandle;
    Rect:TRect;
    NeedTop:Integer;
    HintForm:TForm;
    HintLabel:TLabel;
  {$ifdef intwndproc}
    ActiveWnd:THandle;
  {$endif}
  {$ifdef useIDAF}
    ida:TIdAntiFreeze;
  {$endif}
begin
  //���� "������ � ��������"
  ShellHandle := FindWindow('Shell_TrayWnd', nil);
  if ShellHandle = 0 then
    exit;
{$ifdef useIDAF}
  ida:=TIdAntiFreeze.Create(nil);
{$endif}
  GetWindowRect(ShellHandle, Rect);
  //������� �����
  HintForm:=TForm.Create(nil);
  with HintForm do
  begin
    Width:=245;
    Height:=100;
    Color:=clSkyBlue;
    BorderStyle:=bsNone;
    FormStyle := fsStayOnTop;
    //������ �����
    HintLabel:=TLabel.Create(nil);
    with HintLabel do
    begin
        Parent:=HintForm;
        WordWrap:=true;
        Font.Size := 10;
        Font.Style := [fsBold];
        Caption:=' '+Trim(aText)+' ';
        Cursor := crHandPoint;
        Align:=alClient;
        Layout:=tlCenter;
        Alignment:=taCenter;
        Hint := '������';
        ShowHint := True;
        Cursor := crHandPoint;
        OnClick := TMovingwnd.HintLabelClick;
    end;

    AlphaBlend:=true;
    AlphaBlendValue:=220;
{$ifdef intwndproc}
    ActiveWnd:=GetActiveWindow;
{$endif}
    ShowWindow(Handle,SW_SHOWNOACTIVATE);
{$ifdef intwndproc}
    SetActiveWindow(ActiveWnd);
{$endif}
    Left:=Screen.Width-Width;
    Top:=Screen.Height-20;
    //�������� �����
    NeedTop:=Rect.Top-Height;
    while Top>NeedTop do
    begin
      Top:=Top-2;
      Repaint;
{$ifdef useIDAF}
      ida.Sleep(10);
      ida.Process;
{$else}
      Sleep(10);
{$endif}
    end;

  end;
end;
end.
