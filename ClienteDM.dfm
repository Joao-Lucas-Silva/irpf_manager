object ClienteDtm: TClienteDtm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 264
  Width = 375
  object qryCliente: TFDQuery
    Connection = ConexaoDtm.Conexao
    SQL.Strings = (
      'SELECT c.cod_cliente,'
      '       c.nome_cliente,'
      '       c.cpf,'
      '       c.apelido,'
      '       c.titulo_eleitor,'
      '       c.endereco,'
      '       c.bairro,'
      '       c.cidade,'
      '       c.estado,'
      '       c.cep,'
      '       c.numero,'
      '       c.nome_conjugue,'
      '       c.cpf_conjugue,'
      '       c.nome_dependente1,'
      '       c.cpf_dependente1,'
      '       c.parentesco_depentente1,'
      '       c.nome_dependente2,'
      '       c.cpf_dependente2,'
      '       c.parentesco_depentente2,'
      '       c.nome_dependente3,'
      '       c.cpf_dependente3,'
      '       c.parentesco_depentente3,'
      '       c.nome_dependente4,'
      '       c.cpf_dependente4,'
      '       c.parentesco_depentente4,'
      '       c.nome_dependente5,'
      '       c.cpf_dependente5,'
      '       c.parentesco_depentente5,'
      '       c.ultima_checagem,'
      '       c.data_cadastro'
      'FROM cliente c'
      'LIMIT 0')
    Left = 48
    Top = 32
  end
  object qryGrid: TFDQuery
    Connection = ConexaoDtm.Conexao
    SQL.Strings = (
      'SELECT c.cod_cliente,'
      '       c.nome_cliente,'
      '       c.cpf,'
      '       c.apelido'
      'FROM cliente c'
      'LIMIT 0')
    Left = 128
    Top = 32
    object qryGridcod_cliente: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = 'CONTROLE'
      FieldName = 'cod_cliente'
      Origin = 'cod_cliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '000'
    end
    object qryGridnome_cliente: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'NOME'
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 45
    end
    object qryGridcpf: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
      Origin = 'cpf'
    end
    object qryGridapelido: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'APELIDO'
      FieldName = 'apelido'
      Origin = 'apelido'
      Size = 45
    end
  end
end
