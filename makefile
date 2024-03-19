ifdef TAGS
	VAR_TAGS := --tags $(TAGS)
endif

IMAGE_NAME = kirillsilianov/deploy-image:latest
CONTAINER_NAME = deploy-container

.pre:
	chmod 0600 $(PWD)/configuration/private_key.pem || true

lint:
	docker run -it --rm \
	-v $(PWD)/configuration:/workdir \
	-v $(PWD)/ansible-lint.yaml:/ansible-lint.yaml \
	--name $(CONTAINER_NAME) \
	$(IMAGE_NAME) ansible-lint -c /ansible-lint.yaml

run: .pre
	docker run -it --rm \
	-v $(PWD)/configuration:/workdir \
	-v $(PWD)/ansible.cfg:/etc/ansible/ansible.cfg \
	--name $(CONTAINER_NAME) \
	$(IMAGE_NAME) ansible-playbook /workdir/deploy.yaml -i /workdir/inventory.yaml --extra-vars "@/workdir/extra_vars.yaml" $(VAR_TAGS)
