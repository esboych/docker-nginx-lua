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
        always {
            echo 'example step 2-1'
        }
    }
}