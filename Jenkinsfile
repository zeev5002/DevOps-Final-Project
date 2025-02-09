pipeline {
    agent any

    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'מוצר', description: 'שם הפריט')
        string(name: 'ITEM_PRICE', defaultValue: '100', description: 'מחיר לפני מע"מ')
        booleanParam(name: 'ADD_VAT', defaultValue: true, description: 'האם להוסיף מע"מ?')
    }

    stages {
        stage('Checkout Repository') {
            steps {
                git 'https://github.com/zeev5002/DevOps-Final-Project.git'
            }
        }
        stage('Run VAT Calculator') {
            steps {
                sh "./skript.sh ${params.ITEM_NAME} ${params.ITEM_PRICE} ${params.ADD_VAT}"
            }
        }
        stage('Generate HTML Output') {
            steps {
                script {
                    def output = sh(script: "./skript.sh ${params.ITEM_NAME} ${params.ITEM_PRICE} ${params.ADD_VAT}", returnStdout: true).trim()
                    writeFile file: 'output.html', text: "<pre>${output}</pre>"
                }
            }
        }
        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'output.html', fingerprint: true
            }
        }
    }
}
