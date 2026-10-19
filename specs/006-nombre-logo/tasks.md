# Tareas 006 — Nombre y logo de la app
Estado: aprobada

Plan: `specs/006-nombre-logo/plan.md` (aprobado). En cada tarea: `dart format .` sin cambios y `flutter analyze` sin avisos. Las comprobaciones en el móvil se hacen con `flutter run` y las confirma el autor. No se toca ningún identificador de la app (RNF-3).

- [x] **T1. Fuente del logo y script de generación.** RF-3, RF-8, RNF-2
  - `docs/marca/simbolo.svg` con la geometría de la sección 4.1 del plan, `docs/marca/README.md` y `tool/generar_iconos.sh`, que crea las seis salidas de la sección 4.2 en una carpeta temporal (sin copiarlas aún a `android/` ni a `ios/`).
  - Hecho cuando: el script termina sin errores; `sips` da los tamaños de la tabla 4.2, sin alfa los iconos claro y tintado de iOS y con alfa el oscuro y las capas de Android; y los PNG se ven como el tablero «C · Rueda Viva» (claro, oscuro, tintado y monocromo, con la llama separada de los radios).
  - Comprobado (2026-10-19): el script genera los 18 PNG en unos 11 s; `sips` da 1024 px para iOS (claro y tintado sin alfa, oscuro con alfa), 108 a 432 px para las capas de Android y 48 a 192 px para el icono antiguo, todos con alfa. En una hoja de contacto, las seis variantes coinciden con el diseño: la cubierta cabe entera en el recorte circular y, en el monocromo, la llama queda separada de los radios. El contorno y el recorte de la llama son máscaras en un `<g>` sin `transform` (con la máscara en el mismo elemento que el `transform`, se aplicaría en sus coordenadas).

- [x] **T2. Icono y nombre en Android.** RF-1, RF-3, RF-4, RF-5, RF-8
  - El script copia los PNG a los `mipmap-*dpi` (`ic_launcher`, `ic_launcher_foreground` e `ic_launcher_monochrome`); `mipmap-anydpi-v26/ic_launcher.xml`, `values/ic_launcher_background.xml` y `android:label="Rueda Viva"`.
  - Hecho cuando: `flutter build apk --debug` compila; el autor ve en su móvil el icono de la rueda y el nombre "Rueda Viva", sin cortes con la forma de su launcher y en monocromo con los iconos temáticos activados.
  - Estado (2026-10-19): código hecho. `tool/generar_iconos.sh --instalar` copia los 15 PNG a los `mipmap-*dpi`. `flutter build apk --debug` compila (Gradle descargó CMake 3.22.1 la primera vez), y `aapt2` confirma en el APK la etiqueta "Rueda Viva", el icono `mipmap-anydpi-v26/ic_launcher.xml` con fondo, primer plano y monocromo, y los PNG de las 5 densidades. Sin dispositivo Android conectado. **Confirmado por el autor** (2026-10-19) en su móvil.

- [x] **T3. Icono y nombre en iOS.** RF-1, RF-2, RF-6, RF-7, RF-8
  - El script copia `icono-claro.png`, `icono-oscuro.png` e `icono-tintado.png` a `AppIcon.appiconset`; `Contents.json` de tamaño único con las tres apariencias; se borran los 15 PNG antiguos; `CFBundleDisplayName` = "Rueda Viva".
  - Hecho cuando: la app compila y se instala en el simulador; la captura de la pantalla de inicio muestra el icono y "Rueda Viva". El autor comprueba los modos oscuro y tintado del icono.
  - Estado (2026-10-19): código hecho. `tool/generar_iconos.sh --instalar` también copia los 3 PNG de iOS. `flutter build ios --simulator --debug` compila (Xcode 27.1); el `Assets.car` lleva el icono de 1024 en las apariencias clara, `UIAppearanceDark` e `ISAppearanceTintable`. Instalada encima de la versión anterior en el simulador (iPhone 18 Pro): la pantalla de inicio muestra la rueda y "Rueda Viva". Con el simulador en modo oscuro los iconos siguen en claro (también los de Apple): el estilo de iconos se cambia en «Personalizar» de la pantalla de inicio, **Confirmado por el autor** (2026-10-19): variantes oscura y tintada.

- [x] **T4. Símbolo dentro de la app.** RF-10, RF-11
  - `logoRueda` en `ColoresApp` (claro `#1F1A17`, oscuro `#FFF8F3`, con `copyWith` y `lerp`) y `SimboloRueda(tamano)` en `lib/ui/core/ui/simbolo_rueda.dart` (`CustomPaint`, radio del 24 %, borde fino en claro, `ExcludeSemantics`).
  - Hecho cuando: compila y, en una prueba temporal en el simulador (sin dejar código), el símbolo a 32 y a 200 px coincide con el SVG en los dos modos.
  - Comprobado (2026-10-19) en el simulador de iOS, con un `builder` temporal en `MaterialApp` (ya quitado; `main.dart` sin cambios): a 200 px la rueda ocupa el 68 % del lado, como en `icono-claro.png`, y los radios se cortan alrededor de la llama; en oscuro, la rueda crema sobre `#1C1B1F` coincide con `icono-oscuro.png`. El contorno y el recorte de la llama se borran con `BlendMode.clear` dentro de un `saveLayer` (como las máscaras del SVG). El borde en claro es `onSurface` al 14 %, el `#1F1A17` al 14 % del diseño (el plan decía `outline` con alfa).

- [x] **T5. Barra del inicio y título de la app.** RF-2, RF-9, RF-10, RF-11
  - `AppBar` del inicio con `SimboloRueda(32)`, 10 px y "Rueda " + "Viva" (en `textoPrincipal`) con `FittedBox`; `title: 'Rueda Viva'` en `main.dart`.
  - Hecho cuando: en el simulador, el inicio coincide con el tablero «Inicio» del diseño en claro y oscuro; con el texto del sistema al máximo el nombre no se corta; y tras instalar encima de la versión anterior las sesiones siguen ahí (RNF-3).
  - Comprobado (2026-10-19) en el simulador de iOS: el inicio muestra el símbolo y "Rueda Viva" con "Viva" en `#C2410C` (claro) y `#FF5A1F` (oscuro), como el tablero «Inicio»; con el texto del sistema al máximo (`accessibility-extra-extra-extra-large`) el nombre se ve entero. RNF-3: la BD del simulador tenía 1 sesión antes de instalar la versión nueva encima y la sigue teniendo después (leída en solo lectura). **Confirmado por el autor** (2026-10-19) en Android (apps recientes, RF-2).

- [x] **T6. Documentación.** —
  - `.claude/rules/design-system-and-theming.md` (`logoRueda`, `SimboloRueda` y cómo regenerar los iconos) y `MEMORY.md`.
  - Hecho cuando: la regla describe el símbolo y el script, y `MEMORY.md` tiene el estado de la spec.
  - Hecho (2026-10-19): la regla de tema añade `logoRueda`, `SimboloRueda` y que los iconos se regeneran con el script (nunca a mano, y el SVG y el widget cambian a la vez). `MEMORY.md` tiene el estado, lo que falta por comprobar y cómo leer la BD del simulador.
