object FrmManager: TFrmManager
  Left = 522
  Top = 260
  ClientHeight = 209
  ClientWidth = 187
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object conDataB: TADOConnection
    Left = 144
    Top = 160
  end
  object adoQryLessee: TADOQuery
    Parameters = <>
    Left = 80
    Top = 8
  end
  object adoLessee: TADOTable
    Left = 16
    Top = 8
  end
  object adoLessor: TADOTable
    Left = 16
    Top = 56
  end
  object adoQryLessor: TADOQuery
    Parameters = <>
    Left = 80
    Top = 56
  end
  object adoBookings: TADOTable
    Left = 16
    Top = 104
  end
  object adoQryBookings: TADOQuery
    Parameters = <>
    Left = 80
    Top = 104
  end
  object adoQryDataB: TADOQuery
    Parameters = <>
    Left = 80
    Top = 160
  end
  object adoDataB: TADOTable
    Left = 16
    Top = 160
  end
end
