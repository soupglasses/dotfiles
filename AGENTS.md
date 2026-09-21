# Repository guidance

- This is a public repository; keep secrets and machine-specific configuration out.
- Run from the root: `mise install` bootstraps, `mise run check` verifies, and
  `mise run apply [tags...]` applies the configuration.
- Keep roles portable via `role_platforms`; unsupported hosts must skip cleanly.
- Prefer Stow for files owned wholesale; use managed blocks only for shared files.
- Follow `roles/work/AGENTS.md` or its legacy `CLAUDE.md` when that overlay exists.
