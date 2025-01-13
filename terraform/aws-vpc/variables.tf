variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR values"
  default     = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zone" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ap-south-1a", "ap-south-1b"]
}