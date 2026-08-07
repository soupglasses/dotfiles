# Dotfiles

Public dotfiles. Ansible under `ansible/` drives setup; run `site.yaml` on any
machine and each role skips platforms it doesn't support (see `role_platforms`).

On a work machine the private overlay at `ansible/roles/work` is checked out. If
`ansible/roles/work/CLAUDE.md` exists, read and follow it too.
