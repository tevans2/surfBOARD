unit UserClass_u;

interface

uses SysUtils, Vcl.Dialogs, ADODB, TagTeamDB_u, TeamClass_u, Validation_u;

// type
// UserType = (Surfer, Judge, Coach, Admin);
type
  TIntArray = array of integer;

type
  TUser = class
  private
    userID: integer;
    UserType: String;
    teamID: integer;
    seasonID: integer;
    username: String;
    password: String;
    first_name: String;
    surname: String;
    cell_no: String;
    email: String;
    function GenerateUsername(first_name, surname, cell_no,
      UserType: String): String;
    function GeneratePassword(UserType: String): String;
  public
    constructor Create(); overload;
    constructor Create(UserType: String; teamID, seasonID: integer;
      first_name, surname, cell_no, email: String); overload;
    constructor CreateFromTextFile(FileName: String);
    function getUserType(): String;
    procedure InsertUserRecord();
    procedure UpdateUserRecord;
    function MakeUserIDArray(): TIntArray;
    function Validate: String;
  end;

const
  arrCharacters: Array [0 .. 7] of String = ('!', '@', '#', '$', '%', '^',
    '&', '*');

implementation

uses CreateSeason_u;

var
  Valid: TValidate;

  { TUSer }

constructor TUser.Create(UserType: string; teamID, seasonID: integer;
  first_name, surname, cell_no, email: String);
begin
  Self.UserType := uppercase(UserType);
  Self.teamID := teamID;
  Self.seasonID := seasonID;
  Self.first_name := first_name;
  Self.surname := surname;
  Self.cell_no := cell_no;
  Self.email := email;

end;

constructor TUser.Create;
begin
end;

constructor TUser.CreateFromTextFile(FileName: String);
var
  UserFile: TextFile;
  sMsg: String;
  sLine, sTeam, sUsername, sPassword, sPath, sErrorMsg: String;
  iPos, iLine: integer;
  Team: TTeam;
begin
  iLine := 0;
  if not fileExists(FileName) then
    Showmessage('ERROR: Specified file doesnt exist')
  else
  begin
    AssignFile(UserFile, FileName);
    reset(UserFile);
    while not Eof(UserFile) do
    begin
      ReadLn(UserFile, sLine);
      inc(iLine);
      sLine := stringReplace(sLine, ' ', '', [rfReplaceAll, rfIgnoreCase]);
      // remove spaces

      iPos := pos(',', sLine);

      Self.UserType := uppercase(Copy(sLine, 1, iPos - 1));
      Delete(sLine, 1, iPos);
      iPos := pos(',', sLine);

      sTeam := uppercase(ExtractFileName(FileName));
      Delete(sTeam, pos('.', sTeam), length(sTeam));
      with dmTagTeam do
      begin
        tblTEAM.First;
        while not tblTEAM.Eof do
        begin
          if (tblTEAM['seasonId'] = frmSEASONCreate.seasonID) AND
            (uppercase(tblTEAM['team_name']) = sTeam) then
          begin
            Self.teamID := tblTEAM['teamID'];
            break
          end
          else
            tblTEAM.Next
        end;
        if Self.teamID < 1 then
        begin
          Showmessage
            ('Choosen Team does not exist, please create the team before adding users.');
        exit
        end;
      end;;

      Self.first_name := Copy(sLine, 1, iPos - 1);
      Delete(sLine, 1, iPos);
      iPos := pos(',', sLine);

      Self.surname := Copy(sLine, 1, iPos - 1);
      Delete(sLine, 1, iPos);
      iPos := pos(',', sLine);

      Self.cell_no := Copy(sLine, 1, iPos - 1);
      Delete(sLine, 1, iPos);
      iPos := pos(',', sLine);
      if iPos = 0 then
        iPos := length(sLine);

      Self.email := Copy(sLine, 1, iPos - 1);
      Delete(sLine, 1, iPos);
      iPos := pos(',', sLine);

      Self.seasonID := frmSEASONCreate.seasonID;

      sMsg := '';
      sMsg := Self.Validate;
      if sMsg = '' then
        InsertUserRecord()
      else
      begin
        Delete(sMsg, 1, 1);
        sErrorMsg := sErrorMsg + sMsg + ' in Line ' + iLine.ToString +
          '. User not added.' + #13#10;
      end;
    end;
    if sErrorMsg = '' then
      Showmessage('Users added succesfully!')
    else
      Showmessage(sErrorMsg);
    CloseFile(UserFile);
  end;

