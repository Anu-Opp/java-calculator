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
                    echo "🚀 Deploying ${DOCKER_IMAGE} on port 8080"

                    // Stop any container already using port 8080
                    sh '''
                        existing=$(docker ps -q --filter "publish=8080")
                        if [ ! -z "$existing" ]; then
                          echo "🛑 Stopping container using port 8080: $existing"
                          docker stop $existing
                        fi
                    '''

                    // Run new container with unique name
                    sh "docker run -d --name java-app-${BUILD_NUMBER} -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            echo "✅ Pipeline completed: Build #${BUILD_NUMBER}"
        }
    }
}
