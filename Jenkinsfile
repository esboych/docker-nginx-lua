node {
    def app

    stage('Clone repository') {
        /* Cloning the repo to our workspace */
        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        //app = docker.build("esboych/test-nginx-jenkins-op:${env.BUILD_NUMBER}", ".")
        app = docker.build("esboych/test-nginx-jenkins-op", ".")
    }


    stage('Push image') {
        /* Pushing the image to public registry. The "latest" tag used for simplicity */
        docker.withRegistry("https://registry.hub.docker.com", "docker-hub-credentials") {
            app.push("latest")
        }
    }

    sshagent(['08f7edc5-286e-4fba-9883-b8fea9225d1a']) {
        /* Pull and deploy containerised app */
         containerID = sh "ssh -o StrictHostKeyChecking=no -l ubuntu ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker ps | grep test-nginx-jenkins-op | awk '{print \$1}'"
         sh "echo ${containerID}"
        /* First try to delete previous container if any */
         //sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker rm -f \$(sudo docker ps | grep test-nginx-jenkins-op | awk '{print \$1}') || true"
         //sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker rm -f '${containerID}' || true"
         sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker rm -f nginx || true"
        /* Now deploy the new one */
         sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com  sudo docker --name=nginx run -p 80:80 -d esboych/test-nginx-jenkins-op"

    }


}