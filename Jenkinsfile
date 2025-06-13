pipeline {
    agent any
    environment {
        HOST_PORT = '9125'
        CONTAINER_PORT = '9125'
        CONTAINER_NAME = 'springboot'
        IMAGE_NAME = 'my-spring-boot-app'
        IMAGE_TAG = 'latest'
        TARGET_DIR = 'D:\\Deployments\\SpringBoot'
        REPO = 'https://github.com/wicakson0/jenkins-practice.git'
        BRANCH_NAME = 'main'
        JARNAME = 'jenkinspractice-0.0.1-SNAPSHOT.jar'
        REGISTRY_ADDRESS = 'localhost:5000'
    }

    stages {
        stage('Checkout') {
            steps {
                 echo "Fetching Source Code From GIT:"
                 echo "=============================="
                 git branch: "${env.BRANCH_NAME}", url: "${env.REPO}"
            }
        }
        stage('build & test') {
            steps {
                echo "Building and Running Unit Test:"
                echo "==============================="
                chmod +x ./mvnw
                sh "./mvnw clean install"
            }
        }
        stage('build docker image') {
            when {
                expression {
                    currentBuild.result == null
                }
            }
            steps {
                echo "Building Docker Image:"
                echo "======================"
                sh "docker build -t ${env.IMAGE_NAME}:${env.IMAGE_TAG} ."
            }
        }
        stage('Push Docker Image to Repository') {
            steps{
                 sh "docker tag ${env.IMAGE_NAME}:${env.IMAGE_TAG} ${env.REGISTRY_ADDRESS}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                 sh "docker push ${env.REGISTRY_ADDRESS}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
            }
        }
        stage('Deploy Container') {
            steps{
                sh "docker pull ${env.REGISTRY_ADDRESS}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                sh "docker run -d -p ${env.CONTAINER_PORT}:${env.HOST_PORT} --name ${env.CONTAINER_NAME} ${env.REGISTRY_ADDRESS}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
            }
        }
    }
}
