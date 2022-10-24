unit CreateSeason_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, TagTeamDB_u, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.WinXPickers,
  UserClass_u, TeamClass_u, EventClass_u, SeasonClass_u, PodiumClass_u,
  ResultClass_u;

type
  TfrmSEASONCreate = class(TForm)
    pgcnrtlSEASONCreate: TPageControl;
    tbshtSEASON: TTabSheet;
    tbshtTEAM: TTabSheet;
    tbshtUSER: TTabSheet;
    tbshtEvent: TTabSheet;
    dbgSEASON: TDBGrid;
    pnlSEASONCreate: TPanel;
    pnlSEASONButtons: TPanel;
    btnSEASONCreate: TButton;
    btnSEASONEdit: TButton;
    btnSEASONDelete: TButton;
    dpStart: TDatePicker;
    dpEnd: TDatePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnSEASONSave: TButton;
    btnSEASONCancel: TButton;
    dbgEVENT: TDBGrid;
    pnlUSERButtons: TPanel;
    btnUSERCreate: TButton;
    btnUSEREdit: TButton;
    btnUSERDelete: TButton;
    pnlTEAMButtons: TPanel;
    btnTEAMCreate: TButton;
    btnTEAMEdit: TButton;
    btnTEAMDelete: TButton;
    pnlEVENTButtons: TPanel;
    btnEVENTCreate: TButton;
    btnEVENTEdit: TButton;
    btnEVENTDelete: TButton;
    pnlEVENTCreate: TPanel;
    Label3: TLabel;
    btnEVENTSave: TButton;
    btnEVENTCancel: TButton;
    dpEVENTDate: TDatePicker;
    dbgTEAM: TDBGrid;
    pnlTEAMCreate: TPanel;
    Label8: TLabel;
    btnTEAMSave: TButton;
    btnTEAMCancel: TButton;
    edtTeamName: TEdit;
    dbgUSER: TDBGrid;
    pnlUSERCreate: TPanel;
    Label10: TLabel;
    Label12: TLabel;
    btnUSERSave: TButton;
    btnUSERCancel: TButton;
    edtFirstName: TEdit;
    edtUserSurname: TEdit;
    Label7: TLabel;
    cbbUserType: TComboBox;
    cbbUserTeam: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    edtEmail: TEdit;
    Label15: TLabel;
    edtCell: TEdit;
    OpenDlgFilePicker: TOpenDialog;
    btnLoadFromFile: TButton;
    lblSeasonDates: TLabel;
    btnFinishSeasonSetup: TButton;
    Label5: TLabel;
    btnCancelSeasonSetup: TButton;
    procedure btnSEASONCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEVENTCreateClick(Sender: TObject);
    procedure btnTEAMCreateClick(Sender: TObject);
    procedure btnUSERCreateClick(Sender: TObject);
    procedure btnEVENTCancelClick(Sender: TObject);
    procedure btnUSERCancelClick(Sender: TObject);
    procedure btnTEAMCancelClick(Sender: TObject);
    procedure btnSEASONCancelClick(Sender: TObject);
    procedure btnSEASONEditClick(Sender: TObject);
    procedure btnSEASONDeleteClick(Sender: TObject);
    procedure btnEVENTDeleteClick(Sender: TObject);
    procedure btnEVENTEditClick(Sender: TObject);
    procedure btnTEAMDeleteClick(Sender: TObject);
    procedure btnTEAMEditClick(Sender: TObject);
    procedure btnUSERDeleteClick(Sender: TObject);
    procedure btnUSEREditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSEASONSaveClick(Sender: TObject);
    procedure btnLoadFromFileClick(Sender: TObject);
    procedure dbgSEASONCellClick(Column: TColumn);
    procedure btnTEAMSaveClick(Sender: TObject);
    procedure dbgTEAMCellClick(Column: TColumn);
    procedure btnUSERSaveClick(Sender: TObject);
    procedure dbgUSERCellClick(Column: TColumn);
    procedure dbgEVENTCellClick(Column: TColumn);
    procedure btnEVENTSaveClick(Sender: TObject);
    procedure cbbUserTypeChange(Sender: TObject);
    procedure cbbSeasonChange(Sender: TObject);
    procedure btnFinishSeasonSetupClick(Sender: TObject);
    procedure btnCancelSeasonSetupClick(Sender: TObject);
  private
    { Private declarations }
    iCUD: Integer; // Create = 1, Edit = 2, Delete = 3
    User: TUser;
    Team: TTeam;
    Event: TEvent;
    Result: TResult;
    Season: TSeason;
    Podium: TPodium;
    arrSeasonID: SeasonClass_u.TIntArray;
    arrTeamID: TeamClass_u.TIntArray;

  public
    { Public declarations }
    SeasonID: Integer;
  end;

