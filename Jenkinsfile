pipeline {
    agent {
        docker {
            image 'docker:20.10.16'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
            reuseNode true
        }
    }

    options {
        skipDefaultCheckout()
    }

    environment {
        DOCKER_IMAGE = "anuopp/java-calculator:${BUILD_NUMBER}"
        DOCKERHUB_CREDENTIALS_ID = "dockerhub" // Update if your ID is different
    }

    stages {
        stage('Checkout Source') {
            steps {
                echo '📥 Cloning source code from GitHub...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🔨 Building Docker image: ${DOCKER_IMAGE}"
                    sh 'ls -la' // optional: verify files
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "📤 Pushing Docker image to Docker Hub..."
                    withDockerRegistry([url: 'https://index.docker.io/v1/', credentialsId: "${DOCKERHUB_CREDENTIALS_ID}"]) {
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
                            echo "🛑 Stopping container already using port 8080: $existing"
                            docker stop $existing
                            docker rm $existing
                        fi
                    '''
                    sh "docker run -d --name java-app-${BUILD_NUMBER} -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment complete: App running on http://localhost:8080"
        }
        failure {
            echo "❌ Pipeline failed. Check logs above for errors."
        }
    }
}

