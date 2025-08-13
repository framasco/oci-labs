#!/bin/bash

# ========================================
# Script: delete_vcn.sh
# Autor: Francisco Ramasco
# Descripción: Elimina una VCN de forma segura y controlada.
# Uso: ./delete_vcn.sh <compartment_ocid> <vcn_ocid>
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

log "🗑️ Eliminando VCN: $VCN_ID"

if oci network vcn delete \
    --vcn-id "$VCN_ID" \
    --force \
    --wait-for-state TERMINATED \
    --wait-interval-seconds 5 \
    --max-wait-seconds 90 >/dev/null; then
    log "✅ VCN $VCN_ID eliminada correctamente."
    exit 0
else
    log "❌ Error al eliminar la VCN $VCN_ID."
    exit 1
fi

