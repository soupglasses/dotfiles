# Dotfiles

Public dotfiles. Ansible under `ansible/` drives setup; run `site.yaml` on any
machine and each role skips platforms it doesn't support (see `role_platforms`).
Prefer files deployed with Stow over Ansible-managed content blocks whenever a
file can be owned wholesale; use managed blocks only for files that must retain
unmanaged or machine-generated content.

On a work machine the private overlay at `ansible/roles/work` is checked out. If
`ansible/roles/work/CLAUDE.md` exists, read and follow it too.
