# Ansible

## Bootstrap

Install [Mise](https://mise.jdx.dev/), then run these commands from the
repository root:

```bash
mise install
mise run setup
```

Mise supplies Ansible and the repository's check tools. Ansible installs
machine-level packages such as Stow through the native package manager; no
separate Python or `python3-psutil` package is required.

## Checks

[hk](https://hk.jdx.dev/) installs the shared pre-commit hook during
`mise install`. Run the same full check used by GitHub Actions with:

```bash
mise run check
```

## Check facts for local machine

```bash
ansible all -c local -i localhost, -m setup -a "filter=*os_family*"
```

## Update dependencies

```bash
ansible-galaxy collection install -r requirements.yml
```

## Run all locally

`site.yaml` runs on every machine. Each role declares its `role_platforms` and
skips itself where unsupported, so the same list works on Linux and macOS.

```bash
ansible-playbook site.yaml
```

To replace existing files or symlinks that conflict with any stow package for
one run, enable the play-wide stow override:

```bash
ansible-playbook site.yaml --extra-vars stow_force=true
```

Directories are never removed by this override.

## Run a single role locally

Use Mise to run a role by its Ansible tag:

```bash
mise run role fonts
mise run role git
```

The direct Ansible equivalent is:

```bash
ansible-playbook site.yaml --tags "fonts"
```
