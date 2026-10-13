/// View model del historial de sesiones.
///
/// Pide las sesiones al repositorio con [cargar] y las agrupa por día con la
/// lógica del dominio (`agruparPorDia`). No contiene reglas de negocio.
library;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/session_repository.dart';
import '../../../domain/session_history.dart';
import '../../../utils/result.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({required this._sessionRepository})
    : super(const HistoryState());

  final SessionRepository _sessionRepository;

  /// Carga (o recarga) el historial. Se llama al abrir la pantalla y al
  /// volver de editar o borrar una sesión. Al recargar no vuelve a `loading`,
  /// para que la lista no parpadee.
  Future<void> cargar() async {
    final result = await _sessionRepository.getSessions();
    if (isClosed) return;

    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            status: HistoryStatus.ready,
            dias: agruparPorDia(value),
          ),
        );
      case Error():
        emit(state.copyWith(status: HistoryStatus.error));
    }
  }
}
