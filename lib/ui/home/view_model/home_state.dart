/// Estado inmutable de la pantalla de inicio.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/mensaje_dia.dart';
import '../../../domain/models/streak.dart';

part 'home_state.freezed.dart';

enum HomeStatus { loading, ready, error }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.loading) HomeStatus status,
    @Default(Streak.empty) Streak streak,

    /// Instante de la última carga, del reloj del Cubit. Es el "hoy" de la
    /// racha y la fecha que se muestra (RF-1).
    DateTime? hoy,

    /// Mensaje del día (RF-8 a RF-11); `null` hasta la primera carga.
    MensajeDia? mensaje,
  }) = _HomeState;
}
