<div align="center">
<img width="188" height="200" alt="image" src="https://github.com/user-attachments/assets/60d8a531-d1b0-4282-a91c-0d24467ffd8b" /></div><p>

# <div align="center"><strong>TKAFSConexaoDataSnap</strong></div> 

<div align="center">
Componente Delphi/FireMonkey para conexão DataSnap com suporte a reconexão automática,<br> 
persistência de configurações e interface de fallback para entrada manual de dados do servidor.
</p>

[![Delphi](https://img.shields.io/badge/Delphi-XE8+-B22222?logo=delphi)](https://www.embarcadero.com/products/delphi)
[![SQLConnection](https://img.shields.io/badge/SQLConnection-Connector-FF6600)]([https://www.embarcadero.com/products/firedac](https://docwiki.embarcadero.com/RADStudio/Athens/en/FireDAC))
[![Multiplatform](https://img.shields.io/badge/Multiplatform-Windows/Linux/macOS/Android/IOS-8250DF)]([https://www.embarcadero.com/products/delphi/cross-platform](https://docwiki.embarcadero.com/RADStudio/Athens/en/Developing_Multi-Device_Applications))
[![License](https://img.shields.io/badge/License-GPLv3-blue)](LICENSE)
</div><br>

## ⚠️ Dependências externas

Este componente utiliza a seguinte unit externa que deve ser adicionada ao projeto:

- [uKAFSFuncoes](https://github.com/ViniciusdoAmaralReis/uKAFSFuncoes)
<div></div><br><br>

## ⚡ Instanciação básica
```pascal
var _conexao := TKAFSConexaoDataSnap.Create(nil);
try
  // A conexão é estabelecida automaticamente no construtor
finally
  FreeAndNil(_conexao);
end;
```
<div></div><br><br>


---
**Nota**: Este componente é parte do ecossistema KAFS para integração com servidores DataSnap. Requer configuração prévia do servidor DataSnap e das credenciais apropriadas para funcionamento completo. Certifique-se de ter todas as unidades externas baixadas e configuradas corretamente no projeto.
