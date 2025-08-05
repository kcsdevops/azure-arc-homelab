# Azure Arc HomeLab

Este repositório contém documentação e scripts para habilitar um ambiente HomeLab no Azure Arc, permitindo o gerenciamento centralizado de servidores on-premises através do portal do Azure.

## Sobre o Azure Arc

O Azure Arc é uma solução da Microsoft que permite estender os serviços e as capacidades do Microsoft Azure para ambientes on-premises, como datacenters locais, outras nuvens (AWS, GCP ou OCI) e dispositivos em borda (edge).

Ele basicamente permite que você gerencie e controle recursos de infraestrutura e aplicações que estão em diferentes ambientes, tudo a partir de um único painel do Azure.

### Recursos Suportados

Atualmente, o Azure Arc permite que você gerencie os seguintes tipos de recursos hospedados fora do Azure:

- Servidores físicos e virtuais Linux e Windows
- Clusters de Kubernetes
- Servidores SQL Server
- Hypervisors VMWare e Hyper-V

## Funcionalidades do Azure Arc

Ao conectar seu servidor ao Azure Arc, você pode executar muitas funções operacionais:

### 🎛️ Controlar

- Atribua Configurações de servidor do Azure para auditar as configurações dentro do computador usando Azure Policy

### 🛡️ Proteger

- Proteja servidores que não são do Azure com o Microsoft Defender endpoint

### ⚙️ Configurar

- Use a Automation Account do Azure para tarefas de gerenciamento frequentes e demoradas com runbooks do PowerShell

### 🔄 Atualizar

- Use o Update Manager do Azure para gerenciar atualizações do sistema operacional dos seus servidores Windows e Linux

### 📊 Monitorar

- Monitore o desempenho do sistema operacional e descubra os componentes do aplicativo para monitorar os processos e dependências com outros recursos usando os insights da VM

## Pré-requisitos

### Resource Providers

Antes de usar o Azure Arc, é necessário registrar os seguintes providers na sua assinatura Azure:

- `Microsoft.HybridCompute`
- `Microsoft.GuestConfiguration`
- `Microsoft.HybridConnectivity`
- `Microsoft.AzureArcData` (Se for usar Arc-enabled SQL Servers)
- `Microsoft.Compute` (Se for usar o Azure Update Manager)

### Registro via PowerShell

```powershell
Connect-AzAccount
Set-AzContext -SubscriptionId [subscription you want to onboard]
Register-AzResourceProvider -ProviderNamespace Microsoft.HybridCompute
Register-AzResourceProvider -ProviderNamespace Microsoft.GuestConfiguration
Register-AzResourceProvider -ProviderNamespace Microsoft.HybridConnectivity
Register-AzResourceProvider -ProviderNamespace Microsoft.AzureArcData
```

### Registro via Azure CLI

```bash
az account set --subscription "{Your Subscription Name}"
az provider register --namespace 'Microsoft.HybridCompute'
az provider register --namespace 'Microsoft.GuestConfiguration'
az provider register --namespace 'Microsoft.HybridConnectivity'
az provider register --namespace 'Microsoft.AzureArcData'
```

## Configuração do HomeLab

### Servidores Testados

Este projeto foi testado com os seguintes sistemas operacionais:

- **Windows Server 2022**
- **Debian GNU/Linux 12**
- **Ubuntu 24.04.1 LTS** (Cloud image)

> **Nota sobre Cloud Images**: São snapshots leves (geralmente abaixo de 700 MB) de um SO configurado criado por um publicador para uso com nuvens públicas e privadas.

## Métodos de Conexão

### Single Server vs Multiple Servers

#### Add a Single Server

- O script permitirá você adicionar um servidor por vez
- Requer autenticação no portal do Azure a cada execução
- Ideal para testes e ambientes pequenos

#### Add Multiple Servers

- Utiliza Service Principal para autenticação
- Permite registro em lote de servidores
- Recomendado para ambientes corporativos e GPOs

### Opções de Conectividade

1. **Public Endpoint**: Todo o tráfego pela internet
2. **Proxy Server**: Comunicação através de servidor proxy
3. **Private Endpoint**: Comunicação via VPN ou ExpressRoute

## Service Principal - Configuração

### Detalhes do Service Principal

- **Nome**: Escolha um nome que identifique claramente o propósito
- **Scope Assignment Level**: Permissão na assinatura inteira ou apenas no resource group

### Client Secret

- **Description**: Nome amigável para gerenciar o client secret
- **Expires**: Duração da validade (1 dia, 1 semana, 1 mês ou personalizado)

### Permissões Recomendadas

- **Azure Connected Machine Onboarding**: Pode integrar máquinas conectadas do Azure ✅ *Recomendado*
- **Kubernetes Cluster - Azure Arc Onboarding**: Para clusters Kubernetes
- **Azure Connected Machine Resource Administrator**: Permissões completas de gerenciamento

## Scripts de Instalação

### Preparação do Script

1. Gere o script no portal do Azure Arc
2. Baixe o client secret e client ID
3. Substitua `<ENTER SECRET HERE>` no script pelo conteúdo do arquivo .txt baixado

```powershell
# Add the service principal application ID and secret here
$ServicePrincipalId="443a3c0a-9753-4b00-b328-a389d1340135";
$ServicePrincipalClientSecret="<ENTER SECRET HERE>";
```

### Execução

Execute o script gerado nos servidores que deseja conectar ao Azure Arc.

## Monitoramento e Logs

Após a configuração bem-sucedida, os servidores aparecerão no portal do Azure com status "Conectado". É possível configurar:

- Coleta de logs em Log Analytics Workspace
- Métricas de performance
- Alertas e monitoramento

## Próximos Passos

- [ ] Configurar Azure Policy para compliance
- [ ] Implementar Microsoft Defender
- [ ] Configurar Update Manager
- [ ] Explorar Automation Account com runbooks
- [ ] Configurar monitoramento avançado

## Recursos Úteis

### Documentação Oficial

- [What is Azure Arc-enabled servers?](https://learn.microsoft.com/en-us/azure/azure-arc/servers/overview)
- [Connect hybrid machines to Azure at scale](https://learn.microsoft.com/en-us/azure/azure-arc/servers/onboard-service-principal)

### Estrutura do Repositório

```text
azure-arc-homelab/
├── README.md                 # Este arquivo
├── scripts/                  # Scripts de instalação e configuração
│   ├── windows/             # Scripts específicos para Windows
│   └── linux/               # Scripts específicos para Linux
├── docs/                    # Documentação adicional
├── policies/                # Azure Policies personalizadas
└── monitoring/              # Configurações de monitoramento
```

## Contribuições

Contribuições são bem-vindas! Por favor, abra uma issue ou pull request para melhorias.

## Licença

Este projeto está licenciado sob [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

---

**Autor**: Baseado no artigo original de [Luiz Henrique Arantes](https://www.linkedin.com/in/luizhenriquearantes)  
**Tags**: Azure, Arc, HomeLab, Hybrid Cloud, Infrastructure Management
