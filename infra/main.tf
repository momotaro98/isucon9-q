provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  region = "ap-northeast-1"
  alias = "ap_northeast"
}
