pipeline {
  agent any

  tools {nodejs "node"}

  stages {
    stage('Install dependencies') {
      steps {
        sh 'npm install'
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
        sh './build.sh deploy'
      }
    }
  }
}