unit EditSeason_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TagTeamDB_u, Data.DB, Vcl.WinXPickers,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls,
  CreateSeason_u, Login_u, ResultClass_u, UserClass_u, TeamClass_u,
  PodiumClass_u, SeasonClass_u, EventClass_u;

type
  TfrmSEASONEdit = class(TForm)
    pgcnrtlSEASONEdit: TPageControl;
    tbshtSEASON: TTabSheet;
    tbshtTEAM: TTabSheet;
    dbgTEAM: TDBGrid;
    tbshtUSER: TTabSheet;
    pnlUSERButtons: TPanel;
    btnUSERCreate: TButton;
    btnUSEREdit: TButton;
    btnUSERDelete: TButton;
    dbgUSER: TDBGrid;
    pnlUSERCreate: TPanel;
    Label10: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    btnUSERSave: TButton;
    btnUSERCancel: TButton;
    edtUserName: TEdit;
    edtUserSurname: TEdit;
    cbbUserType: TComboBox;
    cbbUserTeam: TComboBox;
    edtEmail: TEdit;
    edtCell: TEdit;
    tbshtEvent: TTabSheet;
    dbgEVENT: TDBGrid;
    btnSEASONSelect: TButton;
    btnSEASONCreate: TButton;
    Panel1: TPanel;
    cbbSeasonSelect: TComboBox;
    Label1: TLabel;
    tbshtRESULT: TTabSheet;
    dbgRESULT: TDBGrid;
    pnlRESULTCreate: TPanel;
    Label2: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    cbbUser: TComboBox;
    cbbEvent: TComboBox;
    edtResult1: TEdit;
    edtResult2: TEdit;
    edtResult3: TEdit;
    cbbJudge: TComboBox;
    Label19: TLabel;
    btnRESULTSave: TButton;
    btnRESULTCancel: TButton;
    pnlRESULTButtons: TPanel;
    btnRESULTCreate: TButton;
    btnRESULTDelete: TButton;
    btnRESULTEdit: TButton;
    Button1: TButton;
    tbshtSEASONRANK: TTabSheet;
    pnlSeasonRank: TPanel;
    rea: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnUSERCreateClick(Sender: TObject);
    procedure btnUSERCancelClick(Sender: TObject);
    procedure btnUSERDeleteClick(Sender: TObject);
    procedure btnUSEREditClick(Sender: TObject);
    procedure btnSEASONCreateClick(Sender: TObject);
    procedure btnRESULTCreateClick(Sender: TObject);
    procedure btnRESULTEditClick(Sender: TObject);
    procedure btnRESULTDeleteClick(Sender: TObject);
    procedure btnRESULTCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSEASONSelectClick(Sender: TObject);
    procedure btnRESULTSaveClick(Sender: TObject);
    procedure btnUSERSaveClick(Sender: TObject);
    procedure dbgUSERCellClick(Column: TColumn);
    procedure dbgRESULTCellClick(Column: TColumn);
    procedure cbbUserTypeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtResult1Change(Sender: TObject);
    procedure edtResult2Change(Sender: TObject);
    procedure edtResult3Change(Sender: TObject);
    procedure tbshtSEASONRANKShow(Sender: TObject);
  private
    { Private declarations }
    iCUD: Integer; // Create = 1, Update = 2
    User: TUser;
    Team: TTeam;
    Event: TEvent;
    Result: TResult;
    Season: TSeason;
    Podium: TPodium;

    arrSeasonID: SeasonClass_u.TIntArray;
    arrTeamID: TeamClass_u.TIntArray;
    arrUserID: UserClass_u.TIntArray;
    arrEventID: EventClass_u.TIntArray;
    arrJudgeID: array of Integer;
    arrSurferID: array of Integer;
    SeasonID: Integer;

  public
    { Public declarations }
  end;

var
  frmSEASONEdit: TfrmSEASONEdit;

implementation

{$R *.dfm}
// EVENT

