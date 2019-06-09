pipeline {
  agent any

  tools {nodejs "node"}

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
        sh 'apt-get install zip'
        sh './build.sh deploy dev'
      }
    }
  }
}