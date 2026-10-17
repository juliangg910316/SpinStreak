/// Calendario mensual de días entrenados (spec 003).
///
/// Solo pinta el estado de [CalendarCubit]; el `BlocProvider` lo crea el
/// router. La cuadrícula sale de `construirMes` (dominio): aquí solo se le da
/// aspecto a cada celda. Aspecto según la spec 005 (RF-16, RF-17, RF-26 a
/// RF-28b): cambian los estilos, no el orden ni el comportamiento.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/calendar_month.dart';
import '../../../domain/models/mes_calendario.dart';
import '../../../domain/models/session.dart';
import '../../../utils/formatters.dart';
import '../../core/themes/colores_app.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/dia_historial_widgets.dart';
import '../../core/ui/editar_sesion.dart';
import '../../core/ui/estado_error.dart';
import '../../core/ui/tarjeta_aviso.dart';
import '../view_model/calendar_cubit.dart';
import '../view_model/calendar_state.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario')),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) => switch (state.status) {
          CalendarStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          // RF-14.
          CalendarStatus.error => const EstadoError(
            'No se pudo cargar el calendario.',
          ),
          CalendarStatus.ready => _Contenido(state: state),
        },
      ),
    );
  }
}

class _Contenido extends StatelessWidget {
  const _Contenido({required this.state});

  final CalendarState state;

  @override
  Widget build(BuildContext context) {
    final mes = state.mes;
    if (mes == null) return const SizedBox.shrink();
    final seleccionado = state.seleccionado;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.margen, 8, Dimens.margen, 24),
      children: [
        // RF-13 / RC-2: sin sesiones, el calendario se ve igual con un aviso
        // encima (spec 005, RF-28b).
        if (state.sinSesiones) ...[
          const TarjetaAviso(
            icono: Icons.calendar_month_rounded,
            texto:
                'Aún no hay días entrenados. Registra tu primera sesión con '
                '«Registrar sesión» en el inicio.',
          ),
          const SizedBox(height: Dimens.margen),
        ],
        _CabeceraMes(mes: mes),
        const _Iniciales(),
        for (final semana in mes.semanas)
          Row(
            children: [
              for (final celda in semana)
                Expanded(
                  child: celda == null
                      ? const SizedBox(height: _altoCelda)
                      : _Celda(
                          celda: celda,
                          seleccionada:
                              seleccionado != null &&
                              mismoDia(celda.dia, seleccionado),
                        ),
                ),
            ],
          ),
        const SizedBox(height: 16),
        if (state.diaSeleccionado case final dia?)
          // RF-7: mismo formato que el historial (spec 005, RF-28).
          TarjetaDia(
            dia: dia,
            onTapSesion: (sesion) => _abrirEdicion(context, sesion),
          )
        else if (seleccionado != null)
          // RF-16: hoy seleccionado y sin sesiones.
          _HoySinSesiones(dia: seleccionado)
        else
          // RF-9.
          Text(
            'Toca un día marcado para ver sus sesiones.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }

  /// Abre la sesión en el formulario (RF-11) y, al volver, recarga el
  /// calendario y el día seleccionado (RF-12).
  Future<void> _abrirEdicion(BuildContext context, Session sesion) async {
    final cubit = context.read<CalendarCubit>();
    await editarSesion(context, sesion);
    await cubit.cargar();
  }
}

/// Alto de cada fila de la cuadrícula: deja un círculo de 40 px cómodo de
/// pulsar con el dedo.
const _altoCelda = 48.0;

/// Hoy seleccionado sin sesiones: la fecha, con el mismo aspecto que
/// `CabeceraDia`, y debajo el mensaje de RF-16 en una tarjeta neutra.
class _HoySinSesiones extends StatelessWidget {
  const _HoySinSesiones({required this.dia});

  final DateTime dia;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            formatearFecha(dia),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: 8),
        const TarjetaAviso(
          icono: Icons.today_rounded,
          texto:
              'Hoy aún no has entrenado. Registra una sesión con «Registrar '
              'sesión» en el inicio.',
        ),
      ],
    );
  }
}

/// ‹ "octubre de 2026" › (RF-1 a RF-3).
class _CabeceraMes extends StatelessWidget {
  const _CabeceraMes({required this.mes});

  final MesCalendario mes;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalendarCubit>();
    return Row(
      children: [
        IconButton(
          onPressed: cubit.mesAnterior,
          tooltip: 'Mes anterior',
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Expanded(
          child: Text(
            formatearMes(mes.mes),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          // RF-3: desactivada en el mes de hoy (spec 005, RF-27).
          onPressed: mes.puedeAvanzar ? cubit.mesSiguiente : null,
          tooltip: 'Mes siguiente',
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

/// Iniciales de lunes a domingo.
class _Iniciales extends StatelessWidget {
  const _Iniciales();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final estilo = tema.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: tema.colorScheme.onSurfaceVariant,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          for (final inicial in const ['L', 'M', 'X', 'J', 'V', 'S', 'D'])
            Expanded(
              child: Text(inicial, textAlign: TextAlign.center, style: estilo),
            ),
        ],
      ),
    );
  }
}

/// Un día (spec 003, RF-4 a RF-8; spec 005, RF-26): círculo naranja con el
/// número oscuro si está entrenado, borde interior si es hoy, número
/// atenuado si es futuro y anillo exterior si está seleccionado. Solo se
/// pueden pulsar los días entrenados y hoy.
class _Celda extends StatelessWidget {
  const _Celda({required this.celda, required this.seleccionada});

  final CeldaDia celda;
  final bool seleccionada;

  /// Anillo de selección y su separación del círculo: 40 + 2 × (1,5 + 2,5)
  /// = 48, el alto de la celda, para que la cuadrícula no se mueva.
  static const _anchoAnillo = 2.5;
  static const _separacion = 1.5;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final app = tema.extension<ColoresApp>()!;
    final colorNumero = celda.entrenado
        ? colores.onPrimary
        : celda.esFuturo
        ? colores.onSurfaceVariant.withValues(alpha: 0.45)
        : colores.onSurface;

    final circulo = Container(
      width: Dimens.circuloDia,
      height: Dimens.circuloDia,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: celda.entrenado ? colores.primary : null,
        border: celda.esHoy
            ? Border.all(color: colores.onSurface, width: 2)
            : null,
      ),
      child: Text(
        '${celda.dia.day}',
        style: tema.textTheme.labelLarge?.copyWith(
          color: colorNumero,
          fontWeight: celda.entrenado || celda.esHoy
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    );

    return SizedBox(
      height: _altoCelda,
      child: Center(
        child: GestureDetector(
          onTap: celda.seleccionable
              ? () => context.read<CalendarCubit>().seleccionarDia(celda.dia)
              : null,
          // El anillo rodea el círculo, así que se ve a la vez que el fondo
          // de entrenado y el borde de hoy.
          child: Container(
            padding: EdgeInsets.all(
              seleccionada ? _separacion : _separacion + _anchoAnillo,
            ),
            decoration: seleccionada
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: app.textoPrincipal,
                      width: _anchoAnillo,
                    ),
                  )
                : null,
            child: circulo,
          ),
        ),
      ),
    );
  }
}