// RESULT
procedure TfrmSEASONEdit.btnRESULTCancelClick(Sender: TObject);
begin
  pnlRESULTButtons.Show;
  pnlRESULTCreate.Hide;
  iCUD := 0;
end;

procedure TfrmSEASONEdit.btnRESULTCreateClick(Sender: TObject);
var
  i, iJudgeCount, iSurferCount: Integer;
begin
  pnlRESULTCreate.Show;
  pnlRESULTButtons.Hide;
  iCUD := 1;

  setlength(arrJudgeID, 0);
  setlength(arrSurferID, 0);

  cbbUser.Clear;
  cbbEvent.Clear;
  cbbJudge.Clear;
  edtResult1.Clear;
  edtResult1.SetFocus;
  edtResult2.Clear;
  edtResult3.Clear;

  iJudgeCount := 0;
  iSurferCount := 0;

  User := TUser.Create();
  arrUserID := User.MakeUserIDArray;
  with dmTagTeam do
    for i := 0 to Length(arrUserID) - 1 do
    // populate cbbUser and cbbJudge
    begin
      tblUser.Locate('userID', arrUserID[i], []);
      if uppercase(tblUser['type']) = 'JUDGE' then
      begin
        inc(iJudgeCount);
        setlength(arrJudgeID, iJudgeCount);
        arrJudgeID[iJudgeCount - 1] := arrUserID[i];

        cbbJudge.Items.Add(tblUser['first_name'] + ' ' + tblUser['surname'])
      end
      else if uppercase(tblUser['type']) = 'SURFER' then
      begin
        inc(iSurferCount);
        setlength(arrSurferID, iSurferCount);
        arrSurferID[iSurferCount - 1] := arrUserID[i];

        cbbUser.Items.Add(tblUser['first_name'] + ' ' + tblUser['surname']);
      end;
    end;

  Event := TEvent.Create();
  arrEventID := Event.MakeEventIDArray;
  with dmTagTeam do
    for i := 0 to Length(arrEventID) - 1 do
    // populate cbbEvent
    begin
      tblEVENT.Locate('eventID', arrEventID[i], []);
      cbbEvent.Items.Add(tblEVENT['event_name'] + ' - ' +
        datetostr(tblEVENT['event_date']));
    end;
end;

procedure TfrmSEASONEdit.btnRESULTDeleteClick(Sender: TObject);
begin
  with dmTagTeam do
  begin
    if tblRESULT['resultID'] <= 0 then
      Showmessage('Please select a record to delete.')
    else if MessageDlg('Are you sure you want to delete this result?',
      mtWarning, [mbOK, mbCancel], 0) = mrOK then
      tblRESULT.Delete;
  end;
end;

procedure TfrmSEASONEdit.btnRESULTEditClick(Sender: TObject);
var
  iResult, i, iIndex: Integer;
begin
  pnlRESULTCreate.Show;
  pnlRESULTButtons.Hide;

  btnRESULTCreate.Click;
  iCUD := 2;

  with dmTagTeam do
  begin
    for i := 0 to Length(arrSurferID) - 1 do
    // Find index in arrSurferID to determined itemindex needed
    begin
      if arrSurferID[i] = tblRESULT['userID'] then
        iIndex := i;
    end;
    if iIndex >= 0 then
      cbbUser.ItemIndex := iIndex
    else
      Showmessage('ERROR: Surfer not found');
    iIndex := -1;

    for i := 0 to Length(arrEventID) - 1 do
    // Find index in arrEventID to determined itemindex needed
    begin
      if arrEventID[i] = tblRESULT['eventID'] then
        iIndex := i;
    end;
    if iIndex >= 0 then
      cbbEvent.ItemIndex := iIndex
    else
      Showmessage('ERROR: Event not found');
    iIndex := -1;

    for i := 0 to Length(arrJudgeID) - 1 do
    // Find index in arrJudgeID to determined itemindex needed
    begin
      if arrJudgeID[i] = tblRESULT['judgeID'] then
        iIndex := i;
    end;
    if iIndex >= 0 then
      cbbJudge.ItemIndex := iIndex
    else
      Showmessage('ERROR: Judge not found');
    iIndex := -1;

    iResult := tblRESULT['result'] * 10;
    if iResult = 100 then // Inserts result from database into edits
    begin
      edtResult1.Text := inttostr(iResult)[1];
      edtResult2.Text := inttostr(iResult)[2];
      edtResult3.Text := inttostr(0);
    end
    else
    begin
      edtResult1.Text := inttostr(0);
      edtResult2.Text := inttostr(iResult)[1];
      edtResult3.Text := inttostr(iResult)[2];
    end;
  end;

