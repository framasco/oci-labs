#!/bin/bash

# ========================================
# Script: delete_all_gateways.sh
# Autor: Francisco Ramasco
# Descripción: Elimina todos los Gateways (Internet, NAT, Service, LPGs y DRG) asociados a una VCN.
# Uso: ./delete_all_gateways.sh <compartment_ocid> <vcn_ocid>
# ========================================

set -euo pipefail

COMPARTMENT_ID="$1"
VCN_ID="$2"

if [[ -z "$COMPARTMENT_ID" || -z "$VCN_ID" ]]; then
    echo "❌ Uso: $0 <compartment_ocid> <vcn_ocid>"
    exit 1
fi

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1"
}

delete_resources() {
    local label="$1"
    local list_cmd="$2"
    local delete_cmd="$3"
    local id_param="$4"

    log "🔎 Buscando $label..."
    IDS=$(eval "$list_cmd" | jq -r '.[]')

    for ID in $IDS; do
        log "🧹 Eliminando $label: $ID"
        if oci $delete_cmd --$id_param "$ID" --force --wait-for-state TERMINATED >/dev/null 2>&1; then
            log "✅ $label eliminado correctamente: $ID"
        else
            log "❌ Error eliminando $label: $ID"
        fi
    done
}

log "=== Eliminando TODOS los Gateways asociados a la VCN: $VCN_ID ==="

# 1. Internet Gateways
delete_resources "Internet Gateway" \
  "oci network internet-gateway list --compartment-id $COMPARTMENT_ID --vcn-id $VCN_ID --query \"data[?\\\"lifecycle-state\\\"=='AVAILABLE'].id\" --output json" \
  "network internet-gateway delete" "ig-id"

# 2. NAT Gateways
delete_resources "NAT Gateway" \
  "oci network nat-gateway list --compartment-id $COMPARTMENT_ID --vcn-id $VCN_ID --query \"data[?\\\"lifecycle-state\\\"=='AVAILABLE'].id\" --output json" \
  "network nat-gateway delete" "nat-gateway-id"

# 3. Service Gateways
delete_resources "Service Gateway" \
  "oci network service-gateway list --compartment-id $COMPARTMENT_ID --vcn-id $VCN_ID --query \"data[?\\\"lifecycle-state\\\"=='AVAILABLE'].id\" --output json" \
  "network service-gateway delete" "service-gateway-id"

# 4. Local Peering Gateways
delete_resources "Local Peering Gateway (LPG)" \
  "oci network local-peering-gateway list --compartment-id $COMPARTMENT_ID --vcn-id $VCN_ID --query \"data[?\\\"lifecycle-state\\\"=='AVAILABLE'].id\" --output json" \
  "network local-peering-gateway delete" "local-peering-gateway-id"

# 5. DRG Attachments y DRG
log "🔎 Buscando DRGs disponibles..."
DRG_IDS=$(oci network drg list \
  --compartment-id "$COMPARTMENT_ID" \
  --query "data[?\"lifecycle-state\"=='AVAILABLE'].id" \
  --output json | jq -r '.[]')

for DRG_ID in $DRG_IDS; do
    log "🌐 Procesando DRG: $DRG_ID"

    ATTACHMENTS=$(oci network drg-attachment list \
      --compartment-id "$COMPARTMENT_ID" \
      --drg-id "$DRG_ID" \
      --query "data[?\"lifecycle-state\"=='ATTACHED'].id" \
      --output json | jq -r '.[]')

    for ATT_ID in $ATTACHMENTS; do
        log "🔌 Eliminando DRG Attachment: $ATT_ID"
        if oci network drg-attachment delete \
          --drg-attachment-id "$ATT_ID" \
          --force \
          --wait-for-state TERMINATED >/dev/null; then
            log "✅ Attachment eliminado: $ATT_ID"
        else
            log "❌ Error eliminando attachment: $ATT_ID"
        fi
    done

    log "🧹 Eliminando DRG: $DRG_ID"
    if oci network drg delete --drg-id "$DRG_ID" --force --wait-for-state TERMINATED >/dev/null; then
        log "✅ DRG eliminado: $DRG_ID"
    else
        log "❌ Error eliminando DRG: $DRG_ID"
    fi
done

log "✅ Todos los Gateways (incluyendo DRG) han sido eliminados correctamente."

