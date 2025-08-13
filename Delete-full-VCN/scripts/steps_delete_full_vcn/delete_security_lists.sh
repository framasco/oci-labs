#!/bin/bash

# ========================================
# Script: delete_security_lists.sh
# Autor: Francisco Ramasco
# Descripción: Elimina todas las Security Lists personalizadas de una VCN.
# Uso: ./delete_security_lists.sh <compartment_ocid> <vcn_ocid>
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

log "🔐 Eliminando Security Lists personalizadas de la VCN $VCN_ID..."

SEC_LISTS=$(oci network security-list list \
  --compartment-id "$COMPARTMENT_ID" \
  --vcn-id "$VCN_ID" \
  --output json)

# Verificar que la salida sea JSON válido
if ! echo "$SEC_LISTS" | jq empty >/dev/null 2>&1; then
    log "❌ Error: respuesta no es JSON válido."
    echo "$SEC_LISTS"
    exit 1
fi

# Eliminar todas excepto las "Default Security List"
SEC_IDS=$(echo "$SEC_LISTS" | jq -r '.data[] | select(."display-name" | test("^Default Security List") | not) | .id')

if [[ -z "$SEC_IDS" ]]; then
    log "ℹ️ No se encontraron Security Lists personalizadas para eliminar."
    exit 0
fi

for SEC_ID in $SEC_IDS; do
    SEC_NAME=$(echo "$SEC_LISTS" | jq -r --arg ID "$SEC_ID" '.data[] | select(.id == $ID) | ."display-name"')
    log "🧹 Eliminando Security List: $SEC_NAME ($SEC_ID)"
    
    if oci network security-list delete \
        --security-list-id "$SEC_ID" \
        --force \
        --wait-for-state TERMINATED \
        --wait-interval-seconds 5 \
        --max-wait-seconds 90 >/dev/null; then
        log "✅ Eliminada: $SEC_NAME"
    else
        log "❌ Error al eliminar $SEC_NAME ($SEC_ID)"
        exit 1
    fi
done

log "✅ Todas las Security Lists personalizadas fueron eliminadas exitosamente."

