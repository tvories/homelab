# vSphere specific configuration

# Tag categories
resource "vsphere_tag_category" "ansible" {
    name            = "ansible"
    description     = "Tags used in ansible"
    cardinality     = "MULTIPLE"

    associable_types = [
        "Folder",
        "ClusterComputeResource",
        "Datacenter",
        "Datastore",
        "StoragePod",
        "DistributedVirtualPortgroup",
        "DistributedVirtualSwitch",
        "VmwareDistributedVirtualSwitch",
        "HostSystem",
        "HostNetwork",
        "Network",
        "OpaqueNetwork",
        "ResourcePool",
        "VirtualApp",
        "VirtualMachine"
    ]
}

# Tags
resource "vsphere_tag" "debian" {
    name            = "debian"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Debian based linux systems"
}
resource "vsphere_tag" "k8" {
    name            = "k8"
    category_id     = vsphere_tag_category.ansible.id
    description     = "kubernetes"
}
resource "vsphere_tag" "centos" {
    name            = "centos"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Centos based linux systems"
}
resource "vsphere_tag" "k8_minion" {
    name            = "k8_minion"
    category_id     = vsphere_tag_category.ansible.id
    description     = "kubernetes minions"
}
resource "vsphere_tag" "k8_master" {
    name            = "k8_master"
    category_id     = vsphere_tag_category.ansible.id
    description     = "kubernetes master"
}
resource "vsphere_tag" "joey" {
    name            = "joey"
    category_id     = vsphere_tag_category.ansible.id
    description     = "VMs associated with Joey"
}
resource "vsphere_tag" "pfsense" {
    name            = "pfsense"
    category_id     = vsphere_tag_category.ansible.id
    description     = "pfSense systems"
}
resource "vsphere_tag" "dc" {
    name            = "dc"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Domain controllers"
}
resource "vsphere_tag" "windows" {
    name            = "windows"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Windows systems"
}
resource "vsphere_tag" "docker" {
    name            = "docker"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Docker"
}
resource "vsphere_tag" "morpheus" {
    name            = "morpheus"
    category_id     = vsphere_tag_category.ansible.id
    description     = "Morpheus"
}

# Distributed port groups