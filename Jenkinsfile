String prodCredentials = 'AWS_CREDENTIALS_PROD'
String devCredentials = 'AWS_CREDENTIALS_DEV'


try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

if (env.BRANCH_NAME == 'dev') {

  // Run terraform init
  stage('Initialize Terraform') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: devCredentials,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
        ansiColor('xterm') {
        sh 'export AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}'
        sh 'export AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}'
        echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
        sh 'make'
      }
    }
}
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}