# Lesson: Docker
In this lesson, we will be creating a Docker image with a very simple "Hello World" Node.js application.

This directory includes a `Dockerfile` for building a Docker image, and the application itself.

## To build the image
```
docker build -t hellonode .
```

## To run the image, mapping port 8000 to the host machine
```
docker run -i -t -p8000:8000 hellonode
```

https://getintodevops.com
