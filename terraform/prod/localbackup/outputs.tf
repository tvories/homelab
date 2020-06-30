output "localbackup_ip" {
  value = vsphere_virtual_machine.localbackup.guest_ip_addresses[0]
}