program Principal;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {frmPrincipal},
  UTClassePadrao in 'UTClassePadrao.pas',
  UTCor in 'UTCor.pas',
  UFrmCor in 'UFrmCor.pas' {frmCor},
  UFrmTipoVeiculo in 'UFrmTipoVeiculo.pas' {frmCadastroTiposVeiculos},
  UTTipoVeiculo in 'UTTipoVeiculo.pas',
  UTVeiculoCores in 'UTVeiculoCores.pas',
  UTVeiculo in 'UTVeiculo.pas',
  UDataModule in 'UDataModule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmCor, frmCor);
  Application.CreateForm(TfrmCadastroTiposVeiculos, frmCadastroTiposVeiculos);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