end;

procedure TfrmSEASONEdit.btnRESULTSaveClick(Sender: TObject);
var
  iUserID: Integer;
  iEventID: Integer;
  iTeamID: Integer;
  iJudgeID: Integer;
  iResult: Integer;
  rResult: Real;
  iNum: Integer;
  sMsg: String;
begin
  iUserID := arrSurferID[cbbUser.ItemIndex];
  iEventID := arrEventID[cbbEvent.ItemIndex];
  with dmTagTeam do
  begin
    tblUser.Locate('userID', iUserID, []);
    iTeamID := tblUser['teamID'];
  end;
  iJudgeID := arrJudgeID[cbbJudge.ItemIndex];
  iResult := strtoint(edtResult1.Text + edtResult2.Text + edtResult3.Text);
  rResult := iResult / 10;

  Result := TResult.Create(iUserID, iEventID, iTeamID, iJudgeID, rResult);
  if Result.Validate = '' then
  begin
    case iCUD of
      1:
        begin
          Result.InsertResultRecord;
        end;
      2:
        begin
          Result.UpdateResultRecord;
        end;
    end;
    btnRESULTCancel.Click;
  end
  else
  begin
    sMsg := Result.Validate; // Validation and Error Checking
    iNum := strtoint(sMsg[1]);
    Delete(sMsg, 1, 1);
    Showmessage(sMsg);

    case iNum of
      1:
        begin
          cbbUser.ItemIndex := -1;
          cbbUser.SetFocus;
        end;
      2:
        begin
          cbbEvent.ItemIndex := -1;
          cbbEvent.SetFocus;
        end;
      3:
        begin
          cbbJudge.ItemIndex := -1;
          cbbJudge.SetFocus;
        end;
      4:
        begin
          // Team generated by program
        end;
      5:
        begin
          edtResult1.Clear;
          edtResult2.Clear;
          edtResult3.Clear;
          edtResult1.SetFocus;
        end;
    end;
  end;
end;

procedure TfrmSEASONEdit.btnSEASONCreateClick(Sender: TObject);
begin
  frmSEASONEdit.Hide;
  frmSEASONCreate.Show;
end;

procedure TfrmSEASONEdit.btnSEASONSelectClick(Sender: TObject);
var
  sResultFilter: String;
  iResultEvent, iPos: Integer;
  sCaption: String;
begin
  if cbbSeasonSelect.Text = '' then
  begin
    Showmessage('Please select a season to edit');
    Exit
  end;

  tbshtRESULT.Show;

  tbshtRESULT.TabVisible := True;
  tbshtTEAM.TabVisible := True;
  tbshtUSER.TabVisible := True;
  tbshtEvent.TabVisible := True;

  SeasonID := arrSeasonID[cbbSeasonSelect.ItemIndex];

  with dmTagTeam do
  begin
    tblUser.Filtered := False;
    tblRESULT.Filtered := False;
    tblEVENT.Filtered := False;

    tblUser.Filter := 'seasonID =' + SeasonID.ToString;
    tblUser.Filtered := True;

    tblRESULT.First;
    while not tblRESULT.Eof do
    begin
      iResultEvent := tblRESULT['eventID'];
      tblEVENT.Locate('eventID', iResultEvent, []);
      if tblEVENT['seasonID'] = SeasonID then
        sResultFilter := sResultFilter + 'eventID =' +
          iResultEvent.ToString + ' OR ';
      tblRESULT.Next;
    end;

    Delete(sResultFilter, Length(sResultFilter) - 3, 3);
    if sResultFilter = '' then
      sResultFilter := 'eventID =' + '0';
    tblRESULT.Filter := sResultFilter;
    tblRESULT.Filtered := True;

    tblEVENT.Filter := 'seasonID =' + SeasonID.ToString;
    tblEVENT.Filtered := True;

    tblTEAM.Filter := 'seasonID =' + SeasonID.ToString;
    tblTEAM.Filtered := True;
  end;

