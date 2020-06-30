terraform {
  backend "gcs" {
    bucket = "tvo-homelab-tfstate"
    prefix = "terraform/state/k8s"
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

