# isucon9 provisioning

> ansible 2.8.3のみで動作確認しています。

# Overview

__PackerがAnsibleをProvisionerとして使ってAMIを作成する__

# How to build AMI. 

```
packer build .
```

## Packerが使っているファイル

- *.pkr.hcl なファイル

# Ansible playbooks

## 現状使っているもの

- standalone.yml
  - アプリ、ベンチマーク、外部サービスが一緒になっている

## もともとあったもの

- webapp.yml
  - 競技用
- bench.yml
  - ベンチマーカー用
- dev.yml
  - 競技者向け開発用の外部サービス