end;

// SEASON

// TEAM

// USER
procedure TfrmSEASONEdit.btnUSERCancelClick(Sender: TObject);
begin
  pnlUSERButtons.Show;
  pnlUSERCreate.Hide;
  iCUD := 0;
end;

procedure TfrmSEASONEdit.btnUSERCreateClick(Sender: TObject);
var
  i: Integer;
begin
  pnlUSERCreate.Show;
  pnlUSERButtons.Hide;
  iCUD := 1;

  cbbUserTeam.Enabled := True;
  cbbUserTeam.Clear;
  cbbUserType.ItemIndex := -1;
  edtUserName.Clear;
  edtUserSurname.Clear;
  edtEmail.Clear;
  edtCell.Clear;

  Team := TTeam.Create();
  arrTeamID := Team.MakeTeamIDArray;
  with dmTagTeam do
    for i := 1 to Length(arrTeamID) - 1 do // populate cbbTeam
    begin
      tblTEAM.Locate('teamID', arrTeamID[i], []);
      cbbUserTeam.Items.Add(tblTEAM['team_name']);
    end;
end;

procedure TfrmSEASONEdit.btnUSERDeleteClick(Sender: TObject);
begin
  with dmTagTeam do
  begin
    if tblUser['userid'] <= 0 then
      Showmessage('Please select a record to delete.')
    else if MessageDlg('Are you sure you want to delete user: ' +
      tblUser['first_name'] + ' ' + tblUser['surname'] + '?', mtWarning,
      [mbOK, mbCancel], 0) = mrOK then
      tblUser.Delete;
  end;
end;

procedure TfrmSEASONEdit.btnUSEREditClick(Sender: TObject);
var
  iType: Integer;
  sType: String;
  i, iIndex: Integer;
begin
  pnlUSERCreate.Show;
  pnlUSERButtons.Hide;
  iIndex := -1;

  btnUSERCreate.Click;
  iCUD := 2;
  with dmTagTeam do
  begin

    sType := uppercase(tblUser['type']);

    if sType = 'SURFER' then
      iType := 0
    else if sType = 'COACH' then
      iType := 1
    else if sType = 'JUDGE' then
    begin
      iType := 2;
      cbbUserTeam.ItemIndex := -1;
      cbbUserTeam.Enabled := False;
    end;

    cbbUserType.ItemIndex := iType;
    iIndex := -1;

    for i := 0 to Length(arrTeamID) - 1 do
    // Find index in arrTeamID to determined itemindex needed
    begin
      if arrTeamID[i] = tblUser['teamID'] then
        iIndex := i - 1;
    end;

    if iIndex >= 0 then
      cbbUserTeam.ItemIndex := iIndex
    else if cbbUserTeam.Enabled = True then
      Showmessage('ERROR: Team not found');
    iIndex := -1;

    edtUserName.Text := tblUser['first_name'];

    edtUserSurname.Text := tblUser['surname'];

    edtCell.Text := tblUser['cell_no'];

    edtEmail.Text := tblUser['email'];
  end;
end;

procedure TfrmSEASONEdit.btnUSERSaveClick(Sender: TObject);
var
  sFirstName, sSurname, sType, sEmail, sCell, sMsg: String;
  iTeam, iSeason, iNum: Integer;
