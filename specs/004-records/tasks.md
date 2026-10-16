# Tareas 004 — Récords personales
Estado: aprobada

Spec: `spec.md` (aprobada) · Plan: `plan.md` (aprobado). Una tarea cada vez, en este orden.

Todas las tareas comparten la **puerta**:
- `dart run build_runner build` si cambian clases freezed;
- `dart format .` sin cambios;
- `flutter analyze` sin errores ni avisos.

No se crean tests (decisión del autor). No hay cambios en drift ni dependencias nuevas.

- [x] **T1. Cálculo de récords en `domain` y formatos nuevos.** — RF-1 a RF-6, RF-10, RF-11, RC-3
  - `TipoRecord` y `RecordPersonal` (freezed) en `lib/domain/models/record_personal.dart`.
  - `calcularRecords(sesiones)` y `recordsBatidos(anteriores, nueva)` en `lib/domain/records_calculator.dart`, según el pseudocódigo del plan (sección 3).
  - `formatearVelocidadMax(int)` y `formatearPulso(int)` en `lib/utils/formatters.dart`.
  - Hecho cuando:
    - un script temporal fuera del repositorio da el resultado esperado en los 10 casos del plan (sección 9);
    - `formatearVelocidadMax(32)` da "32 km/h" y `formatearPulso(160)`, "160 ppm";
    - `domain/` solo importa `dart:` y `freezed_annotation`;
    - pasa la puerta.

- [x] **T2. El formulario se cierra con `ResultadoFormulario`.** — RF-9, RF-10 (preparación)
  - `@freezed ResultadoFormulario(status, recordsBatidos)` en `session_form_state.dart`, y el campo `recordsBatidos` en `SessionFormState` (vacío por ahora).
  - El formulario se cierra con `ResultadoFormulario`; la ruta pasa a `MaterialPageRoute<ResultadoFormulario>`.
  - `editarSesion` y el inicio leen `.status`. `editarSesion` sigue devolviendo `SessionFormStatus?`.
  - Sin cambio de comportamiento.
  - Hecho cuando:
    - en el móvil, con tus datos actuales, editar una sesión desde el historial y desde el calendario sigue mostrando "Sesión actualizada", y volver con "Atrás" no muestra nada;
    - pasa la puerta.

- [x] **T3. Aviso de récord al registrar.** — RF-10, RF-11, RF-12, RC-1
  - `SessionFormCubit.guardar()`, solo en modo nuevo:
    - lee las sesiones anteriores;
    - guarda;
    - rellena `recordsBatidos` con `recordsBatidos(...)`;
    - si falla la lectura, guarda igual y no avisa.
  - En modo edición no calcula nada.
  - El inicio muestra "Sesión guardada" o "Sesión guardada. ¡Nuevo récord de …!" / "¡Nuevos récords de …, … y …!", con los nombres y el orden del plan (sección 4.3).
  - Hecho cuando:
    - revisando el código:
      - el cálculo solo ocurre al registrar;
      - si falla la lectura previa, se guarda sin aviso;
      - la rama de error del guardado no cambia (RC-1);
      - el mensaje se compone con ", " e " y " en el orden de `TipoRecord`;
    - la app compila;
    - la comprobación en el móvil se hace en T6 (pasos 2, 4, 5 y 7), para no registrar sesiones en tus datos reales;
    - pasa la puerta.

- [x] **T4. Estado y Cubit de récords, con su ruta y DI.** — RF-1 a RF-7
  - `RecordsState` (freezed: `status`, `records`, `sinSesiones`) y `RecordsCubit.cargar()` (`getSessions` → `calcularRecords`).
  - `RouteNames.records` (`/records`), su caso en `AppRouter` con `BlocProvider(getIt<RecordsCubit>()..cargar())` y `registerFactory<RecordsCubit>`.
  - `RecordsScreen` provisional (solo la barra "Récords"), que se completa en T5.
  - Hecho cuando:
    - revisando el código, el Cubit no calcula reglas (solo llama a `calcularRecords`) y la rama de error emite `error`;
    - la app compila;
    - pasa la puerta.

- [x] **T5. Pantalla de récords y botón en el inicio.** — RF-1 a RF-4, RF-7 a RF-9, RC-2, RC-3, navegación
  - `RecordsScreen`:
    - los 4 récords en `Card` + `ListTile` (nombre, fecha o "Sin datos", y el valor con su formato);
    - el aviso "Aún no hay récords…" encima si no hay sesiones;
    - el mensaje de error de RF-7;
    - `onTap` solo en los récords con sesión → `editarSesion` y después `cargar()`.
  - Botón "Récords" (`OutlinedButton.icon`, icono `emoji_events`) debajo de "Calendario", con `_abrir(RouteNames.records)`.
  - Hecho cuando:
    - en el móvil, con tus datos actuales:
      - Inicio → "Récords" muestra tus récords (o "Sin datos" en los opcionales que no tengas) con su fecha y su formato;
      - tocar un récord con valor abre "Editar sesión" y volver con "Atrás" no cambia nada;
      - "Atrás" vuelve al inicio;
    - pasa la puerta.

- [x] **T6. Recorrido completo con base de datos de prueba.** — RF-1 a RF-12, RC-1 a RC-3
  - **Con tu permiso:**
    1. Copiar tu base de datos al PC.
    2. Preparar con `node:sqlite` una base de datos vacía y otra con las 3 sesiones del plan (sección 9): hace 5 días, hace 4 y hace 2.
    3. Cargarlas en el móvil (solo `adb` para copiar archivos).
    4. Al terminar, restaurar tu base de datos original y comprobar que es idéntica a la copia.
  - Actualizar `MEMORY.md`.
  - Hecho cuando:
    - ejecutas los pasos 1 a 11 del recorrido del plan y confirmas el resultado esperado;
    - la base de datos original se ha restaurado;
    - pasa la puerta.
