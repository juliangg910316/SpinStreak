/// Estado inmutable del formulario de registro y edición de sesiones.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/entrada_sesion.dart';
import '../../../domain/models/session.dart';
import '../../../domain/session_validator.dart';

part 'session_form_state.freezed.dart';

enum ModoFormulario { nuevo, edicion }

enum SessionFormStatus {
  /// El usuario está rellenando el formulario.
  editando,

  /// Guardando o borrando: el botón de guardar queda desactivado.
  guardando,

  /// Estados finales: la pantalla se cierra con este resultado.
  guardada,
  actualizada,
  borrada,

  /// Falló la operación; la entrada se conserva (RC-1).
  error,
}

/// Operación que falló, para que la UI elija el mensaje de error.
enum OperacionFallida { guardar, borrar }

@freezed
abstract class SessionFormState with _$SessionFormState {
  const SessionFormState._();

  const factory SessionFormState({
    @Default(ModoFormulario.nuevo) ModoFormulario modo,

    /// Sesión que se edita; `null` al registrar una nueva.
    Session? original,

    @Default(EntradaSesion()) EntradaSesion entrada,

    /// Valores al abrir el formulario, para saber si hay cambios (RF-16).
    @Default(EntradaSesion()) EntradaSesion entradaInicial,

    /// Errores de validación por campo (RF-3, RF-4).
    @Default({}) Map<CampoSesion, ErrorCampo> errores,

    @Default(SessionFormStatus.editando) SessionFormStatus status,

    /// Solo con `status == error`.
    OperacionFallida? fallo,
  }) = _SessionFormState;

  /// La entrada actual difiere de la inicial (comparación por valor).
  bool get hayCambios => entrada != entradaInicial;

  /// Guardada, actualizada o borrada: la pantalla debe cerrarse.
  bool get terminado =>
      status == SessionFormStatus.guardada ||
      status == SessionFormStatus.actualizada ||
      status == SessionFormStatus.borrada;
}
