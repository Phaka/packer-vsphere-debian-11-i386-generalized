# Setting the locales, country
# Supported locales available in /usr/share/i18n/SUPPORTED
d-i debian-installer/language string en
d-i debian-installer/country string us
d-i debian-installer/locale string en_US.UTF-8

# Keyboard setting
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/layoutcode string us
d-i keyboard-configuration/xkb-keymap us
d-i keyboard-configuration/modelcode string pc105

# User creation
d-i passwd/user-fullname string ${ ssh_username }
d-i passwd/username string ${ ssh_username }
d-i passwd/user-password password ${ ssh_password }
d-i passwd/user-password-again password ${ ssh_password }
d-i passwd/user-uid string 1000
d-i user-setup/allow-password-weak boolean true

# Disk and Partitioning setup
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman-auto/method string lvm
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-lvm/device_remove_lvm boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/confirm_write_new_label boolean true

# Set mirror
apt-mirror-setup apt-setup/use_mirror boolean true
choose-mirror-bin mirror/http/proxy string
d-i mirror/country string manual
d-i mirror/http/directory string /debian
d-i mirror/http/hostname string httpredir.debian.org
d-i mirror/http/proxy string

# Set root password
d-i passwd/root-login boolean false
d-i passwd/root-password-again password ${ ssh_password }
d-i passwd/root-password password ${ ssh_password }

# Package installations
popularity-contest popularity-contest/participate boolean false
tasksel tasksel/first multiselect standard, ssh-server
d-i pkgsel/include string sudo wget curl open-vm-tools
d-i pkgsel/install-language-support boolean false
d-i pkgsel/update-policy select none
d-i pkgsel/upgrade select full-upgrade
d-i grub-installer/only_debian boolean true
d-i finish-install/reboot_in_progress note

# Give Packer Passwordless access to VM
d-i preseed/late_command string \
    echo '${ ssh_username } ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/${ ssh_username } ; \
    in-target chmod 440 /etc/sudoers.d/${ ssh_username } ;

# Skip Scanning Next DVDs
d-i apt-setup/cdrom/set-first boolean false
d-i apt-setup/cdrom/set-next boolean false
d-i apt-setup/cdrom/set-failed boolean false