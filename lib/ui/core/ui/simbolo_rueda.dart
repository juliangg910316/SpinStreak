/// Símbolo de la app (spec 006): rueda de bici con 7 radios y la llama de la
/// racha como buje, en un cuadrado con las esquinas redondeadas.
///
/// Dibuja la misma geometría que `docs/marca/simbolo.svg` (vista 14..94 del
/// lienzo de 108) con los colores del tema, así que cambia solo con el modo
/// claro u oscuro (RF-10). Es decorativo: no se anuncia en el lector de
/// pantalla (RF-11).
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../themes/colores_app.dart';

class SimboloRueda extends StatelessWidget {
  const SimboloRueda({required this.tamano, super.key});

  /// Lado del cuadrado, en píxeles lógicos.
  final double tamano;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final app = tema.extension<ColoresApp>()!;
    final claro = tema.brightness == Brightness.light;

    return ExcludeSemantics(
      child: Container(
        width: tamano,
        height: tamano,
        decoration: BoxDecoration(
          color: colores.surface,
          borderRadius: BorderRadius.circular(tamano * 0.24),
          // En claro, borde fino para separarlo del fondo crema (RF-10).
          border: claro
              ? Border.all(color: colores.onSurface.withValues(alpha: 0.14))
              : null,
        ),
        child: CustomPaint(
          painter: _PintorRueda(rueda: app.logoRueda, llama: colores.primary),
        ),
      ),
    );
  }
}

class _PintorRueda extends CustomPainter {
  const _PintorRueda({required this.rueda, required this.llama});

  final Color rueda;
  final Color llama;

  /// Vista del lienzo de 108: de 14 a 94 (80 de lado).
  static const _origen = 14.0;
  static const _lado = 80.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(size.width / _lado, size.height / _lado)
      ..translate(-_origen, -_origen);

    // Rueda (cubierta y radios), sin la llama ni su contorno.
    canvas.saveLayer(null, Paint());
    final trazo = Paint()
      ..color = rueda
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(const Offset(54, 54), 24, trazo..strokeWidth = 6.5);
    trazo
      ..strokeWidth = 3.4
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 7; i++) {
      final a = (-90 + 360 / 14 + i * 360 / 7) * math.pi / 180;
      Offset punto(double r) =>
          Offset(54 + r * math.cos(a), 54 + r * math.sin(a));
      canvas.drawLine(punto(5), punto(21.5), trazo);
    }
    _enLlama(canvas, () {
      final borrar = Paint()..blendMode = BlendMode.clear;
      canvas
        ..drawPath(_llama, borrar)
        ..drawPath(
          _llama,
          borrar
            ..style = PaintingStyle.stroke
            ..strokeWidth = 7
            ..strokeJoin = StrokeJoin.round,
        );
    });
    canvas.restore();

    // Llama, sin su recorte interior.
    canvas.saveLayer(null, Paint());
    _enLlama(canvas, () {
      canvas
        ..drawPath(_llama, Paint()..color = llama)
        ..drawPath(_corte, Paint()..blendMode = BlendMode.clear);
    });
    canvas
      ..restore()
      ..restore();
  }

  /// Lleva el lienzo a las coordenadas propias de la llama.
  void _enLlama(Canvas canvas, VoidCallback dibujar) {
    canvas
      ..save()
      ..translate(54, 57.5)
      ..scale(0.78);
    dibujar();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PintorRueda old) =>
      old.rueda != rueda || old.llama != llama;
}

/// Contorno exterior de la llama (coordenadas propias, centrada en 0, 0).
final _llama = Path()
  ..moveTo(2, -26)
  ..cubicTo(6, -16, 16, -10, 16, 2)
  ..cubicTo(16, 12, 9, 18, 0, 18)
  ..cubicTo(-9, 18, -16, 12, -16, 3)
  ..cubicTo(-16, -5, -11, -10, -7, -15)
  ..cubicTo(-6, -10, -4, -7, -1, -6)
  ..cubicTo(-2, -13, -1, -20, 2, -26)
  ..close();

/// Recorte interior de la llama.
final _corte = Path()
  ..moveTo(1, -3)
  ..cubicTo(3, 2, 7.5, 4.5, 7.5, 8.5)
  ..cubicTo(7.5, 11.5, 4.5, 13.5, 0.5, 13.5)
  ..cubicTo(-3.5, 13.5, -6.5, 11.5, -6.5, 8.5)
  ..cubicTo(-6.5, 5, -2, 2.5, 1, -3)
  ..close();
