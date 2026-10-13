---
description: Capas, direcciones de dependencia y responsabilidades según la arquitectura oficial de Flutter.
globs: ["lib/**"]
paths:
  - "lib/**"
---

# Arquitectura por capas

## Objetivo

- Seguir la [guía oficial de arquitectura de Flutter](https://docs.flutter.dev/app-architecture/guide): `ui` → `domain` ← `data`.
- Mantener la lógica de negocio (racha) pura y testeable, aislada de Flutter y de drift.

## Estructura por feature

- **UI (presentation)**: `lib/ui/<feature>/widgets/` (pantallas) + `lib/ui/<feature>/view_model/` (Cubit + estado).
- **Domain**: `lib/domain/models/` (modelos inmutables) y lógica pura en `lib/domain/` (p. ej. `streak_calculator.dart`).
- **Data**: `lib/data/repositories/` (única puerta de la UI a los datos) y `lib/data/services/` (fuentes: base de datos drift en `services/database/`).
- **Transversal**: `lib/config/` (DI), `lib/routing/`, `lib/utils/` (`Result<T>`), `lib/ui/core/` (tema y widgets compartidos).

## Direcciones de dependencia

- `ui` importa `domain` y `data/repositories`; **nunca** `data/services` ni drift.
- `data/repositories` importa `domain`, `data/services` y `utils`.
- `domain` no importa nada de `ui`, `data`, Flutter ni paquetes externos: solo `dart:` y `package:freezed_annotation`.
- Los modelos de `domain/models/` son clases `@freezed` (ver `dart-coding-standards.md`).
- Las filas de drift (`SessionRow`, `SessionsCompanion`) **solo existen en `data/`**: el repositorio las convierte a modelos de dominio.
- Los repositorios devuelven `Future<Result<T>>` en lecturas y escrituras; no lanzan excepciones hacia la UI. Las lecturas usan `get()` de drift, **nunca `watch()` ni `Stream`**: las vistas se recargan después de cada acción.
- Repositorios como clase concreta; crear contrato abstracto solo si hay dos implementaciones reales o se necesita un fake.
- Casos de uso: no hay capa `use_cases`. La lógica de negocio va como funciones/clases puras en `domain/`; crear `domain/use_cases/` solo si un flujo combina varios repositorios.

## Reglas de negocio que viven en capas concretas

- La fecha de la sesión la asigna `SessionRepository` con su reloj inyectable; la UI nunca envía fecha.
- `updateSession` no modifica `fecha` ni `dia`.
- La racha se calcula en `domain/streak_calculator.dart` a partir de días únicos (columna `dia`, `yyyy-MM-dd` local).
- Datos derivados (velocidad media, totales) se calculan, no se almacenan.
- Las validaciones de negocio (campos obligatorios, rangos válidos) son funciones puras en `domain/` (p. ej. `domain/session_validator.dart`). El Cubit las llama y convierte el resultado en estado; el formulario solo pinta los errores.

## Anti-patrones

- Widgets o Cubits que acceden a `AppDatabase` directamente.
- Validaciones de negocio dentro del formulario (`validator:` con reglas propias) o del Cubit.
- Reglas de negocio (racha, validaciones de fecha) dentro de un Cubit o widget.
- Modelos de dominio con anotaciones o tipos de drift.
- Usar `DateTime.now()` dentro de lógica de dominio en vez de recibir el día como parámetro.

## Checklist

- [ ] Ningún import de `data/services` o `package:drift` desde `lib/ui/`.
- [ ] `lib/domain/` sin imports de Flutter ni paquetes (salvo `freezed_annotation`).
- [ ] Repositorio convierte filas → modelos y envuelve errores en `Result`.
- [ ] Nueva regla de negocio con su función pura en `domain/`.
