pipeline {
    agent any

    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'Default Item', description: 'Enter item name')
        string(name: 'ITEM_PRICE', defaultValue: '', description: 'Enter item price')
        choice(name: 'VAT_ACTION', choices: ['Add VAT', 'Remove VAT'], description: 'Choose VAT action')
    }

    stages {
        stage('Run Script') {
            steps {
                sh 'chmod +x ./Script.sh'
                sh './Script.sh "${ITEM_NAME}" "${ITEM_PRICE}" "${VAT_ACTION}"'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'output.html', fingerprint: true
            publishHTML(target: [
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: '.',
                reportFiles: 'output.html',
                reportName: 'VAT Calculation Output'
            ])
        }
    }
}
