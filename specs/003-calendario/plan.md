# Plan 003 — Calendario de días entrenados
Estado: aprobada

Spec: `specs/003-calendario/spec.md` (aprobada). Respeta `docs/constitution.md` y las capas de `AGENTS.md` (`ui` → `domain` → `data`). **Sin dependencias nuevas** (la cuadrícula se hace con widgets de Flutter) y **sin cambios en las tablas de drift**.

> **Cambio del 2026-10-15** (spec actualizada y aprobada): hoy queda seleccionado al abrir y al volver al mes de hoy, tenga o no sesiones (RF-15), con su fecha y un mensaje si no tiene sesiones (RF-16); hoy siempre se puede pulsar; RF-7 a RF-10, RF-12 y RF-13 cambian. T1 a T5 ya están hechas: el cambio se aplica sobre ese código (sección 10).

## 1. Qué ya existe en el código

| Pieza | Estado | RF |
| --- | --- | --- |
| `SessionRepository.getSessions()`: todas las sesiones con su `dia` local, de la más reciente a la más antigua | Existe, sin cambios | RF-4, RF-7 |
| `agruparPorDia(sesiones)` → `List<DiaHistorial>` (día, sesiones y totales) | Existe, sin cambios | RF-4, RF-7 |
| Formatos `formatearFecha`, `formatearHora`, `formatearTiempo`, `formatearKm`, `formatearKmh`, `formatearKcal` | Existen. **Falta** el formato del mes ("octubre de 2026") | RF-1, RF-7 |
| `HistoryScreen` con `_CabeceraDia` y `_FilaSesion` (cabecera con totales y fila de sesión) | Existen, pero **privados** de la pantalla del historial | RF-7 |
| `HistoryScreen._abrirEdicion`: abre el formulario, recarga y muestra "Sesión actualizada" o "Sesión borrada" | Existe dentro del historial | RF-11, RF-12 |
| Formulario de edición y borrado (spec 001) y ruta `sessionForm` | Existe, sin cambios | RF-11 |
| Inicio con botón "Historial" que recarga al volver (spec 002) | Existe. **Falta** el botón "Calendario" | Navegación |
| Cuadrícula del mes, selección de día, Cubit, ruta y pantalla del calendario | **No existen** | RF-1 a RF-14 |

## 2. Archivos y responsabilidades

### domain
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/domain/models/mes_calendario.dart` | Crear | `@freezed MesCalendario` (`mes`, `semanas: List<List<CeldaDia?>>`, `puedeAvanzar`) y `@freezed CeldaDia` (`dia`, `entrenado`, `esHoy`, `esFuturo`, y el getter `seleccionable` = entrenado o hoy). `null` es una celda vacía de relleno | RF-1, RF-3 a RF-8 |
| `lib/domain/calendar_month.dart` | Crear | `construirMes(DateTime mes, Set<DateTime> diasEntrenados, DateTime hoy)`, `diaASeleccionar(...)` y `mismoDia(a, b)`, funciones puras con "hoy" como parámetro | RF-1, RF-3 a RF-6, RF-10, RF-12, RF-15 |

### ui y utils
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/utils/formatters.dart` | Modificar | `formatearMes(DateTime)` → "octubre de 2026" | RF-1, RC-3 |
| `lib/ui/core/ui/dia_historial_widgets.dart` | Crear (se mueve) | `CabeceraDia` y `FilaSesion`, públicos, **movidos sin cambios** desde `history_screen.dart` para reutilizarlos en el calendario | RF-7 |
| `lib/ui/core/ui/editar_sesion.dart` | Crear (se mueve) | `editarSesion(context, sesion)`: abre el formulario de la 001, espera el resultado y muestra "Sesión actualizada" o "Sesión borrada". Devuelve el resultado para que la pantalla recargue. Sale de `HistoryScreen._abrirEdicion` | RF-11, RF-12 |
| `lib/ui/history/widgets/history_screen.dart` | Modificar | Usa `CabeceraDia`, `FilaSesion` y `editarSesion`. **Refactor sin cambio de comportamiento** | — |
| `lib/ui/calendar/view_model/calendar_state.dart` | Crear | `@freezed CalendarState` | RF-1 a RF-14 |
| `lib/ui/calendar/view_model/calendar_cubit.dart` | Crear | `cargar()`, `mesAnterior()`, `mesSiguiente()` y `seleccionarDia(dia)`, con reloj inyectable | RF-1 a RF-3, RF-7 a RF-10, RF-12, RF-14 |
| `lib/ui/calendar/widgets/calendar_screen.dart` | Crear | Cabecera del mes con ‹ ›, iniciales L…D, cuadrícula, mensaje sin sesiones, sesiones del día seleccionado o texto de ayuda, y error | RF-1 a RF-14 |
| `lib/ui/home/widgets/home_screen.dart` | Modificar | Botón "Calendario" bajo "Historial", con el mismo estilo; recarga al volver | Navegación |
| `lib/routing/route_names.dart` y `app_router.dart` | Modificar | Ruta `calendar` (`/calendar`) con `BlocProvider(getIt<CalendarCubit>()..cargar())` | Navegación |
| `lib/config/dependencies.dart` | Modificar | `registerFactory<CalendarCubit>` | — |

