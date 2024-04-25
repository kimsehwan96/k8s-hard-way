variable "boot_command" {
  type    = list(string)
  default = null
}

variable "build_username" {
  type    = string
  default = "vagrant"
}

variable "build_password" {
  type    = string
  default = "vagrant"
}

variable "cdrom_adapter_type" {
  type    = string
  default = "sata"
}

variable "data_directory" {
  type    = string
  default = "null"
}

variable "disk_size" {
  type    = number
  default = 65536
}

variable "disk_adapter_type" {
  type    = string
  default = "lsilogic"
}

variable "guest_os_type" {
  type    = string
  default = null
}

variable "hardware_version" {
  type    = number
  default = 19 # Refer to VMware versions https://kb.vmware.com/s/article/1003746
}

variable "iso_checksum" {
  type    = string
  default = null
}

variable "iso_url" {
  type    = string
  default = null
}

variable "memory" {
  type    = number
  default = null
}

variable "network_adapter_type" {
  type    = string
  default = null
}

variable "tools_upload_flavor" {
  type    = string
  default = null
}

variable "tools_upload_path" {
  type    = string
  default = null
}

variable "vm_name" {
  type    = string
  default = "debian"
}

variable "vmx_data" {
  type = map(string)
  default = {
    "cpuid.coresPerSocket" = "2"
  }
}

variable "vm_guest_os_language" {
  type    = string
  default = "en"
}

variable "vm_guest_os_keyboard" {
  type    = string
  default = "us"
}

variable "vm_guest_os_timezone" {
  type    = string
  default = "UTC"
}

variable "vm_headless" {
  type    = bool
  default = true
}


variable "vm_guest_os_family" {
  type    = string
  default = null
}

variable "vm_guest_os_name" {
  type    = string
  default = null
}

variable "vm_guest_os_version" {
  type    = string
  default = null
}
