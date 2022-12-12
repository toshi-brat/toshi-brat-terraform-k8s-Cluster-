#############
# Local Varibale
#############

variable "environment" {
  description = "The envirenment of the Resources"
}
variable "buildby" {
  description = "Code Written By"
}

###############
# VPC Variables
###############
variable "cidr" {
  description = " The desired CIRD range of VPC"
}
variable "pub-snet" {
  description = "Desired Public Subnet Ranges"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "pri-snet" {
  description = "Desired Public Subnet Ranges"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}
variable "nat_required" {
  description = "Weather NAT is required in Private Subnet YES/NO "
}
variable "nat-pub-id" {
  description = "Public Subnet Name to Associate with NAT"
}

#############
# SG Varibale
#############
variable "sg_details" {
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({

      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      self            = bool
      security_groups = list(string)
    }))
  }))
}

####################
# Instance Variables
####################
variable "ami" {
  description = "desired ami id"
}
variable "instance_type" {
  description = " desired instance type"
  validation {
    condition     = can(regex("^[Tt][2].[micro]", var.instance_type))
    error_message = "Invalid Instance type can be only t2.micro"
  }
}
variable "key-pair" {
  description = "name of the key to ssh into instance"
}

#  variable "instance" {
#     type = map(object({
#     pub-id = string
#   }))
# }

################
# DNS Variables
################

# variable "domain_name" {
#   description = "Desired Private Hosted Zone Name"
#   type = string
# }