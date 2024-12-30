# フォルダ構成
```
├── api            # 実質エントリーポイント。 struct関数にしたいのでcontrollerも入ってる。
├── config
├── db
│ ├── fixture
│ ├── migration
│ └── query
├── lib
├── services
├── sqlc
├── token
└── util
```

# 技術スタック

- Framework: Gin
- Database: sqlite
- SQL Builder: sqlc

とりあえずローカルでは'air'でホットリロードできるようにしています。

# sqlliteセットアップ
```
sqlite3 db.sqlite
sqlite> .databases
```

# sqlcについて
## 感想
- 生クエリで開発できるので、楽
  - というかSQL知ってるのにORMの記法をわざわざ覚えるのが、手間
- 必然的にテストもクエリ毎に書けるので、分かりやすい
- 柔軟性は無いけどエンドポイントの設計をちゃんとすれば問題ない、かも
  - バックエンド開発において柔軟性ってそもそもそんなに必要ない
 
## sqlcの俺ルール
- queryフォルダはentity毎にフォルダは切る
- crud毎にファイル切る
- joinするクエリは何をキーにしているか次第で
- ファイル名は[entity]_[crud].sqlにする
  - 理由は、`sqlc generate`すると同階層にファイル名でまとめられて生成されてしまうので、ファイル名で管理しやすくするため
- UTモジュールの配置場所の関係でgenerateされたフォルダにトランザクションモジュールを置くのがキモい
  - 外フォルダから参照は出来るけど、毎回struct関数になるのも面倒な気がする。別に良いのかは知らん。
