ARCH_TYPE = $(shell uname -m)

IMAGE_NAME = kirillsilianov/deploy-image:latest-$(ARCH_TYPE)

pull:
	docker pull $(IMAGE_NAME)

lint: pull
	docker run -it \
	-v $(PWD)/configuration:/var/configuration/deploy \
	-v $(PWD)/ansible-lint.yaml:/config/ansible-lint.yaml \
	$(IMAGE_NAME) ansible-lint -c /config/ansible-lint.yaml

run: lint
	docker run -it -v $(PWD)/configuration:/var/configuration/deploy \
	-v $(PWD)/entrypoint.sh:/var/entrypoint.sh \
	-v $(PWD)/ansible.cfg:/etc/ansible/ansible.cfg \
	$(IMAGE_NAME) /bin/sh /var/entrypoint.sh
