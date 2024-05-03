# Ansible Configuration Template

## Description
Template for Ansible configuration files.

## Prerequisites
1. Installed "[TaskFile](https://taskfile.dev/installation/)"

## Steps
1. Copy `./example.variables.yaml` to `./.variables.yaml`
2. Set your variables in `./.variables.yaml`
3. Create `configuration/private_key.pem` file and copy your private key into it
4. Run `taskfile run` to run the playbook
