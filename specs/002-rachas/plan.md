# Plan 002 — Rachas
Estado: aprobada

Spec: `specs/002-rachas/spec.md` (aprobada). Respeta `docs/constitution.md` y las capas de `AGENTS.md` (`ui` → `domain` → `data`). **Sin dependencias nuevas y sin cambios en las tablas de drift.**

## 1. Qué ya existe en el código

| Pieza | Estado | RF |
| --- | --- | --- |
| `calculateStreak(trainedDays, today)` en `domain/streak_calculator.dart`: días únicos, racha viva si el último día es hoy o ayer, mejor racha, total, `_dayNumber` con UTC solo como calendario | Existe y cumple | RF-2, RF-3, RF-4, RF-5, RF-7, cambio de hora |
| Modelo `Streak` (freezed) con `current`, `best`, `totalDays` y `Streak.empty` | Existe. **Falta** saber si hoy hay sesión | RF-8 a RF-11 |
| `SessionRepository.getTrainedDays()`: días distintos a partir de la columna `dia` (local) | Existe, sin cambios | RF-2, RF-7 |
| `HomeCubit.cargar()` con reloj inyectable y `HomeState` (freezed: `status`, `streak`) | Existe. **Falta** el mensaje del día y la fecha de hoy en el estado | RF-1, RF-6 |
| `HomeScreen`: fecha de hoy, tres contadores, botón flotante "Registrar sesión" y botón "Historial", con recarga al volver (spec 001) | Existe. **Falta** el mensaje del día y el recálculo al volver la app al primer plano. La fecha se calcula con `DateTime.now()` dentro del widget, contra la regla de `AGENTS.md` | RF-1, RF-6, RF-8 |
| Sin sesiones: contadores a 0 | Existe. Falta el mensaje de bienvenida | RF-8 |

## 2. Archivos y responsabilidades

### domain
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/domain/models/streak.dart` | Modificar | Nuevo campo `trainedToday` (`bool`): hoy hay al menos una sesión. `Streak.empty` con `trainedToday: false` | RF-9, RF-10 |
| `lib/domain/streak_calculator.dart` | Modificar | `calculateStreak` rellena `trainedToday` (`days.last == número de hoy`), con el mismo `_dayNumber` | RF-9, RF-10, RF-13 |
| `lib/domain/models/mensaje_dia.dart` | Crear | Unión `@freezed sealed MensajeDia`: `bienvenida`, `aSalvo`, `riesgo(int dias)` y `reiniciada(int mejorRacha)` | RF-8 a RF-12 |
| `lib/domain/streak_message.dart` | Crear | `mensajeDelDia(Streak racha) → MensajeDia`, función pura | RF-8 a RF-12 |

### ui y utils
| Archivo | Acción | Responsabilidad | RF |
| --- | --- | --- | --- |
| `lib/utils/formatters.dart` | Modificar | `formatearDias(int n)` → "1 día", "12 días", "1.000 días" | RF-12, RC-3 |
| `lib/ui/home/view_model/home_state.dart` | Modificar | Nuevos campos `hoy` (`DateTime?`) y `mensaje` (`MensajeDia?`) | RF-1, RF-8 a RF-11 |
| `lib/ui/home/view_model/home_cubit.dart` | Modificar | `cargar()`: `hoy = _now()`, `streak = calculateStreak(días, hoy)`, `mensaje = mensajeDelDia(streak)` | RF-1, RF-6, RF-8 a RF-11, RF-13 |
| `lib/ui/home/widgets/home_screen.dart` | Modificar | Pasa a `StatefulWidget` con `AppLifecycleListener(onResume: cubit.cargar)`. Pinta la fecha desde `state.hoy` y la tarjeta del mensaje del día entre la fecha y los contadores | RF-1, RF-8 a RF-13 |

Sin cambios en `data/`, en el router ni en la DI: `HomeCubit` ya está registrado y su ruta ya lanza `cargar()`.

## 3. Funciones puras en `lib/domain/`

### `calculateStreak(trainedDays, today)` (se amplía) — RF-2 a RF-5, RF-7, RF-9, RF-10
Recibe "hoy" como parámetro (constitución, principio 3). Solo se añade una línea al algoritmo actual:

```
days ← números de día únicos y ordenados de trainedDays
si days vacío → Streak.empty (trainedToday = false)
best, run ← racha más larga y racha que termina en days.last   // ya existe
hoyN ← _dayNumber(today)
isAlive ← days.last ≥ hoyN − 1                                 // ya existe
trainedToday ← days.last == hoyN                               // NUEVO
devolver Streak(current: isAlive ? run : 0, best, totalDays: |days|, trainedToday)
```

### `mensajeDelDia(Streak racha) → MensajeDia` — RF-8 a RF-12
No necesita "hoy" aparte: ya va dentro de `racha`, calculada con `today`. El orden de las comprobaciones garantiza un solo mensaje (RF-12):

```
si racha.totalDays == 0       → bienvenida                    // RF-8
si racha.trainedToday         → aSalvo                        // RF-10
si racha.current > 0          → riesgo(dias: racha.current)   // RF-9 (hoy no, ayer sí)
si no                         → reiniciada(mejorRacha: racha.best)  // RF-11
```

Las cuatro situaciones son excluyentes y cubren todos los casos. Si hay sesiones pero `current` es 0, la última sesión es anterior a ayer: el caso de RF-11.

### `formatearDias(int n)` (utils, presentación) — RF-12, RC-3
`n == 1 ? '1 día' : '${NumberFormat('#,##0').format(n)} días'`.

