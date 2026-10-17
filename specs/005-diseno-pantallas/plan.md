# Plan 005 — Diseño visual de las pantallas
Estado: aprobada

Spec: `specs/005-diseno-pantallas/spec.md` (aprobada). Respeta `docs/constitution.md` y las capas de `AGENTS.md`. **Sin dependencias nuevas**, **sin cambios en las tablas de drift** y **sin cambios en `domain` ni `data`**: es un cambio solo de `ui` (más `utils/formatters.dart` y `main.dart`). Los únicos archivos nuevos que no son código son las fuentes (sección 5), que necesitan la aprobación del autor.

## 1. Qué ya existe en el código

| Pieza | Estado | RF |
| --- | --- | --- |
| `AppTheme.light` con `ColorScheme.fromSeed(Colors.deepOrange)`; sin tema oscuro | **Se rehace**: colores exactos, tema oscuro, tipografía y estilos de componentes | RF-1 a RF-8, RNF-2 |
| `MaterialApp` solo con `theme` | **Falta** `darkTheme` y `themeMode: ThemeMode.system` | RF-6 a RF-8 |
| Inicio: fecha, `_TarjetaMensaje` (colores de `secondary`/`primary`/`errorContainer`), tres `_StatTile` en lista, tres `OutlinedButton` y FAB | **Se rehace el aspecto**; mismos datos, textos y navegación | RF-3, RF-9 a RF-14 |
| Aviso tras guardar (`SnackBar` de texto) en inicio y `editarSesion` | **Cambia el aspecto**: icono y, con récord, fondo ámbar | RF-13, RF-19 |
| Formulario: `TextField` con `suffixIcon` ⓘ dentro del campo, "Borrar" como `TextButton.icon`, "Guardar" al final de la lista | **Cambia**: ⓘ fuera del campo, "Borrar" solo icono, "Guardar" fijo abajo | RF-19b a RF-24 |
| Historial y calendario: `CabeceraDia` con fondo gris y `FilaSesion` sueltas | **Cambia**: cabecera sin fondo y sesiones dentro de una tarjeta | RF-25, RF-28 |
| Calendario: círculo `primary`, borde de hoy `tertiary`, anillo `secondary` con sombra, aviso sin sesiones con `secondaryContainer` | **Cambia el aspecto**; mismo comportamiento de la spec 003 (aviso encima, pista solo sin selección) | RF-26 a RF-28b |
| Récords: `Card` + `ListTile` con el valor a la derecha | **Se rehace** la tarjeta: icono ámbar, valor grande, fecha y chevron | RF-29 a RF-31 |
| Errores de carga: texto centrado sin icono en las 5 pantallas | **Cambia**: icono de error en un círculo + mensaje | RF-16 |
| Formatos `formatearEntero`, `formatearKm`, `formatearTiempo`… | Existen. **Falta** el número sin unidad para el valor de los récords ("42,5" y "km" por separado) | RF-29 |

## 2. Archivos y responsabilidades

### Tema (`lib/ui/core/themes/`)
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `app_theme.dart` | Rehacer | `AppTheme.light` y `AppTheme.dark`: `ColorScheme` completo con los hex de la spec, `TextTheme` (sección 4.2) y temas de componentes (sección 4.3) | RF-1, RF-2, RF-5 a RF-7, RNF-2 |
| `colores_app.dart` | Crear | `ThemeExtension<ColoresApp>` con los colores que no tiene `ColorScheme`: `racha`, `rachaContenedor`, `textoPrincipal` (`#C2410C`/`#FF5A1F`), `botonTexto`, `avisoRecord`/`onAvisoRecord`. Con `copyWith` y `lerp` (no es un modelo: no lleva freezed) | RF-3, RF-4, RF-13, RF-24, RF-26 |
| `dimens.dart` | Crear | Constantes repetidas: márgenes (16), radios (12, 16, 20, 28), tamaños (círculo del día 40, caja de icono 40) | RNF-2, RNF-4 |

