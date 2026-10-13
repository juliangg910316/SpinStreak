/// Agrupado del historial por día (spec 001: RF-9, RF-10).
///
/// Función pura: agrupa por el día local guardado al registrar (`dia`), el
/// mismo criterio que la racha, para que un cambio de hora o de zona horaria
/// no mueva una sesión de grupo.
library;

import 'models/dia_historial.dart';
import 'models/session.dart';

/// Agrupa [sesiones] por día, del día más reciente al más antiguo. Dentro de
/// cada día, las sesiones van de la más reciente a la más antigua (a igual
/// `fecha`, primero la de mayor `id`).
List<DiaHistorial> agruparPorDia(List<Session> sesiones) {
  final ordenadas = [...sesiones]
    ..sort((a, b) {
      final porFecha = b.fecha.compareTo(a.fecha);
      return porFecha != 0 ? porFecha : b.id.compareTo(a.id);
    });

  final porDia = <DateTime, List<Session>>{};
  for (final sesion in ordenadas) {
    porDia.putIfAbsent(sesion.dia, () => []).add(sesion);
  }

  final dias = [
    for (final MapEntry(key: dia, value: delDia) in porDia.entries)
      DiaHistorial(
        dia: dia,
        sesiones: delDia,
        distanciaTotal: delDia.fold(0, (total, s) => total + s.distancia),
        tiempoTotal: delDia.fold(Duration.zero, (total, s) => total + s.tiempo),
        caloriasTotal: delDia.fold(0, (total, s) => total + s.calorias),
      ),
  ]..sort((a, b) => b.dia.compareTo(a.dia));

  return dias;
}
