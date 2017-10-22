# Lesson: Terraform
In this lesson, we are provisioning a load balancer and two web servers in nginx.

## To see what changes would be done
```
terraform plan -var 'aws_access_key=ACCESS_KEY_HERE' -var 'aws_secret_key=SECRET_KEY_HERE'
```

## To apply the changes
```
terraform apply -var 'aws_access_key=ACCESS_KEY_HERE' -var 'aws_secret_key=SECRET_KEY_HERE'
```

## To destroy all Terraform-managed infrastructure
```
terraform destroy -var 'aws_access_key=ACCESS_KEY_HERE' -var 'aws_secret_key=SECRET_KEY_HERE'
```
