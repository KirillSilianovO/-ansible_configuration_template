ARCH_TYPE = $(shell uname -m)

ifeq ($(ARCH_TYPE),x86_64)
	ARCH_TYPE = amd64
endif

IMAGE_NAME = kirillsilianov/deploy-image:$(ARCH_TYPE)-latest
CONTAINER_NAME = deploy-container

pull:
	docker pull $(IMAGE_NAME)

lint: pull
	docker run -it \
	-v $(PWD)/configuration:/workdir \
	-v $(PWD)/ansible-lint.yaml:/ansible-lint.yaml \
	--name $(CONTAINER_NAME) \
	$(IMAGE_NAME) ansible-lint -c /ansible-lint.yaml
	docker container rm $(CONTAINER_NAME) || true

run: lint
	docker run -it \
	-v $(PWD)/configuration:/workdir \
	-v $(PWD)/ansible.cfg:/etc/ansible/ansible.cfg \
	--name $(CONTAINER_NAME) \
	$(IMAGE_NAME) ansible-playbook /workdir/deploy.yaml -i /workdir/inventory.yaml --extra-vars "@/workdir/extra_vars.yaml"
	docker container rm $(CONTAINER_NAME) || true
