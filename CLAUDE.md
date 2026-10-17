# CLAUDE.md

Guía para Claude Code (claude.ai/code) al trabajar con el código de este repositorio.

Las instrucciones principales del proyecto (stack, comandos, convenciones, reglas de dominio, límites, verificación y memoria) están en `AGENTS.md`, la fuente única compartida con cualquier agente:

@AGENTS.md

Aquí solo va el detalle extra para Claude Code. Si cambian las reglas generales, editar `AGENTS.md`, no este archivo.

## Contexto adicional

- Decisiones completas de arquitectura: `.ia/memories/flutter_architecture.memory.json`. Reglas detalladas por tema en `.claude/rules/` (se cargan automáticamente).
- SDK Dart `^3.13.3`: dot shorthands y parámetros con nombre privados (`this._campo`).
- Lints: `flutter_lints` + reglas extra en `analysis_options.yaml` (comillas simples, `const`, trailing commas, `final` locales…). Se excluyen `build/`, `android/`, `ios/`, `**/*.g.dart` y `**/*.freezed.dart`.
## Flujo de datos (UI → datos)

- `lib/ui/<feature>/widgets/` pinta el estado con `BlocBuilder`; `lib/ui/<feature>/view_model/` tiene el Cubit y su estado inmutable. El Cubit carga los datos con `cargar()` (`Future<Result<T>>`, sin streams), recarga tras cada acción y no contiene reglas de negocio.
- `lib/domain/`: modelos (`models/session.dart`) y lógica pura (`streak_calculator.dart`, la racha). Sin dependencias de Flutter ni drift.
- `lib/data/repositories/`: convierte filas de drift (`SessionRow`) en modelos de dominio, devuelve `Result<T>` (`lib/utils/result.dart`) en vez de lanzar excepciones y asigna la fecha con un reloj inyectable (`updateSession` nunca cambia la fecha).
- `lib/data/services/database/app_database.dart`: tablas drift. La columna `dia` (`yyyy-MM-dd` local, calculada al registrar) es la clave de la racha y del agrupado por día.
- `lib/config/dependencies.dart`: registro en `get_it` (lazy singletons para servicios/repositorios, factories para Cubits). `getIt<...>()` solo se usa ahí y en el `create:` de los `BlocProvider` de `lib/routing/app_router.dart`; el resto recibe dependencias por constructor.
- Nueva pantalla: añadir el nombre en `routing/route_names.dart`, el caso en `AppRouter.onGenerateRoute` y registrar su Cubit en `dependencies.dart`.
- `main.dart` configura `intl` en español (`initializeDateFormatting('es')`) antes de `setupDependencies()`.

## Documentación del proyecto (vault de Obsidian)

Nota del proyecto (archivada el 2026-10-16): `D:\Obsidian Vault\04 - Archive\Projects\SpinStreak\`.
