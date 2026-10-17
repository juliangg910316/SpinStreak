/// Cabecera de un día y fila de sesión con el formato del historial
/// (spec 001, RF-10 y RF-11). Se comparten con el calendario (spec 003, RF-7).
/// Aspecto según la spec 005 (RF-25, RF-28): cabecera sin fondo y sesiones
/// dentro de una tarjeta.
library;

import 'package:flutter/material.dart';

import '../../../domain/models/dia_historial.dart';
import '../../../domain/models/session.dart';
import '../../../utils/formatters.dart';
import '../themes/dimens.dart';

/// Un día: su cabecera y, debajo, sus sesiones en una tarjeta separadas por
/// líneas de 1 px (spec 005, RF-25).
class TarjetaDia extends StatelessWidget {
  const TarjetaDia({required this.dia, required this.onTapSesion, super.key});

  final DiaHistorial dia;
  final ValueChanged<Session> onTapSesion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CabeceraDia(dia: dia),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (i, sesion) in dia.sesiones.indexed) ...[
                if (i > 0) const Divider(),
                FilaSesion(sesion: sesion, onTap: () => onTapSesion(sesion)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Cabecera de un día con sus totales (RF-10).
class CabeceraDia extends StatelessWidget {
  const CabeceraDia({required this.dia, super.key});

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formatearFecha(dia.dia), style: tema.textTheme.titleSmall),
          const SizedBox(height: 2),
          Text(
            totales,
            style: tema.textTheme.bodySmall?.copyWith(
              color: tema.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Una sesión: hora, tiempo, distancia, velocidad media y calorías (RF-11).
class FilaSesion extends StatelessWidget {
  const FilaSesion({required this.sesion, required this.onTap, super.key});

  final Session sesion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final secundario = tema.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.margen, 10, 12, 10),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  formatearHora(sesion.fecha),
                  style: tema.textTheme.labelLarge?.copyWith(color: secundario),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${formatearTiempo(sesion.tiempo)} · '
                      '${formatearKm(sesion.distancia)}',
                      style: tema.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${formatearKmh(sesion.velocidadMedia)} · '
                      '${formatearKcal(sesion.calorias)}',
                      style: tema.textTheme.bodySmall?.copyWith(
                        color: secundario,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: secundario),
            ],
          ),
        ),
      ),
    );
  }
}
