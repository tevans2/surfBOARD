unit Login_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCrypt,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnLOGIN: TButton;
    imgHide: TImage;
    imgShow: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnLOGINClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgShowClick(Sender: TObject);
    procedure imgHideClick(Sender: TObject);
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
var
  sUsernameIn, sPasswordIn, sPinIn, sLoginIn, sHash: String;
  sUsername, sPassword: String;
  PasswordRehashNeeded: Boolean;
  txtLogin: Textfile;
begin

  sUsernameIn := edtUsername.Text;
  if sUsernameIn = '' then // Input Validation, ensures input is not empty
  begin
    Showmessage('No Username Input, try again.'); // Show error on empty input
    edtUsername.Clear;
  end;

  sPasswordIn := edtPassword.Text;
  if sPasswordIn = '' then // Input Validation, ensures input is not empty
  begin
    Showmessage('No Password Input, try again.'); // Show error on empty input
    edtPassword.Clear;
  end;

  if FileExists('Login_Info.txt') then
  begin
    AssignFile(txtLogin, 'Login_Info.txt');
    reset(txtLogin);
    readln(txtLogin, sUsername); // Loads correct username form file
    readln(txtLogin, sHash); // Loads password hash from file
    closefile(txtLogin);
  end
  else
    Showmessage('File not found.');

  if (sUsernameIn = sUsername) AND
  // Checks input Username and actual Username is correct
    (TBCrypt.CheckPassword(sPasswordIn, sHash, { out } PasswordRehashNeeded))
  then // Checks Passsword hash
  BEGIN // On correct login:
    edtUsername.Clear;
    edtPassword.Clear;
    Application.ShowMainForm := true;
    frmSEASONEdit.Show;
  END
  else // On incoreect login:
  begin
    edtPassword.Clear; // Reset edits
    Showmessage('ERROR: Incorrect username or password. Try again');
    // Show error
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  self.Show;
  imgHide.Hide;
end;

procedure TfrmLogin.imgHideClick(Sender: TObject);
begin
  imgShow.Show;
  imgHide.Hide;
  edtPassword.PasswordChar := '*'; // Sets password to viible text
end;

procedure TfrmLogin.imgShowClick(Sender: TObject);
begin
  imgShow.Hide;
  imgHide.Show;
  edtPassword.PasswordChar := #0; // Sets password to viible text
end;

end.
