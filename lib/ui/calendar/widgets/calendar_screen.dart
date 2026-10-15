/// Calendario mensual de días entrenados (spec 003).
///
/// Solo pinta el estado de [CalendarCubit]; el `BlocProvider` lo crea el
/// router. La cuadrícula sale de `construirMes` (dominio): aquí solo se le da
/// aspecto a cada celda.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/calendar_month.dart';
import '../../../domain/models/mes_calendario.dart';
import '../../../domain/models/session.dart';
import '../../../utils/formatters.dart';
import '../../core/ui/dia_historial_widgets.dart';
import '../../core/ui/editar_sesion.dart';
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
          CalendarStatus.error => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No se pudo cargar el calendario.',
                textAlign: TextAlign.center,
              ),
            ),
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        // RF-13 / RC-2: sin sesiones, el calendario se ve igual con un aviso.
        if (state.sinSesiones) const _AvisoSinSesiones(),
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
        if (state.diaSeleccionado case final dia?) ...[
          // RF-7: mismo formato que el historial.
          CabeceraDia(dia: dia),
          for (final sesion in dia.sesiones)
            FilaSesion(
              sesion: sesion,
              onTap: () => _abrirEdicion(context, sesion),
            ),
        ] else if (seleccionado != null)
          // RF-16: hoy seleccionado y sin sesiones.
          _HoySinSesiones(dia: seleccionado)
        else
          // RF-9.
          Text(
            'Toca un día marcado para ver sus sesiones.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
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
/// `CabeceraDia`, y debajo el mensaje de RF-16.
class _HoySinSesiones extends StatelessWidget {
  const _HoySinSesiones({required this.dia});

  final DateTime dia;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: tema.colorScheme.surfaceContainerHighest,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          margin: const EdgeInsets.only(top: 8),
          child: Text(formatearFecha(dia), style: tema.textTheme.titleSmall),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Hoy aún no has entrenado. Registra una sesión con «Registrar '
            'sesión» en el inicio.',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
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
                'Aún no hay días entrenados. Registra tu primera sesión con '
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
          icon: const Icon(Icons.chevron_left),
        ),
        Expanded(
          child: Text(
            formatearMes(mes.mes),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          // RF-3: desactivada en el mes de hoy.
          onPressed: mes.puedeAvanzar ? cubit.mesSiguiente : null,
          tooltip: 'Mes siguiente',
          icon: const Icon(Icons.chevron_right),
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
    final estilo = Theme.of(context).textTheme.labelMedium;
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

/// Un día: círculo de color si está entrenado (RF-4), borde si es hoy (RF-5),
/// número en gris si es futuro (RF-6) y anillo con sombra si está
/// seleccionado (RF-7). Solo se pueden pulsar los días entrenados y hoy
/// (RF-7, RF-8).
class _Celda extends StatelessWidget {
  const _Celda({required this.celda, required this.seleccionada});

  final CeldaDia celda;
  final bool seleccionada;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final colorNumero = celda.entrenado
        ? colores.onPrimary
        : celda.esFuturo
        ? colores.onSurface.withValues(alpha: 0.38)
        : colores.onSurface;

    final circulo = Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: celda.entrenado ? colores.primary : null,
        border: celda.esHoy
            ? Border.all(color: colores.tertiary, width: 2)
            : null,
      ),
      child: Text(
        '${celda.dia.day}',
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: colorNumero),
      ),
    );

    return SizedBox(
      height: _altoCelda,
      child: Center(
        child: GestureDetector(
          onTap: celda.seleccionable
              ? () => context.read<CalendarCubit>().seleccionarDia(celda.dia)
              : null,
          // El anillo de selección rodea el círculo, así que se ve a la vez
          // que el fondo de entrenado y el borde de hoy.
          // Mismo tamaño con y sin anillo (40 + 2 × 4), para que la
          // cuadrícula no se mueva al seleccionar.
          child: Container(
            padding: EdgeInsets.all(seleccionada ? 1 : 4),
            decoration: seleccionada
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colores.secondary, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: colores.shadow.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                : null,
            child: circulo,
          ),
        ),
      ),
    );
  }
}
