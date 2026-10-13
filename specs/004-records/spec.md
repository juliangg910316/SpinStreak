# Spec 004 — Récords personales
Estado: borrador

## Contexto y objetivo
Superar las propias marcas es otra fuente de motivación. La app muestra los mejores valores alcanzados en una sesión.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero ver mis récords personales para saber qué marcas puedo superar.
- HU-2. Como usuario, quiero saber cuándo conseguí cada récord.

## Definiciones
- **Récord**: el valor más alto de un parámetro en una sola sesión (no la suma de un día).
- Tipos de los valores (spec 001):
  - tiempo en horas, minutos y segundos, hasta 5:00:00;
  - distancia en km, hasta 2 decimales;
  - velocidad máxima en km/h, **entera**;
  - pulso máximo en ppm, entero.

## Requisitos funcionales
- RF-1: EL SISTEMA muestra cuatro récords: sesión más larga (tiempo), mayor distancia, mayor velocidad máxima y mayor pulso máximo.
- RF-2: EL SISTEMA muestra junto a cada récord la fecha de la sesión en la que se consiguió.
- RF-3: SI ninguna sesión tiene velocidad máxima o pulso máximo, ENTONCES EL SISTEMA muestra ese récord como "Sin datos".
- RF-4: SI no hay ninguna sesión, ENTONCES EL SISTEMA muestra todos los récords como "Sin datos".
- RF-5: CUANDO se registra, edita o borra una sesión, EL SISTEMA recalcula los récords sin reiniciar la app.
- RF-6: SI dos sesiones empatan en un récord, ENTONCES EL SISTEMA muestra la fecha de la más antigua (la primera vez que se consiguió).

## Requisitos no funcionales
- Cada valor se muestra con su unidad y el mismo formato que el historial de la spec 001:
  - tiempo como "1:05:20";
  - distancia como "12,34 km";
  - velocidad máxima como "32 km/h";
  - pulso como "160 ppm";
  - fecha en español, como "sábado, 10 de octubre de 2026".
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- Pendiente de definir: depende de si los récords tienen pantalla propia o van en el inicio (ver dudas abiertas) y de la duda de navegación de la spec 002: más botones en el inicio o barra inferior.
- Contexto de la spec 001: el inicio ya tiene el botón flotante "Registrar sesión" y el botón "Historial". Tras guardar una sesión se vuelve al inicio con el mensaje "Sesión guardada".

## Casos límite
- Se borra o edita la sesión que tenía un récord: el récord pasa a la siguiente mejor sesión.
- Sesiones sin velocidad máxima ni pulso (campos opcionales).
- Varias sesiones el mismo día: cada una compite por separado.
- La velocidad máxima y el pulso son enteros, así que los empates son frecuentes: se aplica RF-6.
- Se edita una sesión: su fecha no cambia (spec 001, RF-14), pero sus valores sí, así que puede ganar o perder un récord.

## Fuera de alcance
- Récords por día, semana o mes.
- Récords de calorías o de velocidad media.
- Insignias y celebraciones (v2).

## Criterios de finalización
- Todos los RF se cumplen en la revisión del código y en un recorrido manual en Android.
- `dart format .` no deja cambios y `flutter analyze` termina sin errores ni avisos.

## Dudas abiertas
- [NECESITA ACLARACIÓN] ¿Se avisa al usuario cuando bate un récord al guardar una sesión? Si se avisa, ¿cómo, dado que tras guardar se vuelve al inicio con "Sesión guardada" (spec 001)? Por ejemplo, otro mensaje "¡Nuevo récord de distancia!". ¿Y al editar una sesión?
- [NECESITA ACLARACIÓN] ¿Los récords van en una pantalla propia o en la pantalla de inicio?
