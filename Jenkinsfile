pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gitforce/cloud-architect"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/pankajyadav05/cloud-architect'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:latest").pull()
                    
                    docker.image("${DOCKER_IMAGE}:latest").inside {
                        try {
                            sh 'npm run test'
                        } catch (Exception e) {
                            echo "Test execution failed: ${e.getMessage()}"
                            throw e
                        }
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


