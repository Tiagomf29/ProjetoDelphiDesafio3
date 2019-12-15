unit UTClassePadrao;

interface

uses
  ZDataSet, System.SysUtils, System.Generics.Collections;

type

  TClassePadrao = class

  private
    FId: Integer;
    FDescricao: String;
    function getDescricao: String;
    function getId: Integer;
    procedure setDescricao(const Value: String);
    procedure setId(const Value: Integer);

  protected

  public

    qry: TZQuery;

    function sqlPadrao(nomeTabela: String): String;

    property id: Integer read getId write setId;
    property descricao: String read getDescricao write setDescricao;
    
    constructor create();
    destructor destroi();

  end;

implementation
uses         
  UDataModule;

{ TClassePadrao }

constructor TClassePadrao.create;
begin
  qry := TZQuery.create(nil);
end;

destructor TClassePadrao.destroi;
begin
  FreeAndNil(qry);
end;

function TClassePadrao.getDescricao: String;
begin
  Result := FDescricao;
end;

function TClassePadrao.getId: Integer;
begin
  Result := FId;
end;

procedure TClassePadrao.setDescricao(const Value: String);
begin
  Self.FDescricao := Value;
end;

procedure TClassePadrao.setId(const Value: Integer);
begin
  Self.FId := Value;
end;

function TClassePadrao.sqlPadrao(nomeTabela: String): String;
begin
  Result := 'select * from ' + nomeTabela;
end;

end.
