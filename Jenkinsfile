pipeline {
  agent {
    docker { image 'danbuk/drone-terraform:0.11.8-0.0.3' }
  }

  stages {
    stage('Install dependencies') {
      steps {
        sh 'npm ci'
      }
    }
    stage('Integration Test') {
      steps {
        sh 'npm run test'
      }
    }
    stage('Acceptance Test') {
      steps {
        sh 'npm run acceptance'
      }
    }
    stage('Deploy Dev') {
      steps {
        sh './build.sh deploy dev'
      }
    }
  }
}