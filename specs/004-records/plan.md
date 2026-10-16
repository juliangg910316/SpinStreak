# Plan 004 — Récords personales
Estado: aprobada

Spec: `specs/004-records/spec.md` (aprobada). Respeta `docs/constitution.md` y las capas de `AGENTS.md` (`ui` → `domain` → `data`). **Sin dependencias nuevas** y **sin cambios en las tablas de drift**.

## 1. Qué ya existe en el código

| Pieza | Estado | RF |
| --- | --- | --- |
| `SessionRepository.getSessions()`: todas las sesiones con `fecha`, `tiempo`, `distancia`, `velocidadMax?` y `pulsoMax?` | Existe, sin cambios | RF-1 a RF-7, RF-10 |
| `editarSesion(context, sesion)` en `ui/core/ui/` (spec 003): abre "Editar sesión", muestra "Sesión actualizada" o "Sesión borrada" y devuelve el resultado | Existe. **Cambia** el tipo del resultado (sección 4.4) | RF-8, RF-9 |
| `SessionFormCubit.guardar()`: valida, llama a `addSession` y termina con `guardada` | Existe. **Falta** calcular los récords batidos al registrar | RF-10 a RF-12 |
| El inicio muestra "Sesión guardada" al volver del formulario, y tiene los botones "Historial" y "Calendario" con `_abrir(ruta)`, que recarga al volver | Existe. **Falta** el aviso de récord y el botón "Récords" | RF-10, RF-11, navegación |
| Formatos `formatearTiempo`, `formatearKm` y `formatearFecha` | Existen. **Faltan** "32 km/h" (entero, sin decimales) y "160 ppm" | RNF de formato |
| Cálculo de récords, pantalla, Cubit, ruta y DI | **No existen** | RF-1 a RF-9 |

## 2. Archivos y responsabilidades

### domain
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/domain/models/record_personal.dart` | Crear | `enum TipoRecord { tiempo, distancia, velocidadMax, pulsoMax }` (el orden de la spec) y `@freezed RecordPersonal(tipo, sesion: Session?)`. `sesion == null` es "Sin datos" | RF-1 a RF-3, RF-8 |
| `lib/domain/records_calculator.dart` | Crear | Funciones puras `calcularRecords(sesiones)` y `recordsBatidos(anteriores, nueva)` | RF-1 a RF-6, RF-10, RF-11 |

### ui y utils
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/utils/formatters.dart` | Modificar | `formatearVelocidadMax(int)` → "32 km/h" y `formatearPulso(int)` → "160 ppm" | RNF, RC-3 |
| `lib/ui/session_form/view_model/session_form_state.dart` | Modificar | Campo `recordsBatidos: List<TipoRecord>` y nuevo `@freezed ResultadoFormulario(status, recordsBatidos)`, el valor con el que se cierra el formulario | RF-10 a RF-12 |
| `lib/ui/session_form/view_model/session_form_cubit.dart` | Modificar | Al **registrar**, lee las sesiones anteriores, guarda y rellena `recordsBatidos` con `recordsBatidos(...)`. Al editar, no | RF-10 a RF-12 |
| `lib/ui/session_form/widgets/session_form_screen.dart` | Modificar | Se cierra con `ResultadoFormulario` en lugar de `SessionFormStatus` | RF-10 |
| `lib/routing/app_router.dart` y `route_names.dart` | Modificar | La ruta del formulario pasa a `MaterialPageRoute<ResultadoFormulario>`. Nueva ruta `records` (`/records`) con `BlocProvider(getIt<RecordsCubit>()..cargar())` | RF-10, navegación |
| `lib/ui/core/ui/editar_sesion.dart` | Modificar | Lee el `status` de `ResultadoFormulario`. Mismos mensajes y mismo comportamiento | RF-9 |
| `lib/ui/home/widgets/home_screen.dart` | Modificar | Mensaje al volver de registrar: "Sesión guardada" o el aviso de récord. Botón "Récords" debajo de "Calendario" | RF-10, RF-11, navegación |
| `lib/ui/records/view_model/records_state.dart` | Crear | `@freezed RecordsState` | RF-1 a RF-7 |
| `lib/ui/records/view_model/records_cubit.dart` | Crear | `cargar()`: `getSessions` → `calcularRecords` | RF-1 a RF-7 |
| `lib/ui/records/widgets/records_screen.dart` | Crear | Los 4 récords, el aviso sin sesiones, el error y tocar un récord para editar su sesión | RF-1 a RF-9 |
| `lib/config/dependencies.dart` | Modificar | `registerFactory<RecordsCubit>` | — |

