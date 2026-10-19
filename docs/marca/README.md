# Marca — Rueda Viva

Nombre y logo de la app (spec 006). Diseño de referencia: tablero «C · Rueda Viva» del lienzo https://claude.ai/artifact/Lb8Ea2k8nbwZStQ324fmuc.

## Símbolo
`simbolo.svg`: rueda de bici vista de frente en un lienzo de 108 × 108 (el del icono adaptativo de Android).
- Cubierta: círculo de radio 24 con trazo 6,5.
- 7 radios (uno por día de una semana seguida): trazo 3,4, de r 5 a r 21,5; el primero a −90° + 360/14.
- Buje: la llama de la racha, trasladada a (54, 57,5) y escalada 0,78. Su contorno (trazo 7) y su recorte interior son **máscaras**: dejan ver el fondo, sea un color o transparente.

El widget `SimboloRueda` de la app dibuja la misma geometría.

## Variantes
| Variante | Vista | Fondo | Rueda | Llama | Archivo |
| --- | --- | --- | --- | --- | --- |
| iOS claro | 14..94 | `#FFF8F3` | `#1F1A17` | `#FF5A1F` | `icono-claro.png` (1024, sin alfa) |
| iOS oscuro | 14..94 | transparente | `#FFF8F3` | `#FF5A1F` | `icono-oscuro.png` (1024) |
| iOS tintado | 14..94 | `#000000` | `#B8B8B8` | `#FFFFFF` | `icono-tintado.png` (1024, sin alfa) |
| Android primer plano | 0..108 | transparente | `#1F1A17` | `#FF5A1F` | `ic_launcher_foreground.png` (108 dp) |
| Android monocromo | 0..108 | transparente | negro | negro | `ic_launcher_monochrome.png` (108 dp) |
| Android antiguo (7) | 14..94, radio 24 % | `#FFF8F3` | `#1F1A17` | `#FF5A1F` | `ic_launcher.png` (48 dp) |

El fondo del icono adaptativo (`#FFF8F3`) es un color de Android, no una imagen.

## Regenerar los iconos
Hace falta Google Chrome (o indicar otro con `CHROME=...`).

```bash
tool/generar_iconos.sh [--instalar] [carpeta_de_salida]
```

Genera todas las variantes en la carpeta indicada (o en una temporal), en dos subcarpetas: `ios/` y `android/mipmap-*dpi/`. Con `--instalar`, además las copia a `android/app/src/main/res/mipmap-*dpi/`, donde las usa `mipmap-anydpi-v26/ic_launcher.xml` (fondo en `values/ic_launcher_background.xml`). Los de iOS van a `ios/Runner/Assets.xcassets/AppIcon.appiconset/`, con un `Contents.json` de tamaño único y tres apariencias (Xcode genera el resto de tamaños).
