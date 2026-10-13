/// Valores ya validados de una sesión, sin `id` ni `fecha`.
///
/// Lo produce la validación del formulario y lo reciben `addSession` y
/// `updateSession`. No lleva fecha porque la asigna el repositorio al
/// registrar y no cambia al editar.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_data.freezed.dart';

@freezed
abstract class SessionData with _$SessionData {
  const factory SessionData({
    required Duration tiempo,
    required double distancia,
    required int calorias,
    required double odometro,
    int? velocidadMax,
    int? pulsoMax,
    String? nota,
  }) = _SessionData;
}
