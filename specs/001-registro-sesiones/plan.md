# Plan 001 — Registro de sesiones
Estado: aprobada

Spec: `specs/001-registro-sesiones/spec.md` (aprobada). Respeta `docs/constitution.md` y las capas de `AGENTS.md` (`ui` → `domain` → `data`).

> **Dependencia nueva, decisión del autor (2026-10-13):** `freezed` para **todos los modelos de dominio y todos los estados de los Cubits**. Requiere actualizar el principio 1 de la constitución antes de implementar (sección 2.0).

## 1. Qué ya existe en el código

| Pieza | Estado | RF |
| --- | --- | --- |
| Tabla `Sessions` (drift, `schemaVersion` 1) con `fecha`, `dia`, tiempo en segundos, distancia, calorías, odómetro, velocidad máxima (`real`), pulso y nota | Existe. **Falta**: velocidad máxima como entero | RF-1, RF-6 |
| `SessionRepository.addSession` asigna `fecha` y `dia` con el reloj inyectable | Existe. Se cambia la firma | RF-1, RF-2 |
| `SessionRepository.updateSession` no toca `fecha` ni `dia` | Existe. Se cambia la firma | RF-14 |
| `SessionRepository.deleteSession` | Existe, sin cambios | RF-15 |
| `SessionRepository.getSessions` (más reciente primero) | Existe. Falta desempate y `dia` en el modelo | RF-9 |
| Modelo `Session` con `velocidadMedia` derivada | Existe. Falta `dia`; `velocidadMax` es `double?` | RF-11 |
| `Result<T>`, DI con get_it, router con rutas nombradas, pantalla de inicio con `HomeCubit.cargar()` | Existe | — |
| `freezed` | **No se usa.** `Session`, `Streak` (dentro de `streak_calculator.dart`) y `HomeState` son clases manuales, y `HomeState` tiene un `copyWith` escrito a mano | — |
| Formulario, selector de tiempo, validación, ayuda ⓘ, historial, navegación desde el inicio | **No existe** | RF-3 a RF-16 |

## 2. Archivos y responsabilidades

### 2.0 Dependencias, configuración y documentación (freezed)
| Archivo | Acción | Responsabilidad |
| --- | --- | --- |
| `pubspec.yaml` | Modificar | `flutter pub add freezed_annotation dev:freezed` (resuelve `freezed_annotation` ^3.1.0 y `freezed` ^4.0.2; `build_runner` ya está) |
| `analysis_options.yaml` | Modificar | Excluir `**/*.freezed.dart` del análisis (igual que `**/*.g.dart`) |
| `docs/constitution.md` | Modificar | Principio 1: añadir `freezed` al stack. **Cambiar la constitución requiere tu aprobación explícita** |
| `AGENTS.md` | Modificar | Stack: añadir `freezed` (modelos y estados inmutables). Comandos: `build_runner` también tras cambiar un modelo o estado |
| `.claude/rules/flutter-clean-architecture.md` | Modificar | `domain` solo importa `dart:` **y `freezed_annotation`** |
| `.claude/rules/state-management.md`, `dart-coding-standards.md` | Modificar | Estados y modelos con `@freezed`; nada de `copyWith`, `==` ni `hashCode` escritos a mano |
| `.ia/memories/flutter_architecture.memory.json` | Modificar | Registrar la decisión |

**Convención freezed** (freezed 3+):
- Clase de datos: `@freezed abstract class X with _$X { const factory X({...}) = _X; }` y `part 'x.freezed.dart';`.
- Si la clase tiene getters o métodos: `const X._();`.
- Uniones: `@freezed sealed class X with _$X` con un `factory` por caso, consumidas con `switch` y patrones (sin `when` ni `map`).
- Los campos de colección (`List`, `Map`) quedan no modificables y se comparan por contenido.
- Los enums (`HomeStatus`, `CampoSesion`, …) siguen siendo enums.

