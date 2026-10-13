# Spec 003 — Calendario de días entrenados
Estado: borrador

## Contexto y objetivo
Un calendario o heatmap con los días entrenados permite ver la constancia de un vistazo. Un calendario lleno motiva y hace más difícil saltarse un día.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero ver en un calendario qué días he entrenado para ver mi constancia de un vistazo.
- HU-2. Como usuario, quiero consultar las sesiones de un día concreto desde el calendario.

## Definiciones
- **Día entrenado**: el mismo concepto que en la spec 002. El día de una sesión se fija al guardarla y no cambia al editarla (spec 001), el mismo criterio que agrupa el historial.

## Requisitos funcionales
- RF-1: EL SISTEMA muestra un calendario en el que los días entrenados se distinguen visualmente de los no entrenados.
- RF-2: EL SISTEMA marca el día de hoy de forma distinta al resto.
- RF-3: CUANDO el usuario pulsa un día entrenado, EL SISTEMA muestra las sesiones de ese día.
- RF-4: CUANDO se registra, edita o borra una sesión, EL SISTEMA actualiza el calendario sin reiniciar la app.
- RF-5: EL SISTEMA no muestra días futuros como entrenados ni como fallados.

## Requisitos no funcionales
- Las semanas empiezan en lunes.
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- Pendiente de definir: desde dónde se abre el calendario y a dónde lleva pulsar un día (ver dudas abiertas).
- Contexto de la spec 001: el inicio ya tiene el botón flotante "Registrar sesión" y el botón "Historial". El historial agrupa las sesiones por día, con los totales, y desde él se edita cualquier sesión.

## Casos límite
- Sin sesiones: el calendario no da errores. Qué se muestra está pendiente (ver dudas, RC-2).
- Varias sesiones el mismo día: el día se marca una sola vez.
- Días anteriores a la primera sesión.
- Se edita una sesión: su día no cambia (spec 001, RF-14), así que el calendario no varía. Solo cambia al registrar o borrar.
- Se borra la única sesión de un día: ese día deja de marcarse como entrenado.

## Fuera de alcance
- Editar sesiones desde el calendario.
- Gráficas de evolución (v2).

## Criterios de finalización
- Todos los RF se cumplen en un recorrido manual en Android.
- `dart format .` no deja cambios y `flutter analyze` termina sin errores ni avisos.

## Dudas abiertas
- [NECESITA ACLARACIÓN] ¿Vista mensual (con navegación entre meses) o heatmap anual estilo GitHub?
- [NECESITA ACLARACIÓN] ¿El color es binario (entrenado / no entrenado) o con intensidad según la distancia o el tiempo?
- [NECESITA ACLARACIÓN] ¿Se marcan los días de la racha actual de forma especial?
- [NECESITA ACLARACIÓN] Navegación: ¿desde dónde se abre el calendario? Depende de la duda de navegación de la spec 002: más botones en el inicio o barra inferior.
- [NECESITA ACLARACIÓN] Al pulsar un día (RF-3): ¿se muestran sus sesiones en la misma pantalla o se abre el historial en ese día? Si se muestran, ¿con los mismos datos que el historial de la 001 (cabecera con totales y, por sesión, hora, tiempo, distancia, velocidad media y kcal)?
- [NECESITA ACLARACIÓN] "Editar sesiones desde el calendario" está fuera de alcance, pero la 001 permite editar cualquier sesión desde el historial. Si al pulsar un día se ven sus sesiones, ¿tocarlas abre la edición de la 001 o solo se consultan?
- [NECESITA ACLARACIÓN] Sin sesiones contra RC-2: RC-2 exige un mensaje que explique qué hacer para empezar en lugar de una pantalla vacía. ¿Se muestra el calendario vacío con un mensaje encima, o solo el mensaje?
