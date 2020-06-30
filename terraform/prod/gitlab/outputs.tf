output "gitlab_ip" {
  value = vsphere_virtual_machine.gitlab.guest_ip_addresses[0]
}