# Tareas 003 — Calendario de días entrenados
Estado: aprobada

Spec: `spec.md` (aprobada) · Plan: `plan.md` (aprobado). Una tarea cada vez, en este orden.

Todas las tareas comparten la **puerta**:
- `dart run build_runner build` si cambian clases freezed;
- `dart format .` sin cambios;
- `flutter analyze` sin errores ni avisos.

No se crean tests (decisión del autor). No hay cambios en drift ni dependencias nuevas.

- [x] **T1. Cuadrícula del mes en `domain` y formato del mes.** — RF-1, RF-3 a RF-6, RC-3
  - `MesCalendario` y `CeldaDia` (freezed) en `lib/domain/models/mes_calendario.dart`.
  - `construirMes(mes, diasEntrenados, hoy)` y `mismoDia(a, b)` en `lib/domain/calendar_month.dart`, según el pseudocódigo del plan (sección 3).
  - `formatearMes(DateTime)` en `lib/utils/formatters.dart`.
  - Hecho cuando:
    - un script temporal fuera del repositorio da el resultado esperado en los 4 meses del plan (sección 9):
      - octubre de 2026 con 3 huecos y 31 días;
      - junio de 2026 sin huecos iniciales;
      - febrero de 2028 con 29 días;
      - marzo de 2026 con huecos finales;
    - en todos, `esHoy` solo en hoy, `esFuturo` desde mañana, ningún día futuro entrenado aunque esté en el conjunto, y `puedeAvanzar` falso en el mes de hoy y verdadero en los anteriores;
    - `formatearMes` da "octubre de 2026";
    - `domain/` solo importa `dart:` y `freezed_annotation`;
    - pasa la puerta.

- [x] **T2. Refactor del historial: piezas compartidas en `ui/core/ui/`.** — RF-7, RF-11, RF-12 (preparación)
  - Mover `_CabeceraDia` y `_FilaSesion` a `lib/ui/core/ui/dia_historial_widgets.dart` como `CabeceraDia` y `FilaSesion` públicos, sin cambios.
  - Sacar `_abrirEdicion` a `editarSesion(context, sesion)` en `lib/ui/core/ui/editar_sesion.dart`: abre el formulario, muestra "Sesión actualizada" o "Sesión borrada" y devuelve el resultado.
  - `HistoryScreen` usa las piezas compartidas y recarga igual que antes.
  - Hecho cuando:
    - en el móvil, el historial se ve igual y editar y borrar una sesión funciona igual que antes, con los mismos mensajes (paso 11 del recorrido);
    - pasa la puerta.

- [x] **T3. Estado y Cubit del calendario, con su ruta y DI.** — RF-1 a RF-3, RF-7, RF-8, RF-10, RF-12, RF-14
  - `CalendarState` (freezed) con `status`, `hoy`, `mesVisible`, `dias`, `mes` y `seleccionado`, y los getters `sinSesiones` y `diaSeleccionado`.
  - `CalendarCubit` con reloj inyectable: `cargar()`, `mesAnterior()`, `mesSiguiente()` y `seleccionarDia(dia)`, según el plan (sección 4).
  - `RouteNames.calendar` (`/calendar`), su caso en `AppRouter` con `BlocProvider(getIt<CalendarCubit>()..cargar())` y `registerFactory<CalendarCubit>`.
  - Hecho cuando:
    - revisando el código:
      - "hoy" sale solo del reloj inyectado;
      - la cuadrícula, los días futuros y el límite de meses salen de `construirMes`;
      - cambiar de mes quita la selección;
      - `cargar()` mantiene la selección solo si el día sigue teniendo sesiones;
      - `seleccionarDia` ignora los días no entrenados y los futuros;
    - la app compila;
    - pasa la puerta.

