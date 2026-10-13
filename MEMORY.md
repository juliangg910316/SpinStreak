# MEMORY.md -- SpinStreak

## Estado actual (2026-10-13)
- **Spec 001 (registro de sesiones): `implementada`** (11 tareas; validada el 2026-10-13). Hay formulario de alta y edición, selector de tiempo, ayuda ⓘ, historial por día con totales, borrado con confirmación y navegación desde el inicio.
- Base de datos en `schemaVersion` 2 (velocidad máxima entera, migración verificada en el móvil).
- Sin tests (`test/` no existe). Git: 2 commits; **todo el trabajo de la spec 001 está sin commitear**.

## Decisiones (y por qué)
- Solo Android, uso personal y datos solo locales: es una app personal y no necesita backend.
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
- Antes de un "Hecho cuando" visual, comprobar con `flutter devices` que hay un dispositivo Android.
- Probar migraciones sin tocar datos reales: copiar la BD del móvil (`adb exec-out run-as com.juliangg.spin_streak cat app_flutter/spinstreak.sqlite`), meter una BD de prueba, instalar con `adb install -r`, abrir, traer la BD, inspeccionarla con `node:sqlite` y restaurar el original. En Git Bash usar `MSYS_NO_PATHCONV=1`.
- Si una tarea solo se puede probar desde una pantalla que aún no existe, decidir con el autor si se pospone la comprobación (se hizo en T8 y T9, verificadas en T10).

## Próximos pasos (MVP)
- [x] 001-registro-sesiones: **implementada** (2026-10-13).
- [ ] Commit del trabajo de la spec 001 (cuando el autor lo pida).
- [ ] 002-rachas: resolver dudas (`/sdd-spec`) → validar lo existente → completar. Ojo:
  - la navegación del inicio ya la fija la 001 (botón flotante + "Historial");
  - su RF-8 ("contadores a 0" sin sesiones) choca con RC-2 (mensaje para empezar).
- [ ] 003-calendario: resolver dudas → flujo completo. Ojo: "calendario vacío" sin sesiones choca con RC-2.
- [ ] 004-records: resolver dudas → flujo completo.
