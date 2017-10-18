# Configure the VMware vSphere Provider
provider "vsphere" {
  vsphere_server           = ""
  user       = ""
  password = ""

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Create a file
resource "vsphere_file" "test" {
  datastore        = "test"
  source_datastore        = "test"
  source_file     = "default-template/default-template.vmdk"
  destination_file = "test/test.vmdk"
  datacenter = "Datacenter"
  source_datacenter = "Datacenter"
  create_directories = true
  }

resource "vsphere_file" "test2" {
  datastore        = "test"
  source_datastore        = "test"
  source_file     = "default-template/default-template-flat.vmdk"
  destination_file = "test/default-template-flat.vmdk"
  datacenter = "Datacenter"
  source_datacenter = "Datacenter"
  create_directories = true
  }
  
# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "test" {
  name = "test"
  vcpu   = 2
  memory = 4096

  network_interface {
    label = "VM Network"
  }

  disk {
  datastore        = "test"
  vmdk = "test/test.vmdk"
 

  }
}