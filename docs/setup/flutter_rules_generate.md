# Project Rule Builder

Actúa como un "Project Rule Builder" para este repositorio Flutter.
Objetivo: crear/actualizar un conjunto de Project Rules (.md), basadas en:

1) el estado REAL del proyecto (carpetas, dependencias, patrones ya utilizados), y
2) la guía oficial de reglas de Dart: <https://raw.githubusercontent.com/flutter/flutter/refs/heads/master/docs/rules/rules.md>
   - Si no puedes acceder al enlace, deriva las reglas a partir del `analysis_options.yaml` y del código existente.

## Entrada opcional

- Es posible proporcionar un archivo complementario con información/contexto para orientar la generación de las reglas.
- Formatos aceptados: `.md`, `.txt`, `.json`, `.yaml`.
- Tratamiento:
  - Lee el archivo íntegramente y extrae directrices útiles (decisiones arquitectónicas, excepciones locales, convenciones del equipo, restricciones de seguridad, etc.).
  - En caso de conflicto entre el archivo auxiliar y el estado real del repositorio, prioriza el repositorio y registra la divergencia en los TODOs del resumen final.
  - No copies el contenido en su totalidad; incorpóralo como reglas objetivas alineadas con el código y los lints.
  - En el resumen final, indica el nombre del archivo usado como "Fuente auxiliar".

## Qué analizar en el repo

- `pubspec.yaml` (dependencias → detectar state management y libs de DI).
- `analysis_options.yaml` (lints/formatter).
- Estructura `lib/**`, `test/**`, `integration_test/**`, `assets/**`, `l10n/**`.
- Presencia de `core/`, `shared/`, design system, temas, i18n.
- ¿Monorepo? (múltiples `pubspec.yaml` → ajustar globs para `apps/*/lib/**` y `packages/*/lib/**`).
- Archivo auxiliar (opcional), cuando se proporcione (ver "Entrada opcional").

## Salida esperada (archivos y contenido)

Crea/actualiza **exactamente** estos archivos, con front-matter y contenido conciso en bullets:

1) `dart-coding-standards.md`  (Always)
   - `description`: Estándares de código Dart del proyecto.
   - Reglas: formatter, imports, naming, null-safety, uso de `const`, async/await, extensions, logs (sin prints en prod).
   - Alinea con las reglas del enlace oficial y el `analysis_options.yaml`.
   - Secciones: Objetivo, Reglas, Anti-patrones, Checklist.

2) `flutter-clean-architecture.md`  (Auto-attach)
   - `globs`: paths reales de la app (ej.: `"lib/**"` o `"apps/*/lib/**"`).
   - Capas: presentation / domain / data; direcciones de dependencia; DTOs solo en data; use cases; repositorios (contratos vs impl).
   - Secciones: Objetivo, Estructura por feature, Direcciones de dependencia, Anti-patrones, Checklist.

3) `dependency-injection.md`  (Auto-attach)
   - `globs`: igual que arriba.
   - Detecta la lib estándar (ej.: GetIt/Riverpod/etc.) vía dependencias; define ciclo de vida (singleton/factory), orden de arranque, prohibición de instanciar servicios en widgets, estrategia de mocks en pruebas.
   - Secciones: Objetivo, Reglas, Mocks/ambientes, Checklist.

4) `state-management.md`  (Auto-attach)
   - `globs`: idem.
   - Detecta el patrón (Signals/BLoC/Riverpod/Provider) por el código y deps; define inmutabilidad, estructura de estados, loading/error/success, side-effects, selectors para evitar rebuilds, pruebas de estado.
   - Secciones: Objetivo, Reglas, Anti-patrones, Checklist.

5) `project-structure.md`  (Auto-attach)
   - `globs`: `"lib/**","test/**","integration_test/**","assets/**","l10n/**"` (ajustar según repo).
   - Árbol de carpetas por feature; `core/` (theme, routes, errors, utils); `shared/` (widgets); convenciones de nombres (`*_page.dart`, `*_cubit.dart`/`*_notifier.dart`); reglas de import (relativo/absoluto); dónde crear nuevos archivos.
   - Secciones: Objetivo, Reglas, Ejemplos cortos, Checklist.

6) `testing-standards.md`  (Auto-attach)
   - `globs`: `"test/**","integration_test/**","packages/*/test/**"` si es monorepo.
   - Tipos: unit/widget/integration/golden; estructura de carpetas; cuándo mockear vs fake; cobertura objetivo; ejecución en CI; fixtures/seeds.
   - Secciones: Objetivo, Reglas, Anti-patrones, Checklist.

7) `commits-and-language.md`  (Always)
   - Commits semánticos en **es-ES** (feat/fix/chore/docs/refactor/test): título corto + cuerpo explicando qué/por qué; referencia a issues/PRs; patrón para PRs (título/descripción/labels).
   - Secciones: Objetivo, Patrones, Ejemplos cortos, Checklist.

## Opcionales (crear solo si el repo indica necesidad)

- `design-system-and-theming.md` (Auto-attach si hay `core/theme` o DS).
- `assets-and-i18n.md`        (Auto-attach si hay `l10n/**` o ARB).
- `security-and-secrets.md`    (Always: .env/cofre, no-logs sensibles, permisos).

## Requisitos de forma

- Idioma: es-ES, directo y asertivo.
- Cada archivo comienza con front-matter YAML: `description`, y **o bien** `alwaysApply: true` **o bien** `globs: [...]` (para Auto-attach).
- Texto en bullets, secciones cortas: Objetivo, Reglas, Anti-patrones, Checklist (y "Ejemplos cortos" cuando sea útil).
- No copiar la guía de Dart completa; **alinea y referencia** (ej.: "seguir regla X cuando sea aplicable").
- Límite: reglas objetivas (evitar párrafos largos).

## Pasos finales

- Lista al final un "Resumen de lo detectado" (state mgmt, DI, monorepo, carpetas).
- Valida los `globs` con base en el árbol real del repo y muéstralos en el resumen.
- Si algo está ambiguo, propón defaults sensatos y registra TODOs.
- Si se utilizó un archivo auxiliar, inclúyelo en el resumen: `Fuente auxiliar: <ruta/archivo>` y destaca cualquier decisión derivada de él
  