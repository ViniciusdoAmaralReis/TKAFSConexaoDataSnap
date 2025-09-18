unit uKAFSConexaoDataSnap;

interface

uses
  System.Classes, System.SysUtils, System.UITypes,
  FMX.Dialogs, FMX.DialogService, FMX.Forms,
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

  // Desabilita janela de login padr�o
  LoginPrompt := False;

  // Configura par�metros para DataSnap
  Params.Values['CommunicationProtocol'] := 'tcp/ip';
  Params.Values['DatasnapContext'] := 'datasnap/';

  // Configura timeout
  Params.Values['CommunicationTimeout'] := '10000';
  Params.Values['ConnectionIdleTimeout'] := '30000';
  Params.Values['ConnectTimeout'] := '5000';

  // Inicia a conex�o
  Conectar;
end;

procedure TKAFSConexaoDataSnap.Conectar;
begin
  var _tentativas := 0;
  const _max = 3; // Limite de tentativas

  // Repete enquanto n�o conseguir conex�o e n�o exceder tentativas
  while (not Connected) and (_tentativas < _max) do
    try
      // Busca em cache local o endere�o do servidor
      with Params do
      begin
        Values['HostName'] := LerIni('cache', 'servidor', 'host');
        Values['Port'] := LerIni('cache', 'servidor', 'porta');
      end;

      // Tentativa de conex�o
      Connected := True;
    except
      // Caso a tentativa fracasse
      begin
        // Incrementa tentativas
        Inc(_tentativas);

        {$IFDEF ANDROID}
        var _respondido := False;
        {$ENDIF}

        TThread.Synchronize(nil, procedure
        begin
          TDialogService.InputQuery('Servidor n�o encontrado', ['IP', 'Porta'], ['', ''],
          procedure(const AResult: TModalResult; const AValues: array of string)
          begin
            if AResult = mrOk then
            begin
              SalvarIni('cache', 'servidor', 'host', AValues[0]);
              SalvarIni('cache', 'servidor', 'porta', AValues[1]);

              {$IFDEF ANDROID}
              _respondido := True;
              {$ENDIF}
            end
            else
            begin
              {$IFDEF ANDROID}
              _respondido := True;
              {$ENDIF}

              Application.Terminate;
            end;
          end);
        end);

        {$IFDEF ANDROID}
        // Aguarda a resposta do di�logo
        while not _respondido do
          Sleep(100);
        {$ENDIF}
      end;
    end;

  // Se n�o conseguiu conectar ap�s todas as tentativas
  if not Connected then
    TThread.Synchronize(nil, procedure begin ShowMessage('N�o foi poss�vel conectar ao servidor'); end);
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
