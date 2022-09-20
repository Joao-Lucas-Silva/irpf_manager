program ir_manager;

uses
  Vcl.Forms,
  PrincipalForm in 'PrincipalForm.pas' {PrincipalFrm},
  ConexaoDM in 'ConexaoDM.pas' {ConexaoDtm: TDataModule},
  ConexaoForm in 'ConexaoForm.pas' {ConexaoFrm},
  FerramentasForm in 'FerramentasForm.pas' {FerramentasFrm},
  MsgPadraoForm in 'MsgPadraoForm.pas' {MsgPadraoFrm},
  ConfiguracoesForm in 'ConfiguracoesForm.pas' {ConfiguracoesFrm},
  CadastrosChecklistIrpfForm in 'CadastrosChecklistIrpfForm.pas' {CadastrosChecklistIrpfFrm},
  ClienteDM in 'ClienteDM.pas' {ClienteDtm: TDataModule},
  CadastrosClienteForm in 'CadastrosClienteForm.pas' {CadastrosClienteFrm},
  NovoClienteForm in 'NovoClienteForm.pas' {NovoClienteFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConexaoDtm, ConexaoDtm);
  Application.CreateForm(TPrincipalFrm, PrincipalFrm);
  Application.CreateForm(TFerramentasFrm, FerramentasFrm);
  Application.Run;
end.
