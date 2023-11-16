node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
         app = docker.build("/fis-20201197-cd4-project/nginx")
         
     }
     stage('Push image') {
         docker.withRegistry('https://ip-10-101-1-161.ap-northeast-2.compute.internal/', 'harbor-reg') {
             app.push("${env.BUILD_NUMBER}")
             app.push("latest")
         }
     }
}
