object FrmAdmin: TFrmAdmin
  Left = 429
  Top = 259
  Caption = 'Admin'
  ClientHeight = 234
  ClientWidth = 382
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
    Left = 6
    Top = 8
    Width = 369
    Height = 217
    TabOrder = 0
    object btnConfirm: TButton
      Left = 12
      Top = 8
      Width = 173
      Height = 41
      Caption = 'Confirm Lodgings'
      TabOrder = 0
      OnClick = btnConfirmClick
    end
    object btnChangePassword: TButton
      Left = 191
      Top = 8
      Width = 170
      Height = 41
      Caption = 'Change users password'
      TabOrder = 1
      OnClick = btnChangePasswordClick
    end
    object btnSetUpSale: TButton
      Left = 12
      Top = 55
      Width = 349
      Height = 35
      Caption = '!!!Set up Sale!!!'
      TabOrder = 2
      OnClick = btnSetUpSaleClick
    end
    object redOut: TRichEdit
      Left = 12
      Top = 99
      Width = 349
      Height = 110
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Hello Admin')
      ParentFont = False
      TabOrder = 3
    end
  end
end
