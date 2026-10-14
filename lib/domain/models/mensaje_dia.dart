/// Mensaje del día que muestra el inicio (spec 002, RF-8 a RF-11).
///
/// `domain` decide qué situación es; el texto y el plural los compone la UI
/// (RC-3).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mensaje_dia.freezed.dart';

@freezed
sealed class MensajeDia with _$MensajeDia {
  /// No hay ninguna sesión (RF-8).
  const factory MensajeDia.bienvenida() = Bienvenida;

  /// Hoy ya hay al menos una sesión (RF-10).
  const factory MensajeDia.aSalvo() = ASalvo;

  /// Hoy no hay sesión y la racha sigue viva desde ayer (RF-9).
  const factory MensajeDia.riesgo({required int dias}) = Riesgo;

  /// Hay sesiones, pero la racha actual es 0 (RF-11).
  const factory MensajeDia.reiniciada({required int mejorRacha}) = Reiniciada;
}
