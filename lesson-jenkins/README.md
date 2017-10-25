# Lesson: Jenkins
In this lesson, we will be configuring a Continuous Integration pipeline in Jenkins to build a Hello Node Docker image whenever there's a commit to the code repository.

This directory includes a `Jenkinsfile` with specifications of the build pipeline, a `Dockerfile` for building the Docker image, and the application itself.

## To run Jenkins as a container
```
docker run -it -v /var/run/docker.sock:/var/run/docker.sock -p8080:8080 getintodevops/jenkins-withdocker:lts
```

Access the Jenkins user interface in http://localhost:8080

https://getintodevops.com
