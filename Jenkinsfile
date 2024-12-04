pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'apache-t16'    
        DOCKER_TAG = 'latest'          
        REGISTRY = 'cr.yandex/crpvem9c0799ctn25n8t' 

        APACHE_CONTAINER_NAME = 'apache'
        NGINX_CONTAINER_NAME = 'nginx'

        APACHE_IP = '158.160.73.86'
        APACHE_PORT = '8085'

        NGINX_IP = ''
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: '5993ba5d-138a-4314-a8ca-507961cd0286', url: 'git@github.com:SaiTeR/apache-image-task16.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    sh 'docker tag apache-t16 cr.yandex/crpvem9c0799ctn25n8t/apache:latest'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh 'docker push cr.yandex/crpvem9c0799ctn25n8t/apache:latest'
                }
            }
        }


        stage('Deploy to VM') {
            steps {
                script {
                    sshagent(['5993ba5d-138a-4314-a8ca-507961cd0286']) {
                        sh """
                        ssh ubuntu@${env.APACHE_IP} << EOF

                        echo "Stopping and removing old container..."
                        docker stop ${env.APACHE_CONTAINER_NAME} || true
                        docker rm ${env.APACHE_CONTAINER_NAME} || true

                        echo "Removing old image..."
                        docker rmi ${env.REGISTRY}/apache:latest || true

                        echo "Pulling new image..."
                        docker pull ${env.REGISTRY}/apache:latest

                        echo "Running new container..."
                        docker run -d --name ${env.APACHE_CONTAINER_NAME} -p ${env.APACHE_PORT}:${env.APACHE_PORT} -e PORT=${env.APACHE_PORT} ${env.REGISTRY}/apache:latest
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Очистка рабочей директории после сборки
        }
    }
}
