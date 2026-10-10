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
- **Día entrenado**: el mismo concepto que en la spec 002.

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

## Casos límite
- Sin sesiones: el calendario se muestra vacío, sin errores.
- Varias sesiones el mismo día: el día se marca una sola vez.
- Días anteriores a la primera sesión.

## Fuera de alcance
- Editar sesiones desde el calendario.
- Gráficas de evolución (v2).

## Criterios de finalización
- Todos los RF se cumplen en un recorrido manual en Android.
- `flutter analyze` sin errores ni avisos.

## Dudas abiertas
- [NECESITA ACLARACIÓN] ¿Vista mensual (con navegación entre meses) o heatmap anual estilo GitHub?
- [NECESITA ACLARACIÓN] ¿El color es binario (entrenado / no entrenado) o con intensidad según la distancia o el tiempo?
- [NECESITA ACLARACIÓN] ¿Se marcan los días de la racha actual de forma especial?
- [NECESITA ACLARACIÓN] Navegación: ¿desde dónde se abre el calendario? Al pulsar un día, ¿se muestran sus sesiones en la misma pantalla o se abre el historial de ese día?
