/// Formatos de presentación en español (RC-3), con `intl`.
///
/// Usan el idioma por defecto (`Intl.defaultLocale = 'es'`, configurado en
/// `main.dart`): coma decimal y punto de miles.
library;

import 'package:intl/intl.dart';

/// "sábado, 10 de octubre de 2026".
String formatearFecha(DateTime fecha) => DateFormat.yMMMMEEEEd().format(fecha);

/// "octubre de 2026".
String formatearMes(DateTime fecha) => DateFormat.yMMMM().format(fecha);

/// "18:30" (24 horas).
String formatearHora(DateTime fecha) => DateFormat.Hm().format(fecha);

/// "1:05:20". Las horas no se limitan a 24 (totales del día).
String formatearTiempo(Duration tiempo) {
  final horas = tiempo.inHours;
  final minutos = (tiempo.inMinutes % 60).toString().padLeft(2, '0');
  final segundos = (tiempo.inSeconds % 60).toString().padLeft(2, '0');
  return '$horas:$minutos:$segundos';
}

/// "1.234,5 km" (hasta 2 decimales).
String formatearKm(double km) => '${NumberFormat('#,##0.##').format(km)} km';

/// "23,4 km/h" (un decimal, redondeado).
String formatearKmh(double kmh) =>
    '${NumberFormat('#,##0.0').format(kmh)} km/h';

/// "32 km/h" (velocidad máxima, entera).
String formatearVelocidadMax(int kmh) =>
    '${NumberFormat('#,##0').format(kmh)} km/h';

/// "160 ppm".
String formatearPulso(int ppm) => '${NumberFormat('#,##0').format(ppm)} ppm';

/// "1 día", "12 días", "1.000 días" (singular solo con 1).
String formatearDias(int dias) =>
    dias == 1 ? '1 día' : '${NumberFormat('#,##0').format(dias)} días';

/// "610 kcal".
String formatearKcal(int kcal) => '${NumberFormat('#,##0').format(kcal)} kcal';
