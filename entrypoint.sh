#!/usr/bin/env bash

eval `ssh-agent`
echo "${SSH_PRIVATE_KEY}" | ssh-add -
ansible-playbook ./deploy/deploy.yaml -i ./deploy/inventory.yaml --extra-vars "@deploy/extra_vars.yaml"
