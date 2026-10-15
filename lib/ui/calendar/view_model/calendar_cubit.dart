/// View model del calendario de días entrenados (spec 003).
///
/// Pide las sesiones al repositorio con [cargar], las agrupa por día y
/// construye la cuadrícula del mes con la lógica del dominio
/// (`agruparPorDia`, `construirMes`). No contiene reglas de negocio.
library;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/session_repository.dart';
import '../../../domain/calendar_month.dart';
import '../../../domain/session_history.dart';
import '../../../utils/result.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required this._sessionRepository, this._now = DateTime.now})
    : super(const CalendarState());

  final SessionRepository _sessionRepository;
  final DateTime Function() _now;

  /// Carga (o recarga) el calendario. Se llama al abrir la pantalla y al
  /// volver de editar o borrar una sesión (RF-12). Conserva el mes visible;
  /// el día seleccionado lo decide `diaASeleccionar`. "Hoy" sale siempre del
  /// reloj inyectado.
  Future<void> cargar() async {
    final result = await _sessionRepository.getSessions();
    if (isClosed) return;

    switch (result) {
      case Ok(:final value):
        final hoy = _now();
        final dias = {for (final d in agruparPorDia(value)) d.dia: d};
        final mesVisible = state.mesVisible ?? DateTime(hoy.year, hoy.month);
        final diasEntrenados = dias.keys.toSet();
        emit(
          state.copyWith(
            status: CalendarStatus.ready,
            hoy: hoy,
            dias: dias,
            mesVisible: mesVisible,
            // RF-12, RF-15: al abrir, hoy; al recargar, se conserva o se
            // recoloca según el dominio.
            seleccionado: diaASeleccionar(
              previo: state.seleccionado,
              diasEntrenados: diasEntrenados,
              mesVisible: mesVisible,
              hoy: hoy,
            ),
            mes: construirMes(mesVisible, diasEntrenados, hoy),
          ),
        );
      case Error():
        emit(state.copyWith(status: CalendarStatus.error));
    }
  }

  /// Muestra el mes anterior y quita la selección (RF-2, RF-10).
  void mesAnterior() => _irAMes(-1);

  /// Muestra el mes siguiente; no hace nada en el mes de hoy. Al llegar al
  /// mes de hoy, selecciona hoy (RF-2, RF-3, RF-10, RF-15).
  void mesSiguiente() {
    if (state.mes?.puedeAvanzar ?? false) _irAMes(1);
  }

  /// Selecciona [dia] si es seleccionable (entrenado o hoy) en el mes
  /// visible; si no, no cambia nada (RF-7, RF-8).
  void seleccionarDia(DateTime dia) {
    final celda = state.mes?.semanas
        .expand((semana) => semana)
        .firstWhere(
          (c) => c != null && mismoDia(c.dia, dia),
          orElse: () => null,
        );
    if (celda == null || !celda.seleccionable) return;
    emit(state.copyWith(seleccionado: celda.dia));
  }

  void _irAMes(int desplazamiento) {
    final actual = state.mesVisible;
    final hoy = state.hoy;
    if (actual == null || hoy == null) return;

    final mesVisible = DateTime(actual.year, actual.month + desplazamiento);
    final diasEntrenados = state.dias.keys.toSet();
    emit(
      state.copyWith(
        mesVisible: mesVisible,
        seleccionado: diaASeleccionar(
          previo: null,
          diasEntrenados: diasEntrenados,
          mesVisible: mesVisible,
          hoy: hoy,
        ),
        mes: construirMes(mesVisible, diasEntrenados, hoy),
      ),
    );
  }
}
