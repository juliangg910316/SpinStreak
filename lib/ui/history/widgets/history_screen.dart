/// Historial de sesiones agrupado por día, con los totales de cada día.
///
/// Solo pinta el estado de [HistoryCubit]; el `BlocProvider` lo crea el
/// router. Tocar una sesión abre su edición (RF-13) y, al volver, recarga.
/// Aspecto según la spec 005 (RF-16, RF-17 y RF-25).
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/session.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/dia_historial_widgets.dart';
import '../../core/ui/editar_sesion.dart';
import '../../core/ui/estado_error.dart';
import '../../core/ui/tarjeta_aviso.dart';
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
          HistoryStatus.error => const EstadoError(
            'No se pudo cargar el historial.',
          ),
          // RF-12 / RC-2: sin sesiones, explica cómo empezar (spec 005,
          // RF-17: tarjeta neutra).
          HistoryStatus.ready when state.dias.isEmpty => const Padding(
            padding: EdgeInsets.fromLTRB(Dimens.margen, 8, Dimens.margen, 0),
            child: TarjetaAviso(
              icono: Icons.history_rounded,
              texto:
                  'Aún no hay sesiones. Registra la primera con «Registrar '
                  'sesión» en el inicio.',
            ),
          ),
          // Spec 005, RF-25: un bloque por día, separados 20 px.
          HistoryStatus.ready => ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              Dimens.margen,
              8,
              Dimens.margen,
              24,
            ),
            itemCount: state.dias.length,
            separatorBuilder: (_, _) => const SizedBox(height: 20),
            itemBuilder: (context, i) => TarjetaDia(
              dia: state.dias[i],
              onTapSesion: (sesion) => _abrirEdicion(context, sesion),
            ),
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
