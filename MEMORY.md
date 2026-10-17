# MEMORY.md -- SpinStreak

## Estado actual (2026-10-16)
- **Spec 001 (registro de sesiones): `implementada`** (11 tareas; validada el 2026-10-13). Hay formulario de alta y edición, selector de tiempo, ayuda ⓘ, historial por día con totales, borrado con confirmación y navegación desde el inicio.
- **Spec 002 (rachas): `implementada`** (4 tareas; validada el 2026-10-14). El inicio muestra la fecha, un "mensaje del día" (bienvenida, a salvo, riesgo o racha reiniciada) y los contadores, y recalcula al volver la app al primer plano.
- **Spec 003 (calendario): `implementada`** (7 tareas; validada el 2026-10-15). Botón "Calendario" en el inicio; mes con días entrenados, hoy seleccionado y sesiones del día editables.
- **Spec 004 (récords): `implementada`** (6 tareas; validada el 2026-10-16). Pantalla "Récords" y aviso de récord al registrar.
- Base de datos en `schemaVersion` 2 (velocidad máxima entera, migración verificada en el móvil).
- **Spec 005 (diseño visual): `implementada`** (9 tareas; validada el 2026-10-17 con el recorrido del autor en el simulador de iOS). Paleta "Fuego" en claro y oscuro (`ColorScheme` a mano + `ColoresApp`), Figtree y Bricolage Grotesque en `assets/fonts/`, widgets compartidos `TarjetaAviso`/`EstadoError`/`mostrarAviso`/`TarjetaDia`. Diseño de referencia: https://claude.ai/artifact/Lb8Ea2k8nbwZStQ324fmuc. Las comprobaciones visuales se hacen en el simulador de iOS (`xcrun simctl ui booted appearance dark|light`, `xcrun simctl io booted screenshot`); para ver una pantalla sin tocar, cambiar temporalmente `initialRoute`. No puedo tocar el simulador: lo interactivo lo prueba el autor. 
- Sin tests (`test/` no existe). Git: el autor hizo commit de las specs 001 a 004 (último: `dadf6fb`, 2026-10-16).

## Decisiones (y por qué)
- Android e iOS (antes solo Android; iOS añadido por el autor el 2026-10-17), uso personal y datos solo locales: es una app personal y no necesita backend.
- Racha estrictamente diaria, sin comodines: así lo decidió el autor.
- No se registran días pasados: evita "rellenar" una racha rota. **Riesgo aceptado**: una sesión sin registrar o borrada por error rompe la racha sin remedio.
- Sin copia de seguridad hasta la v2: **riesgo aceptado** de perder datos al desinstalar o cambiar de móvil.
- Columna `dia` en hora local (`yyyy-MM-dd`) calculada al registrar: es la clave de la racha y del agrupado del historial.
- Fila de drift `SessionRow`: evita el choque de nombres con el modelo de dominio `Session`.
- DI en `lib/config/` (no en `core/di`). `docs/setup/` es histórico.
- Sin tests por ahora: decisión del autor.
- Validaciones de negocio en `lib/domain/` (`validarSesion`), nunca en el formulario ni en el Cubit.
- Sin streams: el repositorio devuelve `Future<Result<T>>` y los Cubits recargan (`cargar()`) tras cada acción y al volver de otra pantalla. El autor prefiere el control explícito.
- `freezed` en todos los modelos de dominio y estados de Cubit (estado = clase freezed + enum `status`). Constitución actualizada (principio 1), 2026-10-13.
- Tiempo como `Duration` (no `DateTime`): representa una duración y los totales pueden pasar de 24 h. Se elige con un selector propio (`CupertinoPicker`, máx. 05:00:00).
- Entrada numérica: coma o punto decimal, sin separador de miles ("1.234,5" no es válido; ",5" = 0,5). Se muestran todos los errores a la vez.
- `flutter_localizations` + `locale: es`: RC-3 también exige en español los textos propios de Flutter (aprobado el 2026-10-13).
- Spec-Driven Development: constitución en `docs/constitution.md`; skill `sdd` y comandos `/sdd-*`. `spec.md`, `plan.md` y `tasks.md` solo pasan a `aprobada` cuando el autor lo dice.
- `docs/ESPECIFICACION.md` = visión global + requisitos comunes (RC-1 a RC-3). Los RF de cada funcionalidad solo viven en `specs/`.
- 4 specs para el MVP (001 registro, 002 rachas, 003 calendario, 004 récords). Evolución semanal y mensual, y diferencia de odómetro: v2.

