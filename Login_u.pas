unit Login_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnLOGIN: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnLOGINClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses EditSeason_u;
procedure TfrmLogin.btnLOGINClick(Sender: TObject);
begin
  Application.ShowMainForm := true;
  frmSEASONEdit.Show;

end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  self.Show;
end;

end.
