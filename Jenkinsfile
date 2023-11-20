pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "ip-10-101-3-226.ap-northeast-2.compute.internal/fis-20201197-cd4-project/nginx"
        GITHUB_REPO_URL = "https://github.com/xleeboy/fis-20201197-cd4-project-apps.git"
        GITHUB_CREDENTIALS_ID = 'your-github-credentials-id'
    }

    stages {
        stage('Clone repository') {
            steps {
                script {
                    // Clone the repository
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: GITHUB_REPO_URL]]])
                }
            }
        }

        stage('Modify deployment.yaml') {
            steps {
                script {
                    // Update image tag in deployment.yaml
                    sh 'sed -i "s|image: .*|image: ${DOCKER_IMAGE}:latest|" development-deploy/deployment.yaml'
                }
            }
        }

        stage('Git add and commit') {
            steps {
                script {
                    // Stage the modified file
                    sh 'git add development-deploy/deployment.yaml'

                    // Commit the changes
                    sh 'git commit -m "Update image tag"'
                }
            }
        }

        stage('Push Changes to GitHub') {
            steps {
                script {
                    // Push changes to GitHub
                    withCredentials([usernamePassword(credentialsId: github-reg, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'git config --global user.email "xleeboy@gmail.com"'
                        sh 'git config --global user.name "xleeboy"'
                        sh "git push https://${USERNAME}:${PASSWORD}@${GITHUB_REPO_URL} HEAD:main"
                    }
                }
            }
        }
    }
}
