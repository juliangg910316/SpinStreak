/// Modelo de dominio con el resumen de la racha del usuario.
///
/// Lo calcula `calculateStreak` (`domain/streak_calculator.dart`).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak.freezed.dart';

@freezed
abstract class Streak with _$Streak {
  const factory Streak({
    /// Días consecutivos entrenados que terminan hoy o ayer.
    required int current,

    /// Racha más larga histórica.
    required int best,

    /// Total de días distintos con al menos una sesión.
    required int totalDays,
  }) = _Streak;

  /// Sin sesiones: los tres contadores a 0.
  static const empty = Streak(current: 0, best: 0, totalDays: 0);
}
