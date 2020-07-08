program AnglingAccomodations;
// Connor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Connor

uses
  Forms,
  Login in 'Login.pas' {FrmLogin} ,
  Admin in 'Admin.pas' {FrmAdmin} ,
  Lessee in 'Lessee.pas' {FrmLessee} ,
  Lessor in 'Lessor.pas' {FrmLessor} ,
  Manager in 'Manager.pas' {FrmManager} ,
  Bookings in 'Bookings.pas';
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmManager, FrmManager);
  // took out other forms so that they aren't created and don't take up memory
  Application.Run;

end.
