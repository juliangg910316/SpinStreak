/// Elección del mensaje del día del inicio (spec 002, RF-8 a RF-12).
///
/// Función pura. No recibe "hoy" aparte: ya va dentro de la [Streak],
/// calculada con `calculateStreak(días, hoy)`.
library;

import 'models/mensaje_dia.dart';
import 'models/streak.dart';

/// Devuelve el único mensaje que corresponde a [racha] (RF-12). Las cuatro
/// situaciones son excluyentes y cubren todos los casos; el orden importa.
MensajeDia mensajeDelDia(Streak racha) {
  if (racha.totalDays == 0) return const MensajeDia.bienvenida();
  if (racha.trainedToday) return const MensajeDia.aSalvo();
  if (racha.current > 0) return MensajeDia.riesgo(dias: racha.current);
  return MensajeDia.reiniciada(mejorRacha: racha.best);
}
