terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.80.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "mmayr-k8s-rg" {
  name     = "mmayr-k8s-rg"
  location = "South Central US"
}

resource "azurerm_network_interface" "k8s_master_nic" {
  name                = "k8s-master-nic-${count.index}"
  location            = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name = azurerm_resource_group.mmayr-k8s-rg.name
  count               = var.worker_machines.count

  ip_configuration {
    name                          = "mmayr-k8s-ipconfig"
    subnet_id                     = "/subscriptions/619b068f-9bf3-474c-887a-9dbec6ba6e51/resourceGroups/sre/providers/Microsoft.Network/virtualNetworks/sre-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "k8s-master" {
  name                  = "k8s-master-${count.index}"
  count                 = var.master_machines.count
  location              = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name   = azurerm_resource_group.mmayr-k8s-rg.name
  network_interface_ids = ["${element(azurerm_network_interface.k8s_master_nic.*.id, count.index)}"]
  admin_username        = var.admin_username
  size                  = "Standard_B2s"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19_04-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_key)
  }
}

resource "azurerm_network_interface" "k8s_worker_nic" {
  name                = "k8s-worker-nic-${count.index}"
  count               = var.worker_machines.count
  location            = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name = azurerm_resource_group.mmayr-k8s-rg.name

  ip_configuration {
    name                          = "mmayr-k8s-ipconfig"
    subnet_id                     = "/subscriptions/619b068f-9bf3-474c-887a-9dbec6ba6e51/resourceGroups/sre/providers/Microsoft.Network/virtualNetworks/sre-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "k8s-worker" {
  name                  = "k8s-worker-${count.index}"
  count                 = var.worker_machines.count
  location              = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name   = azurerm_resource_group.mmayr-k8s-rg.name
  network_interface_ids = ["${element(azurerm_network_interface.k8s_worker_nic.*.id, count.index)}"]
  admin_username        = var.admin_username
  size                  = "Standard_B2s"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19_04-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_key)
  }
}

