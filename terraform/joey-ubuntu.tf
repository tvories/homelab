# Create a vSphere VM in the folder #
resource "vsphere_virtual_machine" "joey-ubuntu" {
  # VM placement #
  name             = "joey-ubuntu"
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.LUN03.id
  folder           = "joey"
  tags             = [vsphere_tag.joey.id, vsphere_tag.debian.id]

  # VM resources #
  num_cpus = 2
  memory   = 2048

  # Guest OS #
  guest_id = data.vsphere_virtual_machine.ubuntu_template.guest_id

  # VM storage #
  disk {
    label            = "joey-ubuntu.vmdk"
    size             = data.vsphere_virtual_machine.ubuntu_template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.ubuntu_template.disks[0].thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.ubuntu_template.disks[0].eagerly_scrub
  }

   scsi_type = "${data.vsphere_virtual_machine.ubuntu_template.scsi_type}"

  # VM networking #
  network_interface {
    network_id   = data.vsphere_network.joey-net.id
    adapter_type = "vmxnet3"
  }

  # Customization of the VM #
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu_template.id

    customize {
      linux_options {
        host_name = "joey"
        domain    = "mcbadass.local"
      }
      network_interface {
        ipv4_address = "192.168.70.20"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.70.1"
      dns_server_list = ["1.1.1.1"]
    }
  }
}
