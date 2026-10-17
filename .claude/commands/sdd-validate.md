---
description: SDD · Valida la spec RF por RF (revisión de código + recorrido en Android o iOS)
argument-hint: <NNN-nombre>
disable-model-invocation: true
---

Recorre specs/$0/spec.md requisito por requisito. Usa la skill sdd.
Para cada RF indica qué código lo cumple y cómo se verifica:
- Lógica pura (lib/domain/): revisa el código contra el RF y sus casos límite.
- Interfaz: dame los pasos exactos de un recorrido manual en un emulador, simulador o
  dispositivo Android o iOS (`flutter run`) y el resultado esperado, para que yo lo ejecute y lo confirme.

Ejecuta también `flutter analyze`.
Si algún RF no está cubierto o falla, dilo claramente. NO arregles nada todavía.
Después comprueba los criterios de finalización y dame un veredicto:
¿la spec está cumplida? Si lo está y lo confirmo, cambia su estado a "implementada" y actualiza MEMORY.md.
