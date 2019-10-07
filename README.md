# Provision MongoDB Atlas Clusters using Terraform
Sample code to deploy MongoDB Atlas clusters using the Terraform [MongoDB Atlas Provider](https://www.terraform.io/docs/providers/mongodbatlas/index.html).

Clone this repository
```
$ git clone https://github.com/wbleonard/terraform-atlas.git
```

Add a `terraform.tfvars` file with the following values:
```
mongodb_atlas_api_public_key = "<API Public Key>"
mongodb_atlas_api_private_key = "<API Priviate Key>
org_id="<Atlas Org Id">
project_name="<Desired Project Name>"
database_username = "<Database User Name>"
database_user_password = "<Database User Password>"
whitelist_ip = "<Whitelist IP>"
whitelist_ip_desc = "<Whitelist IP Description>"
```

Initialize the MongoDB Atlas Provider
```
$ terraform init
```

Apply your changes
```
$ terraform apply
```

View the current state
```
$ terraform show
```
