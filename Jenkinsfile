pipeline {
    agent any

    parameters {
        string(name: 'user_input', defaultValue: '0', description: 'Enter a number to check for Fibonacci sequence')
    }

    environment {
        OUTPUT_FILE = 'output.html'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/zeev5002/DevOps-Jenkins-Project.git'  
            }
        }

        stage('Run cmd Script') {
            steps {
                bat script: "script.cmd %user_input%"
            }
        }

        stage('Publish HTML Output') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: '.',
                    reportFiles: OUTPUT_FILE,
                    reportName: 'Fibonacci Check Report'
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: OUTPUT_FILE, fingerprint: true
        }
    }
}
