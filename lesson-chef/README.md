# Lesson: Chef
In this lesson, we are extending the Terraform configuration we wrote earlier to use Chef for configuring two application servers behind our load balancer.

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
