# Scripts de Instalação do Azure Arc

Esta pasta contém scripts para instalação e configuração do Azure Arc em diferentes sistemas operacionais.

## Estrutura

- **windows/**: Scripts PowerShell para Windows Server
- **linux/**: Scripts Bash para distribuições Linux

## Como Usar

1. Gere o script de instalação no portal do Azure Arc
2. Substitua o `<ENTER SECRET HERE>` pelo client secret baixado
3. Execute o script apropriado para seu sistema operacional

## Importante

⚠️ **Segurança**: Nunca commit client secrets ou informações sensíveis no repositório. Use variáveis de ambiente ou arquivos de configuração separados.

## Pré-requisitos

- Resource providers registrados na assinatura Azure
- Service Principal criado (para instalação em múltiplos servidores)
- Conectividade com o Azure (internet, proxy ou private endpoint)
