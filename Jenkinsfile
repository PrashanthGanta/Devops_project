pipeline {
  environment {
    imagename = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${BUILD_NAME}"
    BUILD_NAME = 'devops-project-node-app'
    IMAGE_TAG = "$BUILD_NUMBER"
    AWS_DEFAULT_REGION = "us-east-1"
    AWS_ACCOUNT_ID="350465793522"
    dockerRun = "docker run -p 8080:8081 -d --name node-app $imagename:$IMAGE_TAG"
    dockerKill= "docker rm -f node-app"

  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/PrashanthGanta/Devops_project_sampleNode_app.git', branch: 'develop', credentialsId: 'PrashanthGanta-github-token'])

      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${imagename}:${IMAGE_TAG}"
        }
      }
    }
    
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                sh "docker push ${imagename}:${IMAGE_TAG}"
         }
        }
      }

    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$IMAGE_TAG"
      }
    }

      stage('Run Container on Dev Server'){
        steps{
          sshagent(['d08c0287-ec43-4b7f-8591-f5cb34a88ba7']) {
          sh "ssh -o StrictHostKeyChecking=no ubuntu@34.234.73.215 ${dockerKill}"
          sh "ssh -o StrictHostKeyChecking=no ubuntu@34.234.73.215 ${dockerRun}"
         }
     }
   }

  }
}