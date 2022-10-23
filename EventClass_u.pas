unit EventClass_u;

interface

uses SysUtils, StrUtils, Vcl.Dialogs, TagTeamDB_u, Vcl.StdCtrls, DateUtils,
  Validation_u,
  PodiumClass_u;

type
  TIntArray = array of integer;

type
  TEvent = Class
  private
    seasonID: integer;
    location: String;
    event_name: String;
    event_date: TDate;

  public
    constructor Create(); overload;
    constructor Create(location, event_name: String; event_date: TDate;
      seasonID: integer); overload;
    procedure InsertEventRecord; overload;
    procedure InsertEventRecord(seasonID: integer; event_date: TDate); overload;
    procedure UpdateEventRecord;
    function MakeEventIDArray(): TIntArray;
    function Validate: String;
    procedure CreateEventSchedule(seasonID: integer; var bSuccess: Boolean);
  End;

implementation

uses CreateSeason_u;

var
  Valid: TValidate;
  Podium: TPodium;

  { TEvent }

constructor TEvent.Create(location, event_name: String; event_date: TDate;
  seasonID: integer);
begin
  Self.location := location;
  Self.event_name := event_name;
  Self.event_date := event_date;
  Self.seasonID := seasonID;
end;

procedure TEvent.CreateEventSchedule(seasonID: integer; var bSuccess: Boolean);
var
  dStart, dEnd: TDate;
  sEventDay: String;
  iDay: integer;
  arrDay: array [1 .. 7] of string;
  bFound: Boolean;
  i: integer;
begin
  bSuccess := True;
  with dmTagTeam do
  begin
    tblSEASON.Locate('seasonid', seasonID, []);
    dStart := tblSEASON['season_start'];
    dEnd := tblSEASON['season_end'];
    iDay := 0;

    arrDay[1] := 'SUNDAY';
    arrDay[2] := 'MONDAY';
    arrDay[3] := 'TUESDAY';
    arrDay[4] := 'WEDNESDAY';
    arrDay[5] := 'THURSDAY';
    arrDay[6] := 'FRIDAY';
    arrDay[7] := 'SATERDAY';
    sEventDay := Uppercase(InputBox('Select Event Day',
      'Enter the day which events will occur:' + #13#10 +
      '(Day name must be written in full. eg. Friday)',
      'Friday'));

    if MatchStr(sEventDay, arrDay) then
    begin
      for i := 1 to length(arrDay) do
        if sEventDay = arrDay[i] then
          iDay := i;

      repeat
        if Dayofweek(dStart) = iDay then
          bFound := True
        else
          dStart := incday(dStart, 1);

      until bFound = True;

      while dStart <= dEnd do
      begin
        if dStart <= dEnd then
        begin
          InsertEventRecord(seasonID, dStart);
          dStart := incday(dStart, 14);
        end;
      end;
    end
    else
    begin
      Showmessage
        ('Please re enter the event day. Use the full name of the day. eg. Saterday');
      bSuccess := False;
    end;
  end;
end;

procedure TEvent.InsertEventRecord(seasonID: integer; event_date: TDate);
begin
  with dmTagTeam do
  begin
  tblEvent.Insert;
  event_date := Trunc(event_date);
  tblEvent['event_date'] := event_date;
  tblEvent['seasonID'] := seasonID;
  tblEvent.Post;
  end;
end;

constructor TEvent.Create;
begin
end;

procedure TEvent.InsertEventRecord;
var
  i, iPodiumEventID, iPodiumNumber: integer;
  iTeam1, iTeam2, iTeam3, iTeam4: integer;
begin
  with dmTagTeam do
  begin
    tblEvent.Insert;

    event_date := Trunc(event_date);
    tblEvent['event_date'] := event_date;
    tblEvent['seasonID'] := seasonID;
    tblEvent.Post;

    // for i := 1 to PodiumClass_u.iPodiums do
    // begin
    // iPodiumEventID := tblEvent['eventID'];
    // iPodiumNumber := i;
    // Podium := TPodium.Create;
    // Podium.GetTeams(iPodiumNumber, iTeam1, iTeam2, iTeam3, iTeam4);
    //
    // Podium.Create(iPodiumEventID, iPodiumNumber, iTeam1, iTeam2,
    // iTeam3, iTeam4);
    // Podium.InsertPodiumRecord;
    //
    // end;
    // Podium.ShiftPodiums;

  end;

end;

function TEvent.MakeEventIDArray: TIntArray;
var
  iCount: integer;
  arrEventID: TIntArray;
begin
  with dmTagTeam do
  begin
    iCount := 0;
    tblEvent.First;
    while not tblEvent.Eof do
    begin
      inc(iCount);
      SetLength(arrEventID, iCount); // makes array containing eventIDs
      arrEventID[iCount - 1] := tblEvent['eventID'];
      tblEvent.Next;
    end;
  end;
  Result := arrEventID
end;

procedure TEvent.UpdateEventRecord;
begin
  with dmTagTeam do
  begin
    tblEvent.Edit;
    tblEvent['location'] := location;
    tblEvent['event_name'] := event_name;

    event_date := Trunc(event_date);
    tblEvent['event_date'] := event_date;
    tblEvent['seasonID'] := seasonID;
    tblEvent.Post;
  end;
end;

function TEvent.Validate: String;
begin
  Valid := TValidate.Create;
  with Valid do
  begin
    if CheckNull(seasonID.ToString) = False then
      Result := '1Invalid Season';

    if Result = '' then
    begin
      if dmTagTeam.tblSEASON.Locate('seasonID', seasonID, []) = False then
        Result := '1Invalid Season';

      if CheckEventDate(event_date, seasonID) = False then
        Result := '4Event Date not in season ' + seasonID.ToString;
    end;
  end;
end;

end.
