#!/bin/bash

# ========================================
# Script Maestro: delete_full_vcn.sh
# Autor: Francisco Ramasco
# Descripción: Elimina todos los componentes de una VCN en orden controlado.
# Uso: ./delete_full_vcn.sh <compartment_ocid> <vcn_ocid> [paso_inicial]
# ========================================

COMPARTMENT_ID=$1
VCN_ID=$2
START_STEP=${3:-00}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STEP_DIR="$SCRIPT_DIR/steps_delete_full_vcn"
LOG_DIR="$SCRIPT_DIR/logs"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$LOG_DIR/delete_full_vcn_$TIMESTAMP.log"

mkdir -p "$STEP_DIR" "$LOG_DIR"

if [[ -z "$COMPARTMENT_ID" || -z "$VCN_ID" ]]; then
    echo "❌ Uso: $0 <compartment_ocid> <vcn_ocid> [paso_inicial]"
    exit 1
fi

log() {
    local mensaje="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $mensaje" | tee -a "$LOG_FILE"
}

run_step() {
    local num="$1"
    local nombre="$2"
    local script="$STEP_DIR/$3"

    if [[ "$START_STEP" > "$num" ]]; then
        log "⏩ Paso $num - $nombre: saltado (ya ejecutado o se parte desde paso posterior)"
        return 0
    fi

    if [[ ! -f "$script" ]]; then
        log "❌ Script '$script' no encontrado."
        exit 99
    fi

    log "▶️ Paso $num - $nombre: ejecutando..."
    bash "$script" "$COMPARTMENT_ID" "$VCN_ID"
    local estado=$?
    if [[ $estado -ne 0 ]]; then
        log "❌ Fallo en el paso $num - $nombre (Código de salida: $estado)"
        log "💡 Reejecutar desde este paso con: $0 $COMPARTMENT_ID $VCN_ID $num"
        exit $num
    fi
    log "✅ Paso $num - $nombre: completado"
}

# Ejecución paso a paso
run_step "01" "Eliminar Subnets" "delete_subnets.sh"
run_step "02" "Eliminar NSGs" "delete_nsgs.sh"
run_step "03" "Eliminar Route Tables" "delete_route_tables.sh"
run_step "04" "Eliminar Security Lists" "delete_security_lists.sh"
run_step "05" "Eliminar Gateways" "delete_all_gateways.sh"
run_step "06" "Eliminar VCN" "delete_vcn.sh"

log "🎉 Todos los pasos ejecutados exitosamente. VCN eliminada por completo."

