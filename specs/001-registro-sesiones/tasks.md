# Tareas 001 — Registro de sesiones
Estado: aprobada

Spec: `spec.md` (aprobada) · Plan: `plan.md` (aprobado). Una tarea cada vez, en este orden.

Todas las tareas comparten la **puerta**:
- `dart run build_runner build` si cambian tablas, modelos o estados freezed;
- `dart format .` sin cambios;
- `flutter analyze` sin errores ni avisos.

No se crean tests (decisión del autor).

- [x] **T1. Instalar freezed y actualizar la configuración y la documentación (plan 2.0).** —
  - `flutter pub add freezed_annotation dev:freezed`.
  - Excluir `**/*.freezed.dart` en `analysis_options.yaml`.
  - Añadir freezed al stack y a los comandos de `AGENTS.md`.
  - Actualizar `.claude/rules/` (`flutter-clean-architecture.md`, `state-management.md`, `dart-coding-standards.md`) y `.ia/memories/flutter_architecture.memory.json`.
  - Hecho cuando: `pubspec.yaml` incluye `freezed_annotation` y `freezed`; los documentos citados mencionan freezed y su convención; pasa la puerta.

- [x] **T2. Pasar `Streak` y `HomeState` a freezed (refactor sin cambio de comportamiento).** —
  - Mover `Streak` a `lib/domain/models/streak.dart` como `@freezed`, con `Streak.empty`.
  - `streak_calculator.dart` la importa.
  - `HomeState` pasa a `@freezed` y se elimina el `copyWith` manual.
  - Hecho cuando: no quedan `copyWith` ni clases de modelo o estado manuales en `domain/` ni en `ui/home/`; `flutter run` muestra los mismos contadores en el inicio que antes; pasa la puerta.

- [x] **T3. `Session` y `SessionData` con freezed, velocidad máxima entera y migración a `schemaVersion` 2.** — RF-1, RF-2, RF-6, RF-9, RF-14
  - `Session` pasa a `@freezed`, con `dia`, `velocidadMax: int?` y el getter `velocidadMedia`.
  - Nuevo `SessionData` como `@freezed`.
  - Tabla: `velocidadMaxKmh` pasa a `integer().nullable()`, `schemaVersion` sube a 2 y se añade la migración `CAST(ROUND(...) AS INTEGER)`.
  - Repositorio:
    - `addSession(SessionData)` y `updateSession(int id, SessionData)`; este último no escribe `fecha` ni `dia`;
    - `getSessions` ordena por `fecha` desc e `id` desc;
    - `_toDomain` rellena `dia`.
  - Hecho cuando:
    - el código compila con las nuevas firmas;
    - la migración solo actúa si `from < 2` y redondea;
    - instalar sobre la versión anterior conserva las sesiones (32,6 pasa a 33, el resto de datos igual);
    - pasa la puerta.

- [x] **T4. Validación de sesiones en `domain`.** — RF-3, RF-4, RF-6, RF-7, RF-14
  - `@freezed EntradaSesion` en `domain/models/`.
  - En `session_validator.dart`:
    - constantes de rango;
    - enum `CampoSesion`;
    - uniones freezed `ErrorCampo` y `ResultadoValidacion`;
    - `validarSesion(entrada)`, que devuelve todos los errores a la vez.
  - Hecho cuando:
    - revisando el código caso por caso (plan, sección 9) se obtiene el resultado esperado para: vacío, solo espacios, "abc", "-5", "1.234,5", "12,50" y "12,555" en distancia, "30,0" en velocidad, límites inferior y superior, 00:00:00 y 05:00:00;
    - `domain/` solo importa `dart:` y `freezed_annotation`;
    - pasa la puerta.

- [ ] **T5. Agrupado del historial y formatos.** — RF-9, RF-10, RF-11, RC-3
  - `@freezed DiaHistorial` en `domain/models/`.
  - `agruparPorDia(sesiones)` en `domain/session_history.dart`: agrupa por `dia`, ordena por `fecha` desc e `id` desc, y suma distancia, tiempo y calorías.
  - `lib/utils/formatters.dart` con los formatos de la tabla del plan (fecha, hora, `H:mm:ss`, km, km/h y kcal).
  - Hecho cuando:
    - la revisión caso por caso de `agruparPorDia` es correcta para: lista vacía, varias sesiones el mismo día, varios días y desempate por `id`;
    - los formatos producen los ejemplos de la tabla del plan;
    - pasa la puerta.

