unit UTCor;

interface

uses
  UTclassePadrao, ZDataSet, System.Generics.Collections;

type

  TCor = class(TClassePadrao)

  private

  protected

  public

    function consultaCores(): TObjectList<TCor>;
    procedure insereCores(cores: TCor);
    procedure atualizaCor(cores: TCor);
    procedure deletaCor(cores: TCor);

  end;

implementation

uses
  UDataModule;
{ TCor }

procedure TCor.insereCores(cores: TCor);
begin

  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add('insert into cor (descricao) values (:descricao)');
  qry.ParamByName('descricao').AsString := cores.descricao;
  
  qry.ExecSQL;

end;

procedure TCor.atualizaCor(cores: TCor);
begin

  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add('update cor set descricao =:descricao where id =:id');
  
  qry.ParamByName('descricao').AsString := cores.descricao;
  qry.ParamByName('id').AsInteger := cores.id;
  
  qry.ExecSQL;

end;

function TCor.consultaCores(): TObjectList<TCor>;
var
  cor: TCor;
  lista: TObjectList<TCor>;

begin
  
  qry.Connection := DM.conexao;
  
  lista := TObjectList<TCor>.Create;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Text := cor.sqlPadrao('cor');
  
  qry.Open;

  while not qry.Eof do
    begin

      cor := TCor.Create;

      cor.id := qry.FieldByName('id').AsInteger;
      cor.descricao := qry.FieldByName('descricao').AsString;
      
      lista.Add(cor);
      
      qry.Next;
    end;

  result := lista;

end;

procedure TCor.deletaCor(cores: TCor);
begin

  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  
  qry.SQL.Add('delete from cor where id =:id');
  
  qry.ParamByName('id').AsInteger := cores.id;
  
  qry.ExecSQL;

end;


end.
