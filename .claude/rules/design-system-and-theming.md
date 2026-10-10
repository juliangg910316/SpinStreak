---
description: Tema visual, colores y formato de fechas y números.
globs: ["lib/ui/**", "lib/main.dart"]
paths:
  - "lib/ui/**"
  - "lib/main.dart"
---

# Tema y diseño

## Objetivo

- Un único tema claro en `lib/ui/core/themes/app_theme.dart` (`AppTheme.light`), basado en Material 3 y `ColorScheme.fromSeed`.

## Reglas

- Colores y tipografía siempre desde el tema: `Theme.of(context).colorScheme` y `.textTheme`. No usar `Colors.*` ni `TextStyle` con tamaños fijos en widgets.
- Cambios de estilo globales (botones, tarjetas, inputs) en `AppTheme`, no por widget.
- Constantes de diseño repetidas (márgenes, radios) en `lib/ui/core/themes/` (p. ej. `dimens.dart`) cuando aparezcan en más de un sitio.
- Widgets reutilizables entre features en `lib/ui/core/ui/`; los de una sola pantalla, privados (`_Nombre`) en su archivo.
- **Fechas y números**: con `intl` (`DateFormat`, `NumberFormat`), que usa `es` por defecto (configurado en `main.dart`). No formatear a mano para la UI.
- Textos de UI en español, escritos directamente (no hay ARB ni varios idiomas).
- Modo oscuro: no existe; para añadirlo, crear `AppTheme.dark` y pasarlo a `MaterialApp.darkTheme`.

## Anti-patrones

- `'${km.toStringAsFixed(1)} km'` en la UI (usar `NumberFormat`, que pone la coma decimal).
- Colores hex sueltos en widgets.

## Checklist

- [ ] Sin colores ni tamaños de texto fijos en widgets.
- [ ] Fechas y números formateados con `intl`.
