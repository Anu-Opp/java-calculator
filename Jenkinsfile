pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "anuopp/java-calculator:${BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "🔨 Building Docker image: ${DOCKER_IMAGE}"
                    sh "docker build -t ${DOCKER_IMAGE} JavaWeb3"
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

        stage('Deploy Container') {
            steps {
                script {
                    echo "🚀 Deploying ${DOCKER_IMAGE} on port 8080"
                    // Stop existing container on port 8080
                    sh '''
                        existing=$(docker ps -q --filter publish=8080)
                        if [ ! -z "$existing" ]; then
                            echo "Stopping existing container on port 8080"
                            docker stop $existing
                        fi
                    '''
                    // Run new container
                    sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs for details."
        }
        always {
            echo "📦 Jenkins pipeline finished."
        }
    }
}
