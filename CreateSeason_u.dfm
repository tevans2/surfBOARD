object frmSEASONCreate: TfrmSEASONCreate
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmSEASONCreate'
  ClientHeight = 726
  ClientWidth = 1109
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcnrtlSEASONCreate: TPageControl
    Left = 48
    Top = 40
    Width = 929
    Height = 529
    ActivePage = tbshtSEASON
    TabOrder = 0
    object tbshtSEASON: TTabSheet
      Caption = 'Create Season'
      object dbgSEASON: TDBGrid
        Left = 24
        Top = 41
        Width = 865
        Height = 329
        DataSource = dmTagTeam.dscSEASON
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = dbgSEASONCellClick
      end
      object pnlSEASONCreate: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 264
          Top = 21
          Width = 86
          Height = 13
          Caption = 'Season End Date:'
        end
        object Label2: TLabel
          Left = 24
          Top = 21
          Width = 95
          Height = 13
          Caption = 'Season Start  Date:'
        end
        object dpStart: TDatePicker
          Left = 24
          Top = 40
          Date = 44848.000000000000000000
          DateFormat = 'yyyy/MM/dd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          TabOrder = 0
        end
        object dpEnd: TDatePicker
          Left = 264
          Top = 40
          Date = 44848.000000000000000000
          DateFormat = 'yyyy/MM/dd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          TabOrder = 1
        end
        object btnSEASONSave: TButton
          Left = 518
          Top = 40
          Width = 163
          Height = 32
          Caption = 'Save'
          TabOrder = 2
          OnClick = btnSEASONSaveClick
        end
        object btnSEASONCancel: TButton
          Left = 687
          Top = 40
          Width = 163
          Height = 32
          Caption = 'Cancel'
          TabOrder = 3
          OnClick = btnSEASONCancelClick
        end
      end
      object pnlSEASONButtons: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 2
        object btnSEASONCreate: TButton
          Left = 0
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Create New Season'
          TabOrder = 0
          OnClick = btnSEASONCreateClick
        end
        object btnSEASONEdit: TButton
          Left = 328
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Edit Existing Season'
          TabOrder = 1
          OnClick = btnSEASONEditClick
        end
        object btnSEASONDelete: TButton
          Left = 647
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Delete Season'
          TabOrder = 2
          OnClick = btnSEASONDeleteClick
        end
      end
    end
    object tbshtTEAM: TTabSheet
      Caption = 'Add Teams'
      ImageIndex = 1
      object pnlTEAMButtons: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 0
        object btnTEAMCreate: TButton
          Left = 0
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Create New Team'
          TabOrder = 0
          OnClick = btnTEAMCreateClick
        end
        object btnTEAMEdit: TButton
          Left = 328
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Edit Existing Team'
          TabOrder = 1
          OnClick = btnTEAMEditClick
        end
        object btnTEAMDelete: TButton
          Left = 647
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Delete Team'
          TabOrder = 2
          OnClick = btnTEAMDeleteClick
        end
      end
      object dbgTEAM: TDBGrid
        Left = 24
        Top = 41
        Width = 865
        Height = 329
        DataSource = dmTagTeam.dscTEAM
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = dbgTEAMCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'team_name'
            Visible = True
          end>
      end
      object pnlTEAMCreate: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 2
        object Label8: TLabel
          Left = 25
          Top = 23
          Width = 60
          Height = 13
          Caption = 'Team Name:'
        end
        object btnTEAMSave: TButton
          Left = 502
          Top = 34
          Width = 163
          Height = 30
          Caption = 'Save'
          TabOrder = 0
          OnClick = btnTEAMSaveClick
        end
        object btnTEAMCancel: TButton
          Left = 687
          Top = 32
          Width = 163
          Height = 32
          Caption = 'Cancel'
          TabOrder = 1
          OnClick = btnTEAMCancelClick
        end
        object edtTeamName: TEdit
          Left = 25
          Top = 42
          Width = 168
          Height = 21
          TabOrder = 2
        end
      end
    end
    object tbshtUSER: TTabSheet
      Caption = 'Add Users'
      ImageIndex = 2
      object pnlUSERButtons: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 122
        BevelOuter = bvNone
        TabOrder = 0
        object btnUSERCreate: TButton
          Left = 0
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Create New User'
          TabOrder = 0
          OnClick = btnUSERCreateClick
        end
        object btnUSEREdit: TButton
          Left = 328
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Edit Existing User'
          TabOrder = 1
          OnClick = btnUSEREditClick
        end
        object btnUSERDelete: TButton
          Left = 647
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Delete User'
          TabOrder = 2
          OnClick = btnUSERDeleteClick
        end
        object btnLoadFromFile: TButton
          Left = 0
          Top = 79
          Width = 217
          Height = 25
          Caption = 'Load Surfers from Text File'
          TabOrder = 3
          OnClick = btnLoadFromFileClick
        end
      end
      object dbgUSER: TDBGrid
        Left = 24
        Top = 41
        Width = 865
        Height = 329
        DataSource = dmTagTeam.dscUSER
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = dbgUSERCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'type'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'teamID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'first_name'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'surname'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cell_no'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Visible = True
          end>
      end
      object pnlUSERCreate: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 2
        object Label10: TLabel
          Left = 25
          Top = 60
          Width = 55
          Height = 13
          Caption = 'First Name:'
        end
        object Label12: TLabel
          Left = 169
          Top = 60
          Width = 46
          Height = 13
          Caption = 'Surname:'
        end
        object Label7: TLabel
          Left = 24
          Top = 7
          Width = 53
          Height = 13
          Caption = 'User Type:'
        end
        object Label13: TLabel
          Left = 168
          Top = 6
          Width = 30
          Height = 13
          Caption = 'Team:'
        end
        object Label14: TLabel
          Left = 464
          Top = 63
          Width = 91
          Height = 13
          Caption = 'Cellphone Number:'
        end
        object Label15: TLabel
          Left = 313
          Top = 63
          Width = 28
          Height = 13
          Caption = 'Email:'
        end
        object btnUSERSave: TButton
          Left = 687
          Top = 26
          Width = 163
          Height = 32
          Caption = 'Save'
          TabOrder = 0
          OnClick = btnUSERSaveClick
        end
        object btnUSERCancel: TButton
          Left = 687
          Top = 64
          Width = 163
          Height = 32
          Caption = 'Cancel'
          TabOrder = 1
          OnClick = btnUSERCancelClick
        end
        object edtFirstName: TEdit
          Left = 25
          Top = 79
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object edtUserSurname: TEdit
          Left = 169
          Top = 79
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object cbbUserType: TComboBox
          Left = 25
          Top = 26
          Width = 120
          Height = 21
          Style = csDropDownList
          TabOrder = 4
          OnChange = cbbUserTypeChange
          Items.Strings = (
            'Surfer'
            'Coach'
            'Judge')
        end
        object cbbUserTeam: TComboBox
          Left = 168
          Top = 25
          Width = 120
          Height = 21
          Style = csDropDownList
          TabOrder = 5
        end
        object edtEmail: TEdit
          Left = 313
          Top = 79
          Width = 121
          Height = 21
          TabOrder = 6
        end
        object edtCell: TEdit
          Left = 464
          Top = 79
          Width = 121
          Height = 21
          TabOrder = 7
        end
      end
    end
    object tbshtEvent: TTabSheet
      Caption = 'Event Schedule'
      ImageIndex = 3
      object dbgEVENT: TDBGrid
        Left = 40
        Top = 41
        Width = 849
        Height = 329
        DataSource = dmTagTeam.dscEVENT
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = dbgEVENTCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'event_date'
            Visible = True
          end>
      end
      object pnlEVENTButtons: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 121
        BevelOuter = bvNone
        TabOrder = 1
        object btnEVENTCreate: TButton
          Left = 0
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Create New Event'
          TabOrder = 0
          OnClick = btnEVENTCreateClick
        end
        object btnEVENTEdit: TButton
          Left = 328
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Edit Existing Event'
          TabOrder = 1
          OnClick = btnEVENTEditClick
        end
        object btnEVENTDelete: TButton
          Left = 647
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Delete Event'
          TabOrder = 2
          OnClick = btnEVENTDeleteClick
        end
      end
      object pnlEVENTCreate: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 2
        object Label3: TLabel
          Left = 299
          Top = 15
          Width = 58
          Height = 13
          Caption = 'Event Date:'
        end
        object lblSeasonDates: TLabel
          Left = 16
          Top = 34
          Width = 4
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 16
          Top = 15
          Width = 75
          Height = 13
          Caption = 'Season Length:'
        end
        object btnEVENTSave: TButton
          Left = 687
          Top = 34
          Width = 163
          Height = 32
          Caption = 'Save'
          TabOrder = 0
          OnClick = btnEVENTSaveClick
        end
        object btnEVENTCancel: TButton
          Left = 687
          Top = 72
          Width = 163
          Height = 32
          Caption = 'Cancel'
          TabOrder = 1
          OnClick = btnEVENTCancelClick
        end
        object dpEVENTDate: TDatePicker
          Left = 299
          Top = 34
          Height = 21
          Date = 44848.000000000000000000
          DateFormat = 'yyyy/MM/dd'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          TabOrder = 2
        end
      end
    end
  end
  object btnFinishSeasonSetup: TButton
    Left = 76
    Top = 575
    Width = 865
    Height = 42
    Caption = 'FINISH SEASON SETUP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnFinishSeasonSetupClick
  end
  object btnCancelSeasonSetup: TButton
    Left = 120
    Top = 623
    Width = 777
    Height = 42
    Caption = 'CANCEL SEASON SETUP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelSeasonSetupClick
  end
  object OpenDlgFilePicker: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 1024
    Top = 240
  end
end
