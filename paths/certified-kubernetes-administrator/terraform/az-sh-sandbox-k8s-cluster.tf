terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.81.0"
    }
  }
}

provider "azurerm" {
  features {
    # resource_group {
    #   prevent_deletion_if_contains_resources = true
    # }
  }
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "mmayr-k8s-rg" {
  name     = "mmayr-k8s-rg"
  location = "South Central US"
}

resource "azurerm_network_security_group" "mmayr-k8s-nsg" {
  name     = "k8s-nsg"
  location = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name = azurerm_resource_group.mmayr-k8s-rg.name

  security_rule = [{
    access                     = "Allow"
    description                = "value"
    destination_address_prefix = "*"
    destination_address_prefixes = []
    destination_application_security_group_ids = []
    destination_port_ranges = []
    source_address_prefixes = []
    source_application_security_group_ids = []
    destination_port_range     = "*"
    direction                  = "Outbound"
    name                       = "Default"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    source_port_ranges          = []
  },
  {
    access                     = "Allow"
    description                = "value"
    destination_address_prefix = "*"
    destination_address_prefixes = []
    destination_application_security_group_ids = []
    destination_port_ranges = []
    source_address_prefixes = []
    source_application_security_group_ids = []
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "ssh"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    source_port_ranges          = []
  }]
}

resource "azurerm_subnet_network_security_group_association" "k8s-nsg-association" {
  subnet_id                 = "/subscriptions/619b068f-9bf3-474c-887a-9dbec6ba6e51/resourceGroups/sre/providers/Microsoft.Network/virtualNetworks/sre-vnet/subnets/default"
  network_security_group_id = azurerm_network_security_group.mmayr-k8s-nsg.id
}

resource "azurerm_network_interface" "k8s_master_nic" {
  name                = "k8s-master-nic-${count.index}"
  location            = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name = azurerm_resource_group.mmayr-k8s-rg.name
  count               = var.master_machines.count

  ip_configuration {
    name                          = "mmayr-k8s-ipconfig"
    subnet_id                     = "/subscriptions/619b068f-9bf3-474c-887a-9dbec6ba6e51/resourceGroups/sre/providers/Microsoft.Network/virtualNetworks/sre-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = length(azurerm_public_ip.master-ip.*.id) > 0 ? element(concat(azurerm_public_ip.master-ip.*.id, tolist([])), count.index) : ""
  }
}

resource "azurerm_public_ip" "master-ip" {
  name                = "k8s-master-ip-${count.index}"
  count               = var.master_machines.count
  location            = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name = azurerm_resource_group.mmayr-k8s-rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "worker-ip" {
  name                = "k8s-worker-ip-${count.index}"
  count               = var.worker_machines.count
  location            = azurerm_resource_group.mmayr-k8s-rg.location
  resource_group_name = azurerm_resource_group.mmayr-k8s-rg.name
  allocation_method   = "Dynamic"
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
    sku       = "18_04-lts-gen2"
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
    public_ip_address_id          = length(azurerm_public_ip.worker-ip.*.id) > 0 ? element(concat(azurerm_public_ip.worker-ip.*.id, tolist([])), count.index) : ""


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
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_key)
  }
}