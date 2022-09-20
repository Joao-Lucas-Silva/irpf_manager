unit ConexaoDM;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf;

type
  TConexaoDtm = class(TDataModule)
    Conexao: TFDConnection;
    cmd: TFDCommand;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
  public
    { Public declarations }
  end;

var
  ConexaoDtm: TConexaoDtm;

implementation

uses
  System.SysUtils, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConexaoDtm.CriarTabelas;
begin
  //Tabela cliente
  cmd.CommandText.Add('CREATE TABLE if not exists `'+ConexaoDtm.Conexao.Params.Database+'`.`cliente` ('+
  ' `cod_cliente` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,'+
  ' `nome_cliente` VARCHAR(45),'+
  ' `cpf` VARCHAR(20),'+
  ' `apelido` VARCHAR(45),'+
  ' `titulo_eleitor` VARCHAR(20),'+
  ' `endereco` VARCHAR(45),'+
  ' `bairro` VARCHAR(45),'+
  ' `cidade` VARCHAR(45),'+
  ' `estado` CHAR(2),'+
  ' `cep` VARCHAR(11),'+
  ' `numero` VARCHAR(10),'+
  ' `nome_conjugue` VARCHAR(45),'+
  ' `cpf_conjugue` VARCHAR(20),'+
  ' `nome_dependente1` VARCHAR(45),'+
  ' `cpf_dependente1` VARCHAR(20),'+
  ' `parentesco_depentente1` INTEGER UNSIGNED,'+
  ' `nome_dependente2` VARCHAR(45),'+
  ' `cpf_dependente2` VARCHAR(20),'+
  ' `parentesco_depentente2` INTEGER UNSIGNED,'+
  ' `nome_dependente3` VARCHAR(45),'+
  ' `cpf_dependente3` VARCHAR(20),'+
  ' `parentesco_depentente3` INTEGER UNSIGNED,'+
  ' `nome_dependente4` VARCHAR(45),'+
  ' `cpf_dependente4` VARCHAR(20),'+
  ' `parentesco_depentente4` INTEGER UNSIGNED,'+
  ' `nome_dependente5` VARCHAR(45),'+
  ' `cpf_dependente5` VARCHAR(20),'+
  ' `parentesco_depentente5` INTEGER UNSIGNED,'+
  ' `ultima_checagem` DATETIME,'+
  ' `data_cadastro` DATETIME,'+
  ' PRIMARY KEY(`cod_cliente`)'+
  ' )'+
  ' ENGINE = InnoDB;');
  cmd.Execute();
end;

procedure TConexaoDtm.DataModuleCreate(Sender: TObject);
begin
  FDPhysMySQLDriverLink1.VendorLib:='';
  FDPhysMySQLDriverLink1.VendorLib:=ExtractFilePath(Application.ExeName)+'libmysql.dll';
  CriarTabelas();
end;

end.
