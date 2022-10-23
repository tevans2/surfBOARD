unit SeasonClass_u;

interface

uses SysUtils, Vcl.Dialogs, ADODB, TagTeamDB_u, TeamClass_u, Validation_u;

type
  TIntArray = Array of Integer;

type
  TSeason = Class
  private
    seasonid: Integer;
    season_start: TDate;
    season_end: TDate;
  public
    constructor Create(); overload;
    constructor Create(season_start, season_end: TDate); overload;
    function MakeSeasonIDArray(): TIntArray;
    procedure InsertSeasonRecord;
    procedure UpdateSeasonRecord;
    function Validate: String;
  End;

implementation

var
  Valid: TValidate;

  { TSeason }

constructor TSeason.Create;
begin
end;

constructor TSeason.Create(season_start, season_end: TDate);
var
  iSeasonID: Integer;
begin
  with dmTagTeam do
  begin
    tblSEASON.First;
    iSeasonID := 0;
    while not tblSEASON.Eof do
    begin
      if tblSEASON['seasonid'] > iSeasonID then
        iSeasonID := tblSEASON['seasonid'];
      tblSEASON.Next;
    end;
    Self.seasonid := iSeasonID + 1;
  end;
  Self.season_start := season_start;
  Self.season_end := season_end;
end;

procedure TSeason.InsertSeasonRecord;
begin
  with dmTagTeam do
  begin
    tblSEASON.Append;
    tblSEASON['seasonID'] := seasonid;
    season_start := Trunc(season_start);
    tblSEASON['season_start'] := season_start;

    season_end := Trunc(season_end);
    tblSEASON['season_end'] := season_end;

    tblSEASON.Post;
  end;
end;

function TSeason.MakeSeasonIDArray: TIntArray;
var
  iCount: Integer;
  arrSeasonID: TIntArray;
begin
  iCount := 0;
  with dmTagTeam do
  begin
    tblSEASON.First;
    while not tblSEASON.Eof do
    begin
      inc(iCount);
      SetLength(arrSeasonID, iCount); // makes array containing userIDs
      arrSeasonID[iCount - 1] := tblSEASON['seasonID'];
      tblSEASON.Next;
    end;
  end;
  Result := arrSeasonID;
end;

procedure TSeason.UpdateSeasonRecord;
begin
  with dmTagTeam do
  begin
    tblSEASON.Edit;
    season_start := Trunc(season_start);
    tblSEASON['season_start'] := season_start;

    season_end := Trunc(season_end);
    tblSEASON['season_end'] := season_end;

    tblSEASON.Post;
  end;
end;

function TSeason.Validate: String;
begin
  Valid := TValidate.Create;
  with Valid do
  begin
    if CheckDates(season_start, season_end) = True then
      Result := ''
    else
      Result := 'Dates are incorrectly entered';
  end;
end;

end.
