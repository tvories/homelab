# Create a vSphere VM in the folder #
resource "vsphere_virtual_machine" "K8-MASTER" {
  # VM placement #
  name             = var.k8_master_name
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.LUN03.id
  folder           = var.k8_vm_folder
  tags             = [data.vsphere_tag.tag.id]

  # VM resources #
  num_cpus = 2
  memory   = 4096

  # Guest OS #
  guest_id = data.vsphere_virtual_machine.centos_template.guest_id

  # VM storage #
  disk {
    label            = "${var.k8_master_name}.vmdk"
    size             = data.vsphere_virtual_machine.centos_template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.centos_template.disks[0].thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.centos_template.disks[0].eagerly_scrub
  }

   scsi_type = "${data.vsphere_virtual_machine.centos_template.scsi_type}"

  # VM networking #
  network_interface {
    network_id   = data.vsphere_network.LAN.id
    adapter_type = data.vsphere_virtual_machine.centos_template.network_interface_types[0]
  }

  # Customization of the VM #
  clone {
    template_uuid = data.vsphere_virtual_machine.centos_template.id

    customize {
      linux_options {
        host_name = var.k8_master_name
        domain    = var.vsphere_domain
        time_zone = var.vsphere_time_zone
      }

      network_interface {
        ipv4_address = var.k8_master_ip
        ipv4_netmask = var.vsphere_ipv4_netmask
      }

      ipv4_gateway    = var.vsphere_ipv4_gateway
      dns_server_list = var.vsphere_dns_servers
      dns_suffix_list = [var.vsphere_domain]
    }
  }
}
