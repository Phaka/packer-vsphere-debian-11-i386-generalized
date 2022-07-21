source "vsphere-iso" "main" {
  vm_name             = local.vm_name
  notes = "Packer generated VM"

  host                = var.vsphere_host
  insecure_connection = true
  username            = var.vcenter_username
  password            = var.vcenter_password
  vcenter_server      = var.vcenter_server
  folder              = var.vcenter_folder
  create_snapshot     = true
  snapshot_name       = "generalized"
  CPUs                = var.processor_count
  cpu_cores           = var.processor_cores
  RAM                 = var.RAM
  RAM_reserve_all     = true
  firmware            = "bios"
  boot_wait           = "5s"

   
  http_content        = {
    "/preseed.cfg" = templatefile(
      "${path.root}/http/preseed.cfg.pkrtpl.hcl", {
        ssh_username = var.ssh_username,
        ssh_password = var.ssh_password,
        ssh_password_hashed = var.ssh_password_hashed,
        packer_username = var.packer_username,
        packer_password = var.packer_password,
        packer_password_hashed = var.packer_password_hashed,
        hostname = var.hostname,
    })
  }

  boot_command        = [local.boot_commands]
  guest_os_type       = "debian10Guest"
  iso_paths           = [ local.iso_path ]

  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  disk_controller_type = ["pvscsi"]

  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = true
  }

  shutdown_command       = ""
  ssh_password           = var.ssh_password
  ssh_username           = var.ssh_username
  ssh_handshake_attempts = 10
  ssh_timeout            = "20m"
  remove_cdrom           = true
  datastore              = var.vsphere_datastore

  convert_to_template = true
}