## 3. Funciones puras en `lib/domain/`

### `construirMes(mes, diasEntrenados, hoy) → MesCalendario` — RF-1, RF-3 a RF-6
Recibe "hoy" como parámetro (constitución, principio 3). Trabaja solo con año, mes y día; no usa horas ni UTC, así que no le afectan los cambios de hora.

```text
primero ← DateTime(mes.year, mes.month, 1)
numDias ← DateTime(mes.year, mes.month + 1, 0).day        // 28–31; bisiestos incluidos
huecosInicio ← primero.weekday − 1                         // lunes = 0 … domingo = 6
celdas ← [null × huecosInicio]
para d en 1..numDias:
  dia ← DateTime(mes.year, mes.month, d)
  esFuturo ← dia es posterior a hoy (comparando año, mes y día)
  celdas += CeldaDia(dia, entrenado: !esFuturo && dia ∈ diasEntrenados, esHoy: mismoDia(dia, hoy), esFuturo)
rellenar con null hasta múltiplo de 7
semanas ← celdas en grupos de 7
puedeAvanzar ← (mes.year, mes.month) < (hoy.year, hoy.month)   // RF-3
devolver MesCalendario(mes: primero, semanas, puedeAvanzar)
```

- `diasEntrenados` llega como un `Set` de fechas normalizadas a `DateTime(y, m, d)`, igual que `Session.dia`.
- `mismoDia(a, b)` compara año, mes y día.
- Un día futuro nunca sale como entrenado (RF-6), aunque los datos fueran raros, por ejemplo tras cambiar el reloj del móvil.
- `CeldaDia.seleccionable` = `entrenado || esHoy` (RF-7, RF-8).

### `diaASeleccionar(previo, diasEntrenados, mesVisible, hoy) → DateTime?` — RF-10, RF-12, RF-15
Decide qué día queda seleccionado al abrir, al recargar y al cambiar de mes.

```text
si previo ≠ null y (previo ∈ diasEntrenados o mismoDia(previo, hoy)):
  devolver previo                                   // sigue seleccionado (RF-12)
si (mesVisible.year, mesVisible.month) == (hoy.year, hoy.month):
  devolver DateTime(hoy.year, hoy.month, hoy.day)   // hoy (RF-15, RF-12)
devolver null                                       // otro mes, sin selección (RF-9, RF-10, RF-12)
```

- Al abrir y al cambiar de mes se llama con `previo = null`: en el mes de hoy selecciona hoy; en otro mes, nada.
- Al recargar tras editar o borrar, `previo` es la selección actual.

## 4. Interfaz

