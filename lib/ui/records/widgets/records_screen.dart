/// Récords personales por sesión (spec 004).
///
/// Solo pinta el estado de [RecordsCubit]; el `BlocProvider` lo crea el
/// router. Tocar un récord con valor abre la edición de su sesión (RF-8) y,
/// al volver, recarga (RF-9).
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/record_personal.dart';
import '../../../domain/models/session.dart';
import '../../../utils/formatters.dart';
import '../../core/ui/editar_sesion.dart';
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
          RecordsStatus.error => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No se pudieron cargar los récords.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          RecordsStatus.ready => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // RF-4 / RC-2: sin sesiones, los récords con un aviso encima.
              if (state.sinSesiones) const _AvisoSinSesiones(),
              for (final record in state.records)
                _TarjetaRecord(
                  record: record,
                  onTap: switch (record.sesion) {
                    final sesion? => () => _abrirEdicion(context, sesion),
                    null => null,
                  },
                ),
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

class _AvisoSinSesiones extends StatelessWidget {
  const _AvisoSinSesiones();

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Card(
      color: colores.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: colores.onSecondaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Aún no hay récords. Registra tu primera sesión con '
                '«Registrar sesión» en el inicio.',
                style: TextStyle(color: colores.onSecondaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Un récord: nombre, fecha de su sesión (o "Sin datos") y valor (RF-1 a
/// RF-3). Solo se puede tocar si tiene sesión (RF-8).
class _TarjetaRecord extends StatelessWidget {
  const _TarjetaRecord({required this.record, required this.onTap});

  final RecordPersonal record;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final sesion = record.sesion;
    final nombre = switch (record.tipo) {
      TipoRecord.tiempo => 'Sesión más larga',
      TipoRecord.distancia => 'Mayor distancia',
      TipoRecord.velocidadMax => 'Mayor velocidad máxima',
      TipoRecord.pulsoMax => 'Mayor pulso máximo',
    };

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(nombre),
        subtitle: Text(
          sesion == null ? 'Sin datos' : formatearFecha(sesion.fecha),
        ),
        trailing: sesion == null
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _valor(record.tipo, sesion),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
      ),
    );
  }

  /// Valor con el mismo formato que el historial (spec 001).
  static String _valor(TipoRecord tipo, Session sesion) => switch (tipo) {
    TipoRecord.tiempo => formatearTiempo(sesion.tiempo),
    TipoRecord.distancia => formatearKm(sesion.distancia),
    TipoRecord.velocidadMax => switch (sesion.velocidadMax) {
      final v? => formatearVelocidadMax(v),
      null => '',
    },
    TipoRecord.pulsoMax => switch (sesion.pulsoMax) {
      final p? => formatearPulso(p),
      null => '',
    },
  };
}
