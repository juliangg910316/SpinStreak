# Spec 002 — Rachas
Estado: borrador

## Contexto y objetivo
La motivación principal de la app es la constancia: ver cuántos días seguidos se ha entrenado anima a no saltarse el siguiente. La pantalla de inicio muestra la racha actual, la mejor racha y el total de días entrenados.

> Ya existe una implementación inicial (cálculo de la racha y pantalla de inicio). Esta spec documenta el comportamiento esperado; la validación dirá qué falta o qué hay que corregir.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero ver mi racha actual al abrir la app para motivarme a mantenerla.
- HU-2. Como usuario, quiero ver mi mejor racha para tener un récord que superar.
- HU-3. Como usuario, quiero ver el total de días entrenados para valorar mi constancia aunque pierda la racha.

## Definiciones
- **Día entrenado**: día natural (fecha local del dispositivo) con al menos una sesión. Varias sesiones el mismo día cuentan como un solo día.
- **Racha actual**: número de días entrenados consecutivos que terminan hoy o ayer.
- **Mejor racha**: la secuencia de días entrenados consecutivos más larga del historial.
- **Total de días**: número de días entrenados distintos.

## Requisitos funcionales
- RF-1: EL SISTEMA muestra en la pantalla de inicio la racha actual, la mejor racha y el total de días entrenados.
- RF-2: EL SISTEMA cuenta como un solo día entrenado todas las sesiones de un mismo día.
- RF-3: MIENTRAS el último día entrenado sea hoy o ayer, EL SISTEMA muestra como racha actual el número de días consecutivos que terminan en ese día.
- RF-4: SI el último día entrenado es anterior a ayer, ENTONCES EL SISTEMA muestra la racha actual como 0.
- RF-5: EL SISTEMA conserva la mejor racha aunque la racha actual vuelva a 0.
- RF-6: CUANDO se registra, edita o borra una sesión, EL SISTEMA actualiza la racha sin reiniciar la app.
- RF-7: EL SISTEMA calcula los días con la fecha local del dispositivo, no con UTC.
- RF-8: SI no hay ninguna sesión, ENTONCES EL SISTEMA muestra los tres contadores a 0.

## Requisitos no funcionales
- Un cambio de hora (horario de verano) no altera la racha.
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- La pantalla de inicio es la primera que se muestra al abrir la app.
- Accesos desde el inicio al resto de pantallas: pendiente de definir (ver dudas abiertas).

## Casos límite
- Hoy aún no se ha entrenado, pero ayer sí: la racha sigue viva.
- Hueco de exactamente un día: la racha vuelve a 0.
- Varias sesiones el mismo día.
- Día del cambio de hora (23 o 25 horas).
- Se borra la única sesión de un día dentro de una racha.

## Fuera de alcance
- Comodines o días de descanso (la racha es estrictamente diaria).
- Notificaciones de racha en riesgo (v2).
- Insignias por hitos (v2).

## Criterios de finalización
- Todos los RF se cumplen en la revisión del código y en un recorrido manual en Android.
- `flutter analyze` sin errores ni avisos.

## Dudas abiertas
- [NECESITA ACLARACIÓN] ¿Se muestra algún mensaje cuando hoy aún no se ha entrenado y la racha está en riesgo (p. ej. "Entrena hoy para mantener tu racha")?
- [NECESITA ACLARACIÓN] ¿Qué se muestra cuando la racha actual es 0 (mensaje de ánimo, solo el número)?
- [NECESITA ACLARACIÓN] Navegación: ¿qué accesos tiene el inicio (registrar sesión, historial, calendario, récords) y de qué forma (botones, barra inferior, menú)?
