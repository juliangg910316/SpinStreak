/// View model del formulario de registro y edición de sesiones.
///
/// Guarda lo que escribe el usuario, valida con `validarSesion` (domain) y
/// llama al repositorio. No calcula reglas de negocio: la fecha la pone el
/// repositorio y las reglas de los campos están en domain.
library;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/session_repository.dart';
import '../../../domain/models/entrada_sesion.dart';
import '../../../domain/models/record_personal.dart';
import '../../../domain/models/session.dart';
import '../../../domain/records_calculator.dart';
import '../../../domain/session_validator.dart';
import '../../../utils/result.dart';
import 'session_form_state.dart';

class SessionFormCubit extends Cubit<SessionFormState> {
  /// Sin [original], registra una sesión nueva; con ella, la edita.
  SessionFormCubit({required this._sessionRepository, Session? original})
    : super(_estadoInicial(original));

  final SessionRepository _sessionRepository;

  static SessionFormState _estadoInicial(Session? original) {
    if (original == null) return const SessionFormState();
    final entrada = _entradaDesde(original);
    return SessionFormState(
      modo: ModoFormulario.edicion,
      original: original,
      entrada: entrada,
      entradaInicial: entrada,
    );
  }

  /// Cambia el texto de un campo numérico y borra su error.
  /// El tiempo se cambia con [cambiarTiempo].
  void cambiarCampo(CampoSesion campo, String texto) {
    final e = state.entrada;
    final entrada = switch (campo) {
      CampoSesion.distancia => e.copyWith(distancia: texto),
      CampoSesion.calorias => e.copyWith(calorias: texto),
      CampoSesion.odometro => e.copyWith(odometro: texto),
      CampoSesion.velocidadMax => e.copyWith(velocidadMax: texto),
      CampoSesion.pulsoMax => e.copyWith(pulsoMax: texto),
      CampoSesion.tiempo => e,
    };
    _actualizar(entrada, campo);
  }

  void cambiarTiempo(Duration tiempo) =>
      _actualizar(state.entrada.copyWith(tiempo: tiempo), CampoSesion.tiempo);

  void cambiarNota(String nota) =>
      _actualizar(state.entrada.copyWith(nota: nota), null);

  void _actualizar(EntradaSesion entrada, CampoSesion? campo) {
    emit(
      state.copyWith(
        entrada: entrada,
        errores: {...state.errores}..remove(campo),
        status: SessionFormStatus.editando,
        fallo: null,
      ),
    );
  }

  /// Valida y registra (modo nuevo) o actualiza (modo edición). Si la
  /// entrada no es válida, emite los errores y no guarda.
  Future<void> guardar() async {
    if (state.status == SessionFormStatus.guardando || state.terminado) return;

    switch (validarSesion(state.entrada)) {
      case Invalida(:final errores):
        emit(
          state.copyWith(
            errores: errores,
            status: SessionFormStatus.editando,
            fallo: null,
          ),
        );
      case Valida(:final datos):
        emit(
          state.copyWith(
            errores: const {},
            status: SessionFormStatus.guardando,
            fallo: null,
          ),
        );
        final original = state.original;
        // Spec 004, RF-10 a RF-12: solo al registrar se comparan los datos
        // con las sesiones anteriores. Si no se pueden leer, se guarda igual
        // y no se avisa (RC-1: guardar es lo importante).
        var batidos = const <TipoRecord>[];
        if (original == null) {
          if (await _sessionRepository.getSessions() case Ok(:final value)) {
            batidos = recordsBatidos(value, datos);
          }
        }
        final result = original == null
            ? await _sessionRepository.addSession(datos)
            : await _sessionRepository.updateSession(original.id, datos);
        if (isClosed) return;
        emit(switch (result) {
          Ok() => state.copyWith(
            status: original == null
                ? SessionFormStatus.guardada
                : SessionFormStatus.actualizada,
            recordsBatidos: batidos,
          ),
          // RC-1: la entrada se conserva para reintentar.
          Error() => state.copyWith(
            status: SessionFormStatus.error,
            fallo: OperacionFallida.guardar,
          ),
        });
    }
  }

  /// Borra la sesión que se edita. La confirmación (RF-15) la pide la
  /// pantalla antes de llamar a este método.
  Future<void> borrar() async {
    final original = state.original;
    if (original == null ||
        state.status == SessionFormStatus.guardando ||
        state.terminado) {
      return;
    }

    emit(state.copyWith(status: SessionFormStatus.guardando, fallo: null));
    final result = await _sessionRepository.deleteSession(original.id);
    if (isClosed) return;
    emit(switch (result) {
      Ok() => state.copyWith(status: SessionFormStatus.borrada),
      Error() => state.copyWith(
        status: SessionFormStatus.error,
        fallo: OperacionFallida.borrar,
      ),
    });
  }

  /// Valores de [sesion] como texto del formulario, con coma decimal y sin
  /// separador de miles, para que `validarSesion` los acepte tal cual.
  static EntradaSesion _entradaDesde(Session sesion) => EntradaSesion(
    tiempo: sesion.tiempo,
    distancia: _decimal(sesion.distancia),
    calorias: '${sesion.calorias}',
    odometro: _decimal(sesion.odometro),
    velocidadMax: sesion.velocidadMax?.toString() ?? '',
    pulsoMax: sesion.pulsoMax?.toString() ?? '',
    nota: sesion.nota ?? '',
  );

  /// 12.0 → "12", 12.5 → "12,5".
  static String _decimal(double valor) => valor == valor.truncateToDouble()
      ? valor.toInt().toString()
      : valor.toString().replaceFirst('.', ',');
}
