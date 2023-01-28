variable "vpc_cidr" {
  default = "10.9.0.0/16"
}

variable "project" {
  default = "christopher-portfolio"
}

variable "availability_zones_count" {
  type    = number
  default = 2
}

variable "subnet_cidr_bits" {
  type    = number
  default = 8
}