object FrmLessee: TFrmLessee
  Left = 440
  Top = 263
  Caption = 'Lessee'
  ClientHeight = 234
  ClientWidth = 360
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 8
    Top = 8
    Width = 345
    Height = 217
    TabOrder = 0
    object btnfndLodge: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Search for Lodgings'
      TabOrder = 0
      OnClick = btnfndLodgeClick
    end
    object Btnbookings: TButton
      Left = 119
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Bookings'
      TabOrder = 1
      OnClick = BtnbookingsClick
    end
    object btnChngPsswrd: TButton
      Left = 230
      Top = 8
      Width = 105
      Height = 41
      Caption = 'Change password'
      TabOrder = 2
      OnClick = btnChngPsswrdClick
    end
    object redOut: TRichEdit
      Left = 8
      Top = 55
      Width = 327
      Height = 154
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
