/// Estado inmutable de la pantalla de historial.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/dia_historial.dart';

part 'history_state.freezed.dart';

enum HistoryStatus { loading, ready, error }

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(HistoryStatus.loading) HistoryStatus status,

    /// Días con sesiones, del más reciente al más antiguo.
    @Default([]) List<DiaHistorial> dias,
  }) = _HistoryState;
}