## 3. Funciones puras en `lib/domain/` (`records_calculator.dart`)

Los récords **no dependen de "hoy"**: solo comparan sesiones ya guardadas. Por eso estas funciones no reciben la fecha; la constitución pide "hoy" como parámetro solo a las reglas que dependen del día.

### Valor de cada récord
```text
valor(tipo, tiempo, distancia, velocidadMax?, pulsoMax?) → num?
  tiempo        → tiempo en segundos
  distancia     → distancia
  velocidadMax  → velocidadMax (puede ser null)
  pulsoMax      → pulsoMax (puede ser null)
```
Se usa con `Session` y con `SessionData` (la sesión nueva, que aún no tiene `id` ni `fecha`).

### `calcularRecords(sesiones) → List<RecordPersonal>` — RF-1 a RF-6
```text
para cada tipo en TipoRecord.values (en orden):
  candidatas ← sesiones con valor(tipo) ≠ null
  si no hay → RecordPersonal(tipo, sesion: null)              // "Sin datos" (RF-3, RF-4)
  mejor ← la de mayor valor; en un empate, la de menor fecha y, si coincide, la de menor id   // RF-6
  RecordPersonal(tipo, sesion: mejor)
```
- Varias sesiones el mismo día compiten por separado.
- Una sesión editada compite con sus valores nuevos, y una borrada ya no está en la lista (RF-5).

### `recordsBatidos(anteriores, nueva) → List<TipoRecord>` — RF-10, RF-11
```text
resultado ← []
para cada tipo en TipoRecord.values (en orden):
  v ← valor(tipo, nueva); si v == null → seguir
  previo ← máximo de valor(tipo) en anteriores (sin contar los null)
  si previo == null → seguir      // primera sesión o primer dato opcional: no avisa
  si v > previo → añadir tipo     // estrictamente mayor; un empate no bate
devolver resultado
```

## 4. Interfaz

### 4.1 Pantalla "Récords" (`RecordsScreen`)
- **Barra superior:** "Récords".
- **Si `status == error`:** "No se pudieron cargar los récords." (RF-7).
- **Si no hay sesiones:** encima de los récords, una tarjeta con "Aún no hay récords. Registra tu primera sesión con «Registrar sesión» en el inicio." (RF-4, RC-2), con el mismo estilo que el aviso del calendario.
- **Los 4 récords**, cada uno en una `Card` con un `ListTile`, en el orden de `TipoRecord`:

  | Récord | Valor |
  | --- | --- |
  | Sesión más larga | `formatearTiempo` |
  | Mayor distancia | `formatearKm` |
  | Mayor velocidad máxima | `formatearVelocidadMax` |
  | Mayor pulso máximo | `formatearPulso` |

  - **Título:** el nombre del récord. **Debajo:** la fecha de la sesión con `formatearFecha`, o "Sin datos". **A la derecha:** el valor (RF-1 a RF-3).
  - **Con sesión:** `onTap` → `editarSesion(context, sesion)` y después `cargar()`, más un chevron como en el historial (RF-8, RF-9).
  - **Sin sesión:** sin `onTap` ni chevron (RF-8).

### 4.2 Estado y Cubit
- `RecordsState` (freezed):
  - `status` (`loading`, `ready`, `error`);
  - `records: List<RecordPersonal>`;
  - `sinSesiones`, un `bool` que el Cubit rellena con la lista de sesiones vacía.
- `RecordsCubit.cargar()`: `getSessions()` → `Ok` → `emit(ready, records: calcularRecords(sesiones), sinSesiones: sesiones.isEmpty)`; `Error` → `emit(error)`. Se llama al abrir y al volver de editar, y la pantalla se crea de nuevo cada vez que se abre (RF-5).

### 4.3 Aviso de récord al registrar (RF-10 a RF-12)
- **`SessionFormCubit.guardar()`, solo en modo nuevo:**
  1. `anteriores ← getSessions()`; si falla, `anteriores ← null` (no se avisa, pero se guarda igual).
  2. `addSession(datos)`.
  3. Si se guarda bien: `emit(guardada, recordsBatidos: anteriores == null ? [] : recordsBatidos(anteriores, datos))`.
  4. Si falla, RC-1 como ahora, sin aviso.
