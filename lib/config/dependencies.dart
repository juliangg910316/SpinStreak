/// Inyección de dependencias con get_it.
///
/// Único sitio donde se crean servicios, repositorios y Cubits. Solo se llama
/// a `getIt<...>()` aquí y en los `BlocProvider` del router; el resto de
/// clases reciben sus dependencias por constructor.
library;

import 'package:get_it/get_it.dart';

import '../data/repositories/session_repository.dart';
import '../data/services/database/app_database.dart';
import '../domain/models/session.dart';
import '../ui/calendar/view_model/calendar_cubit.dart';
import '../ui/history/view_model/history_cubit.dart';
import '../ui/home/view_model/home_cubit.dart';
import '../ui/records/view_model/records_cubit.dart';
import '../ui/session_form/view_model/session_form_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt
    // Servicios y repositorios: una instancia, creada al primer uso.
    ..registerLazySingleton<AppDatabase>(AppDatabase.new)
    ..registerLazySingleton<SessionRepository>(
      () => SessionRepository(database: getIt()),
    )
    // Cubits: uno nuevo por pantalla; BlocProvider se encarga de cerrarlo.
    ..registerFactory<HomeCubit>(() => HomeCubit(sessionRepository: getIt()))
    ..registerFactory<HistoryCubit>(
      () => HistoryCubit(sessionRepository: getIt()),
    )
    ..registerFactory<CalendarCubit>(
      () => CalendarCubit(sessionRepository: getIt()),
    )
    ..registerFactory<RecordsCubit>(
      () => RecordsCubit(sessionRepository: getIt()),
    )
    // Formulario: `param1` es la sesión a editar, o null para una nueva.
    ..registerFactoryParam<SessionFormCubit, Session?, void>(
      (original, _) =>
          SessionFormCubit(sessionRepository: getIt(), original: original),
    );
}