begin
  sFirstName := edtUserName.Text;
  sSurname := edtUserSurname.Text;
  sType := uppercase(cbbUserType.Text);
  sEmail := edtEmail.Text;
  sCell := edtCell.Text;
  if Length(arrTeamID) > 0 then
    iTeam := arrTeamID[cbbUserTeam.ItemIndex + 1]
  else
  begin
    Showmessage('Please fill in the teams table before entering users.');
    btnUSERCancel.Click;
    pgcnrtlSEASONEdit.ActivePage := tbshtTEAM;
    Exit
  end;
  try
    iSeason := SeasonID;
  Except
    Showmessage('Please Enter Season');
  end;

  User := TUser.Create(sType, iTeam, iSeason, sFirstName, sSurname,
    sCell, sEmail);
  if User.Validate = '' then
  begin
    case iCUD of
      1:
        begin
          User.InsertUserRecord;
        end;
      2:
        begin
          User.UpdateUserRecord;
        end;
    end;
    btnUSERCancel.Click;
  end
  else
  begin
    sMsg := User.Validate;
    iNum := strtoint(sMsg[1]);
    Delete(sMsg, 1, 1);
    Showmessage(sMsg);

    case iNum of
      1:
        begin

        end;
      2:
        begin
          cbbUserType.ItemIndex := -1;
          cbbUserType.SetFocus;
        end;
      3:
        begin
          cbbUserTeam.ItemIndex := -1;
          cbbUserTeam.SetFocus;
        end;
      4:
        begin
          edtCell.Clear;
          edtCell.SetFocus;
        end;
      5:
        begin
          edtEmail.Clear;
          edtEmail.SetFocus;
        end;
      6:
        begin
          edtUserName.Clear;
          edtUserSurname.Clear;
          edtUserName.SetFocus;
        end;
    end;
  end;
end;

procedure TfrmSEASONEdit.Button1Click(Sender: TObject);
begin
  if SeasonID > 0 then
  begin
    Podium := TPodium.Create;
    Podium.SetupPodiums(SeasonID);
  end
  else
    Showmessage('Please Select Season');
end;

procedure TfrmSEASONEdit.cbbUserTypeChange(Sender: TObject);
begin
  if (cbbUserType.ItemIndex = 2) or (uppercase(cbbUserType.Text) = 'JUDGE') then
  begin
    cbbUserTeam.ItemIndex := -1;
    cbbUserTeam.Enabled := False
  end
  else
    cbbUserTeam.Enabled := True;
end;

procedure TfrmSEASONEdit.dbgRESULTCellClick(Column: TColumn);
begin
  if pnlRESULTCreate.Visible = True then
    btnRESULTEdit.Click;
end;

procedure TfrmSEASONEdit.dbgUSERCellClick(Column: TColumn);
begin
  if pnlUSERCreate.Visible = True then
    btnUSEREdit.Click;
end;

procedure TfrmSEASONEdit.edtResult1Change(Sender: TObject);
begin
  edtResult2.SetFocus;
end;

procedure TfrmSEASONEdit.edtResult2Change(Sender: TObject);
begin
  edtResult3.SetFocus;
end;

procedure TfrmSEASONEdit.edtResult3Change(Sender: TObject);
begin
  edtResult1.SetFocus;
end;

procedure TfrmSEASONEdit.FormCreate(Sender: TObject);
begin
  pnlUSERCreate.Hide;
  pnlRESULTCreate.Hide;
  Application.ShowMainForm := False;

end;

procedure TfrmSEASONEdit.FormShow(Sender: TObject);
var
  i, iSeasonID: Integer;
  dStart, dEnd: TDate;
  sItem: String;
