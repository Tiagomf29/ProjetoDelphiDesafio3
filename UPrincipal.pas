unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Data.DB,
  System.Generics.Collections,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.CheckLst, Vcl.Grids,
  UTTipoVeiculo,UTClassePadrao,
  Vcl.DBGrids, Datasnap.Provider, Datasnap.DBClient, ZAbstractConnection,
  ZConnection, Vcl.DBCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Cor1: TMenuItem;
    N1: TMenuItem;
    ipodeVeculo1: TMenuItem;
    N2: TMenuItem;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cklCores: TCheckListBox;
    lblModelo: TLabel;
    edtModelo: TEdit;
    Label1: TLabel;
    lblCodigoValor: TLabel;
    Label2: TLabel;
    cbxTipoVeiculo: TComboBox;
    lblOcupantes: TLabel;
    edtOcupantes: TEdit;
    DBGrid1: TDBGrid;
    btinserir: TButton;
    btnSalvar: TButton;
    btnAlterar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    DS: TDataSource;
    DSP: TDataSetProvider;
    CDS: TClientDataSet;
    conexao: TZConnection;
    CDSid: TIntegerField;
    CDSmodelo: TWideStringField;
    CDSdescricao: TWideStringField;
    CDSocupantes: TIntegerField;
    CDSidTipoVeiculo: TIntegerField;
    qry: TZQuery;
    procedure Cor1Click(Sender: TObject);
    procedure ipodeVeculo1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btinserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnFecharClick(Sender: TObject);
  private
    procedure statusBotoesInsercao(status: Boolean);
    procedure carregaCbxCores;
    procedure carregaTipoVeiculos;
    var alterandoRegistro : Boolean;

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses  UDataModule, UFrmCor, UTCor, UfrmTipoVeiculo, UTVeiculo, UTVeiculoCores;

procedure TfrmPrincipal.btinserirClick(Sender: TObject);
begin
  statusBotoesInsercao(true);
  alterandoRegistro:= false;
  edtModelo.Text := '';
  cbxTipoVeiculo.ItemIndex := -1;
  edtOcupantes.Text := '';
  lblCodigoValor.Caption := '';
  carregaCbxCores;
end;

procedure TfrmPrincipal.btnAlterarClick(Sender: TObject);
begin
  statusBotoesInsercao(true);
  alterandoRegistro:=true;
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  statusBotoesInsercao(false);
  carregaCbxCores;
  
end;

procedure TfrmPrincipal.btnExcluirClick(Sender: TObject);
var
  veiculo : TVeiculo;
