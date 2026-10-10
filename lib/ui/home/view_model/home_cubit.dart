/// View model de la pantalla de inicio.
///
/// Pide los días entrenados al repositorio con [cargar] y los convierte en
/// [HomeState] usando la lógica del dominio. No contiene reglas de negocio.
library;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/session_repository.dart';
import '../../../domain/streak_calculator.dart';
import '../../../utils/result.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this._sessionRepository, this._now = DateTime.now})
    : super(const HomeState());

  final SessionRepository _sessionRepository;
  final DateTime Function() _now;

  /// Carga (o recarga) la racha. Se llama al abrir la pantalla y después de
  /// cualquier acción que cambie las sesiones.
  Future<void> cargar() async {
    final result = await _sessionRepository.getTrainedDays();
    if (isClosed) return;

    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            status: HomeStatus.ready,
            streak: calculateStreak(value, _now()),
          ),
        );
      case Error():
        emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
