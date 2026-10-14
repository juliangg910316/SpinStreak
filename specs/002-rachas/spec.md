# Spec 002 — Rachas
Estado: implementada

## Contexto y objetivo
La motivación principal de la app es la constancia: ver cuántos días seguidos se ha entrenado anima a no saltarse el siguiente. La pantalla de inicio muestra la racha actual, la mejor racha y el total de días entrenados, y un mensaje que dice en cada momento qué hacer hoy para mantener o recuperar la racha.

> Ya existe una implementación inicial: el cálculo de la racha y la pantalla de inicio con los contadores, la fecha de hoy y los accesos de la spec 001. Esta spec documenta el comportamiento esperado; la validación dirá qué falta o qué hay que corregir.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero ver mi racha actual al abrir la app para motivarme a mantenerla.
- HU-2. Como usuario, quiero ver mi mejor racha para tener un récord que superar.
- HU-3. Como usuario, quiero ver el total de días entrenados para valorar mi constancia aunque pierda la racha.
- HU-4. Como usuario, quiero que la app me avise si hoy aún no he entrenado y la racha está en riesgo, para no perderla por olvido.
- HU-5. Como usuario, quiero que la app me anime a empezar de nuevo cuando pierdo la racha.

## Definiciones
- **Día entrenado**: día natural (fecha local del dispositivo) con al menos una sesión. Varias sesiones el mismo día cuentan como un solo día. El día de una sesión se fija al guardarla y no cambia al editarla (spec 001, RF-1 y RF-14).
- **Racha actual**: número de días entrenados consecutivos que terminan hoy o ayer.
- **Mejor racha**: la secuencia de días entrenados consecutivos más larga del historial.
- **Total de días**: número de días entrenados distintos.
- **Mensaje del día**: el único mensaje que muestra el inicio, según la situación:

| Situación | Mensaje | RF |
| --- | --- | --- |
| No hay ninguna sesión | "Aún no has registrado ninguna sesión. Toca «Registrar sesión» para empezar tu racha." | RF-8 |
| Hoy ya hay al menos una sesión | "Hoy ya has entrenado. ¡Racha a salvo!" | RF-10 |
| Hoy no hay sesión y la racha actual es mayor que 0 (ayer sí se entrenó) | "Entrena hoy para mantener tu racha de N días." | RF-9 |
| Hay sesiones y la racha actual es 0 | "Tu racha se ha reiniciado. Tu mejor racha es de N días: registra una sesión hoy para empezar una nueva." | RF-11 |

## Requisitos funcionales

### Contadores
- RF-1: EL SISTEMA muestra en la pantalla de inicio la fecha de hoy, la racha actual, la mejor racha y el total de días entrenados.
- RF-2: EL SISTEMA cuenta como un solo día entrenado todas las sesiones de un mismo día.
- RF-3: MIENTRAS el último día entrenado sea hoy o ayer, EL SISTEMA muestra como racha actual el número de días consecutivos que terminan en ese día.
- RF-4: SI el último día entrenado es anterior a ayer, ENTONCES EL SISTEMA muestra la racha actual como 0.
- RF-5: EL SISTEMA conserva la mejor racha aunque la racha actual vuelva a 0.
- RF-6: CUANDO se registra, edita o borra una sesión, EL SISTEMA actualiza los contadores y el mensaje del día sin reiniciar la app.
- RF-7: EL SISTEMA calcula los días con la fecha local del dispositivo, no con UTC.

### Mensaje del día
- RF-8: SI no hay ninguna sesión, ENTONCES EL SISTEMA muestra los tres contadores a 0 y, encima, el mensaje de bienvenida de la tabla (RC-2).
- RF-9: MIENTRAS la racha actual sea mayor que 0 y hoy no haya ninguna sesión, EL SISTEMA muestra el aviso "Entrena hoy para mantener tu racha de N días.", con N = racha actual.
- RF-10: MIENTRAS haya al menos una sesión hoy, EL SISTEMA muestra "Hoy ya has entrenado. ¡Racha a salvo!".
- RF-11: MIENTRAS haya sesiones y la racha actual sea 0, EL SISTEMA muestra "Tu racha se ha reiniciado. Tu mejor racha es de N días: registra una sesión hoy para empezar una nueva.", con N = mejor racha.
- RF-12: EL SISTEMA muestra un solo mensaje del día a la vez y usa el singular cuando N es 1 ("1 día").
- RF-13: CUANDO la app vuelve al primer plano, EL SISTEMA recalcula los contadores y el mensaje del día con la fecha actual del dispositivo.

## Requisitos no funcionales
- Un cambio de hora (horario de verano) no altera la racha.
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- La pantalla de inicio es la primera que se muestra al abrir la app.
- Botón flotante "Registrar sesión" (spec 001): al volver de guardar, el inicio muestra los contadores y el mensaje actualizados y el mensaje "Sesión guardada".
- Debajo de los contadores, un botón por pantalla secundaria, con el mismo estilo:
  - "Historial" (spec 001);
  - "Calendario" (spec 003);
  - "Récords" (spec 004).

  Los dos últimos se añaden al implementar sus specs. Si la spec 004 decide mostrar los récords en el propio inicio, el botón "Récords" no se añade.
- Al volver de cualquier pantalla secundaria, el inicio se actualiza (RF-6).

## Casos límite
- Hoy aún no se ha entrenado, pero ayer sí: la racha sigue viva y se muestra el aviso de RF-9.
- Hueco de exactamente un día: la racha vuelve a 0 y se muestra el mensaje de RF-11.
- Varias sesiones el mismo día: cuentan como un día.
- Día del cambio de hora (23 o 25 horas).
- Se borra la única sesión de un día dentro de una racha: la racha se recalcula (puede volver a 0). Si era la única de hoy, el mensaje pasa de RF-10 a RF-9 o RF-11.
- Se borra la última sesión que queda: contadores a 0 y mensaje de bienvenida (RF-8).
- Se edita una sesión: su día no cambia (spec 001, RF-14), así que la racha no varía. Solo cambia al registrar o borrar.
- Se guarda una sesión justo después de medianoche: cuenta para el día en que se pulsa "Guardar" (spec 001, RF-1).
- La app queda abierta o en segundo plano de un día para otro: al volver a ella se recalculan los contadores y el mensaje (RF-13).
- Racha o mejor racha de 1: "1 día" (RF-12).

## Fuera de alcance
- Comodines o días de descanso (la racha es estrictamente diaria).
- Notificaciones fuera de la app de racha en riesgo (v2).
- Insignias por hitos (v2).
- Actualizar el inicio exactamente a medianoche mientras la app está en pantalla; solo se actualiza al volver a la app (RF-13).

## Criterios de finalización
- Todos los RF se cumplen en la revisión del código y en un recorrido manual en Android.
- `dart format .` no deja cambios y `flutter analyze` termina sin errores ni avisos.

## Dudas abiertas
- Ninguna.