### domain (lógica pura, sin Flutter ni drift; solo `freezed_annotation` como paquete)
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/domain/models/session.dart` | Modificar | Pasa a `@freezed`. `velocidadMax` pasa a `int?`; nuevo campo `dia` (fecha sin hora, el mismo de la racha); `velocidadMedia` como getter (`const Session._()`) | RF-6, RF-9, RF-11 |
| `lib/domain/models/session_data.dart` | Crear | `@freezed SessionData`: valores ya validados de una sesión (sin `id` ni `fecha`). Es lo que reciben `addSession` y `updateSession` | RF-1, RF-14 |
| `lib/domain/models/entrada_sesion.dart` | Crear | `@freezed EntradaSesion`: `Duration tiempo` y los textos del formulario. Su igualdad por valor permite saber si hay cambios (RF-16) | RF-3 a RF-7, RF-16 |
| `lib/domain/models/dia_historial.dart` | Crear | `@freezed DiaHistorial`: día, sesiones y totales | RF-9, RF-10 |
| `lib/domain/models/streak.dart` | Crear (se mueve) | `Streak` sale de `streak_calculator.dart` y pasa a `@freezed`, con `Streak.empty`. Es un refactor sin cambio de comportamiento | — |
| `lib/domain/streak_calculator.dart` | Modificar | Importa `Streak` desde `models/`. La lógica no cambia | — |
| `lib/domain/session_validator.dart` | Crear | Rangos de la spec como constantes, `CampoSesion` (enum), uniones `@freezed sealed ErrorCampo` y `ResultadoValidacion`, y `validarSesion(entrada)` | RF-3, RF-4, RF-6, RF-7, RF-14 |
| `lib/domain/session_history.dart` | Crear | `agruparPorDia(sesiones)` → `List<DiaHistorial>` | RF-9, RF-10 |

### data
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/data/services/database/app_database.dart` | Modificar | `velocidadMaxKmh` → `integer().nullable()`; `schemaVersion` 2 y migración (sección 5) | RF-6 |
| `lib/data/repositories/session_repository.dart` | Modificar | `addSession(SessionData)`, `updateSession(int id, SessionData)`; `getSessions` ordena por `fecha` desc y `id` desc; `_toDomain` rellena `dia` | RF-1, RF-2, RF-9, RF-14 |

### ui
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/utils/formatters.dart` | Crear | Formatos en español con `intl`: fecha de cabecera, hora (24 h), tiempo `H:mm:ss`, km (hasta 2 decimales), km/h (1 decimal), kcal | RC-3, RF-10, RF-11 |
| `lib/ui/home/view_model/home_state.dart` | Modificar | Pasa a `@freezed`; se elimina el `copyWith` manual. Es un refactor sin cambio de comportamiento | — |
| `lib/ui/session_form/view_model/session_form_state.dart` | Crear | `@freezed SessionFormState`, el estado inmutable del formulario, con el getter `hayCambios` | RF-3 a RF-7, RF-16 |
| `lib/ui/session_form/view_model/session_form_cubit.dart` | Crear | `cambiarCampo`, `cambiarTiempo`, `guardar`, `borrar`; llama a `validarSesion` y al repositorio | RF-1, RF-3 a RF-7, RF-14, RF-15, RC-1 |
| `lib/ui/session_form/widgets/session_form_screen.dart` | Crear | Formulario de registro y edición, fecha de solo lectura en edición, botón "Borrar", diálogos de borrar y de descartar | RF-2, RF-5, RF-8, RF-13, RF-15, RF-16 |
| `lib/ui/session_form/widgets/tiempo_picker.dart` | Crear | Selector propio de horas, minutos y segundos (máx. 05:00:00) en una hoja inferior | RF-5 |
| `lib/ui/session_form/widgets/ayuda_parametro.dart` | Crear | Botón ⓘ y diálogo con el texto del glosario (sección 5 de `docs/ESPECIFICACION.md`) | RF-8 |
| `lib/ui/history/view_model/history_state.dart` | Crear | `@freezed HistoryState`: `status` (`loading`, `ready`, `error`) y lista de `DiaHistorial` | RF-9 a RF-12 |
| `lib/ui/history/view_model/history_cubit.dart` | Crear | `cargar()`: `getSessions()` → `agruparPorDia` | RF-9, RF-10 |
| `lib/ui/history/widgets/history_screen.dart` | Crear | Lista agrupada, cabeceras con totales, mensaje si está vacío, abre la edición | RF-9 a RF-13 |
| `lib/ui/home/widgets/home_screen.dart` | Modificar | Botón flotante "Registrar sesión", botón "Historial", mensajes tras volver y `cargar()` | Navegación |
| `lib/routing/route_names.dart` y `app_router.dart` | Modificar | Rutas `sessionForm` (argumento opcional `Session`) e `history` | Navegación |
| `lib/config/dependencies.dart` | Modificar | `registerFactoryParam<SessionFormCubit, Session?, void>` y `registerFactory<HistoryCubit>` | — |

## 3. Funciones puras en `lib/domain/`

Ninguna de estas funciones depende de "hoy": la fecha la pone el repositorio con su reloj (RF-1) y la validación no mira la fecha. Por eso no reciben ese parámetro.

### `validarSesion(EntradaSesion entrada) → ResultadoValidacion` — RF-3, RF-4, RF-6, RF-7, RF-14
- `EntradaSesion` (freezed): `Duration tiempo` y textos tal cual los escribe el usuario (`distancia`, `calorias`, `odometro`, `velocidadMax`, `pulsoMax`, `nota`).
- `ResultadoValidacion`: unión freezed `sealed`, con `ResultadoValidacion.valida(SessionData)` o `ResultadoValidacion.invalida(Map<CampoSesion, ErrorCampo>)`.
- `ErrorCampo`: unión freezed `sealed`, con `falta`, `noNumerico`, `fueraDeRango(min, max)` y `demasiadosDecimales(max)`. El texto en español lo compone la UI con `switch` (RC-3).
- Devuelve **todos** los errores a la vez, no solo el primero.

```text
para cada campo numérico (distancia, calorías, odómetro, velocidadMax, pulsoMax):
  texto ← recortar espacios
  si texto vacío:
    si campo obligatorio → error Falta
    si opcional → valor null (RF-6)
    continuar
  si texto no cumple ^\d+([.,]\d+)?$ → error NoNumerico      // RF-7: coma o punto; sin signos, sin miles
  decimales ← nº de dígitos tras el separador (0 si no hay)
  si decimales > máximo del campo → error DemasiadosDecimales  // "12,50" en distancia: válido (2 ≤ 2)
  valor ← parsear sustituyendo ',' por '.'
  si valor fuera de [min, max] (distancia y velocidad: min exclusivo/≥1) → error FueraDeRango
