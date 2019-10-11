variable "vsphere_k8pod_network" {
  description = "POD Network and Subnet Mask for K8 Configruation Script"
  default     = "10.0.30.0/24"
}

variable "vsphere_k8_nodes" {
  description = "Number of K8 Nodes"
}

variable "vsphere_vm_name_k8n1" {
  description = "K8 Node VM Name"
}

variable "vsphere_ipv4_address_k8n1_network" {
  description = "K8 Node 1 IP"
}

variable "vsphere_ipv4_address_k8n1_host" {
  description = "K8 Node 1 IP"
}

variable "k8_master_name" {
  description = "Name of the kubernetes master"
}

variable "k8_node_name" {
  description = "Name of the kubernetes nodes"
}

variable "k8_vm_folder" {
  description = "VM folder for k8 stuff to go"
}

variable "k8_master_ip" {
  description = "IP Address for K8 Master"
}
