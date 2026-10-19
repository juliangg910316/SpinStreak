#!/usr/bin/env bash
# Genera los iconos de la app (spec 006) a partir de docs/marca/simbolo.svg.
#
# Pasa el SVG a PNG con Google Chrome en modo headless, a tamaño exacto, para
# cada variante de la sección 4.2 del plan 006. No forma parte del build: se
# ejecuta a mano cuando cambia el símbolo.
#
# Uso: tool/generar_iconos.sh [--instalar] [carpeta_de_salida]
#   Sin carpeta, usa una temporal y la indica al terminar.
#   Con --instalar, además copia los iconos a android/ e ios/.

set -euo pipefail

instalar=no
if [[ "${1:-}" == --instalar ]]; then
  instalar=si
  shift
fi

raiz="$(cd "$(dirname "$0")/.." && pwd)"
simbolo="$raiz/docs/marca/simbolo.svg"
chrome="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
salida="${1:-$(mktemp -d)}"
trabajo="$(mktemp -d)"
trap 'rm -rf "$trabajo"' EXIT

if [[ ! -x "$chrome" ]]; then
  echo "No encuentro Chrome en: $chrome (cámbialo con CHROME=...)" >&2
  exit 1
fi
mkdir -p "$salida"

# Vistas del lienzo de 108: entero (capas de Android) o centrado (iOS y
# Android antiguo).
VISTA_CAPA='0 0 108 108'
VISTA_ICONO='14 14 80 80'

# generar <png> <px> <vista> <fondo|none> <rueda> <llama> <transparente:si|no> <radio>
generar() {
  local png="$1" px="$2" vista="$3" fondo="$4" rueda="$5" llama="$6"
  local transparente="$7" radio="$8"
  local nombre
  nombre="$(basename "$png" .png)-$px"

  sed -e "s/viewBox=\"0 0 108 108\"/viewBox=\"$vista\"/" \
    -e "s/fill=\"#FFF8F3\"/fill=\"$fondo\"/" \
    -e "s/stroke=\"#1F1A17\"/stroke=\"$rueda\"/" \
    -e "s/fill=\"#FF5A1F\"/fill=\"$llama\"/" \
    "$simbolo" >"$trabajo/$nombre.svg"

  cat >"$trabajo/$nombre.html" <<EOF
<!doctype html>
<html><body style="margin:0;background:transparent">
<img src="$nombre.svg" style="display:block;width:${px}px;height:${px}px;border-radius:$radio">
</body></html>
EOF

  # Sin color de fondo por defecto, Chrome pinta blanco y el PNG sale sin
  # alfa (lo que pide iOS para el icono claro y el tintado).
  local fondo_chrome=()
  if [[ "$transparente" == si ]]; then
    fondo_chrome=(--default-background-color=00000000)
  fi

  mkdir -p "$(dirname "$png")"
  "$chrome" --headless=new --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=1 --window-size="$px,$px" \
    ${fondo_chrome[@]+"${fondo_chrome[@]}"} \
    --screenshot="$png" "file://$trabajo/$nombre.html" >/dev/null 2>&1

  if [[ ! -s "$png" ]]; then
    echo "No se generó $png" >&2
    exit 1
  fi
}

# iOS: 1024 px. El claro y el tintado, opacos; el oscuro, con el fondo
# transparente para que iOS ponga el suyo (RF-6).
generar "$salida/ios/icono-claro.png" 1024 "$VISTA_ICONO" '#FFF8F3' '#1F1A17' '#FF5A1F' no 0
generar "$salida/ios/icono-oscuro.png" 1024 "$VISTA_ICONO" none '#FFF8F3' '#FF5A1F' si 0
generar "$salida/ios/icono-tintado.png" 1024 "$VISTA_ICONO" '#000000' '#B8B8B8' '#FFFFFF' no 0

# Android: capas del icono adaptativo (108 dp) y el icono antiguo (48 dp,
# cuadrado redondeado) para Android 7.
for densidad in mdpi:1 hdpi:1.5 xhdpi:2 xxhdpi:3 xxxhdpi:4; do
  carpeta="$salida/android/mipmap-${densidad%%:*}"
  escala="${densidad##*:}"
  capa="$(awk "BEGIN { print 108 * $escala }")"
  antiguo="$(awk "BEGIN { print 48 * $escala }")"
  generar "$carpeta/ic_launcher_foreground.png" "$capa" "$VISTA_CAPA" none '#1F1A17' '#FF5A1F' si 0
  generar "$carpeta/ic_launcher_monochrome.png" "$capa" "$VISTA_CAPA" none '#000000' '#000000' si 0
  generar "$carpeta/ic_launcher.png" "$antiguo" "$VISTA_ICONO" '#FFF8F3' '#1F1A17' '#FF5A1F' si 24%
done

echo "Iconos generados en: $salida"

if [[ "$instalar" == si ]]; then
  res="$raiz/android/app/src/main/res"
  for carpeta in "$salida"/android/mipmap-*dpi; do
    cp "$carpeta"/*.png "$res/$(basename "$carpeta")/"
  done
  echo "Iconos copiados a: $res"

  iconos_ios="$raiz/ios/Runner/Assets.xcassets/AppIcon.appiconset"
  cp "$salida"/ios/*.png "$iconos_ios/"
  echo "Iconos copiados a: $iconos_ios"
fi
