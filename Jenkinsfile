pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'GitHub-Credentials', url: 'https://github.com/zeev5002/DevOps-Jenkins-Project.git'
            }
        }
        stage('Run Script') {
            steps {
                bat "script.bat ${params.NUMERIC_PARAM}"
            }
        }
        stage('Publish HTML Output') {
            steps {
                publishHTML(target: [
                    reportDir: '',
                    reportFiles: 'output.html',
                    reportName: 'Execution Output'
                ])
            }
        }
    }
}
