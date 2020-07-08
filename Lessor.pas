unit Lessor; // user who rents out / owns a property

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Manager, ExtCtrls;

type
  TFrmLessor = class(TForm)
    pnlMain: TPanel;
    btneditlodge: TButton;
    btnChngPsswrd: TButton;
    btnSetUpSale: TButton;
    BtnBookings: TButton;
    redOut: TRichEdit;
    procedure FormCreate(Sender: TObject);

    procedure btnChngPsswrdClick(Sender: TObject);

    procedure btneditlodgeClick(Sender: TObject);
    procedure btnSAVEWhnClckd(Sender: TObject);
    procedure btnDISCARDWhnClckd(Sender: TObject);

    procedure BtnBookingsClick(Sender: TObject);

    procedure btnSetUpSaleClick(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    //
  public
    //
  end;

var
  FrmLessor: TFrmLessor;
  // global variables
  sPassword: string;
  BookingsBtnUsed: Boolean;

  // objects :
  pnlEditLodging: TPanel;

  lblNameLodge: TLabel;
  lblNumPeople: TLabel;
  lblPricePerNight: TLabel;
  lblFishingType: TLabel;
  lblNumRooms: TLabel;
  lblGuideCost: TLabel;
  lblHouseKeeping: TLabel;
  lblList: TLabel;
  lblLocation: TLabel;

  editNameLodge: TEdit;
  edtNumPeople: TEdit;
  edtPricePerNight: TEdit;
  edtFishingType: TEdit;
  edtNumRooms: TEdit;
  edtGuideCost: TEdit;
  edtHouseKeeping: TEdit;
  edtLocation: TEdit;

  chkList: TCheckBox;

  btnSAVE: TButton;
  btnDISCARD: TButton;

implementation

uses Login;
{$R *.dfm}

procedure TFrmLessor.FormCreate(Sender: TObject);
begin
  FrmLogin.Visible := false;
  FrmLogin.Free;
  FrmLessor.Visible := true;
  redOut.Lines.Add('Hello ' + FrmManager.getUsername);
  BookingsBtnUsed := false;
end;

// =============================================================================

procedure TFrmLessor.btneditlodgeClick(Sender: TObject);
var
  sLodgeName, sLocation, sNumRooms, sNumPeps, sPricepernight,
    sPriceHousekeeping, sFishingType, sPriceguide: string;
  List: Boolean;
begin
  pnlMain.Visible := false;
  FrmLessor.Height := 295;
  FrmLessor.width := 465;

  pnlEditLodging := TPanel.Create(FrmLessor);
  with pnlEditLodging do
  begin
    Left := 8;
    Top := 4;
    width := 433;
    Height := 245;
    TabOrder := 0;
    Parent := FrmLessor;
  end;

  lblNameLodge := TLabel.Create(FrmLessor);
  with lblNameLodge do
  begin
    Font.size := 8;
    Left := 8;
    Top := 8;
    width := 69;
    Height := 13;
    Caption := 'Name of lodge';
    Parent := pnlEditLodging;
  end;

  lblNumPeople := TLabel.Create(FrmLessor);
  with lblNumPeople do
  begin
    Left := 280;
    Top := 8;
    width := 145;
    Height := 13;
    Caption := 'Number of people able to stay';
    Parent := pnlEditLodging;
  end;

  lblPricePerNight := TLabel.Create(FrmLessor);
  with lblPricePerNight do
  begin
    Left := 8;
    Top := 64;
    width := 69;
    Height := 13;
    Caption := 'Price per night(R)';
    Parent := pnlEditLodging;
  end;

  lblFishingType := TLabel.Create(FrmLessor);
  with lblFishingType do
  begin
    Left := 144;
    Top := 64;
    width := 60;
    Height := 13;
    Caption := 'Fishing Type';
    Parent := pnlEditLodging;
  end;

  lblNumRooms := TLabel.Create(FrmLessor);
  with lblNumRooms do
  begin
    Left := 144;
    Top := 8;
    width := 82;
    Height := 13;
    Caption := 'Number of rooms';
    Parent := pnlEditLodging;
  end;

  lblGuideCost := TLabel.Create(FrmLessor);
  with lblGuideCost do
  begin
    Left := 8;
    Top := 120;
    width := 52;
    Height := 13;
    Caption := 'Price Guide per day(R)';
    Parent := pnlEditLodging;
  end;

  lblHouseKeeping := TLabel.Create(FrmLessor);
  with lblHouseKeeping do
  begin
    Left := 280;
    Top := 64;
    width := 70;
    Height := 13;
    Caption := 'Price House keeping per day(R)';
    Parent := pnlEditLodging;
  end;

  lblList := TLabel.Create(FrmLessor);
  with lblList do
  begin
    Left := 280;
    Top := 122;
    width := 16;
    Height := 13;
    Caption := 'List';
    Parent := pnlEditLodging;
  end;

  lblLocation := TLabel.Create(FrmLessor);
  with lblLocation do
  begin
    Left := 144;
    Top := 122;
    width := 16;
    Height := 13;
    Caption := 'Province and town/city';
    Parent := pnlEditLodging;
  end;

  editNameLodge := TEdit.Create(FrmLessor);
  with editNameLodge do
  begin
    Left := 8;
    Top := 27;
    width := 121;
    Height := 21;
    TabOrder := 0;
    Parent := pnlEditLodging;
  end;

  edtNumRooms := TEdit.Create(FrmLessor);
  with edtNumRooms do
  begin
    Left := 144;
    Top := 27;
    width := 121;
    Height := 21;
    NumbersOnly := true;
    TabOrder := 1;
    Parent := pnlEditLodging;
  end;

  edtNumPeople := TEdit.Create(FrmLessor);
  with edtNumPeople do
  begin
    Left := 280;
    Top := 27;
    width := 121;
    Height := 21;
    NumbersOnly := true;
    TabOrder := 2;
    Parent := pnlEditLodging;
  end;

  edtPricePerNight := TEdit.Create(FrmLessor);
  with edtPricePerNight do
  begin
    Left := 8;
    Top := 83;
    width := 121;
    Height := 21;
    NumbersOnly := true;
    TabOrder := 3;
    Parent := pnlEditLodging;
  end;

  edtFishingType := TEdit.Create(FrmLessor);
  with edtFishingType do
  begin
    Left := 144;
    Top := 83;
    width := 121;
    Height := 21;
    TabOrder := 4;
    Parent := pnlEditLodging;
    Text := '';
  end;

  edtHouseKeeping := TEdit.Create(FrmLessor);
  with edtHouseKeeping do
  begin
    Left := 280;
    Top := 83;
    width := 121;
    Height := 21;
    NumbersOnly := true;
    TabOrder := 5;
    Text := 'If no House Keeping set to 0';
    Parent := pnlEditLodging;
  end;

  edtGuideCost := TEdit.Create(FrmLessor);
  with edtGuideCost do
  begin
    Left := 8;
    Top := 139;
    width := 121;
    Height := 21;
    NumbersOnly := true;
    TabOrder := 6;
    Text := 'If no guideset to 0';
    Parent := pnlEditLodging;
  end;

  edtLocation := TEdit.Create(FrmLessor);
  with edtLocation do
  begin
    Left := 144;
    Top := 139;
    width := 121;
    Height := 21;
    TabOrder := 7;
    Parent := pnlEditLodging;
  end;

  chkList := TCheckBox.Create(FrmLessor);
  with chkList do
  begin
    Left := 280;
    Top := 139;
    width := 97;
    Height := 17;
    Caption := 'List';
    TabOrder := 8;
    Parent := pnlEditLodging;
  end;

  btnSAVE := TButton.Create(FrmLessor);
  with btnSAVE do
  begin
    Left := 8;
    Top := 182;
    width := 201;
    Height := 49;
    Caption := 'SAVE 💾';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -27;
    Font.Name := 'Tahoma';
    Font.Style := [];
    ParentFont := false;
    TabOrder := 9;
    Parent := pnlEditLodging;
    OnClick := btnSAVEWhnClckd;
  end;

  btnDISCARD := TButton.Create(FrmLessor);
  with btnDISCARD do
  begin
    Left := 225;
    Top := 182;
    width := 201;
    Height := 49;
    Caption := 'DISCARD 🗑';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -27;
    Font.Name := 'Tahoma';
    Font.Style := [];
    ParentFont := false;
    TabOrder := 10;
    Parent := pnlEditLodging;
    OnClick := btnDISCARDWhnClckd;
  end;

  FrmManager.getLodgeDetails(sLodgeName, sFishingType, sLocation, sNumRooms,
    sNumPeps, sPricepernight, sPriceHousekeeping, sPriceguide, List);

  editNameLodge.Text := sLodgeName;
  edtFishingType.Text := sFishingType;
  edtLocation.Text := sLocation;
  edtNumRooms.Text := sNumRooms;
  edtNumPeople.Text := sNumPeps;
  edtPricePerNight.Text := sPricepernight;
  if sPriceHousekeeping <> '0' then
    edtHouseKeeping.Text := sPriceHousekeeping;
  if sPriceguide <> '0' then
    edtGuideCost.Text := sPriceguide;
  chkList.Checked := List;

  showmessage('You can not leave any feilds empty');
end;

// ==================

procedure TFrmLessor.btnSAVEWhnClckd(Sender: TObject);
begin
  FrmManager.setLodgeDetails(editNameLodge.Text, edtFishingType.Text,
    edtLocation.Text, edtNumRooms.Text, edtNumPeople.Text,
    edtPricePerNight.Text, edtHouseKeeping.Text, edtGuideCost.Text,
    chkList.Checked);

  pnlMain.Visible := true;
  FrmLessor.width := 375;
  FrmLessor.Height := 270;
  pnlEditLodging.Visible := false;
end;

// ==================

procedure TFrmLessor.btnDISCARDWhnClckd(Sender: TObject);
begin
  if messageDlg('Are you sure you want to discard all changes will be lost?',
    mtWarning, [mbOk, mbCancel], 0) = mrOk then
  begin
    pnlMain.Visible := true;
    FrmLessor.width := 375;
    FrmLessor.Height := 270;
    pnlEditLodging.Visible := false;
  end;
end;

// =============================================================================

procedure TFrmLessor.BtnBookingsClick(Sender: TObject);
var
  iLoop: integer;
  BookingNumberToDel: string;
  BookingNum, startDte, endDte, guide: string;
begin
  if BookingsBtnUsed = false then
  begin
    redOut.Lines.clear;
    BtnBookings.Caption := 'Delete a booking';

    for iLoop := 1 to FrmManager.CountAndSetUpBookings do
    begin
      FrmManager.returnBookings(iLoop, BookingNum, startDte, endDte, guide);
      redOut.Lines.Add('Booking ' + BookingNum + ' start date: ' + startDte +
        ' end date: ' + endDte + ' is a guide requested: ' + guide);
    end;
  end
  else
  begin
    BookingNumberToDel :=
      InputBox('', 'Enter in the number of the booking you wish to delete', '');
    FrmManager.deleteBooking(BookingNum);
    showmessage('Done!')
  end;

end;

// =============================================================================

procedure TFrmLessor.btnChngPsswrdClick(Sender: TObject);
begin
  if messageDlg('Are you sure you want to change your password?', mtWarning,
    [mbOk, mbCancel], 0) = mrOk then
  begin
    sPassword := InputBox('', 'New Passwords', '');
    if messageDlg('Are you sure you want to change your password to ' +
      sPassword + '?', mtWarning, [mbOk, mbCancel], 0) = mrOk then
    begin
      FrmManager.changePassword(sPassword);
      showmessage('done!');
    end;
  end;
end;

// =============================================================================

procedure TFrmLessor.btnSetUpSaleClick(Sender: TObject);
begin
  FrmManager.setUpSale(1);
end;

// =============================================================================

procedure TFrmLessor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if pnlMain.Visible = false then
  begin
    if messageDlg('If you close you will loose all changes', mtWarning,
      [mbOk, mbCancel], 0) = mrCancel then
      CanClose := false;
  end;
end;

// =============================================================================

procedure TFrmLessor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
