/// Estado inmutable de la pantalla de récords (spec 004).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/record_personal.dart';

part 'records_state.freezed.dart';

enum RecordsStatus { loading, ready, error }

@freezed
abstract class RecordsState with _$RecordsState {
  const factory RecordsState({
    @Default(RecordsStatus.loading) RecordsStatus status,

    /// Los cuatro récords, en el orden de `TipoRecord` (RF-1).
    @Default([]) List<RecordPersonal> records,

    /// No hay ninguna sesión (RF-4).
    @Default(false) bool sinSesiones,
  }) = _RecordsState;
}
