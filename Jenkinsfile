pipeline {
  agent none
  stages {
    stage('Build/push image') {
      agent {label "window_20_dev"}
      steps{
        withDockerRegistry(credentialsId: 'dockerhub', url: "") {
          bat "docker build -t nddung2102-1/react-app ."
          bat "docker push nddung2102-1/react-app "
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