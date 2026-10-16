/// Pantalla de inicio: fecha de hoy, mensaje del día, racha actual, mejor
/// racha y total de días (spec 002).
///
/// Solo pinta el estado de [HomeCubit]; el `BlocProvider` lo crea el router.
/// Desde aquí se registra una sesión y se abren el historial (spec 001) y el
/// calendario (spec 003) y los récords (spec 004). La
/// racha se recarga al volver de otra pantalla y al volver la app al primer
/// plano (RF-6, RF-13).
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/mensaje_dia.dart';
import '../../../domain/models/record_personal.dart';
import '../../../routing/route_names.dart';
import '../../../utils/formatters.dart';
import '../../session_form/view_model/session_form_state.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AppLifecycleListener _ciclo;

  @override
  void initState() {
    super.initState();
    // RF-13: al volver la app al primer plano, recalcula con la fecha actual.
    _ciclo = AppLifecycleListener(
      onResume: () => context.read<HomeCubit>().cargar(),
    );
  }

  @override
  void dispose() {
    _ciclo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SpinStreak')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _registrarSesion,
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
              if (state.hoy case final hoy?)
                Text(
                  formatearFecha(hoy),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              const SizedBox(height: 16),
              // RF-8 a RF-12: un único mensaje, encima de los contadores.
              if (state.mensaje case final mensaje?) ...[
                _TarjetaMensaje(mensaje: mensaje),
                const SizedBox(height: 8),
              ],
              _StatTile(label: 'Racha actual', value: state.streak.current),
              _StatTile(label: 'Mejor racha', value: state.streak.best),
              _StatTile(
                label: 'Días entrenados',
                value: state.streak.totalDays,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _abrir(RouteNames.history),
                icon: const Icon(Icons.history),
                label: const Text('Historial'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _abrir(RouteNames.calendar),
                icon: const Icon(Icons.calendar_month),
                label: const Text('Calendario'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _abrir(RouteNames.records),
                icon: const Icon(Icons.emoji_events),
                label: const Text('Récords'),
              ),
            ],
          ),
        },
      ),
    );
  }

  /// Abre el formulario vacío y, al volver, recarga la racha. Si se guardó,
  /// muestra "Sesión guardada" o el aviso de récord (spec 004, RF-10, RF-11).
  Future<void> _registrarSesion() async {
    final cubit = context.read<HomeCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final resultado = await Navigator.of(context)
        .pushNamed<ResultadoFormulario>(RouteNames.sessionForm);
    await cubit.cargar();

    if (resultado case ResultadoFormulario(
      status: SessionFormStatus.guardada,
      :final recordsBatidos,
    )) {
      messenger.showSnackBar(
        SnackBar(content: Text(_textoGuardada(recordsBatidos))),
      );
    }
  }

  /// Abre una pantalla secundaria (historial, calendario o récords) y, al volver,
  /// recarga la racha (pudo editarse o borrarse alguna sesión).
  Future<void> _abrir(String ruta) async {
    final cubit = context.read<HomeCubit>();
    await Navigator.of(context).pushNamed(ruta);
    await cubit.cargar();
  }
}

/// "Sesión guardada", con el aviso de los récords batidos si los hay:
/// "¡Nuevo récord de distancia!" o "¡Nuevos récords de tiempo, distancia y
/// pulso máximo!" (spec 004, RF-10). Los nombres van en el orden recibido,
/// que es el de `TipoRecord`.
String _textoGuardada(List<TipoRecord> batidos) {
  final lista = [
    for (final tipo in batidos)
      switch (tipo) {
        TipoRecord.tiempo => 'tiempo',
        TipoRecord.distancia => 'distancia',
        TipoRecord.velocidadMax => 'velocidad máxima',
        TipoRecord.pulsoMax => 'pulso máximo',
      },
  ];
  return switch (lista) {
    [] => 'Sesión guardada',
    [final unico] => 'Sesión guardada. ¡Nuevo récord de $unico!',
    [...final primeros, final ultimo] =>
      'Sesión guardada. ¡Nuevos récords de ${primeros.join(', ')} y $ultimo!',
  };
}

/// Tarjeta con el mensaje del día (RF-8 a RF-11), con colores del tema.
class _TarjetaMensaje extends StatelessWidget {
  const _TarjetaMensaje({required this.mensaje});

  final MensajeDia mensaje;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final (icono, fondo, texto, contenido) = switch (mensaje) {
      Bienvenida() => (
        Icons.waving_hand_outlined,
        colores.secondaryContainer,
        colores.onSecondaryContainer,
        'Aún no has registrado ninguna sesión. Toca «Registrar sesión» para '
            'empezar tu racha.',
      ),
      ASalvo() => (
        Icons.check_circle_outline,
        colores.primaryContainer,
        colores.onPrimaryContainer,
        'Hoy ya has entrenado. ¡Racha a salvo!',
      ),
      Riesgo(:final dias) => (
        Icons.warning_amber_outlined,
        colores.errorContainer,
        colores.onErrorContainer,
        'Entrena hoy para mantener tu racha de ${formatearDias(dias)}.',
      ),
      Reiniciada(:final mejorRacha) => (
        Icons.restart_alt,
        colores.secondaryContainer,
        colores.onSecondaryContainer,
        'Tu racha se ha reiniciado. Tu mejor racha es de '
            '${formatearDias(mejorRacha)}: registra una sesión hoy para '
            'empezar una nueva.',
      ),
    };

    return Card(
      color: fondo,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icono, color: texto),
            const SizedBox(width: 12),
            Expanded(
              child: Text(contenido, style: TextStyle(color: texto)),
            ),
          ],
        ),
      ),
    );
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
