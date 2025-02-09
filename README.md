# DevOps-Jenkins-Project

## 📌 Project Description
This project is a **Jenkins Pipeline** that calculates the exact age of a person (in years, months, and days) based on their birthdate and today's date. The pipeline receives user input via **Jenkins' Build with Parameters**, processes the data using a **Batch Script (`script.bat`)**, and generates an **HTML report (`output.html`)**.

---

## 📌 How It Works
1. **User provides parameters in Jenkins UI**:
   - **NAME** → The person's name.
   - **TODAY_DATE** → The current date (Format: YYYY-MM-DD).
   - **BIRTH_DATE** → The birth date (Format: YYYY-MM-DD).
   
2. **Jenkins Pipeline runs `script.bat`**:
   - Validates the input.
   - Calculates the age in **years, months, and days**.
   - Generates an `output.html` report.

3. **Jenkins displays the HTML report** via **Publish HTML Plugin**.

---

## 📌 Pipeline Structure
The Jenkins pipeline is defined in `Jenkinsfile`, which consists of the following stages:

| **Stage**            | **Description** |
|----------------------|----------------|
| **Clone Repository** | Fetches the latest project files from GitHub. |
| **Run Script**       | Executes `script.bat` to compute the age. |
| **Publish HTML**     | Generates and publishes `output.html`. |

---

## 📌 Parameters (User Input)
These parameters are provided when starting a new Jenkins build:

| **Parameter**  | **Type**  | **Default Value** | **Description** |
|---------------|----------|-----------------|----------------|
| `NAME`        | String   | `John Doe`       | Person's full name. |
| `TODAY_DATE`  | String   | `2025-02-09`     | The current date (YYYY-MM-DD). |
| `BIRTH_DATE`  | String   | `2000-01-01`     | Person's birth date (YYYY-MM-DD). |

📌 **Input Validation:**  
- If the user provides an invalid date format, the pipeline will **not fail** but will **display a warning message**.

---

## 📌 Jenkinsfile Configuration
The pipeline is defined in `Jenkinsfile`, which executes the batch script:

```groovy
pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/zeev5002/DevOps-Jenkins-Project.git'
            }
        }
        stage('Run Script') {
            steps {
                bat "script.bat \"%NAME%\" \"%TODAY_DATE%\" \"%BIRTH_DATE%\""
            }
        }
        stage('Publish HTML Output') {
            steps {
                publishHTML(target: [
                    reportDir: '',
                    reportFiles: 'output.html',
                    reportName: 'Age Calculation Result'
                ])
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
