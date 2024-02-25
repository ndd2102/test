pipeline {
  agent none
  stages {
    stage('Build image') {
      agent {label "windown 20 dev"}
      steps{
          sh "docker build -t react-app ."
        }
    }
    stage('Pushing Image') {
      agent {label "windown 20 dev"}
      steps{
          sh "docker push nddung2102/react-app "
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