tiempo: si tiempo < 1 s o > 5 h → FueraDeRango(0:00:01, 5:00:00)   // incluye 00:00:00
nota: recortar; vacía → null
si hay errores → Invalida(errores) si no → Valida(SessionData(...))
```

Rangos (constantes en el mismo archivo): tiempo 1 s–5 h; distancia (0, 200] con 2 decimales; calorías 0–5.000 enteras; odómetro 0–999.999 con 2 decimales; velocidad máxima 1–100 entera; pulso 40–240 entero. Los límites son válidos.

### `agruparPorDia(List<Session> sesiones) → List<DiaHistorial>` — RF-9, RF-10
```
ordenar sesiones por fecha desc, id desc
recorrer y agrupar consecutivas con el mismo `dia`
por grupo: distanciaTotal = Σ distancia; tiempoTotal = Σ tiempo; caloriasTotal = Σ calorías; numSesiones
devolver grupos en orden de `dia` desc
```
Agrupa por `dia` (el día local guardado al registrar), igual que la racha, y no recalcula la fecha desde `fecha`. Así un cambio de hora o de zona horaria no mueve una sesión de grupo.

## 4. Interfaz

### Formulario (`SessionFormScreen` + `SessionFormCubit`)
- **Estado** (`@freezed`): `modo` (nuevo o edición), `original` (`Session?`), `entrada` (`EntradaSesion`), `entradaInicial`, `errores` (`Map<CampoSesion, ErrorCampo>`) y `status` (`editando`, `guardando`, `guardada`, `actualizada`, `borrada`, `error`). Getter `hayCambios` = `entrada != entradaInicial` (requiere `const SessionFormState._()`). La igualdad generada por freezed compara por valor: escribir y volver a borrar no cuenta como cambio. Los cambios de estado usan el `copyWith` generado.
- **Campos**:
  - tiempo: campo de solo lectura que abre `TiempoPicker` (RF-5);
  - distancia y odómetro: teclado numérico con decimales;
  - calorías, velocidad máxima y pulso: teclado numérico sin decimales;
  - nota: texto libre, varias líneas.

  Cada campo muestra su error bajo él (RF-3, RF-4). Los seis parámetros del glosario llevan ⓘ (RF-8); la nota no.
- **Edición**: título "Editar sesión", línea de solo lectura "Registrada el sábado, 10 de octubre de 2026 a las 18:30" (RF-2) y acción "Borrar" en la barra superior. El formulario nuevo no muestra la fecha: la asigna la app al guardar.
- **`guardar()`**:
  - `validarSesion` → si es `Invalida`, emite los errores y no guarda;
  - si es `Valida`, emite `guardando` (el botón queda desactivado, para evitar el doble toque) → `addSession` o `updateSession`;
  - `Ok` → `guardada` o `actualizada`;
  - `Error` → `error` con los datos intactos y el mensaje "No se pudo guardar la sesión. Inténtalo de nuevo." (RC-1).
- Guardar una edición sin cambios guarda igualmente y devuelve "Sesión actualizada".
- **`borrar()`**:
  - antes de llamarlo, la pantalla muestra el diálogo "¿Borrar esta sesión? No se puede deshacer." (RF-15);
  - si se confirma, `deleteSession` → `borrada`, o `error` con el mensaje de RC-1;
  - borrar descarta los cambios sin guardar sin preguntar de nuevo.
- **Atrás (RF-16)**:
  - `PopScope(canPop: !hayCambios || status es final)`;
  - si hay cambios, diálogo "¿Descartar los cambios?" (Seguir editando / Descartar).
- **Efectos (`BlocListener`)**:
  - con `guardada`, `actualizada` o `borrada` → `Navigator.pop(context, resultado)`;
  - con `error` → `SnackBar` con el mensaje.

### Selector de tiempo (`TiempoPicker`) — RF-5
- Widget propio: hoja inferior con tres columnas `CupertinoPicker` (horas 0–5, minutos 0–59, segundos 0–59), "Cancelar" y "Aceptar". Devuelve un `Duration`.
- Si las horas son 5, minutos y segundos se fijan a 0, así que no se puede pasar de 05:00:00.

### Historial (`HistoryScreen` + `HistoryCubit`) — RF-9 a RF-13
- Cabecera de cada día, por ejemplo "sábado, 10 de octubre de 2026 · 2 sesiones · 25,4 km · 1:05:20 · 610 kcal". "N sesiones" solo aparece si hay más de una (RF-10).
- Fila de cada sesión: hora, tiempo, distancia, velocidad media con un decimal redondeado y calorías (RF-11).
- Al tocar una fila se abre el formulario de edición con esa sesión como argumento (RF-13).
- Sin sesiones: "Aún no hay sesiones. Registra la primera con «Registrar sesión» en el inicio." (RF-12, RC-2).
- Error de carga: "No se pudo cargar el historial".

### Navegación
- **Inicio**: `FloatingActionButton.extended` "Registrar sesión" → `await pushNamed(sessionForm)`. Botón "Historial" (`OutlinedButton.icon`) bajo los contadores → `await pushNamed(history)`.
- Al volver de cualquiera de las dos, el inicio llama a `cargar()`. Si el resultado es `guardada`, muestra el mensaje "Sesión guardada".
- **Historial**: `await pushNamed(sessionForm, arguments: session)`. Al volver llama a `cargar()` y, según el resultado, muestra "Sesión actualizada" o "Sesión borrada".
- **Router**:
  - `sessionForm` → `BlocProvider(create: getIt<SessionFormCubit>(param1: settings.arguments as Session?))`;
  - `history` → `BlocProvider(create: getIt<HistoryCubit>()..cargar())`.

### Formatos (`lib/utils/formatters.dart`) — RC-3
| Dato | Formato | Ejemplo |
| --- | --- | --- |
| Fecha de la cabecera | `DateFormat.yMMMMEEEEd()` | sábado, 10 de octubre de 2026 |
| Hora | `DateFormat.Hm()` | 18:30 |
| Tiempo | `H:mm:ss`, sin límite de horas en los totales | 1:05:20 |
| Distancia | `#,##0.##` km | 1.234,5 km |
| Velocidad media | `#,##0.0` km/h | 23,4 km/h |
| Calorías | `#,##0` kcal | 610 kcal |

