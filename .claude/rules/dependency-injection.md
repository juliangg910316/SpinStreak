---
description: Inyección de dependencias con get_it: registro, ciclo de vida y uso.
globs: ["lib/**"]
paths:
  - "lib/**"
---

# Inyección de dependencias (get_it)

## Objetivo

- Un único punto de composición: `lib/config/dependencies.dart` (`setupDependencies()`).
- Clases desacopladas que reciben sus dependencias por constructor.

## Reglas

- **Registro**: todo servicio, repositorio y Cubit se registra en `setupDependencies()`, agrupado por tipo con un comentario.
- **Ciclo de vida**:
  - `registerLazySingleton` para servicios (`AppDatabase`) y repositorios.
  - `registerFactory` para Cubits (uno nuevo por pantalla; `BlocProvider` lo cierra).
- **Orden de arranque** en `main()`: `WidgetsFlutterBinding.ensureInitialized()` → inicialización de `intl` → `setupDependencies()` → `runApp()`.
- **Dónde se usa `getIt<...>()`**: solo en `dependencies.dart` y en el `create:` de los `BlocProvider` de `lib/routing/app_router.dart`.
- **Constructores**: dependencias como parámetros `required` con nombre; dependencias de entorno (reloj) como parámetro opcional con valor por defecto (`this._now = DateTime.now`).
- Registrar con el tipo explícito: `registerLazySingleton<SessionRepository>(...)`.

## Mocks/ambientes

- Un solo entorno (`main.dart`); no hay configuración por entorno.
- En pruebas, pasar fakes por constructor sin tocar `get_it`. Si un test de widget necesita el contenedor, llamar a `getIt.reset()` en `tearDown`.
- Base de datos de prueba: `AppDatabase(NativeDatabase.memory())`.

## Anti-patrones

- Llamar a `getIt` dentro de widgets, Cubits, repositorios o `build()`.
- Instanciar servicios o repositorios con `new`/constructor dentro de la UI.
- Singletons globales propios (`static instance`) fuera de get_it.
- Registrar Cubits como singleton.

## Checklist

- [ ] Nueva clase registrada en `dependencies.dart` con el ciclo de vida correcto.
- [ ] Dependencias recibidas por constructor.
- [ ] `getIt` no aparece fuera de `config/` y `routing/`.