- [ ] **T6. Selector de tiempo y ayuda ⓘ.** — RF-5, RF-8
  - `TiempoPicker`: hoja inferior con tres `CupertinoPicker` (0–5 h, 0–59 min, 0–59 s) que devuelve un `Duration`. Con 5 h fija los minutos y segundos a 0.
  - `AyudaParametro`: botón ⓘ con un diálogo que muestra el texto del glosario de los seis parámetros.
  - Hecho cuando: los dos widgets compilan y no dependen de ningún Cubit; los textos coinciden con la sección 5 de `docs/ESPECIFICACION.md`; pasa la puerta.

- [ ] **T7. Estado y Cubit del formulario.** — RF-1, RF-3 a RF-7, RF-14, RF-15, RF-16, RC-1
  - `@freezed SessionFormState`: modo, original, entrada, entrada inicial, errores, status y el getter `hayCambios`.
  - `SessionFormCubit`, con estos métodos:
    - `cambiarCampo` y `cambiarTiempo`;
    - `guardar()`: valida, pasa a `guardando`, llama a `addSession` o `updateSession` y termina en `guardada`, `actualizada` o `error`;
    - `borrar()`: llama a `deleteSession` y termina en `borrada` o `error`.
  - Registro en DI con `registerFactoryParam<SessionFormCubit, Session?, void>`.
  - Hecho cuando:
    - revisando el código, todas las ramas de error conservan `entrada` (RC-1);
    - `hayCambios` es falso tras escribir y volver a borrar;
    - el Cubit no importa Flutter ni drift y no calcula reglas;
    - pasa la puerta.

- [ ] **T8. Pantalla del formulario y su ruta.** — RF-2, RF-3, RF-4, RF-5, RF-8, RF-13, RF-15, RF-16
  - `SessionFormScreen`:
    - campos con su teclado y su ⓘ, y errores bajo cada campo;
    - el campo de tiempo abre `TiempoPicker`;
    - en edición: título "Editar sesión", fecha de solo lectura y acción "Borrar", con su diálogo de confirmación;
    - `PopScope` con el diálogo "¿Descartar los cambios?";
    - `BlocListener`: hace `pop(resultado)` en los estados finales y muestra un `SnackBar` si hay error.
  - Ruta `sessionForm` en `route_names.dart` y en `app_router.dart`.
  - Hecho cuando: en `flutter run`, navegando a la ruta a mano, se cumplen los pasos 2 a 5 y 9 del recorrido del plan (sección 9); pasa la puerta.

- [ ] **T9. Historial: estado, Cubit, pantalla, ruta y acceso a la edición.** — RF-9 a RF-13, RC-2
  - `@freezed HistoryState` y `HistoryCubit.cargar()` (`getSessions` → `agruparPorDia`), registrado en DI.
  - `HistoryScreen`:
    - cabeceras con totales y filas con hora, tiempo, distancia, velocidad media y kcal;
    - mensaje de historial vacío y mensaje de error de carga;
    - al tocar una fila, `await pushNamed(sessionForm, arguments: session)`, después `cargar()` y el `SnackBar` "Sesión actualizada" o "Sesión borrada".
  - Ruta `history`.
  - Hecho cuando: en `flutter run` se cumplen los pasos 7, 8, 10 y 11 del recorrido del plan; pasa la puerta.

- [ ] **T10. Navegación desde el inicio y recorrido completo.** — RF-1, RC-3 (navegación de la spec)
  - En `HomeScreen`:
    - `FloatingActionButton.extended` "Registrar sesión" y botón "Historial";
    - `await pushNamed` y después `cargar()`;
    - `SnackBar` "Sesión guardada".
  - Actualizar `MEMORY.md`.
  - Hecho cuando: el autor ejecuta en Android los 12 pasos del recorrido del plan (sección 9) y confirma el resultado; pasa la puerta.
