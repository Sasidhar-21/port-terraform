module "vpc" {
  #source = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/com-tf-modules/network/vpc?ref=v0.1"
  source = "../resources/vpc"
  env     = "${local.env}"
  project = "${local.project}"
  vpc_name = "${local.env}-${var.vpc_name}"
  vpc_cidr = var.vpc_cidr
  az_list = ["us-east-1a"]
  #single_nat_gw = true
  common_tags = local.common_tags
}

# module "comm_sg" {
#   source      = "../resources/com-sg"
#   env         = local.env
#   project     = local.project
#   common_tags = local.common_tags
#   vpc_id      = module.vpc.vpc_id
# }

# module "ec2" {
#   depends_on = [module.vpc,module.ec2_sg]
#   source        = "../resources/ec2"
#   project       = local.project
#   env           = local.env
#   instance_type = var.instance_type
#   disk_size     = "30"
#   vpc_id        = module.vpc.vpc_id
#   subnet_id =  module.vpc.public_subnet_ids
#   #subnet_id = ${data.aws_subnet.subnet.*.id}
#   common_tags     = local.common_tags
#   security_groups = [module.ec2_sg.sg_id, module.comm_sg.sg_id]
#   ec2_ami         = var.ec2_ami
#   key_name        = var.key_name
# }

# module "ec2_sg" {
#   source      = "../resources/ec2_sg"
#   project     = local.project
#   env         = local.env
#   common_tags = local.common_tags
#   vpc_id      = module.vpc.vpc_id
# }




# # module "environment" {
# #   source = "../resources/enviornment"
# #   env     = "${local.env}"
# #   project = "${local.project}"
# #   common_tags = local.common_tags
# # }
