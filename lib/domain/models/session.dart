/// Modelo de dominio de una sesión de entrenamiento.
///
/// Es independiente de la persistencia: el repositorio convierte las filas de
/// drift en este modelo, así que la UI y la lógica de negocio no dependen de
/// la base de datos.
class Session {
  const Session({
    required this.id,
    required this.fecha,
    required this.tiempo,
    required this.distancia,
    required this.calorias,
    required this.odometro,
    this.velocidadMax,
    this.pulsoMax,
    this.nota,
  });

  final int id;

  /// Momento del registro. Lo asigna la app y no se puede cambiar.
  final DateTime fecha;

  final Duration tiempo;

  /// Kilómetros recorridos en la sesión.
  final double distancia;

  /// Estimación de la bici, en kcal.
  final int calorias;

  /// Total acumulado de la bici, en km.
  final double odometro;

  /// km/h. Opcional.
  final double? velocidadMax;

  /// Pulsaciones por minuto. Opcional.
  final int? pulsoMax;

  final String? nota;

  /// Velocidad media en km/h (dato derivado, no se almacena).
  double get velocidadMedia {
    final horas = tiempo.inSeconds / Duration.secondsPerHour;
    return horas == 0 ? 0 : distancia / horas;
  }
}
