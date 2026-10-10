---
description: Idioma del proyecto y formato de commits y PRs.
alwaysApply: true
---

# Commits e idioma

## Objetivo

- Historial legible y homogéneo en español (es-ES).
- Mismo idioma en respuestas, comentarios de código, textos de UI y documentación.

## Patrones

- **Idioma**: español para commits, PRs, comentarios, documentación y textos visibles. Identificadores de código en el idioma ya usado (dominio en español: `distancia`, `racha`; términos técnicos en inglés: `repository`, `cubit`).
- **Commits semánticos** (Conventional Commits): `<tipo>(<ámbito opcional>): <resumen>`.
  - Tipos: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `style`, `build`.
  - Título en imperativo, minúsculas, sin punto final, ≤ 72 caracteres.
  - Cuerpo: qué cambia y por qué; referencia a issues (`Refs #12`, `Closes #12`) si existen.
- **PRs**: título con el mismo formato que el commit principal; descripción con "Qué", "Por qué" y "Cómo probarlo"; labels según el tipo (`feature`, `bug`, `docs`).
- Un commit por cambio lógico; el código generado (`*.g.dart`) va en el mismo commit que su origen.

## Ejemplos cortos

- `feat(session): registrar sesión con la fecha del día actual`
- `fix(streak): no cortar la racha por el cambio de hora`
- `docs: documentar la arquitectura en CLAUDE.md`
- `chore(deps): añadir drift y drift_flutter`

## Checklist

- [ ] Título semántico en español e imperativo.
- [ ] Cuerpo explica el porqué si no es obvio.
- [ ] `dart format .` y `flutter analyze` ejecutados antes del commit.
