# terraform_oke_Ampere_A1
- OCIのFree TireでOKEクラスターを作成するためのterraformコード
- 作業の大枠や事前準備は[こちら]()を参照

## 前提
- OCIでアカウントを開設していること
- HOME REGIONをMontrealに設定していること
- terraformがクライアントにインストールされていること
- ociコマンドがクライアントにインストールされており、初期設定が完了していること

## 構成図

## 使い方
- cloneしてフォルダに移動
```
# git cloneする
git clone https://github.com/yamamuratkr/terraform_oke_Ampere_A1.git

# フォルダ移動
cd terraform_oke_Ampere_A1
```
- アカウント開設時に生成した`api_key.pem`を`keys`フォルダに格納
- `terraform.tfvars`を編集
  - User OCID
  - api_key.pem を生成したときにメモしたfingerprint
  - tenancy OCID
  - compartment OCID
- terraform実行
```
# terraform初期化
terraform init

# terraformをdry run
terraform plan
→追加されるリソースに齟齬がないか確認する

# 実際に構築
terraform apply (-auto-approveをつけるとyesの入力が不要になる)
→エラーが発生しなかったら構築成功
```
