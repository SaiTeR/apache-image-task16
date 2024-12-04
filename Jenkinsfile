pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'apache-t16'    // Имя собранного Docker-образа
        DOCKER_TAG = 'latest'          // Тег для образа
        REGISTRY = 'cr.yandex/crpvem9c0799ctn25n8t'  // Адрес вашего контейнерного реестра
    }

    stages {
        stage('Checkout') {
            steps {
                // Скачиваем репозиторий с GitHub, используя SSH credentials
                git credentialsId: '5993ba5d-138a-4314-a8ca-507961cd0286', url: 'git@github.com:SaiTeR/apache-image-task16.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Собираем Docker-образ из Dockerfile в репозитории
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Присваиваем тег собранному Docker-образу
                    docker.tag("${DOCKER_IMAGE}", "${REGISTRY}/apache:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Отправляем тегированный Docker-образ в контейнерный реестр
                    docker.push("${REGISTRY}/apache:${DOCKER_TAG}")
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
