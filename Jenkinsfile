node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("esboych/test-nginx-jenkins-op:${env.BUILD_NUMBER}", ".")
    }


    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            /* app.push("${env.BUILD_NUMBER}") */
            app.push("latest")
        }
    }

        stage('Deploy image') {
            /* ssh to host machine and run newly pushed image */
            echo 'ssh to web server and tell it to pull new image'
            sh 'ssh ubuntu@ec2-54-191-128-143.us-west-2.compute.amazonaws.com ls -la'
            
        }
}