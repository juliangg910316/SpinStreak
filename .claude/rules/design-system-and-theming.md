---
description: Tema visual, colores y formato de fechas y números.
globs: ["lib/ui/**", "lib/main.dart"]
paths:
  - "lib/ui/**"
  - "lib/main.dart"
---

# Tema y diseño

## Objetivo

- Paleta "Fuego" de la spec 005 en modo claro y oscuro: `AppTheme.light` y `AppTheme.dark` en `lib/ui/core/themes/app_theme.dart`, con Material 3 y `ThemeMode.system` (sigue el modo del móvil).
- Diseño de referencia de todas las pantallas: el lienzo enlazado en `specs/005-diseno-pantallas/spec.md`. Si no coincide con las specs, mandan las specs.

## Reglas

- **Colores**: `ColorScheme` escrito a mano con los hex de la spec 005 (no `fromSeed`, que recalcula los tonos). Los colores sin rol en Material están en la `ThemeExtension` `ColoresApp` (`colores_app.dart`): `racha`, `rachaContenedor`, `textoPrincipal`, `botonTexto`, `avisoRecord`/`onAvisoRecord`. Se leen con `Theme.of(context).extension<ColoresApp>()!`.
- **Acento de la racha** (`ColoresApp.racha`, `#E53935`): solo en los números de racha del inicio y su llama; nunca en texto de menos de 24 px ni en otras pantallas.
- **Texto sobre el color principal** (`#FF5A1F`): siempre `onPrimary` (`#1F1A17`); el blanco no da el contraste. Para texto o bordes naranjas sobre el fondo, `textoPrincipal`.
- **Contraste** (WCAG 2.1): texto ≥ 4,5:1; texto ≥ 24 px e iconos ≥ 3:1. Medir cualquier par de colores nuevo antes de usarlo.
- **Tipografía**: Figtree (textos) y Bricolage Grotesque (títulos y números), incluidas en `assets/fonts/` (sin descarga). Estilos en el `TextTheme` de `AppTheme`; en los widgets solo se cambian el peso o el color con `copyWith`, nunca el tamaño.
- Colores y tipografía siempre desde el tema: `Theme.of(context).colorScheme`, `.textTheme` y `ColoresApp`. Nada de `Colors.*`, `Color(0x…)` ni `fontSize` fuera de `lib/ui/core/themes/`. Los tonos que el tema no tiene (caja de icono, bordes suaves) se derivan con `withValues(alpha: …)`.
- Cambios de estilo globales (botones, tarjetas, campos, diálogos, avisos) en `AppTheme`, no por widget.
- Medidas repetidas (márgenes, radios, alto de botones, zona táctil de 44) en `lib/ui/core/themes/dimens.dart`.
- **Widgets compartidos** en `lib/ui/core/ui/`: `TarjetaAviso` (mensaje del día y estados vacíos), `EstadoError` (error de carga, sin reintentar), `mostrarAviso` (avisos inferiores con icono) y `TarjetaDia` / `CabeceraDia` / `FilaSesion` (historial y calendario). Los de una sola pantalla, privados (`_Nombre`) en su archivo.
- **Fechas y números**: con `intl` (`DateFormat`, `NumberFormat`) a través de `lib/utils/formatters.dart`, que usa `es` por defecto (configurado en `main.dart`). No formatear a mano para la UI.
- Textos de UI en español, escritos directamente (no hay ARB ni varios idiomas).
- Con el texto del sistema muy grande, los números grandes van en `FittedBox(fit: BoxFit.scaleDown)` y el botón flotante limita su escalado (`MediaQuery.withClampedTextScaling`).

## Anti-patrones

- `'${km.toStringAsFixed(1)} km'` en la UI (usar los formatos de `formatters.dart`, que ponen la coma decimal).
- Colores hex sueltos o `Colors.*` en widgets.
- Usar el rojo de la racha para destacar algo que no es la racha (p. ej. récords o errores).

## Checklist

- [ ] Sin colores ni tamaños de texto fijos en widgets.
- [ ] Los dos modos (claro y oscuro) revisados.
- [ ] Fechas y números formateados con `intl`.
