variable "resource_group_name" {
  description = "The name for a resource group where Azure resources will reside in"    
  default = "tailspin-space-game-rg"
}

variable "resource_group_location" {
  description = "The location for the resource group"    
  default = "southeastasia"
}

variable "tags" {
  type = map
  
  default = {
    Environment = "Tailspin-Space-Game"
    Division = "SSS"
  }
}