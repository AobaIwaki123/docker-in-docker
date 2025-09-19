build:
	docker build -t docker-cli .

run-exec:
	docker run --rm -it --privileged docker-cli /bin/bash

test: build
	@echo "=== Docker-in-Docker テスト開始 ==="
	@echo "1. イメージのビルド完了"
	@echo "2. Docker-in-Docker環境でhello-worldテスト実行中..."
	@docker run --rm --privileged docker-cli /bin/bash -c " \
		echo 'Dockerデーモンを起動中...' && \
		dockerd > /tmp/dockerd.log 2>&1 & \
		echo 'Dockerデーモンの起動を待機中...' && \
		timeout=30; \
		while [ \$$timeout -gt 0 ]; do \
			if docker info > /dev/null 2>&1; then \
				echo 'Dockerデーモンが起動しました'; \
				break; \
			fi; \
			sleep 1; \
			timeout=\$$((timeout-1)); \
		done; \
		if [ \$$timeout -eq 0 ]; then \
			echo 'エラー: Dockerデーモンの起動がタイムアウトしました'; \
			exit 1; \
		fi; \
		echo 'hello-worldコンテナを実行中...'; \
		if docker run --rm hello-world; then \
			echo '✅ テスト成功: hello-worldが正常に実行されました'; \
		else \
			echo '❌ テスト失敗: hello-worldの実行に失敗しました'; \
			exit 1; \
		fi; \
	"
	@echo "=== Docker-in-Docker テスト完了 ==="

