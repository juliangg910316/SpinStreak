/// Un mes del calendario listo para pintar (spec 003, RF-1 y RF-3 a RF-6).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mes_calendario.freezed.dart';

@freezed
abstract class MesCalendario with _$MesCalendario {
  const factory MesCalendario({
    /// Primer día del mes.
    required DateTime mes,

    /// Semanas de lunes a domingo, 7 celdas cada una. `null` es un hueco de
    /// relleno (días del mes anterior o del siguiente).
    required List<List<CeldaDia?>> semanas,

    /// Si se puede pasar al mes siguiente: falso en el mes de hoy (RF-3).
    required bool puedeAvanzar,
  }) = _MesCalendario;
}

/// Un día de la cuadrícula del calendario.
@freezed
abstract class CeldaDia with _$CeldaDia {
  const CeldaDia._();

  const factory CeldaDia({
    /// Día local (sin hora).
    required DateTime dia,

    /// Tiene al menos una sesión. Nunca es cierto en un día futuro (RF-6).
    required bool entrenado,

    /// Es el día de hoy (RF-5).
    required bool esHoy,

    /// Es posterior a hoy (RF-6).
    required bool esFuturo,
  }) = _CeldaDia;

  /// Se puede pulsar para seleccionarlo: está entrenado o es hoy, aunque no
  /// tenga sesiones (RF-7, RF-8).
  bool get seleccionable => entrenado || esHoy;
}
