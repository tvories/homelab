provider "vsphere" {
  version        = "1.13.0"
  vsphere_server = var.vsphere_vcenter
  user           = var.vsphere_user
  password       = var.vsphere_password

  allow_unverified_ssl = var.vsphere_unverified_ssl
}

data "vsphere_datacenter" "home" {
  name = "Home"
}
data "vsphere_compute_cluster" "cluster-01" {
  name          = "Cluster-01"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_resource_pool" "resource_pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_host" "esx3" {
  name          = "esx3.mcbadass.local"
  datacenter_id = data.vsphere_datacenter.home.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.home.id
}

# Datastores
data "vsphere_datastore" "LUN03" {
  name          = "LUN03"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_datastore" "SATAStorage" {
  name          = "SATAStorage"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_datastore" "SSD" {
  name          = "SSD"
  datacenter_id = data.vsphere_datacenter.home.id
}

# Networks
data "vsphere_network" "network" {
  name          = var.vsphere_port_group
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_network" "LAN" {
  name          = "VLAN 1 - LAN"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_network" "internal_only" {
  name          = "Internal Only"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_network" "joey-net" {
  name          = "VLAN 70 - Joey Backup"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_network" "vlan40" {
  name          = "VLAN 40 - Guest Wifi"
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_network" "trunk" {
  name          = "Trunk"
  datacenter_id = data.vsphere_datacenter.home.id
}

# Templates
data "vsphere_virtual_machine" "centos_template" {
  name          = var.vsphere_centos_template
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_virtual_machine" "ubuntu_template" {
  name          = var.vsphere_ubuntu_template
  datacenter_id = data.vsphere_datacenter.home.id
}
data "vsphere_virtual_machine" "win_2019_template" {
  name          = var.vsphere_2019_template
  datacenter_id = data.vsphere_datacenter.home.id
}

data "vsphere_virtual_machine" "debian_template" {
  name          = "packer-debian10"
  datacenter_id = data.vsphere_datacenter.home.id
}