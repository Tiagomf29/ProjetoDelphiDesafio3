object frmCadastroTiposVeiculos: TfrmCadastroTiposVeiculos
  Left = 0
  Top = 0
  Caption = 'Cadastro de tipos de ve'#237'culos'
  ClientHeight = 307
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblDescricao: TLabel
    Left = 9
    Top = 42
    Width = 46
    Height = 13
    Caption = 'Descricao'
  end
  object lblCodigo: TLabel
    Left = 9
    Top = 4
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lblCodigoValor: TLabel
    Left = 9
    Top = 21
    Width = 3
    Height = 13
  end
  object edtDescricao: TEdit
    Left = 8
    Top = 57
    Width = 273
    Height = 21
    TabOrder = 0
  end
  object btinserir: TButton
    Left = 8
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 1
    OnClick = btinserirClick
  end
  object btnSalvar: TButton
    Left = 89
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnAlterar: TButton
    Left = 170
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
    OnClick = btnAlterarClick
  end
  object btnCancelar: TButton
    Left = 251
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object btnExcluir: TButton
    Left = 332
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object DBGrid1: TDBGrid
    Left = 6
    Top = 84
    Width = 482
    Height = 191
    DataSource = DS
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object btnFechar: TButton
    Left = 412
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 7
    OnClick = btnFecharClick
  end
  object DS: TDataSource
    DataSet = CDS
    Left = 264
    Top = 1
  end
  object CDS: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    ReadOnly = True
    Left = 296
    Top = 1
    object CDSid: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object CDSdescricao: TWideStringField
      DisplayLabel = 'Descricao'
      FieldName = 'descricao'
      Size = 40
    end
  end
  object DSP: TDataSetProvider
    DataSet = qry
    Left = 328
    Top = 1
  end
  object qry: TZQuery
    Connection = DM.conexao
    SQL.Strings = (
      'select * from tipoveiculo')
    Params = <>
    Left = 360
    Top = 1
  end
end
