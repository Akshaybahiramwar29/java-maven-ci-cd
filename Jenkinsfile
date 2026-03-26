pipeline {
    tools {
        jdk 'myjava'
        maven 'mymaven'
    }
    agent none
    stages {
        stage('checkout') {
            agent any
            steps {
                git branch: 'main', url: 'https://github.com/Akshaybahiramwar29/java-maven-ci-cd.git'
            }
        }
        stage('Update Version') {
            agent any
            steps {
             sh """mvn versions:set -DnewVersion=1.0.${BUILD_NUMBER} 
                   mvn versions:commit"""
            }
        }
        stage('Compile') {
            agent any
            steps {
                sh 'mvn compile'
            }
        }
        stage('Test') {
            agent any
            steps {
                sh 'mvn test'
            }
        }
        stage('Sonar analysis') {
            agent any
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh'mvn sonar:sonar'
                }
            }
        }
        stage('Package') {
            agent any
            steps {
                sh 'mvn package'
            }
        }
        stage('Upload to Nexus') {
            agent any
            steps {
                sh 'mvn deploy'
            }
        }
        stage('Docker Build') {
            agent any
            steps {
              sh "docker build -t akshaybahiramwar/java-maven:1.0.${BUILD_NUMBER} ."
            }
        }
        stage('Docker Tag') {
            agent any
            steps {
            sh "docker tag akshaybahiramwar/java-maven:1.0.${BUILD_NUMBER} akshaybahiramwar/java-maven:latest"
            }
        }
        stage('Docker Login') {
            agent any
            steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
              sh 'echo $PASS | docker login docker.io -u $USER --password-stdin'
             }
        }
   }

         stage('Docker Push') {
             agent any
             steps {
             sh 'docker push akshaybahiramwar/java-maven:1.0.${BUILD_NUMBER}'
             sh 'docker push akshaybahiramwar/java-maven:latest'
             }
         }
         stage('Deploy to minikube') {
             agent any
           steps {
        sh """
        ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/ubuntu.pem ubuntu@54.173.58.114 "kubectl apply -f /home/ubuntu/deployment.yaml"
        
        ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/ubuntu.pem ubuntu@54.173.58.114 "kubectl apply -f /home/ubuntu/service.yaml"
        
        ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/ubuntu.pem ubuntu@54.173.58.114 "kubectl get pods"
        """
           }
        }
    }
}
