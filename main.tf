#
# Example main.tf used in MDBW 19 talk 
# Uses https://github.com/akshaykarle/terraform-provider-mongodbatlas
#
#  Variables we need for this terraform run
#  Normally want to put them in their own variables.tf file
#

variable "mongodb_atlas_api_pub_key" { default = ""}
variable "mongodb_atlas_api_pri_key" { default = "" }

variable "database_username" { default = "" }
variable "database_user_password" { default = "" }

variable "mongodb_atlas_whitelistip" { default = "" }

variable "mongodb_atlas_org_id" { default = ""}
variable "mongodb_atlas_project_id" { default = "" }

#
# Configure the MongoDB Atlas Provider
#
provider "mongodbatlas" {
  username = "${var.mongodb_atlas_api_pub_key}"
  api_key  = "${var.mongodb_atlas_api_pri_key}"
}

#
# Create a Cluster in 2 Regions
#
resource "mongodbatlas_cluster" "cluster" {
  name                  = "MDBW19-Class-Cluster3-TF"
  group                 = "${var.mongodb_atlas_project_id}"
  mongodb_major_version = "4.0"
  provider_name         = "AWS"
  region                = ""
  size                  = "M30"
  disk_size_gb		= 100
  backup		= false
  provider_backup       = true
  disk_gb_enabled       = false
  replication_factor    = 0

  replication_spec {
    region          = "US_WEST_1"
    priority        = 7
    read_only_nodes = 0
    analytics_nodes = 1
    electable_nodes = 3
  }

  replication_spec {
    region          = "US_EAST_1"
    priority        = 6
    read_only_nodes = 1
    analytics_nodes = 0
    electable_nodes = 2 
  }
}

#
# Create a Database User
#
resource "mongodbatlas_database_user" "test" {
  username = "${var.database_username}"
  password = "${var.database_user_password}"
  database = "admin"
  group    = "${var.mongodb_atlas_project_id}"

  roles {
    name     = "readWriteAnyDatabase"
    database = "admin"
  }
}

#
# Create an IP Whitelist
#
resource "mongodbatlas_ip_whitelist" "test" {
  group      = "${var.mongodb_atlas_project_id}"
  ip_address = "${var.mongodb_atlas_whitelistip}"
  comment    = "Added with Terraform"
}
