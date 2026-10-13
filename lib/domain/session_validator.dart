/// Validación de los datos de una sesión (spec 001: RF-3, RF-4, RF-6, RF-7).
///
/// Función pura: convierte una [EntradaSesion] en [SessionData] o devuelve
/// todos los errores a la vez, uno por campo. Los textos de error los compone
/// la UI a partir de [ErrorCampo].
library;

import 'package:freezed_annotation/freezed_annotation.dart';

import 'models/entrada_sesion.dart';
import 'models/session_data.dart';

part 'session_validator.freezed.dart';

/// Campos del formulario que pueden tener error. La nota no se valida.
enum CampoSesion {
  tiempo,
  distancia,
  calorias,
  odometro,
  velocidadMax,
  pulsoMax,
}

/// Límites del tiempo de una sesión (tabla de rangos de la spec 001).
abstract final class LimitesTiempo {
  static const minimo = Duration(seconds: 1);
  static const maximo = Duration(hours: 5);
}

/// Motivo por el que un campo no es válido.
@freezed
sealed class ErrorCampo with _$ErrorCampo {
  /// Campo obligatorio vacío (RF-3).
  const factory ErrorCampo.falta() = Falta;

  /// No es un número sin signo con un único separador decimal (RF-4, RF-7).
  const factory ErrorCampo.noNumerico() = NoNumerico;

  /// Fuera del rango válido (RF-4). Si [minExclusivo], el mínimo no es
  /// válido (p. ej. distancia "más de 0"). Para el tiempo, [min] y [max]
  /// están en segundos.
  const factory ErrorCampo.fueraDeRango({
    required num min,
    required num max,
    @Default(false) bool minExclusivo,
  }) = FueraDeRango;

  /// Más decimales de los permitidos; [max] = 0 significa entero (RF-4).
  const factory ErrorCampo.demasiadosDecimales({required int max}) =
      DemasiadosDecimales;
}

/// Resultado de [validarSesion].
@freezed
sealed class ResultadoValidacion with _$ResultadoValidacion {
  const factory ResultadoValidacion.valida(SessionData datos) = Valida;

  const factory ResultadoValidacion.invalida(
    Map<CampoSesion, ErrorCampo> errores,
  ) = Invalida;
}

/// Valida [entrada] y, si todo es correcto, la convierte en [SessionData].
ResultadoValidacion validarSesion(EntradaSesion entrada) {
  final errores = <CampoSesion, ErrorCampo>{};

  if (entrada.tiempo < LimitesTiempo.minimo ||
      entrada.tiempo > LimitesTiempo.maximo) {
    errores[CampoSesion.tiempo] = ErrorCampo.fueraDeRango(
      min: LimitesTiempo.minimo.inSeconds,
      max: LimitesTiempo.maximo.inSeconds,
    );
  }

  final distancia = _validar(
    entrada.distancia,
    _distancia,
    CampoSesion.distancia,
    errores,
  );
  final calorias = _validar(
    entrada.calorias,
    _calorias,
    CampoSesion.calorias,
    errores,
  );
  final odometro = _validar(
    entrada.odometro,
    _odometro,
    CampoSesion.odometro,
    errores,
  );
  final velocidadMax = _validar(
    entrada.velocidadMax,
    _velocidadMax,
    CampoSesion.velocidadMax,
    errores,
  );
  final pulsoMax = _validar(
    entrada.pulsoMax,
    _pulsoMax,
    CampoSesion.pulsoMax,
    errores,
  );

  if (errores.isNotEmpty) return ResultadoValidacion.invalida(errores);

  final nota = entrada.nota.trim();
  return ResultadoValidacion.valida(
    SessionData(
      tiempo: entrada.tiempo,
      distancia: distancia!,
      calorias: calorias!.toInt(),
      odometro: odometro!,
      velocidadMax: velocidadMax?.toInt(),
      pulsoMax: pulsoMax?.toInt(),
      nota: nota.isEmpty ? null : nota,
    ),
  );
}

/// Regla de un campo numérico (tabla de rangos de la spec 001).
class _Regla {
  const _Regla({
    required this.obligatorio,
    required this.min,
    required this.max,
    required this.decimales,
    this.minExclusivo = false,
  });

  final bool obligatorio;
  final num min;
  final num max;
  final int decimales;
  final bool minExclusivo;
}

const _distancia = _Regla(
  obligatorio: true,
  min: 0,
  max: 200,
  decimales: 2,
  minExclusivo: true,
);
const _calorias = _Regla(obligatorio: true, min: 0, max: 5000, decimales: 0);
const _odometro = _Regla(obligatorio: true, min: 0, max: 999999, decimales: 2);
const _velocidadMax = _Regla(
  obligatorio: false,
  min: 1,
  max: 100,
  decimales: 0,
);
const _pulsoMax = _Regla(obligatorio: false, min: 40, max: 240, decimales: 0);

/// Número sin signo ni separador de miles; coma o punto como decimal (RF-7).
/// Acepta "12", "12,5", "12.5" y ",5"; rechaza "-5", "1.234,5", "12," y "1e3".
final _numero = RegExp(r'^(\d+|\d*[.,]\d+)$');

/// Valida [texto] con [regla]. Devuelve el valor, o `null` si el campo es
/// opcional y está vacío o si hay error (en ese caso lo anota en [errores]).
double? _validar(
  String texto,
  _Regla regla,
  CampoSesion campo,
  Map<CampoSesion, ErrorCampo> errores,
) {
  final limpio = texto.trim();

  if (limpio.isEmpty) {
    if (regla.obligatorio) errores[campo] = const ErrorCampo.falta();
    return null;
  }

  if (!_numero.hasMatch(limpio)) {
    errores[campo] = const ErrorCampo.noNumerico();
    return null;
  }

  final separador = limpio.indexOf(RegExp('[.,]'));
  final decimales = separador == -1 ? 0 : limpio.length - separador - 1;
  if (decimales > regla.decimales) {
    errores[campo] = ErrorCampo.demasiadosDecimales(max: regla.decimales);
    return null;
  }

  final valor = double.parse(limpio.replaceFirst(',', '.'));
  final bajoMinimo = regla.minExclusivo
      ? valor <= regla.min
      : valor < regla.min;
  if (bajoMinimo || valor > regla.max) {
    errores[campo] = ErrorCampo.fueraDeRango(
      min: regla.min,
      max: regla.max,
      minExclusivo: regla.minExclusivo,
    );
    return null;
  }

  return valor;
}
