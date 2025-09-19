build:
	docker build -t docker-cli .

run-exec:
	docker run --rm -it docker-cli /bin/bash
