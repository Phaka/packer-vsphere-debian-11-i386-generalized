build {
  sources = [
    "source.vsphere-iso.main",
  ]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    user = var.ssh_username
    extra_arguments = [
      "--extra-vars",
      "username=\"${var.packer_username}\" password=\"${var.packer_password }\"",
    ]
  }

  post-processors {
    post-processor "manifest" {
      output      = "manifest.json"
      strip_path  = true
    }
  }
}