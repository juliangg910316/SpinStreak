# AGENTS.md -- SpinStreak
App Flutter solo para Android y de uso personal: registra a diario las sesiones de bicicleta estática y motiva con la racha de días consecutivos. Proyecto de portafolio. Principios innegociables en `docs/constitution.md` (stack, spec, capas, datos e idioma); visión en `docs/ESPECIFICACION.md`; requisitos en `specs/`.

## Stack y estructura
- Flutter (Dart `^3.13.3`) · `flutter_bloc` (un Cubit por pantalla) · `get_it` · `drift` (SQLite local) · `intl` (es) · rutas nombradas nativas.
- Capas: `lib/ui/<feature>/{view_model,widgets}` → `lib/domain/` (modelos, lógica pura y validaciones) → `lib/data/{repositories,services/database}`. DI en `lib/config/`, rutas en `lib/routing/`. Detalle por tema en `.claude/rules/`.

## Comandos
```bash
flutter pub get
dart run build_runner build   # tras cambiar tablas de drift
dart format .
flutter analyze
flutter run
```

## Convenciones
- Commits semánticos en español: `feat(session): registrar sesión del día`.

## Reglas de dominio / trampas conocidas
- La fecha la asigna el repositorio con un reloj inyectable: **no se registran días pasados** y editar no cambia la fecha. `DateTime.now` solo como valor por defecto de ese reloj, nunca llamado directamente.
- Racha con la **fecha local** (columna `dia`, `yyyy-MM-dd`), nunca UTC. Varias sesiones el mismo día = un día. Ojo con los cambios de hora.
- La fila de drift es `SessionRow`; el modelo de dominio es `Session`.

## Forma de trabajar
- **Spec-Driven Development** (skill `sdd`, comandos `/sdd-*`): spec → clarificación → plan → tareas → implementación (una tarea cada vez) → validación. No se pasa de fase sin aprobación. Las correcciones sin cambio de comportamiento se hacen directamente.
- Al terminar: resumen breve, cómo probarlo y decisiones que deba revisar el autor.

## Límites
- **Siempre:** respetar las capas; `getIt` solo en `config/` y en el router; el repositorio devuelve `Future<Result<T>>` (sin streams ni `watch()`); las vistas se recargan tras cada acción.
- **Pregunta antes:** añadir dependencias, cambiar la arquitectura, modificar tablas de drift, crear tests.
- **Nunca:** editar `*.g.dart` a mano, añadir backend o HTTP, permitir fechas pasadas, hacer commits sin que se pida.

## Verificación
- `dart format .` sin cambios y `flutter analyze` sin errores ni avisos; si cambian tablas, migración + `build_runner`.
- Recorrido manual en el emulador o dispositivo Android con `flutter run`.

## Memoria
- Al empezar, lee `MEMORY.md`. Al terminar una tarea, actualízalo: estado, decisiones (con su porqué) y errores a evitar.
- Máximo ~50 líneas. Si algo se convierte en regla permanente, propón moverlo a `AGENTS.md`. Nunca datos sensibles.
