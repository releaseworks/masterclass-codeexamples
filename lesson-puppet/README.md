# Lesson: Puppet
In this lesson, we are using Puppet to configure a server we're provisioning with Terraform.

See our Puppet code in environments/

## First, configure AWS credentials
```
aws configure
```

## To see what changes would be done
```
terraform plan
```

## To apply the changes
```
terraform apply
```

## To destroy all Terraform-managed infrastructure
```
terraform destroy
```
