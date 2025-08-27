# Ansible

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
ansible-playbook site.yaml --ask-become-pass
```
