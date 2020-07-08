unit Lessee; // user who rents / pays to stay at a property

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Manager, ExtCtrls;

type
  TFrmLessee = class(TForm)
    pnlMain: TPanel;
    btnfndLodge: TButton;
    Btnbookings: TButton;
    btnChngPsswrd: TButton;
    redOut: TRichEdit;
    procedure FormCreate(Sender: TObject);

    procedure btnChngPsswrdClick(Sender: TObject);

    procedure BtnbookingsClick(Sender: TObject);

    procedure btnfndLodgeClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure BkngAftrSrchngClick1(Sender: TObject);
    procedure BkngAftrSrchngClick2(Sender: TObject);
    procedure BkngAftrSrchngClick3(Sender: TObject);
    procedure BkngAftrSrchngClick4(Sender: TObject);
    procedure BkngAftrSrchngClick5(Sender: TObject);
    procedure BkngAftrSrchngClick6(Sender: TObject);
    procedure BkngAftrSrchngClick7(Sender: TObject);
    procedure BkngAftrSrchngClick8(Sender: TObject);
    procedure BkngAftrSrchngClick9(Sender: TObject);
    procedure BkngAftrSrchngClick10(Sender: TObject);
    // seems repetitive but this was the only way I knew to do it
    procedure btnNextClick(Sender: TObject);
    procedure btnPerviousClick(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure displayLodgings;
    procedure BkngAftrSrchngClick(iIn: integer);
  public
    //
  end;

var
  FrmLessee: TFrmLessee;

  // global variables
  sPassword: string;
  BookingsBtnUsed: Boolean;
  bSearched: Boolean;
  iGroup: integer;
  iTotLodge: integer;

  // objects :
  btnHome: TButton;
  btnSearch: TButton;
  edtSearch: TEdit;
  SrchFrCmbBx: TComboBox;
  OrdrByCmbBx: TComboBox;

  arrPnlLodge: array [1 .. 10] of TPanel;
  arrBtnBookings: array [1 .. 10] of TButton;
  arrRedOut: array [1 .. 10] of TRichEdit;
  btnNext: TButton;
  btnPervious: TButton;

implementation

uses Login;
{$R *.dfm}

procedure TFrmLessee.FormCreate(Sender: TObject);
begin
  FrmLogin.Visible := false;
  FrmLogin.Free;
  FrmLessee.Visible := true;
  redout.Lines.Add('Hello ' + FrmManager.getUsername);
  BookingsBtnUsed := false;
end;

// =============================================================================

procedure TFrmLessee.btnfndLodgeClick(Sender: TObject);
begin
  FrmLessee.height := 83;
  FrmLessee.width := 702;

  btnHome := TButton.Create(FrmLessee);
  with btnHome do
  begin
    Left := 8;
    Top := 8;
    width := 75;
    height := 25;
    Caption := '⌂ Home';
    TabOrder := 0;
    Parent := FrmLessee;
    onClick := btnHomeClick;
  end;

  btnSearch := TButton.Create(FrmLessee);
  with btnSearch do
  begin
    Left := 590;
    Top := 8;
    width := 75;
    height := 25;
    Caption := 'Search';
    TabOrder := 2;
    Parent := FrmLessee;
    onClick := btnSearchClick;
  end;

  edtSearch := TEdit.Create(FrmLessee);
  with edtSearch do
  begin
    Left := 235;
    Top := 10;
    width := 200;
    height := 21;
    TabOrder := 1;
    Text := 'Search...';
    Parent := FrmLessee;
  end;

  OrdrByCmbBx := TComboBox.Create(FrmLessee);
  with OrdrByCmbBx do
  begin
    Left := 88;
    Top := 10;
    width := 145;
    height := 21;
    TabOrder := 0;
    Text := 'Order by';
    Parent := FrmLessee;
    Items.Add('Price low > high');
    Items.Add('Price high > low');
  end;

  SrchFrCmbBx := TComboBox.Create(FrmLessee);
  with SrchFrCmbBx do
  begin
    Left := 443;
    Top := 10;
    width := 145;
    height := 21;
    TabOrder := 1;
    Text := 'Search for';
    Parent := FrmLessee;
    Items.Add('Lodge name');
    Items.Add('Fishing type');
    Items.Add('PLocation');
  end;

  bSearched := false;
  pnlMain.Visible := false;
end;

// ==================

procedure TFrmLessee.btnHomeClick(Sender: TObject);
var
  iLoop: integer;
begin
  if bSearched = true then
  begin
    for iLoop := 1 to 10 do
    begin
      arrPnlLodge[iLoop].Free;
      arrBtnBookings[iLoop].Free;
      arrRedOut[iLoop].Free;
    end;

    btnNext.Free;
    btnPervious.Free;
  end;

  btnSearch.Free;
  edtSearch.Free;
  SrchFrCmbBx.Free;
  OrdrByCmbBx.Free;
  FrmLessee.width := 376;
  FrmLessee.height := 273;
  pnlMain.Visible := true;
  btnHome.Free;
end;

// ==================

procedure TFrmLessee.btnSearchClick(Sender: TObject);
var
  iLoop: integer;
  strSearch, strSqlSearch: string;
begin
  FrmLessee.height := 850;

  if bSearched = false then
  begin
    // panels
    for iLoop := 1 to 10 do
    begin
      arrPnlLodge[iLoop] := TPanel.Create(FrmLessee);
      with arrPnlLodge[iLoop] do
      begin
        Parent := FrmLessee;
        if (iLoop - 5) <= 0 then
        begin
          Left := 8;
          Top := (iLoop * 40) + ((iLoop - 1) * 100);
        end
        else
        begin
          Left := 348;
          Top := ((iLoop - 5) * 40) + ((iLoop - 6) * 100);
        end;

        width := 330;
        height := 130;
        TabOrder := 3;
      end;

      // buttons
      arrBtnBookings[iLoop] := TButton.Create(FrmLessee);
      with arrBtnBookings[iLoop] do
      begin
        Left := 223;
        Top := 53;
        width := 75;
        height := 25;
        Caption := 'Book';
        TabOrder := 1;
        Parent := arrPnlLodge[iLoop];
        case iLoop of
          1:
            onClick := BkngAftrSrchngClick1;
          2:
            onClick := BkngAftrSrchngClick2;
          3:
            onClick := BkngAftrSrchngClick3;
          4:
            onClick := BkngAftrSrchngClick4;
          5:
            onClick := BkngAftrSrchngClick5;
          6:
            onClick := BkngAftrSrchngClick6;
          7:
            onClick := BkngAftrSrchngClick7;
          8:
            onClick := BkngAftrSrchngClick8;
          9:
            onClick := BkngAftrSrchngClick9;
          10:
            onClick := BkngAftrSrchngClick10;
        end;
      end;

      // RichEdits
      arrRedOut[iLoop] := TRichEdit.Create(FrmLessee);
      with arrRedOut[iLoop] do
      begin
        Left := 8;
        Top := 8;
        width := 185;
        height := 113;
        Font.Charset := ANSI_CHARSET;
        Font.Color := clWindowText;
        Font.height := -11;
        Font.Name := 'Tahoma';
        Font.Style := [];
        ParentFont := false;
        TabOrder := 0;
        Parent := arrPnlLodge[iLoop];
      end;
    end;

    btnNext := TButton.Create(FrmLessee);
    with btnNext do
    begin
      Left := 352;
      Top := 743;
      width := 327;
      height := 66;
      Caption := 'Next →';
      TabOrder := 4;
      Parent := FrmLessee;
      onClick := btnNextClick;
    end;

    btnPervious := TButton.Create(FrmLessee);
    with btnPervious do
    begin
      Left := 8;
      Top := 743;
      width := 322;
      height := 66;
      Caption := '← Pervious';
      TabOrder := 3;
      Enabled := false;
      Parent := FrmLessee;
      onClick := btnPerviousClick;
    end;
  end
  else
    for iLoop := 1 to 10 do
      arrRedOut[iLoop].Lines.Clear;

  strSqlSearch := 'SELECT * FROM tblLessorUser';

  strSearch := edtSearch.Text;
  if strSearch = 'Search...' then
    strSearch := '';

  case SrchFrCmbBx.itemIndex of
    1:
      strSqlSearch := strSqlSearch + ' WHERE ([FishingType] LIKE ''' +
        strSearch + '%'') and (Confirmed = YES)';
    2:
      strSqlSearch := strSqlSearch + ' WHERE ([Location] LIKE ''' + strSearch +
        '%'') and (Confirmed = YES)';
  else
    strSqlSearch := strSqlSearch + ' WHERE ([Lodging] LIKE ''' + strSearch +
      '%'') and (Confirmed = YES)';
  end;

  case OrdrByCmbBx.itemIndex of
    0:
      strSqlSearch := strSqlSearch + '  ORDER BY [PricePerNight]';
    1:
      strSqlSearch := strSqlSearch + ' ORDER BY [PricePerNight] DESC';
  end;

  iGroup := 0;
  FrmManager.setUpSearchforLodgings(strSqlSearch, bSearched, iTotLodge);
  bSearched := true;
  displayLodgings;
end;

// ==================

procedure TFrmLessee.BkngAftrSrchngClick1(Sender: TObject);
begin
  BkngAftrSrchngClick(1); // seems pretty stupid to have to just send one value
  // had to do it this way as to not ruin user expereince with "book1", "book2", etc
end;

procedure TFrmLessee.BkngAftrSrchngClick2(Sender: TObject);
begin
  BkngAftrSrchngClick(2);
end;

procedure TFrmLessee.BkngAftrSrchngClick3(Sender: TObject);
begin
  BkngAftrSrchngClick(3);
end;

procedure TFrmLessee.BkngAftrSrchngClick4(Sender: TObject);
begin
  BkngAftrSrchngClick(4);
end;

procedure TFrmLessee.BkngAftrSrchngClick5(Sender: TObject);
begin
  BkngAftrSrchngClick(5);
end;

procedure TFrmLessee.BkngAftrSrchngClick6(Sender: TObject);
begin
  BkngAftrSrchngClick(6);
end;

procedure TFrmLessee.BkngAftrSrchngClick7(Sender: TObject);
begin
  BkngAftrSrchngClick(7);
end;

procedure TFrmLessee.BkngAftrSrchngClick8(Sender: TObject);
begin
  BkngAftrSrchngClick(8);
end;

procedure TFrmLessee.BkngAftrSrchngClick9(Sender: TObject);
begin
  BkngAftrSrchngClick(9);
end;

procedure TFrmLessee.BkngAftrSrchngClick10(Sender: TObject);
begin
  BkngAftrSrchngClick(10);
end;

// ==================

procedure TFrmLessee.BkngAftrSrchngClick(iIn: integer);
begin
  FrmManager.bookLodging(iIn);
  FrmManager.Visible := true;
end;

// ==================

procedure TFrmLessee.btnNextClick(Sender: TObject);
begin
  iGroup := iGroup + 10;

  if ((iTotLodge mod 10) <> 0) and (iGroup + 10 > iTotLodge) then
    btnNext.Enabled := false
  else if iGroup + 10 = iTotLodge then
    btnNext.Enabled := false;
  btnPervious.Enabled := true;
  displayLodgings;
end;

// ==================

procedure TFrmLessee.btnPerviousClick(Sender: TObject);
begin
  iGroup := iGroup - 10;

  if iGroup - 10 <= 0 then
    btnPervious.Enabled := false;
  btnNext.Enabled := true;
  displayLodgings;
end;

// ==================

procedure TFrmLessee.displayLodgings;
var
  iLoop: integer;
  sLdgNm, sFshTp, sLoca, sNumRms, sNumPeps, sPPN, sHseKpng, sGd: string;
begin
  for iLoop := 1 to 10 do
    arrRedOut[iLoop].Lines.Clear;

  for iLoop := 1 to 10 do
  begin
    FrmManager.ReturnASearchedLodge((iGroup + iLoop), sLdgNm, sFshTp, sLoca,
      sNumRms, sNumPeps, sPPN, sHseKpng, sGd);
    if sLdgNm <> '' then
    begin
      arrRedOut[iLoop].Lines.Add('Lodge Name: ' + sLdgNm + #13 +
          'Type of fishing: ' + sFshTp + #13 + 'Location: ' + sLoca + #13 +
          'Number of rooms: ' + sNumRms + #13 +
          'Number of people able to stay: ' + sNumPeps + #13 +
          'Price per Night: R' + sPPN + #13 + 'House Keeping: ' + sHseKpng +
          #13 + 'Guide: ' + sGd);
      arrBtnBookings[iLoop].Enabled := true
    end
    else
      arrBtnBookings[iLoop].Enabled := false;
  end;
end;

// =============================================================================

procedure TFrmLessee.BtnbookingsClick(Sender: TObject);
var
  iLoop: integer;
  BookingNumberToDel: string;
  BookingNum, startDte, endDte, guide: string;
begin
  if BookingsBtnUsed = false then
  begin
    redout.Lines.Clear;
    Btnbookings.Caption := 'Delete a booking';

    for iLoop := 1 to FrmManager.CountAndSetUpBookings do
    begin
      FrmManager.returnBookings(iLoop, BookingNum, startDte, endDte, guide);
      redout.Lines.Add('Booking ' + BookingNum + ' start date: ' + startDte +
          ' end date: ' + endDte + ' is a guide requested: ' + guide);
    end;
  end
  else
  begin
    BookingNumberToDel := InputBox('',
      'Enter in the number of the booking you wish to delete', '');
    FrmManager.deleteBooking(BookingNum);
    Showmessage('Done!')
  end;
end;

// =============================================================================

procedure TFrmLessee.btnChngPsswrdClick(Sender: TObject);
begin
  if messageDlg('Are you sure you want to change your password?', mtWarning,
    [mbOk, mbCancel], 0) = mrOk then
  begin
    sPassword := InputBox('', 'New Password', '');
    if messageDlg('Are you sure you want to change your password to ' +
        sPassword + '?', mtWarning, [mbOk, mbCancel], 0) = mrOk then
    begin
      FrmManager.changePassword(sPassword);
      Showmessage('done!');
    end;
  end;
end;

// =============================================================================

procedure TFrmLessee.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
