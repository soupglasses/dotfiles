# Repository guidance

- This repository is public. Keep secrets, generated state, and work-only settings
  out; `roles/work` is the optional private submodule. Follow its own guidance.
- `site.yaml` is the sole playbook. Register roles there with a matching tag.
- Keep the role contract: platforms in `defaults/main.yaml`, a gated `main.yaml`,
  orchestration in `setup.yaml`, and OS package work in the matching OS task file.
- Use explicit `ansible_facts[...]`. Keep tasks idempotent; probes must not report
  changes, secrets need `no_log`, and service changes should use handlers.
- `_meta` supplies shared prerequisites. Depend on `shell` for shell integration:
  Linux uses Bash and macOS uses Zsh. Preserve the numbered Zsh loading stages.
- Put owned dotfiles under `files/<package>/<home-relative-path>` and deploy with
  Stow. Use `folding: false` for shared or runtime-written directories; merge or
  manage blocks in files that also contain machine/user state. Keep force opt-in.
- Run `mise run check`. Use `mise run apply <tags...>` only for requested host-level
  verification: it changes the machine and may prompt for sudo or credentials.