end;

function TUser.GeneratePassword(UserType: String): String;
begin
  Result := uppercase(Copy(UserType, 1, 2)) + inttostr(random(1000) + 1) +
    arrCharacters[random(7)];
end;

function TUser.GenerateUsername(first_name, surname, cell_no,
  UserType: String): String;
begin
  Result := upcase(Self.first_name[1]) + upcase(Self.surname[1]) +
    upcase(Self.UserType[1]) + Copy(Self.cell_no, 7, 10);
end;

function TUser.getUserType: String;
begin
  Result := UserType;
end;

procedure TUser.InsertUserRecord;
begin

  Self.username := GenerateUsername(Self.first_name, Self.surname, Self.cell_no,
    Self.UserType);
  Self.password := GeneratePassword(Self.UserType);
  with dmTagTeam do
  begin
    tblUser.Append;
    tblUser['type'] := UserType;
    tblUser['teamID'] := teamID;
    tblUser['seasonID'] := seasonID;
    tblUser['username'] := username;
    tblUser['password'] := password;
    tblUser['first_name'] := first_name;
    tblUser['surname'] := surname;
    tblUser['cell_no'] := cell_no;
    tblUser['email'] := email;
    tblUser.Post;
  end;
end;

function TUser.MakeUserIDArray: TIntArray;
var
  iCount: integer;
  arrUserID: TIntArray;
begin
  iCount := 0;
  with dmTagTeam do
  begin
    tblUser.First;
    while not tblUser.Eof do
    begin
      inc(iCount);
      SetLength(arrUserID, iCount); // makes array containing userIDs
      arrUserID[iCount - 1] := tblUser['userID'];
      tblUser.Next;
    end;
  end;
  Result := arrUserID;
end;

procedure TUser.UpdateUserRecord;
begin
  with dmTagTeam do
  begin
    tblUser.Edit;
    tblUser['seasonID'] := seasonID;
    tblUser['type'] := UserType;
    tblUser['teamID'] := teamID;
    tblUser['first_name'] := first_name;
    tblUser['surname'] := surname;
    tblUser['cell_no'] := cell_no;
    tblUser['email'] := email;
    tblUser.Post;
  end;
end;

function TUser.Validate: String;
begin
  Valid := TValidate.Create;
  with Valid do
  begin
    if CheckNull(seasonID.ToString) = False then
      Result := '1Invalid Season';

    if CheckNull(UserType) = False then
      Result := '2Invalid User Type';

    if UserType <> 'JUDGE' then
      if CheckNull(teamID.ToString) = False then
        Result := '3Invalid Team';

    if CheckNull(cell_no) = False then
      Result := '4Invalid Cellphone Number';

    if CheckNull(email) = False then
      Result := '5Invalid Email Address';

    if CheckNull(first_name) = False then
      Result := '6Please Enter your name';

    if CheckNull(surname) = False then
      Result := '6Please Enter your name';

    if Result = '' then
    begin
      if dmTagTeam.tblSEASON.Locate('seasonID', seasonID, []) = False then
        Result := '1Invalid Season';

      if CheckUserType(UserType) = False then
        Result := '2Invalid User Type';

      if dmTagTeam.tblTEAM.Locate('teamID', teamID, []) = False then
        Result := '3Invalid Team';

      if (UserType = 'JUDGE') and (teamID > 0) then
        Result := '3Invalid Team';

      if CheckCell(cell_no) = False then
        Result := '4Invalid Cellphone Number';

      if CheckEmail(email) = False then
        Result := '5Invalid Email Address';
    end;

  end;
end;

end.
