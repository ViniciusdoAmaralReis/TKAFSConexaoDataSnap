# 🧩 TKAFSConexaoDataSnap

Componente Delphi/FireMonkey para conexão DataSnap com suporte a reconexão automática, persistência de configurações e interface de fallback para entrada manual de dados do servidor.

## ⚠️ Dependências externas

Este componente utiliza a seguinte unit externa que deve ser adicionada ao projeto:

- 🧩 [uKAFSFuncoes](https://github.com/ViniciusdoAmaralReis/uKAFSFuncoes)

## 💡 Instanciação básica
```pascal
var _conexao := TKAFSConexaoDataSnap.Create(nil);
try
  // A conexão é estabelecida automaticamente no construtor
finally
  FreeAndNil(_conexao);
end;
```

## 🏛️ Status de compatibilidade

| Sistema operacional | Status DataSnap | Observações |
|---------------------|-----------------|-------------|
| **Windows** | ✅ **Totalmente Compatível** | Funcionamento completo com todos os recursos |
| **Android** | ✅ **Compatível** | Suporte a diálogos nativos e reconexão |
| **iOS** | ✅ **Compatível** | Funcionamento completo |
| **macOS** | ✅ **Compatível** | Suporte total ao protocolo TCP/IP |

| IDE | Versão mínima | Observações |
|---------------------|----------------|-------------|
| **Delphi** | ✅ **XE8** | Suporte multiplataforma completo |

---

**Nota**: Este componente é parte do ecossistema KAFS para integração com servidores DataSnap. Requer configuração prévia do servidor DataSnap e das credenciais apropriadas para funcionamento completo. Certifique-se de ter todas as unidades externas baixadas e configuradas corretamente no projeto.
