node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        //app = docker.build("esboych/test-nginx-jenkins-op:${env.BUILD_NUMBER}", ".")
        app = docker.build("esboych/test-nginx-jenkins-op", ".")
    }


    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("latest")
        }
    }

    sshagent(['08f7edc5-286e-4fba-9883-b8fea9225d1a']) {
        /* Pull and deploy containerised app */
         sh 'ssh -o StrictHostKeyChecking=no -l ubuntu ec2-54-191-128-143.us-west-2.compute.amazonaws.com uname -a'
         sh 'ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com sudo docker rm -f esboych/test-nginx-jenkins-op || true'
         sh 'ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com  sudo docker run -p 80:80 -d esboych/test-nginx-jenkins-op'

    }


}