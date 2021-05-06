variable "standalone_ami_name" {}
variable "standalone_ami_owner" {}
variable "subnet_id" {}
variable "security_group_id" {}

variable "names" {
  default = {
    "0" = "01"
    "1" = "02"
    "2" = "03"
  }
}