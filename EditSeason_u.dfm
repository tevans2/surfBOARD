object frmSEASONEdit: TfrmSEASONEdit
  Left = 0
  Top = 0
  Caption = 'frmSEASONEdit'
  ClientHeight = 636
  ClientWidth = 1095
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcnrtlSEASONEdit: TPageControl
    Left = 40
    Top = 56
    Width = 929
    Height = 529
    ActivePage = tbshtSEASONRANK
    TabOrder = 0
    object tbshtSEASON: TTabSheet
      Caption = 'Select Season'
      ExplicitLeft = 0
      object Panel1: TPanel
        Left = 272
        Top = 80
        Width = 385
        Height = 345
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 88
          Top = 85
          Width = 71
          Height = 13
          Caption = 'Select Season:'
        end
        object btnSEASONCreate: TButton
          Left = 88
          Top = 263
          Width = 201
          Height = 41
          Caption = 'Create New Season'
          TabOrder = 0
          OnClick = btnSEASONCreateClick
        end
        object btnSEASONSelect: TButton
          Left = 88
          Top = 216
          Width = 201
          Height = 41
          Caption = 'Select Season'
          TabOrder = 1
          OnClick = btnSEASONSelectClick
        end
        object cbbSeasonSelect: TComboBox
          Left = 88
          Top = 104
          Width = 201
          Height = 21
          Style = csDropDownList
          TabOrder = 2
        end
      end
      object Button1: TButton
        Left = 704
        Top = 353
        Width = 75
        Height = 25
        Caption = 'Setup Podium'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object tbshtRESULT: TTabSheet
      Caption = 'Enter Results'
      ImageIndex = 4
      object dbgRESULT: TDBGrid
        Left = 24
        Top = 41
        Width = 865
        Height = 329
        DataSource = dmTagTeam.dscRESULT
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
        OnCellClick = dbgRESULTCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'userID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'eventID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'judgeID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'result'
            Visible = True
          end>
      end
      object pnlRESULTCreate: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        TabOrder = 1
        object Label2: TLabel
          Left = 611
          Top = 48
          Width = 4
          Height = 16
          Caption = '.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 29
          Top = 21
          Width = 58
          Height = 13
          Caption = 'Select User:'
        end
        object Label17: TLabel
          Left = 197
          Top = 21
          Width = 64
          Height = 13
          Caption = 'Select Event:'
        end
        object Label18: TLabel
          Left = 533
          Top = 21
          Width = 34
          Height = 13
          Caption = 'Result:'
        end
        object Label19: TLabel
          Left = 365
          Top = 21
          Width = 65
          Height = 13
          Caption = 'Select Judge:'
        end
        object cbbUser: TComboBox
          Left = 29
          Top = 40
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object cbbEvent: TComboBox
          Left = 197
          Top = 40
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
        object edtResult1: TEdit
          Left = 533
          Top = 40
          Width = 33
          Height = 21
          TabOrder = 2
          OnChange = edtResult1Change
        end
        object edtResult2: TEdit
          Left = 572
          Top = 40
          Width = 33
          Height = 21
          TabOrder = 3
          OnChange = edtResult2Change
        end
        object edtResult3: TEdit
          Left = 621
          Top = 40
          Width = 33
          Height = 21
          TabOrder = 4
          OnChange = edtResult3Change
        end
        object cbbJudge: TComboBox
          Left = 365
          Top = 40
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 5
        end
        object btnRESULTSave: TButton
          Left = 679
          Top = 20
          Width = 163
          Height = 30
          Caption = 'Save'
          TabOrder = 6
          OnClick = btnRESULTSaveClick
        end
        object btnRESULTCancel: TButton
          Left = 679
          Top = 56
          Width = 163
          Height = 32
          Caption = 'Cancel'
          TabOrder = 7
          OnClick = btnRESULTCancelClick
        end
      end
      object pnlRESULTButtons: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
        BevelOuter = bvNone
        TabOrder = 2
        object btnRESULTCreate: TButton
          Left = 0
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Create New Result'
          TabOrder = 0
          OnClick = btnRESULTCreateClick
        end
        object btnRESULTDelete: TButton
          Left = 648
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Delete Result'
          TabOrder = 1
          OnClick = btnRESULTDeleteClick
        end
        object btnRESULTEdit: TButton
          Left = 328
          Top = 32
          Width = 217
          Height = 41
          Caption = 'Edit Existing Result'
          TabOrder = 2
          OnClick = btnRESULTEditClick
        end
      end
    end
    object tbshtTEAM: TTabSheet
      Caption = 'Team List'
      ImageIndex = 1
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
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'teamID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'team_name'
            Visible = True
          end>
      end
    end
    object tbshtUSER: TTabSheet
      Caption = 'Edit Users'
      ImageIndex = 2
      object pnlUSERButtons: TPanel
        Left = 24
        Top = 376
        Width = 865
        Height = 105
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
        object edtUserName: TEdit
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
        Left = 24
        Top = 41
        Width = 865
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
        Columns = <
          item
            Expanded = False
            FieldName = 'event_date'
            Visible = True
          end>
      end
    end
    object tbshtSEASONRANK: TTabSheet
      Caption = 'Season Rankings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 5
      ParentFont = False
      OnEnter = tbshtSEASONRANKEnter
      object pnlSeasonRank: TPanel
        Left = 224
        Top = 17
        Width = 457
        Height = 465
        TabOrder = 0
        object stgSEASONRANK: TStringGrid
          Left = 48
          Top = 24
          Width = 393
          Height = 417
          TabOrder = 0
        end
      end
    end
  end
end
