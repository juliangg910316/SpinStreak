/// Selector propio del tiempo de la sesión: horas, minutos y segundos (RF-5).
///
/// Se muestra en una hoja inferior con [mostrarTiempoPicker]. No deja pasar
/// de [LimitesTiempo.maximo] (05:00:00): con 5 horas, los minutos y los
/// segundos solo pueden ser 0. No depende de ningún Cubit.
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
  showDragHandle: true,
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Tiempo', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SizedBox(
              height: _alturaFila * 5,
              child: Row(
                children: [
                  _Columna(
                    etiqueta: 'h',
                    controller: _ctrlHoras,
                    cantidad: _maxHoras + 1,
                    alturaFila: _alturaFila,
                    onCambio: _cambiarHoras,
                  ),
                  _Columna(
                    etiqueta: 'min',
                    controller: _ctrlMinutos,
                    cantidad: _enMaximo ? 1 : 60,
                    alturaFila: _alturaFila,
                    onCambio: (m) => setState(() => _minutos = m),
                  ),
                  _Columna(
                    etiqueta: 's',
                    controller: _ctrlSegundos,
                    cantidad: _enMaximo ? 1 : 60,
                    alturaFila: _alturaFila,
                    onCambio: (s) => setState(() => _segundos = s),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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

/// Una columna del selector (0 … [cantidad] − 1) con su unidad debajo.
class _Columna extends StatelessWidget {
  const _Columna({
    required this.etiqueta,
    required this.controller,
    required this.cantidad,
    required this.alturaFila,
    required this.onCambio,
  });

  final String etiqueta;
  final FixedExtentScrollController controller;
  final int cantidad;
  final double alturaFila;
  final ValueChanged<int> onCambio;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: controller,
              itemExtent: alturaFila,
              onSelectedItemChanged: onCambio,
              childCount: cantidad,
              itemBuilder: (context, i) =>
                  Center(child: Text(i.toString().padLeft(2, '0'))),
            ),
          ),
          Text(etiqueta, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
