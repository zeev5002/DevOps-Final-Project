pipeline {
    agent any

    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'default_item', description: 'Enter item name')
        string(name: 'ITEM_PRICE', defaultValue: '100', description: 'Enter item price')
        choice(name: 'VAT_ACTION', choices: ['Add VAT', 'Remove VAT'], description: 'Choose VAT action')
    }

    stages {
        stage('Run Script') {
            steps {
                sh 'chmod +x ./Script.sh'
                sh './Script.sh "${ITEM_NAME}" "${ITEM_PRICE}" "${VAT_ACTION}"'
            }
        }

        stage('Generate HTML Output') {
            steps {
                writeFile file: 'output.html', text: """
                <h1>VAT Calculation Completed</h1>
                <p>Item Name: ${ITEM_NAME}</p>
                <p>Item Price: ${ITEM_PRICE}</p>
                <p>VAT Action: ${VAT_ACTION}</p>
                """
                echo 'HTML file created successfully.'
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
                reportName: 'To -> HTML Output <- '
            ])
        }
    }
}
