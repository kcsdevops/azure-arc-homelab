#!/bin/bash

# Exemplo de Script de Instalação Azure Arc - Linux
# IMPORTANTE: Substitua as variáveis abaixo pelos valores corretos
# Este é um template baseado no script gerado pelo portal do Azure

# Variáveis de configuração
SUBSCRIPTION_ID="YOUR_SUBSCRIPTION_ID"
RESOURCE_GROUP="YOUR_RESOURCE_GROUP"
TENANT_ID="YOUR_TENANT_ID"
LOCATION="YOUR_LOCATION"
SERVICE_PRINCIPAL_ID="YOUR_SERVICE_PRINCIPAL_ID"
SERVICE_PRINCIPAL_CLIENT_SECRET="YOUR_CLIENT_SECRET"  # ⚠️ NÃO COMMITAR ESTE VALOR

# Função para log
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Iniciando instalação do Azure Arc Agent..."

# Detectar distribuição Linux
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VERSION=$VERSION_ID
else
    log "❌ Não foi possível detectar a distribuição Linux"
    exit 1
fi

log "Sistema detectado: $OS $VERSION"

# Download e instalação do Azure Connected Machine Agent
log "Baixando o Azure Connected Machine Agent..."

case "$OS" in
    "Ubuntu"*)
        # Ubuntu/Debian
        wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh
        bash ~/install_linux_azcmagent.sh
        ;;
    "CentOS"* | "Red Hat"* | "RHEL"*)
        # RHEL/CentOS
        wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh
        bash ~/install_linux_azcmagent.sh
        ;;
    "SUSE"* | "openSUSE"*)
        # SUSE
        wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh
        bash ~/install_linux_azcmagent.sh
        ;;
    *)
        log "❌ Distribuição Linux não suportada: $OS"
        exit 1
        ;;
esac

if [ $? -eq 0 ]; then
    log "✅ Azure Connected Machine Agent instalado com sucesso!"
else
    log "❌ Erro na instalação do Azure Connected Machine Agent"
    exit 1
fi

# Conectar ao Azure Arc
log "Conectando o servidor ao Azure Arc..."

sudo azcmagent connect \
    --service-principal-id "$SERVICE_PRINCIPAL_ID" \
    --service-principal-secret "$SERVICE_PRINCIPAL_CLIENT_SECRET" \
    --resource-group "$RESOURCE_GROUP" \
    --tenant-id "$TENANT_ID" \
    --location "$LOCATION" \
    --subscription-id "$SUBSCRIPTION_ID" \
    --cloud "AzureCloud"

if [ $? -eq 0 ]; then
    log "✅ Servidor conectado com sucesso ao Azure Arc!"
else
    log "❌ Erro ao conectar o servidor ao Azure Arc"
    exit 1
fi

log "Instalação concluída!"

# Verificar status da conexão
log "Verificando status da conexão..."
sudo azcmagent show
