/// Formulario para registrar una sesión nueva o editar una existente.
///
/// Solo pinta el estado de [SessionFormCubit] y le pasa lo que escribe el
/// usuario; el `BlocProvider` lo crea el router. Al terminar (guardada,
/// actualizada o borrada) se cierra devolviendo un [ResultadoFormulario] con
/// ese estado y los récords batidos. Aspecto según la spec 005 (RF-19b a
/// RF-24).
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/session_validator.dart';
import '../../../utils/formatters.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/aviso.dart';
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
                // Spec 005, RF-19b: solo el icono; el tooltip da la
                // descripción accesible "Borrar".
                if (edicion)
                  IconButton(
                    onPressed: guardando ? null : _confirmarBorrar,
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: 'Borrar',
                  ),
              ],
            ),
            // Spec 005, RF-22: "Guardar" fijo en la parte inferior.
            bottomNavigationBar: _BarraGuardar(
              guardando: guardando,
              onGuardar: cubit.guardar,
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(
                Dimens.margen,
                8,
                Dimens.margen,
                24,
              ),
              children: [
                if (state.original case final original?)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Registrada el ${formatearFecha(original.fecha)} '
                      'a las ${formatearHora(original.fecha)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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
                // La nota no tiene ayuda: deja el hueco del ⓘ para alinearse.
                _FilaCampo(
                  ayuda: null,
                  campo: TextField(
                    controller: _nota,
                    onChanged: cubit.cambiarNota,
                    maxLines: 3,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Nota (opcional)',
                    ),
                  ),
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
      Navigator.of(context).pop(
        ResultadoFormulario(
          status: state.status,
          recordsBatidos: state.recordsBatidos,
        ),
      );
    } else if (state.status == SessionFormStatus.error) {
      // RC-1: mensaje comprensible; la entrada sigue en el formulario.
      final mensaje = switch (state.fallo) {
        OperacionFallida.borrar =>
          'No se pudo borrar la sesión. Inténtalo de nuevo.',
        _ => 'No se pudo guardar la sesión. Inténtalo de nuevo.',
      };
      mostrarAviso(
        ScaffoldMessenger.of(context),
        mensaje,
        icono: Icons.error_outline_rounded,
      );
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
          // Spec 005, RF-24: la acción destructiva, en el color de error.
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
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
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
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

/// Un campo con su botón ⓘ a la derecha (spec 005, RF-20). Sin [ayuda]
/// queda el hueco, para que todos los campos tengan el mismo ancho.
class _FilaCampo extends StatelessWidget {
  const _FilaCampo({required this.campo, required this.ayuda});

  final Widget campo;
  final CampoSesion? ayuda;

  @override
  Widget build(BuildContext context) {
    final ayuda = this.ayuda;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: campo),
          SizedBox(
            width: 48,
            height: Dimens.altoBoton,
            child: ayuda == null ? null : AyudaParametro(campo: ayuda),
          ),
        ],
      ),
    );
  }
}

/// Error de un campo: icono y mensaje en el color de error (spec 005, RF-21).
Widget? _errorCampo(BuildContext context, String? mensaje) {
  if (mensaje == null) return null;
  final tema = Theme.of(context);
  final color = tema.colorScheme.error;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.error_outline_rounded, size: 16, color: color),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          mensaje,
          style: tema.textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    ],
  );
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
    final tema = Theme.of(context);
    final vacio = tiempo == Duration.zero;
    return _FilaCampo(
      ayuda: CampoSesion.tiempo,
      campo: InkWell(
        onTap: onElegir,
        borderRadius: BorderRadius.circular(Dimens.radioCampo),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: _etiquetas[CampoSesion.tiempo],
            error: _errorCampo(context, error),
          ),
          child: Text(
            vacio ? 'Toca para elegir' : formatearTiempo(tiempo),
            style: tema.textTheme.bodyLarge?.copyWith(
              color: vacio ? tema.colorScheme.onSurfaceVariant : null,
            ),
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
    return _FilaCampo(
      ayuda: campo,
      campo: TextField(
        controller: control,
        onChanged: onChanged,
        keyboardType: TextInputType.numberWithOptions(
          decimal: _conDecimales.contains(campo),
        ),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: _etiquetas[campo],
          // Spec 005, RF-20: la unidad aparece una vez escrito el valor.
          suffixText: control.text.isEmpty ? null : _unidades[campo],
          error: _errorCampo(context, error),
        ),
      ),
    );
  }
}

/// Botón "Guardar" a lo ancho, fijo abajo; mientras guarda, indicador
/// circular junto al texto (spec 005, RF-22).
class _BarraGuardar extends StatelessWidget {
  const _BarraGuardar({required this.guardando, required this.onGuardar});

  final bool guardando;
  final VoidCallback onGuardar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colores.surface,
        border: Border(top: BorderSide(color: colores.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.margen),
          child: FilledButton(
            onPressed: guardando ? null : onGuardar,
            // Mientras guarda conserva el color principal.
            style: FilledButton.styleFrom(
              disabledBackgroundColor: colores.primary,
              disabledForegroundColor: colores.onPrimary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (guardando) ...[
                  SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: colores.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                const Text('Guardar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
