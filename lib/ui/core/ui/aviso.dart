/// Avisos inferiores con icono (spec 005, RF-13 y RF-19).
///
/// Recibe el `ScaffoldMessengerState` (y no un `BuildContext`) porque las
/// pantallas lo guardan antes de esperar a que se cierre el formulario.
library;

import 'package:flutter/material.dart';

import '../themes/colores_app.dart';

/// Muestra [texto] con [icono]. Con [record], fondo ámbar (nuevo récord).
void mostrarAviso(
  ScaffoldMessengerState messenger,
  String texto, {
  required IconData icono,
  bool record = false,
}) {
  final tema = Theme.of(messenger.context);
  final app = tema.extension<ColoresApp>()!;
  final colorTexto = record
      ? app.onAvisoRecord
      : tema.colorScheme.onInverseSurface;

  messenger.showSnackBar(
    SnackBar(
      backgroundColor: record ? app.avisoRecord : null,
      content: Row(
        children: [
          Icon(icono, size: 20, color: colorTexto),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              texto,
              style: tema.snackBarTheme.contentTextStyle?.copyWith(
                color: colorTexto,
                fontWeight: record ? FontWeight.w600 : null,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
