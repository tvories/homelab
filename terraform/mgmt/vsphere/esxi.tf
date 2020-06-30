resource "vsphere_host" "esx4" {
  hostname  = "esx4.mcbadass.local"
  username  = "root"
  password  = var.vsphere_host_password
  license   = var.vsphere_host_license
  cluster   = data.vsphere_compute_cluster.cluster-01.id
}

# iSCSI storage network
resource "vsphere_host_virtual_switch" "iscsi" {
  name              = "iSCSI"
  host_system_id    = vsphere_host.esx4.id
  network_adapters  = var.esx4_iscsi_nics

  active_nics       = var.esx4_iscsi_nics
  standby_nics      = []
  mtu               = 9000
}

resource "vsphere_host_port_group" "iscsi0" {
  name              = "iSCSI0"
  host_system_id    = vsphere_host.esx4.id
  virtual_switch_name = vsphere_host_virtual_switch.iscsi.name
  active_nics         = ["vmnic4"]
}
resource "vsphere_host_port_group" "iscsi1" {
  name              = "iSCSI1"
  host_system_id    = vsphere_host.esx4.id
  virtual_switch_name = vsphere_host_virtual_switch.iscsi.name
  active_nics         = ["vmnic6"]
}
resource "vsphere_host_port_group" "iscsi2" {
  name              = "iSCSI2"
  host_system_id    = vsphere_host.esx4.id
  virtual_switch_name = vsphere_host_virtual_switch.iscsi.name
  active_nics         = ["vmnic5"]
}
resource "vsphere_host_port_group" "iscsi3" {
  name              = "iSCSI3"
  host_system_id    = vsphere_host.esx4.id
  virtual_switch_name = vsphere_host_virtual_switch.iscsi.name
  active_nics         = ["vmnic7"]
}

resource "vsphere_vnic" "iscsi0" {
  host                = vsphere_host.esx4.id
  portgroup           = vsphere_host_port_group.iscsi0.name
  ipv4 {
    ip      = var.esx4_iscsi0_ip
    netmask = var.esx_subnet_mask
  }
  mtu                 = "9000"
  netstack            = "defaultTcpipStack"
}

resource "vsphere_vnic" "iscsi1" {
  host                = vsphere_host.esx4.id
  portgroup           = vsphere_host_port_group.iscsi1.name
  ipv4 {
    ip      = var.esx4_iscsi1_ip
    netmask = var.esx_subnet_mask
  }
  mtu                 = "9000"
  netstack            = "defaultTcpipStack"
}

resource "vsphere_vnic" "iscsi2" {
  host                = vsphere_host.esx4.id
  portgroup           = vsphere_host_port_group.iscsi2.name
  ipv4 {
    ip      = var.esx4_iscsi2_ip
    netmask = var.esx_subnet_mask
  }
  mtu                 = "9000"
  netstack            = "defaultTcpipStack"
}

resource "vsphere_vnic" "iscsi3" {
  host                = vsphere_host.esx4.id
  portgroup           = vsphere_host_port_group.iscsi3.name
  ipv4 {
    ip      = var.esx4_iscsi3_ip
    netmask = var.esx_subnet_mask
  }
  mtu                 = "9000"
  netstack            = "defaultTcpipStack"
}

# vMotion network
resource "vsphere_host_virtual_switch" "vmotion" {
  name              = "vMotion"
  host_system_id    = vsphere_host.esx4.id
  network_adapters  = var.esx4_vmotion_nics

  active_nics       = var.esx4_vmotion_nics
  standby_nics      = []
}

resource "vsphere_host_port_group" "vmotion" {
  name                = "vMotion"
  host_system_id      = vsphere_host.esx4.id
  virtual_switch_name = vsphere_host_virtual_switch.vmotion.name
}

resource "vsphere_vnic" "vmotion" {
  host                = vsphere_host.esx4.id
  portgroup           = vsphere_host_port_group.vmotion.name
  ipv4 {
    dhcp = true
  }
  netstack            = "vmotion"
}

# Distributed Port Group


# Disks/Storage
# data "vsphere_vmfs_disks" "available" {
#   host_system_id  = vsphere_host.esx4.id
#   rescan          = true
# }

# resource "vsphere_vmfs_datastore" "datastore" {
#   name = "datastore-test"
#   host_system_id = vsphere_host.esx4.id
#   disks = data.vsphere_vmfs_disks.available.disks
# }