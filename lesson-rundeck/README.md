# Lesson: Rundeck
To run the Rundeck Docker image locally:
```
docker run -p4440:4440 -e SERVER_URL=http://localhost:4440 getintodevops/rundeck
```

The Dockerfile for the above image is included in this directory.

Our automation script is in inline_script.txt. The full job definition of our example job is in CreateEnvironmentJobDefinition.yml.

https://getintodevops.com
