# Configurações de Monitoramento

Esta pasta contém configurações para monitoramento de servidores Azure Arc-enabled.

## Arquivos Incluídos

- **log-analytics-workspace.json**: Template ARM para criação do workspace
- **monitoring-dashboard.json**: Dashboard customizado para monitoramento
- **alerts.json**: Configurações de alertas recomendadas
- **kql-queries.md**: Queries KQL úteis para análise de logs

## Log Analytics Workspace

### Criação via Azure CLI
```bash
az monitor log-analytics workspace create \
    --resource-group "rg-arc-homelab" \
    --workspace-name "law-arc-homelab" \
    --location "East US" \
    --sku "PerGB2018"
```

### Conectar Servidores Arc
```bash
# Instalar extensão Log Analytics
az connectedmachine extension create \
    --machine-name "SERVER_NAME" \
    --resource-group "rg-arc-homelab" \
    --name "MicrosoftMonitoringAgent" \
    --publisher "Microsoft.EnterpriseCloud.Monitoring" \
    --type "MicrosoftMonitoringAgent" \
    --settings "{\"workspaceId\":\"WORKSPACE_ID\"}" \
    --protected-settings "{\"workspaceKey\":\"WORKSPACE_KEY\"}"
```

## Alertas Recomendados

### Conectividade
- Servidor desconectado por mais de 5 minutos
- Falha na comunicação com o Azure

### Performance
- CPU > 80% por 10 minutos
- Memória > 90% por 5 minutos
- Disco < 10% espaço livre

### Segurança
- Falhas de autenticação
- Tentativas de acesso não autorizado
- Alterações em configurações críticas
