/// Datos de una sesión tal como los introduce el usuario en el formulario.
///
/// Los campos numéricos son texto sin procesar (se validan y convierten en
/// `validarSesion`). Su igualdad por valor permite saber si el formulario
/// tiene cambios sin guardar (RF-16).
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'entrada_sesion.freezed.dart';

@freezed
abstract class EntradaSesion with _$EntradaSesion {
  const factory EntradaSesion({
    /// Elegido con el selector de horas, minutos y segundos.
    @Default(Duration.zero) Duration tiempo,
    @Default('') String distancia,
    @Default('') String calorias,
    @Default('') String odometro,
    @Default('') String velocidadMax,
    @Default('') String pulsoMax,
    @Default('') String nota,
  }) = _EntradaSesion;
}
