# Create a vSphere VM in the folder #
resource "vsphere_virtual_machine" "morpheus" {
  # VM placement #
  name             = "morpheus"
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.LUN03.id
  folder           = "Linux"
  tags             = [vsphere_tag.centos.id, vsphere_tag.morpheus.id]

  # VM resources #
  num_cpus = 4
  memory   = 8192

  # Guest OS #4
  guest_id = data.vsphere_virtual_machine.centos_template.guest_id

  # VM storage #
  disk {
    label            = "morpheus.vmdk"
    size             = data.vsphere_virtual_machine.centos_template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.centos_template.disks[0].thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.centos_template.disks[0].eagerly_scrub
  }

   scsi_type = "${data.vsphere_virtual_machine.centos_template.scsi_type}"

  # VM networking #
  network_interface {
    network_id   = data.vsphere_network.LAN.id
    adapter_type = "vmxnet3"
  }

  # Customization of the VM #
  clone {
    template_uuid = data.vsphere_virtual_machine.centos_template.id

    customize {
      linux_options {
        host_name = "morpheus"
        domain    = "mcbadass.local"
      }
      network_interface {
        ipv4_address = "192.168.1.63"
        ipv4_netmask = 24
      }
      ipv4_gateway = "192.168.1.1"
      dns_server_list = ["192.168.1.240", "192.168.1.241"]
    }
  }
}
