/// Pantalla de inicio: fecha de hoy, mensaje del día, racha actual, mejor
/// racha y total de días (spec 002), con el diseño de la spec 005 (RF-9 a
/// RF-14).
///
/// Solo pinta el estado de [HomeCubit]; el `BlocProvider` lo crea el router.
/// Desde aquí se registra una sesión y se abren el historial (spec 001) y el
/// calendario (spec 003) y los récords (spec 004). La
/// racha se recarga al volver de otra pantalla y al volver la app al primer
/// plano (RF-6, RF-13).
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/mensaje_dia.dart';
import '../../../domain/models/record_personal.dart';
import '../../../routing/route_names.dart';
import '../../../utils/formatters.dart';
import '../../core/themes/colores_app.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/aviso.dart';
import '../../core/ui/estado_error.dart';
import '../../core/ui/tarjeta_aviso.dart';
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
    final tema = Theme.of(context);
    final app = tema.extension<ColoresApp>()!;

    return Scaffold(
      // Spec 005, RF-9: "Streak" en el color principal.
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: 'Spin',
            children: [
              TextSpan(
                text: 'Streak',
                style: TextStyle(color: app.textoPrincipal),
              ),
            ],
          ),
        ),
      ),
      // Con el texto del sistema muy grande, el botón no cabría en la
      // pantalla: su texto crece como mucho 1,5 veces (spec 005, RF-12).
      floatingActionButton: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.5,
        child: FloatingActionButton.extended(
          onPressed: _registrarSesion,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Registrar sesión'),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => switch (state.status) {
          HomeStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          HomeStatus.error => const EstadoError(
            'No se pudieron cargar los datos',
          ),
          HomeStatus.ready => ListView(
            // Margen inferior para que el botón flotante no tape contenido
            // (spec 005, RF-12).
            padding: const EdgeInsets.fromLTRB(
              Dimens.margen,
              4,
              Dimens.margen,
              96,
            ),
            children: [
              if (state.hoy case final hoy?)
                Text(
                  formatearFecha(hoy),
                  style: tema.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: tema.colorScheme.onSurfaceVariant,
                  ),
                ),
              const SizedBox(height: 12),
              // RF-8 a RF-12 (spec 002): un único mensaje, encima de los
              // contadores.
              if (state.mensaje case final mensaje?) ...[
                _TarjetaMensaje(mensaje: mensaje),
                const SizedBox(height: Dimens.margen),
              ],
              _TarjetaRacha(dias: state.streak.current),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _Contador(
                      icono: Icon(
                        Icons.local_fire_department_rounded,
                        size: 18,
                        color: app.racha,
                      ),
                      etiqueta: 'Mejor racha',
                      valor: state.streak.best,
                      colorValor: app.racha,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Contador(
                      icono: Icon(
                        Icons.event_available_rounded,
                        size: 18,
                        color: tema.colorScheme.onSurfaceVariant,
                      ),
                      etiqueta: 'Días entrenados',
                      valor: state.streak.totalDays,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Explorar',
                style: tema.textTheme.labelLarge?.copyWith(
                  color: tema.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _Acceso(
                      icono: Icons.history_rounded,
                      etiqueta: 'Historial',
                      onTap: () => _abrir(RouteNames.history),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Acceso(
                      icono: Icons.calendar_month_rounded,
                      etiqueta: 'Calendario',
                      onTap: () => _abrir(RouteNames.calendar),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Acceso(
                      icono: Icons.emoji_events_rounded,
                      etiqueta: 'Récords',
                      onTap: () => _abrir(RouteNames.records),
                    ),
                  ),
                ],
              ),
            ],
          ),
        },
      ),
    );
  }

  /// Abre el formulario vacío y, al volver, recarga la racha. Si se guardó,
  /// muestra "Sesión guardada" o el aviso de récord (spec 004, RF-10, RF-11),
  /// este en ámbar y con trofeo (spec 005, RF-13).
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
      final hayRecord = recordsBatidos.isNotEmpty;
      mostrarAviso(
        messenger,
        _textoGuardada(recordsBatidos),
        icono: hayRecord
            ? Icons.emoji_events_rounded
            : Icons.check_circle_rounded,
        record: hayRecord,
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

/// Unidad que acompaña a un número: singular solo con 1 (spec 005, RF-10 y
/// RF-10b).
String _unidad(int n, String singular, String plural) =>
    n == 1 ? singular : plural;

/// Mensaje del día (spec 002, RF-8 a RF-11) con su icono y su color
/// (spec 005, RF-11).
class _TarjetaMensaje extends StatelessWidget {
  const _TarjetaMensaje({required this.mensaje});

  final MensajeDia mensaje;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return switch (mensaje) {
      Bienvenida() => const TarjetaAviso(
        icono: Icons.waving_hand_rounded,
        texto:
            'Aún no has registrado ninguna sesión. Toca «Registrar sesión» '
            'para empezar tu racha.',
      ),
      ASalvo() => TarjetaAviso(
        icono: Icons.check_circle_rounded,
        texto: 'Hoy ya has entrenado. ¡Racha a salvo!',
        fondo: colores.primaryContainer,
        colorIcono: colores.onPrimaryContainer,
        destacado: true,
      ),
      Riesgo(:final dias) => TarjetaAviso(
        icono: Icons.warning_amber_rounded,
        texto: 'Entrena hoy para mantener tu racha de ${formatearDias(dias)}.',
        fondo: colores.secondaryContainer,
        colorIcono: colores.onSecondaryContainer,
        conBorde: true,
        destacado: true,
      ),
      Reiniciada(:final mejorRacha) => TarjetaAviso(
        icono: Icons.restart_alt_rounded,
        texto:
            'Tu racha se ha reiniciado. Tu mejor racha es de '
            '${formatearDias(mejorRacha)}: registra una sesión hoy para '
            'empezar una nueva.',
        conBorde: true,
      ),
    };
  }
}

