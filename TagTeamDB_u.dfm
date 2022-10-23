object dmTagTeam: TdmTagTeam
  OldCreateOrder = False
  Height = 387
  Width = 453
  object conTagTeam: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=TagTeamDB.mdb;Persi' +
      'st Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 72
    Top = 192
  end
  object tblEVENT: TADOTable
    Active = True
    Connection = conTagTeam
    CursorType = ctStatic
    TableName = 'EVENT'
    Left = 152
    Top = 144
  end
  object tblSEASON: TADOTable
    Active = True
    Connection = conTagTeam
    CursorType = ctStatic
    TableName = 'SEASON'
    Left = 152
    Top = 288
  end
  object tblRESULT: TADOTable
    Active = True
    Connection = conTagTeam
    CursorType = ctStatic
    TableName = 'RESULT'
    Left = 152
    Top = 192
  end
  object tblPODIUM: TADOTable
    Active = True
    Connection = conTagTeam
    CursorType = ctStatic
    TableName = 'PODIUM'
    Left = 152
    Top = 240
  end
  object tblTEAM: TADOTable
    Active = True
    Connection = conTagTeam
    CursorType = ctStatic
    TableName = 'TEAM'
    Left = 152
    Top = 96
  end
  object tblUSER: TADOTable
    Active = True
    Connection = conTagTeam
    CursorType = ctStatic
    TableName = 'USER_table'
    Left = 152
    Top = 48
  end
  object dscTEAM: TDataSource
    DataSet = tblTEAM
    Left = 240
    Top = 96
  end
  object dscEVENT: TDataSource
    DataSet = tblEVENT
    Left = 240
    Top = 144
  end
  object dscUSER: TDataSource
    DataSet = tblUSER
    Left = 240
    Top = 48
  end
  object dscRESULT: TDataSource
    DataSet = tblRESULT
    Left = 240
    Top = 192
  end
  object dscPODIUM: TDataSource
    DataSet = tblPODIUM
    Left = 240
    Top = 240
  end
  object dscSEASON: TDataSource
    DataSet = tblSEASON
    Left = 240
    Top = 288
  end
end
