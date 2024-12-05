resource "proxmox_vm_qemu" "srv_IAC" {
  name                          = "srv-IAC"
  desc                          = "IAC"
  tags                          = "IAC;Prod"
  force_recreate_on_change_of   = "1"
  vmid                          = 1005
  target_node                   = var.proxmox_node_name
  # vm_state                    = "running"

  clone      = "IAC-Ubuntu-24-04"
  full_clone = true
  cores      = 2
  sockets    = 1
  cpu        = "host"
  memory     = 4096
  qemu_os    = "l26"
  agent      = 1
  onboot     = true

  network {
    bridge = var.proxmox_network_bridge
    model  = "virtio"
  }

  disks {
    virtio {
      virtio0 {
        disk {
          size    = 20
          storage = var.proxmox_storage_pool
        }
      }
    }
  }

  cloudinit_cdrom_storage = var.proxmox_storage_pool
  os_type                 = "cloud-init"
  ipconfig0               = "ip=dhcp"
  nameserver              = "10.11.1.1 10.11.1.11"
}