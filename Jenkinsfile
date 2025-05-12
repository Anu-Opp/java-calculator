pipeline {
    agent {
        docker {
            image 'docker:20.10.16-dind'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_IMAGE = "anuopp/java-calculator:${BUILD_NUMBER}"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo "🔨 Building Docker image: ${DOCKER_IMAGE}"
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "📤 Pushing Docker image to Docker Hub"
                    withDockerRegistry([url: 'https://index.docker.io/v1/', credentialsId: 'dockerhub']) {
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy') {
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
            echo "✅ Pipeline completed: Build #${BUILD_NUMBER}"
        }
    }
}

