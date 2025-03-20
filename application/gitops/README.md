How to manage this to deploy/destroy the infrastructure?

We have three envs:
- dev
- prod

We have VPC's deployed for all three env.

* **STEP 1**
To deploy VPC, going to the folder and running the following commands:
 * `terraform init -backend-config ../boobud.hcl`

 * **STEP 2**
 Select the workspace:
 * `terraform workspace select dev-us-east-1`
If workspace doesnt exist create one:
 * `terraform workspace list`
 * `terraform workspace new dev-us-east-1`
 * `terraform workspace new admin-us-east-1`
 * `terraform workspace new prod-us-east-1`

  * **STEP 2**
To apply and if you want to destroy then replace apply with destroy: 
 * `terraform apply -var-file tfvars/dev-us-east-1.tfvars`
 * `terraform apply -var-file tfvars/admin-us-east-1.tfvars`
 * `terraform apply -var-file tfvars/prod-us-east-1.tfvars`

To destroy:
 * `terraform destroy -var-file tfvars/dev-us-east-1.tfvars`  
