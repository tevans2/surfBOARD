unit ResultClass_u;

interface

uses SysUtils, Vcl.Dialogs, System.Classes, TagTeamDB_u, Validation_u;

type
  TResult = Class
  private
    UserID: integer;
    eventID: integer;
    teamID: integer;
    judgeID: integer;
    UserResult: real;

  public
    constructor Create; overload;
    constructor Create(UserID, eventID, teamID, judgeID: integer;
      UserResult: real); overload;
    procedure InsertResultRecord;
    procedure UpdateResultRecord;
    function Validate: String;
    function CreateResultFilter(SeasonID: integer): String;

  End;

implementation

var
  Valid: TValidate;

  { TResult }

  { TResult }

constructor TResult.Create(UserID, eventID, teamID, judgeID: integer;
  UserResult: real);
begin
  Self.UserID := UserID;
  Self.eventID := eventID;
  Self.teamID := teamID;
  Self.judgeID := judgeID;
  Self.UserResult := UserResult;
end;

constructor TResult.Create;
begin

end;

function TResult.CreateResultFilter(SeasonID: integer): String;
var
  sResultFilter: String;
  iResultEvent: integer;
begin
  with dmTagTeam do
  begin
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

    Result := sResultFilter;
  end;
end;

procedure TResult.InsertResultRecord;
begin
  with dmTagTeam do
  begin
    tblRESULT.Append;
    tblRESULT['userid'] := UserID;
    tblRESULT['eventID'] := eventID;
    tblRESULT['teamID'] := teamID;
    tblRESULT['judgeID'] := judgeID;
    tblRESULT['result'] := UserResult;
    tblRESULT.Post;
  end;
end;

procedure TResult.UpdateResultRecord;
begin
  with dmTagTeam do
  begin
    tblRESULT.Edit;
    tblRESULT['userid'] := UserID;
    tblRESULT['eventID'] := eventID;
    tblRESULT['teamID'] := teamID;
    tblRESULT['judgeID'] := judgeID;
    tblRESULT['result'] := UserResult;
    tblRESULT.Post;
  end;
end;

function TResult.Validate: String;
var
  iUserResult: integer;
begin
  Valid := TValidate.Create;
  iUserResult := trunc(UserResult * 10);
  with Valid do
  begin
    if CheckNull(UserID.ToString) = false then
      Result := '1Invalid User';

    if CheckNull(eventID.ToString) = false then
      Result := '2Invalid Event';

    if CheckNull(teamID.ToString) = false then
      Result := '3Invalid Team';

    if CheckNull(judgeID.ToString) = false then
      Result := '4Invalid Judge';

    if CheckNull(iUserResult.ToString) = false then
      Result := '5Invalid Result';

    if Result = '' then
    begin
      if dmTagTeam.tblUSER.Locate('userID', UserID, []) = false then
        Result := '1Invalid User';

      if dmTagTeam.tblEVENT.Locate('eventID', eventID, []) = false then
        Result := '2Invalid Event';

      if dmTagTeam.tblTEAM.Locate('teamID', teamID, []) = false then
        Result := '3Invalid Team';

      if dmTagTeam.tblUSER.Locate('userID', judgeID, []) = false then
        Result := '4Invalid Judge';

      if CheckResult(iUserResult.ToString) = false then
        Result := '5Invalid Result';

    end;
  end;
end;

end.
