#!/bin/bash

# ========================================
# Script: delete_nsgs.sh
# Autor: Francisco Ramasco
# Descripción: Elimina todos los Network Security Groups (NSGs) asociados a una VCN.
# Uso: ./delete_nsgs.sh <compartment_ocid> <vcn_ocid>
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

log "🔍 Buscando NSGs asociados a la VCN '$VCN_ID' en el compartimento '$COMPARTMENT_ID'..."

# Obtener lista de NSGs como array
mapfile -t NSG_OCIDS < <(
    oci network nsg list \
        --compartment-id "$COMPARTMENT_ID" \
        --vcn-id "$VCN_ID" \
        --query "data[].id" \
        --raw-output
)

if [[ ${#NSG_OCIDS[@]} -eq 0 ]]; then
    log "ℹ️ No se encontraron NSGs asociados a la VCN."
    exit 0
fi

ERROR_OCCURRED=0

for NSG_ID in "${NSG_OCIDS[@]}"; do
    log "🗑️ Eliminando NSG: $NSG_ID ..."
    if oci network nsg delete \
        --nsg-id "$NSG_ID" \
        --force \
        --wait-for-state TERMINATED \
        --wait-interval-seconds 5 \
        --max-wait-seconds 60 >/dev/null; then
        log "✅ NSG $NSG_ID eliminado correctamente."
    else
        log "❌ Error al eliminar NSG $NSG_ID."
        ERROR_OCCURRED=1
    fi
done

if [[ $ERROR_OCCURRED -eq 1 ]]; then
    log "⚠️ Uno o más NSGs no pudieron eliminarse."
    exit 1
else
    log "🎯 Todos los NSGs fueron eliminados exitosamente."
    exit 0
fi

