# Tareas 005 — Diseño visual de las pantallas
Estado: aprobada

Plan: `specs/005-diseno-pantallas/plan.md` (aprobado). En cada tarea: `dart format .` sin cambios y `flutter analyze` sin avisos. Las comprobaciones en el móvil se hacen con `flutter run` y las confirma el autor.

- [x] **T1. Registrar las fuentes.** RNF-3
  - Ya hecho (2026-10-17, a petición del autor): `assets/fonts/` con Figtree 400/500/600/700 y Bricolage Grotesque 600/700 (tamaño óptico 24) y 800 (tamaño óptico 96), generados desde las fuentes variables oficiales de Google Fonts con `fonttools`, y sus licencias OFL.
  - Falta: sección `fonts:` en `pubspec.yaml` (familias `Figtree` y `BricolageGrotesque` con su `weight`) y `LicenseRegistry.addLicense` en `main.dart` con los dos `OFL-*.txt` (declarados en `assets:`).
  - Hecho cuando: `flutter pub get` no da errores, `flutter analyze` sin avisos y las dos licencias aparecen en `showLicensePage` (comprobación temporal, sin dejar código).
  - Estado (2026-10-17): código hecho; `pub get`, `format` y `analyze` correctos, y `flutter build bundle` incluye las 7 fuentes y las 2 licencias. Comprobado en el simulador de iOS (iPhone 18 Pro) con un `debugPrint` temporal, ya borrado: `LicenseRegistry` devuelve las licencias de Figtree y de Bricolage Grotesque, y la app arranca.

- [x] **T2. Tema claro y oscuro.** RF-1, RF-2, RF-5 a RF-8, RNF-2, RNF-4
  - `colores_app.dart` (`ThemeExtension<ColoresApp>`), `dimens.dart` y `app_theme.dart` con `light` y `dark`: `ColorScheme` de la sección 4.1 del plan, `TextTheme` de la 4.2 y temas de componentes de la 4.3. En `main.dart`, `darkTheme` y `themeMode: ThemeMode.system`.
  - Hecho cuando: la app arranca en los dos modos con el fondo, el texto y las fuentes nuevas, y al cambiar el modo del móvil con la app abierta cambia sin reiniciar (RF-8).
  - Comprobado (2026-10-17) en el simulador de iOS: arranca en claro con fondo crema, Figtree y Bricolage; al pasar el simulador a oscuro con la app abierta cambia al instante. Hasta T4–T8 las pantallas mezclan estilos viejos (p. ej. los `OutlinedButton` del inicio en naranja sobre crema, 3,0:1).

- [x] **T3. Widgets compartidos y formato.** RF-13, RF-16, RF-17, RF-19, RF-29
  - `TarjetaAviso`, `EstadoError` y `mostrarAviso` en `ui/core/ui/`; `formatearDecimal` en `formatters.dart` (y `formatearKm` la usa).
  - Hecho cuando: compila y `formatearKm(1234.5)` sigue dando "1.234,5 km" (script temporal).
  - Comprobado (2026-10-17): `formatearKm(1234.5)` → "1.234,5 km" y `formatearDecimal(1234.5)` → "1.234,5". La caja del icono y el borde de `TarjetaAviso` se derivan del color del icono con transparencia (el diseño usa tonos sueltos sin rol en el tema), y el icono de los avisos va en el color del texto.

- [x] **T4. Pantalla de inicio.** RF-3, RF-4, RF-9 a RF-14, RF-16
  - Título, tarjeta de racha, contadores con unidades, "Explorar" con los tres accesos, mensaje del día con `TarjetaAviso`, avisos tras guardar con `mostrarAviso` y error con `EstadoError` (sección 4.4).
  - Hecho cuando: en el móvil, en los dos modos, el inicio coincide con el diseño de referencia; al registrar una sesión sale el aviso (ámbar si bate un récord); con el texto del sistema al máximo los números no se cortan.
  - Estado (2026-10-17): código hecho. Comprobado en el simulador de iOS: inicio en claro y oscuro (estado Bienvenida) y texto al máximo sin errores de desbordamiento; el botón flotante limita su texto a 1,5× porque se salía de la pantalla. **Confirmado por el autor** (2026-10-17): recorrido completo en el simulador de iOS.

