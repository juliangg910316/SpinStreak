# 🧩 Flutter App Architecture — Asistente de Configuración (Pregunta a Pregunta)

Sigue la **Arquitectura oficial de Flutter**:

* [https://docs.flutter.dev/app-architecture/concepts](https://docs.flutter.dev/app-architecture/concepts)
* [https://docs.flutter.dev/app-architecture/guide](https://docs.flutter.dev/app-architecture/guide)

Estructura obligatoria del proyecto:

```test
lib
├─ ui
│  ├─ core
│  │  ├─ ui/<shared widgets>
│  │  └─ themes
│  └─ <FEATURE NAME>
│     ├─ view_model/<view_model class>.dart
│     └─ widgets/<feature name>_screen.dart
├─ domain/models/<model name>.dart
├─ data
│  ├─ repositories/<repository class>.dart
│  ├─ services/<service class>.dart
│  └─ model/<api model class>.dart
├─ config
├─ utils
├─ routing
├─ main.dart

test/
testing/
```

---

## 🧠 Modo de Ejecución (instrucciones para el LLM)

> Haz **una pregunta a la vez**.
> Espera mi respuesta antes de pasar a la siguiente.
> Cuando se hayan dado todas las respuestas, muestra un **resumen final** de las elecciones y solo entonces genera el esqueleto del proyecto según las directrices anteriores.

---

### 🪜 Pasos del Asistente

#### **Paso 1 – Gestión de Estado**

> Pregunta:
> “¿Qué gestor de estado deseas usar (ej: ChangeNotifier, Provider + ChangeNotifier, Riverpod, Bloc, otro)?”
>
> Tras la respuesta:
>
> * Guarda la elección como `state_manager`.
> * Explica brevemente cómo se aplicará en la capa `ui/view_model`.
> * Avanza al paso 2.

---

#### **Paso 2 – Inyección de Dependencias**

> Pregunta:
> “¿Cómo deseas hacer la inyección de dependencias (Provider, get_it, injectable + get_it, manual por constructor, otro)?”
>
> Tras la respuesta:
>
> * Guarda la elección como `dependency_injection`.
> * Explica dónde se inicializarán las dependencias (ej: `core/di/providers.dart`).
> * Avanza al paso 3.

---

#### **Paso 3 – Cliente HTTP**

> Pregunta:
> “¿Qué biblioteca deseas usar para las peticiones HTTP (Dio, http, Retrofit + Dio, otra)?”
>
> Tras la respuesta:
>
> * Guarda la elección como `http_client`.
> * Explica dónde se configurará el cliente (ej: `core/network/dio_client.dart`).
> * Avanza al paso 4.

---

#### **Paso 4 – Enrutamiento**

> Pregunta:
> “¿Confirmas que deseas usar **rutas nombradas nativas de Flutter** (Navigator + routes/onGenerateRoute)? ¿Quieres añadir guards simples (ej: login obligatorio)?”
>
> Tras la respuesta:
>
> * Guarda la confirmación como `routing_strategy = native_named_routes`.
> * Describe brevemente la estructura esperada (`routing/route_names.dart`, `routing/app_router.dart`).
> * Avanza al paso 5.

---

#### **Paso 5 – Temas y Design System**

> Pregunta:
> “¿Quieres generar un tema inicial (claro/oscuro completo, tema base simple o ninguno)?”
>
> Tras la respuesta:
>
> * Guarda como `theme_setup`.
> * Indica dónde se configurará (`ui/core/themes`).
> * Avanza al paso 6.

---

#### **Paso 6 – Entornos y Entrypoints**

> Pregunta:
> “¿Quieres mantener múltiples entrypoints (main.dart, main_development.dart, main_staging.dart) o usar solo main.dart?”
>
> Tras la respuesta:
>
> * Guarda como `entrypoints_strategy`.
> * Explica la diferencia de uso entre entornos (logs, baseUrl, etc.).
> * Avanza al paso 7.

---

#### **Paso 7 – Estándares y Calidad**

> Pregunta:
> “¿Qué herramientas de calidad deseas incluir (analysis_options.yaml, very_good_analysis, flutter format, README base)?”
>
> Tras la respuesta:
>
> * Guarda como `quality_tools`.
> * Indica que `dart_code_metrics` y `git hooks` **no** se incluirán.
> * Avanza al paso 8.

---

#### **Paso 8 – Pruebas**

> Pregunta:
> “¿Deseas incluir ejemplos de pruebas (unitarias, de widget, golden, mocks/fakes)?”
>
> Tras la respuesta:
>
> * Guarda como `test_setup`.
> * Explica la estructura de los directorios `test/` y `testing/`.
> * Avanza al paso 9.

---

#### **Paso 9 – Extras**

> Pregunta:
> “¿Deseas incluir recursos adicionales (internacionalización, logger, manejo de errores, caché, monitoreo)?”
>
> Tras la respuesta:
>
> * Guarda como `extras`.
> * Avanza al paso final.

---

### ✅ **Paso Final – Resumen y Generación**

> Tras todas las respuestas:
>
> * Muestra el **resumen consolidado** de las elecciones:
>
>   ```test
>   State Manager: ...
>   Dependency Injection: ...
>   HTTP Client: ...
>   Routing: Native named routes
>   Theme: ...
>   Entrypoints: ...
>   Quality: ...
>   Tests: ...
>   Extras: ...
>   ```
>
> * Pide una confirmación final: “¿Puedo generar la estructura del proyecto con estas configuraciones?”
> * Tras la confirmación:
>
>   * Genera la estructura de carpetas.
>   * Crea los archivos de bootstrap (`main.dart`, `app_router.dart`, `providers.dart`, etc.).
>   * Inserta comentarios que expliquen el papel de cada capa y archivo.
>   * No añadas ninguna librería ni archivo que no haya sido confirmado.

---

### 📌 Persistir la memoria de las decisiones y la arquitectura

> Tras generar el proyecto, crea un archivo de memoria con las decisiones y los detalles arquitectónicos para uso futuro en la generación de rules.
>
> • Ruta del archivo: `@.ia/memories/flutter_architecture.memory.json`
>
> • Contenido (rellénalo con los valores recopilados a lo largo de los pasos):
>
> ```json
> {
>   "kind": "flutter_setup",
>   "version": 1,
>   "state_manager": "<state_manager>",
>   "dependency_injection": "<dependency_injection>",
>   "http_client": "<http_client>",
>   "routing_strategy": "native_named_routes",
>   "theme_setup": "<theme_setup>",
>   "entrypoints_strategy": "<entrypoints_strategy>",
>   "quality_tools": "<quality_tools>",
>   "test_setup": "<test_setup>",
>   "extras": "<extras>",
>   "architecture": {
>     "layers": ["ui", "domain", "data", "config", "utils", "routing"],
>     "ui": {
>       "view_model_pattern": "<e.g.: ChangeNotifier + Provider>",
>       "themes_path": "lib/ui/core/themes"
>     },
>     "di": {
>       "init_path": "lib/core/di/providers.dart",
>       "strategy": "<dependency_injection>"
>     },
>     "network": {
>       "client": "<http_client>",
>       "config_path": "lib/core/network/dio_client.dart"
>     },
>     "routing": {
>       "strategy": "native_named_routes",
>       "files": ["lib/routing/route_names.dart", "lib/routing/app_router.dart"]
>     },
>     "config": {
>       "app_config_path": "lib/config/app_config.dart",
>       "environments": ["main.dart", "main_development.dart", "main_staging.dart"]
>     }
>   },
>   "notes": "<add relevant decisions, trade-offs and important conventions here>",
>   "generated_at": "<ISO-8601 datetime>"
> }
> ```
>
> Nota: este archivo en `@.ia/memories` se utilizará posteriormente para generar y actualizar las rules del proyecto de forma automática.
