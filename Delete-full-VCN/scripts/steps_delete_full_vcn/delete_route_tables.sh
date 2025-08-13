#!/bin/bash

set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') | ❌ Uso incorrecto: $0 <compartment_ocid> <vcn_ocid>"
  exit 1
fi

COMPARTMENT_ID=$1
VCN_ID=$2

echo "$(date '+%Y-%m-%d %H:%M:%S') | ▶️ Paso 03 - Eliminar Route Tables: iniciando..."
echo "$(date '+%Y-%m-%d %H:%M:%S') | 🔍 Buscando Route Table default (case-insensitive) en la VCN '$VCN_ID'..."

DEFAULT_RT_OCID=$(oci network route-table list \
  --compartment-id "$COMPARTMENT_ID" \
  --vcn-id "$VCN_ID" \
  --output json | jq -r '.data[] | select((.["display-name"] | ascii_downcase) | contains("default")) | .id' | head -n1)

if [ -z "$DEFAULT_RT_OCID" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') | ℹ️ No se encontró Route Table default en la VCN."
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') | ✅ Route Table default encontrada: $DEFAULT_RT_OCID"

  RULES_COUNT=$(oci network route-table get \
    --rt-id "$DEFAULT_RT_OCID" \
    --output json | jq '.data["route-rules"] | length')

  if [ "$RULES_COUNT" -gt 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ✂️ La Route Table default tiene $RULES_COUNT reglas. Eliminando reglas..."
    oci network route-table update \
      --rt-id "$DEFAULT_RT_OCID" \
      --route-rules '[]' \
      --force > /dev/null
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ✅ Reglas eliminadas de la Route Table default."
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ℹ️ La Route Table default no tiene reglas configuradas."
  fi
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') | 🔍 Buscando Route Tables personalizadas para eliminar..."

CUSTOM_RT_OCIDS=$(oci network route-table list \
  --compartment-id "$COMPARTMENT_ID" \
  --vcn-id "$VCN_ID" \
  --output json | jq -r '.data[] | select((.["display-name"] | ascii_downcase) | contains("default") | not) | .id')

if [ -z "$CUSTOM_RT_OCIDS" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') | ℹ️ No se encontraron Route Tables personalizadas."
else
  for RT_OCID in $CUSTOM_RT_OCIDS; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ➡️ Procesando Route Table: $RT_OCID"

    SUBNETS_ASSOC=$(oci network subnet list \
      --compartment-id "$COMPARTMENT_ID" \
      --vcn-id "$VCN_ID" \
      --output json | jq -r --arg RT_OCID "$RT_OCID" '.data[] | select(.["route-table-id"] == $RT_OCID) | .id')

    if [ -n "$SUBNETS_ASSOC" ]; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') | ❌ No se puede eliminar la Route Table porque tiene subnets asociadas: $SUBNETS_ASSOC"
      continue
    fi

    echo "$(date '+%Y-%m-%d %H:%M:%S') | 🗑️ Eliminando Route Table $RT_OCID..."
    if oci network route-table delete --rt-id "$RT_OCID" --force; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') | ✅ Route Table $RT_OCID eliminada correctamente."
    else
      echo "$(date '+%Y-%m-%d %H:%M:%S') | ⚠️ Error eliminando Route Table $RT_OCID."
    fi
  done
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') | ✅ Paso 03 - Eliminar Route Tables: completado"

