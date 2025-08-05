# Azure Policy para Azure Arc

Esta pasta contém exemplos de Azure Policies que podem ser utilizadas com servidores Azure Arc-enabled.

## Policies Incluídas

### Compliance e Configuração
- **require-tags.json**: Exige tags específicas em servidores Arc
- **allowed-locations.json**: Restringe regiões onde servidores podem ser registrados
- **monitoring-agent.json**: Força instalação do Azure Monitor Agent

### Segurança
- **security-baseline.json**: Aplica baseline de segurança
- **antimalware.json**: Configura Microsoft Antimalware
- **disk-encryption.json**: Exige criptografia de disco

## Como Aplicar

### Via Azure CLI
```bash
# Criar policy definition
az policy definition create --name "require-arc-tags" --rules require-tags.json --params require-tags.parameters.json

# Atribuir policy
az policy assignment create --name "require-arc-tags-assignment" --policy "require-arc-tags" --scope "/subscriptions/YOUR_SUBSCRIPTION_ID"
```

### Via Portal Azure
1. Acesse Azure Policy no portal
2. Vá em Definitions
3. Clique em + Policy definition
4. Cole o conteúdo do arquivo JSON
5. Salve e atribua conforme necessário
