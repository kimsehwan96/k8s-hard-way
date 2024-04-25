cdrom_adapter_type   = "sata"
data_directory       = "data/rocky"
disk_adapter_type    = "sata"
network_adapter_type = "e1000e"
iso_url              = "https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.3-aarch64-dvd.iso"
iso_checksum         = "6b25a942cbac1126903a10290da0bf7c89513d397ca92e743ba418f000f76efb"
guest_os_type        = "arm-rhel9-64"
hardware_version     = 20
boot_command = [
  // This sends the "up arrow" key, typically used to navigate through boot menu options.
  "<up>",
  // This sends the "e" key. In the GRUB boot loader, this is used to edit the selected boot menu option.
  "e",
  // This sends two "down arrow" keys, followed by the "end" key, and then waits. This is used to navigate to a specific line in the boot menu option's configuration.
  "<down><down><end><wait>",
  // This types the string "text" followed by the value of the 'data_source_command' local variable.
  // This is used to modify the boot menu option's configuration to boot in text mode and specify the kickstart data source configured in the common variables.
  "inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
  // This sends the "enter" key, waits, turns on the left control key, sends the "x" key, and then turns off the left control key. This is used to save the changes and exit the boot menu option's configuration, and then continue the boot process.
  "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
]
vm_name = "rocky_aarch64"
vmx_data = {
  "cpuid.coresPerSocket" = "2"
  //   "ethernet0.pciSlotNumber" = "32"
  # REF: https://github.com/hashicorp/packer-plugin-vmware/tree/main/example
  # ARM MAC 에서 VMWare Fusion 사용해서 빌드하기 위해서 추가적인 설정이 필요함.
  "svga.autodetect"  = true
  "usb_xhci.present" = true
  "virtualHW.version" : "20"
  "ethernet0.virtualdev" = "e1000e",
  "firmware"             = "efi"
}

vm_guest_os_family  = "linux"
vm_guest_os_name    = "rocky"
vm_guest_os_version = "9.3"
