/// Récords personales por sesión (spec 004).
///
/// Solo pinta el estado de [RecordsCubit]; el `BlocProvider` lo crea el
/// router. Tocar un récord con valor abre la edición de su sesión (RF-8) y,
/// al volver, recarga (RF-9). Aspecto según la spec 005 (RF-16, RF-17 y
/// RF-29 a RF-31): sin el acento de la racha.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/record_personal.dart';
import '../../../domain/models/session.dart';
import '../../../utils/formatters.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/editar_sesion.dart';
import '../../core/ui/estado_error.dart';
import '../../core/ui/tarjeta_aviso.dart';
import '../view_model/records_cubit.dart';
import '../view_model/records_state.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Récords')),
      body: BlocBuilder<RecordsCubit, RecordsState>(
        builder: (context, state) => switch (state.status) {
          RecordsStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          // RF-7.
          RecordsStatus.error => const EstadoError(
            'No se pudieron cargar los récords.',
          ),
          RecordsStatus.ready => ListView(
            padding: const EdgeInsets.fromLTRB(
              Dimens.margen,
              8,
              Dimens.margen,
              24,
            ),
            children: [
              // RF-4 / RC-2: sin sesiones, los récords con un aviso encima
              // (spec 005, RF-17: tarjeta neutra).
              if (state.sinSesiones) ...[
                const TarjetaAviso(
                  icono: Icons.emoji_events_rounded,
                  texto:
                      'Aún no hay récords. Registra tu primera sesión con '
                      '«Registrar sesión» en el inicio.',
                ),
                const SizedBox(height: 12),
              ],
              for (final (i, record) in state.records.indexed) ...[
                if (i > 0) const SizedBox(height: 12),
                _TarjetaRecord(
                  record: record,
                  onTap: switch (record.sesion) {
                    final sesion? => () => _abrirEdicion(context, sesion),
                    null => null,
                  },
                ),
              ],
            ],
          ),
        },
      ),
    );
  }

  /// Abre la sesión del récord en el formulario (RF-8) y, al volver,
  /// recalcula los récords (RF-9).
  Future<void> _abrirEdicion(BuildContext context, Session sesion) async {
    final cubit = context.read<RecordsCubit>();
    await editarSesion(context, sesion);
    await cubit.cargar();
  }
}

/// Un récord (spec 004, RF-1 a RF-3; spec 005, RF-29 y RF-30): icono en una
/// caja ámbar, nombre, valor y unidad, fecha de su sesión y chevron. Sin
/// datos, solo el icono, el nombre y "Sin datos". Solo se puede tocar si
/// tiene sesión (RF-8).
class _TarjetaRecord extends StatelessWidget {
  const _TarjetaRecord({required this.record, required this.onTap});

  final RecordPersonal record;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final secundario = tema.textTheme.bodySmall?.copyWith(
      color: colores.onSurfaceVariant,
    );
    final sesion = record.sesion;
    final (nombre, icono) = switch (record.tipo) {
      TipoRecord.tiempo => ('Sesión más larga', Icons.timer_outlined),
      TipoRecord.distancia => ('Mayor distancia', Icons.route_rounded),
      TipoRecord.velocidadMax => (
        'Mayor velocidad máxima',
        Icons.speed_rounded,
      ),
      TipoRecord.pulsoMax => (
        'Mayor pulso máximo',
        Icons.monitor_heart_outlined,
      ),
    };

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.margen),
          child: Row(
            children: [
              Container(
                width: Dimens.cajaIcono,
                height: Dimens.cajaIcono,
                decoration: BoxDecoration(
                  color: colores.secondaryContainer,
                  borderRadius: BorderRadius.circular(Dimens.radioCampo),
                ),
                child: Icon(icono, color: colores.onSecondaryContainer),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: secundario?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (sesion == null)
                      Text('Sin datos', style: tema.textTheme.bodyMedium)
                    else ...[
                      _Valor(partes: _valorYUnidad(record.tipo, sesion)),
                      Text(formatearFecha(sesion.fecha), style: secundario),
                    ],
                  ],
                ),
              ),
              if (sesion != null)
                Icon(
                  Icons.chevron_right_rounded,
                  color: colores.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Valor grande de un récord con su unidad pequeña al lado.
class _Valor extends StatelessWidget {
  const _Valor({required this.partes});

  final (String, String) partes;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final (valor, unidad) = partes;
    return Text.rich(
      TextSpan(
        text: valor,
        style: tema.textTheme.headlineSmall,
        children: [
          if (unidad.isNotEmpty)
            TextSpan(
              text: ' $unidad',
              style: tema.textTheme.bodySmall?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

/// Valor y unidad por separado, con los formatos del historial (spec 001):
/// "1:30:00", ("42,5", "km"), ("38", "km/h"), ("172", "ppm").
(String, String) _valorYUnidad(TipoRecord tipo, Session sesion) =>
    switch (tipo) {
      TipoRecord.tiempo => (formatearTiempo(sesion.tiempo), ''),
      TipoRecord.distancia => (formatearDecimal(sesion.distancia), 'km'),
      TipoRecord.velocidadMax => switch (sesion.velocidadMax) {
        final v? => (formatearEntero(v), 'km/h'),
        null => ('', ''),
      },
      TipoRecord.pulsoMax => switch (sesion.pulsoMax) {
        final p? => (formatearEntero(p), 'ppm'),
        null => ('', ''),
      },
    };
