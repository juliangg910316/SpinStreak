/// Pantalla de inicio: racha actual, mejor racha y total de días.
///
/// Solo pinta el estado de [HomeCubit]; el `BlocProvider` lo crea el router.
/// Desde aquí se registra una sesión y se abre el historial (spec 001); al
/// volver de cualquiera de las dos, recarga la racha.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../routing/route_names.dart';
import '../../session_form/view_model/session_form_state.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateFormat.yMMMMEEEEd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('SpinStreak')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _registrarSesion(context),
        icon: const Icon(Icons.add),
        label: const Text('Registrar sesión'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => switch (state.status) {
          HomeStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          HomeStatus.error => const Center(
            child: Text('No se pudieron cargar los datos'),
          ),
          HomeStatus.ready => ListView(
            // Margen inferior para que el botón flotante no tape contenido.
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              Text(today, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              _StatTile(label: 'Racha actual', value: state.streak.current),
              _StatTile(label: 'Mejor racha', value: state.streak.best),
              _StatTile(
                label: 'Días entrenados',
                value: state.streak.totalDays,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _abrirHistorial(context),
                icon: const Icon(Icons.history),
                label: const Text('Historial'),
              ),
            ],
          ),
        },
      ),
    );
  }

  /// Abre el formulario vacío y, al volver, recarga la racha. Si se guardó,
  /// muestra "Sesión guardada".
  Future<void> _registrarSesion(BuildContext context) async {
    final cubit = context.read<HomeCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final resultado = await Navigator.of(context)
        .pushNamed<SessionFormStatus>(RouteNames.sessionForm);
    await cubit.cargar();

    if (resultado == SessionFormStatus.guardada) {
      messenger.showSnackBar(const SnackBar(content: Text('Sesión guardada')));
    }
  }

  /// Abre el historial y, al volver, recarga la racha (pudo editarse o
  /// borrarse alguna sesión).
  Future<void> _abrirHistorial(BuildContext context) async {
    final cubit = context.read<HomeCubit>();
    await Navigator.of(context).pushNamed(RouteNames.history);
    await cubit.cargar();
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(
          NumberFormat.decimalPattern().format(value),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
