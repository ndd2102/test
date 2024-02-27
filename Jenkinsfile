pipeline {
  agent none
  stages {
    stage('SonarQube Analysis') {
      agent {label "window_20_dev"}
      steps{
        def scannerHome = tool 'SonarScanner';
        withSonarQubeEnv() {
          bat "${scannerHome}/bin/sonar-scanner"
          }
        }
      }
    stage("Quality Gate") {
      agent {label "window_20_dev"}
      steps{
        timeout(time: 1, unit: 'HOURS') {
          def qg = waitForQualityGate()
          if (qg.status != 'OK') {
            error "Pipeline aborted due to quality gate failure: ${qg.status}"
          }
        }
      }
    }
    stage('Build/push image') {
      agent {label "window_20_dev"}
      steps{
          bat "docker build -t nddung2102/react-app ."
        }
      steps{
        withDockerRegistry(credentialsId: 'dockerhub', url: "") {
          bat "docker push nddung2102/react-app "
        }
      }
    }
    // stage('Deploying to Kubernetes') {
    //   agent {label "APS"}
    //   steps {
    //       sh "kubectl apply -f deployment.yml"
    //       sh "kubectl apply -f service.yml"
    //     }
    //   }
  }
}