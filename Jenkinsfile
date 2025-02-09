pipeline {
    agent any

    stages {
        stage('Validate and Calculate Price') {
            steps {
                bat "script.bat \"%ITEM_NAME%\" \"%PRICE_BEFORE_TAX%\""
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
