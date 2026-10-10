/// Resultado de una operación que puede fallar.
///
/// Los repositorios devuelven `Result` en lugar de lanzar excepciones hacia
/// la capa de UI. Quien lo recibe usa `switch` para tratar ambos casos:
///
/// ```dart
/// switch (await repository.addSession(...)) {
///   case Ok():
///     // éxito
///   case Error(:final error):
///     // mostrar error
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Resultado correcto con [value].
  const factory Result.ok(T value) = Ok._;

  /// Resultado fallido con [error].
  const factory Result.error(Exception error) = Error._;
}

/// Caso de éxito de [Result].
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Caso de error de [Result].
final class Error<T> extends Result<T> {
  const Error._(this.error);

  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
