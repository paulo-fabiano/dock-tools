# Dockerfile dind-ci

This repository contains a Docker-in-Docker (DinD) image designed for CI/CD pipelines, specifically for Jenkins. It combines the ability to run Docker commands with built-in security scanning via Trivy.

## 🚀 Quick Start

You can pull the ready-to-use image directly from Docker Hub:

* Repository: [paulofabianoo/dind-ci](https://hub.docker.com/repository/docker/paulofabianoo/ci/general)

```bash
docker pull paulofabianoo/dind-ci:latest
```

## Packages

There are many packages instalead for this pipeline CI like:

* git
* curl

## Jenkins Integration

To use this image in your Jenkinsfile, you can define it as your agent. This is particularly useful for building images and scanning them in the same stage.

```groovy
pipeline {

    agent {
        docker { 
            image 'paulofabianoo/ci:latest'
        }
    }

    stages {
        stage('Security Scan') {
            steps {
                sh '''
                    trivy fs \
                    --scanners vuln,secret,config \
                    --severity HIGH,CRITICAL \
                    --ignore-unfixed \
                    --format template \
                    --template "@trivy/templates/html.tpl" \
                    --output report.html \
                    .
                '''
            }
        }
    }

}
```

# Contributing

Feel free to fork this repository or open an issue if you have suggestions for additional packages or trivy templates that would improve the CI experience.