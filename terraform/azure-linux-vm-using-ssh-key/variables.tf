variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "linux_test"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "Central India"
}

variable "username" {
  description = "The username for the machine."
  default     = "adminlinux"
}