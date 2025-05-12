pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "anuopp/java-calculator:${BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }
}
