unit Validation_u;

interface

uses SysUtils, Vcl.Dialogs, TagTeamDB_u;

type
  TValidate = Class
  private
  public
    constructor Create;
    function CheckNull(InputStr: String): Boolean;
    function CheckLength(InputStr: String; iLength: Integer): Boolean;
    function CheckStr(InputStr: String): Boolean;
    function CheckInt(InputStr: String): Boolean;
    function CheckDates(Date1, Date2: TDate): Boolean;
    function CheckEventDate(Date: TDate; SeasonID: Integer): Boolean;
    function CheckUserType(InputStr: String): Boolean;
    function CheckEmail(InputStr: String): Boolean;
    function CheckCell(InputStr: String): Boolean;
    function CheckResult(InputStr: String): Boolean;
    // function CheckStr(InputStr: String): Boolean;
    // function CheckStr(InputStr: String): Boolean;
  end;

implementation

{ Validate }

function TValidate.CheckCell(InputStr: String): Boolean;
var
  Valid: TValidate;
  iPos: Integer;
begin
  iPos := pos(' ', InputStr);
  if iPos = 0 then
  begin
    Result := True;
    try
      strtoint(InputStr);
    except
      Result := False;
      exit
    end;

    if Length(InputStr) = 10 then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
end;

function TValidate.CheckDates(Date1, Date2: TDate): Boolean;
begin
  if Date2 > Date1 then
    Result := True
  else
    Result := False;
end;

function TValidate.CheckEmail(InputStr: String): Boolean;
var
  i, iAt, iDot, iAtPos, iDotPos, iPos: Integer;
  sIn: String;
begin
  sIn := UpperCase(InputStr);
  iAt := 0;
  iDot := 0;

  iPos := pos(' ', InputStr);
  if iPos = 0 then
  begin
    for i := 1 to Length(sIn) do
    begin
      if sIn[i] = '@' then
        inc(iAt);
      if sIn[i] = '.' then
        inc(iDot);
    end;

  if (iAt <> 1) or (iDot = 0) then
  begin
    Result := False;
    Exit
  end
  else
  begin
    iAtPos := pos('@', sIn);

    if (iAtPos > 1) and (iAtPos < Length(sIn)) then
      Result := True
    else
    begin
      Result := False;
    end;
  end;

  for i := 1 to iDot do
  begin
    iDotPos := pos('.', sIn);
    if (iDotPos > 1) and (iDotPos < Length(sIn)) then
      Result := True
    else
    begin
      Result := False;
    end;
    Delete(sIn, iDotPos, 1);
  end;
  end
  else
  Result := False;
end;

function TValidate.CheckEventDate(Date: TDate; SeasonID: Integer): Boolean;
var
  SeasonStart, SeasonEnd: TDate;
begin
  with dmTagTeam do
  begin
    try
      tblSEASON.Locate('seasonID', SeasonID, []);
    except
      Exit
    end;

    SeasonStart := tblSEASON['season_start'];
    SeasonEnd := tblSEASON['season_end'];

    if (SeasonStart <= Date) and (Date <= SeasonEnd) then
      Result := True
    else
      Result := False;
  end;
end;

function TValidate.CheckInt(InputStr: String): Boolean;
begin
  Result := True;
  try
    strtoint(InputStr);
  except
    Result := False;
  end;
end;

function TValidate.CheckLength(InputStr: String; iLength: Integer): Boolean;
begin
  if Length(InputStr) = iLength then
    Result := True
  else
    Result := False;
end;

function TValidate.CheckNull(InputStr: String): Boolean;
begin
  if InputStr = '' then
    Result := False
  else
    Result := True;
end;

function TValidate.CheckResult(InputStr: String): Boolean;
var
  iIn: Integer;
begin
  Result := True;
  try
    iIn := strtoint(InputStr);
  except
    Result := False;
    Exit
  end;

  if not(iIn <= 100) and (iIn > 0) then
  begin
    Result := False;
    Exit
  end;

end;

function TValidate.CheckStr(InputStr: String): Boolean;
var
  i: Integer;
begin
  InputStr := UpperCase(InputStr);
  Result := True;

  InputStr := StringReplace(InputStr, ' ', '', [rfReplaceAll]);

  for i := 1 to Length(InputStr) do
    if not(InputStr[i] in ['A' .. 'Z']) then
      Result := False;
end;

function TValidate.CheckUserType(InputStr: String): Boolean;
begin
  if (InputStr = 'SURFER') OR (InputStr = 'COACH') OR (InputStr = 'JUDGE') then
    Result := True
  else
    Result := False;

end;

constructor TValidate.Create;
begin
end;

end.
