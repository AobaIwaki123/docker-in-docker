# Docker-in-Docker (DinD) 環境

このリポジトリは、Docker-in-Docker環境を構築し、コンテナ内でDockerコマンドを実行できる環境を提供します。

## 概要

Docker-in-Docker（DinD）は、Dockerコンテナの中でDockerデーモンを実行し、さらにDockerコンテナを起動できる技術です。この環境は以下のような用途に使用できます：

- CI/CDパイプラインでのDockerイメージのビルドとテスト
- Dockerコマンドの学習・実験環境
- 隔離されたDocker環境での開発・テスト

## 前提条件

- Docker Engine がインストールされていること
- `make` コマンドが利用可能であること
- 十分な権限（privilegedモードでのコンテナ実行が可能）

## Quick Start

以下のコマンドが正常に実行されれば、Docker-in-Docker環境が正常に動作しています。

```bash
$ make test
```

## 利用可能なコマンド

### `make build`

Docker-in-Docker環境のDockerイメージをビルドします。

```bash
make build
```

**説明**: Ubuntu 22.04ベースでDockerエンジンがインストールされたイメージを作成します。

### `make run-exec`

Docker-in-Docker環境を起動し、対話式シェルに入ります。

```bash
make run-exec
```

**説明**: privilegedモードでコンテナを起動し、bash シェルに入ります。このシェル内でDockerコマンドを実行できます。

### `make test`

ビルドから動作確認までの一気通貫テストを実行します。

```bash
make test
```

**説明**: 
1. Docker-in-Docker環境のイメージをビルド
2. コンテナ内でDockerデーモンを起動
3. `hello-world` コンテナを実行して動作確認
4. 結果を表示

## 使用方法

### 対話式環境での作業例

`make run-exec` でシェルに入った後：

```bash
# Dockerデーモンの起動
dockerd &

# Dockerの動作確認
docker info

# hello-worldコンテナの実行
docker run hello-world

# Ubuntuコンテナの実行
docker run -it ubuntu bash
```

## テスト結果の例

`make test` の実行例：

```
=== Docker-in-Docker テスト開始 ===
1. イメージのビルド完了
2. Docker-in-Docker環境でhello-worldテスト実行中...
Dockerデーモンを起動中...
Dockerデーモンの起動を待機中...
Dockerデーモンが起動しました
hello-worldコンテナを実行中...

Hello from Docker!
This message shows that your installation appears to be working correctly.
...

✅ テスト成功: hello-worldが正常に実行されました
=== Docker-in-Docker テスト完了 ===
```

## 注意事項

- **Privileged モード**: Docker-in-Docker環境の実行には `--privileged` フラグが必要です
- **セキュリティ**: privilegedモードはセキュリティリスクがあるため、本番環境では注意して使用してください
- **リソース**: Docker-in-Docker環境は通常のコンテナより多くのリソースを消費します
- **ネストの制限**: Docker-in-Docker内でさらにDocker-in-Dockerを実行することは推奨されません

## トラブルシューティング

### Dockerデーモンが起動しない場合

```bash
# ログの確認
cat /tmp/dockerd.log

# 手動でのDockerデーモン起動
dockerd --debug
```

### 権限エラーが発生する場合

- コンテナが `--privileged` モードで実行されているか確認
- Dockerホストで十分な権限があるか確認
