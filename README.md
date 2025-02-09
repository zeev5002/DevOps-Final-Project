# DevOps-Jenkins-Project

## 📌 Project Description
This project is a **Jenkins Pipeline** that calculates the exact age of a person (in years, months, and days) based on their birthdate and today's date. The pipeline receives user input via **Jenkins' Build with Parameters**, processes the data using a **Batch Script (`script.bat`)**, and generates an **HTML report (`output.html`)**.

---

## 📌 How It Works
1. **User provides parameters in Jenkins UI**:
   - **NAME** → The person's name.
   - **TODAY_DATE** → The current date (Format: DD-MM-YYYY).
   - **BIRTH_DATE** → The birth date (Format: DD-MM-YYYY).

2. **Jenkins Pipeline runs `script.bat`**:
   - Validates the input.
   - Calculates the age in **years, months, and days**.
   - Generates an `output.html` report.

3. **Jenkins displays the HTML report** via **Publish HTML Plugin**.

---

## 📌 Parameters (User Input)
These parameters are provided when starting a new Jenkins build:

| **Parameter**  | **Type**  | **Default Value** | **Description** |
|---------------|----------|-----------------|----------------|
| `NAME`        | String   | `Zeev Leiderman` | Person's full name. |
| `TODAY_DATE`  | String   | `09-02-2025`     | The current date (DD-MM-YYYY). |
| `BIRTH_DATE`  | String   | `01-01-2000`     | Person's birth date (DD-MM-YYYY). |

📌 **Input Validation:**  
- If the user provides an invalid date format, the pipeline will **not fail** but will **display a warning message**.

---

## 📌 Running the Pipeline
1. Open **Jenkins** (`http://localhost:8080`).
2. Go to the **DevOps-Pipeline-Final-project**.
3. Click on **"Build with Parameters"**.
4. Enter values for `NAME`, `TODAY_DATE`, and `BIRTH_DATE` in **DD-MM-YYYY** format.
5. Click **"Build"**.
6. View the HTML report in Jenkins after the pipeline runs successfully.

---

## 📌 Example Output
**Input Parameters:**
