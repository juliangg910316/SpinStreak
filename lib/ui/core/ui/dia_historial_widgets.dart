/// Cabecera de un día y fila de sesión con el formato del historial
/// (spec 001, RF-10 y RF-11). Se comparten con el calendario (spec 003, RF-7).
library;

import 'package:flutter/material.dart';

import '../../../domain/models/dia_historial.dart';
import '../../../domain/models/session.dart';
import '../../../utils/formatters.dart';

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
class FilaSesion extends StatelessWidget {
  const FilaSesion({required this.sesion, required this.onTap, super.key});

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
