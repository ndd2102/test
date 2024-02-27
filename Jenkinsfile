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
        stage('Build/push image') {
          steps{
            withDockerRegistry(credentialsId: 'dockerhub', url: "") {
              bat "docker build -t nddung2102/react-app ."
              bat "docker push nddung2102/react-app "
            }
          }
        }
      }
    }
    stage('Scan and deploying image') {
      agent {label "Dev_MKSmart"}
      steps {
          sh 'echo "docker.io/exampleuser/examplerepo:latest `pwd`/Dockerfile" > anchore_images'
          anchore name: 'anchore_images'
          // sh "kubectl apply -f deployment.yml"
          // sh "kubectl apply -f service.yml"
      }
    }
  }
}