## 5. Cambios en drift

- `velocidadMaxKmh`: `real().nullable()` → `integer().nullable()` (RF-6, tabla de rangos de la spec).
- `schemaVersion`: 1 → **2**.
- Migración que conserva los datos (constitución, principio 4):

```
migration = MigrationStrategy(
  onUpgrade: (m, from, to):
    si from < 2:
      m.alterTable(TableMigration(sessions,
        columnTransformer: {
          sessions.velocidadMaxKmh: CAST(ROUND(velocidad_max_kmh) AS INTEGER)   // 32,6 → 33; NULL se queda NULL
        }))
)
```

- Se redondea, no se trunca: `CAST` solo trunca, y 32,9 pasaría a 32.
- Después: `dart run build_runner build`.

## 6. Decisiones técnicas

| Decisión | Alternativa descartada | Por qué |
| --- | --- | --- |
| **Tiempo como `Duration`** en dominio y base de datos (segundos), con un selector propio. **Decisión del autor a confirmar**: pediste `DateTime` | `DateTime` | Un `DateTime` es un instante: obliga a inventar una fecha, le afectan los cambios de hora y las horas vuelven a 0 al llegar a 24 (los totales del día pueden pasar de 24 h). `Duration` representa justo "cuánto duró" y ya es el tipo del modelo y de la tabla |
| Selector propio con `CupertinoPicker` (incluido en Flutter, sin dependencias) | `CupertinoTimerPicker` o `showTimePicker` | `CupertinoTimerPicker` deja elegir hasta 23:59:59, y RF-5 exige no pasar de 05:00:00. `showTimePicker` elige una hora del día y no tiene segundos |
| Validación sobre texto en `domain` (`validarSesion`) | `validator:` de los `TextFormField` o filtros de teclado | La constitución (principio 3) y las reglas exigen las validaciones en `domain`. El formulario solo pinta errores |
| Coma o punto como separador decimal y **sin separador de miles** al escribir. "1.234" son 1,234 km; "1.234,5" es `NoNumerico` | Aceptar separador de miles | RF-7 manda aceptar el punto como decimal; aceptar también miles haría ambiguo "1.234". En pantalla se muestran los miles (RC-3) |
| Todos los errores a la vez | Solo el primero | Permite corregir en un solo intento (objetivo de 30 s) |
| Agrupar por la columna `dia` (nuevo campo `dia` en `Session`) | Calcular el día desde `fecha` | Mismo criterio que la racha; inmune a cambios de hora o zona |
| `SessionData` como entrada de `addSession` y `updateSession` | Mantener parámetros con nombre y `Session` completo | El validador produce `SessionData`; `updateSession` deja de recibir una `fecha` que no debe usar (RF-2) |
| Resultado de la pantalla con `Navigator.pop(context, resultado)` y mensaje en la pantalla que recibe | Mensaje en el formulario antes de salir | El `SnackBar` debe verse en la pantalla de destino (inicio o historial) |
| Migración manual `if (from < 2)` | `stepByStep` con `make-migrations` | Sin tests, la ventaja principal de `make-migrations` (generar tests de migración) no se aprovecha. Con un solo paso basta |
| **`freezed` en todos los modelos y estados. Decisión del autor** | Clases manuales con `==`, `hashCode` y `copyWith` escritos a mano | Igualdad por valor fiable (necesaria para `hayCambios` y para que `BlocBuilder` no repinte sin motivo), `copyWith` generado, colecciones no modificables y uniones `sealed` para `ErrorCampo` y `ResultadoValidacion`. Coste: código generado y un paso más de `build_runner` |
| Estados como clase de datos freezed con un enum `status` | Estados como unión freezed (`loading`, `ready`, `error`…) | El formulario debe conservar `entrada` en todos los estados (RC-1), y una unión obligaría a copiarla en cada caso. Además, `HomeState` ya sigue el patrón del enum (reglas de estado) |
| `Streak` se mueve a `domain/models/` al convertirla a freezed | Dejarla en `streak_calculator.dart` | La estructura del proyecto pone los modelos en `domain/models/`. Es un refactor sin cambio de comportamiento (constitución, principio 2) |
| Sin más dependencias que `freezed` | `json_serializable` | No hay JSON (datos solo en drift) |
| **Traducciones de Flutter en español (añadido en la validación, 2026-10-13; aprobado por el autor):** `flutter_localizations` (incluido en el SDK de Flutter) y, en `MaterialApp`, `localizationsDelegates` (Material, Widgets, Cupertino), `supportedLocales: [Locale('es')]` y `locale: Locale('es')` | Solo `intl` | Con solo `intl`, los textos propios de Flutter (menú Cortar/Copiar/Pegar, tooltip "Back") salen en inglés, y RC-3 exige todos los textos en español. Se detectó en la validación |

