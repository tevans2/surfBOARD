unit TeamClass_u;

interface

uses SysUtils, ADODB, Vcl.Dialogs, System.Classes, TagTeamDB_u, Validation_u;

type
  TIntArray = Array of integer;

type
  TTeam = class
  private
    teamid: integer;
    team_name: String;
    seasonID: integer;

    function getTeamID: integer;
  public
    constructor Create(); overload;
    constructor Create(team_name: String; seasonID: integer); overload;
    constructor CreateFromID(teamid: integer);
    procedure InsertTeamRecord; overload;
    procedure InsertTeamRecord(iSeasonID, iTeamid: integer;
      sTeam_name: String); overload;
    procedure UpdateTeamRecord;
    function getTeamName(): String;
    function getTeamCoach(): integer;
    function MakeTeamIDArray(): TIntArray;
    function Validate: String;
    procedure CopyOverTeams(ToSeason, FromSeason: integer);
    procedure AddTeamScore(team_score, teamid: integer);
  end;

implementation

var
  Valid: TValidate;
  { TTeam }

procedure TTeam.AddTeamScore(team_score, teamid: integer);
var
  i: integer;
begin
  with dmTagTeam do
  begin
    tblTEAM.Locate('teamid', teamid, []);
    i := tblTEAM['teamId'];
    tblTEAM.Edit;
    tblTEAM['team_score'] := tblTEAM['team_score'] + team_score;
    tblTEAM.Post;
  end;
end;

procedure TTeam.CopyOverTeams(ToSeason, FromSeason: integer);
var
  sTeamName: string;
  iTeamid, num, i, iTeamRecords: integer;
begin
  num := 0;

  with dmTagTeam do
  begin
    tblTEAM.Filtered := False;
    iTeamRecords := tblTEAM.RecordCount;
    if tblTEAM.Locate('seasonID', FromSeason, []) = True then
    begin
      tblTEAM.First;
      for i := 1 to iTeamRecords do
      begin

        tblTEAM.Locate('teamid', i, []);
        num := tblTEAM['seasonID'];
        if num = FromSeason then
        begin
          sTeamName := tblTEAM['team_name'];
          iTeamid := getTeamID;
          InsertTeamRecord(ToSeason, iTeamid, sTeamName);
        end;
      end;
    end;

  end;
end;

constructor TTeam.Create(team_name: String; seasonID: integer);
begin
  Self.teamid := getTeamID;
  Self.team_name := team_name;
  Self.seasonID := seasonID;
end;

constructor TTeam.Create;
begin
end;

constructor TTeam.CreateFromID(teamid: integer);
begin
  with dmTagTeam do
  begin
    if tblTEAM.Locate('teamID', teamid, []) = True then
    begin
      Self.team_name := tblTEAM['team_name'];
      Self.seasonID := tblTEAM['seasonID'];
    end
    else
      Showmessage('ERROR: Team does not exist');
  end;
end;

function TTeam.getTeamCoach: integer;
var
  iTeamid, i: integer;
begin
  i := 0;
  with dmTagTeam do
  begin
    if tblTEAM.Locate('team_name', team_name, []) = True then
      iTeamid := tblTEAM['teamID'];

    tblUser.Filter := 'teamID =' + QuotedStr(iTeamid.ToString);
    tblUser.Filtered := True;
    while not tblUser.Eof do
    begin
      if tblUser['User_type'] = 'Coach' then
        Result := (tblUser['userID']);
      tblUser.Next;
    end;
    tblUser.Filtered := False;
  end;
end;

function TTeam.getTeamID: integer;
var
  iTeamid: integer;
begin
  with dmTagTeam do
  begin
    tblTEAM.Refresh;
    tblTEAM.First;
    iTeamid := 0;
    while not tblTEAM.Eof do
    begin
      if tblTEAM['teamID'] > iTeamid then
        iTeamid := tblTEAM['teamID'];
      tblTEAM.Next;
    end;
    Result := iTeamid + 1;
  end;
end;

// function TTeam.getTeamMembers: TIntArray;
// var
// iTeamID, i: integer;
// begin
// i := 0;
// with dmTagTeam do
// begin
// if tblTeam.Locate('team_name', team_name, []) = True then
// iTeamID := tblTeam['teamID'];
//
// tblUser.Filter := 'teamID =' + QuotedStr(iTeamID.ToString);
// tblUser.Filtered := True;
// while not tblUser.Eof do
// begin
// Setlength(Result, i + 1);
// if tblUser['User_type'] = 'Surfer' then
// Result[i] := (tblUser['userID']);
// tblUser.Next;
// inc(i);
// end;
// tblUser.Filtered := False;
// end;
// end;

function TTeam.getTeamName: String;
begin
  Result := Self.team_name;
end;

procedure TTeam.InsertTeamRecord(iSeasonID, iTeamid: integer;
  sTeam_name: String);
begin
  with dmTagTeam do
  begin
    tblTEAM.Append;
    tblTEAM['teamID'] := iTeamid;
    tblTEAM['team_name'] := sTeam_name;
    tblTEAM['seasonID'] := iSeasonID;
    tblTEAM.Post;
  end;
end;

procedure TTeam.InsertTeamRecord;
begin
  with dmTagTeam do
  begin
    tblTEAM.Append;
    tblTEAM['teamID'] := teamid;
    tblTEAM['team_name'] := team_name;
    tblTEAM['seasonID'] := seasonID;
    tblTEAM['team_score'] := 0;
    tblTEAM.Post;
  end;
end;

function TTeam.MakeTeamIDArray: TIntArray;
var
  iCount, i: integer;
  arrTeamID: TIntArray;
begin
  iCount := 0;
  with dmTagTeam do
  begin
    tblTEAM.First;
    while not tblTEAM.Eof do
    begin
      inc(iCount);
      SetLength(arrTeamID, iCount); // makes array containing TeamIDs
      arrTeamID[iCount - 1] := tblTEAM['teamID'];
      tblTEAM.Next;
    end;
  end;
  Result := arrTeamID;
end;

procedure TTeam.UpdateTeamRecord;
begin
  with dmTagTeam do
  begin
    tblTEAM.Edit;
    tblTEAM['team_name'] := team_name;
    tblTEAM.Post;
  end;
end;

function TTeam.Validate: String;
begin
  Valid := TValidate.Create;
  with Valid do
  begin
    if (CheckNull(team_name)) then
      Result := ''
    else
      Result := 'Please re enter team name';

    with dmTagTeam do
      if tblTEAM.Locate('team_name', team_name, []) = True then
        Result := 'Team already exists';

  end;

end;

end.
