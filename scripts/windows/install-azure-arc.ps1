# Exemplo de Script de Instalação Azure Arc - Windows

# IMPORTANTE: Substitua as variáveis abaixo pelos valores corretos
# Este é um template baseado no script gerado pelo portal do Azure

# Variáveis de configuração
$SubscriptionId = "YOUR_SUBSCRIPTION_ID"
$ResourceGroup = "YOUR_RESOURCE_GROUP"
$TenantId = "YOUR_TENANT_ID"
$Location = "YOUR_LOCATION"
$ServicePrincipalId = "YOUR_SERVICE_PRINCIPAL_ID"
$ServicePrincipalClientSecret = "YOUR_CLIENT_SECRET"  # ⚠️ NÃO COMMITAR ESTE VALOR

# Função para log
function Write-Log {
    param($Message)
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
}

Write-Log "Iniciando instalação do Azure Arc Agent..."

try {
    # Download and install the Azure Connected Machine Agent
    Write-Log "Baixando o Azure Connected Machine Agent..."
    Invoke-WebRequest -Uri "https://aka.ms/AzureConnectedMachineAgent" -OutFile AzureConnectedMachineAgent.msi
    
    Write-Log "Instalando o Azure Connected Machine Agent..."
    Start-Process msiexec.exe -Wait -ArgumentList "/i AzureConnectedMachineAgent.msi /l*v installationlog.txt /qn"
    
    # Connect to Azure Arc
    Write-Log "Conectando o servidor ao Azure Arc..."
    & "$env:ProgramFiles\AzureConnectedMachineAgent\azcmagent.exe" connect `
        --service-principal-id $ServicePrincipalId `
        --service-principal-secret $ServicePrincipalClientSecret `
        --resource-group $ResourceGroup `
        --tenant-id $TenantId `
        --location $Location `
        --subscription-id $SubscriptionId `
        --cloud "AzureCloud" `
        --correlation-id ([System.Guid]::NewGuid())
    
    if ($LASTEXITCODE -eq 0) {
        Write-Log "✅ Servidor conectado com sucesso ao Azure Arc!"
    } else {
        Write-Log "❌ Erro ao conectar o servidor ao Azure Arc. Código de saída: $LASTEXITCODE"
        exit $LASTEXITCODE
    }
    
} catch {
    Write-Log "❌ Erro durante a instalação: $($_.Exception.Message)"
    exit 1
}

Write-Log "Instalação concluída!"