## 7. Casos límite y su tratamiento

- Varias sesiones el mismo día → un grupo con totales sumados (`agruparPorDia`).
- Tiempo 00:00:00 → `FueraDeRango` (RF-4). Los límites exactos son válidos.
- Borrar la única sesión de un día → solo la confirmación de RF-15 (riesgo aceptado).
- Borrar la última sesión → el historial recarga y muestra el mensaje de RF-12.
- Fallo al guardar, editar o borrar → status `error`, `SnackBar` y datos conservados (RC-1).
- Guardar alrededor de medianoche → la sesión cuenta para el día en que se pulsa "Guardar" (RF-1).
- Dos sesiones con la misma `fecha` → desempate por `id` descendente.
- La app se cierra con el formulario a medias → los datos no guardados se pierden. La spec no lo cubre (RF-16 solo cubre "Atrás").

## 8. Cobertura

| Requisito | Dónde se cumple |
| --- | --- |
| RF-1 | `SessionRepository.addSession` (reloj inyectable) |
| RF-2 | `updateSession` no escribe `fecha` ni `dia`; formulario sin selector de fecha; línea de solo lectura en edición |
| RF-3, RF-4 | `validarSesion` + errores bajo cada campo |
| RF-5 | `TiempoPicker` |
| RF-6 | `validarSesion` (opcionales vacíos → null) |
| RF-7 | `validarSesion` (regex con `[.,]`) |
| RF-8 | `AyudaParametro` |
| RF-9, RF-10 | `agruparPorDia` + `HistoryScreen` |
| RF-11 | `Session.velocidadMedia` + `formatters` + fila del historial |
| RF-12 | Estado vacío de `HistoryScreen` |
| RF-13 | Acceso a la edición desde cualquier fila del historial |
| RF-14 | `SessionFormCubit.guardar` en modo edición (mismo `validarSesion`) + `updateSession` |
| RF-15 | Diálogo de confirmación + `deleteSession` |
| RF-16 | `PopScope` + `hayCambios` |
| RC-1 | Status `error` del formulario sin perder la entrada |
| RC-2 | RF-12 |
| RC-3 | `formatters.dart` (intl `es`), textos en español y `flutter_localizations` con `locale: es` en `main.dart` (T11) |

