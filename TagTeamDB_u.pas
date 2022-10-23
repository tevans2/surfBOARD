unit TagTeamDB_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmTagTeam = class(TDataModule)
    conTagTeam: TADOConnection;
    tblEVENT: TADOTable;
    tblSEASON: TADOTable;
    tblRESULT: TADOTable;
    tblPODIUM: TADOTable;
    tblTEAM: TADOTable;
    tblUSER: TADOTable;
    dscTEAM: TDataSource;
    dscEVENT: TDataSource;
    dscUSER: TDataSource;
    dscRESULT: TDataSource;
    dscPODIUM: TDataSource;
    dscSEASON: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmTagTeam: TdmTagTeam;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