## 4. Interfaz

### Estado (`HomeState`, freezed)
`status` (`loading`, `ready`, `error`), `streak` (`Streak.empty`), `hoy` (`DateTime?`) y `mensaje` (`MensajeDia?`).

### Cubit (`HomeCubit.cargar()`) — RF-1, RF-6, RF-13
```
result ← repository.getTrainedDays()
si cerrado → salir
Ok(días):  hoy ← _now(); streak ← calculateStreak(días, hoy)
           emitir(ready, streak, hoy, mensaje: mensajeDelDia(streak))
Error:     emitir(error)
```
"Hoy" sale siempre del reloj inyectado del Cubit, así que la fecha mostrada y el cálculo coinciden siempre (RF-1, RF-13).

### Pantalla (`HomeScreen`)
- **Orden** (de arriba abajo):
  1. la fecha de hoy (`formatearFecha(state.hoy)`);
  2. la **tarjeta del mensaje del día**;
  3. los tres contadores;
  4. el botón "Historial";
  5. el botón flotante "Registrar sesión".

  Con esto, el mensaje de bienvenida queda "encima" de los contadores (RF-8).
- **Textos** (RC-3; `switch` sobre `MensajeDia`):

  | Caso | Texto |
  | --- | --- |
  | `bienvenida` | "Aún no has registrado ninguna sesión. Toca «Registrar sesión» para empezar tu racha." |
  | `aSalvo` | "Hoy ya has entrenado. ¡Racha a salvo!" |
  | `riesgo(d)` | "Entrena hoy para mantener tu racha de ${formatearDias(d)}." |
  | `reiniciada(m)` | "Tu racha se ha reiniciado. Tu mejor racha es de ${formatearDias(m)}: registra una sesión hoy para empezar una nueva." |

- **Aspecto:** una `Card` con icono y colores del tema (`colorScheme`), sin colores fijos. Para distinguir el aviso de riesgo, `riesgo` usa `errorContainer` y `aSalvo` usa `primaryContainer`.
- **RF-13:** `AppLifecycleListener(onResume: () => context.read<HomeCubit>().cargar())`, creado en `initState` y liberado en `dispose`.
- **Navegación:** sin cambios. Los botones "Calendario" y "Récords" **no se crean en este plan**: se añadirán en los planes de la 003 y la 004, con el mismo estilo que "Historial", como dice la spec.

## 5. Cambios en drift
Ninguno. `schemaVersion` sigue en 2.

## 6. Decisiones técnicas

| Decisión | Alternativa descartada | Por qué |
| --- | --- | --- |
| `trainedToday` dentro de `Streak`, calculado en `calculateStreak` | Calcularlo aparte en el Cubit o en otra función | Usa el mismo `_dayNumber`, con el mismo tratamiento del cambio de hora, en una sola pasada. El Cubit no calcula reglas (principio 3) |
| `MensajeDia` como unión freezed en `domain`, y los textos en la UI | Devolver el texto desde `domain` | `domain` decide *qué* situación es (regla de negocio). El texto y el plural son presentación (RC-3), como con `ErrorCampo` en la 001 |
| `AppLifecycleListener` en `HomeScreen` | `WidgetsBindingObserver`, o un temporizador a medianoche | Es la API actual de Flutter, con menos código. La spec descarta el temporizador (fuera de alcance) |
| "Hoy" en `HomeState`, del reloj del Cubit | `DateTime.now()` en el widget, como ahora | `AGENTS.md` prohíbe llamar a `DateTime.now` directamente. Así la fecha mostrada y el cálculo usan el mismo instante |
| Plural con `formatearDias` | `Intl.plural` | Solo hay un caso (día o días). Una función simple basta y es legible |
| La tarjeta del mensaje va siempre entre la fecha y los contadores | Una posición distinta según el mensaje | Un único sitio para el mensaje (RF-12), y RF-8 exige "encima" de los contadores |

## 7. Casos límite y su tratamiento

