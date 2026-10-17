# Spec 005 — Diseño visual de las pantallas
Estado: implementada

## Contexto y objetivo
Las pantallas del MVP (specs 001 a 004) funcionan, pero usan los colores por defecto. Esta spec define una identidad visual común que transmita energía y refuerce la motivación de la racha: la racha se ve como una llama que no hay que dejar apagar. Cubre la paleta de colores y el diseño de todas las pantallas: inicio, registro y edición de sesiones, historial, calendario y récords.

## Usuarios
- El autor: un único usuario que entrena a diario.

## Historias de usuario
- HU-1. Como usuario, quiero que la app tenga colores cálidos y enérgicos para que abrirla me motive a entrenar.
- HU-2. Como usuario, quiero que la racha destaque con un color propio para verla de un vistazo.
- HU-3. Como usuario, quiero que la app se vea bien con el modo claro y con el modo oscuro del móvil.
- HU-4. Como usuario, quiero que los textos se lean con facilidad sobre cualquier fondo.
- HU-5. Como usuario, quiero que la racha actual sea lo primero que vea al abrir la app.

## Definiciones
- **Paleta "Fuego"**: los colores base de la app.

  | Rol | Color | Hex |
  | --- | --- | --- |
  | Principal | Naranja intenso | `#FF5A1F` |
  | Secundario | Ámbar | `#FFB020` |
  | Acento de la racha | Rojo fuego | `#E53935` |
  | Fondo (modo claro) | Crema cálido | `#FFF8F3` |
  | Fondo (modo oscuro) | Grafito | `#1C1B1F` |
  | Texto (modo claro) | Casi negro | `#1F1A17` |

