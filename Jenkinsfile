pipeline {
  agent none
  stages {
    stage('Build/push image') {
      agent {label "window_20_dev"}
      steps{
        withDockerRegistry(credentialsId: 'dockerhub', url: "") {
          bat "docker build -t react-app ."
          bat "docker push nddung2102/react-app "
        }
      }
    }
    stage('Deploying React.js container to Kubernetes') {
      agent {label "APS"}
      steps {
          kubernetesDeploy(configs: "deployment.yaml", 
                                         "service.yaml")
        }
      }
  }
}