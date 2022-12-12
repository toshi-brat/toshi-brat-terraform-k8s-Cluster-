variable "sg" {
  description ="security group to be attached to the instance"
}

variable "ami" {
  description= "desired ami id" 
}
variable "pub-id" {
    # type = map(object({
    # subnet_id = string
    # })  )
}
variable "instance_type" {
  description = " desired instance type"
  type = string
  
 
}

variable "key-pair" {
  description = "name of the key to ssh into instance"
}

variable "cluster_name" {
  
}

variable "worker_subnet_ids" {

}
variable "master_iam_instance_profile" {
  
}

variable "node_iam_instance_profile" {
  
}