pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Sarvnoor-kaur/jenkins-docker-aws'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh "docker build -t shophub-app ."
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    sh "docker stop shophub || true"
                    sh "docker rm shophub || true"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh "docker run -d --name shophub -p 80:80 shophub-app"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed 🚀"
        }
    }
}