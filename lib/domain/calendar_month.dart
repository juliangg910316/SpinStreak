/// Lógica del calendario mensual (ver specs/003-calendario/spec.md).
///
/// Funciones puras, con "hoy" como parámetro. Solo usan año, mes y día, así
/// que un cambio de hora no les afecta.
library;

import 'models/mes_calendario.dart';

/// Construye la cuadrícula de lunes a domingo del mes de [mes].
///
/// [diasEntrenados] son días locales sin hora (como `Session.dia`). Un día
/// posterior a [hoy] nunca sale como entrenado (RF-6).
MesCalendario construirMes(
  DateTime mes,
  Set<DateTime> diasEntrenados,
  DateTime hoy,
) {
  final primero = DateTime(mes.year, mes.month);
  final numDias = DateTime(mes.year, mes.month + 1, 0).day;
  final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);

  final celdas = <CeldaDia?>[
    for (var i = 0; i < primero.weekday - 1; i++) null,
    for (var d = 1; d <= numDias; d++)
      _celda(mes, d, diasEntrenados, hoySinHora),
  ];
  while (celdas.length % 7 != 0) {
    celdas.add(null);
  }

  return MesCalendario(
    mes: primero,
    semanas: [
      for (var i = 0; i < celdas.length; i += 7) celdas.sublist(i, i + 7),
    ],
    puedeAvanzar: primero.isBefore(DateTime(hoy.year, hoy.month)),
  );
}

/// Día que queda seleccionado al abrir, al recargar y al cambiar de mes
/// (RF-10, RF-12, RF-15).
///
/// [previo] es la selección actual al recargar, o `null` al abrir y al
/// cambiar de mes. Se conserva si sigue teniendo sesiones o es hoy; si no,
/// en el mes de hoy se selecciona hoy y en otro mes, ninguno.
DateTime? diaASeleccionar({
  required DateTime? previo,
  required Set<DateTime> diasEntrenados,
  required DateTime mesVisible,
  required DateTime hoy,
}) {
  if (previo != null &&
      (diasEntrenados.contains(previo) || mismoDia(previo, hoy))) {
    return previo;
  }
  if (mesVisible.year == hoy.year && mesVisible.month == hoy.month) {
    return DateTime(hoy.year, hoy.month, hoy.day);
  }
  return null;
}

/// Si [a] y [b] son el mismo día (año, mes y día).
bool mismoDia(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

CeldaDia _celda(
  DateTime mes,
  int d,
  Set<DateTime> diasEntrenados,
  DateTime hoy,
) {
  final dia = DateTime(mes.year, mes.month, d);
  final esFuturo = dia.isAfter(hoy);
  return CeldaDia(
    dia: dia,
    entrenado: !esFuturo && diasEntrenados.contains(dia),
    esHoy: mismoDia(dia, hoy),
    esFuturo: esFuturo,
  );
}
