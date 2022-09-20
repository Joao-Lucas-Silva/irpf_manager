unit CadastrosClienteForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TCadastrosClienteFrm = class(TForm)
    grdCadastro: TDBGrid;
    dtsCadastro: TDataSource;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actFechar: TAction;
    SpeedButton1: TSpeedButton;
    actNovo: TAction;
    actAlterar: TAction;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure grdCadastroKeyPress(Sender: TObject; var Key: Char);
    procedure grdCadastroDblClick(Sender: TObject);
    procedure grdCadastroTitleClick(Column: TColumn);
  private
    { Private declarations }
    procedure AtualizarGrid(Codigo:integer);
    procedure OrdenarColuna(Coluna:TColumn);
  public
    { Public declarations }
  end;

var
  CadastrosClienteFrm: TCadastrosClienteFrm;

implementation

{$R *.dfm}

uses ClienteDM, NovoClienteForm;

procedure TCadastrosClienteFrm.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TCadastrosClienteFrm.actAlterarExecute(Sender: TObject);
begin
  if (grdCadastro.SelectedField.DisplayText<>'') then
  begin
    Application.CreateForm(TNovoClienteFrm,NovoClienteFrm);
    try
      NovoClienteFrm.OPCadastro:='A';
      NovoClienteFrm.Iniciar(ClienteDtm.qryGrid.FieldByName('cod_cliente').AsInteger);
      NovoClienteFrm.ShowModal;
    finally
      FreeAndNil(NovoClienteFrm);
    end;
    AtualizarGrid(ClienteDtm.qryGrid.FieldByName('cod_cliente').AsInteger);
  end;
end;

procedure TCadastrosClienteFrm.actNovoExecute(Sender: TObject);
begin
  Application.CreateForm(TNovoClienteFrm,NovoClienteFrm);
  try
    NovoClienteFrm.OPCadastro:='N';
    NovoClienteFrm.Iniciar(0);
    NovoClienteFrm.ShowModal;
  finally
    FreeAndNil(NovoClienteFrm);
  end;
  AtualizarGrid(0);
end;

procedure TCadastrosClienteFrm.AtualizarGrid(Codigo: integer);
begin
  ClienteDtm.qryGrid.Refresh;
  if not (ClienteDtm.qryGrid.Locate('cod_cliente',Codigo,[loCaseInsensitive])) then
    ClienteDtm.qryGrid.Last;
end;

procedure TCadastrosClienteFrm.FormActivate(Sender: TObject);
begin
  ClienteDtm.qryGrid.Close;
  ClienteDtm.qryGrid.SQL.Clear;
  ClienteDtm.qryGrid.SQL.Add(ClienteDtm.Select);
  ClienteDtm.qryGrid.SQL.Add(ClienteDtm.From);
  ClienteDtm.qryGrid.Open();
  ClienteDtm.qryGrid.Last;
end;

procedure TCadastrosClienteFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(ClienteDtm);
end;

procedure TCadastrosClienteFrm.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TClienteDtm,ClienteDtm);
end;

procedure TCadastrosClienteFrm.grdCadastroDblClick(Sender: TObject);
begin
  actAlterarExecute(Sender);
end;

procedure TCadastrosClienteFrm.grdCadastroKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key=#13) then
    actAlterarExecute(Sender);
end;

procedure TCadastrosClienteFrm.grdCadastroTitleClick(Column: TColumn);
begin
  OrdenarColuna(Column);
end;

procedure TCadastrosClienteFrm.OrdenarColuna(Coluna: TColumn);
begin
  if (ClienteDtm.qryGrid.IndexFieldNames=Coluna.FieldName) then
    ClienteDtm.qryGrid.IndexFieldNames:=Coluna.FieldName+':D'
  else
    ClienteDtm.qryGrid.IndexFieldNames:=Coluna.FieldName;
end;

end.
