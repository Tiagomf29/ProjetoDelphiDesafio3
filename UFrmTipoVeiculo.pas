unit UFrmTipoVeiculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Datasnap.Provider, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmCadastroTiposVeiculos = class(TForm)
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    btinserir: TButton;
    btnSalvar: TButton;
    btnAlterar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    DBGrid1: TDBGrid;
    DS: TDataSource;
    CDS: TClientDataSet;
    CDSid: TIntegerField;
    CDSdescricao: TWideStringField;
    DSP: TDataSetProvider;
    qry: TZQuery;
    lblCodigo: TLabel;
    lblCodigoValor: TLabel;
    btnFechar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btinserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure statusBotoesInsercao(status : boolean);
    var alterandoRegistro : boolean; 
  public
    { Public declarations }
  end;

var
  frmCadastroTiposVeiculos: TfrmCadastroTiposVeiculos;

implementation
uses
  UTTipoVeiculo;

{$R *.dfm}

{ TfrmCadastroTiposVeiculos }

procedure TfrmCadastroTiposVeiculos.btinserirClick(Sender: TObject);
begin
  statusBotoesInsercao(true);
  alterandoRegistro:= false;
end;

procedure TfrmCadastroTiposVeiculos.btnAlterarClick(Sender: TObject);
begin
  statusBotoesInsercao(true);
  alterandoRegistro:= true;
end;

procedure TfrmCadastroTiposVeiculos.btnCancelarClick(Sender: TObject);
begin
  statusBotoesInsercao(false);
  alterandoRegistro:= false;
end;

procedure TfrmCadastroTiposVeiculos.btnExcluirClick(Sender: TObject);
var
tipoVeiculo : TTipoVeiculo;
begin
  statusBotoesInsercao(false);
  alterandoRegistro:=false;

  if CDSid.Value > 0 then
  begin
    if (MessageDlg('Tem  certeza que deseja excluir o registro?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
       begin
         tipoVeiculo := TTipoVeiculo.create;
         try
           tipoVeiculo.id := CDSid.Value;
           tipoVeiculo.deletaTpVeiculo(tipoVeiculo);

           CDS.Refresh;

           MessageDlg('Registro Excluído com sucesso!',mtInformation,[mbOK],0);         
         finally
           FreeAndNil(tipoVeiculo);
         end;
       end;
  end 
  else
      MessageDlg('Nenhum registro está selecionado para a realização da exclusão. Verifique!',mtInformation,[mbOK],0);    
end;

procedure TfrmCadastroTiposVeiculos.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroTiposVeiculos.btnSalvarClick(Sender: TObject);
var
tipoVeiculo : TTipoVeiculo;
begin

  if edtDescricao.Text = '' then
  begin
    MessageDlg('Descrição não informado. Verifique!',mtInformation,[mbOK],0);
    edtDescricao.SetFocus;
    Abort;
  end;

  tipoVeiculo := TTipoVeiculo.create;

  if not alterandoRegistro then
  begin
    try
      tipoVeiculo.descricao := edtDescricao.Text; 
      tipoVeiculo.insereTpVeiculo(tipoVeiculo);
    finally
      FreeAndNil(tipoVeiculo);
    end;
  end
  else
  begin
    try
      tipoVeiculo.id        := CDSid.Value;
      tipoVeiculo.descricao := edtDescricao.Text;
      tipoVeiculo.atualizaTpVeiculo(tipoVeiculo);
    finally
      FreeAndNil(tipoVeiculo);
    end;
    
  end;

  statusBotoesInsercao(false);

  cds.Refresh;
  alterandoRegistro:=false;
  MessageDlg('Registro inserido com sucesso!',mtInformation,[mbOK],0);
    

end;

procedure TfrmCadastroTiposVeiculos.DBGrid1CellClick(Column: TColumn);
begin
  edtDescricao.Text := CDs.FieldByName('descricao').AsString;
  lblCodigoValor.Caption :=  IntToStr(CDS.FieldByName('id').AsInteger);
  statusBotoesInsercao(false);
end;

procedure TfrmCadastroTiposVeiculos.FormShow(Sender: TObject);
begin
  statusBotoesInsercao(false);
end;

procedure TfrmCadastroTiposVeiculos.statusBotoesInsercao(status : boolean);
begin
 if status then
    begin
      btinserir.Enabled:=false;
      btnAlterar.Enabled:=false;
      btnCancelar.Enabled:=true;
      btnExcluir.Enabled:=false;
      btnSalvar.Enabled:=true;
      edtDescricao.Enabled:=true;
      edtDescricao.SetFocus;
      btnFechar.Enabled:=false;
    end 
    else
    begin
      edtDescricao.Enabled:=false;
      btinserir.Enabled:=true;
      btnAlterar.Enabled:=true;
      btnCancelar.Enabled:=false;
      btnExcluir.Enabled:=true;
      btnSalvar.Enabled:=false;
      btnFechar.Enabled:=true;
    end;  
end;

end.
