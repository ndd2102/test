pipeline {
  agent none
  stages {
    stage('Build image') {
      agent {label "Mksmart"}
      steps{
          sh "docker built -t react-app ."
        }
    }
    stage('Pushing Image') {
      agent {label "Mksmart"}
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