## Errores a evitar
- No controlar el móvil del autor con `adb shell input` (toques y texto a ciegas): otra app puede pasar a primer plano y recibir la entrada. Para comprobaciones visuales, pedírselas al autor; `adb` solo para instalar, capturar pantalla o leer la BD.
- RC-3 incluye los textos propios de Flutter/Material: `intl` no basta. Revisarlo en cada plan.
- Antes de un "Hecho cuando" visual, comprobar con `flutter devices` que hay un dispositivo (móvil Android o simulador de iOS).
- Probar migraciones sin tocar datos reales: copiar la BD del móvil (`adb exec-out run-as com.juliangg.spin_streak cat app_flutter/spinstreak.sqlite`), meter una BD de prueba, instalar con `adb install -r`, abrir, traer la BD, inspeccionarla con `node:sqlite` y restaurar el original. En Git Bash usar `MSYS_NO_PATHCONV=1`. `run-as` solo funciona con la APK **debug** instalada (con la release falla con "package not debuggable"); se puede instalar encima con `adb install -r` sin perder datos (misma firma). El móvil puede desconectarse a mitad de la prueba: guardar siempre la copia original **antes** y, si se pierde la conexión, avisar al autor de que no toque datos hasta restaurarla.
- Si una tarea solo se puede probar desde una pantalla que aún no existe, decidir con el autor si se pospone la comprobación (se hizo en T8 y T9, verificadas en T10).

## Próximos pasos (MVP)
- [x] 001-registro-sesiones: **implementada** (2026-10-13).
- [x] 002-rachas: **implementada** (2026-10-14).
  - Decidido: botones "Historial", "Calendario" y "Récords" bajo los contadores (sin barra inferior); un único mensaje del día; recálculo al volver a la app.
  - Hecho: `Streak.trainedToday`, `MensajeDia` + `mensajeDelDia`, `formatearDias`, "hoy" en `HomeState` (sin `DateTime.now()` en la UI) y `AppLifecycleListener`.
  - Verificado con script temporal (12 casos) y con BD de prueba en el móvil (con permiso; BD original restaurada e idéntica).
- [x] 003-calendario: **implementada** (2026-10-15; 7 tareas).
  - Decidido: vista mensual L–D con flechas sin pasar del mes de hoy; mismo círculo para todo día entrenado; hoy seleccionado al abrir y al volver al mes de hoy (cambio del autor del 2026-10-14, RF-15/RF-16), con fecha y "Hoy aún no has entrenado…" si no tiene sesiones; sesiones del día debajo, editables.
  - Hecho: cuadrícula propia (sin `table_calendar`), `construirMes`, `diaASeleccionar` y `CeldaDia.seleccionable` en domain; `CabeceraDia`, `FilaSesion` y `editarSesion` compartidos en `ui/core/ui/`.
  - Verificado con scripts temporales (23 + 12 casos) y BD de prueba en el móvil (con permiso; BD original restaurada e idéntica). RF-14 solo revisando el código.
  - **Anomalía de escritura (investigada el 2026-10-16):** con BD de prueba cargadas por `cargar_bd.sh` faltaban escrituras en el archivo (002, 003 y 004: el alta del paso 2 con la BD vacía, `sqlite_sequence` sin cambiar; el borrado del paso 8). Experimento con una copia idéntica de la BD real: alta, cierre desde recientes, reapertura y borrado llegan **al instante** al archivo (mismo inode, sin `-journal` ni `-wal`). En el uso normal la app guarda bien. Causa del fallo en las pruebas sin identificar (algo del cambio de BD o del momento de las lecturas). En próximas pruebas, leer el archivo con la app abierta tras cada escritura para detectarlo.
- [x] 004-records: **implementada** (2026-10-16; 6 tareas).
  - Decidido: pantalla propia con botón "Récords" bajo "Calendario"; 4 récords (tiempo, distancia, velocidad máxima, pulso máximo); aviso "Sesión guardada. ¡Nuevo(s) récord(s) de …!" solo al registrar, solo si se supera estrictamente y nunca en la primera sesión ni con el primer dato opcional; tocar un récord abre la edición de su sesión.
  - Hecho: `calcularRecords`/`recordsBatidos` en domain (sin "hoy"); el formulario calcula los récords batidos antes de guardar y se cierra con `ResultadoFormulario`; formatos "32 km/h" y "160 ppm".
  - Verificado con scripts temporales y BD de prueba en el móvil (con permiso; BD original restaurada e idéntica). RF-7 solo revisando el código.
- [ ] Más adelante (decisión del autor, 2026-10-16): **récord de calorías**. Quedó fuera de la 004 (las calorías son una estimación de la bici); requiere cambiar la spec 004 (5 récords) y seguir el flujo.
- El MVP (specs 001 a 004) está completo. En el móvil está instalada la APK **release** desde cero (2026-10-16, a petición del autor: se desinstaló y se borraron los datos). Para leer la BD por `adb` hace falta volver a instalar la debug.