### Estado (`CalendarState`, freezed)
| Campo | Tipo | Uso |
| --- | --- | --- |
| `status` | `loading`, `ready`, `error` | RF-14 |
| `hoy` | `DateTime?` | Del reloj del Cubit en cada `cargar()` |
| `mesVisible` | `DateTime?` | Primer día del mes mostrado |
| `dias` | `Map<DateTime, DiaHistorial>` | Por día, de `agruparPorDia` |
| `mes` | `MesCalendario?` | De `construirMes` |
| `seleccionado` | `DateTime?` | Día seleccionado (RF-7) |

- Getter `sinSesiones` = `dias.isEmpty` (RF-13).
- Getter `diaSeleccionado` = `dias[seleccionado]`.

### Cubit (`CalendarCubit`)
```
cargar():                                       // al abrir y al volver de editar (RF-12)
  result ← repository.getSessions(); si cerrado → salir
  Error → emitir(error)                                        // RF-14
  Ok(sesiones):
    hoy ← _now(); dias ← {d.dia: d para d en agruparPorDia(sesiones)}
    mesVisible ← state.mesVisible ?? primer día del mes de hoy  // RF-1 (abre en el mes de hoy)
    seleccionado ← diaASeleccionar(state.seleccionado, dias.keys, mesVisible, hoy)   // RF-12, RF-15
    emitir(ready, hoy, dias, mesVisible, seleccionado, mes: construirMes(mesVisible, dias.keys, hoy))

mesAnterior():  mesVisible ← mes − 1; seleccionado ← diaASeleccionar(null, …); recalcular mes   // RF-2, RF-10
mesSiguiente(): si !mes.puedeAvanzar → nada; si no, mes + 1; seleccionado ← diaASeleccionar(null, …)  // RF-2, RF-3, RF-10, RF-15
seleccionarDia(dia): si su celda es seleccionable → seleccionado ← dia; si no → nada   // RF-7, RF-8
```
El Cubit no calcula reglas: la cuadrícula, los días futuros, el límite de meses y qué día queda seleccionado salen de `domain`.

### Pantalla (`CalendarScreen`)
- **Barra superior:** "Calendario".
- **Si `status == error`:** "No se pudo cargar el calendario." (RF-14).
- **Si no hay sesiones:** encima de la cabecera, una tarjeta con "Aún no hay días entrenados. Registra tu primera sesión con «Registrar sesión» en el inicio." (RF-13, RC-2).
- **Cabecera del mes:**
  - `IconButton` ‹, con tooltip "Mes anterior";
  - `formatearMes(mesVisible)`;
  - `IconButton` ›, con tooltip "Mes siguiente", **desactivado** si `!puedeAvanzar` (RF-2, RF-3).
- **Iniciales:** fila L, M, X, J, V, S, D (semana en lunes).
- **Cuadrícula:** 7 columnas. Cada celda es un círculo con el número del día, de al menos 40 × 40 px para pulsarlo con comodidad:

  | Celda | Aspecto | RF |
  | --- | --- | --- |
  | Entrenada | Fondo `colorScheme.primary` y número `onPrimary` | RF-4 |
  | Hoy | Borde de 2 px en `colorScheme.tertiary`, compatible con el fondo de entrenado | RF-5 |
  | Seleccionada | Borde grueso en `colorScheme.secondary` y sombra | RF-7 |
  | Futura | Número en gris (`onSurface` con baja opacidad) y sin `onTap` | RF-6, RF-8 |
  | No entrenada pasada | Sin fondo y sin `onTap`, salvo si es hoy (siempre se puede pulsar) | RF-7, RF-8 |
  | Hueco (`null`) | Vacía | |

- **Debajo de la cuadrícula:**
  - con día seleccionado: `CabeceraDia` y una `FilaSesion` por sesión; tocar una llama a `editarSesion` y luego a `cargar()` (RF-7, RF-11, RF-12);
  - con hoy seleccionado y sin sesiones (`seleccionado != null` y `diaSeleccionado == null`): una cabecera con la fecha de hoy, con el mismo aspecto que `CabeceraDia`, y debajo "Hoy aún no has entrenado. Registra una sesión con «Registrar sesión» en el inicio." (RF-16);
  - sin selección: "Toca un día marcado para ver sus sesiones." (RF-9).
