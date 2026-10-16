/// View model de los récords personales (spec 004).
///
/// Pide las sesiones al repositorio con [cargar] y calcula los récords con la
/// lógica del dominio (`calcularRecords`). No contiene reglas de negocio.
library;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/session_repository.dart';
import '../../../domain/records_calculator.dart';
import '../../../utils/result.dart';
import 'records_state.dart';

class RecordsCubit extends Cubit<RecordsState> {
  RecordsCubit({required this._sessionRepository})
    : super(const RecordsState());

  final SessionRepository _sessionRepository;

  /// Carga (o recarga) los récords. Se llama al abrir la pantalla y al
  /// volver de editar o borrar la sesión de un récord (RF-5, RF-9).
  Future<void> cargar() async {
    final result = await _sessionRepository.getSessions();
    if (isClosed) return;

    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            status: RecordsStatus.ready,
            records: calcularRecords(value),
            sinSesiones: value.isEmpty,
          ),
        );
      case Error():
        // RF-7.
        emit(state.copyWith(status: RecordsStatus.error));
    }
  }
}
