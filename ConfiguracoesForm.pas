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
    ActionList1: TActionList;
    ImageList1: TImageList;
    actSair: TAction;
    actSalvar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure actSairExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
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
  i:integer;
  lNome:TStringList;
begin
  lNome:=TStringList.Create;

  //Alimenta as StringLists com os dados preenchidos no edit e memos
  if (edtNome.Text<>'') then
    lNome.Add(edtNome.Text);

  //Apaga os txts se já existirem
  if (FileExists(PrincipalFrm.Caminho+'nome.txt')) then
    DeleteFile(PrincipalFrm.Caminho+'nome.txt');

  //Salva para o arquivo txt correspondente
  lNome.SaveToFile(PrincipalFrm.Caminho+'nome.txt');

  FerramentasFrm.MsgPadrao('DADOS SALVOS COM SUCESSO','SALVAR',1);
  Close;
end;

procedure TConfiguracoesFrm.FormActivate(Sender: TObject);
var
  lNome:TStringList;
  i:integer;
begin
  lNome:=TStringList.Create;

  if (FileExists(PrincipalFrm.Caminho+'nome.txt')) then
  begin
    lNome.LoadFromFile(PrincipalFrm.Caminho+'nome.txt');
    edtNome.Text:=lNome.Strings[0];
  end;
end;

end.
