pipeline {
    agent any

    stages {
        stage('Checkout Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/zeev5002/DevOps-Final-Project.git'
            }
        }

        stage('Set Permissions') {
            steps {
                sh 'chmod +x ./Script.sh'
                sh 'ls -l ./Script.sh'
            }
        }

        stage('Run VAT Calculator') {
            steps {
                script {
                    def status = sh(script: './Script.sh computer 100 true', returnStatus: true)
                    if (status != 0) {
                        error("Script execution failed with exit code ${status}")
                    }
                }
            }
        }

        stage('Generate HTML Output') {
            steps {
                sh 'echo "<h1>VAT Calculation Completed</h1>" > output.html'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'output.html', fingerprint: true
            }
        }
    }
}
