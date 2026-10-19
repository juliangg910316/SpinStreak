# Plan 006 — Nombre y logo de la app
Estado: aprobada

Spec: `specs/006-nombre-logo/spec.md` (aprobada). Respeta `docs/constitution.md` y las capas de `AGENTS.md`. **Sin dependencias nuevas**, **sin cambios en las tablas de drift** y **sin cambios en `domain` ni `data`**. Cambian los recursos nativos de `android/` e `ios/`, la barra del inicio y el título de `MaterialApp`. No se toca ningún identificador: `applicationId`, `namespace`, `PRODUCT_BUNDLE_IDENTIFIER`, el paquete `spin_streak` y la BD `spinstreak` siguen igual (RNF-3).

## 1. Qué ya existe

| Pieza | Estado | RF |
| --- | --- | --- |
| `android:label="spin_streak"` en `AndroidManifest.xml` | **Cambia** a "Rueda Viva" | RF-1 |
| `CFBundleDisplayName` = "Spin Streak" en `Info.plist` | **Cambia** a "Rueda Viva" | RF-1, RF-2 |
| `MaterialApp(title: 'SpinStreak')` | **Cambia** a 'Rueda Viva' (Android lo usa en las apps recientes) | RF-2 |
| Icono por defecto de Flutter: 5 `mipmap-*/ic_launcher.png`, sin icono adaptativo | **Se sustituye**: icono adaptativo con capa monocroma y los PNG antiguos para Android 7 (minSdk 24) | RF-3 a RF-5, RF-8 |
| `AppIcon.appiconset` con 15 PNG de tamaños sueltos | **Se sustituye** por un icono único de 1024 px en tres apariencias (claro, oscuro y tintado) | RF-3, RF-6 a RF-8 |
| Inicio: `AppBar` con "Spin" + "Streak" en `textoPrincipal` | **Cambia**: símbolo de 32 px + "Rueda Viva" con "Viva" en `textoPrincipal` | RF-9 a RF-11 |

## 2. Archivos y responsabilidades

### Fuente del logo y generación
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `docs/marca/simbolo.svg` | Crear | Geometría del símbolo en un lienzo de 108 × 108, copiada del componente "Icono" del diseño de referencia: cubierta (círculo r 24, trazo 6,5), 7 radios (trazo 3,4, de r 5 a r 21,5, el primero a −90° + 360/14) y llama (trasladada a 54, 57,5 y escalada 0,78) con su contorno y su recorte interior. Una plantilla con los colores de cada variante | RF-3, RF-8 |
| `docs/marca/README.md` | Crear | Variantes, colores, cómo regenerar los iconos y de dónde sale cada archivo | — |
| `tool/generar_iconos.sh` | Crear | Pasa el SVG a PNG con Chrome en modo headless (`--screenshot`, tamaño exacto, fondo transparente cuando hace falta) y los copia a `android/` e `ios/`. Se ejecuta a mano; no forma parte del build | RF-3 a RF-8 |

### Android (`android/app/src/main/`)
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `AndroidManifest.xml` | Modificar | `android:label="Rueda Viva"` | RF-1 |
| `res/mipmap-anydpi-v26/ic_launcher.xml` | Crear | `<adaptive-icon>` con `background` (`@color/ic_launcher_background`), `foreground` y `monochrome` | RF-4, RF-5 |
| `res/values/ic_launcher_background.xml` | Crear | Color `#FFF8F3` | RF-4 |
| `res/mipmap-{m,h,xh,xxh,xxxh}dpi/ic_launcher_foreground.png` | Crear | Símbolo a color sobre fondo transparente, 108 dp por densidad (108 a 432 px). La cubierta (r 24) queda dentro de la zona segura (r 33) | RF-4, RF-8 |
| `res/mipmap-{…}dpi/ic_launcher_monochrome.png` | Crear | Símbolo de un solo color con alfa. El contorno y el recorte de la llama van **transparentes** (con una máscara SVG), no en color de fondo: si no, la llama se fundiría con los radios | RF-5 |
| `res/mipmap-{…}dpi/ic_launcher.png` | Sustituir | Icono a color en cuadrado redondeado de 48 dp (48 a 192 px), para Android 7 (API 24 y 25), que no tiene iconos adaptativos | RF-3 |