## 9. Verificación (sin tests, por decisión del autor)

- **Puerta** (principio 6): tras cada tarea, `dart format .` sin cambios y `flutter analyze` sin avisos. Tras cambiar la tabla, **un modelo o un estado freezed**, `dart run build_runner build`.
- **Refactor a freezed** (`Session`, `Streak`, `HomeState`): la app arranca y el inicio muestra los mismos contadores que antes del cambio.
- **Revisión de código de `domain`, caso por caso**:
  - `validarSesion`: vacío, solo espacios, "abc", "-5", "1.234,5", "12,50" y "12,555" en distancia, "30,0" en velocidad, límites inferior y superior, 00:00:00 y 05:00:00;
  - `agruparPorDia`: lista vacía, un día con varias sesiones, varios días y desempate por `id`.
- **Migración**:
  1. instalar la versión actual (commit `efd378e`, `schemaVersion` 1);
  2. registrar una sesión con velocidad máxima 32,6 (añadida a mano, por ejemplo con un `addSession` temporal, o desde la base de datos);
  3. instalar la nueva versión encima sin desinstalar;
  4. comprobar que la sesión sigue ahí con velocidad 33 y el resto de datos igual.
- **Recorrido manual en Android** (`flutter run`), que el autor ejecuta y confirma:
  1. En el inicio, "Registrar sesión" abre el formulario vacío, sin fecha.
  2. Guardar vacío → errores en tiempo, distancia, calorías y odómetro a la vez (RF-3).
  3. Distancia "250", calorías "10,5" y odómetro "1.234,5" → errores de rango, decimales y formato (RF-4).
  4. Tiempo: en el selector, al poner 5 horas, minutos y segundos quedan en 0 (RF-5).
  5. ⓘ de cada parámetro → texto del glosario (RF-8).
  6. Guardar una sesión válida con distancia "12.5" sin velocidad ni pulso → vuelve al inicio con "Sesión guardada" y la racha actualizada (RF-1, RF-6, RF-7).
  7. Registrar una segunda sesión → en el historial, un solo día con "2 sesiones" y los totales correctos; filas con hora, tiempo, distancia, velocidad media y kcal (RF-9 a RF-11).
  8. Tocar una sesión → "Editar sesión" con la fecha de solo lectura; cambiar la distancia y guardar → "Sesión actualizada", misma fecha (RF-2, RF-13, RF-14).
  9. Editar, cambiar un campo y pulsar atrás → "¿Descartar los cambios?" (RF-16). Escribir y volver a borrar lo escrito → sale sin preguntar.
  10. Borrar, cancelar → la sesión sigue. Borrar y confirmar → "Sesión borrada" (RF-15).
  11. Borrar todas → mensaje de historial vacío (RF-12).
  12. Fechas y números con coma decimal y en español (RC-3).
- **Fallo de guardado (RC-1)**: se revisa en el código que todas las ramas `Error` del Cubit conservan `entrada`. No es fácil provocarlo en un dispositivo real.
