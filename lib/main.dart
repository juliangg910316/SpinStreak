/// Punto de entrada: inicializa intl y las dependencias y arranca la app.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'config/dependencies.dart';
import 'routing/app_router.dart';
import 'routing/route_names.dart';
import 'ui/core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fechas y números en español ("sábado, 10 de octubre", "12,5").
  Intl.defaultLocale = 'es';
  await initializeDateFormatting('es');

  _registrarLicenciasFuentes();
  setupDependencies();
  runApp(const SpinStreakApp());
}

/// Añade las licencias OFL de las fuentes incluidas (spec 005, RNF-3) a la
/// página de licencias de Flutter.
void _registrarLicenciasFuentes() {
  LicenseRegistry.addLicense(() async* {
    for (final (fuente, archivo) in const [
      ('Figtree', 'assets/fonts/OFL-Figtree.txt'),
      ('Bricolage Grotesque', 'assets/fonts/OFL-BricolageGrotesque.txt'),
    ]) {
      yield LicenseEntryWithLineBreaks([
        fuente,
      ], await rootBundle.loadString(archivo));
    }
  });
}

class SpinStreakApp extends StatelessWidget {
  const SpinStreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpinStreak',
      // Spec 005: paleta "Fuego"; sigue el modo claro u oscuro del móvil y
      // cambia sin reiniciar (RF-6 a RF-8).
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      // RC-3: también los textos propios de Flutter (menú Cortar/Copiar/
      // Pegar, tooltips como "Atrás") en español.
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
