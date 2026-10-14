# Tareas 002 — Rachas
Estado: aprobada

Spec: `spec.md` (aprobada) · Plan: `plan.md` (aprobado). Una tarea cada vez, en este orden.

Todas las tareas comparten la **puerta**:
- `dart run build_runner build` si cambian clases freezed;
- `dart format .` sin cambios;
- `flutter analyze` sin errores ni avisos.

No se crean tests (decisión del autor). No hay cambios en drift.

- [x] **T1. Lógica del mensaje del día en `domain`.** — RF-2 a RF-5, RF-7, RF-8 a RF-12
  - `Streak` con el nuevo campo `trainedToday`; `Streak.empty` con `trainedToday: false`.
  - `calculateStreak` rellena `trainedToday` (último día == hoy) con el mismo `_dayNumber`.
  - Unión `@freezed sealed MensajeDia` (`bienvenida`, `aSalvo`, `riesgo(dias)`, `reiniciada(mejorRacha)`) en `domain/models/mensaje_dia.dart`.
  - `mensajeDelDia(Streak)` en `domain/streak_message.dart`.
  - `formatearDias(int)` en `lib/utils/formatters.dart`.
  - Hecho cuando:
    - un script temporal fuera del repositorio da el resultado esperado en todos los casos del plan (sección 9):
      - `calculateStreak`: sin días, solo hoy, solo ayer, ayer y hoy, hueco de un día, varias sesiones el mismo día, mejor racha anterior y cambio de hora, con `trainedToday` correcto;
      - `mensajeDelDia`: los 4 casos, con un único mensaje;
      - `formatearDias`: 1, 2 y 1.000;
    - `domain/` solo importa `dart:` y `freezed_annotation`;
    - pasa la puerta.

- [x] **T2. Estado y Cubit del inicio.** — RF-1, RF-6, RF-8 a RF-11, RF-13
  - `HomeState` con los nuevos campos `hoy` (`DateTime?`) y `mensaje` (`MensajeDia?`).
  - `HomeCubit.cargar()`: `hoy = _now()`, `streak = calculateStreak(días, hoy)`, `mensaje = mensajeDelDia(streak)`.
  - Hecho cuando: revisando el código, "hoy" sale solo del reloj inyectado, el Cubit no calcula reglas (solo llama a `domain`) y la rama de error sigue mostrando el error; la app compila y el inicio muestra los mismos contadores que antes; pasa la puerta.
  - Nota (2026-10-13): pasa la puerta y la APK compila. El móvil no estaba conectado, así que la comprobación visual de los contadores se hace en T3, cuyo "Hecho cuando" ya revisa en el móvil los contadores a 0 y a 1. La pantalla no cambió en esta tarea.

- [x] **T3. Pantalla de inicio: mensaje del día, fecha y recálculo al volver a la app.** — RF-1, RF-8 a RF-13, RC-2, RC-3
  - `HomeScreen` pasa a `StatefulWidget` con `AppLifecycleListener(onResume: cargar)`, creado en `initState` y liberado en `dispose`.
  - Fecha desde `state.hoy` con `formatearFecha`, sin `DateTime.now()` en el widget.
  - Tarjeta del mensaje del día entre la fecha y los contadores, con los textos del plan (sección 4) y colores del tema (`errorContainer` para riesgo, `primaryContainer` para a salvo).
  - Hecho cuando: en el móvil se cumplen los pasos 1, 2 y 9 del recorrido del plan (base de datos vacía: bienvenida encima de los contadores a 0; tras registrar, "¡Racha a salvo!"); no queda ningún `DateTime.now()` en `lib/ui/`; pasa la puerta.

- [x] **T4. Recorrido completo con bases de datos de prueba.** — RF-3, RF-4, RF-5, RF-6, RF-9, RF-11, RF-12, RF-13
  - **Con tu permiso:**
    1. Copiar tu base de datos al PC.
    2. Preparar con `node:sqlite` las bases de datos de prueba de los pasos 3, 4 y 5 del plan:
       - ayer y anteayer;
       - solo ayer;
       - 5 días seguidos que acaban hace 3 días.
    3. Cargarlas en el móvil una a una (solo `adb` para copiar archivos).
    4. Al terminar, restaurar tu base de datos original y comprobar que es idéntica a la copia.
  - Actualizar `MEMORY.md`.
  - Hecho cuando:
    - el autor ejecuta los pasos 3 a 8 del recorrido del plan y confirma el resultado esperado (riesgo, singular "1 día", reiniciada con la mejor racha, vuelta a "a salvo" al registrar, vuelta a riesgo al borrar la sesión de hoy, y recálculo al volver a la app tras cambiar la fecha del móvil);
    - la base de datos original se ha restaurado;
    - pasa la puerta.
