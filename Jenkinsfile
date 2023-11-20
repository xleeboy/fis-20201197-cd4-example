node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
         app = docker.build("fis-20201197-cd4-project/nginx")
         
     }
     stage('Push image') {
         docker.withRegistry('https://ip-10-101-3-226.ap-northeast-2.compute.internal/', 'harbor-reg') {
             app.push("${env.BUILD_NUMBER}")
             app.push("latest")
         }
     }
     
     stage('Modify deployment.yaml') {
        steps {
            script {
                // yq를 사용하여 deployment.yaml 파일에서 이미지 필드 업데이트
                sh 'yq eval \'(.spec.template.spec.containers[0].image) = "ip-10-101-3-226.ap-northeast-2.compute.internal/fis-20201197-cd4-project/nginx:new-tag"\' -i development-deploy/deployment.yaml'
            }
        }
    }

    stage('Git add and commit') {
        steps {
            script {
                // 수정된 파일 스테이징
                sh 'git add development-deploy/deployment.yaml'

                // 변경 내용 커밋
                sh 'git commit -m "development-deploy/deployment.yaml 업데이트"'
            }
        }
    }

    stage('GitHub에 변경 사항 푸시') {
        steps {
            script {
                // GitHub에 변경 사항 푸시
                withCredentials([usernamePassword(credentialsId: 'github-reg', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'git config --global user.email "xleeboy@gmail.com"'
                    sh 'git config --global user.name "xleeboy"'
                    sh "git push https://${USERNAME}:${PASSWORD}@github.com/xleeboy/fis-20201197-cd4-project-apps.git HEAD:main"
                }
            }
        }
    }
}