- **Navegación:**
  - **inicio:** `OutlinedButton.icon` "Calendario" (icono `calendar_month`) debajo de "Historial". Abre la ruta y, al volver, llama a `cargar()` del inicio (spec 002, RF-6);
  - **ruta y DI:** `RouteNames.calendar`, caso en `AppRouter` y `registerFactory<CalendarCubit>`.

## 5. Cambios en drift
Ninguno. `schemaVersion` sigue en 2.

## 6. Decisiones técnicas

| Decisión | Alternativa descartada | Por qué |
| --- | --- | --- |
| Cuadrícula propia con `Row` y `Column` (o `GridView` sin scroll) | Paquete `table_calendar` | Sin dependencias nuevas (constitución, principio 1). Solo hace falta una cuadrícula mensual simple, y un paquete traería selección de rangos, locales y estilos que no se usan |
| Cargar todas las sesiones una vez y construir el mes en memoria | Consulta por mes en el repositorio | Es una app personal con pocas sesiones al año. Reutiliza `getSessions` y `agruparPorDia` sin tocar `data`, y cambiar de mes es instantáneo |
| `construirMes` en `domain` (cuadrícula, días futuros, límite de meses) | Calcular la cuadrícula en el widget | Constitución, principio 3: reglas puras con "hoy" como parámetro y verificables con un script |
| Mover `_CabeceraDia`, `_FilaSesion` y `_abrirEdicion` a `ui/core/ui/` y reutilizarlos | Copiarlos en el calendario | RF-7 exige "el mismo formato que el historial": compartir el código lo garantiza. Es un refactor sin cambio de comportamiento (principio 2) |
| La selección se mantiene al recargar si el día sigue teniendo sesiones (o es hoy); si no, pasa a hoy en el mes de hoy o se quita en otro mes | Quitarla siempre al volver de editar | RF-12: tras editar, ves los totales actualizados del mismo día |
| Qué día queda seleccionado lo decide `diaASeleccionar` en `domain` | Decidirlo con `if` en el Cubit | La regla tiene varios casos (RF-10, RF-12, RF-15): como función pura se verifica con un script, y el Cubit no contiene reglas |
| Cabecera de "hoy sin sesiones" privada del calendario, con el mismo aspecto que `CabeceraDia` | Hacer que `CabeceraDia` acepte un día sin sesiones | `CabeceraDia` muestra totales de un `DiaHistorial`; cambiarla tocaría el historial, que ya está verificado |
| Borde de "hoy" en `tertiary` y de "seleccionado" en `secondary` | Un mismo borde para los dos | Hoy puede estar seleccionado y entrenado a la vez: con tres señales distintas (fondo, borde de hoy y borde de selección) siempre se distinguen |

## 7. Casos límite y su tratamiento

| Caso | Resultado | Cómo |
| --- | --- | --- |
| Varias sesiones el mismo día | Una sola marca; al pulsarlo, todas listadas | `agruparPorDia` |
| Hoy entrenado | Fondo de entrenado y borde de hoy | |
| Meses anteriores a la primera sesión | Se ven sin marcas; la flecha ‹ siempre funciona | |
| Meses de 28 a 31 días y bisiestos | La cuadrícula es correcta | `DateTime(y, m + 1, 0).day` y `weekday` |
| Editar una sesión | El día no cambia; los totales del día seleccionado sí | `cargar()` |
| Hoy sin sesiones | Seleccionado al abrir, con su fecha y el mensaje de RF-16; se puede volver a pulsar | `seleccionable`, `diaASeleccionar` |
| Borrar la única sesión del día seleccionado | El día deja de marcarse; la selección sigue en hoy, pasa a hoy o se quita | `diaASeleccionar` (RF-12) |
| Borrar la última sesión que queda | Mensaje de RF-13 encima y hoy seleccionado con RF-16 | |
| Cambio de hora | Sin efecto | Solo se usan año, mes y día |
| Calendario abierto de un día para otro | "Hoy" se renueva en cada `cargar()`, al volver de editar | Como dice la spec |

