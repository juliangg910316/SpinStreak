/// Estado inmutable de la pantalla de inicio.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/streak.dart';

part 'home_state.freezed.dart';

enum HomeStatus { loading, ready, error }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.loading) HomeStatus status,
    @Default(Streak.empty) Streak streak,
  }) = _HomeState;
}
