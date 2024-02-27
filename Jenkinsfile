pipeline {
  agent none
  stages {
    stage('Build and scan') {
      agent {label "window_20_dev"}
      stages{
        stage ('SonarQube Analysis') {
           environment {
              def scannerHome = tool 'SonarScanner'
            }
          steps {
            withSonarQubeEnv('sonarqube') {
              bat "${scannerHome}/bin/sonar-scanner"
            }
          }
        }
        stage("Quality Gate") {
          steps{
            timeout(time: 5, unit: 'MINUTES') {
              waitForQualityGate abortPipeline: true
            }
          }
        }         
        stage('Build image') {
          steps{
            bat "docker build -t nddung2102/react-app ."
          }
        }
        stage('Push and scan image') {
          steps{
            withDockerRegistry(credentialsId: 'dockerhub', url: "") {
              bat "docker push nddung2102/react-app "
            }
            bat 'echo "docker.io/nddung2102/react-app:latest `pwd`/Dockerfile " > anchore_images'
            anchore name: 'anchore_images'
          }
        }
      }
    }
    stage('Deploying to Kubernetes') {
      // agent {label "APS"}
      steps {
          // sh "kubectl apply -f deployment.yml"
          // sh "kubectl apply -f service.yml"
          echo "test"
      }
    }
  }
}