var
  frmSEASONCreate: TfrmSEASONCreate;

implementation

uses EditSeason_u;
{$R *.dfm}

// EVENT
procedure TfrmSEASONCreate.btnFinishSeasonSetupClick(Sender: TObject);
var
  i, iPodiumEventID, iPodiumNumber: Integer;
  iTeam1, iTeam2, iTeam3, iTeam4: Integer;
  iTeamCount, iTeamID, iSurferCount, iJudgeCount, iCoachCount: Integer;
  bValidSeason: Boolean;
  sError: String;
begin

  bValidSeason := True;
  with dmTagTeam do
  begin
    for i := 1 to tblTEAM.RecordCount do
      if tblTEAM['seasonid'] = SeasonID then // Gets number of teams
        inc(iTeamCount);

    if iTeamCount <= 5 then
    begin
      bValidSeason := False;
      sError := 'Not enough teams. Please enter more than 5 teams.';
    end;

    tblTEAM.First;
    while not tblTEAM.Eof do
    begin
      if tblTEAM['seasonid'] = SeasonID then
      begin
        iTeamID := tblTEAM['teamid'];
        iCoachCount := 0;
        tblUSER.First;
        while not tblUSER.Eof do
        begin
          if (tblUSER['teamid'] = iTeamID) and (tblUSER['type'] = 'COACH') then
            inc(iCoachCount);
          tblUSER.Next;
        end;
        if iCoachCount < 1 then
        begin
          bValidSeason := False;
          sError := 'Not enough coaches. Please ensure that there is only 1 coach assigned to every team.';
        end
        else if iCoachCount > 1 then
        begin
          bValidSeason := False;
          sError := 'More than one coach assigned to a team. Please ensure each there is 1 coach assigned to every team.'
        end;
      end;

      tblUSER.First;
      iSurferCount := 0;
      iJudgeCount := 0;
      while not tblUSER.Eof do
      begin
        // Get number of surfers in each team
        if tblUSER['seasonid'] = SeasonID then
          if (tblUSER['teamid'] = iTeamID) and (tblUSER['type'] = 'SURFER') then
            inc(iSurferCount);

        // Gets number of judges in season
        if (tblUSER['seasonid'] = SeasonID) and (tblUSER['type'] = 'JUDGE') then
          inc(iJudgeCount);

        tblUSER.Next;
      end;
      if iSurferCount < 5 then
      begin
        bValidSeason := False;
        sError := 'Not enough surfers. Please enter at least 5 surfers per team.';
      end;

      if iJudgeCount < 1 then
      begin
        bValidSeason := False;
        sError := 'No judges. Please enter 1 or more judges.';
      end;
      tblTEAM.Next;
    end;

  end;
  if bValidSeason = True then
  begin
    frmSEASONEdit.show;
    frmSEASONCreate.Hide;
    ShowMessage('Season Created Successfully!');

    Podium := TPodium.Create;
    Podium.SetupPodiums(SeasonID); // Sets up Team Matrix
    with dmTagTeam do
    begin
      tblEVENT.First;
      while not tblEVENT.Eof do
      // Enters all podiums for all events into database
      begin
        for i := 1 to PodiumClass_u.iPodiums do
        begin
          iPodiumEventID := tblEVENT['eventID'];
          iPodiumNumber := i;
          Podium := TPodium.Create;
          Podium.GetTeams(iPodiumNumber, iTeam1, iTeam2, iTeam3, iTeam4);

          Podium.Create(iPodiumEventID, iPodiumNumber, iTeam1, iTeam2,
            iTeam3, iTeam4);
          Podium.InsertPodiumRecord;

        end;
        Podium.ShiftPodiums;
        tblEVENT.Next;
      end;
    end;
  end
  else
    Showmessage(sError);
