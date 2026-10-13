# MEMORY.md -- SpinStreak

## Estado actual (2026-10-10)
- Esqueleto de arquitectura creado: DI, router, base de datos drift, `SessionRepository`, `StreakCalculator` y `Result<T>`.
- Solo existe la pantalla de inicio (racha).
- Sin tests (`test/` no existe). Repositorio git creado, sin commits todavía.
- Documentación revisada y alineada el 2026-10-10 (contradicciones corregidas).

## Decisiones (y por qué)
- Solo Android, uso personal y datos solo locales: es una app personal y no necesita backend.
- Racha estrictamente diaria, sin comodines: así lo decidió el autor.
- No se registran días pasados: evita "rellenar" una racha rota. **Riesgo aceptado**: una sesión sin registrar o borrada por error rompe la racha sin remedio.
- Sin copia de seguridad hasta la v2: **riesgo aceptado** de perder datos al desinstalar o cambiar de móvil.
- Columna `dia` en hora local (`yyyy-MM-dd`) calculada al registrar: es la clave de la racha y del agrupado por día.
- Fila de drift `SessionRow`: evita el choque de nombres con el modelo de dominio `Session`.
- DI en `lib/config/` (no en `core/di`): la estructura no tiene `core/` en la raíz de `lib/`. `docs/setup/` es histórico.
- Sin tests por ahora: decisión del autor.
- Validaciones de negocio en `lib/domain/`, nunca en el formulario ni en el Cubit.
- Sin streams: el repositorio devuelve `Future<Result<T>>` (`get()` de drift) y los Cubits recargan la vista tras cada acción y al volver de otra pantalla. El autor prefiere el control explícito. Refactor hecho (2026-10-10): `getSessions()` / `getTrainedDays()` y `HomeCubit.cargar()`, lanzado desde el router con `..cargar()`.
- Spec-Driven Development: constitución en `docs/constitution.md`; skill `sdd` y comandos `/sdd-*` en `.claude/`. Se retiró `/feature`. `spec.md`, `plan.md` y `tasks.md` llevan `Estado:`; solo pasan a `aprobada` cuando el autor lo dice.
- `docs/ESPECIFICACION.md` = visión global + requisitos comunes (RC-1 a RC-3). Los RF de cada funcionalidad solo viven en `specs/`. Cada spec define su navegación.
- 4 specs para el MVP (001 registro, 002 rachas, 003 calendario, 004 récords), para que cada una quepa en ≤10 tareas. Evolución semanal y mensual, y diferencia de odómetro: v2.
- Lo ya implementado se documenta y se valida, no se rehace: la spec 002 (`StreakCalculator` e inicio) y parte de la 001 (el repositorio ya tiene alta, edición y borrado, y conserva la fecha al editar).

## Errores a evitar
- Las comprobaciones con `flutter run` necesitan un dispositivo o emulador Android encendido: comprobarlo con `flutter devices` antes de dar por hecho un "Hecho cuando" visual.
- Probar migraciones sin tocar datos reales: copiar la BD del móvil (`adb exec-out run-as com.juliangg.spin_streak cat app_flutter/spinstreak.sqlite`), meter una BD de prueba, instalar con `adb install -r`, abrir, traer la BD, inspeccionarla con `node:sqlite` y restaurar el original. En Git Bash usar `MSYS_NO_PATHCONV=1` o las rutas del móvil (`/data/local/tmp`) se convierten en rutas de Windows.

## Próximos pasos (MVP)
Todas las specs están en `Estado: borrador`, con dudas `[NECESITA ACLARACIÓN]` pendientes (incluida la navegación).
- [ ] 001-registro-sesiones: spec **aprobada** (2026-10-12) → plan en borrador (2026-10-12; propone `Duration` en vez de `DateTime` para el tiempo, pendiente de confirmar; schemaVersion 2 con velocidad máxima entera redondeada; 2026-10-13: `freezed` en todos los modelos y estados) → **plan aprobado** y constitución actualizada (principio 1 con freezed, 2026-10-13) → **tasks aprobadas** (10 tareas, 2026-10-13) → implement: T1 hecha (2026-10-13: freezed instalado, `*.freezed.dart` excluido del análisis, AGENTS.md, reglas y memoria de arquitectura actualizados). T2 hecha (2026-10-13: `Streak` movido a `domain/models/streak.dart` con freezed; `HomeState` con freezed y `@Default`; APK compila; **pendiente que el autor confirme en un dispositivo** que el inicio muestra los mismos contadores, porque no había ninguno conectado). T3 hecha (2026-10-13: `Session` freezed con `dia` y `velocidadMax: int?`, `SessionData`, `schemaVersion` 2 con migración verificada en el móvil: 32,6→33, 32,4→32, NULL→NULL, 3/3 filas conservadas; BD original restaurada). Siguiente: T4. → tasks → implement → validate. Decidido: rangos por campo; tiempo con selector h/m/s (el autor quiere DateTime + widgets propios: decidir en el plan); velocidad máxima, pulso y calorías enteros; distancia y odómetro hasta 2 decimales; odómetro solo valida rango (se quitó el aviso de odómetro menor, 2026-10-12); editar/borrar cualquier sesión, totales por día en el historial, navegación desde el inicio (botón flotante + botón "Historial"), sin barra inferior.
- [ ] 002-rachas: resolver dudas → validar lo existente → completar lo que falte.
- [ ] 003-calendario: resolver dudas → flujo completo.
- [ ] 004-records: resolver dudas → flujo completo.
