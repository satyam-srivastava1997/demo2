provider "aws" {
  region     = "us-east-1"
}

module "vpc"{
source = "/home/ubuntu/newapp/modules/vpc"
}

module "ec2"{
source = "/home/ubuntu/newapp/modules/ec2"
subnet_id = module.vpc.subnet_id1
subnet_id2 = module.vpc.subnet_id2
security_group =[module.vpc.security_group]
}


module "elb"{
source = "/home/ubuntu/newapp/modules/classic_elb"
instance_id =[ module.ec2.instance_id, module.ec2.instance_id2]
subnet_id =[ module.vpc.subnet_id1, module.vpc.subnet_id2]
subnet_id2 = [module.vpc.subnet_id2]
security_group = [module.vpc.security_group]
}
