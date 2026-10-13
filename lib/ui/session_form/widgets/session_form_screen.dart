/// Formulario para registrar una sesión nueva o editar una existente.
///
/// Solo pinta el estado de [SessionFormCubit] y le pasa lo que escribe el
/// usuario; el `BlocProvider` lo crea el router. Al terminar (guardada,
/// actualizada o borrada) se cierra devolviendo ese [SessionFormStatus].
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/session_validator.dart';
import '../../../utils/formatters.dart';
import '../view_model/session_form_cubit.dart';
import '../view_model/session_form_state.dart';
import 'ayuda_parametro.dart';
import 'tiempo_picker.dart';

class SessionFormScreen extends StatefulWidget {
  const SessionFormScreen({super.key});

  @override
  State<SessionFormScreen> createState() => _SessionFormScreenState();
}

class _SessionFormScreenState extends State<SessionFormScreen> {
  late final Map<CampoSesion, TextEditingController> _controles;
  late final TextEditingController _nota;

  @override
  void initState() {
    super.initState();
    // Texto inicial: vacío al registrar, los valores de la sesión al editar.
    final entrada = context.read<SessionFormCubit>().state.entrada;
    _controles = {
      CampoSesion.distancia: TextEditingController(text: entrada.distancia),
      CampoSesion.calorias: TextEditingController(text: entrada.calorias),
      CampoSesion.odometro: TextEditingController(text: entrada.odometro),
      CampoSesion.velocidadMax: TextEditingController(
        text: entrada.velocidadMax,
      ),
      CampoSesion.pulsoMax: TextEditingController(text: entrada.pulsoMax),
    };
    _nota = TextEditingController(text: entrada.nota);
  }

