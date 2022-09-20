object ConexaoDtm: TConexaoDtm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=irpf_manager'
      'User_Name=root'
      'Password=23092001'
      'UseSSL=True'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 104
    Top = 72
  end
  object cmd: TFDCommand
    Connection = Conexao
    Left = 40
    Top = 72
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Delphi\irpf_manager\EXE\libmysql.dll'
    Left = 48
    Top = 16
  end
end
