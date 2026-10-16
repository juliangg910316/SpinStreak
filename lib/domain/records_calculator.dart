/// Lógica de los récords personales (ver specs/004-records/spec.md).
///
/// Funciones puras. No reciben "hoy": los récords solo comparan sesiones ya
/// guardadas y no dependen del día.
library;

import 'models/record_personal.dart';
import 'models/session.dart';
import 'models/session_data.dart';

/// Los cuatro récords de [sesiones], en el orden de [TipoRecord] (RF-1 a
/// RF-6). Si dos sesiones empatan, gana la más antigua (menor `fecha` y,
/// si coincide, menor `id`).
List<RecordPersonal> calcularRecords(List<Session> sesiones) => [
  for (final tipo in TipoRecord.values)
    RecordPersonal(tipo: tipo, sesion: _mejor(tipo, sesiones)),
];

/// Récords que bate [nueva] frente a [anteriores], en el orden de
/// [TipoRecord] (RF-10, RF-11).
///
/// Solo cuenta superar estrictamente el récord anterior. Si ninguna sesión
/// anterior tiene ese dato (primera sesión o primer dato opcional), no hay
/// récord que batir.
List<TipoRecord> recordsBatidos(List<Session> anteriores, SessionData nueva) {
  final batidos = <TipoRecord>[];
  for (final tipo in TipoRecord.values) {
    final valor = _valor(
      tipo,
      tiempo: nueva.tiempo,
      distancia: nueva.distancia,
      velocidadMax: nueva.velocidadMax,
      pulsoMax: nueva.pulsoMax,
    );
    final previo = _mejorConValor(tipo, anteriores);
    if (valor == null || previo == null) continue;
    if (valor > previo.valor) batidos.add(tipo);
  }
  return batidos;
}

/// Sesión con el mayor valor de [tipo], o `null` si ninguna lo tiene.
Session? _mejor(TipoRecord tipo, List<Session> sesiones) =>
    _mejorConValor(tipo, sesiones)?.sesion;

({Session sesion, num valor})? _mejorConValor(
  TipoRecord tipo,
  List<Session> sesiones,
) {
  ({Session sesion, num valor})? mejor;
  for (final sesion in sesiones) {
    final valor = _valorDe(tipo, sesion);
    if (valor == null) continue;
    final gana = switch (mejor) {
      null => true,
      (sesion: final lider, valor: final actual) =>
        valor > actual || (valor == actual && _esAnterior(sesion, lider)),
    };
    if (gana) mejor = (sesion: sesion, valor: valor);
  }
  return mejor;
}

bool _esAnterior(Session a, Session b) {
  final porFecha = a.fecha.compareTo(b.fecha);
  return porFecha < 0 || (porFecha == 0 && a.id < b.id);
}

num? _valorDe(TipoRecord tipo, Session sesion) => _valor(
  tipo,
  tiempo: sesion.tiempo,
  distancia: sesion.distancia,
  velocidadMax: sesion.velocidadMax,
  pulsoMax: sesion.pulsoMax,
);

/// Valor de [tipo]; el tiempo, en segundos. `null` si el dato opcional falta.
num? _valor(
  TipoRecord tipo, {
  required Duration tiempo,
  required double distancia,
  required int? velocidadMax,
  required int? pulsoMax,
}) => switch (tipo) {
  TipoRecord.tiempo => tiempo.inSeconds,
  TipoRecord.distancia => distancia,
  TipoRecord.velocidadMax => velocidadMax,
  TipoRecord.pulsoMax => pulsoMax,
};
