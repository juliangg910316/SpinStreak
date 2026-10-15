/// Nombres de las rutas de la app.
///
/// Cada ruta nueva se añade aquí y en `AppRouter.onGenerateRoute`.
abstract final class RouteNames {
  static const home = '/';

  /// Formulario de sesión. Argumento opcional: la `Session` a editar.
  /// Devuelve el `SessionFormStatus` final (guardada, actualizada, borrada).
  static const sessionForm = '/session';

  /// Historial de sesiones agrupado por día.
  static const history = '/history';

  /// Calendario mensual de días entrenados.
  static const calendar = '/calendar';
}
