// Jenkinsfile
String prodCredentials = 'AWS_CREDENTIALS_PROD'
String devCredentials = 'AWS_CREDENTIALS_DEV'

pipeline{
    agent none
    stages{
        stage('checkout - source code'){
            step{
                cleanWs()
                checkout scm
            }
        }
    }
}