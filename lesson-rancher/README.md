# Lesson: Rancher
In this lesson, we'll configure a virtual machine on Google Compute Engine to run the Rancher master, and a Rancher agent. We'll deploy a simple application on Rancher, and demonstrate Rancher Catalog by installing an Elasticsearch cluster on our Rancher platform.

Run the following commands on Google Cloud Shell to create the Virtual Machine and firewall rule:
```
gcloud beta compute instances create "rancher" --zone "us-east1-b" --machine-type "custom-1-8192-ext" --subnet "default" --maintenance-policy "MIGRATE" --no-service-account --no-scopes --min-cpu-platform "Automatic" --tags "rancher" --image "coreos-alpha-1576-1-0-v20171026" --image-project "coreos-cloud" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "rancher"

gcloud compute firewall-rules create rancher-test --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules="tcp:8000,tcp:8080,tcp:9000" --source-ranges=0.0.0.0/0 --target-tags=rancher
```

Then, SSH into the server with the following command:
```
gcloud compute ssh rancher
```

And run the Rancher server:
```
docker run -d -p 8080:8080 rancher/server
```

Finally, you will need to run the Rancher node startup command on the Rancher server. You will get this command when you add a host in the Rancher web interface.

After you have finished testing, run the following command on Google Cloud Shell to terminate the virtual machine:
```
gcloud compute instances delete rancher
```

