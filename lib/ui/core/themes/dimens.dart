/// Medidas repetidas del diseño (spec 005): márgenes, radios y tamaños.
library;

abstract final class Dimens {
  /// Margen lateral de las pantallas y separación entre bloques.
  static const margen = 16.0;

  /// Radios de las esquinas.
  static const radioCampo = 12.0;
  static const radioBoton = 16.0;
  static const radioTarjeta = 20.0;
  static const radioGrande = 28.0;

  /// Alto de los botones principales ("Guardar", botón flotante).
  static const altoBoton = 56.0;

  /// Zona táctil mínima (RNF-4).
  static const tactilMinimo = 44.0;

  /// Caja del icono de los avisos y círculo de un día del calendario.
  static const cajaIcono = 40.0;
  static const circuloDia = 40.0;
}
