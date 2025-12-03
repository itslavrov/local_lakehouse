packer {
  required_version = ">= 1.9.0"

  required_plugins {
    openstack = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

variable "network_id" {
  type = string
}

variable "source_image" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "MS1"
}

source "openstack" "ubuntu" {
  flavor                   = "STD2-4-8"
  image_name               = "local-lakehouse-ubuntu-22.04"
  source_image             = var.source_image
  config_drive             = true
  networks                 = [var.network_id]
  security_groups          = ["default-sprut", "ssh"]
  ssh_username             = "ubuntu"
  use_blockstorage_volume  = true
  volume_type              = "ceph-ssd"
  volume_size              = 20
  volume_availability_zone = var.availability_zone
  availability_zone        = var.availability_zone
}

build {
  sources = ["source.openstack.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo mkdir -p /opt/lakehouse_repo",
      "sudo mkdir -p /opt/scripts",
      "sudo chown ubuntu:ubuntu /opt/lakehouse_repo /opt/scripts"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/../lakehouse_repo/"
    destination = "/opt/lakehouse_repo"
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/"
    destination = "/opt/scripts"
  }

  provisioner "shell" {
    inline = [
      "sudo chmod -R 755 /opt/scripts"
    ]
  }

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    user          = "ubuntu"
    sftp_command  = "/usr/lib/openssh/sftp-server -e"
    use_proxy     = false

    ansible_env_vars = [
      "ANSIBLE_CONFIG=./ansible.cfg"
    ]
  }
}
