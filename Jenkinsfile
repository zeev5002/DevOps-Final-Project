pipeline {
    agent any
    parameters {
        string(name: 'NUMERIC_PARAM', defaultValue: '0', description: 'Enter a numeric parameter (integer only)')
    }
    stages {
        stage('Validate Parameter') {
            steps {
                script {
                    if (!params.NUMERIC_PARAM.isInteger()) {
                        error "The parameter NUMERIC_PARAM must be a valid integer."
                    }
                }
                echo "✅ Parameter validation successful: NUMERIC_PARAM = ${params.NUMERIC_PARAM}"
            }
        }
        stage('Clone Repository') {
            steps {
                git 'https://github.com/zeev5002/DevOps-Jenkins-Project.git'
                echo "✅ Repository cloned successfully."
            }
        }
        stage('Run Script') {
            steps {
                bat "script.bat ${params.NUMERIC_PARAM}" // Adjusted for Windows
                echo "✅ Script executed with parameter: ${params.NUMERIC_PARAM}"
            }
        }
        stage('Verify Parameter in HTML') {
            steps {
                script {
                    def htmlContent = readFile('output.html')
                    if (htmlContent.contains("${params.NUMERIC_PARAM}")) {
                        echo "✅ Success: Parameter ${params.NUMERIC_PARAM} exists in the HTML output."
                    } else {
                        error "❌ Failure: Parameter ${params.NUMERIC_PARAM} does not exist in the HTML output."
                    }
                }
            }
        }
        stage('Publish HTML Output') {
            steps {
                publishHTML(target: [
                    reportDir: '', 
                    reportFiles: 'output.html', 
                    reportName: 'Execution Output'
                ])
                echo "✅ HTML output published successfully."
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
