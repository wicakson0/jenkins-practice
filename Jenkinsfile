pipeline {
    agent any

    environment {
        HOST_PORT        = '9125'
        CONTAINER_PORT   = '9125'
        CONTAINER_NAME   = 'springboot'
        IMAGE_NAME       = 'my-spring-boot-app'
        IMAGE_TAG        = 'latest'
        REPO             = 'https://github.com/wicakson0/jenkins-practice.git'
        BRANCH_NAME      = 'macos'
        JARNAME          = 'jenkinspractice-0.0.1-SNAPSHOT.jar'
        REGISTRY_ADDRESS = 'localhost:9000'
    }

    stages {
        stage('ServiceA') {
            steps {
                script {
                    /* ────── Clone & Test ────── */
                    echo "\nFetching Source Code From GIT:\n=============================="
                    git branch: BRANCH_NAME, url: REPO

                    echo "\nBuilding and Running Unit Test:\n================================"
                    sh 'chmod +x mvnw'
                    sh './mvnw clean install'   // akan set currentBuild.result = FAILURE kalau unit test gagal

                    /* ────── Conditional Deploy ────── */
                    if (currentBuild.result == null) {   // Build sukses
                        echo "\nBuilding Docker Image:\n======================"
                        sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                        sh "docker tag  ${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY_ADDRESS}/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker push ${REGISTRY_ADDRESS}/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker pull ${REGISTRY_ADDRESS}/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker run -d -p ${CONTAINER_PORT}:${HOST_PORT} --name ${CONTAINER_NAME} ${REGISTRY_ADDRESS}/${IMAGE_NAME}:${IMAGE_TAG}"
                    } else {
                        echo "⚠️  Maven build/unit test failed — skip Docker build & deploy."
                    }
                }
            }
        }
    }
}