#!/bin/bash

# ========================================
# Script: delete_subnets.sh
# Autor: Francisco Ramasco
# Descripción: Elimina todas las subnets asociadas a una VCN.
# Uso: ./delete_subnets.sh <compartment_ocid> <vcn_ocid>
# ========================================

COMPARTMENT_ID="$1"
VCN_ID="$2"

if [[ -z "$COMPARTMENT_ID" || -z "$VCN_ID" ]]; then
    echo "❌ Uso: $0 <compartment_ocid> <vcn_ocid>"
    exit 1
fi

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1"
}

log "🔍 Buscando subnets en la VCN '$VCN_ID'..."

SUBNETS_JSON=$(oci network subnet list \
    --compartment-id "$COMPARTMENT_ID" \
    --vcn-id "$VCN_ID" \
    --output json)

if ! echo "$SUBNETS_JSON" | jq empty >/dev/null 2>&1; then
    log "❌ Error: respuesta no es JSON válido"
    echo "$SUBNETS_JSON"
    exit 1
fi

SUBNET_IDS=$(echo "$SUBNETS_JSON" | jq -r '.data[]?.id')

if [[ -z "$SUBNET_IDS" ]]; then
    log "ℹ️ No se encontraron subnets en la VCN."
    exit 0
fi

ERROR_OCCURRED=0

for SUBNET_ID in $SUBNET_IDS; do
    log "🗑️ Eliminando subnet: $SUBNET_ID ..."
    if oci network subnet delete \
        --subnet-id "$SUBNET_ID" \
        --force \
        --wait-for-state TERMINATED \
        --wait-interval-seconds 5 \
        --max-wait-seconds 60 >/dev/null; then
        log "✅ Subnet $SUBNET_ID eliminada correctamente."
    else
        log "❌ Error al eliminar subnet $SUBNET_ID."
        ERROR_OCCURRED=1
    fi
done

if [[ $ERROR_OCCURRED -eq 1 ]]; then
    log "⚠️ Una o más subnets no pudieron eliminarse."
    exit 1
else
    log "🎯 Todas las subnets fueron eliminadas exitosamente."
    exit 0
fi

