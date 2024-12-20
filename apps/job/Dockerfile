FROM golang:1.23-alpine

# 必要なツールをインストール
RUN apk add --no-cache git

# 作業ディレクトリを作成
WORKDIR /app

# 依存関係をインストール
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピー
COPY . .

# バッチアプリケーションをビルド
RUN go build -o job ./src/main.go

# コンテナのエントリポイント
CMD ["./job"]