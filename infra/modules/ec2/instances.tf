resource "aws_key_pair" "participant-key" {
  key_name   = "isucon_key"
  public_key = file("./modules/credential/isucon_id_rsa.pub")
}

resource "aws_instance" "participant-instance" {
  count = length(var.names)
  instance_type = "t3.micro"
  ami = "ami-0ef85cf6e604e5650" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type (64-bit x86)
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = aws_key_pair.participant-key.id
  security_groups = [var.security_group_id]

  root_block_device {
    # device_name           = "/dev/sdb"
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = true # TODO? Change to false? ref https://github.com/recruit-tech/r-isucon/blob/master/provisioning/terraform/modules/management/ec2/main.tf#L20
  }

  tags = {
    Name = format("isucon-%s", lookup(var.names, count.index))
  }
}