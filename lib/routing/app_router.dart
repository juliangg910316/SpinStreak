/// Router con rutas nombradas nativas (`Navigator` + `onGenerateRoute`).
///
/// Cada ruta construye su pantalla dentro de un `BlocProvider` con el Cubit
/// obtenido de get_it, y lanza su primera carga (`cargar()`). Los argumentos
/// llegan por `settings.arguments`.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/dependencies.dart';
import '../domain/models/session.dart';
import '../ui/calendar/view_model/calendar_cubit.dart';
import '../ui/calendar/widgets/calendar_screen.dart';
import '../ui/history/view_model/history_cubit.dart';
import '../ui/history/widgets/history_screen.dart';
import '../ui/home/view_model/home_cubit.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/records/view_model/records_cubit.dart';
import '../ui/records/widgets/records_screen.dart';
import '../ui/session_form/view_model/session_form_cubit.dart';
import '../ui/session_form/view_model/session_form_state.dart';
import '../ui/session_form/widgets/session_form_screen.dart';
import 'route_names.dart';

abstract final class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        RouteNames.home => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<HomeCubit>()..cargar(),
            child: const HomeScreen(),
          ),
        ),
        RouteNames.sessionForm => MaterialPageRoute<ResultadoFormulario>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) =>
                getIt<SessionFormCubit>(param1: settings.arguments as Session?),
            child: const SessionFormScreen(),
          ),
        ),
        RouteNames.history => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<HistoryCubit>()..cargar(),
            child: const HistoryScreen(),
          ),
        ),
        RouteNames.calendar => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<CalendarCubit>()..cargar(),
            child: const CalendarScreen(),
          ),
        ),
        RouteNames.records => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<RecordsCubit>()..cargar(),
            child: const RecordsScreen(),
          ),
        ),
        _ => null,
      };
}