### Arranque y utilidades
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/main.dart` | Modificar | `darkTheme: AppTheme.dark`, `themeMode: ThemeMode.system` | RF-6 a RF-8 |
| `lib/utils/formatters.dart` | Modificar | `formatearDecimal(double)` → "42,5" (hasta 2 decimales); `formatearKm` pasa a usarla. Mismo resultado que ahora | RF-29 |
| `pubspec.yaml` + `assets/fonts/` | Modificar / crear | Sección `fonts:` con Figtree (400, 500, 600, 700) y Bricolage Grotesque (600, 700, 800) en TTF estáticos, y sus licencias OFL | RNF-3 |

### Widgets compartidos (`lib/ui/core/ui/`)
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `tarjeta_aviso.dart` | Crear | `TarjetaAviso(icono, texto, fondo, colorIcono, ...)`: tarjeta con caja de icono de 40 px y texto. La usan el mensaje del día y los estados vacíos | RF-11, RF-17 |
| `estado_error.dart` | Crear | `EstadoError(texto)`: icono de error en un círculo `errorContainer` y el mensaje, centrados. Sin botón | RF-16 |
| `aviso.dart` | Crear | `mostrarAviso(messenger, texto, icono, {record = false})`: `SnackBar` flotante con icono; con `record`, fondo ámbar | RF-13, RF-19 |
| `dia_historial_widgets.dart` | Modificar | `CabeceraDia` sin fondo; nueva `TarjetaDia(dia, onTapSesion)` = cabecera + tarjeta con las `FilaSesion` separadas por líneas de 1 px | RF-25, RF-28 |
| `editar_sesion.dart` | Modificar | "Sesión actualizada" / "Sesión borrada" con `mostrarAviso` (check / papelera) | RF-19 |

### Pantallas
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/ui/home/widgets/home_screen.dart` | Modificar | Título con "Streak" en `textoPrincipal`; `_TarjetaRacha`; fila con dos `_Contador`; "Explorar" y fila de tres `_Acceso`; mensaje del día con `TarjetaAviso`; avisos con `mostrarAviso`; error con `EstadoError` | RF-3, RF-9 a RF-14, RF-16 |
| `lib/ui/session_form/widgets/session_form_screen.dart` | Modificar | "Borrar" como `IconButton` (tooltip "Borrar"); ⓘ a la derecha del campo; "Guardar" fijo abajo con indicador; errores al guardar o borrar con `mostrarAviso`; botones destructivos de los diálogos en color de error | RF-19 a RF-22, RF-24 |
| `lib/ui/session_form/widgets/tiempo_picker.dart` | Modificar | Banda del valor elegido, títulos y botones según el diseño | RF-23 |
| `lib/ui/session_form/widgets/ayuda_parametro.dart` | Modificar | Solo estilos del diálogo (lo demás sale del tema) | RF-24 |
| `lib/ui/history/widgets/history_screen.dart` | Modificar | Lista de `TarjetaDia`; vacío con `TarjetaAviso`; error con `EstadoError` | RF-16, RF-17, RF-25 |
| `lib/ui/calendar/widgets/calendar_screen.dart` | Modificar | Aspecto de `_Celda`, cabecera del mes e iniciales; día seleccionado con `TarjetaDia`; aviso sin sesiones con `TarjetaAviso` (sigue **encima**); error con `EstadoError`. Sin tocar la lógica de selección ni la pista | RF-16, RF-17, RF-26 a RF-28b |
| `lib/ui/records/widgets/records_screen.dart` | Modificar | `_TarjetaRecord` nueva (con y sin datos); vacío con `TarjetaAviso`; error con `EstadoError` | RF-16, RF-17, RF-29 a RF-31 |

### Documentación
| Archivo | Acción | Responsabilidad |
| --- | --- | --- |
| `.claude/rules/design-system-and-theming.md` | Modificar | Hoy dice "un único tema claro" y "modo oscuro: no existe". Pasa a describir `AppTheme.light`/`dark`, `ColoresApp`, `dimens.dart` y las fuentes |

## 3. Funciones puras en `lib/domain/`
Ninguna. La spec no añade reglas de negocio: cambia el aspecto. Las únicas funciones nuevas son de formato (`formatearDecimal`) y de presentación.

## 4. Interfaz

### 4.1 Colores (RF-1 a RF-7)
`ColorScheme` escrito a mano para cada modo, con los valores de la tabla "Colores por modo" de la spec:

