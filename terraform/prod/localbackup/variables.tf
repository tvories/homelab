variable "instance_name" {
  description = "Name for the wireguard instance"
  default     = "localbackup"
}

variable "vm_folder" {
  description = "VMware folder location"
  default     = "Linux"
}


variable "vsphere_user" {
  description = "vSphere user name"
}

variable "vsphere_password" {
  description = "vSphere password"
}

variable "vsphere_vcenter" {
  description = "vCenter server FQDN or IP"
}

variable "vsphere_unverified_ssl" {
  description = "Is the vCenter using a self signed certificate (true/false)"
}

# DC Variables
// variable "dc_server" {
//   description = "The domain controller to set DNS"
//   default     = "dc1.mcbadass.local"
// }

// variable "dc_username" {
//   description = "The user that can set DNS values"
// }

// variable "dc_password" {
//   description = "The password for the DNS user"
//   type = "string"
// }