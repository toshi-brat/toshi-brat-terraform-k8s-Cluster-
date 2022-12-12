 
data "cloudinit_config" "master_cloud_init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init-aws-kubernete-master.sh"
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/init-aws-kubernetes-master.sh", 
    { kubeadm_token = module.token.token, dns_name = "${var.cluster_name}.${var.hosted_zone}", ip_address = aws_eip.master.public_ip, cluster_name = var.cluster_name, addons = join(" ", var.addons), aws_region = var.aws_region, asg_name = "${var.cluster_name}-nodes", asg_min_nodes = var.min_worker_count, asg_max_nodes = var.max_worker_count, aws_subnets = join(" ", concat(var.worker_subnet_ids, [var.master_subnet_id])) } )
  }
} 
 resource "aws_instance" "master-node" {
  subnet_id = var.pub-id
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [var.sg]
  key_name = var.key-pair
  iam_instance_profile = var.master_iam_instance_profile
  user_data = data.cloudinit_config.master_cloud_init.rendered

 tags =  merge({
    # Envirenment = var.environment 
    # BuildBy = var.buildby
    
  })
 }
 
 resource "aws_launch_configuration" "nodes" {
  name_prefix          = "${var.cluster_name}-nodes-"
  image_id             = var.ami
  instance_type        = var.instance_type
  key_name             = var.key-pair
  security_groups = [var.sg]
  iam_instance_profile = var.node_iam_instance_profile
 }

resource "aws_autoscaling_group" "nodes" {
  vpc_zone_identifier  = var.worker_subnet_ids
  name                 = "${var.cluster_name}-nodes"
  max_size             = "2"
  min_size             = "2"
  desired_capacity     = "2"
  launch_configuration = aws_launch_configuration.nodes.name

  tags = concat(
    [{
      key                 = "kubernetes.io/cluster/${var.cluster_name}"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "${var.cluster_name}-node"
      propagate_at_launch = true
    }])

}

  