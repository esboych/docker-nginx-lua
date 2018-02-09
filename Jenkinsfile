pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Example step 1'
            }
        }
        stage('Build container') {
            try {
                docker.build("test-nginx-jenkins-op:${env.BUILD_NUMBER}")
            } catch(error){}
        }
    }
    post {
        always {
            echo 'Finished!'
        }
    }
}