| Rol de `ColorScheme` | Claro | Oscuro |
| --- | --- | --- |
| `primary` / `onPrimary` | `#FF5A1F` / `#1F1A17` | igual |
| `primaryContainer` / `onPrimaryContainer` | `#FFE3D6` / `#8F3209` | `#3A2A24` / `#FFB59A` |
| `secondary` / `onSecondary` | `#FFB020` / `#1F1A17` | igual |
| `secondaryContainer` / `onSecondaryContainer` | `#FFE9C2` / `#6B4A00` | `#45330F` / `#FFB020` |
| `surface` / `onSurface` / `onSurfaceVariant` | `#FFF8F3` / `#1F1A17` / `#6B5C53` | `#1C1B1F` / `#F4EDE8` / `#CBBFB7` |
| `surfaceContainerLowest` (tarjetas) | `#FFFFFF` | `#2A2629` |
| `surfaceContainerHigh` (avisos neutros) | `#F5E9E1` | `#2A2629` |
| `surfaceContainerHighest` (diálogos, hoja) | `#FFFFFF` | `#322D31` |
| `outline` / `outlineVariant` | `#8C7A6F` / `#F1E1D6` | `#9A8C84` / `#3A3437` |
| `error` / `errorContainer` | `#8E244D` / `#FFD9E3` | `#FFB1C8` / `#5C1A33` |
| `inverseSurface` / `onInverseSurface` | `#362F2B` / `#FBEEE8` | `#EDE0D8` / `#1F1A17` |
| `scrim` | `#1F1A17` | `#000000` |

`ColoresApp` (extensión): `racha` `#E53935` (los dos modos), `rachaContenedor` `#FDE7E5`/`#3B2224`, `textoPrincipal` `#C2410C`/`#FF5A1F`, `botonTexto` `#A63A0B`/`#FFB59A`, `avisoRecord` `#FFB020` con `onAvisoRecord` `#1F1A17`. Los widgets la leen con `Theme.of(context).extension<ColoresApp>()!` (siempre está registrada en los dos temas).

**RF-4:** `racha` solo se lee en `_TarjetaRacha` y en el contador de mejor racha del inicio. Se comprueba con `grep` (sección 7).

### 4.2 Tipografía (sección "Tipografía" de la spec)
`fontFamily: 'Figtree'` por defecto, y los estilos con Bricolage Grotesque declarados con `fontFamily: 'BricolageGrotesque'`. Cifras de ancho fijo (`FontFeature.tabularFigures()`) en los estilos de números.

| Estilo | Fuente · tamaño/alto · peso | Uso |
| --- | --- | --- |
| `displayLarge` | Bricolage 80/84 · 800 | Número de la racha actual |
| `headlineMedium` | Bricolage 32/40 · 700 | Contadores |
| `headlineSmall` | Bricolage 28/34 · 700 | Valor de un récord |
| `titleLarge` | Bricolage 22/28 · 700 | Título de la barra, diálogos y hoja |
| `titleMedium` | Bricolage 18/24 · 700 | Mes del calendario |
| `titleSmall` | Figtree 15/20 · 700 | Cabecera de día |
| `bodyLarge` | Figtree 16/24 · 400 | Valor de un campo; "Racha actual" (peso 700) |
| `bodyMedium` | Figtree 15/22 · 500 | Mensaje del día, línea principal de una sesión |
| `bodySmall` | Figtree 13/18 · 500 | Etiquetas, unidades, totales, línea secundaria |
| `labelLarge` | Figtree 14/20 · 600 | Botones, fecha (peso 500), "Explorar", días del calendario |
| `labelSmall` | Figtree 12/16 · 600 | Etiqueta y error de un campo, iniciales L–D (peso 700) |

En los widgets solo se cambia el peso o el color con `copyWith`, nunca el tamaño (regla de tema).

### 4.3 Temas de componentes (`AppTheme`)
- `appBarTheme`: sin elevación, fondo `surface`, título `titleLarge` a la izquierda, alto 64.
- `cardTheme`: `surfaceContainerLowest`, borde 1 px `outlineVariant`, radio 20, sin elevación ni margen.
- `inputDecorationTheme`: borde 1 px `outline` y radio 12; con error, 2 px `error`; etiqueta `labelSmall`.
- `filledButtonTheme` y `floatingActionButtonTheme`: `primary` con texto `onPrimary`, alto 56, radio 16, texto 16/700.
- `textButtonTheme`: `botonTexto`, radio 22, alto mínimo 44 (RNF-4).
- `dialogTheme` y `bottomSheetTheme`: `surfaceContainerHighest`, radio 28 (hoja: solo arriba), con asa en `outline`.
- `snackBarTheme`: flotante, radio 12, `inverseSurface` / `onInverseSurface`.
- `progressIndicatorTheme`: `textoPrincipal`.

