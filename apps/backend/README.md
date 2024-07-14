# 技術スタック

- Framework: Gin
- Database: Postgres
- SQL Builder: sqlc

とりあえずローカルでは'air'でホットリロードできるようにしています。


## sqlcの俺ルール
- queryフォルダはentity毎にフォルダは切る
- crud毎にファイル切る
- joinするクエリは何をキーにしているか次第で
- ファイル名は[entity]_[crud].sqlにする
  - 理由は、`sqlc generate`すると同階層に生成されてしまうので、ファイル名で管理しやすくするため
