object FrmLessor: TFrmLessor
  Left = 440
  Top = 263
  Caption = 'Lessor'
  ClientHeight = 232
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 8
    Top = 8
    Width = 345
    Height = 217
    TabOrder = 0
    object btneditlodge: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Create/Edit Lodging'
      TabOrder = 0
      OnClick = btneditlodgeClick
    end
    object btnChngPsswrd: TButton
      Left = 230
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Change password'
      TabOrder = 1
      OnClick = btnChngPsswrdClick
    end
    object btnSetUpSale: TButton
      Left = 8
      Top = 55
      Width = 327
      Height = 35
      Caption = '!!!Set up Sale!!!'
      TabOrder = 2
      OnClick = btnSetUpSaleClick
    end
    object BtnBookings: TButton
      Left = 119
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Bookings'
      TabOrder = 3
      OnClick = BtnBookingsClick
    end
    object redOut: TRichEdit
      Left = 8
      Top = 96
      Width = 327
      Height = 110
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
end
