
module "aws" {
source = "./modules/aws"

}

module "jenkins" {
  source = "./modules/jenkins"
  
}

module "docker" {
  source = "./modules/docker"
  # Pass necessary variables
}

module "sonarqube" {
  source = "./modules/sonarqube"
  # Pass necessary variables
}

module "nexus" {
  source = "./modules/nexus"
  # Pass necessary variables
}

module "kubernetes" {
  source = "./modules/kubernetes"
  # Pass necessary variables
}
