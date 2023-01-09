variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "private_snet_alb_a_cidr_block" {
  default = "10.0.31.0/24"
}

variable "private_snet_alb_b_cidr_block" {
  default = "10.0.32.0/24"
}

variable "private_snet_alb_c_cidr_block" {
  default = "10.0.33.0/24"
}

variable "private_snet_app_a_cidr_block" {
  default = "10.0.11.0/24"
}

variable "private_snet_app_b_cidr_block" {
  default = "10.0.12.0/24"
}

variable "private_snet_app_c_cidr_block" {
  default = "10.0.13.0/24"
}
