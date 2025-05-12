pipeline {
  agent any

  stages {
    stage('Build Docker Image') {
      steps {
        script {
          docker.build("anuopp/java-calculator")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          script {
            docker.withRegistry('', "${DOCKER_USER}:${DOCKER_PASS}") {
              docker.image("anuopp/java-calculator").push('latest')
            }
          }
        }
      }
    }
  }
}

