pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/zeev5002/DevOps-Jenkins-Project.git'
            }
        }
        stage('Run Script') {
            steps {
                bat "script.bat \"%NAME%\" \"%TODAY_DATE%\" \"%BIRTH_DATE%\""
            }
        }
        stage('Publish HTML Output') {
            steps {
                publishHTML(target: [
                    reportDir: '',
                    reportFiles: 'output.html',
                    reportName: 'Age Calculation Result'
                ])
            }
        }
    }
    post {
        success {
            echo "🎉 Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs for details."
        }
    }
}
