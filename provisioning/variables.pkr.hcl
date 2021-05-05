variable "profile" {
  type    = string
  default = "default"
}

variable "ami_name" {
  type    = string
  default = "isucon9-qualify-{{isotime \"20060102030405\"}}"
}

variable "ami_description" {
  type    = string
  default = ""
}

variable "ami_groups" {
  type    = list(string)
  default = []
}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "volume_size" {
  type    = number
  default = 16
}