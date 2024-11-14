locals {
  name   = "eks-project"
  domain = "lab.najiib.co.uk"
  region = "eu-west-2"

  tags = {
    Enviroment = "sandbox"
    Project    = "EKS Project"
    Owner      = "Najiib"
  }
}

