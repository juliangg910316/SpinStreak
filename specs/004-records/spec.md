# Spec 004 — Récords personales
Estado: implementada

## Contexto y objetivo
Superar las propias marcas es otra fuente de motivación. La app muestra en una pantalla propia los mejores valores alcanzados en una sola sesión y celebra el momento en que se bate uno al registrar una sesión. Desde los récords también se puede corregir una marca mal copiada.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero ver mis récords personales para saber qué marcas puedo superar.
- HU-2. Como usuario, quiero saber cuándo conseguí cada récord.
- HU-3. Como usuario, quiero que la app me avise al registrar una sesión que bate un récord, para celebrarlo en el momento.
- HU-4. Como usuario, quiero abrir la sesión de un récord para corregirla si la copié mal.

## Definiciones
- **Récord**: el valor más alto de un parámetro en una sola sesión (no la suma de un día). Hay cuatro, en este orden:

  | Récord | Parámetro | Tipo (spec 001) |
  | --- | --- | --- |
  | Sesión más larga | Tiempo | Horas, minutos y segundos, hasta 5:00:00 |
  | Mayor distancia | Distancia | km, hasta 2 decimales |
  | Mayor velocidad máxima | Velocidad máxima (opcional) | km/h, entero |
  | Mayor pulso máximo | Pulso máximo (opcional) | ppm, entero |

- **Sesión del récord**: la sesión que tiene el valor del récord. Si varias empatan, la más antigua (la primera vez que se consiguió).
- **Batir un récord**: que una sesión nueva tenga un valor **estrictamente mayor** que el récord que había antes de registrarla. Igualarlo no lo bate. Si antes no había ninguna sesión con ese dato, no hay récord que batir.

## Requisitos funcionales

### Pantalla de récords
- RF-1: EL SISTEMA muestra en la pantalla "Récords" los cuatro récords, en el orden de la tabla de definiciones, cada uno con su nombre y su valor.
- RF-2: EL SISTEMA muestra junto a cada récord la fecha de su sesión.
- RF-3: SI ninguna sesión tiene velocidad máxima o pulso máximo, ENTONCES EL SISTEMA muestra ese récord como "Sin datos".
- RF-4: SI no hay ninguna sesión, ENTONCES EL SISTEMA muestra los cuatro récords como "Sin datos" y, encima, el mensaje "Aún no hay récords. Registra tu primera sesión con «Registrar sesión» en el inicio." (RC-2).
- RF-5: CUANDO se registra, edita o borra una sesión, EL SISTEMA recalcula los récords sin reiniciar la app.
- RF-6: SI dos o más sesiones empatan en un récord, ENTONCES EL SISTEMA muestra la fecha de la más antigua.
- RF-7: SI falla la carga de las sesiones, ENTONCES EL SISTEMA muestra "No se pudieron cargar los récords." en lugar de los récords.

### Corregir un récord
- RF-8: CUANDO el usuario toca un récord con valor, EL SISTEMA abre la edición de su sesión (spec 001: "Editar sesión", con "Borrar"). Un récord "Sin datos" no hace nada al tocarlo.
- RF-9: CUANDO el usuario vuelve de editar o borrar esa sesión, EL SISTEMA recalcula los récords y muestra "Sesión actualizada" o "Sesión borrada".

### Aviso de récord al registrar
- RF-10: CUANDO el usuario registra una sesión nueva que bate uno o más récords, EL SISTEMA muestra al volver al inicio, en lugar de "Sesión guardada" (spec 001):
  - con un récord: "Sesión guardada. ¡Nuevo récord de <récord>!";
  - con varios: "Sesión guardada. ¡Nuevos récords de <récord>, <récord> y <récord>!".

  Los récords se nombran "tiempo", "distancia", "velocidad máxima" y "pulso máximo", en el orden de la tabla de definiciones.
- RF-11: SI la sesión registrada no bate ningún récord (incluida la primera sesión de todas, y la primera con velocidad máxima o pulso máximo), ENTONCES EL SISTEMA muestra solo "Sesión guardada".
- RF-12: CUANDO el usuario edita una sesión, EL SISTEMA no muestra aviso de récord, aunque la sesión pase a tener uno.

## Requisitos no funcionales
- Cada valor se muestra con su unidad y el mismo formato que el historial de la spec 001:
  - tiempo como "1:05:20";
  - distancia como "12,34 km";
  - velocidad máxima como "32 km/h";
  - pulso como "160 ppm";
  - fecha en español, como "sábado, 10 de octubre de 2026".
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- **Inicio → Récords**: botón "Récords" debajo de "Calendario", con el mismo estilo (spec 002). Al volver, el inicio se actualiza (spec 002, RF-6).
- **Récords → Editar sesión**: tocar un récord con valor (RF-8); al volver se aplica RF-9.
- **Récords → Inicio**: con "Atrás".
- **Registrar sesión → Inicio**: el aviso de RF-10 sustituye a "Sesión guardada".

## Casos límite
- Se borra o edita la sesión de un récord: el récord pasa a la siguiente mejor sesión, o a "Sin datos" si ya no queda ninguna con ese dato.
- Sesiones sin velocidad máxima ni pulso (campos opcionales): no compiten en esos récords.
- Varias sesiones el mismo día: cada una compite por separado.
- La velocidad máxima y el pulso son enteros, así que los empates son frecuentes: se aplica RF-6, y un empate no bate el récord (no hay aviso).
- Se edita una sesión: su fecha no cambia (spec 001, RF-14), pero sus valores sí, así que puede ganar o perder un récord (sin aviso, RF-12).
- La primera sesión de todas, o la primera tras borrar todas: no avisa (RF-11).
- Se baten varios récords a la vez: un único mensaje con todos (RF-10).
- Falla el guardado de la sesión: se aplica RC-1 y no hay aviso de récord.

## Fuera de alcance
- Aviso de récord al editar una sesión.
- Récords por día, semana o mes.
- Récords de calorías o de velocidad media.
- Insignias, animaciones y celebraciones más allá del mensaje (v2).
- Historial de récords anteriores (solo se ve el récord actual).

## Criterios de finalización
- Todos los RF se cumplen en la revisión del código y en un recorrido manual en Android.
- `dart format .` no deja cambios y `flutter analyze` termina sin errores ni avisos.

## Dudas abiertas
- Ninguna.
