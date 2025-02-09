pipeline {
    agent any
    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'computer', description: 'Enter item name')
        string(name: 'ITEM_PRICE', defaultValue: '100', description: 'Enter item price')
        choice(name: 'VAT_ACTION', choices: ['Add VAT', 'Remove VAT'], description: 'Choose VAT action')
    }
    stages {
        stage('Run Script') {
            steps {
                script {
                    sh './Script.sh "${ITEM_NAME}" "${ITEM_PRICE}" "${VAT_ACTION}"'
                }
            }
        }
        stage('Generate HTML Output') {
            steps {
                sh '''
                if [ "${VAT_ACTION}" == "Add VAT" ]; then
                    echo "<html><body><h1>VAT Calculation</h1><p>Item Name: ${ITEM_NAME}</p><p>Initial Price: ${ITEM_PRICE}</p><p>Action: VAT Added</p><p>Final Price: $(echo "${ITEM_PRICE} * 1.18" | bc)</p></body></html>" > output.html
                else
                    echo "<html><body><h1>VAT Calculation</h1><p>Item Name: ${ITEM_NAME}</p><p>Initial Price: ${ITEM_PRICE}</p><p>Action: VAT Removed</p><p>Final Price: $(echo "${ITEM_PRICE} / 1.18" | bc)</p></body></html>" > output.html
                fi
                '''
            }
        }
    }
}
