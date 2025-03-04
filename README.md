# Ansible Playbook Workstation Setup

Automated setup for Linux workstations (PopOS, Ubuntu, Mint) with development tools and system configurations using Ansible.

## Features

- Multiple Linux distributions support (PopOS 22.04, Linux Mint 22, Ubuntu 24.04)
- Essential development tools (VSCode)
- System configurations and package management
- Hashicorp tools (Terraform, Vault)
- Kubernetes tools
- API clients (Insomnia)
- Browser configurations
- Container-based execution

## Prerequisites

- Docker (recommended)
- SSH access to target machines
- Ansible (if running locally)

## Quick Start

### Using Docker (Recommended)

```bash
# Build container
docker build -t ansible-workstation .

# Run playbook with SSH authentication
docker run -it --rm --network host \
  -v "${HOME}/.ssh:/root/.ssh:ro" \
  -v "$(pwd):/workspace" \
  ansible-workstation -i inventory/hosts.yml playbooks/site.yml --ask-pass --ask-become-pass
```
#### Example for Funcional Command
```bash
docker run -it --rm --network host \
  -v "${HOME}/.ssh:/root/.ssh:ro" \
  -v "$(pwd):/workspace" \
  ansible-workstation -i inventory/hosts.yml playbooks/site.yml --ask-pass --ask-become-pass \
  -u nilson
```

### Local Installation

```bash
# Install Ansible
sudo apt update
sudo apt install -y ansible

# Clone repository
git clone https://github.com/nilsonvieira/ansible-playbook-workstation-setup.git
cd ansible-playbook-workstation-setup

# Install requirements
ansible-galaxy install -r requirements.yml

# Run playbook
ansible-playbook -i inventory/hosts.yml playbooks/site.yml --ask-pass --ask-become-pass
```

## Configuration

### Inventory Setup

Edit `inventory/hosts.yml`:
```yaml
workstations:
  hosts:
    remote:
      ansible_host: YOUR_HOST_IP
      ansible_user: YOUR_USERNAME
      ansible_connection: ssh
```

### Customization

- `group_vars/all.yml`: Common packages and configurations
- `group_vars/distros/`: Distribution-specific settings
- `playbooks/roles/`: Individual role configurations

## Project Structure

```
.
├── ansible.cfg               # Ansible configuration
├── Dockerfile                # Container definition
├── group_vars/               # Variable definitions
│   ├── all.yml               # Common variables
│   └── distros/              # OS-specific variables
├── inventory/                # Host definitions
│   └── hosts.yml
├── playbooks/                # Main playbook directory
│   ├── site.yml              # Main playbook
│   └── roles/                # Role definitions
│       ├── common/           # Common setup tasks
│       ├── system/           # System configuration
│       └── workstation/      # Workstation setup
└── requirements.yml          # Role dependencies
```

## Available Roles

- `common`: Base system packages and configurations
- `vscode`: Visual Studio Code installation and setup
- `hashicorp`: Terraform, Vault, and other Hashicorp tools
- `1password`: 1Password password manager
- `k8s`: Kubernetes tools and configurations
- `apiclient`: API testing tools (Insomnia)
- `browsers`: Web browser installations and configurations

## Troubleshooting

1. Package Lock Issues:
   - The playbook includes automatic handling of APT locks
   - Manual fix: `sudo rm /var/lib/apt/lists/lock /var/cache/apt/archives/lock`

2. GPG Key Conflicts:
   - Automatic cleanup of conflicting keys is included
   - Manual fix: Remove conflicting keys in `/etc/apt/keyrings/`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT