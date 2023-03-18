#!/usr/bin/env bash

chmod 600 /var/configuration/deploy/private_key.pem
ansible-playbook /var/configuration/deploy/deploy.yaml -i /var/configuration/deploy/inventory.yaml --extra-vars "@/var/configuration/deploy/extra_vars.yaml"