- **En modo edición** no se calcula nada: `recordsBatidos` queda vacío (RF-12).
- **La pantalla del formulario** se cierra con `ResultadoFormulario(status, recordsBatidos)`.
- **El inicio**, al volver de registrar con `guardada`, muestra un `SnackBar` con:

  | Récords batidos | Mensaje |
  | --- | --- |
  | Ninguno | "Sesión guardada" (RF-11) |
  | 1 | "Sesión guardada. ¡Nuevo récord de distancia!" |
  | Varios | "Sesión guardada. ¡Nuevos récords de tiempo, distancia y pulso máximo!" |

  Los nombres son "tiempo", "distancia", "velocidad máxima" y "pulso máximo", unidos con ", " y " y " antes del último. El texto lo compone una función privada del inicio: es presentación, no una regla.

### 4.4 Rutas, navegación y DI
- **Formulario:** `RouteNames.sessionForm` pasa a devolver `ResultadoFormulario`. `editarSesion` y el inicio leen `.status`, y `editarSesion` sigue devolviendo el `SessionFormStatus?`, así que el historial y el calendario no cambian.
- **Récords:**
  - ruta `RouteNames.records = '/records'` y su caso en `AppRouter`;
  - `registerFactory<RecordsCubit>`;
  - en el inicio, `OutlinedButton.icon` "Récords" (icono `emoji_events`) debajo de "Calendario", con `_abrir(RouteNames.records)`, que recarga el inicio al volver.

## 5. Cambios en drift
Ninguno. `schemaVersion` sigue en 2.

## 6. Decisiones técnicas

| Decisión | Alternativa descartada | Por qué |
| --- | --- | --- |
| Calcular los récords batidos en `SessionFormCubit` **antes** de guardar, comparando con las sesiones anteriores | Que el inicio, al volver, busque la última sesión y la compare con las demás | El formulario sabe con certeza qué sesión es nueva y cuáles había antes. Desde el inicio habría que deducir cuál es "la nueva" por el `id` |
| El formulario se cierra con `ResultadoFormulario(status, recordsBatidos)`, una clase freezed | Que el propio formulario muestre el `SnackBar` del récord antes de cerrarse | El mensaje tras guardar ya lo muestra quien abre el formulario: separarlo en dos sitios lo haría confuso. Cambian 4 puntos de uso, pero el historial y el calendario no se tocan porque pasan por `editarSesion` |
| Leer todas las sesiones antes de cada registro | Consultar en drift solo los máximos | Reutiliza `getSessions` sin tocar `data`. Con unas cientos de sesiones al año, el coste es despreciable |
| `calcularRecords` devuelve la `Session` entera de cada récord | Guardar solo el valor y la fecha | RF-8 necesita la sesión para abrir su edición |
| Las funciones de récords no reciben "hoy" | Pasar "hoy" por norma | No dependen del día: un parámetro sin usar confundiría |
| Velocidad máxima con un formato nuevo "32 km/h" | Reutilizar `formatearKmh` ("32,0 km/h") | La velocidad máxima es entera (spec 001); "32,0" sugeriría decimales |
| Si falla la lectura previa, se guarda sin aviso | No guardar | Guardar es lo importante (RC-1): el aviso es secundario |

## 7. Casos límite y su tratamiento

| Caso | Resultado | Cómo |
| --- | --- | --- |
| Se borra o edita la sesión de un récord | Pasa a la siguiente mejor, o a "Sin datos" | `calcularRecords` sobre las sesiones actuales, con `cargar()` al volver |
| Sesiones sin velocidad máxima ni pulso | No compiten en esos récords | `valor == null` se descarta |
| Varias sesiones el mismo día | Compiten por separado | Se compara por sesión, no por día |
| Empate | Fecha de la más antigua; un empate no avisa | Menor `fecha` y después menor `id`; `v > previo` |
| Primera sesión, o primera tras borrar todas | Sin aviso | `previo == null` |
| Primera sesión con velocidad máxima o pulso | Sin aviso de ese récord; los demás sí pueden avisar | `previo == null` solo para ese tipo |
| Varios récords a la vez | Un único mensaje | Lista en el orden de `TipoRecord` |
| Falla el guardado | RC-1 y sin aviso | Rama `Error` sin cambios |
| Editar una sesión que pasa a tener un récord | Sin aviso | Solo se calcula en modo nuevo |

## 8. Cobertura

