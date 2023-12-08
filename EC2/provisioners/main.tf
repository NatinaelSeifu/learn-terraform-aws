#terraform {
#  required_providers {
#    aws = {
#      source = "hashicorp/aws"
#      version = "5.20.0"
#    }
#   
#  }
#}


# provider "aws" {}


module "provisioning" {
  source = "./../modules/ec2_basics/"
  ami_id = "ami-00a9282ce3b5ddfb1"
  instance_type = "t2.micro"
  keypair01 = "N_Keypair"
  instance_tag = "tf-server"
  
}


#  resource "aws_instance" "provisioners" {
#  ami           = module.provisioning.ami_id
#  instance_type = module.provisioning.outputs.instance_type
#  key_name      = module.provisioning.outputs.keypair01
#  tags          = { Name = module.provisioning.outputs.instance_tag }
#
#  provisioner "local-exec" {
#    command    = "echo The server's IP address is ${self.public_ip}"
#    on_failure = continue
#  }
#
#  connection {
#    type        = "ssh"
#    user        = "ec2-user"
#    private_key = file("/home/nati/Videos/${module.provisioning.keypair01}.pem")
#    host        = self.public_ip
#  }
#
#  provisioner "file" {
#    source      = "./docker.sh"
#    destination = "/tmp/docker.sh"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/docker.sh",
#      "/tmp/docker.sh args",
#    ]
#  }
#}