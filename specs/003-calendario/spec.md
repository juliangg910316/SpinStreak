# Spec 003 — Calendario de días entrenados
Estado: implementada

## Contexto y objetivo
Un calendario mensual con los días entrenados permite ver la constancia de un vistazo. Un calendario lleno motiva y hace más difícil saltarse un día. Desde el calendario también se consultan, y se pueden corregir, las sesiones de un día concreto.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero ver en un calendario mensual qué días he entrenado para ver mi constancia de un vistazo.
- HU-2. Como usuario, quiero moverme a meses anteriores para revisar mi constancia pasada.
- HU-3. Como usuario, quiero consultar las sesiones de un día concreto desde el calendario y corregirlas si hace falta.

## Definiciones
- **Día entrenado**: el mismo concepto que en la spec 002. El día de una sesión se fija al guardarla y no cambia al editarla (spec 001), el mismo criterio que agrupa el historial.
- **Día seleccionado**: el día cuyas sesiones (o, si es hoy y no tiene, el mensaje de RF-16) se muestran debajo del calendario. Es hoy, o un día entrenado que el usuario ha pulsado. En el mes de hoy siempre hay un día seleccionado.
- **Hoy**: el día local del dispositivo en el momento en que se abre o se actualiza el calendario.

## Requisitos funcionales

### Vista del mes
- RF-1: EL SISTEMA muestra un calendario mensual en forma de cuadrícula de lunes a domingo, con el nombre del mes y el año en español (p. ej. "octubre de 2026"), y lo abre en el mes de hoy.
- RF-2: CUANDO el usuario pulsa la flecha ‹, EL SISTEMA muestra el mes anterior; CUANDO pulsa ›, muestra el mes siguiente.
- RF-3: MIENTRAS se muestre el mes de hoy, EL SISTEMA no permite avanzar al mes siguiente.
- RF-4: EL SISTEMA marca cada día entrenado con un círculo de color y deja sin color los días no entrenados. Todos los días entrenados tienen el mismo aspecto, sin intensidad según distancia o tiempo y sin distinguir la racha actual.
- RF-5: EL SISTEMA marca el día de hoy de forma distinta al resto, también cuando hoy está entrenado.
- RF-6: EL SISTEMA no muestra los días futuros como entrenados ni como fallados.

### Sesiones de un día
- RF-15: CUANDO se abre el calendario, o el usuario vuelve al mes de hoy, EL SISTEMA selecciona el día de hoy, tenga o no sesiones.
- RF-7: CUANDO el usuario pulsa un día entrenado o el día de hoy, EL SISTEMA lo resalta como día seleccionado y muestra debajo del calendario sus sesiones con el mismo formato que el historial (spec 001, RF-10 y RF-11): la fecha y los totales de distancia, tiempo y calorías del día, el número de sesiones si hay más de una, y por sesión su hora, tiempo, distancia, velocidad media y calorías.
- RF-16: MIENTRAS el día seleccionado sea hoy y no tenga sesiones, EL SISTEMA muestra debajo del calendario la fecha de hoy y, debajo, el mensaje "Hoy aún no has entrenado. Registra una sesión con «Registrar sesión» en el inicio."
- RF-8: CUANDO el usuario pulsa un día no entrenado que no es hoy, o un día futuro, EL SISTEMA no cambia nada.
- RF-9: MIENTRAS no haya día seleccionado (solo puede pasar en un mes distinto del de hoy), EL SISTEMA muestra debajo del calendario el texto "Toca un día marcado para ver sus sesiones."
- RF-10: CUANDO el usuario cambia de mes, EL SISTEMA quita la selección de día, salvo al llegar al mes de hoy, donde selecciona hoy (RF-15).
- RF-11: CUANDO el usuario toca una sesión del día seleccionado, EL SISTEMA abre la edición de la spec 001 ("Editar sesión", con "Borrar").
- RF-12: CUANDO el usuario vuelve de editar o borrar una sesión, EL SISTEMA actualiza el calendario y las sesiones del día seleccionado y muestra "Sesión actualizada" o "Sesión borrada". Si el día seleccionado ya no tiene sesiones, deja de marcarse y:
  - si es hoy, sigue seleccionado y muestra el mensaje de RF-16;
  - si es otro día del mes de hoy, se selecciona hoy;
  - si es un día de otro mes, se quita la selección (RF-9).

### Sin datos y errores
- RF-13: SI no hay ninguna sesión, ENTONCES EL SISTEMA muestra el calendario del mes de hoy, con hoy marcado y seleccionado (RF-16 debajo) y, encima, el mensaje "Aún no hay días entrenados. Registra tu primera sesión con «Registrar sesión» en el inicio." (RC-2).
- RF-14: SI falla la carga de las sesiones, ENTONCES EL SISTEMA muestra "No se pudo cargar el calendario." en lugar del calendario.

## Requisitos no funcionales
- Las semanas empiezan en lunes, con las iniciales de los días en español (L, M, X, J, V, S, D).
- Cada día de la cuadrícula se puede pulsar con comodidad con el dedo.
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- **Inicio → Calendario**: botón "Calendario" debajo de los contadores, con el mismo estilo que "Historial" (spec 002).
- **Calendario → Editar sesión**: tocar una sesión del día seleccionado abre la edición de la spec 001; al volver, se aplica RF-12.
- **Calendario → Inicio**: con "Atrás". El inicio se actualiza al volver (spec 002, RF-6).

## Casos límite
- Varias sesiones el mismo día: el día se marca una sola vez y, al pulsarlo, se listan todas con sus totales.
- Hoy entrenado: se ve a la vez la marca de hoy y el círculo de día entrenado.
- Meses anteriores a la primera sesión: se pueden visitar y se muestran sin días marcados.
- Meses de 28, 29, 30 o 31 días y meses que empiezan cualquier día de la semana (p. ej. febrero de 2028, bisiesto).
- Se edita una sesión: su día no cambia (spec 001, RF-14), así que la marca del día no varía. Los totales del día seleccionado sí se actualizan.
- Hoy sin sesiones: está seleccionado al abrir y se puede volver a pulsar, aunque no tenga círculo (RF-7, RF-15, RF-16).
- Se borra la única sesión del día seleccionado: el día deja de marcarse; la selección sigue en hoy, pasa a hoy o se quita según RF-12.
- Se borra la última sesión que queda: se muestra el mensaje de RF-13 y hoy queda seleccionado con el mensaje de RF-16.
- Día del cambio de hora: las sesiones siguen en su día (se usa el día guardado al registrar).
- El calendario abierto de un día para otro: "hoy" se actualiza al volver de editar o al abrir de nuevo el calendario. Si el día seleccionado era el "hoy" anterior y no tiene sesiones, se aplica RF-12 como a cualquier otro día.

## Fuera de alcance
- Heatmap anual o resumen del año.
- Intensidad de color según distancia o tiempo.
- Marcar de forma especial los días de la racha actual.
- Registrar sesiones desde el calendario (se registran desde el inicio).
- Ver meses futuros.
- Gráficas de evolución (v2).

## Criterios de finalización
- Todos los RF se cumplen en un recorrido manual en Android.
- `dart format .` no deja cambios y `flutter analyze` termina sin errores ni avisos.

## Dudas abiertas
- Ninguna.
