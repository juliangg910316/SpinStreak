/// Historial de sesiones agrupado por día, con los totales de cada día.
///
/// Solo pinta el estado de [HistoryCubit]; el `BlocProvider` lo crea el
/// router. Tocar una sesión abre su edición (RF-13) y, al volver, recarga.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/session.dart';
import '../../core/ui/dia_historial_widgets.dart';
import '../../core/ui/editar_sesion.dart';
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
                CabeceraDia(dia: dia),
                for (final sesion in dia.sesiones)
                  FilaSesion(
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

  /// Abre la sesión en el formulario y, al volver, recarga el historial.
  Future<void> _abrirEdicion(BuildContext context, Session sesion) async {
    final cubit = context.read<HistoryCubit>();
    await editarSesion(context, sesion);
    await cubit.cargar();
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
