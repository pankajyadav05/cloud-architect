pipeline {
    agent none

    environment {
        DOCKER_IMAGE_NAME = "your-app"
        DOCKER_REGISTRY = "your.docker.registry.com"
        DOCKER_REGISTRY_CREDENTIALS = credentials('docker-registry-credentials')
    }

    stages {
        stage('Checkout') {
            agent any
            steps {
                git branch: 'main', url: 'https://github.com/your-org/your-repo.git'
            }
        }

        stage('Build') {
            agent { docker { image 'node:20' } }
            steps {
                sh 'npm install'
                sh 'npm run build'
                stash includes: 'build/**', name: 'app'
            }
        }

        stage('Test') {
            agent { docker { image 'node:20' } }
            steps {
                unstash 'app'
                sh 'npm run test'
            }
        }

        stage('Docker Build') {
            agent any
            steps {
                unstash 'app'
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", DOCKER_REGISTRY_CREDENTIALS) {
                        def customImage = docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_ID}", "-f Dockerfile .")
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy') {
            agent any
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", DOCKER_REGISTRY_CREDENTIALS) {
                        sh """
                            docker pull ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${env.BUILD_ID}
                            docker stop ${DOCKER_IMAGE_NAME} || true
                            docker rm ${DOCKER_IMAGE_NAME} || true
                            docker run --name ${DOCKER_IMAGE_NAME} -p 80:80 -d ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${env.BUILD_ID}
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}