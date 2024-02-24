pipeline {
  agent {label "APS"}
  stages {
    stage('Build image') {
      steps{
          sh "docker built -t react-app ."
        }
    }
    stage('Pushing Image') {
      steps{
          sh "docker push nddung2102/react-app "
        }
    }
    stage('Deploying React.js container to Kubernetes') {
      steps {
          kubernetesDeploy(configs: "deployment.yaml", 
                                         "service.yaml")
        }
      }
  }
}