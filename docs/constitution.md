# Constitución -- SpinStreak
Principios innegociables. Si una spec, un plan o una tarea los contradice, gana la constitución. Cambiarla requiere la aprobación del autor.

1. **Stack mínimo.** Flutter + flutter_bloc + get_it + drift + intl + freezed (modelos y estados inmutables). Nada de dependencias nuevas, backend ni HTTP sin aprobación del autor.
2. **La spec manda.** No se implementa comportamiento nuevo sin una spec aprobada (las correcciones y refactors que no cambian el comportamiento no la necesitan). Todo cambio de comportamiento va primero a la spec, luego al plan y al final al código. Cada RF se puede rastrear hasta el código que lo cumple.
3. **Lógica separada de la interfaz.** Las reglas de negocio (racha, récords, totales) son funciones puras en `lib/domain/`, sin imports de Flutter ni de drift, y reciben "hoy" como parámetro. Los widgets y los Cubits no calculan reglas.
4. **Los datos del usuario son sagrados.** Solo locales. Nunca se borra una sesión sin confirmación. La fecha de una sesión la asigna la app y no se modifica. Todo cambio en las tablas de drift incluye una migración que conserva los datos.
5. **Español para las personas.** La interfaz, la documentación, los comentarios y los commits van en español. Los nombres del dominio también (`distancia`, `racha`); los términos técnicos van en inglés (`repository`, `cubit`).
6. **Verificación como puerta.** No se da una tarea por terminada si `dart format .` deja cambios o si `flutter analyze` da errores o avisos.
