ARCH_TYPE = $(shell uname -m)

IMAGE_NAME = kirillsilianov/deploy-image:$(ARCH_TYPE)-latest

pull:
	docker pull $(IMAGE_NAME)

lint: pull
	docker run -it \
	-v $(PWD)/configuration:/workdir \
	-v $(PWD)/ansible-lint.yaml:/ansible-lint.yaml \
	$(IMAGE_NAME) ansible-lint -c /ansible-lint.yaml

run: lint
	docker run -it -v $(PWD)/configuration:/workdir \
	-v $(PWD)/entrypoint.sh:/entrypoint.sh \
	-v $(PWD)/ansible.cfg:/etc/ansible/ansible.cfg \
	$(IMAGE_NAME) /bin/sh /entrypoint.sh
