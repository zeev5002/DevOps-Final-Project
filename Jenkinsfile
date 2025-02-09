pipeline {
    agent any
    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'computer', description: 'Enter item name')
        string(name: 'ITEM_PRICE', defaultValue: '100', description: 'Enter item price')
        choice(name: 'VAT_ACTION', choices: ['Add VAT', 'Remove VAT'], description: 'Choose VAT action')
    }
    stages {
        stage('Checkout Repository') {
            steps {
                git url: 'https://github.com/zeev5002/DevOps-Final-Project.git', branch: 'master'
            }
        }
        stage('Set Permissions') {
            steps {
                sh 'chmod +x ./Script.sh'
            }
        }
        stage('Run Script') {
            steps {
                sh './Script.sh "${ITEM_NAME}" "${ITEM_PRICE}" "${VAT_ACTION}"'
            }
        }
        stage('Generate HTML Output') {
            steps {
                writeFile file: 'output.html', text: '''
                <html>
                <head><title>VAT Calculation Result</title></head>
                <body>
                    <h1>VAT Calculation Completed</h1>
                    <p>Item Name: ${ITEM_NAME}</p>
                    <p>Item Price: ${ITEM_PRICE}</p>
                    <p>VAT Action: ${VAT_ACTION}</p>
                </body>
                </html>
                '''
                archiveArtifacts artifacts: 'output.html'
            }
        }
        stage('View HTML Output') {
            steps {
                echo 'Output available as HTML artifact. View via Jenkins artifacts or add custom link.'
            }
        }
    }
}
