# Variables we need for this Terraform run. Set them in variables.tf
variable "api_public_key" { default="" }
variable "api_private_key" { default="" }
variable "org_id" { default="" }

variable "project_name" { default="Terraform" }
variable "database_username" { default = "terraform" }
variable "database_user_password" { default = "terraform" }
variable "whitelist_ip" { default = "0.0.0.0" }
variable "whitelist_ip_desc" { default = "Added by Terraform" }

#
# Configure the MongoDB Atlas Provider
#
provider "mongodbatlas" {
  public_key = var.api_public_key
  private_key  = var.api_private_key
}

#
# Create a Project 
#
resource "mongodbatlas_project" "my_project" {
  name 			= var.project_name
  org_id		= var.org_id
}

#
# Create a Cluster
#
resource "mongodbatlas_cluster" "test" {
  project_id   = mongodbatlas_project.my_project.id
  name         = "test"
  num_shards   = 1

  replication_factor           = 3
  backup_enabled               = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.0"

  //Provider Settings "block"
  provider_name               = "GCP"
  disk_size_gb                = 40
  provider_instance_size_name = "M30"
  provider_region_name        = "US_EAST_4"
}

#
# Create a Database User
#
resource "mongodbatlas_database_user" "test" {
  username 		= "${var.database_username}"
  password 	 	= "${var.database_user_password}"
  project_id            = "${mongodbatlas_project.my_project.id}"
  database_name	 	= "admin"

  roles {
    role_name     	= "readWriteAnyDatabase"
    database_name 	= "admin"
  }
}

#
# Create an IP Whitelist
#
resource "mongodbatlas_project_ip_whitelist" "test" {
  project_id            = "${mongodbatlas_project.my_project.id}"  
  whitelist {  
    ip_address 		= var.whitelist_ip
    comment    		= var.whitelist_ip_desc
  }
}

