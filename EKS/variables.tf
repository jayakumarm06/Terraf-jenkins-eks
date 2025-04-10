variable "vpc_cidr" {
  description = "VPC_CIDR"
  type        = string

}


variable "public_subnets" {
  description = "public_subnets"
  type        = list(string)

}


variable "private_subnets" {
  description = "private_subnets"
  type        = list(string)

}
