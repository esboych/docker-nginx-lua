pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Example step 1'
            }
        }
    }
    post {
          checkout scm

            def customImage = docker.build("my-image:${env.BUILD_ID}")

            customImage.inside {
                sh 'make test'
            }
    }
}