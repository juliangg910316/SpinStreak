/// Estado inmutable de la pantalla de inicio.
library;

import '../../../domain/streak_calculator.dart';

enum HomeStatus { loading, ready, error }

class HomeState {
  const HomeState({
    this.status = HomeStatus.loading,
    this.streak = Streak.empty,
  });

  final HomeStatus status;
  final Streak streak;

  HomeState copyWith({HomeStatus? status, Streak? streak}) =>
      HomeState(status: status ?? this.status, streak: streak ?? this.streak);
}
