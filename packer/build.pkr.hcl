packer {
  required_version = ">= 1.10.0"
  required_plugins {
    vmware = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/vmware"
    }
    git = {
      source  = "github.com/ethanmdavidson/git"
      version = ">= 0.6.2"
    }
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

//  BLOCK: data
//  Defines the data sources.

data "git-repository" "cwd" {}

// BLOCK: locals
// Defines local variables for the build process.

locals {
  build_by        = "Built by: HashiCorp Packer ${packer.version}"
  build_date      = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_version   = data.git-repository.cwd.head
  manifest_date   = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  manifest_path   = "${path.cwd}/manifests/"
  manifest_output = "${local.manifest_path}${local.manifest_date}.json"
  vm_name         = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${local.build_version}"
}


build {
  sources = ["source.vmware-iso.rocky"]


  provisioner "shell" {
    environment_vars = ["HOME_DIR=/home/admin"]
    execute_command  = "echo 'packer' | {{.Vars}} sudo -S -E sh -eux '{{.Path}}'"
    scripts          = fileset(".", "scripts/*.sh")
  }

  // BLOCK: provisioner: ansible-local
  // Reference: https://developer.hashicorp.com/packer/integrations/hashicorp/ansible/latest/components/provisioner/ansible-local
  provisioner "ansible-local" {
    playbook_file = "./ansible/playbook.yaml"
    playbook_dir = "./ansible"
    // extra_arguments = [
    //   "-vvvv"
    // ]
  }

  post-processor "manifest" {
    output     = local.manifest_output
    strip_path = true
    strip_time = true
    custom_data = {
      build_date    = local.build_date
      build_version = local.build_version
    }
  }
}
