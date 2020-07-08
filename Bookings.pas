unit Bookings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, Grids, DBGrids, StdCtrls, ComCtrls, DateUtils;

type
  TBooking = class
    fLesseeUser: string;
    fLessorUser: string;
    fStartOfBooking: tdate;
    fEndOfBooking: tdate;
    fGuideSelected: boolean;
    fPricePerNight: integer;
    fHouseKeeping: integer;
    fGuide: integer;
    fSale: integer;
    fBSale: boolean;
    FAdminSale: integer;
  private
    //
  public
    constructor Create(sLessorUser, sLesseeUser, sPricePerNight, sHouseKeeping,
      sGuide, sSale, sAdminSale: string; bSale: boolean);
    // mutator
    procedure SetStartOfBooking(dStartOfBooking: tdate);
    procedure SetEndOfBooking(dEndOfBooking: tdate);
    procedure SetGuideSelected(BGuideSelected: boolean);
    // acessor
    function GetLessorUser: string;

    function ClacQoute: real;
    function OutPutQoute: string;
    procedure returnDetaillsforboking(Var sLessorUser, sLesseeUser: string);
  end;

implementation

{ TBooking }

constructor TBooking.Create(sLessorUser, sLesseeUser, sPricePerNight,
  sHouseKeeping, sGuide, sSale, sAdminSale: string; bSale: boolean);
begin
  fLessorUser := sLessorUser;
  fLesseeUser := sLesseeUser;
  fPricePerNight := strtoint(sPricePerNight);
  if sHouseKeeping <> 'none' then
    fHouseKeeping := strtoint(sHouseKeeping)
  else
    fHouseKeeping := 0;

  if sGuide <> 'none' then
    fGuide := strtoint(sGuide)
  else
    fGuide := 0;
  fBSale := bSale;
  if fBSale = true then
    fSale := strtoint(sSale)
  else
    fSale := 0;
  FAdminSale := strtoint(sAdminSale);
end;

// =============================================================================

function TBooking.GetLessorUser: string;
begin
  result := fLessorUser;
end;

// =============================================================================

procedure TBooking.SetStartOfBooking(dStartOfBooking: tdate);
begin
  fStartOfBooking := dStartOfBooking;
end;

// =============================================================================

procedure TBooking.SetEndOfBooking(dEndOfBooking: tdate);
begin
  fEndOfBooking := dEndOfBooking;
end;

// =============================================================================

procedure TBooking.SetGuideSelected(BGuideSelected: boolean);
begin
  fGuideSelected := BGuideSelected;
end;

// =============================================================================

function TBooking.ClacQoute: real;
var
  iDays: integer;
begin
  iDays := DaysBetween(fEndOfBooking, fStartOfBooking);
  result := 0;
  if fGuideSelected = true then
    result := result + fGuide;
  result := result + strtofloat(inttostr(fPricePerNight + fHouseKeeping));
  result := result * (1 + (15 / 100));
  if fBSale = true then
    result := result * (1 - (fSale / 100));
  result := result * (1 - (FAdminSale / 100));
  result := result * strtofloat(inttostr(iDays));
end;

// =============================================================================

function TBooking.OutPutQoute: string;
begin
  result := 'Total cost: R' + floattostr(ClacQoute);
end;

// =============================================================================

procedure TBooking.returnDetaillsforboking(var sLessorUser,
  sLesseeUser: string);
begin
  sLessorUser := fLessorUser;
  sLesseeUser := fLesseeUser;
end;

end.
