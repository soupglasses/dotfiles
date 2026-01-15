# Ansible

## Requirements

```bash
sudo zypper install ansible python3-psutil
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

```bash
ansible-playbook site.yaml
```

## Run single locally

```bash
ansible-playbook site.yaml --tags "fonts"
```
