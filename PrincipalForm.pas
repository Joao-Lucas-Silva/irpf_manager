{
Projeto pessoal para auxiliar na declara��o de IRPF.
Por: Jo�o Lucas.
}
unit PrincipalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.StdCtrls;

type
  TPrincipalFrm = class(TForm)
    ActionList1: TActionList;
    actConfiguracoes: TAction;
    actSair: TAction;
    ActionList2: TActionList;
    actCadastrarClientes: TAction;
    actCheckListsIRRF: TAction;
    ImageList2: TImageList;
    ImageList3: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel3: TPanel;
    btnSair: TSpeedButton;
    btnConfiguracoes: TSpeedButton;
    Panel4: TPanel;
    lblSaudacoes: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actCadastrarClientesExecute(Sender: TObject);
  private
    { Private declarations }
    function Conectar():boolean;
    function Saudacoes():string;
  public
    { Public declarations }
    Caminho:string;
    procedure Iniciar();
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

{$R *.dfm}

uses ConexaoDM, FerramentasForm, ConexaoForm, ConfiguracoesForm,
  CadastrosClienteForm, FireDAC.Comp.Client;

procedure TPrincipalFrm.actCadastrarClientesExecute(Sender: TObject);
begin
  Application.CreateForm(TCadastrosClienteFrm,CadastrosClienteFrm);
  try
    CadastrosClienteFrm.ShowModal;
  finally
    FreeAndNil(CadastrosClienteFrm);
  end;
end;

procedure TPrincipalFrm.actConfiguracoesExecute(Sender: TObject);
begin
  Application.CreateForm(TConfiguracoesFrm,ConfiguracoesFrm);
  try
    ConfiguracoesFrm.ShowModal;
  finally
    FreeAndNil(ConfiguracoesFrm);
  end;
end;

procedure TPrincipalFrm.actSairExecute(Sender: TObject);
begin
  if (Application.MessageBox('DESEJA REALMENTE SAIR DO SISTEMA?','SAIR',MB_YESNO+MB_ICONQUESTION)=IDYES) then
    Close;
end;

function TPrincipalFrm.Conectar: boolean;
var
  lParametrosConexao:TStringList;
  i:integer;
begin
  Result:=False;

  lParametrosConexao:=TStringList.Create;
  lParametrosConexao.LoadFromFile(PrincipalFrm.Caminho+'DadosConexao.txt');

  if (ConexaoDtm.Conexao.Connected=True) then
      ConexaoDtm.Conexao.Connected:=False;
  ConexaoDtm.Conexao.Params.Clear;
  for i:=0 to lParametrosConexao.Count-1 do
    ConexaoDtm.Conexao.Params.Add(lParametrosConexao.Strings[i]);
  try
    ConexaoDtm.Conexao.Connected:=True;
    Result:=True;
  except
    on e:exception do
    begin
      FerramentasFrm.MsgPadrao(PChar('ERRO: '+e.Message),'ERRO',2);
      Result:=False;
    end;
  end;
end;

procedure TPrincipalFrm.FormActivate(Sender: TObject);
begin
  WindowState:=wsMaximized;
  Iniciar();
end;

procedure TPrincipalFrm.FormCreate(Sender: TObject);
var
  Conectado:boolean;
begin
  Caminho:='';
  Caminho:=ExtractFilePath(Application.ExeName);

  if not (DirectoryExists(Caminho+'Temps\')) then
    ForceDirectories(Caminho+'Temps\');

  Conectado:=False;
  if not (FileExists(Caminho+'DadosConexao.txt')) then
  begin
    Application.CreateForm(TConexaoFrm,ConexaoFrm);
    try
      if (ConexaoFrm.ShowModal=mrOk) then
        Conectado:=True
      else
        Application.Terminate;
    finally
      FreeAndNil(ConexaoFrm);
    end;
  end
  else
  if (Conectar) then
    Conectado:=True;

  if not (Conectado) then
    Application.Terminate;
end;

procedure TPrincipalFrm.Iniciar;
begin
  lblSaudacoes.Caption:=Saudacoes();
  lblSaudacoes.Update;
end;

function TPrincipalFrm.Saudacoes: string;
var
  lNome:TStringList;
begin
  Result:='';
  if (FileExists(Caminho+'nome.txt')) then
  begin
    lNome:=TStringList.Create;
    lNome.LoadFromFile(Caminho+'nome.txt');
    if (StrToTime(FormatDateTime('hh:mm',now))>=StrToTime('12:00')) and
       (StrToTime(FormatDateTime('hh:mm',now))<StrToTime('19:00')) then
      Result:=' Boa tarde, '+lNome.Strings[0]+'!'
    else
    if (StrToTime(FormatDateTime('hh:mm',now))>=StrToTime('01:00')) and
       (StrToTime(FormatDateTime('hh:mm',now))<StrToTime('12:00')) then
      Result:=' Bom dia, '+lNome.Strings[0]+'!'
    else
    if (StrToTime(FormatDateTime('hh:mm',now))>=StrToTime('19:00')) and
       (StrToTime(FormatDateTime('hh:mm',now))<=StrToTime('23:59')) then
      Result:=' Boa noite, '+lNome.Strings[0]+'!'
  end;
end;

end.
