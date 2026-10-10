/// View model de la pantalla de inicio.
///
/// Escucha los días entrenados del repositorio y los convierte en
/// [HomeState] usando la lógica del dominio. No contiene reglas de negocio.
library;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/session_repository.dart';
import '../../../domain/streak_calculator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required SessionRepository sessionRepository,
    this._now = DateTime.now,
  }) : super(const HomeState()) {
    _subscription = sessionRepository.watchTrainedDays().listen(
      _onTrainedDays,
      onError: (Object _) => emit(state.copyWith(status: HomeStatus.error)),
    );
  }

  final DateTime Function() _now;
  late final StreamSubscription<List<DateTime>> _subscription;

  void _onTrainedDays(List<DateTime> days) {
    emit(
      state.copyWith(
        status: HomeStatus.ready,
        streak: calculateStreak(days, _now()),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
