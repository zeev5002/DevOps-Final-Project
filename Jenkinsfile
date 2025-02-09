pipeline {
    agent any

    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'Item', description: 'Enter the item name')
        string(name: 'ITEM_PRICE', defaultValue: '100', description: 'Enter the price before VAT')
        choice(name: 'VAT_ACTION', choices: ['Add VAT', 'Remove VAT'], description: 'Choose VAT action')
    }

    stages {
        stage('Checkout Repository') {
            steps {
                // Clone the repository
                git 'https://github.com/zeev5002/DevOps-Final-Project.git'
            }
        }
        stage('Run VAT Calculator') {
            steps {
                script {
                    // Determine VAT action
                    def vatAction = params.VAT_ACTION == 'Add VAT' ? 'true' : 'false'
                    // Run the script with parameters
                    sh "./Script.sh ${params.ITEM_NAME} ${params.ITEM_PRICE} ${vatAction}"
                }
            }
        }
        stage('Generate HTML Output') {
            steps {
                script {
                    // Run the script and capture output
                    def output = sh(script: "./Script.sh ${params.ITEM_NAME} ${params.ITEM_PRICE} ${params.VAT_ACTION == 'Add VAT' ? 'true' : 'false'}", returnStdout: true).trim()
                    // Write the output to an HTML file
                    writeFile file: 'output.html', text: "<pre>${output}</pre>"
                }
            }
        }
        stage('Archive Artifacts') {
            steps {
                // Archive the HTML file as an artifact
                archiveArtifacts artifacts: 'output.html', fingerprint: true
            }
        }
    }
}
