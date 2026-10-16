/// Récords personales por sesión (spec 004).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';

part 'record_personal.freezed.dart';

/// Los cuatro récords, en el orden en que se muestran y se nombran (RF-1,
/// RF-10).
enum TipoRecord { tiempo, distancia, velocidadMax, pulsoMax }

@freezed
abstract class RecordPersonal with _$RecordPersonal {
  const factory RecordPersonal({
    required TipoRecord tipo,

    /// Sesión que tiene el récord (la más antigua si hay empate, RF-6), o
    /// `null` si ninguna sesión tiene ese dato ("Sin datos", RF-3, RF-4).
    Session? sesion,
  }) = _RecordPersonal;
}
