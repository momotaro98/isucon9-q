# isucon9-q

## ディレクトリ構成

```
├── bench        # ベンチマーカーなどが依存するパッケージのソースコード
├── cmd          # ベンチマーカーなどのソースコード
├── docs         # 運営が用意した各種ドキュメント
├── initial-data # 初期データ作成
├── provisioning # セットアップ用ansible and packer
├── infra        # AWSインフラ terraform
└── webapp       # 各言語の参考実装
```

## アプリケーションおよびベンチマーカーの起動方法

こちらのblogでも紹介しています。参考にしてください
http://isucon.net/archives/53805209.html

## [My Note] デプロイスクリプト including service restart and log rotation

### 初回 => すべてのアプリサーバ上で実施

#### Git Clone for this repo

```
ssh isucon-first-server, 2nd, 3rd server
sudo su isucon
cd $HOME
git clone https://github.com/momotaro98/isucon9-q.git
```

#### Update `/etc/hosts` for デプロイスクリプト

example like below

```
# ISUCON
10.1.0.170 isu2
10.1.0.37 isu3
```

### デプロイコマンド => 1つ目のアプリサーバ上で実施

すべてのアプリサーバにデプロイする

```
ssh isucon-first-server
/home/isucon/isucon9-q/deploy-with-remote.sh
```

## 前準備

### [My Note] 以下はprovisioningのAnsibleで`roles/initial-data`の中で実施される。

```
# 初期データ作成
$ cd initial-data
$ make

# 初期画像データダウンロード

$ cd webapp/public
# GitHub releases から initial.zip をダウンロード
$ unzip initial.zip
$ rm -rf upload
$ mv v3_initial_data upload

# ベンチマーク用画像データダウンロード

$ cd initial-data
# GitHub releases から bench1.zip をダウンロード
$ unzip bench1.zip
$ rm -rf images
$ mv v3_bench1 images

$ make
$ ./bin/benchmarker
```

## ベンチマーカー

Version: Go 1.13 or later

### [My Note] Run Bench and serve shipment and payment external APIs in isolated EC2

AWS上のアプリサーバ(3台)とは別にベンチマーク兼外部API(支払い・出荷API)を受けもつEC2を練習用に立てている。

そのEC2からベンチマークできるようにした。そのときのベンチマーカーのオプション。

```bash
APP_SERVER=http://10.1.0.12; ./bin/benchmarker \
  -target-url ${APP_SERVER} \
  -payment-url http://$(hostname -i)/bench/payment/ \
  -shipment-url http://$(hostname -i)/bench/shipment/
```

### 実行オプション

```
$ ./bin/benchmarker -help
Usage of isucon9q:
  -allowed-ips string
        allowed ips (comma separated)
  -data-dir string
        data directory (default "initial-data")
  -payment-port int
        payment service port (default 5555)
  -payment-url string
        payment url (default "http://localhost:5555")
  -shipment-port int
        shipment service port (default 7000)
  -shipment-url string
        shipment url (default "http://localhost:7000")
  -static-dir string
        static file directory (default "webapp/public/static")
  -target-host string
        target host (default "isucon9.catatsuy.org")
  -target-url string
        target url (default "http://127.0.0.1:8000")
```

  * HTTPとHTTPSに両対応
    * 証明書を検証するのでHTTPSは面倒
  * 外部サービス2つを自前で起動するので、いい感じにするならnginxを立てている必要がある
  * nginxでいい感じにするなら以下の設定が必須
    * `proxy_set_header Host $http_host;`
      * shipmentのみ必須
    * `proxy_set_header X-Forwarded-Proto "https";`
      * HTTPSでないなら不要
    * `proxy_set_header True-Client-IP $remote_addr;`
    * cf: https://github.com/isucon/isucon9-qualify/tree/master/provisioning/roles/external.nginx/files/etc/nginx


## 外部サービス

### 実行オプション

```
$ ./bin/shipment -help
Usage of shipment:
  -data-dir string
        data directory (default "initial-data")
```

`payment`はオプションなし。

### 注意点

nginxでいい感じにするなら以下の設定が必須

  * `proxy_set_header Host $http_host;`
    * shipmentのみ必須
  * `proxy_set_header X-Forwarded-Proto "https";`
    * HTTPSでないなら不要

## webapp 起動方法

```shell-session
cd webapp/sql

# databaseとuserを初期化する
mysql -u root < 00_create_database.sql

# データを流し込む
./init.sh

cd webapp/go
make
./isucari
```

## 運営側のブログ

技術情報などについても記載されているので参考にしてください。

  * ISUCON9予選の出題と外部サービス・ベンチマーカーについて - catatsuy - Medium https://medium.com/@catatsuy/isucon9-qualify-969c3abdf011
  * ISUCONのベンチマーカーとGo https://gist.github.com/catatsuy/74cd66e9ff69d7da0ff3311e9dcd81fa
  * ISUCON9予選でフロントエンド周りの実装を担当した話 - はらへり日記 https://sota1235.hatenablog.com/entry/2019/10/07/110500

## サポートするMySQLのバージョン

MySQL 5.7および8.0にて動作確認しています。

ただし、nodejsでアプケーションを起動する場合、MySQL 8.0の認証方式によっては動作しないことがあります。
詳しくは、 https://github.com/isucon/isucon9-qualify/pull/316 を参考にしてください


## 使用データの取得元

- なんちゃって個人情報 http://kazina.com/dummy/
- 椅子画像提供 941-san https://twitter.com/941/status/1157193422127505412