end;

procedure TfrmSEASONCreate.btnEVENTCancelClick(Sender: TObject);
begin
  pnlEVENTButtons.show;
  pnlEVENTCreate.Hide;
  iCUD := 0;
end;

procedure TfrmSEASONCreate.btnEVENTCreateClick(Sender: TObject);
var
  i: Integer;
begin
  pnlEVENTCreate.show;
  pnlEVENTButtons.Hide;
  iCUD := 1;

  dpEVENTDate.Date := now;

end;

procedure TfrmSEASONCreate.btnEVENTDeleteClick(Sender: TObject);
begin
  with dmTagTeam do
  begin
    if tblEVENT['eventID'] <= 0 then
      Showmessage('Please select a record to delete.')
    else if MessageDlg('Are you sure you want to delete Event ' +
      inttostr(tblEVENT['eventID']) + '?', mtWarning, [mbOK, mbCancel], 0) = mrOK
    then
      tblEVENT.Delete;
  end;
end;

procedure TfrmSEASONCreate.btnEVENTEditClick(Sender: TObject);
var
  iIndex, i: Integer;
begin
  pnlEVENTCreate.show;
  pnlEVENTButtons.Hide;

  btnEVENTCreate.Click;
  iCUD := 2;
  iIndex := -1;

  with dmTagTeam do
  begin

    dpEVENTDate.Date := tblEVENT['event_date'];
  end;
end;

procedure TfrmSEASONCreate.btnEVENTSaveClick(Sender: TObject);
var
  iSeason, iNum: Integer;
  sEventName, sLocation, sMsg: String;
  dtEvent: TDate;
begin
  iSeason := SeasonID;
  dtEvent := dpEVENTDate.Date;

  Event := TEvent.Create(sLocation, sEventName, dtEvent, iSeason);
  if Event.Validate = '' then
  begin
    case iCUD of
      1:
        begin
          Event.InsertEventRecord;
        end;
      2:
        begin
          Event.UpdateEventRecord;
        end;
    end;
    btnEVENTCancel.Click;
  end
  else
  begin
    sMsg := Event.Validate; // Validation and Error Checking
    iNum := strtoint(sMsg[1]);
    Delete(sMsg, 1, 1);
    Showmessage(sMsg);

    case iNum of
      1:
        begin
        end;
      2:
        begin
        end;
      3:
        begin
        end;
      4:
        begin
          dpEVENTDate.Date := now;
          dpEVENTDate.SetFocus;
        end;
    end;
  end;
end;

// LOAD FROM FILE
procedure TfrmSEASONCreate.btnLoadFromFileClick(Sender: TObject);
begin
  OpenDlgFilePicker.Filter := 'Text files (*.txt)|*.TXT|Any file (*.*)|*.*';
  OpenDlgFilePicker.Execute;

  TUser.CreateFromTextFile(OpenDlgFilePicker.FileName);
end;

// SEASON
procedure TfrmSEASONCreate.btnSEASONCancelClick(Sender: TObject);
begin
  pnlSEASONButtons.show;
  pnlSEASONCreate.Hide;
  iCUD := 0;
end;

procedure TfrmSEASONCreate.btnSEASONCreateClick(Sender: TObject);
begin
  pnlSEASONCreate.show;
  pnlSEASONButtons.Hide;
  iCUD := 1;

end;

procedure TfrmSEASONCreate.btnSEASONDeleteClick(Sender: TObject);
begin
  with dmTagTeam do
  begin
    if tblSEASON['seasonID'] <= 0 then
      Showmessage('Please select a record to delete.')
    else if MessageDlg('Are you sure you want to delete Season ' +
      inttostr(tblSEASON['seasonID']) + '?', mtWarning, [mbOK, mbCancel], 0) = mrOK
    then
      tblSEASON.Delete;

    tblTEAM.Close;
    tblTEAM.Open;
  end;
