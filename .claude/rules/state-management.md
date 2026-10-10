---
description: Gestión de estado con flutter_bloc (Cubit por pantalla).
globs: ["lib/ui/**"]
paths:
  - "lib/ui/**"
---

# Gestión de estado (flutter_bloc)

## Objetivo

- Un view model por pantalla en `lib/ui/<feature>/view_model/`, implementado como **Cubit**.
- Estado inmutable y predecible; la UI solo pinta el estado y llama a métodos del Cubit.

## Reglas

- **Cubit por defecto**: métodos públicos con verbos (`guardar()`, `editar()`). Usar `Bloc` con eventos solo si el flujo tiene muchas acciones o necesita transformadores (debounce, etc.).
- **Archivos**: `<feature>_cubit.dart` y `<feature>_state.dart` en el mismo `view_model/`.
- **Estado inmutable**: campos `final`, constructor `const`, `copyWith` para cambios. Estado inicial con valores por defecto (`const HomeState()`).
- **Loading/error/success**: un `enum <Feature>Status { loading, ready, error }` en el estado (patrón actual), o una `sealed class` si cada caso lleva datos distintos.
- **Carga de datos (sin streams)**: el Cubit tiene un método `cargar()` que pide los datos al repositorio (`Future<Result<T>>`), hace `switch` sobre el `Result` y emite el estado. No se usan streams ni suscripciones.
- **Escrituras**: el Cubit llama al repositorio, hace `switch` sobre el `Result`, emite el estado correspondiente y, si la acción tuvo éxito, vuelve a llamar a `cargar()`.
- **Volver de otra pantalla**: si una pantalla abre otra que puede cambiar datos (p. ej. el formulario de sesión), espera a que se cierre (`await Navigator.pushNamed(...)`) y llama a `cargar()` de su Cubit.
- **Sin lógica de negocio**: el Cubit delega en `domain/` (p. ej. `calculateStreak`) y solo transforma resultados en estado.
- **Reloj**: si el estado depende de "hoy", recibir `DateTime Function()` por constructor.
- **Side-effects** (navegación, snackbars): `BlocListener` en la UI, nunca dentro del Cubit.
- **Rebuilds**: `BlocBuilder` con `buildWhen` o `BlocSelector` cuando solo interesa una parte del estado; `context.read<T>()` en callbacks, `context.watch<T>()` solo en `build()`.
- **Provisión**: el `BlocProvider` se crea en `AppRouter` al construir la ruta, no dentro de la pantalla.

## Anti-patrones

- `setState` para estado de negocio (solo para estado efímero de UI, p. ej. un campo de texto).
- Mutar el estado actual o emitir el mismo objeto modificado.
- Pasar `BuildContext` al Cubit o importar `package:flutter/material.dart` en él.
- Emitir después de `close()` (comprobar `isClosed` en callbacks asíncronos largos).
- Cubits que se llaman entre sí; coordinar a través del repositorio.
- Suscribirse a streams del repositorio o de drift (`watch()`): las vistas se recargan tras cada acción.

## Checklist

- [ ] Estado inmutable con `copyWith` y estado inicial `const`.
- [ ] Casos de carga y error representados en el estado y pintados en la UI.
- [ ] La vista se recarga (`cargar()`) tras cada acción con éxito y al volver de una pantalla que cambia datos.
- [ ] Cubit registrado como `registerFactory` en `dependencies.dart`.
