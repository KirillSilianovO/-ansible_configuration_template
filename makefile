pull:
	docker pull kirillsilianov/deploy-image:latest
	docker pull kirillsilianov/ansible-linter:latest

lint: pull
	docker run -it \
	-v $(PWD)/configuration:/workdir \
	-v $(PWD)/ansible-lint.yaml:/config/ansible-lint.yaml \
	kirillsilianov/ansible-linter:latest \
	ansible-lint -c /config/ansible-lint.yaml

run: lint
	docker run -it -v $(PWD)/configuration:/var/configuration/deploy \
	-v $(PWD)/entrypoint.sh:/var/entrypoint.sh \
	-v $(PWD)/ansible.cfg:/etc/ansible/ansible.cfg \
	kirillsilianov/deploy-image:latest /bin/bash /var/entrypoint.sh
