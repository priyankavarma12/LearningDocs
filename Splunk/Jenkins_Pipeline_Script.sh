pipeline {
    agent any
 	stages {
 		stage('Compile Stage') {
 		steps {
 
 withMaven(maven:'M3'){
     echo 'Started Compile Stage...';
 echo "PATH = ${PATH}"
 echo "M2_HOME = ${M2_HOME}"
     bat "mvn clean"
 }
 }
 }
 
 stage('Test Stage') {
 steps {
 
 withMaven(maven:'M3'){
     echo 'Started Test Stage...'
     bat "mvn test"
 }
 }
 }
 
 stage('Build Artifact Stage') {
 steps {
 withMaven(maven:'M3'){
 echo 'Started Build Artifact Stage...'
 bat "mvn install"
 }
 }
 }
 
 stage('Copy Artifact to Deployment Location') {
 steps {
 bat("xcopy \"C:\\Program Files (x86)\\Jenkins\\workspace\\library-service-pipeline\\target\\library-service-0.0.1-SNAPSHOT.jar\" C:\\Deployment\\library-service")
 }
 }
 
 }
}
