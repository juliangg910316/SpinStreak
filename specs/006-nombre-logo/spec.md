# Spec 006 — Nombre y logo de la app
Estado: aprobada

## Contexto y objetivo
La app se llama provisionalmente "SpinStreak" y usa el icono por defecto de Flutter. Esta spec le da un nombre y un logo propios, elegidos por el autor el 2026-10-19 entre tres opciones del diseño de referencia: **Rueda Viva**, con el logo de la rueda de bici. La rueda es la bici y "viva" es la racha que se mantiene encendida pedaleando cada día. El nombre en español se pronuncia y se escribe sin dudas, y no choca con apps conocidas como "Streaks".

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero reconocer la app en la pantalla de inicio del móvil por su icono y su nombre para abrirla rápido.
- HU-2. Como usuario, quiero que el icono se vea bien en modo claro, en modo oscuro y con los iconos temáticos del sistema.
- HU-3. Como usuario, quiero ver el logo y el nombre en la parte superior del inicio de la app.

## Definiciones
- **Nombre**: "Rueda Viva" (10 caracteres, con espacio).
- **Símbolo**: una rueda de bici vista de frente. Tiene una cubierta (un anillo grueso), 7 radios (uno por cada día de una semana seguida) y, en el centro, la llama de la racha como buje, con un recorte interior y un contorno del color del fondo que la separa de los radios. No lleva texto.
- **Icono de la app**: el símbolo sobre un fondo liso, con la forma que le dé cada sistema.
- **Logotipo**: el símbolo seguido del nombre en Bricolage Grotesque 800, con "Viva" en el color de texto principal de la paleta.
- **Variantes del icono**:

  | Variante | Fondo | Rueda | Llama |
  | --- | --- | --- | --- |
  | Claro (por defecto) | `#FFF8F3` | `#1F1A17` | `#FF5A1F` |
  | Oscuro | transparente en iOS (el sistema pone su fondo oscuro); `#1C1B1F` en la barra del inicio | `#FFF8F3` | `#FF5A1F` |
  | Tintado (iOS) | `#000000` | `#B8B8B8` | `#FFFFFF` |
  | Monocromo (Android, iconos temáticos) | transparente | un solo color (lo pone el sistema) | el mismo color |

