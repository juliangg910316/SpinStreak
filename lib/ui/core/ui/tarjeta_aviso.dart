/// Tarjeta con un icono en una caja y un texto (spec 005, RF-11 y RF-17).
///
/// La usan el mensaje del día del inicio y los mensajes de las pantallas sin
/// datos. Sin [fondo] ni [colorIcono] es la tarjeta neutra.
library;

import 'package:flutter/material.dart';

import '../themes/dimens.dart';

class TarjetaAviso extends StatelessWidget {
  const TarjetaAviso({
    required this.icono,
    required this.texto,
    this.fondo,
    this.colorIcono,
    this.conBorde = false,
    this.destacado = false,
    super.key,
  });

  final IconData icono;
  final String texto;

  /// Fondo de la tarjeta; por defecto, `surfaceContainerHigh` (neutra).
  final Color? fondo;

  /// Color del icono (y, más suave, de su caja y del borde); por defecto,
  /// `onSurfaceVariant`.
  final Color? colorIcono;

  /// Borde de 1 px ("Riesgo" y "Reiniciada" del mensaje del día).
  final bool conBorde;

  /// Texto en peso 600 ("A salvo" y "Riesgo").
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final color = colorIcono ?? tema.colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.all(Dimens.margen),
      decoration: BoxDecoration(
        color: fondo ?? tema.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Dimens.radioTarjeta),
        border: conBorde
            ? Border.all(color: color.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: Dimens.cajaIcono,
            height: Dimens.cajaIcono,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(Dimens.radioCampo),
            ),
            child: Icon(icono, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              texto,
              style: destacado
                  ? tema.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )
                  : tema.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
