variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "tfvmexample"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "Central India"
}

variable "username" {
  description = "The username for the machine."
  default     = "adminuser"
}

variable "password" {
  description = "The password for the machine."
  default     = "adminuserpassword"
}