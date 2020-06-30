# Create a vSphere VM in the folder #
resource "vsphere_virtual_machine" "K8-WIN-NODE" {
  # Node Count #
  count = var.vsphere_k8_win_nodes

  # VM placement #
  name             = "${var.vsphere_vm_name_k8_win}${count.index + 1}"
  resource_pool_id = data.terraform_remote_state.vcenter.outputs.resource_pool.id
  datastore_id     = data.terraform_remote_state.vcenter.outputs.LUN03.id
  folder           = var.k8_vm_folder
  tags             = [data.terraform_remote_state.vcenter.outputs.tag_k8.id, data.terraform_remote_state.vcenter.outputs.tag_k8_win_minion.id, data.terraform_remote_state.vcenter.outputs.tag_windows.id]

  # VM resources #
  num_cpus = 4
  memory   = 4096

  # Guest OS #
  guest_id = data.terraform_remote_state.vcenter.outputs.win_2019_template.guest_id


  # VM storage #
  disk {
    label            = "${var.vsphere_vm_name_k8_win}${count.index + 1}.vmdk"
    size             = data.terraform_remote_state.vcenter.outputs.win_2019_template.disks[0].size
    thin_provisioned = data.terraform_remote_state.vcenter.outputs.win_2019_template.disks[0].thin_provisioned
    eagerly_scrub    = data.terraform_remote_state.vcenter.outputs.win_2019_template.disks[0].eagerly_scrub
  }

    scsi_type = data.terraform_remote_state.vcenter.outputs.win_2019_template.scsi_type

  # VM networking #
  network_interface {
    network_id   = data.terraform_remote_state.vcenter.outputs.untagged.id
    adapter_type = data.terraform_remote_state.vcenter.outputs.win_2019_template.network_interface_types[0]
  }

  # for vsphere-kubernetes integration
  enable_disk_uuid = "true"

  # Customization of the VM #
  clone {
    template_uuid = data.terraform_remote_state.vcenter.outputs.win_2019_template.id

    customize {
      windows_options {
        computer_name = "${var.vsphere_vm_name_k8_win}${count.index + 1}"
        join_domain   = "mcbadass.local"
      }

      network_interface {
        ipv4_address = "${var.vsphere_ipv4_address_k8n1_network}${var.vsphere_ip4v_address_win_minion_host + count.index}"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "192.168.1.1"
      dns_server_list = ["192.168.1.240", "192.168.1.241"]
    }
  }
}