- [x] **T4. Pantalla del calendario: mes y cuadrícula, y botón en el inicio.** — RF-1 a RF-6, RF-8, RF-9, RF-13, RF-14, RC-2, RC-3, navegación
  - `CalendarScreen`:
    - cabecera con ‹, `formatearMes` y › (desactivada si `!puedeAvanzar`);
    - iniciales L M X J V S D;
    - cuadrícula con los estilos del plan (sección 4) y celdas de al menos 40 × 40 px;
    - tarjeta de RF-13 encima si no hay sesiones;
    - texto "Toca un día marcado para ver sus sesiones." debajo;
    - mensaje de error de RF-14.
  - Botón "Calendario" (`OutlinedButton.icon`, icono `calendar_month`) debajo de "Historial" en el inicio, que recarga el inicio al volver.
  - Hecho cuando:
    - en el móvil, con tus datos actuales, se cumplen los pasos 1 (o su equivalente con datos: días entrenados marcados y hoy con borde), 3, 6, 9 y 10 del recorrido del plan;
    - no hay ningún `DateTime.now()` en `lib/ui/`;
    - pasa la puerta.

- [x] **T5. Sesiones del día seleccionado y edición desde el calendario.** — RF-7, RF-9, RF-11, RF-12
  - Debajo de la cuadrícula, con día seleccionado: `CabeceraDia` y una `FilaSesion` por sesión.
  - Tocar una sesión llama a `editarSesion` y después a `cargar()`.
  - El día seleccionado se resalta con el borde grueso en `secondary` y sombra.
  - Hecho cuando:
    - en el móvil, con tus datos actuales, pulsar un día entrenado lo resalta y muestra sus sesiones con el mismo formato que el historial;
    - editar una sesión desde ahí muestra "Sesión actualizada" y el día sigue seleccionado con los totales nuevos;
    - pasa la puerta.

- [x] **T6. Hoy seleccionado al abrir y siempre pulsable (cambio del 2026-10-15).** — RF-7, RF-8, RF-10, RF-12, RF-13, RF-15, RF-16
  - Según el plan (secciones 3, 4 y 10):
    - `CeldaDia.seleccionable` (`const CeldaDia._()`) y `diaASeleccionar(previo, diasEntrenados, mesVisible, hoy)` en `domain`;
    - `CalendarCubit`: `cargar`, `mesAnterior` y `mesSiguiente` usan `diaASeleccionar`; `seleccionarDia` usa `seleccionable`;
    - `CalendarScreen`: `onTap` en las celdas seleccionables y, con hoy seleccionado sin sesiones, cabecera con la fecha de hoy (mismo aspecto que `CabeceraDia`) y el mensaje "Hoy aún no has entrenado. Registra una sesión con «Registrar sesión» en el inicio."
  - Hecho cuando:
    - un script temporal fuera del repositorio da el resultado esperado en los 7 casos del plan (sección 9);
    - `domain/` solo importa `dart:` y `freezed_annotation`;
    - en el móvil, con tus datos actuales:
      - al abrir el calendario, hoy está seleccionado (con sus sesiones o con su fecha y el mensaje);
      - tras pulsar otro día entrenado, pulsar hoy lo vuelve a seleccionar;
      - en otro mes no hay selección y sale "Toca un día marcado…";
      - al volver al mes de hoy, hoy vuelve a estar seleccionado;
    - pasa la puerta.

- [x] **T7. Recorrido completo con base de datos de prueba.** — RF-1 a RF-16, RC-2, RC-3
  - **Con tu permiso:**
    1. Copiar tu base de datos al PC.
    2. Preparar con `node:sqlite` una base de datos de prueba sin sesiones hoy, con 2 sesiones hace 3 días, una ayer y 3 días del mes anterior (si es el día 1 a 3 del mes, ajustar las fechas para que "hace 3 días" y "ayer" queden en el mes de hoy).
    3. Cargarla en el móvil (solo `adb` para copiar archivos).
    4. Al terminar, restaurar tu base de datos original y comprobar que es idéntica a la copia.
  - Actualizar `MEMORY.md`.
  - Hecho cuando:
    - ejecutas los pasos 2 a 12 del recorrido del plan y confirmas el resultado esperado;
    - el paso 1 (sin sesiones) también se cumple, con la base de datos de prueba vacía o tras borrar todas sus sesiones;
    - la base de datos original se ha restaurado;
    - pasa la puerta.
