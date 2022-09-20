unit FerramentasForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFerramentasFrm = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MsgPadrao(Msg:PChar;Titulo:string;Tipo:integer);
  end;

var
  FerramentasFrm: TFerramentasFrm;

implementation

{$R *.dfm}

uses MsgPadraoForm;

{ TFerramentasFrm }

procedure TFerramentasFrm.MsgPadrao(Msg: PChar; Titulo: string; Tipo: integer);
begin
  Application.CreateForm(TMsgPadraoFrm,MsgPadraoFrm);
  try
    if (Tipo=1) then
      MsgPadraoFrm.imgInformacao.Visible:=True
    else
    if (Tipo=2) then
      MsgPadraoFrm.imgErro.Visible:=True;

    MsgPadraoFrm.lblTitulo.Caption:=Titulo;
    MsgPadraoFrm.mmMsg.Lines.Add(Msg);
    MsgPadraoFrm.ShowModal;
  finally
    FreeAndNil(MsgPadraoFrm);
  end;
end;

end.
