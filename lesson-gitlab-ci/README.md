# Lesson: Gitlab CI
To begin, import the Hellonode project from Github into your Gitlab account. Make the project visibility public on Gitlab, and copy the included .gitlab-ci.yml file into the repository.

You will also need a Google Container Engine cluster with the name 'hellonode', and a Google Cloud Platform service account with access to the cluster. To pass the service account to Gitlab CI, you will need to create a Secret Variable with the name GCLOUD_AUTH, and the JSON contents of the service account private key file.

The included .gitlab-ci.yml will build a Hellonode Docker image, push it to the project registry on Gitlab, and then deploy the image onto the Google Container Engine cluster.
