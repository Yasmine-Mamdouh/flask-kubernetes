pipeline {
    agent any

    environment {
        IMAGE_NAME = "yasminemamdouh/iti-flask-task"
        IMAGE_TAG = "latest"
        DEPLOYMENT_FILE = "k8s/deployment.yaml"
        KUBECONFIG_PATH = "/var/lib/jenkins/.kube/config"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "📦 Cloning GitHub Repo..."
                git branch: 'main', url: 'https://github.com/Yasmine-Mamdouh/flask-kubernetes.git'
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
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh """
                            echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                            docker push $IMAGE_NAME:$IMAGE_TAG
                        """
                    }
                }
            }
        } // ← دي كانت ناقصة

        stage('Deploy to K3s') {
            steps {
                echo "🌐 Deploying to K3s..."
                script {
                    withEnv(["KUBECONFIG=${KUBECONFIG_PATH}"]) {
                        sh "kubectl apply -f ${DEPLOYMENT_FILE}"
                    }
                }
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