end;

procedure TfrmSEASONCreate.btnSEASONEditClick(Sender: TObject);
var
  iSeasonID: Integer;
begin
  pnlSEASONCreate.show;
  pnlSEASONButtons.Hide;

  btnSEASONCreate.Click;
  iCUD := 2;

  with dmTagTeam do
  begin
    dpStart.Date := tblSEASON['season_start'];
    dpEnd.Date := tblSEASON['season_end'];
  end;
end;

procedure TfrmSEASONCreate.btnSEASONSaveClick(Sender: TObject);
var
  dtSeasonStart, dtSeasonEnd: TDate;
  bCreated, bSuccess: Boolean;
  iResultEvent: Integer;
  sCaption: String;
  dStart, dEnd: TDate;
begin
  bCreated := False;
  bSuccess := False;
  dtSeasonStart := dpStart.Date;
  dtSeasonEnd := dpEnd.Date;

  with dmTagTeam do
  begin
    tblTEAM.Close;
    tblUSER.Close;
    tblEVENT.Close;
    tblTEAM.Open;
    tblUSER.Open;
    tblEVENT.Open;
  end;

  Season := TSeason.Create(dtSeasonStart, dtSeasonEnd);
  if Season.Validate = '' then
  begin
    case iCUD of
      1:
        begin
          Season.InsertSeasonRecord;

          bCreated := True;
          SeasonID := dmTagTeam.tblSEASON['seasonID'];

        end;
      2:
        begin
          Season.UpdateSeasonRecord;
        end;
    end;
    btnSEASONCancel.Click;
    with dmTagTeam do
    begin
      tblSEASON.Locate('seasonID', SeasonID, []);
      dStart := tblSEASON['season_start'];
      dEnd := tblSEASON['season_end'];

      sCaption := datetostr(dStart) + ' - ' + datetostr(dEnd);
      lblSeasonDates.Caption := sCaption;
    end;
  end
  else
  begin
    Showmessage(Season.Validate);
    btnSEASONCreate.Click;
  end;

  if bCreated then
  begin
    Team := TTeam.Create;
    Team.CopyOverTeams(SeasonID, SeasonID - 1);
    Event := TEvent.Create;
    Event.CreateEventSchedule(SeasonID, bSuccess);
    if bSuccess = False then
    begin
      btnSEASONCreate.Click;
      Exit
    end
    else
    begin
      with dmTagTeam do
      begin
        tbshtTEAM.TabVisible := True;
        tbshtUSER.TabVisible := True;
        tbshtEvent.TabVisible := True;

        tblUSER.Filtered := False;
        tblRESULT.Filtered := False;
        tblEVENT.Filtered := False;

        tblUSER.Filter := 'seasonID =' + SeasonID.ToString;
        tblUSER.Filtered := True;

        tblEVENT.Filter := 'seasonID =' + SeasonID.ToString;
        tblEVENT.Filtered := True;

        tblTEAM.Filter := 'seasonID =' + SeasonID.ToString;
        tblTEAM.Filtered := True;
      end;
      pgcnrtlSEASONCreate.ActivePage := tbshtTEAM;
    end;
  end;
end;

// TEAM
procedure TfrmSEASONCreate.btnTEAMCreateClick(Sender: TObject);
begin
  pnlTEAMCreate.show;
  pnlTEAMButtons.Hide;
  iCUD := 1;

  edtTeamName.Clear;
end;

procedure TfrmSEASONCreate.btnTEAMDeleteClick(Sender: TObject);
begin
  with dmTagTeam do
  begin
    if tblTEAM['teamID'] <= 0 then
      Showmessage('Please select a record to delete.')
    else if MessageDlg('Are you sure you want to delete the ' +
      tblTEAM['team_name'] + ' team?', mtWarning, [mbOK, mbCancel], 0) = mrOK
    then
      tblTEAM.Delete;
  end;
