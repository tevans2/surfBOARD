object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 330
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 56
    Width = 90
    Height = 33
    Caption = 'LOGIN'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 65
    Top = 117
    Width = 52
    Height = 13
    Caption = 'Username:'
  end
  object Label3: TLabel
    Left = 65
    Top = 173
    Width = 50
    Height = 13
    Caption = 'Password:'
  end
  object edtUsername: TEdit
    Left = 65
    Top = 136
    Width = 144
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 65
    Top = 192
    Width = 144
    Height = 21
    TabOrder = 1
  end
  object btnLOGIN: TButton
    Left = 65
    Top = 248
    Width = 144
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnLOGINClick
  end
end
