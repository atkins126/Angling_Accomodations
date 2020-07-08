unit Manager;

// this is here to provide easy management of the data base it counts as
// object orientated programiming
// contains sql
// this unit is created on startup because it is used by every other form
// this contains textfile managing as well
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, Grids, DBGrids, StdCtrls, ComCtrls, DateUtils, Bookings;

type
  TFrmManager = class(TForm)
    conDataB: TADOConnection;
    adoQryLessee: TADOQuery;
    adoLessee: TADOTable;
    adoLessor: TADOTable;
    adoQryLessor: TADOQuery;
    adoBookings: TADOTable;
    adoQryBookings: TADOQuery;
    adoQryDataB: TADOQuery;
    adoDataB: TADOTable;
    procedure FormCreate(Sender: TObject);

    // for Lessee
    procedure btnBookClick(Sender: TObject);
    procedure btnQuoteClick(Sender: TObject);
    // for Lessor
    procedure BtnLodgeSaleCloseclck(Sender: TObject);
    // for Admin
    procedure BtnSiteSaleCloseclck(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    // for All
    procedure runTheSqlQuery;
    // for All
    procedure encryptString(inputStr: string; var outputStr: string);

    // forLesseeAndLessor
    procedure setUpUserDb(tbl: string);
  public
    // for Lessee And Lessor at the begining of program
    procedure createNewUser(strCrUsrnme, strCrPsswrd, strCrEml: string;
      iCrTypeUser: integer; var strCrerror: string);

    // for All at the begining of program
    procedure checkUser(strChUsrnme, strChPsswrd: string; iTypechUser: integer;
      var strChError: string);

    // forLessee
    procedure setUpSearchforLodgings(strSQL: string; bSearched: Boolean;
      var nmbOfMtchLdg: integer);
    procedure ReturnASearchedLodge(iInLodge: integer; var sLdgNm, sFshTp,
      sLoca, sNumRms, sNumPeps, sPPN, sHseKpng, sGd: string);
    procedure bookLodging(iLodge: integer);

    // forLesseeAndLessor
    function getUsername: string;
    // forLesseeAndLessor
    procedure changePassword(sP: string);
    // forLesseeAndLessor
    function CountAndSetUpBookings: integer;
    procedure returnBookings(whichLodge: integer; var BookingNumber, startDte,
      endDte, guide: string);
    procedure deleteBooking(whichLodge: string);

    // forLessor
    procedure getLodgeDetails(var sLodgeName, sFishingType, sLocation,
      sNumRooms, sNumPeps, sPricepernight, sPriceHousekeeping,
      sPriceguide: string; List: Boolean);
    procedure setLodgeDetails(sLodgeName, sFishingType, sLocation, sNumRooms,
      sNumPeps, sPricepernight, sPriceHousekeeping, sPriceguide: string;
      List: Boolean);

    // forLessorandAdmin
    procedure setUpSale(iTypeUser: integer);

    // forAdmin
    function CntUncnfrmdLdgngs: integer;
    procedure UncnfrmdLdgng(var sLodgeName, sFishingType, sLocation: string);
    procedure CnfrmLdgng(whichLodge: string);
    // forAdmin
    function CheckForUser(strInptUsrNme, strInptTbl: string): Boolean;
    procedure NewUserPassword(strInptTbl, strInptNwPsswrd: string);

  end;

var
  // vairables
  FrmManager: TFrmManager;
  sSql: string;
  strUsernameEn, strUsername: string; // en means encrypted
  strPasswordEn, strPassword: string;
  table, tableUser: string;
  iLength: integer;
  Lodging: Array [1 .. 10000, 1 .. 12] of string;
  Bookings: Array [1 .. 100, 1 .. 4] of string;

  // objects
  // forLessee
  lblFirstDay: TLabel;
  lblLastDay: TLabel;
  ChckBxGuide: TCheckBox;
  DtTmPckrFirstDay: TDateTimePicker;
  DtTmPckrLastDay: TDateTimePicker;
  btnQuote: TButton;
  btnBook: TButton;
  redOut: TRichEdit;
  redOutQoute: TRichEdit;
  Booking: TBooking;
  // forLessorandAdmin
  DateTimePickerBegin: TDateTimePicker;
  DateTimePickerEnd: TDateTimePicker;
  BtnClose: TButton;

const
  CheckChar = ['a' .. 'z', 'A' .. 'Z', '0' .. '9'];

implementation

{$R *.dfm}

procedure TFrmManager.FormCreate(Sender: TObject);
var
  path: String;
begin
  randomize;
  conDataB.Close;

  path := ExtractFilePath(Application.ExeName);

  conDataB.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=' + path +
    'DBAnglingAccomodations.mdb;Persist Security Info=False';
  conDataB.LoginPrompt := false;
  conDataB.Open;
end;

// =============================================================================

procedure TFrmManager.runTheSqlQuery;
begin
  adoQryDataB.Close;
  adoQryDataB.SQL.Text := sSql;
  adoQryDataB.ExecSQL;
  adoQryDataB.Open;
end;

// =============================================================================

procedure TFrmManager.encryptString(inputStr: string; var outputStr: string);
var
  iLoop1, iLoop2, AdditionNumber: integer;
  sTemp: string;
  cTemp: char;
begin
  sTemp := '';

  case inputStr[3] of
    'A' .. 'Z':
      AdditionNumber := ORD(inputStr[3]) - 64;
    'a' .. 'z':
      AdditionNumber := ORD(inputStr[3]) - 96;
    '0' .. '9':
      AdditionNumber := strtoint(inputStr);
  end;

  iLength := length(inputStr);

  for iLoop1 := 1 to iLength do
    begin
      case inputStr[iLoop1] of
        'A' .. 'Z':
          begin
            if (ORD(inputStr[iLoop1]) + AdditionNumber) > 90 then
              begin
                sTemp := sTemp + char
                  (ORD(inputStr[iLoop1]) + AdditionNumber - 26);
              end
            else
              sTemp := sTemp + char(ORD(inputStr[iLoop1]) + AdditionNumber);
          end;
        'a' .. 'z':
          begin
            if (ORD(inputStr[iLoop1]) + AdditionNumber) > 122 then
              begin
                sTemp := sTemp + char
                  (ORD(inputStr[iLoop1]) + AdditionNumber - 26);
              end
            else
              sTemp := sTemp + char(ORD(inputStr[iLoop1]) + AdditionNumber);
          end
        else
          begin
            sTemp := sTemp + char(ORD(inputStr[iLoop1]) + AdditionNumber);
          end
      end
    end;

  for iLoop1 := 1 to iLength - 1 do
    begin
      for iLoop2 := iLoop1 + 1 to iLength do
        begin
          if sTemp[iLoop1] > sTemp[iLoop2] then
            begin
              cTemp := sTemp[iLoop1];
              sTemp[iLoop1] := sTemp[iLoop2];
              sTemp[iLoop2] := cTemp;
            end;
        end;
    end;
  outputStr := sTemp;
end;

// =============================================================================

procedure TFrmManager.setUpUserDb(tbl: string);
begin
  adoDataB.Close;
  adoDataB.Connection := conDataB;
  adoDataB.TableName := tbl;
  adoDataB.Open;

  adoQryDataB.Close;
  adoQryDataB.Connection := conDataB;
  adoQryDataB.SQL.Text := 'Select * from ' + tbl;
  adoQryDataB.Open;

  // Bookings
  adoBookings.Close;
  adoBookings.Connection := conDataB;
  adoBookings.TableName := 'tblBooking';
  adoBookings.Open;

  adoQryBookings.Close;
  adoQryBookings.Connection := conDataB;
  adoQryBookings.SQL.Text := 'Select * from tblBooking';
  adoQryBookings.Open;
end;

// =============================================================================

procedure TFrmManager.createNewUser(strCrUsrnme, strCrPsswrd, strCrEml: string;
  iCrTypeUser: integer; var strCrerror: string);
var
  iLoop: integer;
  bEmailFlag1, bEmailFlag2: Boolean;
begin
  strCrerror := '';
  strUsername := strCrUsrnme;
  strPassword := strCrPsswrd;
  bEmailFlag1 := false;
  bEmailFlag2 := false;

  if iCrTypeUser = 1 then
    begin
      table := 'tblLesseeUser';
      tableUser := 'LesseeUser';
    end
  else if iCrTypeUser = 2 then
    begin
      table := 'tblLessorUser';
      tableUser := 'LessorUser';
    end;
  setUpUserDb(table);

  // username checking
  iLength := length(strCrUsrnme);

  if iLength < 8 then
    begin
      strCrerror := strCrerror + 'username to short error' + #13;
    end;

  if iLength > 20 then
    begin
      strCrerror := strCrerror + 'username to long error' + #13;
    end;

  if (strCrUsrnme[3] in CheckChar) = false then
    begin
      strCrerror := strCrerror +
        'Username must have letter or number as 3rd charecter' + #13;
    end;

  if strCrerror = '' then
    begin
      encryptString(strCrUsrnme, strUsernameEn);

      sSql := 'SELECT [' + tableUser + '] FROM ' + table + ' WHERE ' +
        tableUser + ' = ''' + strUsernameEn + ''';';
      runTheSqlQuery;

      adoQryDataB.Open;
      adoQryDataB.first;
      if adoQryDataB[tableUser] = uppercase(strUsernameEn) then
        strCrerror := strCrerror + 'Username is in use already' + #13;
      adoQryDataB.Close;
    end;

  // passsword checking
  iLength := length(strCrPsswrd);
  if iLength < 8 then
    strCrerror := strCrerror + 'passsword to short error' + #13;

  if iLength > 20 then
    strCrerror := strCrerror + 'passsword to long error' + #13;

  if (strCrPsswrd[3] in CheckChar) = false then
    strCrerror := strCrerror +
      'Password must have letter or number as 3rd charecter' + #13;

  // Email checking
  for iLoop := 1 to length(strCrEml) do
    begin
      if (strCrEml[iLoop] = '.') and (bEmailFlag1 = true) then
        begin
          bEmailFlag2 := true;
        end;
      if strCrEml[iLoop] = '@' then
        bEmailFlag1 := true;
    end;

  if (bEmailFlag1 = false) or (bEmailFlag2 = false) then
    strCrerror := strCrerror + 'Email is not valid' + #13;

  if strCrerror = '' then
    begin
      sSql := 'SELECT [Email] FROM ' + table + ' WHERE Email = ''' + strCrEml +
        ''';';
      runTheSqlQuery;

      adoQryDataB.Open;
      adoQryDataB.first;
      if adoQryDataB['Email'] = uppercase(strCrEml) then
        strCrerror := strCrerror + 'Email is in use already' + #13;
      adoQryDataB.Close;
    end;

  // inserting
  if strCrerror = '' then
    begin
      encryptString(strCrPsswrd, strPasswordEn);

      adoQryDataB.Close;
      adoQryDataB.SQL.Text := ('INSERT INTO ' + table + '([' + tableUser +
          '], [Password], [Email]) ' + 'VALUES(''' + uppercase(strUsernameEn)
          + ''', ''' + strPasswordEn + ''', ''' + uppercase(strCrEml) + ''');');
      adoQryDataB.ExecSQL;
    end;

end;

// =============================================================================

procedure TFrmManager.checkUser(strChUsrnme, strChPsswrd: string;
  iTypechUser: integer; var strChError: string);
var
  sLine: string;
  fileRead: textfile;
begin
  strChError := '';
  strUsername := strChUsrnme;
  strPassword := strChPsswrd;

  if iTypechUser = 3 then
    begin
      table := 'tblLesseeUser';
      tableUser := 'LesseeUser';
      setUpUserDb(table);
    end
  else if iTypechUser = 4 then
    begin
      table := 'tblLessorUser';
      tableUser := 'LessorUser';
      setUpUserDb(table);
    end;

  if iTypechUser = 5 then
    begin
      AssignFile(fileRead, 'Dontdelete.txt');
      Reset(fileRead);

      encryptString(strChUsrnme, strUsernameEn);
      ReadLn(fileRead, sLine);
      if strUsernameEn <> sLine then
        strChError := strChError + 'username is incorect' + #13;

      encryptString(strChPsswrd, strPasswordEn);
      ReadLn(fileRead, sLine);
      if strPasswordEn <> sLine then
        strChError := strChError + 'password is incorect';

      // LesseeDB
      adoLessee.Close;
      adoLessee.Connection := conDataB;
      adoLessee.TableName := 'tblLesseeUser';
      adoLessee.Open;

      adoQryLessee.Close;
      adoQryLessee.Connection := conDataB;
      adoQryLessee.SQL.Text := 'Select * from tblLesseeUser';
      adoQryLessee.Open;

      // LessorDB
      adoLessor.Close;
      adoLessor.Connection := conDataB;
      adoLessor.TableName := 'tblLessorUser';
      adoLessor.Open;

      adoQryLessor.Close;
      adoQryLessor.Connection := conDataB;
      adoQryLessor.SQL.Text := 'Select * from tblLessorUser';
      adoQryLessor.Open;
    end
  else
    begin
      // username checking
      iLength := length(strChUsrnme);

      if iLength < 8 then
        begin
          strChError := strChError + 'username to short error' + #13;
        end;

      if iLength > 20 then
        begin
          strChError := strChError + 'username to long error' + #13;
        end;

      if (strChUsrnme[3] in CheckChar) = false then
        begin
          strChError := strChError +
            'Username must have letter or number as 3rd charecter' + #13;
        end;

      // passsword checking
      iLength := length(strChPsswrd);
      if iLength < 8 then
        strChError := strChError + 'passsword to short error' + #13;

      if iLength > 20 then
        strChError := strChError + 'passsword to long error' + #13;

      if (strChPsswrd[3] in CheckChar) = false then
        strChError := strChError +
          'Password must have letter or number as 3rd charecter' + #13;

      if strChError = '' then
        begin
          encryptString(strChUsrnme, strUsernameEn);

          sSql := 'SELECT [' + tableUser + '], [Password] FROM ' + table +
            ' WHERE ' + tableUser + ' = ''' + strUsernameEn + ''';';
          runTheSqlQuery;

          adoQryDataB.Open;
          adoQryDataB.first;

          if adoQryDataB[tableUser] <> uppercase(strUsernameEn) then
            strChError := strChError + 'Username is incorect' + #13;

          encryptString(strChPsswrd, strPasswordEn);

          if adoQryDataB['Password'] <> strPasswordEn then
            strChError := strChError + 'Password is incorect';

          adoQryDataB.Close;
        end;
    end;
end;

// =============================================================================

procedure TFrmManager.setUpSearchforLodgings
  (strSQL: string; bSearched: Boolean; var nmbOfMtchLdg: integer);
var
  iLoop: integer;
begin
  if bSearched = false then
    begin
      adoLessor.Close;
      adoLessor.Connection := conDataB;
      adoLessor.TableName := 'tblLessorUser';
      adoLessor.Open;

      adoQryLessor.Close;
      adoQryLessor.Connection := conDataB;
      adoQryLessor.SQL.Text := 'Select * from tblLessorUser';
      adoQryLessor.Open;
    end;
  adoQryLessor.Close;
  adoQryLessor.SQL.Text := strSQl;
  adoQryLessor.ExecSQL;
  adoQryLessor.Open;
  nmbOfMtchLdg := adoQryLessor.RecordCount;
  adoQryLessor.first;
  for iLoop := 1 to nmbOfMtchLdg do
    begin
      Lodging[iLoop, 1] := adoQryLessor['LessorUser'];
      Lodging[iLoop, 2] := adoQryLessor['Lodging'];
      Lodging[iLoop, 3] := adoQryLessor['FishingType'];
      Lodging[iLoop, 4] := adoQryLessor['Location'];
      Lodging[iLoop, 5] := inttostr(adoQryLessor['Rooms']);
      Lodging[iLoop, 6] := inttostr(adoQryLessor['PeopleAbleToStay']);
      Lodging[iLoop, 7] := inttostr(adoQryLessor['PricePerNight']);
      if adoQryLessor['HouseKeeping'] = 0 then
        Lodging[iLoop, 8] := 'none'
      else
        Lodging[iLoop, 8] := inttostr(adoQryLessor['HouseKeeping']);
      if adoQryLessor['Guide'] = 0 then
        Lodging[iLoop, 9] := 'none'
      else
        Lodging[iLoop, 9] := inttostr(adoQryLessor['Guide']);
      if adoQryLessor['Sale'] <> 0 then
        begin
          Lodging[iLoop, 10] := inttostr(adoQryLessor['Sale']);
          Lodging[iLoop, 11] := datetostr(adoQryLessor['SaleStart']);
          Lodging[iLoop, 12] := datetostr(adoQryLessor['SaleEnd']);
        end
      else
        begin
          Lodging[iLoop, 10] := '0';
          Lodging[iLoop, 11] := datetostr(Date);
          Lodging[iLoop, 12] := datetostr(Date);
        end;

      adoQryLessor.Next;
    end;
  adoQryLessor.Close;
end;

// =====================
procedure TFrmManager.ReturnASearchedLodge
  (iInLodge: integer; var sLdgNm, sFshTp, sLoca, sNumRms, sNumPeps, sPPN,
  sHseKpng, sGd: string);
begin
  sLdgNm := Lodging[iInLodge, 2];
  sFshTp := Lodging[iInLodge, 3];
  sLoca := Lodging[iInLodge, 4];
  sNumRms := Lodging[iInLodge, 5];
  sNumPeps := Lodging[iInLodge, 6];
  sPPN := Lodging[iInLodge, 7];
  sHseKpng := Lodging[iInLodge, 8];
  sGd := Lodging[iInLodge, 9];
end;

// =====================
procedure TFrmManager.bookLodging(iLodge: integer);
var
  bSale: Boolean;
  sLine: string;
  fileRead: textfile;
  Adminsale: string;
  date1, date2: tDate;
  iPos: integer;
begin
  FrmManager.Width := 330;
  lblFirstDay := TLabel.Create(FrmManager);
  with lblFirstDay do
    begin
      Left := 8;
      Top := 103;
      Width := 40;
      Height := 13;
      Caption := 'First day';
      Parent := FrmManager;
    end;

  lblLastDay := TLabel.Create(FrmManager);
  with lblLastDay do
    begin
      Left := 8;
      Top := 146;
      Width := 41;
      Height := 13;
      Caption := 'Last day';
      Parent := FrmManager;
    end;

  ChckBxGuide := TCheckBox.Create(FrmManager);
  with ChckBxGuide do
    begin
      Left := 208;
      Top := 8;
      Width := 97;
      Height := 17;
      Caption := 'Guide';
      TabOrder := 0;
      Parent := FrmManager;
    end;
  if Lodging[iLodge, 9] = 'none' then
    ChckBxGuide.Visible := false;

  DtTmPckrFirstDay := TDateTimePicker.Create(FrmManager);
  with DtTmPckrFirstDay do
    begin
      Left := 8;
      Top := 119;
      Width := 185;
      Height := 21;
      TabOrder := 1;
      Parent := FrmManager;
    end;

  DtTmPckrLastDay := TDateTimePicker.Create(FrmManager);
  with DtTmPckrLastDay do
    begin
      Left := 8;
      Top := 165;
      Width := 185;
      Height := 21;
      TabOrder := 2;
      Parent := FrmManager;
    end;

  btnQuote := TButton.Create(FrmManager);
  with btnQuote do
    begin
      Left := 208;
      Top := 33;
      Width := 97;
      Height := 25;
      Caption := 'Quote';
      TabOrder := 3;
      Parent := FrmManager;
      OnClick := btnQuoteClick;
    end;

  btnBook := TButton.Create(FrmManager);
  with btnBook do
    begin
      Left := 208;
      Top := 159;
      Width := 97;
      Height := 25;
      Caption := 'Book';
      TabOrder := 4;
      Parent := FrmManager;
      OnClick := btnBookClick;
    end;

  redOut := TRichEdit.Create(FrmManager);
  with redOut do
    begin
      Left := 8;
      Top := 8;
      Width := 185;
      Height := 89;
      Font.Charset := ANSI_CHARSET;
      Font.Color := clWindowText;
      Font.Height := -11;
      Font.Name := 'Tahoma';
      Font.Style := [];
      ParentFont := false;
      TabOrder := 5;
      Parent := FrmManager;
      Scrollbars := ssNone;
    end;

  redOutQoute := TRichEdit.Create(FrmManager);
  with redOutQoute do
    begin
      Left := 208;
      Top := 64;
      Width := 97;
      Height := 91;
      Font.Charset := ANSI_CHARSET;
      Font.Color := clWindowText;
      Font.Height := -11;
      Font.Name := 'Tahoma';
      Font.Style := [];
      ParentFont := false;
      TabOrder := 6;
      Parent := FrmManager;
    end;

  if Lodging[iLodge, 10] <> '0' then
    begin
      if (strtodate(Lodging[iLodge, 11]) <= Date) And
        (strtodate(Lodging[iLodge, 12]) >= Date) then
        begin
          bSale := true;
          showmessage('There is a ' + Lodging[iLodge, 10] +
              '% sale for this lodge');
        end
      else
        bSale := false;
    end
  else
    bSale := false;

  AssignFile(fileRead, 'Sale.txt');
  Reset(fileRead);
  ReadLn(fileRead, sLine);
  iPos := POS('#', sLine);
  Adminsale := Copy(sLine, 1, iPos - 1);
  delete(sLine, 1, iPos);
  iPos := POS('#', sLine);
  date1 := strtodate(Copy(sLine, 1, iPos - 1));
  delete(sLine, 1, iPos);
  date2 := strtodate(sLine);

  if (date1 <= Date) And (date2 >= Date) then
    showmessage('There is a ' + Adminsale + '% sale for the site')
  else
    Adminsale := '0';

  Booking := TBooking.Create(Lodging[iLodge, 1], strUsernameEn,
    Lodging[iLodge, 7], Lodging[iLodge, 8], Lodging[iLodge, 9],
    Lodging[iLodge, 10], Adminsale, bSale);

  redOut.Lines.Add('Lodge name: ' + Lodging[iLodge, 2]
      + #13 + 'Fishing type: ' + Lodging[iLodge, 3] + #13 + 'Location: ' +
      Lodging[iLodge, 4] + #13 + 'Number of roomsthe lodge has: ' + Lodging
      [iLodge, 5] + #13 + 'Number of people the lodge can acomidate: ' + Lodging
      [iLodge, 6] + #13 + 'Price per night(R): ' + Lodging[iLodge, 7] + #13 +
      'Price of housekeeping(R): ' + Lodging[iLodge, 8] + #13 +
      'Pirceof guide(R): ' + Lodging[iLodge, 9] + #13 + #13);

  adoQryBookings.Close;
  adoQryBookings.SQL.Text :=
    'SELECT [StartOfBooking],[EndOfBooking] FROM tblBooking WHERE LessorUser = '''
    + Booking.GetLessorUser + ''';';
  adoQryBookings.ExecSQL;
  adoQryBookings.Open;

  adoQryBookings.Open;
  adoQryBookings.first;
  while not adoQryDataB.Eof do
    begin
      redOut.Lines.Add('There is a booking from ' + datetostr
          (adoQryBookings['StartOfBooking']) + ' to ' + datetostr
          (adoQryBookings['EndOfBooking']) + #13);
      adoQryBookings.Next;
    end;
  adoQryBookings.Close;
end;

// =====================
procedure TFrmManager.btnQuoteClick(Sender: TObject);
begin
  Booking.SetStartOfBooking(DtTmPckrFirstDay.DateTime);
  Booking.SetEndOfBooking(DtTmPckrLastDay.DateTime);
  Booking.SetGuideSelected(ChckBxGuide.Checked);
  redOutQoute.Lines.Add(Booking.OutPutQoute);
end;

// =====================
procedure TFrmManager.btnBookClick(Sender: TObject);
var
  bContinue: Boolean;
  iPos: integer;
  rQuote: real;
  sOutput: string;
begin
  bContinue := true;
  // check if Dates are valid
  adoQryBookings.Close;
  adoQryBookings.SQL.Text :=
    'SELECT [StartOfBooking],[EndOfBooking] FROM tblBooking WHERE LessorUser = '''
    + Booking.GetLessorUser + ''';'; ;
  adoQryBookings.ExecSQL;
  adoQryBookings.Open;

  adoQryBookings.Open;
  adoQryBookings.first;
  while not adoQryBookings.Eof do
    begin
      if ((DtTmPckrFirstDay.DateTime >= adoQryBookings.FieldByName
            ('StartOfBooking').AsDateTime) and
          (DtTmPckrFirstDay.DateTime <= adoQryBookings.FieldByName
            ('EndOfBooking').AsDateTime)) or
        ((DtTmPckrLastDay.DateTime >= adoQryBookings.FieldByName
            ('StartOfBooking').AsDateTime) and
          (DtTmPckrLastDay.DateTime <= adoQryBookings.FieldByName
            ('EndOfBooking').AsDateTime)) then
        begin
          showmessage(
            'Sorry sometime during those sates hase already been booked please'
              + 'scroll down on by the details of the lodge');
          bContinue := false;
        end;
      adoQryBookings.Next;

    end;
  adoQryBookings.Close;

  // calculate qoute
  Booking.SetStartOfBooking(DtTmPckrFirstDay.DateTime);
  Booking.SetEndOfBooking(DtTmPckrLastDay.DateTime);
  Booking.SetGuideSelected(ChckBxGuide.Checked);
  rQuote := Booking.ClacQoute;

  // vefify
  if messageDlg('Are you sre you wnat to book this lodge for R' + floattostr
      (rQuote) + '?', mtWarning, [mbOk, mbCancel], 0) <> mrOk then
    bContinue := false;

  // create a booking
  sOutput := '';
  sOutput := strUsername + datetostr(DtTmPckrFirstDay.DateTime);
  iPos := POS('/', sOutput);
  delete(sOutput, iPos, 1);
  iPos := POS('/', sOutput);
  delete(sOutput, iPos, 1);
  showmessage('Please pay R' + floattostr(rQuote) +
      ' to FAKE ACCOUNT with reference: ' + sOutput);
  FrmManager.Visible := false;

  adoQryBookings.Close;
  adoQryBookings.SQL.Text := 'INSERT INTO tblBooking ' +
    '(LesseeUser, LessorUser, StartOfBooking, EndOfBooking, GuideSelected)' +
    ' VALUES (''' + strUsernameEn + ''', ''' + Booking.GetLessorUser + ''', ' +
    datetostr(DtTmPckrFirstDay.DateTime) + ', ' + datetostr
    (DtTmPckrLastDay.DateTime) + ', ' + booltostr(ChckBxGuide.Checked) + ')';
  adoQryBookings.ExecSQL;

  Booking.Free;
end;

// =============================================================================

function TFrmManager.getUsername: string;
begin
  result := strUsername;
end;

// =============================================================================

procedure TFrmManager.changePassword(sP: string);
begin
  encryptString(sP, strPasswordEn);
  adoQryDataB.Close;
  adoQryDataB.SQL.Text := 'UPDATE ' + table + ' SET [Password] = ' + QuotedStr
    (strPasswordEn) + ' WHERE ' + tableUser + ' = ''' + strUsernameEn + ''';';
  adoQryDataB.ExecSQL;
end;

// =============================================================================

function TFrmManager.CountAndSetUpBookings: integer;
var
  iLoop: integer;
begin
  adoQryBookings.Close;
  adoQryBookings.SQL.Text :=
    'SELECT * FROM tblBooking WHERE ' + tableUser + '  = ''' + uppercase
    (strUsernameEn) + ''';';
  adoQryBookings.ExecSQL;

  adoQryBookings.Open;
  adoQryBookings.first;
  for iLoop := 1 to adoBookings.RecordCount do
    begin
      Bookings[iLoop, 1] := inttostr(adoBookings['Booking']);
      Bookings[iLoop, 2] := datetostr(adoBookings['StartOfBooking']);
      Bookings[iLoop, 3] := datetostr(adoBookings['EndOfBooking']);
      if adoBookings['GuideSelected'] then
        Bookings[iLoop, 4] := 'Yes'
      else
        Bookings[iLoop, 4] := 'No';
    end;

  adoQryBookings.Close;

  result := adoBookings.RecordCount;
end;

// =====================

procedure TFrmManager.returnBookings(whichLodge: integer; var BookingNumber,
  startDte, endDte, guide: string);
begin
  BookingNumber := Bookings[whichLodge, 1];
  startDte := Bookings[whichLodge, 2];
  endDte := Bookings[whichLodge, 3];
  guide := Bookings[whichLodge, 4];
end;

// =====================
procedure TFrmManager.deleteBooking(whichLodge: string);
begin
  adoQryBookings.Close;
  adoQryBookings.SQL.Text :=
    'DELETE * FROM tblBooking WHERE Booking =' + whichLodge + ';';
  adoQryBookings.ExecSQL;
end;

// =============================================================================

procedure TFrmManager.getLodgeDetails(var sLodgeName, sFishingType, sLocation,
  sNumRooms, sNumPeps, sPricepernight, sPriceHousekeeping, sPriceguide: string;
  List: Boolean);
begin
  sLodgeName := '';
  sNumRooms := '0';
  sNumPeps := '0';
  sPricepernight := '0';
  sPriceHousekeeping := '0';
  sFishingType := '';
  sPriceguide := '0';
  List := false;

  sSql := 'SELECT * FROM tblLessorUser WHERE LessorUser = ''' + uppercase
    (strUsernameEn) + ''';';
  runTheSqlQuery;

  adoQryDataB.Open;
  adoQryDataB.first;
  if adoQryDataB['Lodging'] <> null then
    begin
      sLodgeName := adoQryDataB['Lodging'];
      sFishingType := adoQryDataB['FishingType'];
      sLocation := adoQryDataB['Location'];
      sNumRooms := inttostr(adoQryDataB['Rooms']);
      sNumPeps := inttostr(adoQryDataB['PeopleAbleToStay']);
      sPricepernight := inttostr(adoQryDataB['PricePerNight']);
      sPriceHousekeeping := inttostr(adoQryDataB['HouseKeeping']);
      sPriceguide := inttostr(adoQryDataB['Guide']);
      List := adoQryDataB['List'];
    end;

  adoQryDataB.Close;
end;

// =====================
procedure TFrmManager.setLodgeDetails(sLodgeName, sFishingType, sLocation,
  sNumRooms, sNumPeps, sPricepernight, sPriceHousekeeping, sPriceguide: string;
  List: Boolean);
begin
  adoQryDataB.Close;
  adoQryDataB.SQL.Text :=
    'UPDATE tblLessorUser SET Lodging = ''' +
    sLodgeName + ''' , FishingType = ''' + sFishingType +
    ''' , Location = ''' + sLocation + ''' , Rooms = ' + sNumRooms +
    ' , PeopleAbleToStay = ' + sNumPeps + ' , PricePerNight = ' +
    sPricepernight + ' , HouseKeeping = ' + sPriceHousekeeping +
    ' , Guide = ' + sPriceguide + ' , List = ' + booltostr(List)
    + ' WHERE [LessorUser] = ''' + strUsernameEn + ''';';
  adoQryDataB.ExecSQL;
end;

// =============================================================================

procedure TFrmManager.setUpSale(iTypeUser: integer);
begin
  FrmManager.Visible := true;
  FrmManager.Height := 130;
  FrmManager.Width := 217;

  DateTimePickerBegin := TDateTimePicker.Create(FrmManager);
  with DateTimePickerBegin do
    begin
      Left := 8;
      Top := 8;
      Width := 186;
      Height := 21;
      TabOrder := 0;
      Parent := FrmManager;
    end;

  DateTimePickerEnd := TDateTimePicker.Create(FrmManager);
  with DateTimePickerEnd do
    begin
      Left := 8;
      Top := 34;
      Width := 186;
      Height := 21;
      TabOrder := 0;
      Parent := FrmManager;
    end;

  BtnClose := TButton.Create(FrmManager);
  with BtnClose do
    begin
      Left := 8;
      Top := 60;
      Caption := 'Close';
      TabOrder := 1;
      Parent := FrmManager;
      if iTypeUser = 1 then
        OnClick := BtnLodgeSaleCloseclck
      else
        OnClick := BtnSiteSaleCloseclck;
    end;

  showmessage('Top picker is for the start of the sale, ' +
      'Bottom picker is for the end of the sale, ' +
      'A message dailog will come (when you click close) up to select price decrease, '
      + 'You can have only one sale at a time');
end;

// =====================
procedure TFrmManager.BtnLodgeSaleCloseclck(Sender: TObject);
var
  strInputPrice: string;
begin
  strInputPrice := inputBox('',
    'Please put in the pecentage decrease  of the price you would like',
    'i.e. 10');

  adoQryDataB.Close;
  adoQryDataB.SQL.Text := 'UPDATE tblLessorUser SET Sale = ' + strInputPrice +
    ', SaleStart = #' + datetostr(DateTimePickerBegin.DateTime)
    + '#, SaleEnd = #' + datetostr(DateTimePickerEnd.DateTime)
    + '# WHERE LessorUser = ''' + strUsernameEn + ''';';
  adoQryDataB.ExecSQL;

  FrmManager.Visible := false;
end;

// =====================
procedure TFrmManager.BtnSiteSaleCloseclck(Sender: TObject);
var
  strInputPrice: string;
  sLine: string;
  fileWrite: textfile;
begin
  strInputPrice := inputBox('',
    'Please put in the pecentage decrease  of the price you would like',
    'i.e. 10');

  sLine := strInputPrice + '#' + datetostr(DateTimePickerBegin.DateTime)
    + '#' + datetostr(DateTimePickerEnd.DateTime);

  AssignFile(fileWrite, 'Sale.txt');
  ReWrite(fileWrite);
  WriteLn(fileWrite, sLine);
  CloseFile(fileWrite);

  FrmManager.Visible := false;
end;

// =============================================================================

function TFrmManager.CheckForUser(strInptUsrNme, strInptTbl: string): Boolean;
begin
  encryptString(strInptUsrNme, strUsernameEn);

  if strInptTbl = 'Lessee' then
    begin
      adoQryLessee.Close;
      adoQryLessee.SQL.Text :=
        'SELECT [LesseeUser]FROM tblLesseeUser WHERE LesseeUser = ''' +
        strUsernameEn + ''';';
      adoQryLessee.ExecSQL;

      adoQryLessee.Open;
      adoQryLessee.first;
      if adoQryLessee['LessorUser'] <> uppercase(strUsernameEn) then
        result := false
      else
        result := true;
      adoQryLessee.Close;
    end
  else
    begin
      adoQryLessor.Close;
      adoQryLessor.SQL.Text :=
        'SELECT [LessorUser] FROM tblLessorUser WHERE LessorUser = ''' +
        strUsernameEn + ''';';
      adoQryLessor.ExecSQL;

      adoQryLessor.Open;
      adoQryLessor.first;
      if adoQryLessor['LessorUser'] <> uppercase(strUsernameEn) then
        result := false
      else
        result := true;
      adoQryLessor.Close;
    end;
end;

// =====================
procedure TFrmManager.NewUserPassword(strInptTbl, strInptNwPsswrd: string);
begin
  encryptString(strInptNwPsswrd, strPasswordEn);

  if strInptTbl = 'Lessee' then
    begin
      adoQryLessee.Close;
      adoQryLessee.SQL.Text :=
        'UPDATE tblLesseeUser SET [Password] = ' + QuotedStr(strPasswordEn)
        + ' WHERE LesseeUser = ''' + strUsernameEn + ''';';
      adoQryLessee.ExecSQL;
    end
  else
    begin
      adoQryLessor.Close;
      adoQryLessor.SQL.Text :=
        'UPDATE tblLessorUser SET [Password] = ' + QuotedStr(strPasswordEn)
        + ' WHERE LessorUser = ''' + strUsernameEn + ''';';
      adoQryLessor.ExecSQL;
    end;
end;

// =============================================================================

function TFrmManager.CntUncnfrmdLdgngs: integer;
begin
  adoQryLessor.Close;
  adoQryLessor.SQL.Text :=
    'SELECT * FROM tblLessorUser WHERE ([Confirmed] = NO) and ([List] = YES);';
  adoQryLessor.ExecSQL;
  adoQryLessor.Open;
  adoQryLessor.first;
  result := adoQryLessor.RecordCount;
end;

// =====================
procedure TFrmManager.UncnfrmdLdgng(var sLodgeName, sFishingType,
  sLocation: string);
begin
  sLodgeName := adoQryLessor['Lodging'];
  sFishingType := adoQryLessor['FishingType'];
  sLocation := adoQryLessor['Location'];
  adoQryLessor.Next;
end;

// =====================
procedure TFrmManager.CnfrmLdgng(whichLodge: string);
begin
  adoQryLessor.Close;
  adoQryLessor.SQL.Text :=
    'UPDATE tblLessorUser SET Confirmed = Yes WHERE [Lodging] = ''' +
    whichLodge + ''';';
  adoQryLessor.ExecSQL;
end;

// =============================================================================

procedure TFrmManager.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  FrmManager.Visible := false;
end;

end.
