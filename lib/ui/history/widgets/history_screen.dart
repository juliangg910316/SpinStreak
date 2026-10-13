/// Historial de sesiones agrupado por día, con los totales de cada día.
///
/// Solo pinta el estado de [HistoryCubit]; el `BlocProvider` lo crea el
/// router. Tocar una sesión abre su edición (RF-13) y, al volver, recarga.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/dia_historial.dart';
import '../../../domain/models/session.dart';
import '../../../routing/route_names.dart';
import '../../../utils/formatters.dart';
import '../../session_form/view_model/session_form_state.dart';
import '../view_model/history_cubit.dart';
import '../view_model/history_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) => switch (state.status) {
          HistoryStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          HistoryStatus.error => const _Mensaje(
            'No se pudo cargar el historial.',
          ),
          // RF-12 / RC-2: sin sesiones, explica cómo empezar.
          HistoryStatus.ready when state.dias.isEmpty => const _Mensaje(
            'Aún no hay sesiones. Registra la primera con «Registrar sesión» '
            'en el inicio.',
          ),
          HistoryStatus.ready => ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              for (final dia in state.dias) ...[
                _CabeceraDia(dia: dia),
                for (final sesion in dia.sesiones)
                  _FilaSesion(
                    sesion: sesion,
                    onTap: () => _abrirEdicion(context, sesion),
                  ),
              ],
            ],
          ),
        },
      ),
    );
  }

  /// Abre la sesión en el formulario y, al volver, recarga el historial y
  /// muestra el resultado.
  Future<void> _abrirEdicion(BuildContext context, Session sesion) async {
    final cubit = context.read<HistoryCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final resultado = await Navigator.of(
      context,
    ).pushNamed<SessionFormStatus>(RouteNames.sessionForm, arguments: sesion);
    await cubit.cargar();

    final mensaje = switch (resultado) {
      SessionFormStatus.actualizada => 'Sesión actualizada',
      SessionFormStatus.borrada => 'Sesión borrada',
      _ => null,
    };
    if (mensaje != null) {
      messenger.showSnackBar(SnackBar(content: Text(mensaje)));
    }
  }
}

/// Cabecera de un día con sus totales (RF-10).
class _CabeceraDia extends StatelessWidget {
  const _CabeceraDia({required this.dia});

  final DiaHistorial dia;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final totales = [
      if (dia.numSesiones > 1) '${dia.numSesiones} sesiones',
      formatearKm(dia.distanciaTotal),
      formatearTiempo(dia.tiempoTotal),
      formatearKcal(dia.caloriasTotal),
    ].join(' · ');

    return Container(
      width: double.infinity,
      color: tema.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formatearFecha(dia.dia), style: tema.textTheme.titleSmall),
          Text(totales, style: tema.textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// Una sesión: hora, tiempo, distancia, velocidad media y calorías (RF-11).
class _FilaSesion extends StatelessWidget {
  const _FilaSesion({required this.sesion, required this.onTap});

  final Session sesion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(
        formatearHora(sesion.fecha),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      title: Text(
        '${formatearTiempo(sesion.tiempo)} · ${formatearKm(sesion.distancia)}',
      ),
      subtitle: Text(
        '${formatearKmh(sesion.velocidadMedia)} · '
        '${formatearKcal(sesion.calorias)}',
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class _Mensaje extends StatelessWidget {
  const _Mensaje(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(texto, textAlign: TextAlign.center),
      ),
    );
  }
}
