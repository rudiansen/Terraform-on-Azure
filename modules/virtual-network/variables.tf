variable "virtual_network_name" {
  type = string
  description = "Name of the virtual network"
}

variable "resource_group_name" {
  type = string
  description = "Resource group name of the virtual network"
}

variable "virtual_network_address_space" {
  type = list(string)
  description = "Address space of the virtual network"
}

variable "location" {
  type = string
  description = "Location of the virtual network"
}

variable "subnet_name" {
  type = string
  description = "Name of the subnet"
}

variable "subnet_address_prefixes" {
  type = list(string)
  description = "Address prefixes of the subnet"
}