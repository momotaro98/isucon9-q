packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

build {
  sources = [
    "source.amazon-ebs.ubuntu-amd64"
  ]
  provisioner "ansible" {
    playbook_file = "./standalone.yml"
  }
}
