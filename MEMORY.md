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
- Sin streams: el repositorio devuelve `Future<Result<T>>` (`get()` de drift) y los Cubits recargan la vista tras cada acción y al volver de otra pantalla. El autor prefiere el control explícito. El código actual aún usa `watch()`: hay que refactorizarlo.
- Spec-Driven Development: constitución en `docs/constitution.md`; skill `sdd` y comandos `/sdd-*` en `.claude/`. Se retiró `/feature`. `spec.md`, `plan.md` y `tasks.md` llevan `Estado:`; solo pasan a `aprobada` cuando el autor lo dice.
- `docs/ESPECIFICACION.md` = visión global + requisitos comunes (RC-1 a RC-3). Los RF de cada funcionalidad solo viven en `specs/`. Cada spec define su navegación.
- 4 specs para el MVP (001 registro, 002 rachas, 003 calendario, 004 récords), para que cada una quepa en ≤10 tareas. Evolución semanal y mensual, y diferencia de odómetro: v2.
- Lo ya implementado se documenta y se valida, no se rehace: la spec 002 (`StreakCalculator` e inicio) y parte de la 001 (el repositorio ya tiene alta, edición y borrado, y conserva la fecha al editar).

## Errores a evitar
- (vacío)

## Próximos pasos (MVP)
Todas las specs están en `Estado: borrador`, con dudas `[NECESITA ACLARACIÓN]` pendientes (incluida la navegación).
- [ ] Refactor sin cambio de comportamiento: pasar `SessionRepository` (`watchSessions`, `watchTrainedDays`) a `Future<Result<T>>` con `get()`, y `HomeCubit` a `cargar()` sin suscripciones.
- [ ] 001-registro-sesiones: resolver dudas (`/sdd-spec`) → clarify → plan → tasks → implement → validate.
- [ ] 002-rachas: resolver dudas → validar lo existente → completar lo que falte.
- [ ] 003-calendario: resolver dudas → flujo completo.
- [ ] 004-records: resolver dudas → flujo completo.
