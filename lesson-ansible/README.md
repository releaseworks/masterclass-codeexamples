# Lesson: Ansible
In this lesson, we'll use Ansible to launch an EC2 instance, configure Docker on it, and run the Hellonode Docker image.

To begin, configure your AWS API keys:
```
aws configure
```

Then, run the playbook:
```
ansible-playbook deploy-hellonode.yml
```

You can see the application is listening on port 8000 of the EC2 instance IP. You can find the EC2 instance IP under "PLAY RECAP" of the Ansible playbook output.

Finally, terminate the EC2 instance:
```
ansible-playbook -e server_count=0 deploy-hellonode.yml
```