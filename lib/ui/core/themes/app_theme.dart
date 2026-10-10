/// Tema visual de la app (solo claro, por ahora).
///
/// Para añadir modo oscuro, crear `dark` con
/// `Brightness.dark` y pasarlo a `MaterialApp.darkTheme`.
library;

import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  );
}
