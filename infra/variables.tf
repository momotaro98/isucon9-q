variable "standalone_ami_id" {
  type = string
  # default = "ami-02f8f5388a3fb5d30"
  default = "ami-03b1b78bb1da5122f" # From isucon9-q of https://github.com/matsuu/aws-isucon
  description = "AMI ID of stand alone instance"
}

variable "access_cidr_blocks" {
  type = string
  default = "0.0.0.0/0" # "0.0.0.0/0,255.255.255.255/32" のようにカンマ区切りで複数指定可
  description = "cidr for access"
}
