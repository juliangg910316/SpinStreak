/// Colores de la paleta "Fuego" sin rol en `ColorScheme` (spec 005).
///
/// Se registran como `ThemeExtension` en `AppTheme.light` y `AppTheme.dark`
/// y se leen con `Theme.of(context).extension<ColoresApp>()!`. No es un
/// modelo ni un estado: `copyWith` y `lerp` los exige `ThemeExtension`.
library;

import 'package:flutter/material.dart';

@immutable
class ColoresApp extends ThemeExtension<ColoresApp> {
  const ColoresApp({
    required this.racha,
    required this.rachaContenedor,
    required this.textoPrincipal,
    required this.botonTexto,
    required this.avisoRecord,
    required this.onAvisoRecord,
  });

  /// Acento de la racha: solo números de racha (≥ 24 px) y su llama (RF-4).
  final Color racha;

  /// Círculo detrás de la llama de la racha actual.
  final Color rachaContenedor;

  /// Color principal legible como texto o borde sobre el fondo
  /// ("Streak" del título, anillo del día seleccionado, carga).
  final Color textoPrincipal;

  /// Botones de texto: "Cancelar", "Entendido", "Seguir editando".
  final Color botonTexto;

  /// Fondo y texto del aviso de nuevo récord (RF-13).
  final Color avisoRecord;
  final Color onAvisoRecord;

  static const claro = ColoresApp(
    racha: Color(0xFFE53935),
    rachaContenedor: Color(0xFFFDE7E5),
    textoPrincipal: Color(0xFFC2410C),
    botonTexto: Color(0xFFA63A0B),
    avisoRecord: Color(0xFFFFB020),
    onAvisoRecord: Color(0xFF1F1A17),
  );

  static const oscuro = ColoresApp(
    racha: Color(0xFFE53935),
    rachaContenedor: Color(0xFF3B2224),
    textoPrincipal: Color(0xFFFF5A1F),
    botonTexto: Color(0xFFFFB59A),
    avisoRecord: Color(0xFFFFB020),
    onAvisoRecord: Color(0xFF1F1A17),
  );

  @override
  ColoresApp copyWith({
    Color? racha,
    Color? rachaContenedor,
    Color? textoPrincipal,
    Color? botonTexto,
    Color? avisoRecord,
    Color? onAvisoRecord,
  }) {
    return ColoresApp(
      racha: racha ?? this.racha,
      rachaContenedor: rachaContenedor ?? this.rachaContenedor,
      textoPrincipal: textoPrincipal ?? this.textoPrincipal,
      botonTexto: botonTexto ?? this.botonTexto,
      avisoRecord: avisoRecord ?? this.avisoRecord,
      onAvisoRecord: onAvisoRecord ?? this.onAvisoRecord,
    );
  }

  @override
  ColoresApp lerp(ColoresApp? other, double t) {
    if (other == null) return this;
    return ColoresApp(
      racha: Color.lerp(racha, other.racha, t)!,
      rachaContenedor: Color.lerp(rachaContenedor, other.rachaContenedor, t)!,
      textoPrincipal: Color.lerp(textoPrincipal, other.textoPrincipal, t)!,
      botonTexto: Color.lerp(botonTexto, other.botonTexto, t)!,
      avisoRecord: Color.lerp(avisoRecord, other.avisoRecord, t)!,
      onAvisoRecord: Color.lerp(onAvisoRecord, other.onAvisoRecord, t)!,
    );
  }
}
