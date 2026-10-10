---
description: Estándares de pruebas (el proyecto aún no tiene tests).
globs: ["test/**", "integration_test/**"]
paths:
  - "test/**"
  - "integration_test/**"
---

# Pruebas

## Objetivo

- Por decisión del autor, el proyecto **no tiene tests** por ahora (`test/` no existe).
- Estas reglas aplican cuando se añadan; no crear tests ni dependencias de testing sin que el autor lo pida.

## Reglas

- **Prioridad**: tests unitarios de `lib/domain/` (racha), por ser la lógica crítica. Casos mínimos: sin días, hoy, ayer, hueco de un día, varias sesiones el mismo día, cambio de hora (horario de verano).
- **Estructura**: `test/` replica `lib/` y cada archivo termina en `_test.dart`.
- **Tipos**: unit (domain, repositorios), widget (pantallas con un Cubit fake). Integration y golden solo si el autor lo decide.
- **Fakes antes que mocks**: implementaciones falsas escritas a mano; no añadir `mockito`/`mocktail` sin preguntar.
- **Repositorios**: probar contra `AppDatabase(NativeDatabase.memory())`, cerrando la base en `tearDown`.
- **Tiempo**: fijar "hoy" inyectando el reloj (`now:`), nunca depender de `DateTime.now()`.
- **Cubits**: `bloc_test` solo si el autor lo aprueba como dependencia.
- **Ejecución**: `flutter test`, o `flutter test <archivo>` / `--plain-name "<nombre>"` para uno solo.

## Anti-patrones

- Tests que dependen de la fecha real o del orden de ejecución.
- Usar `get_it` en tests en lugar de pasar dependencias por constructor.
- Golden tests frágiles de pantallas que aún cambian.

## Checklist

- [ ] Autor ha pedido los tests y aprobado dependencias nuevas.
- [ ] Reloj fijado y base de datos en memoria.
- [ ] `flutter test` y `flutter analyze` en verde.
