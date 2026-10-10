/// Repositorio de sesiones: única puerta de la UI a los datos de sesiones.
///
/// Convierte las filas de drift en modelos de dominio y aplica las reglas de
/// registro: la fecha la asigna la app y editar no la cambia.
library;

import 'package:drift/drift.dart';

import '../../domain/models/session.dart';
import '../../utils/result.dart';
import '../services/database/app_database.dart';

class SessionRepository {
  SessionRepository({required AppDatabase database, this._now = DateTime.now})
    : _db = database;

  final AppDatabase _db;

  /// Reloj inyectable para poder fijar la fecha en tests.
  final DateTime Function() _now;

  /// Todas las sesiones, de la más reciente a la más antigua.
  Stream<List<Session>> watchSessions() {
    final query = _db.select(_db.sessions)
      ..orderBy([(s) => OrderingTerm.desc(s.fecha)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  /// Días distintos con al menos una sesión (sin hora).
  Stream<List<DateTime>> watchTrainedDays() {
    final query = _db.selectOnly(_db.sessions, distinct: true)
      ..addColumns([_db.sessions.dia]);
    return query.watch().map(
      (rows) => rows.map((r) => _parseDay(r.read(_db.sessions.dia)!)).toList(),
    );
  }

  /// Registra una sesión con la fecha actual.
  Future<Result<void>> addSession({
    required Duration tiempo,
    required double distancia,
    required int calorias,
    required double odometro,
    double? velocidadMax,
    int? pulsoMax,
    String? nota,
  }) async {
    try {
      final now = _now();
      await _db
          .into(_db.sessions)
          .insert(
            SessionsCompanion.insert(
              fecha: now,
              dia: _formatDay(now),
              tiempoSegundos: tiempo.inSeconds,
              distanciaKm: distancia,
              calorias: calorias,
              odometroKm: odometro,
              velocidadMaxKmh: Value(velocidadMax),
              pulsoMax: Value(pulsoMax),
              nota: Value(nota),
            ),
          );
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /// Actualiza los datos de [session]. La fecha y el día no se modifican.
  Future<Result<void>> updateSession(Session session) async {
    try {
      await (_db.update(
        _db.sessions,
      )..where((s) => s.id.equals(session.id))).write(
        SessionsCompanion(
          tiempoSegundos: Value(session.tiempo.inSeconds),
          distanciaKm: Value(session.distancia),
          calorias: Value(session.calorias),
          odometroKm: Value(session.odometro),
          velocidadMaxKmh: Value(session.velocidadMax),
          pulsoMax: Value(session.pulsoMax),
          nota: Value(session.nota),
        ),
      );
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteSession(int id) async {
    try {
      await (_db.delete(_db.sessions)..where((s) => s.id.equals(id))).go();
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Session _toDomain(SessionRow row) => Session(
    id: row.id,
    fecha: row.fecha,
    tiempo: Duration(seconds: row.tiempoSegundos),
    distancia: row.distanciaKm,
    calorias: row.calorias,
    odometro: row.odometroKm,
    velocidadMax: row.velocidadMaxKmh,
    pulsoMax: row.pulsoMax,
    nota: row.nota,
  );

  static String _formatDay(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  static DateTime _parseDay(String day) {
    final [y, m, d] = day.split('-').map(int.parse).toList();
    return DateTime(y, m, d);
  }
}
