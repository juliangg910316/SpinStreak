# Spec 001 — Registro de sesiones
Estado: implementada

## Contexto y objetivo
Los datos de la pantalla de la bici estática se pierden al apagarla. El usuario necesita copiarlos a la app al terminar cada sesión, de forma rápida, y poder consultarlos, corregirlos o borrarlos después. Es la base de todo lo demás: rachas, calendario y récords leen estos datos.

## Usuarios
- El autor: un único usuario que entrena en su bici estática y registra sus sesiones a mano.

## Historias de usuario
- HU-1. Como usuario, quiero registrar una sesión con los datos de la bici para no perderlos.
- HU-2. Como usuario, quiero saber qué significa cada parámetro para entender mis datos.
- HU-3. Como usuario, quiero ver mis sesiones agrupadas por día, con sus totales, para revisar mi historial.
- HU-4. Como usuario, quiero corregir o borrar una sesión mal introducida, aunque sea de un día anterior.

## Definiciones
- **Sesión**: un entrenamiento registrado, con la fecha y hora del momento en que se guarda.
- **Campos obligatorios**: tiempo, distancia, calorías y odómetro.
- **Campos opcionales**: velocidad máxima, pulso máximo y nota.
- **Rangos válidos**:

| Campo | Rango válido | Decimales |
| --- | --- | --- |
| Tiempo | de 00:00:01 a 05:00:00 (horas, minutos y segundos) | — |
| Distancia | más de 0 y hasta 200 km | hasta 2 |
| Calorías | de 0 a 5.000 kcal | ninguno |
| Odómetro | de 0 a 999.999 km | hasta 2 |
| Velocidad máxima (opcional) | de 1 a 100 km/h | ninguno |
| Pulso máximo (opcional) | de 40 a 240 ppm | ninguno |

## Requisitos funcionales

### Registro
- RF-1: CUANDO el usuario guarda una sesión con todos los campos obligatorios válidos, EL SISTEMA la registra con la fecha y hora actuales del dispositivo.
- RF-2: EL SISTEMA no permite elegir ni modificar la fecha de una sesión; en la edición la muestra solo como lectura.
- RF-3: SI falta algún campo obligatorio, ENTONCES EL SISTEMA no guarda la sesión e indica qué campo falta.
- RF-4: SI un valor no es numérico, está fuera de su rango válido o tiene más decimales de los permitidos, ENTONCES EL SISTEMA no guarda la sesión e indica el campo y el rango o formato esperado.
- RF-5: EL SISTEMA permite introducir el tiempo solo mediante un selector de horas, minutos y segundos (no como texto libre), que no deja elegir valores por encima de 05:00:00.
- RF-6: CUANDO el usuario deja vacíos la velocidad máxima, el pulso máximo o la nota, EL SISTEMA guarda la sesión sin ellos.
- RF-7: EL SISTEMA acepta tanto la coma como el punto como separador decimal en los campos con decimales.
- RF-8: CUANDO el usuario pulsa la ayuda ⓘ de un parámetro, EL SISTEMA muestra qué significa y para qué sirve, con el texto del glosario de `docs/ESPECIFICACION.md`.

### Historial
- RF-9: EL SISTEMA muestra el historial de sesiones de la más reciente a la más antigua, agrupado por día.
- RF-10: EL SISTEMA muestra en la cabecera de cada día su fecha y los totales de distancia, tiempo y calorías de ese día, y el número de sesiones cuando hay más de una.
- RF-11: EL SISTEMA muestra en cada sesión del historial su hora, tiempo, distancia, velocidad media (distancia / tiempo, en km/h con un decimal) y calorías.
- RF-12: SI no hay ninguna sesión registrada, ENTONCES EL SISTEMA muestra en el historial un mensaje que invita a registrar la primera sesión (RC-2).

### Edición y borrado
- RF-13: EL SISTEMA permite editar y borrar cualquier sesión, sea del día actual o de días anteriores.
- RF-14: CUANDO el usuario edita una sesión, EL SISTEMA aplica las mismas reglas de los campos que al registrar (RF-3 a RF-7) y conserva su fecha y hora originales.
- RF-15: CUANDO el usuario pide borrar una sesión, EL SISTEMA pide confirmación y solo la borra si el usuario confirma.
- RF-16: CUANDO el usuario intenta salir del formulario con cambios sin guardar, EL SISTEMA pregunta si quiere descartarlos y solo sale si confirma.

## Requisitos no funcionales
- Registrar una sesión lleva menos de 30 segundos: el formulario se abre con un toque desde el inicio, el tiempo se elige con el selector y los demás campos numéricos usan teclado numérico.
- Los datos se guardan solo en el dispositivo.
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- **Inicio → Registrar sesión**: un botón flotante "Registrar sesión" en la pantalla de inicio abre el formulario vacío.
- **Inicio → Historial**: un botón "Historial" en la pantalla de inicio.
- **Historial → Editar sesión**: tocar una sesión abre el mismo formulario con sus datos y el título "Editar sesión".
- **Borrar**: botón con el icono de papelera (descripción accesible "Borrar") en la barra superior del formulario de edición, con confirmación (RF-15). Aspecto según la spec 005.
- **Tras guardar una sesión nueva**: vuelve al inicio, con la racha actualizada y el mensaje "Sesión guardada".
- **Tras editar o borrar**: vuelve al historial, actualizado, con el mensaje "Sesión actualizada" o "Sesión borrada".
- **Atrás desde el formulario**: si hay cambios sin guardar, aplica RF-16.

## Casos límite
- Varias sesiones el mismo día: se guardan todas y aparecen en el mismo grupo del historial, que suma sus totales.
- Tiempo 00:00:00 en el selector: no es válido (RF-4).
- Valores en el límite de su rango (p. ej. tiempo 05:00:00 o pulso 240): son válidos.
- Borrar la única sesión de un día: la racha puede romperse sin remedio, porque no se pueden registrar días pasados. Riesgo aceptado por el autor: basta con la confirmación de RF-15.
- Borrar la última sesión que queda: el historial muestra el mensaje de RF-12.
- Falla el guardado, la edición o el borrado: se aplica RC-1 (mensaje de error y se conservan los datos introducidos).

## Fuera de alcance
- Registrar sesiones de días pasados o cambiar la fecha de una sesión.
- Comprobar el odómetro contra otras sesiones; solo se valida su rango.
- Totales por semana y por mes, y diferencia de odómetro entre sesiones (v2).
- Importar o exportar datos (v2).
- Leer los datos de la bici por Bluetooth u OCR.
- Buscar o filtrar en el historial.
- Barra de navegación inferior.

## Criterios de finalización
- Todos los RF se cumplen en un recorrido manual en Android.
- `dart format .` no deja cambios y `flutter analyze` termina sin errores ni avisos.

## Dudas abiertas
- Ninguna.
