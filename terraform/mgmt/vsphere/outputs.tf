output "ansible_tag_category" {
  value = vsphere_tag_category.ansible
  description = "Ansible tag category"
}

# vSphere
output "cluster-01" {
  value = data.vsphere_compute_cluster.cluster-01
  description = "Primary cluster in vCenter"
}

output "resource_pool" {
  value = data.vsphere_resource_pool.resource_pool
  description = "Resource Pool in vCenter"
}

# output "esx3" {
#   value = data.vsphere_host.esx3
#   description = "esxi host to provision to"
# }

output "esx4" {
  value = vsphere_host.esx4
  description = "DL360 G8 esx host"
}

# Datastores
output "LUN03" {
  value = data.vsphere_datastore.LUN03
  description = "LUN03 Datastore"
}

output "SATAStorage" {
  value = data.vsphere_datastore.SATAStorage
  description = "SATAStorage Datastore"
}

output "SSD" {
  value = data.vsphere_datastore.SSD
  description = "SSD Datastore"
}
output "localbackup" {
  value = data.vsphere_datastore.localbackup
  description = "Local backup drive"
}

# Networks
output "LAN" {
  value = data.vsphere_network.LAN
}

output "untagged" {
  value = data.vsphere_network.untagged
}

output "internal_only" {
  value = data.vsphere_network.internal_only
}

output "joey-net" {
  value = data.vsphere_network.joey-net
}

output "vlan40" {
  value = data.vsphere_network.vlan40
}

output "trunk" {
  value = data.vsphere_network.trunk
}

# Templates
output "centos_template" {
  value = data.vsphere_virtual_machine.centos_template
}

output "ubuntu_template" {
  value = data.vsphere_virtual_machine.ubuntu_template
}
output "ubuntu_2004_template" {
  value = data.vsphere_virtual_machine.ubuntu_2004_template
}

output "win_2019_template" {
  value = data.vsphere_virtual_machine.win_2019_template
}

output "debian_template" {
  value = data.vsphere_virtual_machine.debian_template
}

# Tags
output "tag_gitlab" {
  value = vsphere_tag.gitlab
}

output "tag_debian" {
  value = vsphere_tag.debian
}

output "tag_centos" {
  value = vsphere_tag.centos
}

output "tag_k8_master" {
  value = vsphere_tag.k8_master
}

output "tag_k8_minion" {
  value = vsphere_tag.k8_minion
}

output "tag_k8" {
  value = vsphere_tag.k8
}

output "tag_wireguard" {
  value = vsphere_tag.wireguard
}

output "tag_wireguard_server" {
  value = vsphere_tag.wireguard_server
}

output "tag_wireguard_client" {
  value = vsphere_tag.wireguard_client
}

output "tag_k8_win_minion" {
  value = vsphere_tag.k8_win_minion
}

output "tag_windows" {
  value = vsphere_tag.windows
}
output "tag_localbackup" {
  value = vsphere_tag.localbackup
}