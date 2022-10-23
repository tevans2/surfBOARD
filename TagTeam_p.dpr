program TagTeam_p;

uses
  Vcl.Forms,
  CreateSeason_u in 'CreateSeason_u.pas' {frmSEASONCreate},
  TagTeamDB_u in 'TagTeamDB_u.pas' {dmTagTeam: TDataModule},
  EditSeason_u in 'EditSeason_u.pas' {frmSEASONEdit},
  Login_u in 'Login_u.pas' {frmLogin},
  UserClass_u in 'UserClass_u.pas',
  TeamClass_u in 'TeamClass_u.pas',
  EventClass_u in 'EventClass_u.pas',
  ResultClass_u in 'ResultClass_u.pas',
  PodiumClass_u in 'PodiumClass_u.pas',
  SeasonClass_u in 'SeasonClass_u.pas',
  Validation_u in 'Validation_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSEASONEdit, frmSEASONEdit);
  Application.CreateForm(TfrmSEASONCreate, frmSEASONCreate);
  Application.CreateForm(TdmTagTeam, dmTagTeam);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
