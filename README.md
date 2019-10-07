# terraform-atlas
Sample code to deploy MongoDB Atlas clusters using the Terraform [MongoDB Atlas Provider](https://www.terraform.io/docs/providers/mongodbatlas/index.html)

Clone this repository
```
$ git clone https://github.com/wbleonard/terraform-atlas.git
```

Add a `terraform.tfvars` file with your Atlas API key values:
```
mongodb_atlas_api_public_key = "gzwmxxxx"
mongodb_atlas_api_private_key = "0393d504-xxxx-4bda-xxxx-5564430xxxxx"
```
 
Initialize the MongoDB Atlas Provider
```
$ terraform init
```

Apply
```
$ terraform apply
```

View
```
$ terraform show
```
