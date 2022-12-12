####### GLOBAL TAG VALUES #######
environment = "DEV"
buildby     = "Tushar"

####### VPC DETAILS #######
cidr = "10.0.0.0/20"
#availability_zones = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
nat_required = "false"
nat-pub-id   = "s1"
pub-snet = {
  s1 = {
    cidr_block        = "10.0.0.0/23"
    availability_zone = "ap-southeast-1a"
  },
  s2 = {
    cidr_block        = "10.0.2.0/23"
    availability_zone = "ap-southeast-1b"
  }
  s3 = {
    cidr_block        = "10.0.4.0/22"
    availability_zone = "ap-southeast-1c"
  }
}
pri-snet = {
  ps1 = {
    cidr_block        = "10.0.8.0/23"
    availability_zone = "ap-southeast-1a"
  },
  ps2 = {
    cidr_block        = "10.0.10.0/23"
    availability_zone = "ap-southeast-1b"
  }
  ps3 = {
    cidr_block        = "10.0.12.0/22"
    availability_zone = "ap-southeast-1c"
  }
}

####### SECURITY GROUP DETAILS ######
sg_details = {
  "web-server" = {
    description = "httpd inbound"
    name        = "web-server"
    ingress_rules = [
      {
        cidr_blocks     = ["0.0.0.0/0"]
        from_port       = 6443
        protocol        = "tcp"
        self            = null
        to_port         = 6443
        security_groups = null
      },
      {
        cidr_blocks     = ["0.0.0.0/0"]
        from_port       = 22
        protocol        = "tcp"
        self            = null
        to_port         = 22
        security_groups = null
      },
    ]
  },
  "mysql-sg" = {
    description = "mysql communication"
    name        = "mysql-sg"
    ingress_rules = [
      {
        cidr_blocks     = ["0.0.0.0/0"]
        from_port       = 3306
        protocol        = "tcp"
        self            = null
        to_port         = 3306
        security_groups = null
  }] },
  "docker-sg" = {
    description = "docker swarm"
    name        = "docker-sg"
    ingress_rules = [
      {
        cidr_blocks     = ["0.0.0.0/0"]
        from_port       = 2377
        protocol        = "tcp"
        self            = null
        to_port         = 2377
        security_groups = null
  }] }

}

####### INSTANCE DETAILS ######
ami           = "ami-07651f0c4c315a529"
instance_type = "t2.micro"
key-pair      = "key-nv-pair"

####################
# DNS Variables
####################

# domain_name = "example.com"