begin
  statusBotoesInsercao(false);
  if CDSid.Value > 0  then
    if MessageDlg('Tem certeza que deseja realizar a exclusão do registro?', mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
        try
          veiculo := TVeiculo.create;
          veiculo.id := CDSid.Value;
          veiculo.deletaVeiculo(veiculo);

          CDS.Refresh;
        
          MessageDlg('Registro excluído com sucesso!',mtInformation,[mbOK],0);
        finally
          FreeAndNil(veiculo);
        end;        
      end;
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
var
  veiculo: TVeiculo;
  tipoVeiculo: TTipoVeiculo;
  veiculoCores: TVeiculoCores;
  cores: TCor;
  i,j: Integer;
  naoInsereCor : boolean;
begin
  
  if edtModelo.Text = '' then
    begin
      MessageDlg('Modelo não informado. Verifique!', mtInformation, [mbOK], 0);
      edtModelo.SetFocus;
      Abort;
    end
  else if cbxTipoVeiculo.ItemIndex = -1 then
    begin
      MessageDlg('Tipo de veículo não informado. Verifique!', mtInformation,
        [mbOK], 0);
      cbxTipoVeiculo.SetFocus;
      Abort;
    end
  else if edtOcupantes.Text = '' then
    begin
      MessageDlg('Quantidade de ocupantes não informado. Verifique!',
        mtInformation, [mbOK], 0);
      edtOcupantes.SetFocus;
      Abort;
    end
  else
    begin

      try
        veiculo := TVeiculo.create;
        tipoVeiculo := TTipoVeiculo.create;
        veiculoCores := TVeiculoCores.create;
        cores := TCor.create;

        veiculo.descricao := edtModelo.Text;
        tipoVeiculo.id := Integer(tipoVeiculo.listaTiposVeiculo.Items[cbxTipoVeiculo.ItemIndex].id);
        veiculo.tipoVeiculo := tipoVeiculo;
        veiculo.ocupantes := StrToInt(edtOcupantes.Text);

        if alterandoRegistro = False then
          begin
            CDS.First;
            veiculo.insereVeiculo(veiculo);
          end
        else
          begin
            veiculo.id := CDSid.Value;
            veiculo.atualizaVeiculo(veiculo);            
          end;

        CDS.Refresh;

        for i := 0 to cklCores.Count - 1 do
          begin

            veiculo.id := CDSid.Value;

            if cklCores.Checked[i] then
              begin
                cores.id := Integer(cores.consultaCores.Items[i].id);
                veiculoCores.veiculo := veiculo;
                veiculoCores.cor := cores;
                naoInsereCor := false;
                for j:= 0 to veiculoCores.recuperaCoresVeiculo(CDSid.Value).Count-1 do
                  begin
                    if cores.consultaCores.Items[i].id = veiculoCores.recuperaCoresVeiculo(CDSid.Value).Items[j].id then
                      naoInsereCor := true;
                  end;

                if not naoInsereCor then
                  begin
                    veiculoCores := TVeiculoCores.create;
                    cores := TCor.create;
                    cores.id := Integer(cores.consultaCores.Items[i].id);
                    veiculoCores.veiculo := veiculo;
                    veiculoCores.cor := cores;
                    veiculoCores.insereVeiculoCores(veiculoCores);
                  end;
              end
            else
              if not cklCores.Checked[i] then
                 begin
                   cores.id := Integer(cores.consultaCores.Items[i].id);
                   veiculoCores.veiculo := veiculo;
                   veiculoCores.cor := cores;
                     
                   veiculoCores.deletaVeiculoCores(veiculoCores);                                  
                 end;
          end;

        MessageDlg('Registro ou alterado inserido com sucesso!', mtInformation, [mbOK], 0);

      finally
        FreeAndNil(veiculo);
        FreeAndNil(veiculoCores);
        FreeAndNil(cores);
        FreeAndNil(tipoVeiculo);
      end;

    end;

  statusBotoesInsercao(false);

end;

procedure TfrmPrincipal.carregaCbxCores;
var
  cores: TCor;
  i: Integer;
begin

  cores := TCor.create;

  try
    cklCores.Clear;
    for i := 0 to cores.consultaCores.Count - 1 do
      begin
        cklCores.AddItem(cores.consultaCores.Items[i].descricao,
          TObject(cores.consultaCores.Items[i].id));
      end;
  finally
    FreeAndNil(cores);
  end;
end;

procedure TfrmPrincipal.carregaTipoVeiculos;
var
  tipoVeiculo : TTipoVeiculo;
  i : Integer;
begin

  tipoVeiculo := TTipoVeiculo.create;
  
  try
    cbxTipoVeiculo.Clear;
    for i := 0 to tipoVeiculo.listaTiposVeiculo.Count - 1 do
      begin
        cbxTipoVeiculo.Items.AddObject(tipoVeiculo.listaTiposVeiculo.Items[i].descricao, 
          TObject(tipoVeiculo.listaTiposVeiculo.Items[i].id));
      end;
  finally
    FreeAndNil(tipoVeiculo);
  end;
end;

procedure TfrmPrincipal.Cor1Click(Sender: TObject);
begin
  frmcor.showmodal;
  carregaCbxCores;
  frmcor.Caption := 'Cadastro de cores';
end;

procedure TfrmPrincipal.DBGrid1CellClick(Column: TColumn);
var
  tipoVeiculo: TTipoVeiculo;
  veiculoCores: TVeiculoCores;
  i, j: Integer;
  cores: TCor;

begin

  statusBotoesInsercao(false);
  lblCodigoValor.Caption := IntToStr(CDSid.Value);
  edtModelo.Text := CDSmodelo.Value;
  edtOcupantes.Text := IntToStr(CDSocupantes.Value);

  veiculoCores := TVeiculoCores.create;
  cores := TCor.create;
  tipoVeiculo := TTipoVeiculo.create;
  try
    for i := 0 to tipoVeiculo.listaTiposVeiculo.Count - 1 do
      begin
        if tipoVeiculo.listaTiposVeiculo.Items[i].id = CDSidTipoVeiculo.Value
        then
          cbxTipoVeiculo.ItemIndex := i;
      end;
    carregaCbxCores;
    for i := 0 to cores.consultaCores.Count - 1 do
      begin
        for j := 0 to veiculoCores.recuperaCoresVeiculo(CDSid.Value).Count - 1 do
          begin
            if cores.consultaCores.Items[i].id = veiculoCores.recuperaCoresVeiculo(CDSid.Value).Items[j].id then
              cklCores.Checked[i] := true;
          end;
      end;
  finally
    FreeAndNil(veiculoCores);
    FreeAndNil(tipoVeiculo);
    FreeAndNil(cores);
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin

  statusBotoesInsercao(false);
  carregaTipoVeiculos;
  carregaCbxCores;

end;

procedure TfrmPrincipal.ipodeVeculo1Click(Sender: TObject);
begin

  frmCadastroTiposVeiculos.showmodal;
  carregaTipoVeiculos;

end;

procedure TfrmPrincipal.statusBotoesInsercao(status: Boolean);
begin
  if status then
    begin
      btinserir.Enabled := false;
      btnAlterar.Enabled := false;
      btnCancelar.Enabled := true;
      btnExcluir.Enabled := false;
      btnSalvar.Enabled := true;
      edtModelo.Enabled := true;
      edtOcupantes.Enabled := true;
      cbxTipoVeiculo.Enabled := true;
      edtModelo.SetFocus;
      btnFechar.Enabled := false;
      cklCores.Enabled := True;
    end
  else
    begin
      edtModelo.Enabled := false;
      edtOcupantes.Enabled := false;
      cbxTipoVeiculo.Enabled := false;
      btinserir.Enabled := true;
      btnAlterar.Enabled := true;
      btnCancelar.Enabled := false;
      btnExcluir.Enabled := true;
      btnSalvar.Enabled := false;
      btnFechar.Enabled := true;
      cklCores.Enabled :=False;
    end;
end;

end.