- **Zona segura (Android)**: en el icono adaptativo de 108 dp, el círculo central de 66 dp que ningún recorte del sistema tapa.
- **Diseño de referencia**: el lienzo "Rueda Viva · Diseño de la app" (https://claude.ai/artifact/Lb8Ea2k8nbwZStQ324fmuc). Los tableros "Tres opciones de nombre", "Icono (componente)" y "C · Rueda Viva · rueda de bici" tienen el símbolo, sus variantes, los tamaños reales y el logotipo. Si no coincide con esta spec, manda la spec.

## Requisitos funcionales

### Nombre
- RF-1: EL SISTEMA muestra "Rueda Viva" como nombre de la app bajo su icono, en la pantalla de inicio y en los ajustes del móvil, en Android y en iOS.
- RF-2: EL SISTEMA usa "Rueda Viva" como título de la app en la lista de apps recientes o en el selector de apps del sistema.

### Icono de la app
- RF-3: EL SISTEMA usa como icono de la app el símbolo en su variante clara, en Android y en iOS.
- RF-4: EL SISTEMA proporciona en Android un icono adaptativo: un fondo `#FFF8F3` y el símbolo en otra capa, entero dentro de la zona segura, para que ningún recorte del launcher (círculo, squircle o cuadrado redondeado) lo corte.
- RF-5: EL SISTEMA proporciona en Android la capa monocroma, para que el símbolo se vea con el color del tema MIENTRAS el usuario tiene activados los iconos temáticos.
- RF-6: EL SISTEMA proporciona en iOS el icono de 1024 × 1024 px cuadrado (el sistema redondea las esquinas) en tres variantes: la clara, sin transparencia; la oscura, con el fondo transparente para que iOS ponga el suyo (cambio del autor del 2026-10-19: así lo recomienda Apple); y la tintada.
- RF-7: MIENTRAS el usuario de iOS tiene los iconos en modo oscuro o tintado, EL SISTEMA muestra la variante oscura o la tintada.
- RF-8: EL SISTEMA muestra el icono sin detalles que se pierdan a 48 dp (Android) ni a 29 pt (ajustes de iOS): la cubierta, los radios y la llama se distinguen.

### Inicio
- RF-9: EL SISTEMA muestra en la barra superior del inicio el símbolo a 32 px, en un cuadrado con las esquinas redondeadas (radio del 24 %), y a 10 px el nombre "Rueda Viva" en 22 px, peso 700, con "Viva" en el color de texto principal (`#C2410C` en claro y `#FF5A1F` en oscuro). Sustituye el título "SpinStreak" de la spec 005 (RF-9).
- RF-10: MIENTRAS el móvil está en modo oscuro, EL SISTEMA muestra el símbolo de la barra superior en su variante oscura; en modo claro, en la clara, con un borde fino para separarlo del fondo crema.
- RF-11: EL SISTEMA no anuncia el símbolo de la barra superior por separado en el lector de pantalla: es decorativo y el nombre ya se lee.

## Requisitos no funcionales
- RNF-1: Contraste (WCAG 2.1) de la rueda con su fondo: al menos 3:1 en todas las variantes (claro 16,4:1, oscuro 16,3:1 sobre `#1C1B1F`, tintado 10,6:1). La llama da 5,5:1 en oscuro y 2,97:1 en claro (ver casos límite).
- RNF-2: El icono y el logotipo se incluyen en la app; no se descargan.
- RNF-3: Cambiar el nombre no borra ni migra datos: los identificadores internos de la app y la base de datos no cambian.

## Navegación
No añade pantallas ni cambia la navegación. Afecta al icono y al nombre de la app en el sistema y a la barra superior del inicio. Las pantallas secundarias mantienen su barra con la flecha de volver y su título (spec 005, RF-15).

## Casos límite
- **Launcher de Android que recorta en círculo**: la cubierta de la rueda, de radio 24 sobre 108 dp, queda dentro de la zona segura de 66 dp (radio 33).
- **Android sin iconos temáticos o con una versión anterior a la 13**: se ve el icono adaptativo a color; la capa monocroma no se usa.
- **Modo oscuro en Android**: el icono del launcher no cambia (Android no tiene variante oscura del icono); solo cambia el símbolo de la barra superior de la app (RF-10).
- **Nombre cortado bajo el icono**: con 10 caracteres cabe en las rejillas habituales de 4 o 5 columnas. Si un launcher lo corta ("Rueda Vi…"), se acepta.
- **Icono oscuro de iOS**: el fondo lo pone el sistema (un degradado casi negro), así que el contraste depende de él; con la rueda `#FFF8F3` y la llama `#FF5A1F` queda por encima de 3:1 sobre cualquier fondo oscuro.
- **Llama sobre el crema (2,97:1)**: queda una centésima por debajo de 3:1. Se acepta porque WCAG 2.1 exime a los logotipos (criterio 1.4.11) y porque lo que hace reconocible el icono a tamaño pequeño es la rueda casi negra (16,4:1).
- **Texto del sistema muy grande**: el nombre de la barra superior se reduce para no cortarse (como los números, spec 005 RF-14), y el símbolo no cambia de tamaño.

## Fuera de alcance
- Cambiar el identificador de la app (`com.juliangg.spin_streak` en Android, `com.juliangg.spinStreak` en iOS), el nombre del paquete Dart, el nombre de la base de datos o el del repositorio: cambiarlos instalaría otra app o perdería los datos (RNF-3).
- Pantalla de arranque (splash) con el logo: sigue la del sistema.
- La frase "Cada día, otra vuelta." del diseño de referencia: no se muestra en la app.
- El logotipo horizontal grande: solo para documentación o portafolio, no se usa en la app.
- Los logos A (Brasa) y B (SpinStreak) y sus nombres.
- Publicar la app en las tiendas (iconos de tienda, capturas, ficha).

## Criterios de finalización
- En Android y en iOS, la pantalla de inicio del móvil muestra el icono de la rueda y el nombre "Rueda Viva".
- En Android, el icono no se corta con las formas círculo, squircle y cuadrado redondeado, y se ve en monocromo con los iconos temáticos.
- En iOS, el icono cambia con los modos claro, oscuro (con el fondo oscuro del sistema) y tintado.
- El inicio de la app muestra el símbolo y "Rueda Viva" en la barra superior, en los dos modos, como el diseño de referencia.
- Tras instalar la versión nueva encima de la anterior, las sesiones registradas siguen ahí.

## Dudas abiertas
- Ninguna. Las decisiones de "Fuera de alcance" (splash, frase y no cambiar identificadores) se revisan al aprobar la spec.