### 4.4 Inicio (RF-9 a RF-14)
```text
AppBar(title: Text.rich("Spin" + "Streak" en textoPrincipal))
ListView(padding 16, inferior 96):
  fecha (labelLarge, onSurfaceVariant)
  TarjetaAviso del mensaje del día:
    Bienvenida → waving_hand_rounded, surfaceContainerHigh
    ASalvo     → check_circle_rounded, primaryContainer (texto peso 600)
    Riesgo     → warning_amber_rounded, secondaryContainer + borde (texto peso 600)
    Reiniciada → restart_alt_rounded, surfaceContainerHigh + borde
    (mismos textos que ahora: spec 002)
  _TarjetaRacha: círculo 56 rachaContenedor con local_fire_department_rounded (racha),
                 número displayLarge (racha) en FittedBox, "Racha actual", unidad "día seguido"/"días seguidos"
  Row(_Contador "Mejor racha" con llama y número en racha, _Contador "Días entrenados" con event_available_rounded)
      número headlineMedium en FittedBox + unidad "día"/"días"
  "Explorar" (labelLarge, onSurfaceVariant)
  Row de 3 _Acceso (alto 76, radio 18, primaryContainer, icono en botonTexto): Historial, Calendario, Récords
FAB extendido "Registrar sesión" (add_rounded)
```
- Unidades: función privada `_unidad(n, singular, plural)` (presentación, como `_textoGuardada`).
- RF-13: si hay récords batidos, `mostrarAviso(..., icono: emoji_events_rounded, record: true)`; si no, `check_circle_rounded`.
- RF-14: los números van en `FittedBox(fit: BoxFit.scaleDown)`.

### 4.5 Formulario (RF-19b a RF-24)
- Barra: `IconButton(icon: delete_outline_rounded, tooltip: 'Borrar')` solo en edición (el tooltip da la descripción accesible).
- Cada campo en un `Row(Expanded(campo), AyudaParametro)`: el ⓘ sale del `suffixIcon` y se queda a la derecha (44 px de ancho). La nota lleva un hueco del mismo ancho para alinearse.
- "Guardar" en `bottomNavigationBar` (fijo, con línea superior `outlineVariant` y padding 16); mientras `guardando`, un `CircularProgressIndicator` de 20 px junto al texto y el botón desactivado.
- Diálogos de borrar y descartar: el botón destructivo con `foregroundColor: error`.
- Fallos al guardar o borrar: `mostrarAviso` con `error_outline_rounded`.
- `tiempo_picker.dart`: título `titleLarge`, cabeceras "h"/"min"/"s" encima de cada rueda, banda `primaryContainer` de radio 14 detrás de la fila elegida, "Cancelar" (texto) y "Aceptar" (`FilledButton`).

### 4.6 Historial y calendario (RF-25 a RF-28b)
- `TarjetaDia`: `CabeceraDia` (fecha `titleSmall`, totales `bodySmall`) con padding lateral 4 y, debajo, `Card` con las filas separadas por `Divider` de 1 px. `FilaSesion`: hora (`labelLarge`, `onSurfaceVariant`, 44 px), dos líneas y `chevron_right_rounded`. Entre días, 20 px.
- `_Celda`: entrenado → círculo `primary` y número `onPrimary` peso 700; hoy → borde interior 2 px `onSurface`; seleccionado → anillo de 2,5 px `textoPrincipal` separado 2 px, sin sombra (mismo tamaño total para que no se mueva la cuadrícula); futuro → número `onSurfaceVariant` al 45 %.
- `_CabeceraMes`: mes en `titleMedium`; "Mes siguiente" deshabilitado en el mes de hoy (ya existe, RF-27).
- **RF-28b:** el orden de la lista no cambia (aviso sin sesiones encima, cuadrícula, y debajo `TarjetaDia`, el mensaje de hoy sin sesiones o la pista). Solo cambian los estilos.

### 4.7 Récords (RF-29 a RF-31)
`_TarjetaRecord` en una `Card`: caja 40 px `secondaryContainer` con el icono en `onSecondaryContainer` (`timer_outlined`, `route_rounded`, `speed_rounded`, `monitor_heart_outlined`), nombre (`bodySmall`), valor (`headlineSmall`) + unidad (`bodySmall`), fecha (`bodySmall`) y chevron. Sin datos: icono, nombre y "Sin datos"; sin `onTap` ni chevron. El valor y la unidad salen de `formatearTiempo` (sin unidad), `formatearDecimal` + "km", `formatearEntero` + "km/h" y `formatearEntero` + "ppm".

