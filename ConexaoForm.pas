unit ConexaoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TConexaoFrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actConectar: TAction;
    actExibirSenha: TAction;
    btnConectar: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDatabase: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtPort: TEdit;
    SpeedButton1: TSpeedButton;
    ConexaoTeste: TFDConnection;
    edtServer: TEdit;
    Label5: TLabel;
    procedure edtDatabaseKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure edtPortKeyPress(Sender: TObject; var Key: Char);
    procedure actExibirSenhaExecute(Sender: TObject);
    procedure actConectarExecute(Sender: TObject);
    procedure edtServerKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConexaoFrm: TConexaoFrm;

implementation

{$R *.dfm}

uses FerramentasForm, ConexaoDM, PrincipalForm;

procedure TConexaoFrm.actConectarExecute(Sender: TObject);
var
  Server,
  Database,
  Username,
  Password,
  Port,
  DriverID:string;

  lParametrosConexao:TStringList;

  i:integer;

  TesteOK:boolean;
begin
  TesteOK:=False;
  lParametrosConexao:=TStringList.Create;
  Server:='';
  Database:='';
  Username:='';
  Password:='';
  Port:='';
  DriverID:='DriverID=MySQL';

  Server:=edtServer.Text;
  Database:=edtDatabase.Text;
  Username:=edtUsername.Text;
  Password:=edtPassword.Text;
  Port:=edtPort.Text;

  lParametrosConexao.Add('Server='+Server);
  lParametrosConexao.Add('Database='+Database);
  lParametrosConexao.Add('User_Name='+Username);
  lParametrosConexao.Add('Password='+Password);
  lParametrosConexao.Add('Port='+Port);
  lParametrosConexao.Add(DriverID);

  actConectar.Caption:='TESTANDO CONEXÃO...';
  btnConectar.Font.Color:=clBlack;
  Panel2.Color:=clYellow;
  actConectar.ImageIndex:=-1;

  ConexaoTeste.Connected:=False;
  ConexaoTeste.Params.Clear;
  for i:=0 to lParametrosConexao.Count-1 do
    ConexaoTeste.Params.Add(lParametrosConexao.Strings[i]);
  try
    ConexaoTeste.Connected:=True;
    actConectar.Caption:='TESTE BEM-SUCEDIDO';
    btnConectar.Font.Color:=clWhite;
    Panel2.Color:=clGreen;
    actConectar.ImageIndex:=0;
    TesteOK:=True;
    lParametrosConexao.SaveToFile(PrincipalFrm.Caminho+'DadosConexao.txt');
  except
    on e:exception do
    begin
      actConectar.Caption:='ERRO. TENTAR NOVAMENTE';
      btnConectar.Font.Color:=clWhite;
      Panel2.Color:=clRed;
      actConectar.ImageIndex:=2;
      edtDatabase.SetFocus;
      FerramentasFrm.MsgPadrao(PChar('ERRO: '+e.Message),'ERRO',2);
    end;
  end;

  if (TesteOK) then
  begin
    if (ConexaoDtm.Conexao.Connected=True) then
      ConexaoDtm.Conexao.Connected:=False;
    ConexaoDtm.Conexao.Params.Clear;
    for i:=0 to lParametrosConexao.Count-1 do
      ConexaoDtm.Conexao.Params.Add(lParametrosConexao.Strings[i]);
    try
      ConexaoDtm.Conexao.Connected:=True;
      actConectar.Caption:='CONECTADO';
      ModalResult:=mrOk;
    except
      on e:exception do
      begin
        actConectar.Caption:='ERRO. TENTE NOVAMENTE';
        btnConectar.Font.Color:=clWhite;
        Panel2.Color:=clRed;
        actConectar.ImageIndex:=2;
        edtDatabase.SetFocus;
        FerramentasFrm.MsgPadrao(PChar('ERRO: '+e.Message),'ERRO',2);
      end;
    end;
  end;
  lParametrosConexao.Free;
end;

procedure TConexaoFrm.actExibirSenhaExecute(Sender: TObject);
begin
  if (edtPassword.PasswordChar='*') then
    edtPassword.PasswordChar:=#0
  else
    edtPassword.PasswordChar:='*';
end;

procedure TConexaoFrm.edtDatabaseKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Perform(Wm_NextDlgCtl,0,0);
    Key:=#0;
  end;
end;

procedure TConexaoFrm.edtUsernameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Perform(Wm_NextDlgCtl,0,0);
    Key:=#0;
  end;
end;

procedure TConexaoFrm.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Perform(Wm_NextDlgCtl,0,0);
    Key:=#0;
  end;
end;

procedure TConexaoFrm.edtPortKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Perform(Wm_NextDlgCtl,0,0);
    Key:=#0;
  end;
end;

procedure TConexaoFrm.edtServerKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Perform(Wm_NextDlgCtl,0,0);
    Key:=#0;
  end;
end;

end.
