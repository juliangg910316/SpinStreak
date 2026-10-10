/// Router con rutas nombradas nativas (`Navigator` + `onGenerateRoute`).
///
/// Cada ruta construye su pantalla dentro de un `BlocProvider` con el Cubit
/// obtenido de get_it. Los argumentos llegan por `settings.arguments`.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/dependencies.dart';
import '../ui/home/view_model/home_cubit.dart';
import '../ui/home/widgets/home_screen.dart';
import 'route_names.dart';

abstract final class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        RouteNames.home => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        ),
        _ => null,
      };
}
