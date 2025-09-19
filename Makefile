build:
	docker build -t docker-cli .

run-exec:
	docker run --rm -it docker-cli /bin/bash

run-exec-privileged:
	docker run --rm -it --privileged docker-cli /bin/bash