### iOS (`ios/Runner/`)
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `Info.plist` | Modificar | `CFBundleDisplayName` = "Rueda Viva". `CFBundleName` (`spin_streak`) no se ve y no se toca | RF-1, RF-2 |
| `Assets.xcassets/AppIcon.appiconset/Contents.json` | Rehacer | Formato de tamaño único: una entrada `universal`/`ios` de 1024 × 1024 sin apariencia, otra con `luminosity: dark` y otra con `luminosity: tinted`. Xcode genera los demás tamaños al compilar | RF-6, RF-7 |
| `Assets.xcassets/AppIcon.appiconset/*.png` | Sustituir | `icono-claro.png` e `icono-tintado.png` (1024 px, sin alfa) e `icono-oscuro.png` (1024 px, fondo transparente). Se borran los 15 PNG antiguos | RF-3, RF-6, RF-7 |

### App (`lib/`)
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/ui/core/themes/colores_app.dart` | Modificar | Nuevo color `logoRueda`: `#1F1A17` en claro y `#FFF8F3` en oscuro (con `copyWith` y `lerp`). La llama usa `primary` y el fondo, `surface` | RF-10 |
| `lib/ui/core/ui/simbolo_rueda.dart` | Crear | `SimboloRueda(tamano)`: `CustomPaint` que dibuja el símbolo con la misma geometría que `simbolo.svg`, recortado al cuadrado con radio del 24 %. Colores del tema. En claro, borde de 1 px (`outline` con alfa). Va dentro de `ExcludeSemantics` | RF-9 a RF-11 |
| `lib/ui/home/widgets/home_screen.dart` | Modificar | Título del `AppBar`: `Row(SimboloRueda(32), 10 px, Text.rich('Rueda ' + 'Viva' en textoPrincipal))`, el texto en `Flexible` + `FittedBox(scaleDown)` | RF-9 a RF-11 |
| `lib/main.dart` | Modificar | `title: 'Rueda Viva'` | RF-2 |

### Documentación
| Archivo | Acción | Responsabilidad |
| --- | --- | --- |
| `.claude/rules/design-system-and-theming.md` | Modificar | Añadir `logoRueda` a la lista de `ColoresApp` y `SimboloRueda` a los widgets compartidos; regenerar los iconos con `tool/generar_iconos.sh` |
| `MEMORY.md` | Modificar | Estado de la spec y cómo se generan los iconos |

## 3. Funciones puras en `lib/domain/`
Ninguna: no hay reglas de negocio.

## 4. Interfaz

### 4.1 Geometría del símbolo (lienzo 108 × 108)
```
cubierta: círculo (54, 54), r 24, trazo 6,5, color rueda
radios: para i en 0..6:
  a = (−90 + 360/14 + i · 360/7)°
  línea de (54 + 5·cos a, 54 + 5·sin a) a (54 + 21,5·cos a, 54 + 21,5·sin a), trazo 3,4, extremos redondos
llama (trasladar a (54, 57,5), escalar 0,78):
  1. contorno: llama exterior con relleno y trazo 7 (uniones redondas) del color de fondo
  2. llama exterior rellena del color principal
  3. recorte interior relleno del color de fondo
vista: 14..94 (iOS y barra del inicio: la rueda ocupa unos dos tercios del lado); 0..108 (capas de Android)
```
Las curvas de la llama son los `path` del componente "Icono" del diseño, que en Dart se pasan tal cual a `moveTo`/`cubicTo`. En el monocromo de Android, los pasos 1 y 3 se hacen con una máscara (transparentes).

