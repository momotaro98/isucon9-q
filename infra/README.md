
# var file 変数

## ファイルの優先順位

1. `terraform.tfvars.json` => .gitignoreしている。 利用者がファイルをローカル上で作成する必要がある。
2. `variables.tf`          => デフォルト値を指定している。

`terraform.tfvars.json` の例

```
{
  "access_cidr_blocks": "256.256.256.256/32"
}
```

## 各変数の説明

* `standalone_ami_owner`  => AMIの所有者。standalone_ami_nameと組み合わせる。
* `standalone_ami_name`   => AMI所有者が持つAMI名。先頭文字として検索し重複するAMIがある場合は最新が利用される。 `terraform.tfvars.json` で指定しておく必要あり。
* `access_cidr_blocks`    => EC2に指定するセキュリティグループのInboundで許可するIPアドレス。
* `ec2_members`           => 立ち上げるEC2を指定。現状はすべてのEC2は上記の同じAMIがあてられる。

# Run terraform

```
terraform plan
```

```
terraform apply
```

```
terraform destroy
```

```
terraform fmt
terraform validate
```