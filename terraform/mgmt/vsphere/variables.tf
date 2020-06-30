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

# VM specifications

variable "vsphere_datacenter" {
  description = "In which datacenter the VM will be deployed"
}

variable "vsphere_resource_pool" {
  description = "VM Resource Pool"
  default     = "Resources"
}

variable "vsphere_cluster" {
  description = "In which cluster the VM will be deployed"
}

variable "vsphere_datastore" {
  description = "What is the name of the VM datastore"
  default     = "LUN03"
}

variable "vsphere_host" {
  description = "What is the name of the VM esxi Host"
  default     = "esx3.mcbadass.local"
}

variable "vsphere_port_group" {
  description = "In which port group the VM NIC will be configured (default: LAN)"
  default     = "VLAN 1 - LAN"
}

variable "vsphere_ipv4_netmask" {
  description = "What is the IPv4 netmask of the VM (default: 24)"
  default     = "24"
}

variable "vsphere_ipv4_gateway" {
  description = "What is the IPv4 gateway of the VM"
  default     = "192.168.1.1"
}

variable "vsphere_dns_servers" {
  description = "What are the DNS servers of the VM"
  default     = ["192.168.1.240","192.168.1.241"]
}

variable "vsphere_domain" {
  description = "What is the domain of the VM"
  default     = "mcbadass.local"
}

variable "vsphere_time_zone" {
  description = "What is the timezone of the VM"
  default     = "America/Denver"
}

variable "vsphere_linux_password" {
  description = "Root password linux template"
  default     = "vagrant"
}

variable "vsphere_tag_category" {
  description = "vSphere Tag Catagory Details"
  default     = "ansible"
}

variable "vsphere_master_tag_name" {
  description = "vSphere Tag Details"
  default     = "k8-master"
}

variable "vsphere_node_tag_name" {
  description = "vSphere Tag Details"
  default     = "k8_minion"
}

variable "vsphere_centos_template" {
  description = "VM Template for Centos"
}

variable "vsphere_ubuntu_template" {
  description = "VM Template for Ubuntu"
}
variable "vsphere_ubuntu_2004_template" {
  description = "VM Template for Ubuntu 20.04"
}

variable "vsphere_2019_template" {
  description = "VM Template for Windows Server 2019"
}

variable "linux_vm_username" {
  description = "Username for linux vms"
}

variable "linux_vm_password" {
  description = "Password for linux vms"
}

variable "vsphere_host_password" {
  description = "Password for esxi root user"
}

variable "vsphere_host_license" {
  description = "License for esxi hosts"
}

variable "esx4_iscsi_nics" {
  description = "NICs assigned to iscsi network"
  default = ["vmnic4", "vmnic5", "vmnic6", "vmnic7"]
}

variable "esx4_vmotion_nics" {
  description = "NICs assigned to vmotion network"
  default = ["vmnic1"]
}

variable "esx4_iscsi0_ip" {
  description = "IP Address for iscsi0"
  default = "192.168.20.14"
}

variable "esx4_iscsi1_ip" {
  description = "IP Address for iscsi1"
  default = "192.168.21.14"
}

variable "esx4_iscsi2_ip" {
  description = "IP Address for iscsi2"
  default = "192.168.22.14"
}

variable "esx4_iscsi3_ip" {
  description = "IP Address for iscsi3"
  default = "192.168.23.14"
}

variable "esx_subnet_mask" {
  description = "Subnet mask used in esxi hosts"
  default     = "255.255.255.0"
}

variable "esx4_dvswitch_uplinks" {
  description = "Physical NICs for dvSwitch"
  default     = ["vmnic2", "vmnic3"]
}