## 8. Cobertura

| Requisito | Dónde se cumple |
| --- | --- |
| RF-1 | `CalendarCubit.cargar` (mes de hoy) + `formatearMes` + cuadrícula de lunes a domingo (`construirMes`) |
| RF-2 | `mesAnterior` y `mesSiguiente` + flechas |
| RF-3 | `MesCalendario.puedeAvanzar` + flecha › desactivada |
| RF-4 | `CeldaDia.entrenado` + fondo `primary` |
| RF-5 | `CeldaDia.esHoy` + borde `tertiary` |
| RF-6 | `CeldaDia.esFuturo` (nunca entrenado) + estilo gris |
| RF-7 | `seleccionarDia` (celdas `seleccionable`) + `CabeceraDia` y `FilaSesion` reutilizados del historial |
| RF-8 | `seleccionarDia` ignora las celdas no seleccionables |
| RF-9 | Texto de ayuda cuando `seleccionado == null` (solo fuera del mes de hoy) |
| RF-10 | `mesAnterior` y `mesSiguiente` con `diaASeleccionar(null, …)` |
| RF-11 | `FilaSesion.onTap` → `editarSesion` (formulario de la 001) |
| RF-12 | `editarSesion` (mensaje) + `cargar()` con `diaASeleccionar(seleccionado, …)` |
| RF-13 | `sinSesiones` → tarjeta encima del calendario; hoy seleccionado (RF-15, RF-16) |
| RF-14 | `status == error` → mensaje |
| RF-15 | `diaASeleccionar` al abrir (`cargar`) y al volver al mes de hoy |
| RF-16 | Cabecera con la fecha de hoy + mensaje cuando `diaSeleccionado == null` con selección |
| RC-1 | Las escrituras ocurren en el formulario de la 001, que ya cumple RC-1 |
| RC-2 | RF-13 |
| RC-3 | `formatearMes`, iniciales en español, formatos del historial y `flutter_localizations` |

## 9. Verificación (sin tests, por decisión del autor)

- **Puerta:** `dart run build_runner build` (clases freezed nuevas), `dart format .` sin cambios y `flutter analyze` sin avisos.
- **Revisión de `construirMes` con un script temporal** fuera del repositorio:

  | Mes | Qué se comprueba |
  | --- | --- |
  | Octubre de 2026 | Empieza en jueves: 3 huecos; 31 días |
  | Junio de 2026 | Empieza en lunes: sin huecos iniciales |
  | Febrero de 2028 | Bisiesto: 29 días |
  | Marzo de 2026 | Termina en martes: huecos finales |

  En todos: `esHoy` solo en hoy, `esFuturo` desde mañana, ningún futuro entrenado aunque esté en el conjunto, y `puedeAvanzar` falso en el mes de hoy y verdadero en los anteriores.
- **Revisión de `diaASeleccionar` y `seleccionable` con un script temporal** (cambio del 2026-10-15):

  | Caso | Resultado esperado |
  | --- | --- |
  | Abrir (`previo = null`) en el mes de hoy, con o sin sesiones hoy | Hoy, sin hora |
  | `previo = null` en otro mes | `null` |
  | `previo` con sesiones | `previo` |
  | `previo` = hoy sin sesiones | Hoy |
  | `previo` sin sesiones, otro día del mes de hoy | Hoy |
  | `previo` sin sesiones, día de otro mes | `null` |
  | `seleccionable` | Cierto si entrenado o hoy; falso en un día no entrenado pasado y en uno futuro |
