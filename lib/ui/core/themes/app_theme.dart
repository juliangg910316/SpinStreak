/// Tema visual de la app: paleta "Fuego" en modo claro y oscuro (spec 005).
///
/// `ColorScheme` escrito a mano con los colores de la spec (no `fromSeed`,
/// que recalcula los tonos), la tipografía (Figtree y Bricolage Grotesque)
/// y los estilos de los componentes. Los colores sin rol en Material están
/// en [ColoresApp]. `MaterialApp` elige el modo según el del móvil.
library;

import 'package:flutter/material.dart';

import 'colores_app.dart';
import 'dimens.dart';

abstract final class AppTheme {
  static final light = _tema(_esquemaClaro, ColoresApp.claro);
  static final dark = _tema(_esquemaOscuro, ColoresApp.oscuro);

  static const _esquemaClaro = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF5A1F),
    onPrimary: Color(0xFF1F1A17),
    primaryContainer: Color(0xFFFFE3D6),
    onPrimaryContainer: Color(0xFF8F3209),
    secondary: Color(0xFFFFB020),
    onSecondary: Color(0xFF1F1A17),
    secondaryContainer: Color(0xFFFFE9C2),
    onSecondaryContainer: Color(0xFF6B4A00),
    error: Color(0xFF8E244D),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFD9E3),
    onErrorContainer: Color(0xFF5C1130),
    surface: Color(0xFFFFF8F3),
    onSurface: Color(0xFF1F1A17),
    onSurfaceVariant: Color(0xFF6B5C53),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerHigh: Color(0xFFF5E9E1),
    surfaceContainerHighest: Color(0xFFFFFFFF),
    outline: Color(0xFF8C7A6F),
    outlineVariant: Color(0xFFF1E1D6),
    inverseSurface: Color(0xFF362F2B),
    onInverseSurface: Color(0xFFFBEEE8),
    scrim: Color(0xFF1F1A17),
    surfaceTint: Color(0x00000000),
  );

  static const _esquemaOscuro = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFF5A1F),
    onPrimary: Color(0xFF1F1A17),
    primaryContainer: Color(0xFF3A2A24),
    onPrimaryContainer: Color(0xFFFFB59A),
    secondary: Color(0xFFFFB020),
    onSecondary: Color(0xFF1F1A17),
    secondaryContainer: Color(0xFF45330F),
    onSecondaryContainer: Color(0xFFFFB020),
    error: Color(0xFFFFB1C8),
    onError: Color(0xFF5C1A33),
    errorContainer: Color(0xFF5C1A33),
    onErrorContainer: Color(0xFFFFD9E3),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFF4EDE8),
    onSurfaceVariant: Color(0xFFCBBFB7),
    surfaceContainerLowest: Color(0xFF2A2629),
    surfaceContainerHigh: Color(0xFF2A2629),
    surfaceContainerHighest: Color(0xFF322D31),
    outline: Color(0xFF9A8C84),
    outlineVariant: Color(0xFF3A3437),
    inverseSurface: Color(0xFFEDE0D8),
    onInverseSurface: Color(0xFF1F1A17),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0x00000000),
  );

  static const _bricolage = 'BricolageGrotesque';
  static const _cifrasFijas = [FontFeature.tabularFigures()];

  /// Tipografía de la spec 005 (tamaño/alto de línea en px). Los colores
  /// los pone `_tema` según el modo.
  static const _textos = TextTheme(
    // Número de la racha actual.
    displayLarge: TextStyle(
      fontFamily: _bricolage,
      fontSize: 80,
      height: 84 / 80,
      fontWeight: FontWeight.w800,
      letterSpacing: -2.4,
      fontFeatures: _cifrasFijas,
    ),
    // Contadores.
    headlineMedium: TextStyle(
      fontFamily: _bricolage,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.64,
      fontFeatures: _cifrasFijas,
    ),
    // Valor de un récord.
    headlineSmall: TextStyle(
      fontFamily: _bricolage,
      fontSize: 28,
      height: 34 / 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.56,
      fontFeatures: _cifrasFijas,
    ),
    // Barra superior, diálogos y hoja inferior.
    titleLarge: TextStyle(
      fontFamily: _bricolage,
      fontSize: 22,
      height: 28 / 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.22,
    ),
    // Mes del calendario.
    titleMedium: TextStyle(
      fontFamily: _bricolage,
      fontSize: 18,
      height: 24 / 18,
      fontWeight: FontWeight.w700,
    ),
    // Cabecera de día.
    titleSmall: TextStyle(
      fontSize: 15,
      height: 20 / 15,
      fontWeight: FontWeight.w700,
    ),
    // Valor de un campo; "Racha actual" (peso 700).
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),
    // Mensaje del día, línea principal de una sesión.
    bodyMedium: TextStyle(
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w500,
    ),
    // Etiquetas, unidades, totales, línea secundaria.
    bodySmall: TextStyle(
      fontSize: 13,
      height: 18 / 13,
      fontWeight: FontWeight.w500,
    ),
    // Botones, fecha, "Explorar", días del calendario.
    labelLarge: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w600,
    ),
    // Etiqueta y error de un campo, iniciales L–D.
    labelSmall: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w600,
    ),
  );

  static ThemeData _tema(ColorScheme colores, ColoresApp app) {
    final textos = _textos.apply(
      bodyColor: colores.onSurface,
      displayColor: colores.onSurface,
    );
    const radioCampo = BorderRadius.all(Radius.circular(Dimens.radioCampo));
    OutlineInputBorder borde(Color color, double ancho) => OutlineInputBorder(
      borderRadius: radioCampo,
      borderSide: BorderSide(color: color, width: ancho),
    );
    const textoBoton = TextStyle(
      fontFamily: 'Figtree',
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w700,
    );

    return ThemeData(
      colorScheme: colores,
      fontFamily: 'Figtree',
      textTheme: textos,
      scaffoldBackgroundColor: colores.surface,
      extensions: [app],
      appBarTheme: AppBarThemeData(
        backgroundColor: colores.surface,
        foregroundColor: colores.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 64,
        titleTextStyle: textos.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: colores.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimens.radioTarjeta),
          ),
          side: BorderSide(color: colores.outlineVariant),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colores.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: textos.bodyLarge?.copyWith(color: colores.onSurfaceVariant),
        floatingLabelStyle: textos.labelSmall?.copyWith(
          color: colores.onSurfaceVariant,
        ),
        hintStyle: textos.bodyLarge?.copyWith(color: colores.onSurfaceVariant),
        suffixStyle: textos.bodyLarge?.copyWith(
          color: colores.onSurfaceVariant,
        ),
        errorStyle: textos.labelSmall?.copyWith(color: colores.error),
        errorMaxLines: 2,
        border: borde(colores.outline, 1),
        enabledBorder: borde(colores.outline, 1),
        focusedBorder: borde(app.textoPrincipal, 2),
        errorBorder: borde(colores.error, 2),
        focusedErrorBorder: borde(colores.error, 2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colores.primary,
          foregroundColor: colores.onPrimary,
          minimumSize: const Size(64, Dimens.altoBoton),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.radioBoton)),
          ),
          textStyle: textoBoton,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colores.primary,
        foregroundColor: colores.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radioBoton)),
        ),
        extendedTextStyle: textoBoton,
        extendedPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 20, 0),
        extendedSizeConstraints: const BoxConstraints.tightFor(
          height: Dimens.altoBoton,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: app.botonTexto,
          minimumSize: const Size(64, Dimens.tactilMinimo),
          shape: const StadiumBorder(),
          textStyle: textos.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colores.surfaceContainerHighest,
        surfaceTintColor: colores.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radioGrande)),
        ),
        titleTextStyle: textos.titleLarge,
        contentTextStyle: textos.bodyMedium?.copyWith(
          color: colores.onSurfaceVariant,
          fontWeight: FontWeight.w400,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colores.surfaceContainerHighest,
        surfaceTintColor: colores.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimens.radioGrande),
          ),
        ),
        showDragHandle: true,
        dragHandleColor: colores.outline,
        dragHandleSize: const Size(32, 4),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colores.inverseSurface,
        contentTextStyle: textos.labelLarge?.copyWith(
          color: colores.onInverseSurface,
          fontWeight: FontWeight.w500,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radioCampo)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: app.textoPrincipal,
        circularTrackColor: colores.outlineVariant,
      ),
    );
  }
}
