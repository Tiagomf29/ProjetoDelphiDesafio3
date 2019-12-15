unit UTTipoVeiculo;

interface

uses
  UTClassePadrao, System.Generics.Collections;

type

  TTipoVeiculo = class(TClassePadrao)

  private

  protected

  public
    procedure insereTpVeiculo(tipoVeiculo: TTipoVeiculo);
    procedure atualizaTpVeiculo(tipoVeiculo: TTipoVeiculo);
    procedure deletaTpVeiculo(tipoVeiculo: TTipoVeiculo);
    function  listaTiposVeiculo: TObjectList<TTipoVeiculo>;
    procedure setObject(tipoVeiculo :TTipoVeiculo);

  end;

implementation

uses
  UDataModule;

{ TTipoVeiculo }

procedure TTipoVeiculo.atualizaTpVeiculo(tipoVeiculo: TTipoVeiculo);
begin

  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add('update tipoVeiculo set descricao =:descricao where id =:id');
  qry.ParamByName('descricao').AsString := tipoVeiculo.descricao;
  qry.ParamByName('id').AsInteger := tipoVeiculo.id;
  
  qry.ExecSQL;
end;

procedure TTipoVeiculo.deletaTpVeiculo(tipoVeiculo: TTipoVeiculo);
begin

  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add('delete from tipoVeiculo where id =:id');
  qry.ParamByName('id').AsInteger := tipoVeiculo.id;
  
  qry.ExecSQL;
end;

procedure TTipoVeiculo.insereTpVeiculo(tipoVeiculo: TTipoVeiculo);
begin

  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add('insert into tipoVeiculo (descricao) values (:descricao)');
  qry.ParamByName('descricao').AsString := tipoVeiculo.descricao;
  
  qry.ExecSQL;
end;

function TTipoVeiculo.listaTiposVeiculo: TObjectList<TTipoVeiculo>;
var
  lista: TObjectList<TTipoVeiculo>;
  tipoVeiculo: TTipoVeiculo;
begin

  qry.Connection := DM.conexao;
  
  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add(sqlPadrao('TipoVeiculo'));
  
  qry.Open;
  
  lista := TObjectList<TTipoVeiculo>.Create;

  while (not qry.Eof) do
    begin

      tipoVeiculo := TTipoVeiculo.Create;
      tipoVeiculo.id := qry.FieldByName('id').AsInteger;
      tipoVeiculo.descricao := qry.FieldByName('descricao').AsString;

      lista.Add(tipoVeiculo);

      qry.Next;

    end;

  Result := lista;

end;

procedure TTipoVeiculo.setObject(tipoVeiculo: TTipoVeiculo);
begin
     qry.Connection := dm.conexao;
     qry.Close;
     qry.SQL.Clear;
     qry.SQL.Add(sqlPadrao('tipoveiculo'));
     qry.SQL.Add('where id =:id');
     qry.ParamByName('id').AsInteger := tipoVeiculo.id;
     qry.Open;
end;

end.
