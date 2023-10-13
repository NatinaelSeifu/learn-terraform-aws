variable "terrform_bucket" {
    type = string
    
  }

  module "firewall" {
  source = "./simple bucket"

  location = var.location
}