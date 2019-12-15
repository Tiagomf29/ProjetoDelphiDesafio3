unit UFrmCor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection;

type
  TfrmCor = class(TForm)
    edtDescricao: TEdit;
    lblDescricao: TLabel;
    btinserir: TButton;
    btnSalvar: TButton;
    btnAlterar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    DBGrid1: TDBGrid;
    DS: TDataSource;
    CDS: TClientDataSet;
    DSP: TDataSetProvider;
    CDSid: TIntegerField;
    CDSdescricao: TWideStringField;
    qry: TZQuery;
    lblCodigo: TLabel;
    lblCodigoValor: TLabel;
    btnFechar: TButton;
    procedure btinserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  frmCor: TfrmCor;
  

implementation
uses
UTCor;

{$R *.dfm}

{ TfrmCor }

procedure TfrmCor.btinserirClick(Sender: TObject);
begin
  statusBotoesInsercao(true);
  alterandoRegistro:= false;
end;

procedure TfrmCor.btnAlterarClick(Sender: TObject);
begin
 statusBotoesInsercao(true);
 alterandoRegistro:=true;
end;

procedure TfrmCor.btnCancelarClick(Sender: TObject);
begin
  statusBotoesInsercao(false);
  alterandoRegistro:= false;
end;

procedure TfrmCor.btnExcluirClick(Sender: TObject);
var
cor : TCor;
begin

  statusBotoesInsercao(false);
  alterandoRegistro:=false;

  if CDSid.Value > 0 then
  begin
    if (MessageDlg('Tem  certeza que deseja excluir o registro?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
       begin
         cor := TCor.create;
         try
           cor.id := CDSid.Value;
           cor.deletaCor(cor);

           CDS.Refresh;

           MessageDlg('Registro Exclu�do com sucesso!',mtInformation,[mbOK],0);         
         finally
           FreeAndNil(cor);
         end;
       end;
  end 
  else
      MessageDlg('Nenhum registro est� selecionado para a realiza��o da exclus�o. Verifique!',mtInformation,[mbOK],0);    
end;

procedure TfrmCor.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCor.btnSalvarClick(Sender: TObject);
var
cor : TCor;
begin

  if edtDescricao.Text = '' then
  begin
    MessageDlg('Descri��o n�o informado. Verifique!',mtInformation,[mbOK],0);
    edtDescricao.SetFocus;
    Abort;
  end;

  cor := TCor.create;

  if not alterandoRegistro then
  begin
    try
      cor.descricao := edtDescricao.Text; 
      cor.insereCores(cor);
    finally
      FreeAndNil(cor);
    end;
  end
  else
  begin
    try
      cor.id        := CDSid.Value;
      cor.descricao := edtDescricao.Text;
      cor.atualizaCor(cor);
    finally
      FreeAndNil(cor);
    end;
    
  end;

  statusBotoesInsercao(false);

  cds.Refresh;
  alterandoRegistro:=false;
  MessageDlg('Registro inserido com sucesso!',mtInformation,[mbOK],0);
    
end;

procedure TfrmCor.DBGrid1CellClick(Column: TColumn);
begin

  edtDescricao.Text := CDs.FieldByName('descricao').AsString;
  lblCodigoValor.Caption :=  IntToStr(CDS.FieldByName('id').AsInteger);
  statusBotoesInsercao(false);

end;

procedure TfrmCor.FormCreate(Sender: TObject);
begin
  statusBotoesInsercao(false);
end;

procedure TfrmCor.statusBotoesInsercao(status: boolean);
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
