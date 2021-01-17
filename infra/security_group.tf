module "isucon_sg" {
  source = "./security_group"
  name = "isucon-sg"
  vpc_id = aws_vpc.isucon.id
  cidr_blocks = var.access_cidr_blocks
}
