/*
Prerequisites:
- jenkins is run in dind container on the same host:
 - - Repo:https://github.com/esboych/docker-jenkins-dind
 - - command: sudo docker run --name jenkins-dind --privileged -p 8080:8080 -d -v /home/ubuntu/jenkins:/var/lib/jenkins esboych/docker-jenkins-dind
- EC2 security group inbound rules: ports # 22, 80, 8080 are enabled for ssh, jenkins web console and nginx respectively
- in Jenkins configuration: GitHub feature enabled, ssh-agent feature enabled
- in Jenkinsfile the sshagent step is autogenerated by Jenkins snippets wizard
- TODO: custom nginx conf, custom webpage
*/

node {
    def app

    stage('Clone repository') {
        /* Cloning the repo to our workspace */
        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to docker build on the command line */
        //app = docker.build("esboych/test-nginx-jenkins-op:${env.BUILD_NUMBER}", ".")
        app = docker.build("esboych/test-nginx-jenkins-op", ".")
    }


    stage('Push image') {
        /* Pushing the image to the public registry. The "latest" tag used for simplicity */
        docker.withRegistry("https://registry.hub.docker.com", "docker-hub-credentials") {
        app.push("latest")
        }
    }

    sshagent(['08f7edc5-286e-4fba-9883-b8fea9225d1a']) {
        /* First connect to remote host */
         sh "ssh -o StrictHostKeyChecking=no -l ubuntu ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker ps"
        /* First try to delete previous container if any */
         //sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker rm -f \$(sudo docker ps | grep test-nginx-jenkins-op | awk '{print \$1}') || true"
         sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker rm -f nginx || true"
        /* Now deploy the new one */
         sh "ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com  sudo docker run --name=nginx -p 80:80 -d esboych/test-nginx-jenkins-op"

    }


}