| Requisito | Dónde se cumple |
| --- | --- |
| RF-1 | `calcularRecords` (4, en orden) + `RecordsScreen` |
| RF-2 | `RecordPersonal.sesion.fecha` + `formatearFecha` |
| RF-3 | `sesion == null` → "Sin datos" |
| RF-4 | `sinSesiones` → tarjeta + "Sin datos" en los 4 |
| RF-5 | `cargar()` al abrir y al volver de editar; el inicio abre la pantalla de nuevo cada vez |
| RF-6 | Desempate por `fecha` e `id` en `calcularRecords` |
| RF-7 | `status == error` → mensaje |
| RF-8 | `onTap` solo con sesión → `editarSesion` |
| RF-9 | `editarSesion` (mensaje) + `cargar()` |
| RF-10 | `recordsBatidos` en `guardar()` + `ResultadoFormulario` + mensaje del inicio |
| RF-11 | `previo == null` y `v > previo`; lista vacía → "Sesión guardada" |
| RF-12 | Solo en modo nuevo |
| RC-1 | Sin cambios en el manejo de errores del formulario; si falla la lectura previa, se guarda igual |
| RC-2 | RF-4 |
| RC-3 | Textos en español; `formatearVelocidadMax` y `formatearPulso` con `intl` |

## 9. Verificación (sin tests, por decisión del autor)

- **Puerta:** `dart run build_runner build` (clases freezed nuevas o cambiadas), `dart format .` sin cambios y `flutter analyze` sin avisos.
- **Revisión de `calcularRecords` y `recordsBatidos` con un script temporal** fuera del repositorio:

  | Caso | Resultado esperado |
  | --- | --- |
  | Sin sesiones | 4 récords sin sesión; ningún récord batido |
  | Sesiones sin velocidad máxima ni pulso | Esos 2 sin sesión; tiempo y distancia sí |
  | Empate en velocidad máxima entre una sesión antigua y una nueva | Gana la antigua |
  | Empate con la misma fecha | Gana la de menor `id` |
  | Dos sesiones el mismo día | Cada una compite por separado |
  | Nueva con distancia mayor y tiempo igual | Batido: solo distancia |
  | Nueva que bate tiempo, distancia y pulso | `[tiempo, distancia, pulsoMax]`, en orden |
  | Primera sesión de todas | Ningún récord batido |
  | Primera sesión con pulso (las anteriores sin pulso) | Pulso no se cuenta como batido |
  | Nueva con valores menores | Ninguno |

  Formatos: `formatearVelocidadMax(32)` → "32 km/h" y `formatearPulso(160)` → "160 ppm".
- **Historial y calendario sin cambios:** al editar desde ellos, siguen saliendo "Sesión actualizada" y "Sesión borrada" (efecto de `ResultadoFormulario`).
- **Recorrido manual en Android** con una **base de datos de prueba** cargada en el móvil, **solo con tu permiso**, con la misma técnica de siempre: copia de la tuya, prueba y restauración idéntica.
  - **Sesiones de prueba:**
    - una de 40 min y 15 km, sin velocidad máxima ni pulso, hace 5 días;
    - una de 30 min y 12,5 km con velocidad máxima 32 y pulso 150, hace 4 días;
    - una de 30 min y 10 km con velocidad máxima 32 (empate) y sin pulso, hace 2 días.

  | # | Pasos | Resultado esperado |
  | --- | --- | --- |
  | 1 | Base de datos vacía: Inicio → "Récords" | Aviso "Aún no hay récords…" encima y los 4 con "Sin datos"; tocar uno no hace nada (RF-3, RF-4, RF-8) |
  | 2 | Registrar la primera sesión | Solo "Sesión guardada" (RF-11) |
  | 3 | Con la base de datos de prueba: "Récords" | Tiempo 0:40:00 y distancia 15 km (hace 5 días); velocidad máxima 32 km/h con la fecha de **hace 4 días** (empate, RF-6); pulso 150 ppm (RF-1, RF-2) |
  | 4 | Registrar una sesión de 20 min y 8 km sin opcionales | "Sesión guardada" (RF-11) |
  | 5 | Registrar una de 45 min y 16 km con velocidad máxima 32 y pulso 160 | "Sesión guardada. ¡Nuevos récords de tiempo, distancia y pulso máximo!"; la velocidad empata y no se nombra (RF-10, RF-11) |
  | 6 | "Récords" | Muestra los nuevos valores con la fecha de hoy (RF-5) |
  | 7 | Tocar "Mayor distancia" → cambiar a 14 km → Guardar | "Sesión actualizada" y sin aviso de récord; la distancia vuelve a 15 km de hace 5 días (RF-8, RF-9, RF-12) |
  | 8 | Tocar "Mayor pulso máximo" → Borrar → confirmar | "Sesión borrada"; el pulso vuelve a 150 ppm (RF-9) |
  | 9 | Atrás | Vuelve al inicio, actualizado; botón "Récords" debajo de "Calendario" (navegación) |
  | 10 | Historial y calendario → editar una sesión | "Sesión actualizada", igual que antes |
  | 11 | Revisar textos | En español: "32 km/h", "160 ppm" y las fechas (RC-3) |
