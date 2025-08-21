unit UntKAFSConexaoDataSnap;

interface

uses
  System.Classes, System.UITypes,
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
  UntKAFSFuncoes;

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
  var _sair := False;
  {$IF Defined(ANDROID)}
  // Variável de controle para saber quando o usuário termina a tela de dialogo
  var _respondido := False;
  {$ENDIF}

  // Repete enquanto não conseguir conexão e não estiver pronto para finalizar
  while (not Connected) and (not _sair) do
    try
      // Busca em cache local o endereço do servidor
      Params.Values['HostName'] := LerIni('cache', 'servidor', 'host');
      Params.Values['Port'] := LerIni('cache', 'servidor', 'porta');

      // Tentativa de conexão
      Connected := True;
    except
      // Caso a tentativa fracasse
      TThread.Synchronize(nil, procedure
      begin
        TDialogService.InputQuery('Servidor não encontrado', ['IP', 'Porta'], ['', ''], procedure(const AResult: TModalResult; const AValues: array of string)
        begin
          if AResult = mrOk then
          begin
            SalvarIni('cache', 'servidor', 'host', AValues[0]);
            SalvarIni('cache', 'servidor', 'porta', AValues[1]);

            {$IF Defined(ANDROID)}
            _resposta := True;
            {$ENDIF}
          end
          else
            Application.Terminate;
        end);
      end);

      {$IF Defined(ANDROID)}
      // No Android a tela de dialogo não pausa o código
      while not _respondido do
        Sleep(100);
      {$ENDIF}
    end;
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
