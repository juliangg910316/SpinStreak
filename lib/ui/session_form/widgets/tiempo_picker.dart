/// Selector propio del tiempo de la sesión: horas, minutos y segundos (RF-5).
///
/// Se muestra en una hoja inferior con [mostrarTiempoPicker]. No deja pasar
/// de [LimitesTiempo.maximo] (05:00:00): con 5 horas, los minutos y los
/// segundos solo pueden ser 0. No depende de ningún Cubit. Aspecto según la
/// spec 005 (RF-23): cabeceras encima de las ruedas y una banda detrás del
/// valor elegido.
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/session_validator.dart';

/// Abre el selector con [inicial] y devuelve el tiempo elegido, o `null` si
/// el usuario cancela.
Future<Duration?> mostrarTiempoPicker(
  BuildContext context, {
  required Duration inicial,
}) => showModalBottomSheet<Duration>(
  context: context,
  builder: (_) => TiempoPicker(inicial: inicial),
);

class TiempoPicker extends StatefulWidget {
  const TiempoPicker({required this.inicial, super.key});

  final Duration inicial;

  @override
  State<TiempoPicker> createState() => _TiempoPickerState();
}

class _TiempoPickerState extends State<TiempoPicker> {
  static final _maxHoras = LimitesTiempo.maximo.inHours;
  static const _alturaFila = 40.0;

  late int _horas;
  late int _minutos;
  late int _segundos;
  late final FixedExtentScrollController _ctrlHoras;
  late final FixedExtentScrollController _ctrlMinutos;
  late final FixedExtentScrollController _ctrlSegundos;

  bool get _enMaximo => _horas == _maxHoras;

  @override
  void initState() {
    super.initState();
    final inicial = widget.inicial > LimitesTiempo.maximo
        ? LimitesTiempo.maximo
        : widget.inicial;
    _horas = inicial.inHours;
    _minutos = inicial.inMinutes % 60;
    _segundos = inicial.inSeconds % 60;
    _ctrlHoras = FixedExtentScrollController(initialItem: _horas);
    _ctrlMinutos = FixedExtentScrollController(initialItem: _minutos);
    _ctrlSegundos = FixedExtentScrollController(initialItem: _segundos);
  }

  @override
  void dispose() {
    _ctrlHoras.dispose();
    _ctrlMinutos.dispose();
    _ctrlSegundos.dispose();
    super.dispose();
  }

  void _cambiarHoras(int horas) {
    setState(() {
      _horas = horas;
      if (_enMaximo) {
        _minutos = 0;
        _segundos = 0;
      }
    });
    if (_enMaximo) {
      _ctrlMinutos.jumpToItem(0);
      _ctrlSegundos.jumpToItem(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final etiqueta = tema.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: tema.colorScheme.onSurfaceVariant,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Tiempo', style: tema.textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              children: [
                for (final unidad in const ['h', 'min', 's'])
                  Expanded(
                    child: Text(
                      unidad,
                      textAlign: TextAlign.center,
                      style: etiqueta,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: _alturaFila * 5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Banda detrás de la fila del valor elegido.
                  Container(
                    height: _alturaFila + 4,
                    decoration: BoxDecoration(
                      color: tema.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  Row(
                    children: [
                      _Columna(
                        controller: _ctrlHoras,
                        cantidad: _maxHoras + 1,
                        seleccionado: _horas,
                        alturaFila: _alturaFila,
                        onCambio: _cambiarHoras,
                      ),
                      _Columna(
                        controller: _ctrlMinutos,
                        cantidad: _enMaximo ? 1 : 60,
                        seleccionado: _minutos,
                        alturaFila: _alturaFila,
                        onCambio: (m) => setState(() => _minutos = m),
                      ),
                      _Columna(
                        controller: _ctrlSegundos,
                        cantidad: _enMaximo ? 1 : 60,
                        seleccionado: _segundos,
                        alturaFila: _alturaFila,
                        onCambio: (s) => setState(() => _segundos = s),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(
                    Duration(
                      hours: _horas,
                      minutes: _minutos,
                      seconds: _segundos,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(64, 44),
                    shape: const StadiumBorder(),
                    textStyle: tema.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Una rueda del selector (0 … [cantidad] − 1). El valor [seleccionado] va
/// más grande y en el color del texto; el resto, en gris.
class _Columna extends StatelessWidget {
  const _Columna({
    required this.controller,
    required this.cantidad,
    required this.seleccionado,
    required this.alturaFila,
    required this.onCambio,
  });

  final FixedExtentScrollController controller;
  final int cantidad;
  final int seleccionado;
  final double alturaFila;
  final ValueChanged<int> onCambio;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final gris = Theme.of(context).colorScheme.onSurfaceVariant;
    return Expanded(
      child: CupertinoPicker.builder(
        scrollController: controller,
        itemExtent: alturaFila,
        onSelectedItemChanged: onCambio,
        childCount: cantidad,
        // La banda la pinta el selector, detrás de las ruedas.
        selectionOverlay: null,
        itemBuilder: (context, i) => Center(
          child: Text(
            i.toString().padLeft(2, '0'),
            style: i == seleccionado
                ? textos.titleLarge
                : textos.bodyLarge?.copyWith(color: gris),
          ),
        ),
      ),
    );
  }
}
