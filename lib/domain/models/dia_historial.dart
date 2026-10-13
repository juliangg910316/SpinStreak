/// Un día del historial: sus sesiones y los totales del día (RF-9, RF-10).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';

part 'dia_historial.freezed.dart';

@freezed
abstract class DiaHistorial with _$DiaHistorial {
  const DiaHistorial._();

  const factory DiaHistorial({
    /// Día local (sin hora), el mismo que usa la racha.
    required DateTime dia,

    /// Sesiones del día, de la más reciente a la más antigua.
    required List<Session> sesiones,

    required double distanciaTotal,
    required Duration tiempoTotal,
    required int caloriasTotal,
  }) = _DiaHistorial;

  int get numSesiones => sesiones.length;
}
