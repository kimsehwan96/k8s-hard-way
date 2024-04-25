locals {
  data_directory = var.data_directory == null ? "data" : var.data_directory
  memory         = var.memory == null ? 2048 : var.memory
}

source "vmware-iso" "rocky" {
  boot_command         = var.boot_command
  boot_wait            = "5s"
  cpus                 = 2
  cdrom_adapter_type   = var.cdrom_adapter_type
  disk_adapter_type    = var.disk_adapter_type
  guest_os_type        = var.guest_os_type
  headless             = var.vm_headless
  http_directory       = "http"
  iso_checksum         = var.iso_checksum
  iso_url              = var.iso_url
  memory               = local.memory
  network_adapter_type = var.network_adapter_type
  output_directory     = "artifacts/${var.vm_name}"
  shutdown_command     = "echo vagrant | sudo -S /sbin/shutdown -hP now"
  ssh_password         = "admin"
  ssh_timeout          = "10000s"
  ssh_username         = "admin"
  tools_upload_flavor  = var.tools_upload_flavor
  tools_upload_path    = var.tools_upload_path
  version              = var.hardware_version
  vmx_data             = var.vmx_data
}
