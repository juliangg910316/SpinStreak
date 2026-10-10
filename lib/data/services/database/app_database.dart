/// Servicio de persistencia local con drift (SQLite).
///
/// Solo define tablas y la conexión. La conversión a modelos de dominio y las
/// reglas de negocio están en los repositorios.
///
/// Tras cambiar una tabla, regenerar el código con:
/// `dart run build_runner build`
library;

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Tabla de sesiones de entrenamiento.
///
/// La fila generada se llama `SessionRow` para no chocar con el modelo de
/// dominio `Session`.
@DataClassName('SessionRow')
class Sessions extends Table {
  late final id = integer().autoIncrement()();

  /// Momento del registro.
  late final fecha = dateTime()();

  /// Día local `yyyy-MM-dd` calculado al registrar. Es la clave de la racha y
  /// del agrupado por día, inmune a cambios de hora del dispositivo.
  late final dia = text()();

  late final tiempoSegundos = integer()();
  late final distanciaKm = real()();
  late final calorias = integer()();
  late final odometroKm = real()();
  late final velocidadMaxKmh = real().nullable()();
  late final pulsoMax = integer().nullable()();
  late final nota = text().nullable()();
}

@DriftDatabase(tables: [Sessions])
class AppDatabase extends _$AppDatabase {
  /// Sin [executor] abre la base de datos del dispositivo. En tests se puede
  /// pasar `NativeDatabase.memory()`.
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'spinstreak'));

  @override
  int get schemaVersion => 1;
}
