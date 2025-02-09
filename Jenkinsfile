pipeline {
    agent any

    stages {
        stage('Checkout Repository') {
            steps {
                checkout scm
            }
        }
        stage('Set Permissions') {
            steps {
                sh 'chmod +x ./Script.sh'
            }
        }
        stage('Run VAT Calculator') {
            steps {
                sh './Script.sh computer 100 true'
            }
        }
        stage('Generate HTML Output') {
            steps {
                sh 'echo "<h1>VAT Calculation Completed</h1>" > output.html'
                sh 'echo "<button onclick=\\"window.location.href=\'output.html\'\\">לתצוגת ה-HTML</button>" >> output.html'
            }
        }
        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'output.html', fingerprint: true
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
            echo 'Click the HTML Output button in the artifacts section to view results.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
