# Ansible

## Requirements

```bash
sudo zypper install ansible python3-psutil   # openSUSE
sudo dnf install ansible python3-psutil      # Fedora
sudo pacman -S ansible python-psutil         # Arch
brew install ansible                         # macOS
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

## Run single locally

```bash
ansible-playbook site.yaml --tags "fonts"
```
