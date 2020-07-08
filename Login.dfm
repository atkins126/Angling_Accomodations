object FrmLogin: TFrmLogin
  Left = 507
  Top = 332
  Caption = 'Login'
  ClientHeight = 78
  ClientWidth = 197
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object BtnSignUp: TButton
    Left = 8
    Top = 8
    Width = 184
    Height = 25
    Caption = 'Sign up'
    TabOrder = 0
    OnClick = BtnSignUpClick
  end
  object BtnLogin: TButton
    Left = 8
    Top = 47
    Width = 184
    Height = 25
    Caption = 'Sign in'
    TabOrder = 1
    OnClick = BtnLoginClick
  end
end