  @override
  void dispose() {
    for (final control in _controles.values) {
      control.dispose();
    }
    _nota.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionFormCubit, SessionFormState>(
      listenWhen: (antes, ahora) => antes.status != ahora.status,
      listener: _alCambiarStatus,
      builder: (context, state) {
        final cubit = context.read<SessionFormCubit>();
        final edicion = state.modo == ModoFormulario.edicion;
        final guardando = state.status == SessionFormStatus.guardando;

        return PopScope(
          // RF-16: con cambios sin guardar, "Atrás" pregunta antes de salir.
          canPop: !state.hayCambios || state.terminado,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _confirmarDescartar();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(edicion ? 'Editar sesión' : 'Registrar sesión'),
              actions: [
                if (edicion)
                  TextButton.icon(
                    onPressed: guardando ? null : _confirmarBorrar,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Borrar'),
                  ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (state.original case final original?)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Registrada el ${formatearFecha(original.fecha)} '
                      'a las ${formatearHora(original.fecha)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                _CampoTiempo(
                  tiempo: state.entrada.tiempo,
                  error: _mensajeError(
                    CampoSesion.tiempo,
                    state.errores[CampoSesion.tiempo],
                  ),
                  onElegir: () async {
                    final tiempo = await mostrarTiempoPicker(
                      context,
                      inicial: state.entrada.tiempo,
                    );
                    if (tiempo != null) cubit.cambiarTiempo(tiempo);
                  },
                ),
                for (final campo in _camposNumericos)
                  _CampoNumero(
                    campo: campo,
                    control: _controles[campo]!,
                    error: _mensajeError(campo, state.errores[campo]),
                    onChanged: (texto) => cubit.cambiarCampo(campo, texto),
                  ),
                TextField(
                  controller: _nota,
                  onChanged: cubit.cambiarNota,
                  maxLines: 3,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Nota (opcional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: guardando ? null : cubit.guardar,
                  child: guardando
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Guardar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _alCambiarStatus(BuildContext context, SessionFormState state) {
    if (state.terminado) {
      Navigator.of(context).pop(state.status);
    } else if (state.status == SessionFormStatus.error) {
      // RC-1: mensaje comprensible; la entrada sigue en el formulario.
      final mensaje = switch (state.fallo) {
        OperacionFallida.borrar =>
          'No se pudo borrar la sesión. Inténtalo de nuevo.',
        _ => 'No se pudo guardar la sesión. Inténtalo de nuevo.',
      };
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(mensaje)));
    }
  }

  /// RF-15: solo se borra si el usuario confirma.
  Future<void> _confirmarBorrar() async {
    final cubit = context.read<SessionFormCubit>();
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Borrar esta sesión?'),
        content: const Text('No se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (confirmar ?? false) await cubit.borrar();
  }

  /// RF-16: solo sale si el usuario confirma que descarta los cambios.
  Future<void> _confirmarDescartar() async {
    final descartar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Descartar los cambios?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Seguir editando'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Descartar'),
          ),
        ],
      ),
    );
    // `pop` directo no pasa por `PopScope`, así que no vuelve a preguntar.
    if ((descartar ?? false) && mounted) Navigator.of(context).pop();
  }
}

const _camposNumericos = [
  CampoSesion.distancia,
  CampoSesion.calorias,
  CampoSesion.odometro,
  CampoSesion.velocidadMax,
  CampoSesion.pulsoMax,
];

const _etiquetas = {
  CampoSesion.tiempo: 'Tiempo',
  CampoSesion.distancia: 'Distancia',
  CampoSesion.calorias: 'Calorías',
  CampoSesion.odometro: 'Odómetro',
  CampoSesion.velocidadMax: 'Velocidad máxima (opcional)',
  CampoSesion.pulsoMax: 'Pulso máximo (opcional)',
};

const _unidades = {
  CampoSesion.distancia: 'km',
  CampoSesion.calorias: 'kcal',
  CampoSesion.odometro: 'km',
  CampoSesion.velocidadMax: 'km/h',
  CampoSesion.pulsoMax: 'ppm',
};

/// Campos que admiten decimales (teclado con separador decimal).
const _conDecimales = {CampoSesion.distancia, CampoSesion.odometro};

/// Texto del error de [campo] (RF-3, RF-4), con números en español (RC-3).
String? _mensajeError(CampoSesion campo, ErrorCampo? error) {
  if (error == null) return null;
  final unidad = _unidades[campo] ?? '';
  String numero(num n) => campo == CampoSesion.tiempo
      ? formatearTiempo(Duration(seconds: n.toInt()))
      : '${NumberFormat('#,##0.##').format(n)} $unidad';

  return switch (error) {
    Falta() =>
      campo == CampoSesion.tiempo ? 'Elige el tiempo' : 'Falta este dato',
    NoNumerico() =>
      _conDecimales.contains(campo)
          ? 'Escribe solo un número, con coma o punto para los decimales'
          : 'Escribe solo un número entero',
    FueraDeRango(:final min, :final max, :final minExclusivo) =>
      minExclusivo
          ? 'Debe ser mayor que ${numero(min)} y como máximo ${numero(max)}'
          : 'Debe estar entre ${numero(min)} y ${numero(max)}',
    DemasiadosDecimales(:final max) =>
      max == 0 ? 'Sin decimales' : 'Como máximo $max decimales',
  };
}

/// Campo de tiempo de solo lectura: al tocarlo abre el selector (RF-5).
class _CampoTiempo extends StatelessWidget {
  const _CampoTiempo({
    required this.tiempo,
    required this.error,
    required this.onElegir,
  });

  final Duration tiempo;
  final String? error;
  final VoidCallback onElegir;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onElegir,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: _etiquetas[CampoSesion.tiempo],
            errorText: error,
            border: const OutlineInputBorder(),
            suffixIcon: const AyudaParametro(campo: CampoSesion.tiempo),
          ),
          child: Text(
            tiempo == Duration.zero
                ? 'Toca para elegir'
                : formatearTiempo(tiempo),
          ),
        ),
      ),
    );
  }
}

class _CampoNumero extends StatelessWidget {
  const _CampoNumero({
    required this.campo,
    required this.control,
    required this.error,
    required this.onChanged,
  });

  final CampoSesion campo;
  final TextEditingController control;
  final String? error;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: control,
        onChanged: onChanged,
        keyboardType: TextInputType.numberWithOptions(
          decimal: _conDecimales.contains(campo),
        ),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: _etiquetas[campo],
          suffixText: _unidades[campo],
          errorText: error,
          errorMaxLines: 2,
          border: const OutlineInputBorder(),
          suffixIcon: AyudaParametro(campo: campo),
        ),
      ),
    );
  }
}
