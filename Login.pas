unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Admin, Lessee, Lessor, Manager;
// added names of other units so that changing between forms can be done

// "lse" = "lessee"
// "lsr" = "lessor"
// "admn" = "admin"
// "lgn" = "login" also called "sign in" on form
// "sgn" = "sign up"
type
  TFrmLogin = class(TForm)
    BtnSignUp: TButton;
    BtnLogin: TButton;
    procedure BtnSignUpClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);

    procedure btnLseSgnWhnClckd(Sender: TObject);
    procedure btnLsrSgnWhnClckd(Sender: TObject);
    procedure btnLseLgnWhnClckd(Sender: TObject);
    procedure btnLsrLgnWhnClckd(Sender: TObject);
    procedure btnADMNLgnWhnClckd(Sender: TObject);
    procedure btnChangeFormWhnClckd(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure edtsandlabels(iIn: integer);
  public
    //
  end;

var
  FrmLogin: TFrmLogin;

  // objects :
  btnLessee: TButton;
  btnLessor: TButton;
  btnAdminLogin: TButton;

  btnEnter: TButton;

  edtUsername: TEdit;
  lblUsername: TLabel;
  edtPassword: TEdit;
  lblPassword: TLabel;

  edtChckPsswrd: TEdit;
  lblChckPsswrd: TLabel;
  edtEmail: TEdit;
  lblEmail: TLabel;

  // global variables
  iTypeLoginSignup: integer;

implementation

{$R *.dfm}
// =============================================================================

procedure TFrmLogin.BtnSignUpClick(Sender: TObject);
begin

  btnLessee := TButton.Create(FrmLogin);
  with btnLessee do
  begin
    Height := 25;
    width := 184;
    Top := 8;
    Left := 8;
    Parent := FrmLogin;
    Caption := 'Lessee Sign Up';
    OnClick := btnLseSgnWhnClckd;
  end;

  btnLessor := TButton.Create(FrmLogin);
  with btnLessor do
  begin
    Height := btnLessee.Height;
    width := btnLessee.width;
    Top := btnLessee.Top + 40;
    Left := btnLessee.Left;
    Parent := FrmLogin;
    Caption := 'Lessor Sign Up';
    OnClick := btnLsrSgnWhnClckd;
  end;

  BtnSignUp.visible := false;
  BtnLogin.visible := false;
end;

// =============================================================================

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  btnLessee := TButton.Create(FrmLogin);
  with btnLessee do
  begin
    Height := 25;
    width := 184;
    Top := 8;
    Left := 8;
    Parent := FrmLogin;
    Caption := 'Lessee Sign In';
    OnClick := btnLseLgnWhnClckd;
  end;

  btnLessor := TButton.Create(FrmLogin);
  with btnLessor do
  begin
    Height := btnLessee.Height;
    width := btnLessee.width;
    Top := btnLessee.Top + 40;
    Left := btnLessee.Left;
    Parent := FrmLogin;
    Caption := 'Lessor Sign In';
    OnClick := btnLsrLgnWhnClckd;
  end;

  btnAdminLogin := TButton.Create(FrmLogin);
  with btnAdminLogin do
  begin
    Caption := 'Admin Sign In';
    Height := btnLessee.Height;
    width := btnLessee.width;
    Top := btnLessor.Top + 40;
    Left := btnLessee.Left;
    Parent := FrmLogin;
    OnClick := btnADMNLgnWhnClckd;
  end;

  FrmLogin.Height := 164;

  BtnSignUp.visible := false;
  BtnLogin.visible := false;
end;

// =============================================================================

procedure TFrmLogin.btnLseSgnWhnClckd(Sender: TObject);
begin
  edtsandlabels(1);
end;

procedure TFrmLogin.btnLsrSgnWhnClckd(Sender: TObject);
begin
  edtsandlabels(2);
end;

// =============================================================================

procedure TFrmLogin.btnLseLgnWhnClckd(Sender: TObject);
begin
 edtsandlabels(3);
end;

procedure TFrmLogin.btnLsrLgnWhnClckd(Sender: TObject);
begin
  edtsandlabels(4);
end;

procedure TFrmLogin.btnADMNLgnWhnClckd(Sender: TObject);
begin
  edtsandlabels(5);
end;

// =============================================================================
{ this is very long code all it does is dynamically create edits, labels and a
  buttons created this big procedure because if I did not there would be
  alot of repition }
procedure TFrmLogin.edtsandlabels(iIn: integer);
begin
  btnLessee.free;
  btnLessor.free;
  if iIn > 2 then
  begin
    btnAdminLogin.free;
  end;

  // Username
  lblUsername := TLabel.Create(FrmLogin);
  with lblUsername do
  begin
    { I did not define the height and width because those are given
      defalut values when created }
    Top := 8;
    Left := 8;
    Parent := FrmLogin;
    Caption := 'Username';
  end;

  edtUsername := TEdit.Create(FrmLogin);
  with edtUsername do
  begin
    Top := 28;
    Left := 8;
    Parent := FrmLogin;
  end;

  // Password

  lblPassword := TLabel.Create(FrmLogin);
  with lblPassword do
  begin
    Top := 8;
    Left := 150;
    Parent := FrmLogin;
    Caption := 'Password';
  end;

  edtPassword := TEdit.Create(FrmLogin);
  with edtPassword do
  begin
    Top := 28;
    Left := lblPassword.Left;
    Parent := FrmLogin;
    PasswordChar := '•';
  end;

  //

  btnEnter := TButton.Create(FrmLogin);
  with btnEnter do
  begin
    Height := 25;
    width := edtPassword.Left + edtPassword.width;
    Left := 8;
    Parent := FrmLogin;
    Caption := 'Enter';
    OnClick := btnChangeFormWhnClckd;
  end;

  // ==

  FrmLogin.width := 300;

  // ==

  if (iIn = 1) or (iIn = 2) then
  begin
    // Email

    lblEmail := TLabel.Create(FrmLogin);
    with lblEmail do
    begin
      Top := edtUsername.Top + edtUsername.Height + 20;
      Left := 8;
      Parent := FrmLogin;
      Caption := 'Email';
    end;

    edtEmail := TEdit.Create(FrmLogin);
    with edtEmail do
    begin
      Top := lblEmail.Top + 20;
      Left := 8;
      Parent := FrmLogin;
    end;

    // ChckPsswrd

    lblChckPsswrd := TLabel.Create(FrmLogin);
    with lblChckPsswrd do
    begin
      Top := lblEmail.Top;
      Left := lblPassword.Left;
      Parent := FrmLogin;
      Caption := 'Password again';
    end;

    edtChckPsswrd := TEdit.Create(FrmLogin);
    with edtChckPsswrd do
    begin
      Top := edtEmail.Top;
      Left := lblPassword.Left;
      Parent := FrmLogin;
      PasswordChar := '•'
    end;

    // btn and form

    btnEnter.Top := edtEmail.Top + edtEmail.Height + 20;
    FrmLogin.Height := 200;
  end

  else
  begin
    btnEnter.Top := edtUsername.Top + edtUsername.Height + 20;
    FrmLogin.Height := 140;
  end;

  if iIn = 1 then
    iTypeLoginSignup := 1
  else if iIn = 2 then
    iTypeLoginSignup := 2
  else if iIn = 3 then
    iTypeLoginSignup := 3
  else if iIn = 4 then
    iTypeLoginSignup := 4
  else
    iTypeLoginSignup := 5;
end;

// =============================================================================

procedure TFrmLogin.btnChangeFormWhnClckd(Sender: TObject);
var
  bPassed: boolean;
  error: string;
begin
  bPassed := false;
  error := '';

  if (iTypeLoginSignup = 1) or (iTypeLoginSignup = 2) then
  begin
    if edtPassword.text <> edtChckPsswrd.text then
    begin
      showMessage('Your two passwords don''t match');
    end
    else
    begin
      FrmManager.createNewUser(edtUsername.text, edtPassword.text,
        edtEmail.text, iTypeLoginSignup, error);
      if error = '' then
        bPassed := true
      else
        showMessage(error);
    end;
  end
  else
  begin
    FrmManager.checkUser(edtUsername.text, edtPassword.text, iTypeLoginSignup,
      error);
    if error = '' then
      bPassed := true
    else
      showMessage(error + #13 +
          'If you have forgotten you password, email: FakeEmail@email.com');
  end;

  { I create the other forms here, and  I commented this out in Pat_P.dpr }

  if ((iTypeLoginSignup = 1) or (iTypeLoginSignup = 3)) and (bPassed = true)
    then
  begin
    Application.CreateForm(TFrmLessee, FrmLessee);
    // lessee
  end
  else if ((iTypeLoginSignup = 2) or (iTypeLoginSignup = 4)) and
    (bPassed = true) then
  begin
    Application.CreateForm(TFrmLessor, FrmLessor);
    // lessor
  end
  else if (bPassed = true) then
  begin
    Application.CreateForm(TFrmAdmin, FrmAdmin);
    // admin
  end;
end;

// =============================================================================

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FrmLogin.visible = true then
    Application.Terminate;
end;

end.
