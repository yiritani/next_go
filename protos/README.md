# protoファイルをまとめたリポ


## 想定
- マイクロサービスで複数のサービスが存在する大規模プロジェクト
- それぞれのサービス間でgRPC通信を行う(gRPCだけかどうかは置いといて)

## フォルダ構成
- `protos`の中にサービスごとのprotoフォルダを作成する
- その中の構成はできればバージョンで区切る

## SDK生成
このリポジトリではprotoファイルからGolang用のSDKを生成します。

### 必要な環境
- Go 1.20以上
- Protocol Buffers compiler (protoc)
- Go plugins for protoc:
  ```bash
  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
  ```

### ディレクトリ構成
