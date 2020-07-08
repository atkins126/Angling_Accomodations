unit Admin; // user who manages site

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Manager, ExtCtrls;

type
  TFrmAdmin = class(TForm)
    pnlMain: TPanel;
    btnConfirm: TButton;
    btnChangePassword: TButton;
    btnSetUpSale: TButton;
    redOut: TRichEdit;
    procedure FormCreate(Sender: TObject);

    procedure btnSetUpSaleClick(Sender: TObject);

    procedure btnConfirmClick(Sender: TObject);

    procedure btnChangePasswordClick(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    //
  public
    //
  end;

var
  FrmAdmin: TFrmAdmin;
  // global variables
  BConfirmClick: boolean;

implementation

uses Login;
{$R *.dfm}

procedure TFrmAdmin.FormCreate(Sender: TObject);
begin
  FrmLogin.Visible := false;
  FrmLogin.Free;
  FrmAdmin.Visible := true;
  BConfirmClick := false;
end;

// =============================================================================

procedure TFrmAdmin.btnConfirmClick(Sender: TObject);
var
  iLoop, iUncnfrmdLdgngs: integer;
  sLodgeName, sFishingType, sLocation: string;
begin
  if BConfirmClick = false then
  begin
    redOut.Lines.Clear;
    iUncnfrmdLdgngs := FrmManager.CntUncnfrmdLdgngs;
    for iLoop := 1 to iUncnfrmdLdgngs do
    begin
      FrmManager.UncnfrmdLdgng(sLodgeName, sFishingType, sLocation);
      redOut.Lines.Add('Lodge name: ' + sLodgeName + ' Fishing type: ' +
          sFishingType + ' Location: ' + sLocation);
    end;
    BConfirmClick := true;
    showmessage('Click Confirm Lodgings again to select a lodging to Confirm');
  end
  else
  begin
    sLodgeName := inputbox('',
      'Please put in the name of the lodge you would like to confirm', '');
    FrmManager.CnfrmLdgng(sLodgeName);
    showmessage('Done!');
  end;

end;

// =============================================================================

procedure TFrmAdmin.btnChangePasswordClick(Sender: TObject);
var
  strInptUsrNme, strInptTbl, strInptNwPsswrd: string;
begin
  strInptUsrNme := inputbox('', 'The user''s username', '');
  strInptTbl := inputbox('', 'Lessee or Lessor', 'Lessee/Lessor');

  if FrmManager.CheckForUser(strInptUsrNme, strInptTbl) = true then
  begin
    strInptNwPsswrd := inputbox('', 'The user''s new Password', '');
    FrmManager.NewUserPassword(strInptTbl, strInptNwPsswrd);
  end;
end;

// =============================================================================

procedure TFrmAdmin.btnSetUpSaleClick(Sender: TObject);
begin
  FrmManager.setUpSale(2);
end;

// =============================================================================

procedure TFrmAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
