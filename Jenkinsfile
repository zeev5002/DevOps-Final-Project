pipeline {
    agent any

    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'Default Item', description: 'Item Name')
        string(name: 'PRICE_BEFORE_TAX', defaultValue: '100', description: 'Price Before Tax')
    }

    stages {
        stage('Validate and Calculate Price') {
            steps {
                bat '''
                    script.bat "${ITEM_NAME}" "${PRICE_BEFORE_TAX}"
                    if %ERRORLEVEL% neq 0 exit 1 // בדיקה אם הסקריפט החזיר שגיאה
                '''
            }
        }
        stage('Publish HTML Output') {
            steps {
                publishHTML(target: [
                    reportDir: '',
                    reportFiles: 'output.html',
                    reportName: 'Price Calculation Report'
                ])
            }
        }
    }
}