variable "vpc_cidr" {
  description = "VPC_CIDR"
  type        = string

}


variable "public_subnets" {
  description = "public_subnets"
  type        = list(string)

}


variable "instance_type" {
  description = "instance"
  type        = string
}
