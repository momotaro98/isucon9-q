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

  provisioner "shell" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive",
      "sudo apt-get update",
      "sudo apt-get install -y --no-install-recommends ansible",
    ]
  }

  provisioner "ansible-local" {
    playbook_file  = "./standalone.yml"
    playbook_dir   = "."                 // 必要
    inventory_file = "./inventory/hosts" // 必要
  }
}
