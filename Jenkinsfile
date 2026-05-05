// pipeline {
//     agent any

//     stages {

//         stage('Checkout Code') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Sarvnoor-kaur/jenkins-docker-aws'
//             }
//         }

//         stage('Docker Build') {
//             steps {
//                 script {
//                     sh "docker build -t shophub-app ."
//                 }
//             }
//         }

//         stage('Stop Old Container') {
//             steps {
//                 script {
//                     sh "docker stop shophub || true"
//                     sh "docker rm shophub || true"
//                 }
//             }
//         }

//         stage('Run Container') {
//             steps {
//                 script {
//                     sh "docker run -d --name shophub -p 80:80 shophub-app"
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             echo "Pipeline completed 🚀"
//         }
//     }
// }





pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Sarvnoor-kaur/jenkins-docker-aws'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('sonar') {
                        sh """
                        sonar-scanner \
                        -Dsonar.projectKey=shophub \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://<SONARQUBE-EC2-IP>:9000 \
                        -Dsonar.login=${SONAR_TOKEN}
                        """
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 2, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t shophub-app ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh "docker stop shophub || true"
                sh "docker rm shophub || true"
            }
        }

        stage('Run Container') {
            steps {
                sh "docker run -d --name shophub -p 80:80 shophub-app"
            }
        }
    }

    post {
        always {
            echo "Pipeline completed 🚀"
        }
    }
}