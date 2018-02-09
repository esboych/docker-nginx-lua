pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Example step 1'
            }
        }
        stage('Build container') {
            steps {
                docker.build("test-nginx-jenkins-op:${env.BUILD_NUMBER}")
            }
        }
    }
    post {
        always {
            echo 'Finished!'
        }
    }
}