- **Colores derivados**: los que completan la paleta en cada modo, definidos en el diseño de referencia (ver "Colores por modo").
- **Color principal**: el de los botones de acción principales y los elementos destacados de la interfaz.
- **Acento de la racha**: el color reservado para la racha (números de racha actual y mejor racha, y su icono de llama). No se usa para nada más.
- **Contraste**: relación de contraste según WCAG 2.1. Texto normal: mínimo 4,5:1. Texto grande (≥ 24 px, o ≥ 18,5 px en negrita) e iconos: mínimo 3:1.
- **Diseño de referencia**: el lienzo "SpinStreak · Inicio" (https://claude.ai/artifact/Lb8Ea2k8nbwZStQ324fmuc). Contiene, en modo claro y oscuro: el inicio con los 4 estados del mensaje del día; el formulario (alta, edición, errores, guardando, hoja "Tiempo", diálogos y avisos); el historial, el calendario y los récords con sus estados (vacío, error, carga y avisos); y una hoja con colores, tipografía, medidas e iconos. Si el diseño y esta spec (o las specs 001 a 004) no coinciden, mandan las specs.
- **Pantalla secundaria**: historial, calendario, récords y formulario. Tienen barra superior con flecha de volver y su título.

### Colores por modo

| Uso | Claro | Oscuro |
| --- | --- | --- |
| Fondo de pantalla | `#FFF8F3` | `#1C1B1F` |
| Tarjetas de contadores | `#FFFFFF` | `#2A2629` |
| Bordes de tarjetas | `#F1E1D6` | `#3A3437` |
| Texto principal | `#1F1A17` | `#F4EDE8` |
| Texto secundario (fecha, etiquetas, unidades) | `#6B5C53` | `#CBBFB7` |
| Botón principal: fondo / texto | `#FF5A1F` / `#1F1A17` | `#FF5A1F` / `#1F1A17` |
| Texto en color principal (p. ej. «Streak» del título) | `#C2410C` | `#FF5A1F` |
| Botones secundarios: fondo / icono | `#FFE3D6` / `#A63A0B` | `#3A2A24` / `#FFB59A` |
| Acento de la racha / círculo de la llama | `#E53935` / `#FDE7E5` | `#E53935` / `#3B2224` |
| Mensaje "Riesgo": fondo / icono y texto secundario | `#FFE9C2` / `#6B4A00` | `#45330F` / `#FFB020` |
| Mensaje "A salvo": fondo / icono | `#FFE3D6` / `#8F3209` | `#4A2717` / `#FFB59A` |
| Mensajes "Bienvenida" y "Reiniciada": fondo | `#F5E9E1` | `#2A2629` |
| Error: icono y texto / fondo del icono | `#8E244D` / `#FFD9E3` | `#FFB1C8` / `#5C1A33` |
| Aviso normal: fondo / texto | `#362F2B` / `#FBEEE8` | `#EDE0D8` / `#1F1A17` |
| Aviso de récord: fondo / texto | `#FFB020` / `#1F1A17` | `#FFB020` / `#1F1A17` |
| Borde de campos de texto y asa de la hoja inferior | `#8C7A6F` | `#9A8C84` |
| Diálogos y hoja inferior | `#FFFFFF` | `#322D31` |
| Fondo tras diálogos y hoja | `#1F1A17` al 50 % | `#000000` al 60 % |
| Botones de texto (Cancelar, Entendido, Seguir editando) | `#A63A0B` | `#FFB59A` |
| Día entrenado del calendario: círculo / número | `#FF5A1F` / `#1F1A17` | `#FF5A1F` / `#1F1A17` |
| Récords: caja del icono / icono | `#FFE9C2` / `#6B4A00` | `#45330F` / `#FFB020` |

### Tipografía
- Títulos y números: **Bricolage Grotesque**. Textos: **Figtree**. Ambas incluidas en la app (sin descargarlas de internet).
- Número de la racha actual: 80 px, peso 800. Números de los contadores: 32 px, peso 700. Título de la app: 22 px, peso 700. Mensaje del día: 15 px. Etiquetas y unidades: 13 px.
- Títulos de pantallas secundarias, diálogos y hoja inferior: 22 px, peso 700. Valor de un récord: 28 px, peso 700. Mes del calendario: 18 px, peso 700.
- Valor de un campo: 16 px. Etiqueta y error de un campo: 12 px, peso 600. Fila de sesión: 15 px (principal) y 13 px (secundaria). Cabecera de día: 15 px, peso 700, y 13 px los totales. Días del calendario: 14 px (700 los marcados).
- Los números usan cifras de ancho fijo y el formato español con punto de millar ("1.000").

## Requisitos funcionales

### Paleta
- RF-1: EL SISTEMA usa la paleta "Fuego" y sus colores derivados en todas las pantallas.
- RF-2: EL SISTEMA usa el color principal en los botones de acción principales de cada pantalla, con el texto casi negro (`#1F1A17`).
- RF-3: EL SISTEMA muestra los números de la racha actual y de la mejor racha, y sus iconos de llama, con el acento de la racha.
- RF-4: EL SISTEMA no usa el acento de la racha en ningún elemento que no esté relacionado con la racha, ni en texto de menos de 24 px.
- RF-5: EL SISTEMA muestra los mensajes de error con el color de error (berenjena) y su icono, distinto del acento de la racha.

### Modo claro y oscuro
- RF-6: MIENTRAS el móvil está en modo claro, EL SISTEMA usa los colores de la columna "Claro".
- RF-7: MIENTRAS el móvil está en modo oscuro, EL SISTEMA usa los colores de la columna "Oscuro".
- RF-8: CUANDO el usuario cambia el modo claro u oscuro del móvil, EL SISTEMA aplica el modo nuevo sin reiniciar la app.

### Pantalla de inicio
- RF-9: EL SISTEMA muestra en el inicio, de arriba abajo: el título "SpinStreak" (con "Streak" en el color principal), la fecha de hoy, el mensaje del día, la tarjeta de la racha actual, las tarjetas de mejor racha y días entrenados (una al lado de la otra) y, bajo el encabezado "Explorar", los accesos "Historial", "Calendario" y "Récords" (en una fila de tres).
- RF-10: EL SISTEMA muestra la racha actual en una tarjeta propia, centrada, con el icono de llama, el número en 80 px, la etiqueta "Racha actual" y debajo la unidad "día seguido" si la racha es 1 o "días seguidos" en otro caso.
- RF-10b: EL SISTEMA muestra junto al número de la mejor racha y de los días entrenados la unidad "día" si el valor es 1 o "días" en otro caso.
- RF-11: EL SISTEMA muestra cada estado del mensaje del día con su icono y su color: "Bienvenida" (mano, neutro), "A salvo" (check, color principal suave), "Riesgo" (aviso, ámbar) y "Reiniciada" (reinicio, neutro), con los mismos textos que define la spec 002.
- RF-12: EL SISTEMA muestra el botón "Registrar sesión" flotante abajo a la derecha, con el icono "+", sin tapar el último bloque al desplazar la pantalla.
- RF-13: CUANDO se guarda una sesión, EL SISTEMA muestra el aviso "Sesión guardada" con el fondo del aviso normal, y SI bate algún récord, ENTONCES lo muestra con el fondo del aviso de récord (ámbar) y un icono de trofeo.
- RF-14: SI un número de los contadores no cabe en su espacio (p. ej. con el texto del sistema ampliado), ENTONCES EL SISTEMA lo reduce de tamaño en lugar de cortarlo.

### Pantallas secundarias (comunes)
- RF-15: EL SISTEMA muestra en cada pantalla secundaria una barra superior con la flecha de volver y el título de la pantalla.
- RF-16: SI una pantalla no puede cargar sus datos, ENTONCES EL SISTEMA muestra, centrados, un icono de error en un círculo y el mensaje de error de su spec, sin botón de reintentar.
- RF-17: SI una pantalla no tiene datos (RC-2), ENTONCES EL SISTEMA muestra su mensaje en una tarjeta neutra con icono, como los mensajes "Bienvenida" y "Reiniciada" del inicio.
- RF-18: MIENTRAS una pantalla carga sus datos, EL SISTEMA muestra un indicador circular en el color principal.
- RF-19: EL SISTEMA muestra los avisos inferiores con el fondo del aviso normal y un icono: check para "Sesión actualizada", papelera para "Sesión borrada" y error para los fallos al guardar o borrar.

### Formulario de sesión
- RF-19b: MIENTRAS se edita una sesión, EL SISTEMA muestra la acción de borrar como un icono de papelera, sin texto, en la barra superior, con la descripción accesible "Borrar" (cambio sobre la spec 001, decisión del autor del 2026-10-17: diseño más limpio y un icono muy reconocible).
- RF-20: EL SISTEMA muestra cada campo con borde, la etiqueta sobre el borde y la unidad al final una vez escrito el valor, y a su derecha el botón ⓘ (menos la nota).
- RF-21: SI un campo tiene error, ENTONCES EL SISTEMA dibuja su borde de 2 px y su etiqueta en el color de error, y debajo el icono de error y el mensaje.
- RF-22: EL SISTEMA muestra el botón "Guardar" a lo ancho, fijo en la parte inferior de la pantalla, con el color principal; MIENTRAS guarda, muestra un indicador circular junto al texto.
- RF-23: EL SISTEMA muestra la hoja "Tiempo" con tres ruedas ("h", "min", "s"), una banda que marca el valor elegido y los botones "Cancelar" (botón de texto) y "Aceptar" (color principal).
- RF-24: EL SISTEMA muestra los diálogos de ayuda, borrar y descartar con el fondo de diálogo y radio de 28 px. Las acciones destructivas ("Borrar", "Descartar") usan el color de error; las demás, el de botones de texto.

### Historial
- RF-25: EL SISTEMA muestra cada día con su cabecera (fecha y totales) fuera de la tarjeta y sus sesiones dentro de una tarjeta con borde, separadas por líneas de 1 px. Cada fila muestra la hora, la línea principal, la secundaria y un chevron.

### Calendario
- RF-26: EL SISTEMA muestra cada día entrenado con un círculo de 40 px relleno del color principal (`#FF5A1F`) y el número en `#1F1A17`; hoy, con un borde interior de 2 px en el color del texto principal; el día seleccionado, con un anillo exterior en el color de texto principal de la paleta (`#C2410C` / `#FF5A1F`); y los días futuros, con el número atenuado.
- RF-27: MIENTRAS se muestra el mes de hoy, EL SISTEMA muestra la flecha "Mes siguiente" deshabilitada.
- RF-28: EL SISTEMA muestra las sesiones del día seleccionado con la misma cabecera y tarjeta que el historial (RF-25).
- RF-28b: EL SISTEMA mantiene el comportamiento de la spec 003: la pista "Toca un día marcado para ver sus sesiones." solo aparece sin día seleccionado (RF-9), y sin sesiones el aviso va encima de la cuadrícula, con hoy seleccionado y su mensaje debajo (RF-13). Del diseño de referencia solo se toma el aspecto.

### Récords
- RF-29: EL SISTEMA muestra cada récord en una tarjeta con su icono (cronómetro, ruta, velocímetro y corazón) en una caja ámbar, el nombre, el valor en 28 px con su unidad, la fecha y un chevron.
- RF-30: SI un récord no tiene datos, ENTONCES EL SISTEMA muestra su tarjeta con el icono, el nombre y "Sin datos", sin valor, sin fecha y sin chevron.
- RF-31: EL SISTEMA no usa el acento de la racha en la pantalla de récords.

## Requisitos no funcionales
- RNF-1: Todo texto cumple el contraste mínimo con su fondo en los dos modos (4,5:1 el texto normal; 3:1 el grande y los iconos).
- RNF-2: Los colores de la paleta se definen en un único sitio, para poder cambiarlos sin tocar cada pantalla.
- RNF-3: La app funciona sin conexión: las fuentes se incluyen en la app.
- RNF-4: Los botones y zonas táctiles miden al menos 44 × 44 px.

## Navegación
No añade pantallas ni cambia la navegación: afecta al aspecto de las pantallas existentes (inicio, registro y edición, historial, calendario y récords). El comportamiento de cada pantalla sigue siendo el de su spec (001 a 004).

## Casos límite
- El blanco sobre el naranja (3,1:1) no cumple RNF-1: por eso el texto del botón principal es casi negro (5,5:1).
- El naranja `#FF5A1F` sobre el fondo crema (3,0:1) no vale para texto: en modo claro el texto en color principal usa `#C2410C` (4,9:1).
- Acento de la racha: 4,2:1 sobre la tarjeta blanca y 3,5:1 sobre la tarjeta oscura. Solo cumple con texto grande o iconos (RF-4).
- Racha de 4 cifras ("1.000"): debe caber en la tarjeta y en los contadores (RF-14).
- Estado "Reiniciada": la racha actual se muestra como 0; "Bienvenida": los tres contadores a 0.
- Calendario: el círculo naranja frente al fondo crema da 3,1:1 (justo para un elemento gráfico) y el número `#1F1A17` sobre el círculo, 5,5:1. Se descartó el rojo de la racha (variante B del diseño) para que siga siendo exclusivo de la racha (RF-4).
- Días futuros: número al 45 % de opacidad; al no poder tocarse se consideran deshabilitados (exentos de contraste WCAG).
- Los textos y diálogos propios del sistema (selector de tiempo, diálogos de confirmación, avisos) también siguen la paleta.

## Fuera de alcance
- Elegir el modo claro u oscuro dentro de la app (se sigue el del móvil).
- Cambiar funcionalidades o navegación.
- Cambiar los textos de los mensajes: el subtexto "¡Aún te quedan 14 h para avivar la llama!" del mensaje "Riesgo" del diseño de referencia no se incluye (decisión del autor, 2026-10-17).
- El botón "Reintentar" de la pantalla de error del diseño de referencia: por ahora el error solo muestra el mensaje y su icono (decisión del autor, 2026-10-17).
- Los únicos textos nuevos son los de RF-9, RF-10 y RF-10b ("Explorar", "día(s) seguido(s)", "día(s)").
- Los datos y errores de ejemplo del formulario en el diseño de referencia no son normativos: los mensajes de error son los de la spec 001.
- La variante B del calendario (días entrenados en rojo) del diseño de referencia.

## Criterios de finalización
- Todas las pantallas usan la paleta "Fuego" en los dos modos.
- Cada pantalla coincide con el diseño de referencia en los dos modos y en sus estados (datos, vacío, error, carga, avisos y diálogos), salvo donde esta spec o las specs 001 a 004 dicen otra cosa.
- La racha se ve con el acento de la racha y ningún otro elemento lo usa.
- Ningún texto incumple el contraste de RNF-1 (comprobado en el inicio, el registro, el historial, el calendario y los récords, en los dos modos).

## Dudas abiertas
- Ninguna (resueltas por el autor el 2026-10-17).
