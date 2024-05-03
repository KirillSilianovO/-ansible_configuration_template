ansible-galaxy install -r requirements.yaml --force
ansible-playbook /workdir/deploy.yaml -i /workdir/inventory.yaml $TAGS
