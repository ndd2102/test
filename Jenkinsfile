pipeline {
  agent none
  stages {
    stage('Build/push image') {
      agent {label "window_20_dev"}
      steps{
        withDockerRegistry(credentialsId: 'dockerhub', url: "") {
          bat "docker build -t nddung2102/react-app-1 ."
          bat "docker push nddung2102/react-app-1 "
        }
      }
    }
    stage('Deploying React.js container to Kubernetes') {
      agent {label "APS"}
      steps {
          sh "kubectl apply -f deployment.yml"
          sh "kubectl apply -f service.yml"
        }
      }
  }
}