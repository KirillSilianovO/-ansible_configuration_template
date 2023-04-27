#!/usr/bin/env bash

chmod 600 /workdir/private_key.pem
ansible-playbook /workdir/deploy.yaml -i /workdir/inventory.yaml --extra-vars "@/workdir/extra_vars.yaml"
