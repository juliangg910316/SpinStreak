# Spec 001 — Registro de sesiones
Estado: borrador

## Contexto y objetivo
Los datos de la pantalla de la bici estática se pierden al apagarla. El usuario necesita copiarlos a la app al terminar cada sesión, de forma rápida, y poder consultarlos, corregirlos o borrarlos después. Es la base de todo lo demás: rachas, calendario y récords leen estos datos.

## Usuarios
- El autor: un único usuario que entrena en su bici estática y registra sus sesiones a mano.

## Historias de usuario
- HU-1. Como usuario, quiero registrar una sesión con los datos de la bici para no perderlos.
- HU-2. Como usuario, quiero saber qué significa cada parámetro para entender mis datos.
- HU-3. Como usuario, quiero ver mis sesiones agrupadas por día para revisar mi historial.
- HU-4. Como usuario, quiero corregir o borrar una sesión mal introducida.

## Definiciones
- **Sesión**: un entrenamiento registrado, con la fecha y hora del momento en que se guarda.
- **Campos obligatorios**: tiempo, distancia, calorías y odómetro.
- **Campos opcionales**: velocidad máxima, pulso máximo y nota.

## Requisitos funcionales
- RF-1: CUANDO el usuario guarda una sesión con todos los campos obligatorios válidos, EL SISTEMA la registra con la fecha y hora actuales del dispositivo.
- RF-2: EL SISTEMA no permite elegir ni modificar la fecha de una sesión.
- RF-3: SI falta algún campo obligatorio, ENTONCES EL SISTEMA no guarda la sesión e indica qué campo falta.
- RF-4: SI un valor numérico no es válido (no numérico, negativo, o tiempo igual a cero), ENTONCES EL SISTEMA no guarda la sesión e indica el campo y el motivo.
- RF-5: CUANDO el usuario deja vacíos la velocidad máxima o el pulso máximo, EL SISTEMA guarda la sesión sin ellos y los muestra como "—".
- RF-6: CUANDO el usuario pulsa la ayuda ⓘ de un parámetro, EL SISTEMA muestra qué significa y para qué sirve (glosario de `docs/ESPECIFICACION.md`).
- RF-7: EL SISTEMA muestra el historial de sesiones de la más reciente a la más antigua, agrupado por día.
- RF-8: EL SISTEMA muestra en cada sesión su velocidad media (distancia / tiempo).
- RF-9: CUANDO el usuario edita una sesión, EL SISTEMA actualiza sus valores y conserva su fecha original.
- RF-10: CUANDO el usuario pide borrar una sesión, EL SISTEMA pide confirmación y solo la borra si el usuario confirma.

## Requisitos no funcionales
- Registrar una sesión lleva menos de 30 segundos (teclado numérico en los campos numéricos).
- Los datos se guardan solo en el dispositivo.
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- Pendiente de definir (ver dudas abiertas).

## Casos límite
- Varias sesiones el mismo día: se guardan todas y aparecen en el mismo grupo del historial.
- Un odómetro menor que el de la sesión anterior.
- Borrar la única sesión de un día: la racha puede romperse sin remedio, porque no se pueden registrar días pasados. Riesgo aceptado por el autor: basta con la confirmación de RF-10.
- Valores extremos (p. ej. pulso de 400 ppm o distancia de 500 km en una sesión).

## Fuera de alcance
- Registrar sesiones de días pasados.
- Importar o exportar datos (v2).
- Leer los datos de la bici por Bluetooth u OCR.

## Criterios de finalización
- Todos los RF se cumplen en un recorrido manual en Android.
- `flutter analyze` sin errores ni avisos.

## Dudas abiertas
- [NECESITA ACLARACIÓN] ¿Rangos máximos válidos por campo (pulso, velocidad, distancia, tiempo)?
- [NECESITA ACLARACIÓN] Si el odómetro es menor que el de la sesión anterior, ¿se bloquea o solo se avisa?
- [NECESITA ACLARACIÓN] ¿Se pueden editar o borrar sesiones de días anteriores? (Borrar puede romper una racha.)
- [NECESITA ACLARACIÓN] ¿El historial muestra totales por día (distancia, tiempo, calorías)?
- [NECESITA ACLARACIÓN] Navegación: ¿desde dónde se abre el formulario de registro (botón en el inicio, en el historial…) y cómo se llega al historial? ¿Qué pantalla se muestra después de guardar?
