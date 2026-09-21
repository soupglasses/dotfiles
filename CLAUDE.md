# Dotfiles

Public dotfiles. Ansible drives setup from the repository root; run `site.yaml`
on any machine and each role skips platforms it doesn't support (see
`role_platforms`).
Prefer files deployed with Stow over Ansible-managed content blocks whenever a
file can be owned wholesale; use managed blocks only for files that must retain
unmanaged or machine-generated content.

On a work machine the private overlay at `roles/work` is checked out. If
`roles/work/CLAUDE.md` exists, read and follow it too.
