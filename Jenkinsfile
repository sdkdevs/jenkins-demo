// Jenkinsfile
String prodCredentials = 'AWS_CREDENTIALS_PROD'
String devCredentials = 'AWS_CREDENTIALS_DEV'

pipeline {
    agent any
    stages {
        stage('Checkout - Source Code') {
            steps { 
                cleanWs()
                checkout scm
                echo 'Hello World'
            }
        }
        stage("Terraform Init"){
            when {
                branch 'dev'
            }
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: devCredentials,accessKeyVariable: 'AWS_ACCESS_KEY_ID',secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh '''
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        export AWS_REGION=eu-central-1

                        make init ENV=dev
                        '''
            }
            }
        }
    }
}