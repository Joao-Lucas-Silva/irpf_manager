unit ConfiguracoesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons,
  System.ImageList, Vcl.ImgList;

type
  TConfiguracoesFrm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    edtNome: TButtonedEdit;
    mmOrigemEntrada: TMemo;
    mmOrigemSaida: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actSair: TAction;
    actSalvar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure actSairExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure mmOrigemEntradaExit(Sender: TObject);
    procedure mmOrigemSaidaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function FormatarMemoOrigens(mm:TMemo):TMemo;
  public
    { Public declarations }
  end;

var
  ConfiguracoesFrm: TConfiguracoesFrm;

implementation

{$R *.dfm}

uses PrincipalForm, FerramentasForm;

procedure TConfiguracoesFrm.actSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TConfiguracoesFrm.actSalvarExecute(Sender: TObject);
var
  lNome,
  lOrigemEntrada,
  lOrigemSaida:TStringList;

  i:integer;
begin
  //Formata os dois memos caso isso ainda não tenha sido feito ainda
  //obs.: quando sai do memo direto pro speedbutton, não chama o exit do memo
  mmOrigemEntrada:=FormatarMemoOrigens(mmOrigemEntrada);
  mmOrigemSaida:=FormatarMemoOrigens(mmOrigemSaida);

  lNome:=TStringList.Create;
  lOrigemEntrada:=TStringList.Create;
  lOrigemSaida:=TStringList.Create;

  //Alimenta as StringLists com os dados preenchidos no edit e memos
  if (edtNome.Text<>'') then
    lNome.Add(edtNome.Text);

  for i := 0 to mmOrigemEntrada.Lines.Count-1 do
  begin
    if (mmOrigemEntrada.Lines.Strings[i]<>'') then
      lOrigemEntrada.Add(mmOrigemEntrada.Lines.Strings[i]);
  end;

  for i := 0 to mmOrigemSaida.Lines.Count-1 do
  begin
    if (mmOrigemSaida.Lines.Strings[i]<>'') then
      lOrigemSaida.Add(mmOrigemSaida.Lines.Strings[i]);
  end;

  //Apaga os txts se já existirem
  if (FileExists(PrincipalFrm.Caminho+'nome.txt')) then
    DeleteFile(PrincipalFrm.Caminho+'nome.txt');
  if (FileExists(PrincipalFrm.Caminho+'origens_entrada.txt')) then
    DeleteFile(PrincipalFrm.Caminho+'origens_entrada.txt');
  if (FileExists(PrincipalFrm.Caminho+'origens_saida.txt')) then
    DeleteFile(PrincipalFrm.Caminho+'origens_saida.txt');

  //Salva para o arquivo txt correspondente
  lNome.SaveToFile(PrincipalFrm.Caminho+'nome.txt');
  lOrigemEntrada.SaveToFile(PrincipalFrm.Caminho+'origens_entrada.txt');
  lOrigemSaida.SaveToFile(PrincipalFrm.Caminho+'origens_saida.txt');

  FerramentasFrm.MsgPadrao('DADOS SALVOS COM SUCESSO','SALVAR',1);
  Close;
end;

procedure TConfiguracoesFrm.FormActivate(Sender: TObject);
var
  lNome,
  lOrigemEntrada,
  lOrigemSaida:TStringList;

  i:integer;
begin
  lNome:=TStringList.Create;
  lOrigemEntrada:=TStringList.Create;
  lOrigemSaida:=TStringList.Create;

  if (FileExists(PrincipalFrm.Caminho+'nome.txt')) then
  begin
    lNome.LoadFromFile(PrincipalFrm.Caminho+'nome.txt');
    edtNome.Text:=lNome.Strings[0];
  end;
  if (FileExists(PrincipalFrm.Caminho+'origens_entrada.txt')) then
  begin
    lOrigemEntrada.LoadFromFile(PrincipalFrm.Caminho+'origens_entrada.txt');
    for i := 0 to lOrigemEntrada.Count-1 do
      mmOrigemEntrada.Lines.Add(lOrigemEntrada.Strings[i]);
  end;
  if (FileExists(PrincipalFrm.Caminho+'origens_saida.txt')) then
  begin
    lOrigemSaida.LoadFromFile(PrincipalFrm.Caminho+'origens_saida.txt');
    for i := 0 to lOrigemSaida.Count-1 do
      mmOrigemSaida.Lines.Add(lOrigemSaida.Strings[i]);
  end;
end;

function TConfiguracoesFrm.FormatarMemoOrigens(mm: TMemo):TMemo;
var
  i:integer;
begin
  for i := 0 to mm.Lines.Count-1 do
  begin
    if (mm.Lines.Strings[i]<>'') then
    begin
      if not (Copy(mm.Lines.Strings[i],1,1)=IntToStr(i+1)) then
        mm.Lines.Strings[i]:=Format('%1.1d',[i+1])+' - '+mm.Lines.Strings[i];
    end;
  end;
  Result:=mm;
end;

procedure TConfiguracoesFrm.mmOrigemEntradaExit(Sender: TObject);
begin
  mmOrigemEntrada:=FormatarMemoOrigens(mmOrigemEntrada);
end;

procedure TConfiguracoesFrm.mmOrigemSaidaExit(Sender: TObject);
begin
  mmOrigemSaida:=FormatarMemoOrigens(mmOrigemSaida);
end;

end.
