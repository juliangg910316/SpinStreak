/// Botón ⓘ con la ayuda de un parámetro de la sesión (RF-8).
///
/// Los textos son los del glosario (sección 5 de `docs/ESPECIFICACION.md`).
/// La nota no tiene ayuda: no es un parámetro de la bici.
library;

import 'package:flutter/material.dart';

import '../../../domain/session_validator.dart';

class AyudaParametro extends StatelessWidget {
  const AyudaParametro({required this.campo, super.key});

  final CampoSesion campo;

  @override
  Widget build(BuildContext context) {
    final entrada = _glosario[campo]!;
    return IconButton(
      icon: Icon(
        Icons.info_outline_rounded,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Qué es: ${entrada.nombre}',
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => _DialogoAyuda(entrada: entrada),
      ),
    );
  }
}

class _DialogoAyuda extends StatelessWidget {
  const _DialogoAyuda({required this.entrada});

  final _EntradaGlosario entrada;

  @override
  Widget build(BuildContext context) {
    // Spec 005, RF-24: apartados en el color del texto; el resto, con el
    // estilo de contenido del diálogo.
    final tema = Theme.of(context);
    final titulo = tema.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: tema.colorScheme.onSurface,
    );
    return AlertDialog(
      title: Text(entrada.nombre),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Qué significa', style: titulo),
            const SizedBox(height: 4),
            Text(entrada.significado),
            const SizedBox(height: 12),
            Text('Para qué sirve', style: titulo),
            const SizedBox(height: 4),
            Text(entrada.utilidad),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Entendido'),
        ),
      ],
    );
  }
}

typedef _EntradaGlosario = ({
  String nombre,
  String significado,
  String utilidad,
});

const Map<CampoSesion, _EntradaGlosario> _glosario = {
  CampoSesion.tiempo: (
    nombre: 'Tiempo',
    significado:
        'Duración total de la sesión, desde que empiezas a pedalear hasta '
        'que paras.',
    utilidad: 'Medir el volumen de entrenamiento; es la base de la constancia.',
  ),
  CampoSesion.velocidadMax: (
    nombre: 'Velocidad máxima',
    significado:
        'La velocidad más alta que alcanzaste durante la sesión, en km/h. En '
        'una bici estática se calcula a partir de las pedaladas por minuto '
        '(cadencia), no de un desplazamiento real.',
    utilidad: 'Indica tus picos de esfuerzo o sprints.',
  ),
  CampoSesion.distancia: (
    nombre: 'Distancia',
    significado:
        'Kilómetros "virtuales" recorridos en la sesión, calculados por la '
        'bici a partir de las vueltas de los pedales.',
    utilidad: 'Comparar sesiones y acumular km para retos y metas.',
  ),
  CampoSesion.calorias: (
    nombre: 'Calorías',
    significado:
        'Energía gastada aproximada, en kcal. Es una estimación de la bici '
        '(suele basarse en tiempo, velocidad y resistencia, no en tu peso '
        'real).',
    utilidad: 'Ver tendencias, no como cifra exacta.',
  ),
  CampoSesion.odometro: (
    nombre: 'Odómetro',
    significado:
        'Total de kilómetros acumulados por la bici desde que se usa (no se '
        'reinicia entre sesiones).',
    utilidad:
        'Llevar el total histórico y comprobar que la distancia registrada '
        'cuadra.',
  ),
  CampoSesion.pulsoMax: (
    nombre: 'Pulso máximo',
    significado:
        'Las pulsaciones por minuto (ppm) más altas registradas durante la '
        'sesión, medidas con los sensores del manillar o una banda.',
    utilidad:
        'Medir la intensidad. Referencia orientativa de pulso máximo '
        'teórico: 220 − edad.',
  ),
};
