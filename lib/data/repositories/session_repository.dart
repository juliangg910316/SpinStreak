/// Repositorio de sesiones: única puerta de la UI a los datos de sesiones.
///
/// Convierte las filas de drift en modelos de dominio y aplica las reglas de
/// registro: la fecha la asigna la app y editar no la cambia.
library;

import 'package:drift/drift.dart';

import '../../domain/models/session.dart';
import '../../domain/models/session_data.dart';
import '../../utils/result.dart';
import '../services/database/app_database.dart';

class SessionRepository {
  SessionRepository({required AppDatabase database, this._now = DateTime.now})
    : _db = database;

  final AppDatabase _db;

  /// Reloj inyectable para poder fijar la fecha en tests.
  final DateTime Function() _now;

  /// Todas las sesiones, de la más reciente a la más antigua. Si dos tienen
  /// la misma fecha, primero la registrada después (mayor `id`).
  Future<Result<List<Session>>> getSessions() async {
    try {
      final query = _db.select(_db.sessions)
        ..orderBy([
          (s) => OrderingTerm.desc(s.fecha),
          (s) => OrderingTerm.desc(s.id),
        ]);
      final rows = await query.get();
      return Result.ok(rows.map(_toDomain).toList());
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /// Días distintos con al menos una sesión (sin hora).
  Future<Result<List<DateTime>>> getTrainedDays() async {
    try {
      final query = _db.selectOnly(_db.sessions, distinct: true)
        ..addColumns([_db.sessions.dia]);
      final rows = await query.get();
      return Result.ok(
        rows.map((r) => _parseDay(r.read(_db.sessions.dia)!)).toList(),
      );
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /// Registra una sesión con [datos] y la fecha actual del reloj (RF-1).
  Future<Result<void>> addSession(SessionData datos) async {
    try {
      final now = _now();
      await _db
          .into(_db.sessions)
          .insert(
            SessionsCompanion.insert(
              fecha: now,
              dia: _formatDay(now),
              tiempoSegundos: datos.tiempo.inSeconds,
              distanciaKm: datos.distancia,
              calorias: datos.calorias,
              odometroKm: datos.odometro,
              velocidadMaxKmh: Value(datos.velocidadMax),
              pulsoMax: Value(datos.pulsoMax),
              nota: Value(datos.nota),
            ),
          );
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /// Sustituye los datos de la sesión [id] por [datos]. No escribe `fecha`
  /// ni `dia`: editar nunca cambia la fecha (RF-2, RF-14).
  Future<Result<void>> updateSession(int id, SessionData datos) async {
    try {
      await (_db.update(_db.sessions)..where((s) => s.id.equals(id))).write(
        SessionsCompanion(
          tiempoSegundos: Value(datos.tiempo.inSeconds),
          distanciaKm: Value(datos.distancia),
          calorias: Value(datos.calorias),
          odometroKm: Value(datos.odometro),
          velocidadMaxKmh: Value(datos.velocidadMax),
          pulsoMax: Value(datos.pulsoMax),
          nota: Value(datos.nota),
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
    dia: _parseDay(row.dia),
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
