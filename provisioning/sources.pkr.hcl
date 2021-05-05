source "amazon-ebs" "ubuntu-amd64" {
  # region        = "ap-northeast-1"
  # profile       = "default"
  profile = var.profile

  ami_name        = var.ami_name
  ami_description = var.ami_description
  ami_groups      = var.ami_groups

  instance_type = var.instance_type

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  launch_block_device_mappings {
    volume_type           = "gp2"
    device_name           = "/dev/sda1"
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  ssh_username = "ubuntu"
}