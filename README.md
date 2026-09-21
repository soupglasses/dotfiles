<p align="center">
  <a href="https://www.youtube.com/watch?v=pDSptPcImGE/#gh-light-mode-only">
    <img src="./media/dotfiles-light.png" height="100"/>
  </a>
  <a href="https://www.youtube.com/watch?v=pDSptPcImGE/#gh-dark-mode-only">
    <img src="./media/dotfiles-dark.png" height="100"/>
  </a>
</p>

# dotfiles

My personal Ansible setup for configuring Fedora, openSUSE, Arch Linux, and
macOS machines.

## Bootstrap

Install [Mise](https://mise.jdx.dev/), then run this command from the
repository root:

```bash
mise install
```

Mise supplies Ansible and the repository's check tools, installs the required
Ansible collections, and configures the shared Git hook. Ansible installs
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

## Install repository dependencies

`mise install` runs this automatically. Run it directly after changing
`requirements.yml` or when repairing an incomplete setup:

```bash
mise run setup
```

## Apply the configuration

`site.yaml` runs on every machine. Each role declares its `role_platforms` and
skips itself where unsupported, so the same list works on Linux and macOS.

```bash
mise run apply
```

To replace existing files or symlinks that conflict with any stow package for
one run, use Ansible directly with the play-wide stow override:

```bash
ansible-playbook site.yaml --extra-vars stow_force=true
```

Directories are never removed by this override.

To limit the run to one or more roles or tags, pass them to the same task:

```console
mise run apply fonts
mise run apply git shell
```

The direct Ansible equivalent is:

```bash
ansible-playbook --inventory 'localhost,' site.yaml --tags "fonts"
```
