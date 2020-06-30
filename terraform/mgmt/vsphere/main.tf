terraform {
  backend "gcs" {
    bucket = "tvo-homelab-tfstate"
    prefix = "terraform/state/vsphere"
    credentials = "/home/tadmin/gits/homelab/terraform/keys/terraform.json"
  }
}

# vSphere specific configuration

# Tag categories
resource "vsphere_tag_category" "ansible" {
    name            = "ansible"
    description     = "Tags used in ansible"
    cardinality     = "MULTIPLE"

    associable_types = [
        "Folder",
        "ClusterComputeResource",
        "Datacenter",
        "Datastore",
        "StoragePod",
        "DistributedVirtualPortgroup",
        "DistributedVirtualSwitch",
        "VmwareDistributedVirtualSwitch",
        "HostSystem",
        "HostNetwork",
        "Network",
        "OpaqueNetwork",
        "ResourcePool",
        "VirtualApp",
        "VirtualMachine"
    ]
}

# Tags
resource "vsphere_tag" "debian" {
    name            = "debian"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Debian based linux systems"
}
resource "vsphere_tag" "k8" {
    name            = "k8"
    category_id     = vsphere_tag_category.ansible.id
    description     = "kubernetes"
}
resource "vsphere_tag" "centos" {
    name            = "centos"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Centos based linux systems"
}
resource "vsphere_tag" "k8_minion" {
    name            = "k8_minion"
    category_id     = vsphere_tag_category.ansible.id
    description     = "kubernetes minions"
}
resource "vsphere_tag" "k8_win_minion" {
  name              = "k8_win_minion"
  category_id       = vsphere_tag_category.ansible.id
  description       = "kubernetes windows minion"
}
resource "vsphere_tag" "k8_master" {
    name            = "k8_master"
    category_id     = vsphere_tag_category.ansible.id
    description     = "kubernetes master"
}
resource "vsphere_tag" "joey" {
    name            = "joey"
    category_id     = vsphere_tag_category.ansible.id
    description     = "VMs associated with Joey"
}
resource "vsphere_tag" "pfsense" {
    name            = "pfsense"
    category_id     = vsphere_tag_category.ansible.id
    description     = "pfSense systems"
}
resource "vsphere_tag" "dc" {
    name            = "dc"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Domain controllers"
}
resource "vsphere_tag" "windows" {
    name            = "windows"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Windows systems"
}
resource "vsphere_tag" "docker" {
    name            = "docker"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Docker"
}
resource "vsphere_tag" "morpheus" {
    name            = "morpheus"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Morpheus"
}

resource "vsphere_tag" "gitlab" {
    name            = "gitlab"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Gitlab"
}

resource "vsphere_tag" "wireguard" {
  name              = "wireguard"
  category_id       = vsphere_tag_category.ansible.id
  description       = "Wireguard"
}

resource "vsphere_tag" "wireguard_server" {
  name              = "wireguard_server"
  category_id       = vsphere_tag_category.ansible.id
  description       = "Wireguard Server"
}

resource "vsphere_tag" "wireguard_client" {
  name              = "wireguard_client"
  category_id       = vsphere_tag_category.ansible.id
  description       = "Wireguard Client"
}
resource "vsphere_tag" "localbackup" {
  name              = "localbackup"
  category_id       = vsphere_tag_category.ansible.id
  description       = "Local backup vm"
}


# Distributed port groups
data "vsphere_distributed_virtual_switch" "vm-networking" {
  name              = "VM_Networking"
  datacenter_id     = data.vsphere_datacenter.home.id
}

# vCenter info

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
# data "vsphere_host" "esx3" {
#   name          = "esx3.mcbadass.local"
#   datacenter_id = data.vsphere_datacenter.home.id
# }

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
data "vsphere_datastore" "localbackup" {
  name          = "localbackup"
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
data "vsphere_network" "untagged" {
  name          = "Untagged"
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
data "vsphere_virtual_machine" "ubuntu_2004_template" {
  name          = var.vsphere_ubuntu_2004_template
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