begin
  frmLogin.Hide;
  pgcnrtlSEASONEdit.ActivePage := tbshtSEASON;

  tbshtTEAM.TabVisible := False;
  tbshtUSER.TabVisible := False;
  tbshtEvent.TabVisible := False;
  tbshtRESULT.TabVisible := False;

  cbbSeasonSelect.Clear;
  Season := TSeason.Create;
  arrSeasonID := Season.MakeSeasonIDArray;
  with dmTagTeam do
  begin
    for i := 0 to Length(arrSeasonID) - 1 do
    // populate cbbSeason
    begin
      tblSEASON.Locate('seasonID', arrSeasonID[i], []);
      iSeasonID := (tblSEASON['seasonID']);
      dStart := tblSEASON['season_start'];
      dEnd := tblSEASON['season_end'];

      sItem := iSeasonID.ToString + ': ' + datetostr(dStart) + ' - ' +
        datetostr(dEnd);
      cbbSeasonSelect.Items.Add(sItem);

    end;
  end;

  // Result
  dbgRESULT.Columns.Items[0].Title.Caption := 'Surfer';
  dbgRESULT.Columns.Items[0].Width := 120;

  dbgRESULT.Columns.Items[1].Title.Caption := 'Event';
  dbgRESULT.Columns.Items[1].Width := 170;

  dbgRESULT.Columns.Items[2].Title.Caption := 'Judge';
  dbgRESULT.Columns.Items[2].Width := 170;

  dbgRESULT.Columns.Items[3].Title.Caption := 'Result';
  dbgRESULT.Columns.Items[3].Width := 170;

  // Team
  dbgTEAM.Columns.Items[0].Title.Caption := 'Team Number';

  dbgTEAM.Columns.Items[1].Title.Caption := 'Team Name';

  // User
  dbgUSER.Columns.Items[0].Title.Caption := 'User Type';
  dbgUSER.Columns.Items[0].Width := 120;

  dbgUSER.Columns.Items[1].Title.Caption := 'User Team';
  dbgUSER.Columns.Items[1].Width := 120;

  dbgUSER.Columns.Items[2].Title.Caption := 'First Name';
  dbgUSER.Columns.Items[2].Width := 150;

  dbgUSER.Columns.Items[3].Title.Caption := 'Surname';
  dbgUSER.Columns.Items[3].Width := 150;

  dbgUSER.Columns.Items[4].Title.Caption := 'Cellphone Number';
  dbgUSER.Columns.Items[4].Width := 170;

  dbgUSER.Columns.Items[5].Title.Caption := 'Email Address';
  dbgUSER.Columns.Items[5].Width := 150;

  // Event
  dbgEVENT.Columns.Items[0].Title.Caption := 'Event Date';
  dbgEVENT.Columns.Items[0].Width := 200;
end;

procedure TfrmSEASONEdit.tbshtSEASONRANKShow(Sender: TObject);
var
  iEventID, iTeam1, iTeam2, iTeam3, iTeam4: Integer;
  iTeam1Score, iTeam2Score, iTeam3Score, iTeam4Score: Integer;
begin
  iTeam1Score := 0;
  iTeam2Score := 0;
  iTeam3Score := 0;
  iTeam4Score := 0;
  with dmTagTeam do
  begin
    tblPODIUM.First;
    while not tblPODIUM.Eof do
    begin
      iEventID := tblPODIUM['eventid'];
      iTeam1 := tblPODIUM['team1'];
      iTeam2 := tblPODIUM['team2'];
      iTeam3 := tblPODIUM['team3'];
      iTeam4 := tblPODIUM['team4'];

      tblRESULT.First;
      while not tblRESULT.Eof do
      begin
        if (tblRESULT['eventid'] = iEventID) and (tblRESULT['teamid'] = iTeam1)
        then
          iTeam1Score := iTeam1Score + (tblRESULT['result'] * 10);

        if (tblRESULT['eventid'] = iEventID) and (tblRESULT['teamid'] = iTeam2)
        then
          iTeam2Score := iTeam2Score + (tblRESULT['result'] * 10);

        if (tblRESULT['eventid'] = iEventID) and (tblRESULT['teamid'] = iTeam3)
        then
          iTeam3Score := iTeam3Score + (tblRESULT['result'] * 10);

        if (tblRESULT['eventid'] = iEventID) and (tblRESULT['teamid'] = iTeam4)
        then
          iTeam4Score := iTeam4Score + (tblRESULT['result'] * 10);

         Podium := TPodium.Create;
         Podium.ConvertToPodiumScores(iTeam1Score, iTeam2Score, iTeam3Score, iTeam4Score);

      end;
    end;
  end;
end;

end.
