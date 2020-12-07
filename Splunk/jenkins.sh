pipeline {

    agent any

   

    stages {

        stage('Checkout') {

            steps {

                script{

                  checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], gitTool: 'git', submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: '']]])

                }

            }

        }

        stage('Test') {

          

            steps {

               sh "bash appinspect.sh -u  -p  -l . -a "

            }

        }

        stage('Build') {

            steps {

               sh "tar --exclude='local' --exclude='.DS_Store' -cvf testapp.tar.gz testapp"

            }

        }

    }

    post {

        success {

            archiveArtifacts artifacts: 'testapp.tar.gz,report.html', fingerprint: true

        }

    }   

}

