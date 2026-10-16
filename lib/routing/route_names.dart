/// Nombres de las rutas de la app.
///
/// Cada ruta nueva se añade aquí y en `AppRouter.onGenerateRoute`.
abstract final class RouteNames {
  static const home = '/';

  /// Formulario de sesión. Argumento opcional: la `Session` a editar.
  /// Devuelve un `ResultadoFormulario`: el estado final (guardada,
  /// actualizada, borrada) y los récords batidos al registrar.
  static const sessionForm = '/session';

  /// Historial de sesiones agrupado por día.
  static const history = '/history';

  /// Calendario mensual de días entrenados.
  static const calendar = '/calendar';

  /// Récords personales por sesión.
  static const records = '/records';
}
