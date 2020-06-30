terraform {
  backend "gcs" {
    bucket = "tvo-homelab-tfstate"
    prefix = "terraform/state/localbackup"
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

# Backup data disk
resource "vsphere_virtual_disk" "backup_disk" {
  size               = 2500
  vmdk_path          = "backup_disk/backup_disk.vmdk"
  datastore          = "localbackup"
  type               = "thin"
  create_directories = true

  lifecycle {
    prevent_destroy = true
  }
}

# Create a vSphere VM in the folder #
resource "vsphere_virtual_machine" "localbackup" {
  depends_on       = ["vsphere_virtual_disk.backup_disk"]
  # VM placement #
  name             = var.instance_name
  resource_pool_id = data.terraform_remote_state.vcenter.outputs.resource_pool.id
  datastore_id     = data.terraform_remote_state.vcenter.outputs.localbackup.id
  folder           = var.vm_folder
  tags             = [data.terraform_remote_state.vcenter.outputs.tag_debian.id, data.terraform_remote_state.vcenter.outputs.tag_localbackup.id]

  # VM resources #
  num_cpus = 2
  memory   = 2048

  # Guest OS #
  guest_id = data.terraform_remote_state.vcenter.outputs.ubuntu_2004_template.guest_id

  # VM storage #
  disk {
    label            = "${var.instance_name}.vmdk"
    size             = 25
    thin_provisioned = true
  }

  # Backup drive
  disk {
    label        = "backup_disk"
    attach       = true
    path         = vsphere_virtual_disk.backup_disk.vmdk_path
    unit_number  = 1
    datastore_id = data.terraform_remote_state.vcenter.outputs.localbackup.id
  }

   scsi_type = "pvscsi"

  # VM networking #
  network_interface {
    network_id   = data.terraform_remote_state.vcenter.outputs.untagged.id
    adapter_type = "vmxnet3"
  }

  # Customization of the VM #
  clone {
    template_uuid = data.terraform_remote_state.vcenter.outputs.ubuntu_2004_template.id

    customize {
      linux_options {
        host_name = var.instance_name
        domain    = "mcbadass.local"
      }
      network_interface {
        ipv4_address = "192.168.1.215"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.1.1"
      dns_server_list = ["192.168.1.240", "192.168.1.241"]
    }
  }
}
