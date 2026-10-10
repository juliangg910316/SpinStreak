# Especificación funcional — SpinStreak

*Versión inicial: 2026-10-10*

> Visión global del producto. Los requisitos de cada funcionalidad (RF en EARS, navegación, casos límite y criterios de finalización) viven en las specs numeradas de `specs/` (ver la sección 7). Aquí solo están los **requisitos comunes**, que aplican a todas (sección 6). Los principios innegociables están en `docs/constitution.md`, y la arquitectura en `AGENTS.md`.

## 1. Descripción

Aplicación Flutter para Android que guarda los entrenamientos diarios en bicicleta estática y sigue la constancia. Al terminar cada sesión, los datos se copian a mano desde la pantalla de la bici. La app convierte esos datos en rachas, estadísticas y récords para tener ganas de volver a entrenar al día siguiente.

### Problema
Los datos de la pantalla de la bici se pierden al apagarla. Las apps generalistas (Strava, Fitbit, Google Fit) permiten registros manuales, pero no tienen campos propios de la bici estática (odómetro, velocidad máxima) ni rachas pensadas para el hábito diario.

### Objetivos (v1)
- Registrar una sesión en menos de 30 segundos.
- Ver la racha actual y la mejor racha en la pantalla principal.
- Entender cada parámetro de la bici desde la propia app.
- Servir como pieza de portafolio: código limpio y arquitectura clara (sin tests por ahora).

## 2. Decisiones

| Tema | Decisión |
| --- | --- |
| Plataforma | Solo Android |
| Uso | Personal (no se publica por ahora) |
| Datos | Solo locales, sin nube ni sincronización |
| Racha | Estrictamente diaria, sin comodines ni días de descanso |
| Varias sesiones el mismo día | Se guardan todas, pero cuentan como un solo día para la racha |
| Entrada de datos | Manual (sin Bluetooth por ahora) |
| Datos anteriores | No hay entrenamientos previos que importar |
| Días pasados | No se permite registrar sesiones de días anteriores |
| Campos opcionales | Pulso máximo y velocidad máxima |
| Recordatorios | En la v2 |
| Navegación | Cada spec define la suya |

### Riesgos aceptados
- **Sesión sin registrar o borrada por error:** al no permitirse días pasados, si una sesión no se registra antes de medianoche, o se borra la única sesión de un día, la racha se pierde sin remedio. El autor acepta el riesgo y no se añaden protecciones extra.
- **Pérdida de datos:** al ser solo locales y sin copia de seguridad (la exportación es de la v2), desinstalar la app o cambiar de móvil borra el historial. El autor acepta el riesgo.

## 3. Modelo de datos

| Campo | Tipo | Unidad | Notas |
| --- | --- | --- | --- |
| `fecha` | DateTime | — | La asigna la app (ahora). El **día** es la clave para la racha |
| `tiempo` | Duration | hh:mm:ss | Obligatorio |
| `distancia` | double | km | Obligatorio |
| `calorias` | int | kcal | Obligatorio. Estimación de la bici |
| `odometro` | double | km | Obligatorio. Total acumulado de la bici |
| `velocidadMax` | double? | km/h | Opcional |
| `pulsoMax` | int? | ppm | Opcional |
| `nota` | String? | — | Opcional |

**Datos derivados (v1):** velocidad media = distancia / tiempo. Se calculan, no se almacenan.

## 4. Reglas de la racha

Resumen: un día cuenta si tiene al menos una sesión; la racha actual son los días consecutivos que terminan hoy o ayer; es estrictamente diaria y usa la fecha local del dispositivo. No se entrena de noche, así que no hay sesiones que crucen la medianoche.

Definiciones y requisitos completos: [`specs/002-rachas/spec.md`](../specs/002-rachas/spec.md).

## 5. Glosario de parámetros (texto de la ayuda ⓘ)

| Parámetro | Qué significa | Para qué sirve |
| --- | --- | --- |
| **Tiempo** | Duración total de la sesión, desde que empiezas a pedalear hasta que paras. | Medir el volumen de entrenamiento; es la base de la constancia. |
| **Velocidad máxima** | La velocidad más alta que alcanzaste durante la sesión, en km/h. En una bici estática se calcula a partir de las pedaladas por minuto (cadencia), no de un desplazamiento real. | Indica tus picos de esfuerzo o *sprints*. |
| **Distancia** | Kilómetros "virtuales" recorridos en la sesión, calculados por la bici a partir de las vueltas de los pedales. | Comparar sesiones y acumular km para retos y metas. |
| **Calorías** | Energía gastada aproximada, en kcal. Es una estimación de la bici (suele basarse en tiempo, velocidad y resistencia, no en tu peso real). | Ver tendencias, no como cifra exacta. |
| **Odómetro** | Total de kilómetros acumulados por la bici desde que se usa (no se reinicia entre sesiones). | Llevar el total histórico y comprobar que la distancia registrada cuadra. |
| **Pulso máximo** | Las pulsaciones por minuto (ppm) más altas registradas durante la sesión, medidas con los sensores del manillar o una banda. | Medir la intensidad. Referencia orientativa de pulso máximo teórico: 220 − edad. |

## 6. Requisitos comunes (aplican a todas las specs)

- RC-1: SI falla una operación de guardado, edición o borrado, ENTONCES EL SISTEMA muestra un mensaje de error comprensible y conserva los datos que el usuario había introducido.
- RC-2: SI una pantalla no tiene datos que mostrar (p. ej. el primer uso), ENTONCES EL SISTEMA muestra un mensaje que explica qué hacer para empezar, en lugar de una pantalla vacía.
- RC-3: EL SISTEMA muestra todos los textos en español, y los números y fechas con formato español (coma decimal).

## 7. Alcance

### MVP (v1): specs

Orden de implementación: 001 → 002 → 003 y 004.

| Spec | Contenido |
| --- | --- |
| [001 — Registro de sesiones](../specs/001-registro-sesiones/spec.md) | Alta, edición y borrado de sesiones, validación, ayuda ⓘ e historial agrupado por día |
| [002 — Rachas](../specs/002-rachas/spec.md) | Racha actual, mejor racha, total de días y pantalla de inicio |
| [003 — Calendario](../specs/003-calendario/spec.md) | Calendario o heatmap de días entrenados |
| [004 — Récords](../specs/004-records/spec.md) | Récords personales por sesión |

### v2
- Ver la evolución de las métricas: totales y gráficas por semana y mes.
- Diferencia de odómetro entre sesiones, para comprobar la distancia registrada.
- Recordatorio diario cuando la racha está en riesgo.
- Metas de distancia ("100 km/mes").
- Exportar e importar CSV o JSON como copia de seguridad.
- Hitos con insignias: 7, 30, 100 y 365 días, y cada 1.000 km.
- "Viaje virtual": convertir los km acumulados en una ruta real.
- Futuro: OCR de la pantalla de la bici, o lectura por Bluetooth (FTMS).
