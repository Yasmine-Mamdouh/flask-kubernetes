pipeline {
    agent any

    environment {
        IMAGE_NAME = "yasminemamdouh/iti-flask-task"
        IMAGE_TAG = "v0.1"
        DOCKER_CREDENTIALS_ID = "dockerhub-creds"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "📦 Cloning GitHub Repo..."
                git 'https://github.com/Yasmine-Mamdouh/flask-kubernetes.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🔨 Building Docker image..."
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo "🚀 Pushing image to DockerHub..."
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        sh "docker push $IMAGE_NAME:$IMAGE_TAG"
                    }
                }
            }
        }

        stage('Deploy to K3s') {
            steps {
                echo "🌐 Deploying to K3s..."
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Please check logs!"
        }
    }
}
