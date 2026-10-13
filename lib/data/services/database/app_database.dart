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

  /// Entero desde `schemaVersion` 2 (antes `real`).
  late final velocidadMaxKmh = integer().nullable()();
  late final pulsoMax = integer().nullable()();
  late final nota = text().nullable()();
}

@DriftDatabase(tables: [Sessions])
class AppDatabase extends _$AppDatabase {
  /// Sin [executor] abre la base de datos del dispositivo. En tests se puede
  /// pasar `NativeDatabase.memory()`.
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'spinstreak'));

  /// Historial de versiones:
  /// - 1: esquema inicial.
  /// - 2: `velocidadMaxKmh` pasa de `real` a `integer` (spec 001).
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Recrea la tabla copiando todas las filas. La velocidad máxima se
        // redondea (32,6 → 33); `CAST` solo truncaría. NULL sigue siendo NULL.
        await m.alterTable(
          TableMigration(
            sessions,
            columnTransformer: {
              sessions.velocidadMaxKmh: const CustomExpression<int>(
                'CAST(ROUND(velocidad_max_kmh) AS INTEGER)',
              ),
            },
          ),
        );
      }
    },
  );
}