- **El refactor del historial** (`CabeceraDia`, `FilaSesion`, `editarSesion`) no cambia nada: abrir el historial y editar una sesión se ve y funciona igual que antes.
- **Recorrido manual en Android.** Para tener días de meses anteriores hace falta una **base de datos de prueba** cargada en el móvil, **solo con tu permiso**, con la misma técnica que en la 002: copia de la tuya, prueba y restauración idéntica. Propuesta: 2 sesiones hace 3 días, una ayer, y 3 días del mes anterior.

  | # | Pasos | Resultado esperado |
  | --- | --- | --- |
  La base de datos de prueba no tiene sesiones hoy. Si el recorrido se hace el día 1, 2 o 3 del mes, "hace 3 días" y "ayer" caen en el mes anterior: entonces se ajustan las fechas para que queden en el mes de hoy.

  | # | Pasos | Resultado esperado |
  | --- | --- | --- |
  | 1 | Inicio → "Calendario" (base de datos vacía) | Mes actual; hoy con borde y seleccionado; mensaje "Aún no hay días entrenados…" encima; debajo, la fecha de hoy y "Hoy aún no has entrenado…" (RF-1, RF-5, RF-13, RF-15, RF-16) |
  | 2 | Con la base de datos de prueba, abrir el calendario | Días entrenados con círculo; los futuros en gris; la flecha › desactivada; hoy seleccionado con su fecha y "Hoy aún no has entrenado…" (RF-3, RF-4, RF-6, RF-15, RF-16) |
  | 3 | Pulsar un día no entrenado (que no sea hoy) y uno futuro | No pasa nada (RF-8) |
  | 4 | Pulsar el día con 2 sesiones | Queda resaltado; debajo, la cabecera con "2 sesiones" y los totales, y 2 filas (RF-7) |
  | 5 | Pulsar hoy | Hoy vuelve a quedar seleccionado, con su fecha y el mensaje (RF-7, RF-16) |
  | 6 | ‹ al mes anterior | Sin selección y "Toca un día marcado…"; se ven sus 3 días marcados; la › vuelve a estar activa (RF-2, RF-9, RF-10) |
  | 7 | En el mes anterior, pulsar un día marcado → sesión → Borrar → confirmar | "Sesión borrada"; el día deja de marcarse y se quita la selección (RF-12) |
  | 8 | › hasta el mes actual | La › se desactiva de nuevo y hoy vuelve a estar seleccionado (RF-3, RF-10, RF-15) |
  | 9 | Pulsar el día de ayer → tocar su sesión → cambiar la distancia → Guardar | "Sesión actualizada"; sigue seleccionado con los totales nuevos (RF-11, RF-12) |
  | 10 | Pulsar el día de ayer → sesión → Borrar → confirmar | "Sesión borrada"; ayer ya no está marcado y la selección pasa a hoy (RF-12) |
  | 11 | Atrás | Vuelve al inicio, actualizado (navegación) |
  | 12 | Revisar textos | Mes, iniciales y mensajes en español (RC-3) |
  | 13 | Historial → editar una sesión | Igual que antes del refactor |

## 10. Cambio del 2026-10-15 sobre el código ya hecho (T1 a T5)

| Archivo | Cambio | RF |
| --- | --- | --- |
| `lib/domain/models/mes_calendario.dart` | `const CeldaDia._()` y getter `seleccionable` | RF-7, RF-8 |
| `lib/domain/calendar_month.dart` | Nueva `diaASeleccionar` | RF-10, RF-12, RF-15 |
| `lib/ui/calendar/view_model/calendar_cubit.dart` | `cargar`, `mesAnterior` y `mesSiguiente` usan `diaASeleccionar`; `seleccionarDia` usa `seleccionable` | RF-7, RF-8, RF-10, RF-12, RF-15 |
| `lib/ui/calendar/widgets/calendar_screen.dart` | `onTap` en las celdas `seleccionable`; caso "hoy sin sesiones" debajo de la cuadrícula | RF-7, RF-8, RF-16 |

Sin cambios en `data`, drift, rutas ni DI.
