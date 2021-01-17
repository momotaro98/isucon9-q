variable "access_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
  description = "cidr for access"
}
