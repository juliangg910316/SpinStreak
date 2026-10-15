/// Abre una sesión en el formulario de edición (spec 001, RF-13) desde
/// cualquier pantalla: el historial y el calendario (spec 003, RF-11).
library;

import 'package:flutter/material.dart';

import '../../../domain/models/session.dart';
import '../../../routing/route_names.dart';
import '../../session_form/view_model/session_form_state.dart';

/// Abre [sesion] en el formulario y, al volver, muestra "Sesión actualizada"
/// o "Sesión borrada".
///
/// Devuelve el resultado del formulario (`null` si se vuelve sin guardar)
/// para que la pantalla que llama recargue sus datos.
Future<SessionFormStatus?> editarSesion(
  BuildContext context,
  Session sesion,
) async {
  final messenger = ScaffoldMessenger.of(context);

  final resultado = await Navigator.of(context)
      .pushNamed<SessionFormStatus>(RouteNames.sessionForm, arguments: sesion);

  final mensaje = switch (resultado) {
    SessionFormStatus.actualizada => 'Sesión actualizada',
    SessionFormStatus.borrada => 'Sesión borrada',
    _ => null,
  };
  if (mensaje != null) {
    messenger.showSnackBar(SnackBar(content: Text(mensaje)));
  }
  return resultado;
}
