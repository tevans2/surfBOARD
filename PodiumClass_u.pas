unit PodiumClass_u;

interface

uses SysUtils, Vcl.Dialogs, System.Classes, TagTeamDB_u, Validation_u;

type
  TPodium = Class
  private
    eventID: Integer;
    podium: Integer;
    team1: Integer;
    team2: Integer;
    team3: Integer;
    team4: Integer;
    procedure Make2D(arrTeams: array of Integer);

  public
    constructor Create; overload;
    constructor Create(eventID: Integer; podium: Integer; team1: Integer;
      team2: Integer; team3: Integer; team4: Integer); overload;
    procedure SetupPodiums(seasonID: Integer);
    procedure ShiftPodiums;
    procedure InsertPodiumRecord;
    procedure GetTeams(podium: Integer; var iteam1: Integer;
      var iteam2: Integer; var iteam3: Integer; var iteam4: Integer);
    procedure ConvertToPodiumScores(var iteam1_score: Integer;
      var iteam2_score: Integer; var iteam3_score: Integer;
      var iteam4_score: Integer);

  end;

var
  iTeams, iRoundedTeams, iPodiums: Integer;
  arr2D: array of array of Integer;
  arrTeams: array of Integer;

implementation

var
  Valid: TValidate;

  { TPodium }

constructor TPodium.Create;
begin
end;

procedure TPodium.ConvertToPodiumScores(var iteam1_score, iteam2_score,
  iteam3_score, iteam4_score: Integer);
var
  arrTeamScores: array [1 .. 4] of Integer;
  i, iSwap: Integer;
  j: Integer;
begin
  arrTeamScores[1] := iteam1_score;
  arrTeamScores[2] := iteam2_score;
  arrTeamScores[3] := iteam3_score;
  arrTeamScores[4] := iteam4_score;

  for i := 1 to 4 do
    for j := 1 to 4 do
      if arrTeamScores[i] < arrTeamScores[j] then
      begin
        iSwap := arrTeamScores[i];
        arrTeamScores[i] := arrTeamScores[j];
        arrTeamScores[j] := iSwap;
      end;

  for i := 1 to 4 do
  begin
    if arrTeamScores[i] = iteam1_score then
      iteam1_score := i;

    if arrTeamScores[i] = iteam2_score then
      iteam2_score := i;

    if arrTeamScores[i] = iteam3_score then
      iteam3_score := i;

    if arrTeamScores[i] = iteam4_score then
      iteam4_score := i;
  end;

  // 1000, 860, 730, 670
  case iteam1_score of
    1:
      iteam1_score := 670;
    2:
      iteam1_score := 730;
    3:
      iteam1_score := 860;
    4:
      iteam1_score := 1000;
  end;

    case iteam2_score of
    1:
      iteam2_score := 670;
    2:
      iteam2_score := 730;
    3:
      iteam2_score := 860;
    4:
      iteam2_score := 1000;
  end;

    case iteam3_score of
    1:
      iteam3_score := 670;
    2:
      iteam3_score := 730;
    3:
      iteam3_score := 860;
    4:
      iteam3_score := 1000;
  end;

    case iteam4_score of
    1:
      iteam4_score := 670;
    2:
      iteam4_score := 730;
    3:
      iteam4_score := 860;
    4:
      iteam4_score := 1000;
  end;
end;

constructor TPodium.Create(eventID, podium, team1, team2, team3,
  team4: Integer);
begin
  Self.eventID := eventID;
  Self.podium := podium;
  Self.team1 := team1;
  Self.team2 := team2;
  Self.team3 := team3;
  Self.team4 := team4;
end;

procedure TPodium.GetTeams(podium: Integer; var iteam1, iteam2, iteam3,
  iteam4: Integer);
var
  i: Integer;
begin
  iteam1 := arr2D[0, podium - 1];
  iteam2 := arr2D[1, podium - 1];
  iteam3 := arr2D[2, podium - 1];
  iteam4 := arr2D[3, podium - 1];

end;

procedure TPodium.InsertPodiumRecord;
begin
  with dmTagTeam do
  begin
    tblPODIUM.Append;
    tblPODIUM['eventID'] := eventID;
    tblPODIUM['podium'] := podium;
    tblPODIUM['team1'] := team1;
    tblPODIUM['team2'] := team2;
    tblPODIUM['team3'] := team3;
    tblPODIUM['team4'] := team4;
    tblPODIUM.Post;
  end;
end;

procedure TPodium.Make2D(arrTeams: array of Integer);
var
  iRow: Integer;
  iCol: Integer;
  iNum: Integer;
  i: Integer;
begin
  Setlength(arr2D, 4, iPodiums);
  iNum := 0;
  for iRow := 0 to 4 - 1 do
    for iCol := 0 to iPodiums - 1 do
    begin
      arr2D[iRow, iCol] := arrTeams[iNum];
      inc(iNum);
    end;
end;

procedure TPodium.SetupPodiums(seasonID: Integer);
var
  iRow: Integer;
  iCol: Integer;
  i, iNum: Integer;
begin
  // iTeams from tblTeam
  iTeams := 0;
  iNum := 0;

  with dmTagTeam do
  begin
    tblTEAM.First;
    while not tblTEAM.Eof do
    begin
      if tblTEAM['seasonID'] = seasonID then
        inc(iTeams);
      tblTEAM.Next;
    end;
  end;

  if iTeams < 4 then
  begin
    Showmessage('Not enough teams, please add more');
    exit
  end;

  if iTeams mod 4 <> 0 then // Works out number of podiums required
  begin
    iPodiums := trunc(iTeams / 4);
    iPodiums := iPodiums + 1;
  end
  else
    iPodiums := iTeams div 4;

  iRoundedTeams := iPodiums * 4;
  // Number of teams rounded up to nearest multiple of 4 (adds empty teams)

  Setlength(arrTeams, iRoundedTeams);

  for i := 0 to length(arrTeams) do // Sets array to all zeros
    arrTeams[i] := 0;

  if length(arrTeams) > iTeams then
    with dmTagTeam do
    begin
      tblTEAM.First;
      while not tblTEAM.Eof do
      begin
        if tblTEAM['seasonID'] = seasonID then
        begin
          arrTeams[iNum] := tblTEAM['teamid'];
          inc(iNum);
        end;
        tblTEAM.Next;
      end;
    end
  else
  begin
    Showmessage('arrTeamsError, check podium class');
    exit
  end;

  Make2D(arrTeams); // puts the team list into an (#podiums)x4 matrix
end;

procedure TPodium.ShiftPodiums;
var
  iRow, iCol: Integer;
  iMaxRow, iMaxCol, iEnd: Integer;
  i: Integer;
begin
  iEnd := arrTeams[high(arrTeams)];
  for i := length(arrTeams) - 1 downto 0 do
    // Moves all numbers 1 down in array
    arrTeams[i] := arrTeams[i - 1];

  arrTeams[0] := 1; // replaces the first number
  arrTeams[1] := iEnd; // moves the number prev. in last pos to 2nd pos

  Make2D(arrTeams); // puts the team list into an (#podiums)x4 matrix
end;

end.
