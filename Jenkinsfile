pipeline {
    agent any
    parameters {
        string(name: 'ITEM_NAME', defaultValue: 'computer', description: 'Enter item name')
        string(name: 'ITEM_PRICE', defaultValue: '100', description: 'Enter item price')
        booleanParam(name: 'ADD_VAT', defaultValue: true, description: 'Add VAT?')
    }
    stages {
        stage('Run Script') {
            steps {
                script {
                    sh """
                    ./Script.sh ${params.ITEM_NAME} ${params.ITEM_PRICE} ${params.ADD_VAT}
                    """
                }
            }
        }
        stage('Generate HTML Output') {
            steps {
                sh """
                echo "<html><body><h1>Output</h1><p>Item Name: ${params.ITEM_NAME}</p><p>Price: ${params.ITEM_PRICE}</p><p>VAT Added: ${params.ADD_VAT}</p></body></html>" > output.html
                """
            }
        }
    }
}