/// Racha actual: llama, número grande en el acento de la racha, "Racha
/// actual" y su unidad (spec 005, RF-3, RF-10 y RF-14).
class _TarjetaRacha extends StatelessWidget {
  const _TarjetaRacha({required this.dias});

  final int dias;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final app = tema.extension<ColoresApp>()!;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radioGrande),
        side: BorderSide(color: tema.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: app.rachaContenedor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_fire_department_rounded,
                size: 32,
                color: app.racha,
              ),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                formatearEntero(dias),
                style: tema.textTheme.displayLarge?.copyWith(color: app.racha),
              ),
            ),
            Text(
              'Racha actual',
              style: tema.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              _unidad(dias, 'día seguido', 'días seguidos'),
              style: tema.textTheme.bodySmall?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Mejor racha o días entrenados: icono, etiqueta, número y unidad
/// (spec 005, RF-9, RF-10b y RF-14).
class _Contador extends StatelessWidget {
  const _Contador({
    required this.icono,
    required this.etiqueta,
    required this.valor,
    this.colorValor,
  });

  final Widget icono;
  final String etiqueta;
  final int valor;

  /// Color del número; por defecto, el del texto. La mejor racha usa el
  /// acento de la racha (RF-3).
  final Color? colorValor;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final secundario = tema.colorScheme.onSurfaceVariant;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icono,
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    etiqueta,
                    style: tema.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: secundario,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      formatearEntero(valor),
                      style: tema.textTheme.headlineMedium?.copyWith(
                        color: colorValor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    _unidad(valor, 'día', 'días'),
                    style: tema.textTheme.bodySmall?.copyWith(
                      color: secundario,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Acceso a una pantalla secundaria bajo "Explorar" (spec 005, RF-9).
class _Acceso extends StatelessWidget {
  const _Acceso({
    required this.icono,
    required this.etiqueta,
    required this.onTap,
  });

  final IconData icono;
  final String etiqueta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final app = tema.extension<ColoresApp>()!;

    return Material(
      color: tema.colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 76),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icono, color: app.botonTexto),
                const SizedBox(height: 6),
                Text(
                  etiqueta,
                  textAlign: TextAlign.center,
                  style: tema.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
