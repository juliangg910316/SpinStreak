---
description: Estructura de carpetas, nombres de archivo y dónde crear código nuevo.
globs: ["lib/**", "test/**"]
paths:
  - "lib/**"
  - "test/**"
---

# Estructura del proyecto

## Objetivo

- Mantener la estructura descrita aquí y en `.ia/memories/flutter_architecture.memory.json` (arquitectura oficial de Flutter). `docs/setup/` es histórico y no es normativo.
- Que cualquier archivo nuevo tenga un sitio obvio.

## Reglas

- Árbol de `lib/`:
  - `main.dart`: arranque (intl, DI, `runApp`) y `SpinStreakApp`.
  - `config/`: `dependencies.dart` (get_it).
  - `routing/`: `route_names.dart`, `app_router.dart`.
  - `ui/core/themes/`: tema; `ui/core/ui/`: widgets compartidos entre features.
  - `ui/<feature>/view_model/` y `ui/<feature>/widgets/`.
  - `domain/models/`: modelos; `domain/`: lógica pura.
  - `data/repositories/`, `data/services/` (`database/` para drift), `data/model/` para modelos de servicios si los hubiera.
  - `utils/`: utilidades genéricas sin dependencias de feature (`result.dart`).
- No hay carpetas `core/` ni `shared/` en la raíz de `lib/`: lo compartido de UI va en `ui/core/`.
- **Nombres de archivo** (`snake_case`):
  - Pantalla: `<feature>_screen.dart` (no `_page`).
  - View model: `<feature>_cubit.dart` + `<feature>_state.dart`.
  - Repositorio: `<entidad>_repository.dart`; servicio: `<nombre>_service.dart` o `app_database.dart`.
  - Modelo: `<entidad>.dart` en singular.
- **Features**: una carpeta por pantalla/flujo de la especificación (`home`, `session_form`, `history`, `calendar`, `records`).
- **Imports**: relativos dentro de `lib/`; `package:spin_streak/...` en `test/`.
- **Código generado**: `*.g.dart` junto a su origen, generado con `dart run build_runner build`; excluido del análisis.
- **Tests** (cuando existan): `test/` replica la ruta de `lib/` (`test/domain/streak_calculator_test.dart`).

## Ejemplos cortos

- Nueva pantalla de historial:
  - `lib/ui/history/view_model/history_cubit.dart` + `history_state.dart`
  - `lib/ui/history/widgets/history_screen.dart`
  - `RouteNames.history` + caso en `AppRouter.onGenerateRoute` + `registerFactory<HistoryCubit>`.
- Nueva regla de negocio (récords): `lib/domain/records_calculator.dart`.

## Checklist

- [ ] Archivo en la capa y carpeta correctas.
- [ ] Nombre con el sufijo de su tipo (`_screen`, `_cubit`, `_state`, `_repository`).
- [ ] Ruta, Cubit y DI registrados si es una pantalla nueva.
