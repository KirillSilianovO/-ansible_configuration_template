lint:
	docker run -it -v $(PWD)/configuration:/workdir -v $(PWD)/ansible-lint.yaml:/config/ansible-lint.yaml kirillsilianov/ansible-linter:0.0.8 ansible-lint -c /config/ansible-lint.yaml

run: lint
	docker run -it -v $(PWD)/configuration:/var/configuration/deploy \
	-v $(PWD)/entrypoint.sh:/var/entrypoint.sh \
	-v $(PWD)/ansible.cfg:/etc/ansible/ansible.cfg \
	kirillsilianov/deploy-image:latest /bin/bash /var/entrypoint.sh