end;

procedure TfrmSEASONCreate.btnTEAMEditClick(Sender: TObject);
var
  iTeamID: Integer;
begin
  pnlTEAMCreate.show;
  pnlTEAMButtons.Hide;

  btnTEAMCreate.Click;
  iCUD := 2;

  with dmTagTeam do
  begin
    edtTeamName.Text := tblTEAM['team_name'];
  end;
end;

procedure TfrmSEASONCreate.btnTEAMSaveClick(Sender: TObject);
var
  sTeamName: String;
begin
  sTeamName := edtTeamName.Text;

  Team := TTeam.Create(sTeamName, SeasonID);
  if Team.Validate = '' then
  begin
    case iCUD of
      1:
        begin
          Team.InsertTeamRecord;
        end;
      2:
        begin
          Team.UpdateTeamRecord;
        end;
    end;
    btnTEAMCancel.Click;
  end
  else
  begin
    Showmessage(Team.Validate);
    btnTEAMCreate.Click;
  end;

end;

procedure TfrmSEASONCreate.btnTEAMCancelClick(Sender: TObject);
begin
  pnlTEAMButtons.show;
  pnlTEAMCreate.Hide;
  iCUD := 0;
end;

// USER
procedure TfrmSEASONCreate.btnUSERCancelClick(Sender: TObject);
begin
  pnlUSERButtons.show;
  pnlUSERCreate.Hide;
  iCUD := 0;
end;

procedure TfrmSEASONCreate.btnUSERCreateClick(Sender: TObject);
var
  i: Integer;
begin
  pnlUSERCreate.show;
  pnlUSERButtons.Hide;
  iCUD := 1;

  cbbUserTeam.Enabled := True;
  cbbUserTeam.Clear;
  cbbUserTeam.Enabled := True;
  edtFirstName.Clear;
  edtUserSurname.Clear;
  edtEmail.Clear;
  edtCell.Clear;

  Team := TTeam.Create();
  arrTeamID := Team.MakeTeamIDArray;
  with dmTagTeam do
    for i := 0 to Length(arrTeamID) - 1 do
    begin
      tblTEAM.Locate('teamID', arrTeamID[i], []);
      cbbUserTeam.Items.Add(tblTEAM['team_name']);
    end;
end;

procedure TfrmSEASONCreate.btnUSERDeleteClick(Sender: TObject);
begin
  with dmTagTeam do
  begin
    if tblUSER['userid'] <= 0 then
      Showmessage('Please select a record to delete.')
    else if MessageDlg('Are you sure you want to delete user: ' +
      tblUSER['first_name'] + ' ' + tblUSER['surname'] + '?', mtWarning,
      [mbOK, mbCancel], 0) = mrOK then
      tblUSER.Delete;
  end;
end;

procedure TfrmSEASONCreate.btnUSEREditClick(Sender: TObject);
var
  iType: Integer;
  sType: String;
  i, iIndex: Integer;
begin
  pnlUSERCreate.show;
  pnlUSERButtons.Hide;
  iIndex := -1;

  btnUSERCreate.Click;
  iCUD := 2;
  with dmTagTeam do
  begin

    sType := uppercase(tblUSER['type']);

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

    for i := 0 to Length(arrTeamID) - 1 do
    // Find index in arrTeamID to determined itemindex needed
    begin
      if arrTeamID[i] = tblUSER['teamID'] then
        iIndex := i;
    end;

    if iIndex >= 0 then
      cbbUserTeam.ItemIndex := iIndex
    else if cbbUserTeam.Enabled = True then
      Showmessage('ERROR: Team not found');
    iIndex := -1;

    edtFirstName.Text := tblUSER['first_name'];

    edtUserSurname.Text := tblUSER['surname'];

    edtCell.Text := tblUSER['cell_no'];

    edtEmail.Text := tblUSER['email'];
  end;
end;

procedure TfrmSEASONCreate.btnUSERSaveClick(Sender: TObject);
var
  sFirstName, sSurname, sType, sEmail, sCell, sMsg: String;
  iTeam, iSeason, iNum: Integer;
