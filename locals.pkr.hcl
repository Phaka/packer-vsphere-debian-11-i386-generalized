locals {
  timestamp = formatdate("EEE, DD MMM YYYY hh:mm:ss ZZZ", timestamp())
  suffix = formatdate("YYYYMMDD'T'hhmm", timestamp())
  vm_name = "Debian-11-i386-${local.suffix}"
  iso_path = join("", [var.iso_path_prefix, var.iso_path])
  boot_commands = <<-EOT
    <esc><wait>
    install <wait>
    preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>
    debian-installer=en_US.UTF-8 <wait>
    auto <wait>
    locale=en_US.UTF-8 <wait>
    kbd-chooser/method=us <wait>
    keyboard-configuration/xkb-keymap=us <wait>
    netcfg/get_hostname=debian <wait>
    netcfg/get_domain=oak02.bloudraak.net <wait>
    fb=false <wait>
    debconf/frontend=noninteractive <wait>
    console-setup/ask_detect=false <wait>
    console-keymaps-at/keymap=us <wait>
    grub-installer/bootdev=/dev/sda <wait>
    <enter><wait>
    EOT
}