- [x] **T5. Formulario de sesión.** RF-19, RF-19b, RF-20 a RF-24
  - "Borrar" como icono, ⓘ fuera del campo, "Guardar" fijo abajo con indicador, avisos de fallo, diálogos y hoja "Tiempo" (sección 4.5).
  - Hecho cuando: en el móvil, en los dos modos: alta con errores, hoja "Tiempo", ayuda ⓘ, diálogo de descartar, y en edición el icono "Borrar" (con su descripción "Borrar" al mantenerlo pulsado) y su diálogo (cancelando).
  - Estado (2026-10-17): código hecho. Comprobado en el simulador de iOS (formulario abierto como pantalla inicial con un cambio temporal, ya deshecho): alta vacía en claro y oscuro, con ⓘ fuera del campo y "Guardar" fijo abajo. **Confirmado por el autor** (2026-10-17): recorrido completo en el simulador de iOS.

- [x] **T6. Historial.** RF-16, RF-17, RF-19, RF-25
  - `TarjetaDia` y `CabeceraDia` sin fondo en `dia_historial_widgets.dart`; avisos de `editarSesion` con icono; historial con `TarjetaDia`, `TarjetaAviso` y `EstadoError` (sección 4.6).
  - Hecho cuando: en el móvil, en los dos modos, el historial coincide con el diseño, y al editar una sesión sale "Sesión actualizada" con su icono.
  - Estado (2026-10-17): código hecho. Comprobado en el simulador de iOS (cambio temporal de `initialRoute`, ya deshecho): historial vacío en claro y oscuro con la tarjeta neutra. **Confirmado por el autor** (2026-10-17): recorrido completo en el simulador de iOS.

- [x] **T7. Calendario.** RF-16, RF-17, RF-26 a RF-28b
  - Aspecto de los días, cabecera del mes e iniciales; `TarjetaDia` para el día seleccionado; aviso sin sesiones con `TarjetaAviso` (encima); error con `EstadoError`. Sin tocar la lógica (sección 4.6).
  - Hecho cuando: en el móvil, en los dos modos: días entrenados en naranja, hoy con borde, seleccionado con anillo, futuros atenuados, "Mes siguiente" deshabilitado en el mes de hoy, y en un mes anterior la pista solo sin día seleccionado.
  - Estado (2026-10-17): código hecho. Comprobado en el simulador de iOS (cambio temporal de `initialRoute`, ya deshecho), sin sesiones y en los dos modos: aviso encima, hoy con borde y anillo, futuros atenuados, "Mes siguiente" deshabilitado y debajo la fecha con "Hoy aún no has entrenado…" (spec 003, RF-13 y RF-16). **Confirmado por el autor** (2026-10-17): recorrido completo en el simulador de iOS.

- [x] **T8. Récords.** RF-16, RF-17, RF-29 a RF-31
  - `_TarjetaRecord` con y sin datos, `TarjetaAviso` y `EstadoError` (sección 4.7).
  - Hecho cuando: en el móvil, en los dos modos, los récords coinciden con el diseño y tocar uno abre su edición.
  - Estado (2026-10-17): código hecho. Comprobado en el simulador de iOS (cambio temporal de `initialRoute`, ya deshecho), con la sesión que registró el autor y en los dos modos: dos récords con valor, fecha y chevron, y dos "Sin datos" sin chevron; iconos en caja ámbar y sin rojo de la racha. **Confirmado por el autor** (2026-10-17): recorrido completo en el simulador de iOS.

- [x] **T9. Regla de tema y verificación final.** RF-4, RNF-1, RNF-2
  - Actualizar `.claude/rules/design-system-and-theming.md`. `grep`: `racha` de `ColoresApp` solo en el inicio; `Color(0x` y `Colors.` solo en `lib/ui/core/themes/`. Revisar en el código los estados vacío y error de las 5 pantallas.
  - Hecho cuando: los `grep` dan lo esperado y el autor confirma el recorrido completo de la sección 8 del plan.
  - Estado (2026-10-17): regla actualizada. `grep` correctos: `ColoresApp.racha`/`rachaContenedor` solo en `home_screen.dart`; `Color(0x` solo en `app_theme.dart` y `colores_app.dart`; ningún `Colors.` ni `fontSize` fuera de `core/themes/`. Revisado en el código: las 4 pantallas con carga usan `EstadoError` sin reintentar y su estado vacío con `TarjetaAviso` (el calendario y los récords, encima del contenido); el formulario muestra los fallos con `mostrarAviso`. **Confirmado por el autor** (2026-10-17): recorrido completo en el simulador de iOS.
