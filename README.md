# 🚀 TKAFSConexaoDataSnap

Componente Delphi/FireMonkey para conexão DataSnap com suporte a reconexão automática, persistência de configurações e interface de fallback para entrada manual de dados.

## 📋 Descrição

Componente especializado em gerenciar conexões DataSnap em aplicações Delphi/FireMonkey, com suporte multiplataforma (incluindo Android) e recursos de fallback para configuração manual do servidor quando a conexão automática falha.

## ✨ Características

- ✅ Conexão automática com DataSnap
- ✅ Interface de fallback para configuração manual
- ✅ Suporte multiplataforma (Windows, Android, etc.)
- ✅ Cache de configurações do servidor
- ✅ Timeouts configuráveis
- ✅ Tratamento de erros robusto
- ✅ Dialog service para entrada de dados

## 🛠️ Configuração

### Parâmetros Padrão

```
CommunicationProtocol: tcp/ip
DatasnapContext: datasnap/
CommunicationTimeout: 10000 ms
ConnectionIdleTimeout: 30000 ms  
ConnectTimeout: 5000 ms
```

## 📦 Como Usar

### Instanciação Básica

```pascal
var
  Conexao: TKAFSConexaoDataSnap;
begin
  Conexao := TKAFSConexaoDataSnap.Create(nil);
  try
    Conexao.Conectar;
    // Sua lógica com a conexão aqui
  finally
    Conexao.Free;
  end;
end;
```

### Métodos Principais

| Método | Descrição |
|--------|-----------|
| `Conectar` | Estabelece conexão com o servidor |
| `Desconectar` | Fecha a conexão atual |
| `Create` | Construtor com configuração inicial |

## 🔧 Dependências

- `System.Classes`
- `System.SysUtils` 
- `System.UITypes`
- `FMX.DialogService`
- `FMX.Forms`
- `Data.SqlExpr`
- `UntKAFSFuncoes` (para LerIni/SalvarIni)

## 📁 Estrutura do Cache

As configurações são armazenadas em:

```
[cache]
servidor.host=endereco_do_servidor
servidor.porta=porta_do_servidor
```

## 🎯 Comportamento em Diferentes Plataformas

### Android
- Implementa loop de espera para resposta do diálogo
- Não pausa a execução do código durante o diálogo

### Outras Plataformas
- Diálogo modal que pausa a execução até resposta do usuário

## ⚠️ Tratamento de Erros

- Exibe diálogo para entrada de IP/Porta em caso de falha
- Permite reconfiguração dinâmica do servidor
- Finaliza aplicação se usuário cancelar a configuração

---

**Nota:** Este componente requer a unit `UntKAFSFuncoes` para funcionamento completo, contendo as funções `LerIni` e `SalvarIni`.
