# SpinStreak

App para Android e iOS, hecha en Flutter, para registrar a diario los entrenamientos en **bicicleta estática** y mantener la motivación con **rachas de días consecutivos**, récords personales y progreso visible.

> Proyecto personal y de portafolio.

## Funcionalidades (MVP)

- Registro rápido de sesiones (menos de 30 s), copiando los datos a mano desde la pantalla de la bici.
- Ayuda ⓘ en cada parámetro, que explica qué significa.
- Historial agrupado por día.
- **Racha actual, mejor racha y total de días entrenados**.
- Calendario o heatmap de días entrenados.
- Récords personales: sesión más larga, mayor distancia, mayor velocidad máxima y mayor pulso.
- Datos 100 % locales.

## Datos de cada sesión

| Campo | Unidad | Obligatorio |
| --- | --- | --- |
| Tiempo | hh:mm:ss | Sí |
| Distancia | km | Sí |
| Calorías | kcal | Sí |
| Odómetro | km | Sí |
| Velocidad máxima | km/h | No |
| Pulso máximo | ppm | No |
| Nota | texto | No |

## Reglas de la racha

- Un día cuenta si tiene **al menos una sesión**. Varias sesiones en el mismo día cuentan como un solo día.
- Racha **estrictamente diaria**: sin comodines ni días de descanso.
- La racha actual sigue viva hasta las 23:59 del día siguiente al último entrenamiento.
- **Solo se registran sesiones del día actual**: la fecha la pone la app y no se puede cambiar.

El proyecto sigue **Spec-Driven Development**: visión en [`docs/ESPECIFICACION.md`](docs/ESPECIFICACION.md), principios en [`docs/constitution.md`](docs/constitution.md) y una spec por funcionalidad en [`specs/`](specs/).

## Desarrollo

```bash
flutter pub get
dart run build_runner build   # regenera el código de drift tras cambiar tablas
dart format .
flutter analyze
flutter run
```
