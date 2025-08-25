unit uKAFSConexaoDataSnap;

interface

uses
  System.Classes, System.SysUtils, System.UITypes,
  FMX.DialogService, FMX.Forms,
  Data.SqlExpr;

type
  TKAFSConexaoDataSnap = class(TSQLConnection)

    constructor Create(AOwner: TComponent); reintroduce;
    procedure Conectar;
    procedure Desconectar;
    destructor Destroy; override;
  end;

implementation

uses
  uKAFSFuncoes;

constructor TKAFSConexaoDataSnap.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Configura o componente para DataSnap
  DriverName := 'Datasnap';

  // Desabilita janela de login padrão
  LoginPrompt := False;

  // Configura parâmetros para DataSnap
  Params.Values['CommunicationProtocol'] := 'tcp/ip';
  Params.Values['DatasnapContext'] := 'datasnap/';

  // Configura timeout
  Params.Values['CommunicationTimeout'] := '10000';
  Params.Values['ConnectionIdleTimeout'] := '30000';
  Params.Values['ConnectTimeout'] := '5000';
end;

procedure TKAFSConexaoDataSnap.Conectar;
begin
  var _tentativas := 0;
  const _max = 3; // Limite de tentativas

  // Repete enquanto não conseguir conexão e não exceder tentativas
  while (not Connected) and (_tentativas < _max) do
    try
      // Busca em cache local o endereço do servidor
      Params.Values['HostName'] := LerIni('cache', 'servidor', 'host');
      Params.Values['Port'] := LerIni('cache', 'servidor', 'porta');

      // Tentativa de conexão
      Connected := True;
    except
      // Caso a tentativa fracasse
      begin
        // Incrementa tentativas
        Inc(_tentativas);

        var _respondido := False;

        TThread.Synchronize(nil, procedure
        begin
          TDialogService.InputQuery('Servidor não encontrado', ['IP', 'Porta'], ['', ''],
          procedure(const AResult: TModalResult; const AValues: array of string)
          begin
            if AResult = mrOk then
            begin
              SalvarIni('cache', 'servidor', 'host', AValues[0]);
              SalvarIni('cache', 'servidor', 'porta', AValues[1]);
              _respondido := True;
            end
            else
            begin
              _respondido := True;
              Application.Terminate;
            end;
          end);
        end);

        // Aguarda a resposta do diálogo
        while not _respondido do
          Sleep(100);
      end;
    end;

  // Se não conseguiu conectar após todas as tentativas
  if not Connected then
    raise Exception.Create('Não foi possível conectar ao servidor');
end;
procedure TKAFSConexaoDataSnap.Desconectar;
begin
  Connected := False;
end;

destructor TKAFSConexaoDataSnap.Destroy;
begin
  Desconectar;

  inherited Destroy;
end;

end.
