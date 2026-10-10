/// Lógica de negocio de la racha (ver specs/002-rachas/spec.md).
///
/// Funciones puras, sin dependencias de Flutter ni de drift, para poder
/// probarlas con tests unitarios.
library;

/// Resumen de la racha del usuario.
class Streak {
  const Streak({
    required this.current,
    required this.best,
    required this.totalDays,
  });

  static const empty = Streak(current: 0, best: 0, totalDays: 0);

  /// Días consecutivos entrenados que terminan hoy o ayer.
  final int current;

  /// Racha más larga histórica.
  final int best;

  /// Total de días distintos con al menos una sesión.
  final int totalDays;
}

/// Calcula la racha a partir de los días entrenados.
///
/// [trainedDays] puede contener duplicados (varias sesiones el mismo día) y
/// horas; solo se usa el día local. [today] es el día actual del dispositivo.
Streak calculateStreak(Iterable<DateTime> trainedDays, DateTime today) {
  final days = trainedDays.map(_dayNumber).toSet().toList()..sort();
  if (days.isEmpty) return Streak.empty;

  var best = 1;
  var run = 1;
  for (var i = 1; i < days.length; i++) {
    run = days[i] == days[i - 1] + 1 ? run + 1 : 1;
    if (run > best) best = run;
  }

  // `run` es la longitud de la racha que termina en el último día entrenado.
  // Solo sigue viva si ese día es hoy o ayer.
  final todayNumber = _dayNumber(today);
  final isAlive = days.last >= todayNumber - 1;

  return Streak(current: isAlive ? run : 0, best: best, totalDays: days.length);
}

/// Número de día a partir de la fecha local.
///
/// Usa UTC solo como calendario, para que un cambio de hora no haga que un
/// día dure 23 o 25 horas y se descuadre la diferencia entre días.
int _dayNumber(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day).millisecondsSinceEpoch ~/
    Duration.millisecondsPerDay;