### 4.8 Rutas, navegación y DI
Sin cambios.

## 5. Fuentes (necesita aprobación del autor)
- Archivos: `assets/fonts/Figtree-{Regular,Medium,SemiBold,Bold}.ttf`, `assets/fonts/BricolageGrotesque-{SemiBold,Bold,ExtraBold}.ttf` y `assets/fonts/OFL-Figtree.txt`, `assets/fonts/OFL-BricolageGrotesque.txt`. Unos 100 KB por archivo.
- Origen: la descarga oficial de Google Fonts (licencia SIL Open Font License 1.1, que permite incluirlas en la app). Se descargan **una vez** durante la implementación; la app no se conecta a internet.
- Si la descarga de Bricolage Grotesque solo trae la fuente variable, se generan los tres pesos estáticos con `fonttools varLib.instancer` (herramienta externa, no es dependencia del proyecto).
- Las licencias se registran con `LicenseRegistry.addLicense` en `main.dart` para que aparezcan en la página de licencias de Flutter.

## 6. Cambios en drift
Ninguno. `schemaVersion` sigue en 2.

## 7. Decisiones técnicas

| Decisión | Alternativa descartada | Por qué |
| --- | --- | --- |
| `ColorScheme` escrito a mano con los hex de la spec | `ColorScheme.fromSeed(#FF5A1F)` | `fromSeed` recalcula los tonos y no da los colores exactos ni los contrastes verificados en la spec |
| Colores sin rol en Material (`racha`, `textoPrincipal`, `botonTexto`, `avisoRecord`) en una `ThemeExtension` | Constantes `Color` sueltas o reutilizar `tertiary` para la racha | La extensión cambia con el modo claro/oscuro y deja un único sitio para la paleta (RNF-2). Usar `tertiary` para la racha haría que Material la aplicara en otros componentes (RF-4) |
| Fuentes TTF estáticas en `assets/` | Paquete `google_fonts` | `google_fonts` es una dependencia nueva y por defecto descarga las fuentes por HTTP (constitución, RNF-3) |
| TTF estáticos por peso | Fuente variable con `FontVariation` | Con estáticos, `FontWeight` funciona sin código extra en cada estilo |
| Widgets compartidos `TarjetaAviso`, `EstadoError`, `TarjetaDia` y `mostrarAviso` en `ui/core/ui/` | Copiar el estilo en cada pantalla | Aparecen en 3 a 5 pantallas; un único sitio evita que se desajusten |
| `ThemeMode.system` | Selector de tema en la app | La spec lo deja fuera de alcance; `MaterialApp` aplica el cambio de modo sin reiniciar (RF-8) |
| `TarjetaDia` en el calendario sin cambiar el orden de la lista | Tomar la disposición del diseño de referencia | RF-28b: manda la spec 003 |

## 8. Verificación
Sin tests (decisión del autor):
- `dart format .` sin cambios y `flutter analyze` sin avisos en cada tarea.
- **RF-4 y RNF-2:** `grep` de `racha` de `ColoresApp` (solo en el inicio) y de `Color(0x` / `Colors.` (solo en `lib/ui/core/themes/`).
- **RNF-1:** los pares de colores ya se verificaron al cerrar la spec. Si al implementar aparece un par nuevo, se mide con un script temporal.
- **Recorrido manual** en el móvil (`flutter run`), en modo claro y oscuro, comparando con el diseño de referencia:
  1. Inicio en sus estados (los que se puedan dar con los datos reales) y el cambio de modo del móvil con la app abierta (RF-8).
  2. Registrar una sesión: avisos normal y de récord; formulario con errores, hoja "Tiempo", ayuda ⓘ y diálogo de descartar.
  3. Editar desde el historial: icono "Borrar", diálogo de borrar (cancelar) y aviso "Sesión actualizada".
  4. Calendario: días entrenados, hoy, seleccionado, futuro, mes anterior y pista.
  5. Récords.
  6. Texto del sistema ampliado al máximo: los números del inicio no se cortan (RF-14).
- Estados vacío y error: revisando el código (no se fuerzan con los datos reales del autor).
