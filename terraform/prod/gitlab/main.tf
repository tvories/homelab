terraform {
  backend "gcs" {
    bucket = "tvo-homelab-tfstate"
    prefix = "terraform/state/gitlab"
    credentials = "/home/tadmin/gits/homelab/terraform/keys/terraform.json"
  }
}

data "terraform_remote_state" "vcenter" {
  backend = "gcs"
  config = {
    bucket = "tvo-homelab-tfstate"
    prefix = "terraform/state/vsphere"
    credentials = "/home/tadmin/gits/homelab/terraform/keys/terraform.json"
  }
}

# Create a vSphere VM in the folder #
resource "vsphere_virtual_machine" "gitlab" {
  # VM placement #
  name             = var.instance_name
  resource_pool_id = data.terraform_remote_state.vcenter.outputs.resource_pool.id
  datastore_id     = data.terraform_remote_state.vcenter.outputs.LUN03.id
  folder           = var.vm_folder
  tags             = [data.terraform_remote_state.vcenter.outputs.tag_debian.id, data.terraform_remote_state.vcenter.outputs.tag_gitlab.id]

  # VM resources #
  num_cpus = 6
  memory   = 4096

  # Guest OS #
  guest_id = data.terraform_remote_state.vcenter.outputs.ubuntu_template.guest_id

  # VM storage #
  disk {
    label            = "${var.instance_name}.vmdk"
    size             = data.terraform_remote_state.vcenter.outputs.ubuntu_template.disks[0].size
    thin_provisioned = data.terraform_remote_state.vcenter.outputs.ubuntu_template.disks[0].thin_provisioned
    eagerly_scrub    = data.terraform_remote_state.vcenter.outputs.ubuntu_template.disks[0].eagerly_scrub
  }

   scsi_type = "${data.terraform_remote_state.vcenter.outputs.ubuntu_template.scsi_type}"

  # VM networking #
  network_interface {
    network_id   = data.terraform_remote_state.vcenter.outputs.LAN.id
    adapter_type = "vmxnet3"
  }

  # Customization of the VM #
  clone {
    template_uuid = data.terraform_remote_state.vcenter.outputs.ubuntu_template.id

    customize {
      linux_options {
        host_name = var.instance_name
        domain    = "mcbadass.local"
      }
      network_interface {
        ipv4_address = "192.168.1.92"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.1.1"
      dns_server_list = ["192.168.1.240", "192.168.1.241"]
    }
  }
}

# Set DNS - Not working right now
# resource "windns" "gitlab_dns_a_record" {
#   record_name = "gitlab"
#   record_type = "A"
#   zone_name = "mcbadass.local"
#   ipv4address = vsphere_virtual_machine.gitlab.guest_ip_addresses[0]
# }
