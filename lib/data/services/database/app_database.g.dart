// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions
    with TableInfo<$SessionsTable, SessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diaMeta = const VerificationMeta('dia');
  @override
  late final GeneratedColumn<String> dia = GeneratedColumn<String>(
    'dia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tiempoSegundosMeta = const VerificationMeta(
    'tiempoSegundos',
  );
  @override
  late final GeneratedColumn<int> tiempoSegundos = GeneratedColumn<int>(
    'tiempo_segundos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanciaKmMeta = const VerificationMeta(
    'distanciaKm',
  );
  @override
  late final GeneratedColumn<double> distanciaKm = GeneratedColumn<double>(
    'distancia_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriasMeta = const VerificationMeta(
    'calorias',
  );
  @override
  late final GeneratedColumn<int> calorias = GeneratedColumn<int>(
    'calorias',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometroKmMeta = const VerificationMeta(
    'odometroKm',
  );
  @override
  late final GeneratedColumn<double> odometroKm = GeneratedColumn<double>(
    'odometro_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _velocidadMaxKmhMeta = const VerificationMeta(
    'velocidadMaxKmh',
  );
  @override
  late final GeneratedColumn<double> velocidadMaxKmh = GeneratedColumn<double>(
    'velocidad_max_kmh',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pulsoMaxMeta = const VerificationMeta(
    'pulsoMax',
  );
  @override
  late final GeneratedColumn<int> pulsoMax = GeneratedColumn<int>(
    'pulso_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fecha,
    dia,
    tiempoSegundos,
    distanciaKm,
    calorias,
    odometroKm,
    velocidadMaxKmh,
    pulsoMax,
    nota,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('dia')) {
      context.handle(
        _diaMeta,
        dia.isAcceptableOrUnknown(data['dia']!, _diaMeta),
      );
    } else if (isInserting) {
      context.missing(_diaMeta);
    }
    if (data.containsKey('tiempo_segundos')) {
      context.handle(
        _tiempoSegundosMeta,
        tiempoSegundos.isAcceptableOrUnknown(
          data['tiempo_segundos']!,
          _tiempoSegundosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tiempoSegundosMeta);
    }
    if (data.containsKey('distancia_km')) {
      context.handle(
        _distanciaKmMeta,
        distanciaKm.isAcceptableOrUnknown(
          data['distancia_km']!,
          _distanciaKmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_distanciaKmMeta);
    }
    if (data.containsKey('calorias')) {
      context.handle(
        _caloriasMeta,
        calorias.isAcceptableOrUnknown(data['calorias']!, _caloriasMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriasMeta);
    }
    if (data.containsKey('odometro_km')) {
      context.handle(
        _odometroKmMeta,
        odometroKm.isAcceptableOrUnknown(data['odometro_km']!, _odometroKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometroKmMeta);
    }
    if (data.containsKey('velocidad_max_kmh')) {
      context.handle(
        _velocidadMaxKmhMeta,
        velocidadMaxKmh.isAcceptableOrUnknown(
          data['velocidad_max_kmh']!,
          _velocidadMaxKmhMeta,
        ),
      );
    }
    if (data.containsKey('pulso_max')) {
      context.handle(
        _pulsoMaxMeta,
        pulsoMax.isAcceptableOrUnknown(data['pulso_max']!, _pulsoMaxMeta),
      );
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      dia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dia'],
      )!,
      tiempoSegundos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tiempo_segundos'],
      )!,
      distanciaKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distancia_km'],
      )!,
      calorias: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calorias'],
      )!,
      odometroKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometro_km'],
      )!,
      velocidadMaxKmh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}velocidad_max_kmh'],
      ),
      pulsoMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulso_max'],
      ),
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      ),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class SessionRow extends DataClass implements Insertable<SessionRow> {
  final int id;

  /// Momento del registro.
  final DateTime fecha;

  /// Día local `yyyy-MM-dd` calculado al registrar. Es la clave de la racha y
  /// del agrupado por día, inmune a cambios de hora del dispositivo.
  final String dia;
  final int tiempoSegundos;
  final double distanciaKm;
  final int calorias;
  final double odometroKm;
  final double? velocidadMaxKmh;
  final int? pulsoMax;
  final String? nota;
  const SessionRow({
    required this.id,
    required this.fecha,
    required this.dia,
    required this.tiempoSegundos,
    required this.distanciaKm,
    required this.calorias,
    required this.odometroKm,
    this.velocidadMaxKmh,
    this.pulsoMax,
    this.nota,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['dia'] = Variable<String>(dia);
    map['tiempo_segundos'] = Variable<int>(tiempoSegundos);
    map['distancia_km'] = Variable<double>(distanciaKm);
    map['calorias'] = Variable<int>(calorias);
    map['odometro_km'] = Variable<double>(odometroKm);
    if (!nullToAbsent || velocidadMaxKmh != null) {
      map['velocidad_max_kmh'] = Variable<double>(velocidadMaxKmh);
    }
    if (!nullToAbsent || pulsoMax != null) {
      map['pulso_max'] = Variable<int>(pulsoMax);
    }
    if (!nullToAbsent || nota != null) {
      map['nota'] = Variable<String>(nota);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      fecha: Value(fecha),
      dia: Value(dia),
      tiempoSegundos: Value(tiempoSegundos),
      distanciaKm: Value(distanciaKm),
      calorias: Value(calorias),
      odometroKm: Value(odometroKm),
      velocidadMaxKmh: velocidadMaxKmh == null && nullToAbsent
          ? const Value.absent()
          : Value(velocidadMaxKmh),
      pulsoMax: pulsoMax == null && nullToAbsent
          ? const Value.absent()
          : Value(pulsoMax),
      nota: nota == null && nullToAbsent ? const Value.absent() : Value(nota),
    );
  }

  factory SessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRow(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      dia: serializer.fromJson<String>(json['dia']),
      tiempoSegundos: serializer.fromJson<int>(json['tiempoSegundos']),
      distanciaKm: serializer.fromJson<double>(json['distanciaKm']),
      calorias: serializer.fromJson<int>(json['calorias']),
      odometroKm: serializer.fromJson<double>(json['odometroKm']),
      velocidadMaxKmh: serializer.fromJson<double?>(json['velocidadMaxKmh']),
      pulsoMax: serializer.fromJson<int?>(json['pulsoMax']),
      nota: serializer.fromJson<String?>(json['nota']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'dia': serializer.toJson<String>(dia),
      'tiempoSegundos': serializer.toJson<int>(tiempoSegundos),
      'distanciaKm': serializer.toJson<double>(distanciaKm),
      'calorias': serializer.toJson<int>(calorias),
      'odometroKm': serializer.toJson<double>(odometroKm),
      'velocidadMaxKmh': serializer.toJson<double?>(velocidadMaxKmh),
      'pulsoMax': serializer.toJson<int?>(pulsoMax),
      'nota': serializer.toJson<String?>(nota),
    };
  }

  SessionRow copyWith({
    int? id,
    DateTime? fecha,
    String? dia,
    int? tiempoSegundos,
    double? distanciaKm,
    int? calorias,
    double? odometroKm,
    Value<double?> velocidadMaxKmh = const Value.absent(),
    Value<int?> pulsoMax = const Value.absent(),
    Value<String?> nota = const Value.absent(),
  }) => SessionRow(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    dia: dia ?? this.dia,
    tiempoSegundos: tiempoSegundos ?? this.tiempoSegundos,
    distanciaKm: distanciaKm ?? this.distanciaKm,
    calorias: calorias ?? this.calorias,
    odometroKm: odometroKm ?? this.odometroKm,
    velocidadMaxKmh: velocidadMaxKmh.present
        ? velocidadMaxKmh.value
        : this.velocidadMaxKmh,
    pulsoMax: pulsoMax.present ? pulsoMax.value : this.pulsoMax,
    nota: nota.present ? nota.value : this.nota,
  );
  SessionRow copyWithCompanion(SessionsCompanion data) {
    return SessionRow(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      dia: data.dia.present ? data.dia.value : this.dia,
      tiempoSegundos: data.tiempoSegundos.present
          ? data.tiempoSegundos.value
          : this.tiempoSegundos,
      distanciaKm: data.distanciaKm.present
          ? data.distanciaKm.value
          : this.distanciaKm,
      calorias: data.calorias.present ? data.calorias.value : this.calorias,
      odometroKm: data.odometroKm.present
          ? data.odometroKm.value
          : this.odometroKm,
      velocidadMaxKmh: data.velocidadMaxKmh.present
          ? data.velocidadMaxKmh.value
          : this.velocidadMaxKmh,
      pulsoMax: data.pulsoMax.present ? data.pulsoMax.value : this.pulsoMax,
      nota: data.nota.present ? data.nota.value : this.nota,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRow(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('dia: $dia, ')
          ..write('tiempoSegundos: $tiempoSegundos, ')
          ..write('distanciaKm: $distanciaKm, ')
          ..write('calorias: $calorias, ')
          ..write('odometroKm: $odometroKm, ')
          ..write('velocidadMaxKmh: $velocidadMaxKmh, ')
          ..write('pulsoMax: $pulsoMax, ')
          ..write('nota: $nota')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fecha,
    dia,
    tiempoSegundos,
    distanciaKm,
    calorias,
    odometroKm,
    velocidadMaxKmh,
    pulsoMax,
    nota,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRow &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.dia == this.dia &&
          other.tiempoSegundos == this.tiempoSegundos &&
          other.distanciaKm == this.distanciaKm &&
          other.calorias == this.calorias &&
          other.odometroKm == this.odometroKm &&
          other.velocidadMaxKmh == this.velocidadMaxKmh &&
          other.pulsoMax == this.pulsoMax &&
          other.nota == this.nota);
}

class SessionsCompanion extends UpdateCompanion<SessionRow> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<String> dia;
  final Value<int> tiempoSegundos;
  final Value<double> distanciaKm;
  final Value<int> calorias;
  final Value<double> odometroKm;
  final Value<double?> velocidadMaxKmh;
  final Value<int?> pulsoMax;
  final Value<String?> nota;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.dia = const Value.absent(),
    this.tiempoSegundos = const Value.absent(),
    this.distanciaKm = const Value.absent(),
    this.calorias = const Value.absent(),
    this.odometroKm = const Value.absent(),
    this.velocidadMaxKmh = const Value.absent(),
    this.pulsoMax = const Value.absent(),
    this.nota = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    required String dia,
    required int tiempoSegundos,
    required double distanciaKm,
    required int calorias,
    required double odometroKm,
    this.velocidadMaxKmh = const Value.absent(),
    this.pulsoMax = const Value.absent(),
    this.nota = const Value.absent(),
  }) : fecha = Value(fecha),
       dia = Value(dia),
       tiempoSegundos = Value(tiempoSegundos),
       distanciaKm = Value(distanciaKm),
       calorias = Value(calorias),
       odometroKm = Value(odometroKm);
  static Insertable<SessionRow> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<String>? dia,
    Expression<int>? tiempoSegundos,
    Expression<double>? distanciaKm,
    Expression<int>? calorias,
    Expression<double>? odometroKm,
    Expression<double>? velocidadMaxKmh,
    Expression<int>? pulsoMax,
    Expression<String>? nota,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (dia != null) 'dia': dia,
      if (tiempoSegundos != null) 'tiempo_segundos': tiempoSegundos,
      if (distanciaKm != null) 'distancia_km': distanciaKm,
      if (calorias != null) 'calorias': calorias,
      if (odometroKm != null) 'odometro_km': odometroKm,
      if (velocidadMaxKmh != null) 'velocidad_max_kmh': velocidadMaxKmh,
      if (pulsoMax != null) 'pulso_max': pulsoMax,
      if (nota != null) 'nota': nota,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fecha,
    Value<String>? dia,
    Value<int>? tiempoSegundos,
    Value<double>? distanciaKm,
    Value<int>? calorias,
    Value<double>? odometroKm,
    Value<double?>? velocidadMaxKmh,
    Value<int?>? pulsoMax,
    Value<String?>? nota,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      dia: dia ?? this.dia,
      tiempoSegundos: tiempoSegundos ?? this.tiempoSegundos,
      distanciaKm: distanciaKm ?? this.distanciaKm,
      calorias: calorias ?? this.calorias,
      odometroKm: odometroKm ?? this.odometroKm,
      velocidadMaxKmh: velocidadMaxKmh ?? this.velocidadMaxKmh,
      pulsoMax: pulsoMax ?? this.pulsoMax,
      nota: nota ?? this.nota,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (dia.present) {
      map['dia'] = Variable<String>(dia.value);
    }
    if (tiempoSegundos.present) {
      map['tiempo_segundos'] = Variable<int>(tiempoSegundos.value);
    }
    if (distanciaKm.present) {
      map['distancia_km'] = Variable<double>(distanciaKm.value);
    }
    if (calorias.present) {
      map['calorias'] = Variable<int>(calorias.value);
    }
    if (odometroKm.present) {
      map['odometro_km'] = Variable<double>(odometroKm.value);
    }
    if (velocidadMaxKmh.present) {
      map['velocidad_max_kmh'] = Variable<double>(velocidadMaxKmh.value);
    }
    if (pulsoMax.present) {
      map['pulso_max'] = Variable<int>(pulsoMax.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('dia: $dia, ')
          ..write('tiempoSegundos: $tiempoSegundos, ')
          ..write('distanciaKm: $distanciaKm, ')
          ..write('calorias: $calorias, ')
          ..write('odometroKm: $odometroKm, ')
          ..write('velocidadMaxKmh: $velocidadMaxKmh, ')
          ..write('pulsoMax: $pulsoMax, ')
          ..write('nota: $nota')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sessions];
}

typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  required DateTime fecha,
  required String dia,
  required int tiempoSegundos,
  required double distanciaKm,
  required int calorias,
  required double odometroKm,
  Value<double?> velocidadMaxKmh,
  Value<int?> pulsoMax,
  Value<String?> nota,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  Value<DateTime> fecha,
  Value<String> dia,
  Value<int> tiempoSegundos,
  Value<double> distanciaKm,
  Value<int> calorias,
  Value<double> odometroKm,
  Value<double?> velocidadMaxKmh,
  Value<int?> pulsoMax,
  Value<String?> nota,
});

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dia => $composableBuilder(
    column: $table.dia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tiempoSegundos => $composableBuilder(
    column: $table.tiempoSegundos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanciaKm => $composableBuilder(
    column: $table.distanciaKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calorias => $composableBuilder(
    column: $table.calorias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometroKm => $composableBuilder(
    column: $table.odometroKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get velocidadMaxKmh => $composableBuilder(
    column: $table.velocidadMaxKmh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulsoMax => $composableBuilder(
    column: $table.pulsoMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dia => $composableBuilder(
    column: $table.dia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tiempoSegundos => $composableBuilder(
    column: $table.tiempoSegundos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanciaKm => $composableBuilder(
    column: $table.distanciaKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calorias => $composableBuilder(
    column: $table.calorias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometroKm => $composableBuilder(
    column: $table.odometroKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get velocidadMaxKmh => $composableBuilder(
    column: $table.velocidadMaxKmh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulsoMax => $composableBuilder(
    column: $table.pulsoMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get dia =>
      $composableBuilder(column: $table.dia, builder: (column) => column);

  GeneratedColumn<int> get tiempoSegundos => $composableBuilder(
    column: $table.tiempoSegundos,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanciaKm => $composableBuilder(
    column: $table.distanciaKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calorias =>
      $composableBuilder(column: $table.calorias, builder: (column) => column);

  GeneratedColumn<double> get odometroKm => $composableBuilder(
    column: $table.odometroKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get velocidadMaxKmh => $composableBuilder(
    column: $table.velocidadMaxKmh,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pulsoMax =>
      $composableBuilder(column: $table.pulsoMax, builder: (column) => column);

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          SessionRow,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (
            SessionRow,
            BaseReferences<_$AppDatabase, $SessionsTable, SessionRow>,
          ),
          SessionRow,
          PrefetchHooks Function()
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String> dia = const Value.absent(),
                Value<int> tiempoSegundos = const Value.absent(),
                Value<double> distanciaKm = const Value.absent(),
                Value<int> calorias = const Value.absent(),
                Value<double> odometroKm = const Value.absent(),
                Value<double?> velocidadMaxKmh = const Value.absent(),
                Value<int?> pulsoMax = const Value.absent(),
                Value<String?> nota = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                fecha: fecha,
                dia: dia,
                tiempoSegundos: tiempoSegundos,
                distanciaKm: distanciaKm,
                calorias: calorias,
                odometroKm: odometroKm,
                velocidadMaxKmh: velocidadMaxKmh,
                pulsoMax: pulsoMax,
                nota: nota,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fecha,
                required String dia,
                required int tiempoSegundos,
                required double distanciaKm,
                required int calorias,
                required double odometroKm,
                Value<double?> velocidadMaxKmh = const Value.absent(),
                Value<int?> pulsoMax = const Value.absent(),
                Value<String?> nota = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                fecha: fecha,
                dia: dia,
                tiempoSegundos: tiempoSegundos,
                distanciaKm: distanciaKm,
                calorias: calorias,
                odometroKm: odometroKm,
                velocidadMaxKmh: velocidadMaxKmh,
                pulsoMax: pulsoMax,
                nota: nota,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsTable, SessionRow>(table),
                  BaseReferences<_$AppDatabase, $SessionsTable, SessionRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      SessionRow,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (SessionRow, BaseReferences<_$AppDatabase, $SessionsTable, SessionRow>),
      SessionRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
}
