pipeline {

    agent any

    environment {
        AWS_REGION    = 'eu-north-1'
        EKS_CLUSTER   = 'project1'

        ECR_REGISTRY   = '363267429195.dkr.ecr.eu-north-1.amazonaws.com'
        ECR_REPOSITORY = 'devopsproject/ci-cdpipelineautomation'

        IMAGE_NAME = "${ECR_REGISTRY}/${ECR_REPOSITORY}"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    echo "Building Docker image..."

                    docker build \
                        -t ${IMAGE_NAME}:${IMAGE_TAG} \
                        .

                    docker tag \
                        ${IMAGE_NAME}:${IMAGE_TAG} \
                        ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Trivy Security Scan') {
            steps {
                sh '''
                    echo "Scanning Docker image with Trivy..."

                    trivy image \
                        --severity HIGH,CRITICAL \
                        --exit-code 0 \
                        ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('ECR Login') {
            steps {
                sh '''
                    echo "Logging in to Amazon ECR..."

                    aws ecr get-login-password \
                        --region ${AWS_REGION} | \
                    docker login \
                        --username AWS \
                        --password-stdin ${ECR_REGISTRY}
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                    echo "Pushing image to ECR..."

                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Update Kubernetes Manifest') {
            steps {
                sh '''
                    echo "Updating Kubernetes image tag..."

                    sed -i "s|image: ${IMAGE_NAME}:.*|image: ${IMAGE_NAME}:${IMAGE_TAG}|" \
                        k8s/deployment.yaml

                    echo "Updated Kubernetes image:"
                    grep "image:" k8s/deployment.yaml
                '''
            }
        }

        stage('Verify EKS Access') {
            steps {
                sh '''
                    echo "Verifying EKS cluster access..."

                    aws eks update-kubeconfig \
                        --region ${AWS_REGION} \
                        --name ${EKS_CLUSTER}

                    kubectl get nodes
                '''
            }
        }
    }

    post {

        always {
            sh '''
                docker logout ${ECR_REGISTRY} || true
            '''
        }

        success {
            echo 'CI pipeline completed successfully!'
        }

        failure {
            echo 'CI pipeline failed. Check the stage logs.'
        }
    }
}
