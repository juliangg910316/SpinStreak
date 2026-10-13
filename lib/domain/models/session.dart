/// Modelo de dominio de una sesión de entrenamiento.
///
/// Es independiente de la persistencia: el repositorio convierte las filas de
/// drift en este modelo, así que la UI y la lógica de negocio no dependen de
/// la base de datos.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';

@freezed
abstract class Session with _$Session {
  const Session._();

  const factory Session({
    required int id,

    /// Momento del registro. Lo asigna la app y no se puede cambiar.
    required DateTime fecha,

    /// Día local del registro (sin hora). Es la clave de la racha y del
    /// agrupado del historial.
    required DateTime dia,

    required Duration tiempo,

    /// Kilómetros recorridos en la sesión (hasta 2 decimales).
    required double distancia,

    /// Estimación de la bici, en kcal.
    required int calorias,

    /// Total acumulado de la bici, en km (hasta 2 decimales).
    required double odometro,

    /// km/h, entero. Opcional.
    int? velocidadMax,

    /// Pulsaciones por minuto. Opcional.
    int? pulsoMax,

    String? nota,
  }) = _Session;

  /// Velocidad media en km/h (dato derivado, no se almacena).
  double get velocidadMedia {
    final horas = tiempo.inSeconds / Duration.secondsPerHour;
    return horas == 0 ? 0 : distancia / horas;
  }
}