begin
  sFirstName := edtFirstName.Text;
  iSeason := SeasonID;
  sSurname := edtUserSurname.Text;
  sType := uppercase(cbbUserType.Text);
  sEmail := edtEmail.Text;
  sCell := edtCell.Text;
  if Length(arrTeamID) > 0 then
    iTeam := arrTeamID[cbbUserTeam.ItemIndex]
  else
  begin
    Showmessage('Please fill in the teams table before entering users.');
    btnUSERCancel.Click;
    pgcnrtlSEASONCreate.ActivePage := tbshtTEAM;
    Exit
  end;

  if sType = 'JUDGE' then
    iTeam := 0;
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
          edtFirstName.Clear;
          edtUserSurname.Clear;
          edtFirstName.SetFocus;
        end;
    end;
  end;
end;

procedure TfrmSEASONCreate.btnCancelSeasonSetupClick(Sender: TObject);
begin
  if SeasonID >= 1 then
  begin
    with dmTagTeam do
    begin
      tblSEASON.Locate('seasonid', SeasonID, []);
      tblSEASON.Delete;
    end;
  end;
  frmSEASONEdit.show;
  frmSEASONCreate.Hide;

end;

procedure TfrmSEASONCreate.cbbSeasonChange(Sender: TObject);
var
  sCaption: String;
  dStart, dEnd: TDate;
begin
  with dmTagTeam do
  begin
    tblSEASON.Locate('seasonID', SeasonID, []);
    dStart := tblSEASON['season_start'];
    dEnd := tblSEASON['season_end'];

    sCaption := datetostr(dStart) + ' - ' + datetostr(dEnd);
    lblSeasonDates.Caption := sCaption;
  end;
end;

procedure TfrmSEASONCreate.cbbUserTypeChange(Sender: TObject);
begin
  if (cbbUserType.ItemIndex = 2) or (uppercase(cbbUserType.Text) = 'JUDGE') then
  begin
    cbbUserTeam.ItemIndex := -1;
    cbbUserTeam.Enabled := False
  end
  else
    cbbUserTeam.Enabled := True;
end;

// Other
procedure TfrmSEASONCreate.dbgEVENTCellClick(Column: TColumn);
begin
  if pnlEVENTCreate.Visible = True then
    btnEVENTEdit.Click;
end;

procedure TfrmSEASONCreate.dbgSEASONCellClick(Column: TColumn);
begin
  if pnlSEASONCreate.Visible = True then
    btnSEASONEdit.Click;
end;

procedure TfrmSEASONCreate.dbgTEAMCellClick(Column: TColumn);
begin
  if pnlTEAMCreate.Visible = True then
    btnTEAMEdit.Click;
end;

procedure TfrmSEASONCreate.dbgUSERCellClick(Column: TColumn);
begin
  if pnlUSERCreate.Visible = True then
    btnUSEREdit.Click;
end;

procedure TfrmSEASONCreate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;
end;

procedure TfrmSEASONCreate.FormCreate(Sender: TObject);
begin
  pnlSEASONCreate.Hide;
  pnlEVENTCreate.Hide;
  pnlUSERCreate.Hide;
  pnlTEAMCreate.Hide;
end;

procedure TfrmSEASONCreate.FormShow(Sender: TObject);
begin
  tbshtTEAM.TabVisible := False;
  tbshtUSER.TabVisible := False;
  tbshtEvent.TabVisible := False;

  // Season
  dbgSEASON.Columns.Items[0].Title.Caption := 'Season Title';
  dbgSEASON.Columns.Items[0].Width := 120;

  dbgSEASON.Columns.Items[1].Title.Caption := 'Season Start Date';
  dbgSEASON.Columns.Items[1].Width := 170;

  dbgSEASON.Columns.Items[2].Title.Caption := 'Season End Date';
  dbgSEASON.Columns.Items[2].Width := 170;

  // Team
  dbgTEAM.Columns.Items[0].Title.Caption := 'Team Name';

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

end.
