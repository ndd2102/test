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
            script {
              def qg = waitForQualityGate()
              timeout(time: 1, unit: 'HOURS') {
                if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
                }
              }
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