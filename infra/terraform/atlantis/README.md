# atlantis
金をかけたくないのでローカルでatlantis serverを立てる

## githubの設定
1. リポジトリにwebhookを設定する<br>
   - Payload URL: ngrokのURL
   - Content type: application/json
   - Secret: 任意の文字列
   - events: push, pull_request, comment

## ローカル起動
1. install atlantis runner<br>
何かしらの方法でローカルマシンに対応したatlantis runnerをインストールする<br>
ここから
   https://github.com/runatlantis/atlantis/releases

2. install ngrok<br>
```
brew install ngrok
```

3. run atlantis server<br>
ウィンドウを2つ開いて
```
ngrok http --url=[何かしらの使えるドメイン] 4141
```
ngrokなら無料で使えるのでそれを使うと良い

```
sh run_atlantis.sh
```