### 4.2 Variantes que genera el script
| Salida | Vista | Fondo | Rueda | Llama | Tamaños |
| --- | --- | --- | --- | --- | --- |
| iOS claro | 14..94 | `#FFF8F3` | `#1F1A17` | `#FF5A1F` | 1024 |
| iOS oscuro | 14..94 | transparente | `#FFF8F3` | `#FF5A1F` | 1024 |
| iOS tintado | 14..94 | `#000000` | `#B8B8B8` | `#FFFFFF` | 1024 |
| Android primer plano | 0..108 | transparente | `#1F1A17` | `#FF5A1F` | 108 · 162 · 216 · 324 · 432 |
| Android monocromo | 0..108 | transparente | negro con alfa | negro con alfa | 108 · 162 · 216 · 324 · 432 |
| Android antiguo | 14..94, radio 24 % | `#FFF8F3` | `#1F1A17` | `#FF5A1F` | 48 · 72 · 96 · 144 · 192 |

### 4.3 Barra superior del inicio
Sin cambios en el Cubit, el estado, las rutas ni la DI. Solo cambia el `title` del `AppBar`: el símbolo no escala con el texto del sistema (tamaño fijo de 32) y el nombre usa `titleLarge` (22/700, ya en el tema) reducido con `FittedBox` si no cabe.

## 5. Cambios en drift
Ninguno.

## 6. Decisiones técnicas
| Decisión | Por qué | Alternativa descartada |
| --- | --- | --- |
| Generar los PNG con un script propio y Chrome headless (decisión del autor, 2026-10-19) | No añade dependencias (constitución, principio 1), y Chrome ya está en el Mac del autor. Comprobado: da 1024 × 1024 exactos y sin alfa | `flutter_launcher_icons` (dependencia de desarrollo nueva, y aun así hace falta pasar el SVG a PNG). Herramientas como `rsvg-convert` o ImageMagick no están instaladas |
| Capas de Android en PNG, no en `VectorDrawable` (decisión del autor, 2026-10-19) | Un mismo SVG para todo; el monocromo necesita una máscara, que `VectorDrawable` no tiene | `VectorDrawable` a mano: nítido a cualquier tamaño, pero hay que traducir los trazados y no puede vaciar el contorno de la llama |
| Símbolo dentro de la app con `CustomPainter` | Nítido a cualquier tamaño, colores del tema (claro y oscuro sin dos imágenes) y sin dependencias | PNG en `assets/` (dos variantes × tres densidades); `flutter_svg` (dependencia nueva) |
| Color propio `logoRueda` en `ColoresApp` | La rueda oscura del diseño es `#FFF8F3`, no el `onSurface` oscuro (`#F4EDE8`) | Usar `onSurface` (casi igual, pero no es el color del diseño) |
| iOS con icono de tamaño único y tres apariencias | Es el único formato con oscuro y tintado (RF-6, RF-7); Xcode saca el resto de tamaños | Mantener los 15 PNG (sin oscuro ni tintado) |
| Icono oscuro de iOS con fondo transparente | Decisión del autor (2026-10-19): es lo que recomienda Apple, y el sistema pone su degradado oscuro | Fondo `#1C1B1F` opaco, como en el diseño |
| Fuentes del logo en `docs/marca/`, no en `assets/` | Lo que está en `assets/` se mete en la app; el SVG solo sirve para generar los iconos | `assets/marca/` |
| `SpinStreakApp`, `com.juliangg.spin_streak` y el resto de identificadores siguen igual | La spec lo deja fuera (RNF-3) y el autor no quiere renombrar clases (2026-10-19) | Renombrar a `RuedaVivaApp` |

## 7. Verificación
- `dart format .` sin cambios y `flutter analyze` sin avisos.
- Ver los PNG generados (tamaño; sin alfa en los iconos claro y tintado de iOS; con alfa en el oscuro de iOS y en las capas de Android) con `sips` y revisándolos visualmente.
- Simulador de iOS: el nombre "Rueda Viva" y el icono en la pantalla de inicio (captura con `xcrun simctl io booted screenshot`); el inicio de la app en claro y oscuro, comparado con el tablero "Inicio" del diseño. Los modos oscuro y tintado del icono (se cambian a mano en la pantalla de inicio) los comprueba el autor.
- Android (lo comprueba el autor): icono con las formas del launcher, iconos temáticos y nombre.
- RNF-3: instalar encima de la versión anterior y comprobar que las sesiones siguen ahí.
