# Documentação Adicional do Azure Arc HomeLab

## Configuração Detalhada

### 1. Preparação do Ambiente Azure

#### 1.1 Resource Providers
Antes de iniciar, certifique-se de que os seguintes resource providers estão registrados na sua assinatura:

```bash
# Verificar status dos providers
az provider show --namespace Microsoft.HybridCompute --query "registrationState"
az provider show --namespace Microsoft.GuestConfiguration --query "registrationState"
az provider show --namespace Microsoft.HybridConnectivity --query "registrationState"
```

#### 1.2 Criação do Resource Group
```bash
az group create --name "rg-arc-homelab" --location "East US"
```

### 2. Service Principal

#### 2.1 Criação
```bash
az ad sp create-for-rbac --name "sp-azure-arc-homelab" --role "Azure Connected Machine Onboarding" --scopes "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/rg-arc-homelab"
```

#### 2.2 Permissões Adicionais (se necessário)
```bash
# Para SQL Server Arc-enabled
az role assignment create --assignee "YOUR_SP_OBJECT_ID" --role "SQL Server Contributor" --scope "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/rg-arc-homelab"
```

### 3. Configuração de Rede

#### 3.1 Public Endpoint
- Portas necessárias: 443 (HTTPS)
- URLs permitidas:
  - `*.his.arc.azure.com`
  - `*.guestconfiguration.azure.com`
  - `login.windows.net`
  - `management.azure.com`

#### 3.2 Proxy Configuration
```bash
# Configurar proxy no agente
sudo azcmagent config set proxy.url "http://proxy.company.com:8080"
sudo azcmagent config set proxy.username "proxyuser"
sudo azcmagent config set proxy.password "proxypass"
```

### 4. Monitoramento e Troubleshooting

#### 4.1 Logs do Agente
- **Windows**: `C:\ProgramData\AzureConnectedMachineAgent\Log\`
- **Linux**: `/var/opt/azcmagent/log/`

#### 4.2 Comandos Úteis
```bash
# Verificar status
azcmagent show

# Verificar conectividade
azcmagent check

# Logs em tempo real (Linux)
tail -f /var/opt/azcmagent/log/himds.log

# Logs em tempo real (Windows)
Get-Content "C:\ProgramData\AzureConnectedMachineAgent\Log\himds.log" -Tail 10 -Wait
```

### 5. Extensões Úteis

#### 5.1 Microsoft Monitoring Agent
```bash
# Instalar via Azure CLI
az connectedmachine extension create \
    --machine-name "myserver" \
    --resource-group "rg-arc-homelab" \
    --name "MicrosoftMonitoringAgent" \
    --publisher "Microsoft.EnterpriseCloud.Monitoring" \
    --type "MicrosoftMonitoringAgent" \
    --settings '{"workspaceId":"YOUR_WORKSPACE_ID"}' \
    --protected-settings '{"workspaceKey":"YOUR_WORKSPACE_KEY"}'
```

#### 5.2 Azure Security Center
```bash
az connectedmachine extension create \
    --machine-name "myserver" \
    --resource-group "rg-arc-homelab" \
    --name "AzureSecurityLinuxAgent" \
    --publisher "Qualys" \
    --type "QualysAgent"
```

## Melhores Práticas

### Segurança
- ✅ Use Service Principal com permissões mínimas necessárias
- ✅ Rotacione client secrets regularmente
- ✅ Monitore logs de segurança
- ❌ Nunca hardcode secrets em scripts

### Performance
- ✅ Configure proxy adequadamente se necessário
- ✅ Monitore uso de recursos do agente
- ✅ Use Private Endpoints quando possível

### Manutenção
- ✅ Atualize o agente regularmente
- ✅ Monitore status de conectividade
- ✅ Documente mudanças de configuração