| Caso | Resultado | Cómo |
| --- | --- | --- |
| Sin sesiones | Contadores a 0 y `bienvenida` | `Streak.empty` |
| Ayer sí, hoy no | `riesgo(current)` | `trainedToday = false` y `current > 0` |
| Hoy sí | `aSalvo` | |
| Hueco de un día o más | `current = 0` y `reiniciada(best)` | |
| Cambio de hora | Sin efecto | `_dayNumber` con UTC como calendario |
| Se borra la única sesión de hoy | Al volver, `cargar()` pasa a `riesgo` o `reiniciada` (o a `bienvenida` si era la última) | |
| Se edita una sesión | Su día no cambia y la racha tampoco | |
| Guardar después de medianoche | Cuenta para el día nuevo | Spec 001 |
| App abierta de un día para otro | Al volver al primer plano, `onResume` → `cargar()` con el nuevo "hoy" | |
| Racha o mejor racha de 1 | "1 día" | `formatearDias` |

## 8. Cobertura

| Requisito | Dónde se cumple |
| --- | --- |
| RF-1 | `HomeState.hoy` + `formatearFecha` + contadores en `HomeScreen` |
| RF-2, RF-3, RF-4, RF-5, RF-7 | `calculateStreak` (existe) + `getTrainedDays` (columna `dia` local) |
| RF-6 | `cargar()` al volver de registrar o del historial (existe, spec 001) |
| RF-8 | `mensajeDelDia` → `bienvenida` + tarjeta encima de los contadores a 0 |
| RF-9 | `trainedToday` + `mensajeDelDia` → `riesgo` |
| RF-10 | `trainedToday` + `mensajeDelDia` → `aSalvo` |
| RF-11 | `mensajeDelDia` → `reiniciada(best)` |
| RF-12 | Orden excluyente de `mensajeDelDia` + `formatearDias` |
| RF-13 | `AppLifecycleListener.onResume` → `cargar()` |
| RC-1 | No aplica: la 002 no guarda, edita ni borra. Los errores de lectura ya muestran "No se pudieron cargar los datos" |
| RC-2 | RF-8 |
| RC-3 | Textos en español, `formatearFecha` y `formatearDias` (intl `es`), `flutter_localizations` (spec 001) |

## 9. Verificación (sin tests, por decisión del autor)

- **Puerta:** `dart run build_runner build` (cambian clases freezed), `dart format .` sin cambios y `flutter analyze` sin avisos.
- **Revisión de `domain` caso por caso,** con un script temporal fuera del repositorio, como en la 001:
  - **`calculateStreak`:**
    - sin días;
    - solo hoy;
    - solo ayer;
    - ayer y hoy;
    - hueco de un día;
    - varias sesiones el mismo día;
    - mejor racha anterior a la actual;
    - días alrededor del cambio de hora (último domingo de marzo y de octubre);
    - comprobar `trainedToday` en cada caso.
  - **`mensajeDelDia`:** los cuatro casos y que solo sale uno.
  - **`formatearDias`:** 1, 2 y 1.000.
- **Recorrido manual en Android.** Los estados `riesgo` y `reiniciada` necesitan sesiones de días anteriores, que la app no deja registrar (spec 001, RF-2). Para probarlos propongo una **base de datos de prueba** en el móvil, con la misma técnica que la migración de la 001: copia de la base de datos real al PC, base de datos de prueba, prueba y restauración de la original. **Solo con tu permiso** en cada ocasión; el `adb` se usa solo para copiar archivos, nunca para tocar la pantalla.

  | # | Datos de partida | Pasos | Resultado esperado |
  | --- | --- | --- | --- |
  | 1 | BD vacía | Abrir la app | Fecha de hoy; mensaje de bienvenida encima; contadores 0, 0 y 0 (RF-1, RF-8) |
  | 2 | BD vacía | Registrar una sesión | Vuelve con "Sesión guardada", "¡Racha a salvo!" y contadores 1, 1 y 1 (RF-6, RF-10) |
  | 3 | BD de prueba: sesiones de ayer y anteayer, ninguna hoy | Abrir la app | "Entrena hoy para mantener tu racha de 2 días."; racha 2 (RF-3, RF-9) |
  | 4 | BD de prueba: una sesión ayer | Abrir la app | "…tu racha de 1 día." (singular, RF-12) |
  | 5 | BD de prueba: 5 días seguidos que acaban hace 3 días | Abrir la app | Racha 0; "Tu racha se ha reiniciado. Tu mejor racha es de 5 días: …"; mejor racha 5 (RF-4, RF-5, RF-11) |
  | 6 | Estado del paso 3 | Registrar una sesión | "¡Racha a salvo!" y racha 3 (RF-6, RF-10) |
  | 7 | Estado del paso 6 | Historial → borrar la sesión de hoy → volver | Vuelve a "Entrena hoy… 2 días." (RF-6, RF-9) |
  | 8 | Cualquiera | Dejar la app en segundo plano, cambiar la fecha del móvil al día siguiente en Ajustes, volver a la app | La fecha y el mensaje se actualizan al nuevo día (RF-13). Después, restaurar la fecha automática |
  | 9 | — | Revisar textos | Todo en español, "1 día" o "N días" bien (RC-3) |
