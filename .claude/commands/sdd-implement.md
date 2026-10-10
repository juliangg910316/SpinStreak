---
description: SDD · Implementa UNA tarea de una spec (uso - /sdd-implement 001-registro-sesiones T3)
argument-hint: <NNN-nombre> <Tn>
disable-model-invocation: true
---

Si specs/$0/tasks.md no está en "Estado: aprobada", para y avísame.

Implementa SOLO la tarea $1 de specs/$0/tasks.md, siguiendo specs/$0/plan.md,
docs/constitution.md, AGENTS.md y la skill sdd.

1. Escribe el código de la tarea. Si necesitas desviarte del plan, para y pregúntame.
2. Si cambian tablas de drift: sube schemaVersion, escribe la migración que conserve los datos
   y ejecuta `dart run build_runner build`.
3. Ejecuta `dart format .` y `flutter analyze`, y muéstrame el resultado (sin errores ni avisos).
4. Marca $1 como hecha en tasks.md e indica qué RF cubre.
5. Actualiza MEMORY.md si hubo una decisión o un error a evitar.

Después PÁRATE. No empieces la siguiente tarea.
