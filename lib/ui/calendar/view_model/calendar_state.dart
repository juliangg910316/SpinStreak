/// Estado inmutable de la pantalla del calendario (spec 003).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/dia_historial.dart';
import '../../../domain/models/mes_calendario.dart';

part 'calendar_state.freezed.dart';

enum CalendarStatus { loading, ready, error }

@freezed
abstract class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    @Default(CalendarStatus.loading) CalendarStatus status,

    /// Día de hoy según el reloj del Cubit en la última carga.
    DateTime? hoy,

    /// Primer día del mes que se muestra.
    DateTime? mesVisible,

    /// Días con sesiones, por día local.
    @Default({}) Map<DateTime, DiaHistorial> dias,

    /// Cuadrícula del mes visible, de `construirMes`.
    MesCalendario? mes,

    /// Día seleccionado (RF-7), o `null` si no hay ninguno.
    DateTime? seleccionado,
  }) = _CalendarState;

  /// No hay ninguna sesión (RF-13).
  bool get sinSesiones => dias.isEmpty;

  /// Sesiones y totales del día seleccionado, si lo hay.
  DiaHistorial? get diaSeleccionado =>
      seleccionado == null ? null : dias[seleccionado];
}
