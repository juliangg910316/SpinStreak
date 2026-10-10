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

## Requisitos funcionales
- RF-1: EL SISTEMA muestra cuatro récords: sesión más larga (tiempo), mayor distancia, mayor velocidad máxima y mayor pulso máximo.
- RF-2: EL SISTEMA muestra junto a cada récord la fecha de la sesión en la que se consiguió.
- RF-3: SI ninguna sesión tiene velocidad máxima o pulso máximo, ENTONCES EL SISTEMA muestra ese récord como "Sin datos".
- RF-4: SI no hay ninguna sesión, ENTONCES EL SISTEMA muestra todos los récords como "Sin datos".
- RF-5: CUANDO se registra, edita o borra una sesión, EL SISTEMA recalcula los récords sin reiniciar la app.
- RF-6: SI dos sesiones empatan en un récord, ENTONCES EL SISTEMA muestra la fecha de la más antigua (la primera vez que se consiguió).

## Requisitos no funcionales
- Cada valor se muestra con su unidad (km, km/h, ppm, hh:mm:ss).
- Se cumplen los requisitos comunes RC-1 a RC-3 de `docs/ESPECIFICACION.md`.

## Navegación
- Pendiente de definir: depende de si los récords tienen pantalla propia o van en el inicio (ver dudas abiertas).

## Casos límite
- Se borra o edita la sesión que tenía un récord: el récord pasa a la siguiente mejor sesión.
- Sesiones sin velocidad máxima ni pulso (campos opcionales).
- Varias sesiones el mismo día: cada una compite por separado.

## Fuera de alcance
- Récords por día, semana o mes.
- Récords de calorías o de velocidad media.
- Insignias y celebraciones (v2).

## Criterios de finalización
- Todos los RF se cumplen en la revisión del código y en un recorrido manual en Android.
- `flutter analyze` sin errores ni avisos.

## Dudas abiertas
- [NECESITA ACLARACIÓN] ¿Se avisa al usuario cuando bate un récord al guardar una sesión?
- [NECESITA ACLARACIÓN] ¿Los récords van en una pantalla propia o en la pantalla de inicio?
