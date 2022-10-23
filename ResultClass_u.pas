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
    constructor Create(UserID, eventID, teamID, judgeID: integer;
      UserResult: real);
    procedure InsertResultRecord;
    procedure UpdateResultRecord;
    function Validate: String;

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

procedure TResult.InsertResultRecord;
begin
  with dmTagTeam do
  begin
    tblResult.Append;
    tblResult['userid'] := UserID;
    tblResult['eventID'] := eventID;
    tblResult['teamID'] := teamID;
    tblResult['judgeID'] := judgeID;
    tblResult['result'] := UserResult;
    tblResult.Post;
  end;
end;

procedure TResult.UpdateResultRecord;
begin
  with dmTagTeam do
  begin
    tblResult.Edit;
    tblResult['userid'] := UserID;
    tblResult['eventID'] := eventID;
    tblResult['teamID'] := teamID;
    tblResult['judgeID'] := judgeID;
    tblResult['result'] := UserResult;
    tblResult.Post;
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
      result := '1Invalid User';

    if CheckNull(eventID.ToString) = false then
      result := '2Invalid Event';

    if CheckNull(teamID.ToString) = false then
      result := '3Invalid Team';

    if CheckNull(judgeID.ToString) = false then
      result := '4Invalid Judge';

    if CheckNull(iUserResult.ToString) = false then
      result := '5Invalid Result';

    if result = '' then
    begin
      if dmTagTeam.tblUSER.Locate('userID', UserID, []) = false then
        result := '1Invalid User';

      if dmTagTeam.tblEVENT.Locate('eventID', eventID, []) = false then
        result := '2Invalid Event';

      if dmTagTeam.tblTEAM.Locate('teamID', teamID, []) = false then
        result := '3Invalid Team';

      if dmTagTeam.tblUSER.Locate('userID', JudgeID, []) = false then
        result := '4Invalid Judge';

      if CheckResult(iUserResult.ToString) = false then
        result := '5Invalid Result';

    end;
  end;
end;

end.
