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
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    echo "🚀 Deploying ${DOCKER_IMAGE} on port 8080"
                    sh '''
                        existing=$(docker ps -q --filter "publish=8080")
                        if [ ! -z "$existing" ]; then
                            echo "🛑 Stopping container using port 8080: $existing"
                            docker stop $existing
                        fi
                    '''
                    sh "docker run -d --name java-app-${BUILD_NUMBER} -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            echo "📦 Jenkins pipeline finished."
        }
        failure {
            echo "❌ Pipeline failed. Check the logs for details."
        }
    }
}

