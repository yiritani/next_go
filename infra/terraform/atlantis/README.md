# atlantis
ドメイン料がかかるのでローカルでatlantis serverを立てる

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
ngrok http --url=quick-allegedly-boxer.ngrok-free.app 4141
```
```
sh run_atlantis.sh
```

ngrokのURLをコピーしてgithubのwebhookに設定する<br>