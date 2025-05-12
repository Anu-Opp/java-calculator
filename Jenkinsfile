pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "anuopp/java-calculator:${BUILD_NUMBER}"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo "🔨 Building Docker image: ${DOCKER_IMAGE}"
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "📤 Pushing Docker image to Docker Hub"
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "🚀 Running container from ${DOCKER_IMAGE}"
                    // Stop any existing container with the same image (optional safety)
                    sh "docker ps -q --filter ancestor=${DOCKER_IMAGE} | xargs -r docker stop"
                    sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            echo "✅ Pipeline finished"
        }
    }
}

