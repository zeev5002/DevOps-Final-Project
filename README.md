# DevOps Final Project - VAT Calculation

## 📌 Project Overview
This project is a **Jenkins Pipeline** that automates the execution of a **Bash script** for VAT (Value Added Tax) calculations.  
The script receives parameters from Jenkins, validates them, performs VAT calculations, and generates an **HTML output report**.

---

## ⚙️ How It Works
1. **User inputs parameters** (Item Name, Item Price, VAT Action) in Jenkins.
2. **Jenkins triggers the pipeline** which runs the Bash script.
3. **The script validates the inputs**:
   - Ensures the item name contains only letters.
   - Ensures the price is a valid number.
   - Displays warnings for invalid inputs (without breaking execution).
4. **VAT Calculation**:
   - If "Add VAT" is selected → Adds **18% VAT** to the price.
   - If "Remove VAT" is selected → Removes **18% VAT** from the price.
5. **Generates an HTML report** displaying:
   - The original and final price.
   - Any validation warnings (if applicable).
6. **Jenkins archives the output and publishes it** as an HTML page.

## 🔗 Links & Resources
- 📜 **Repository**: [GitHub Repo](https://github.com/zeev5002/DevOps-Final-Project)
- 🛠️ **Script File**: [`Script.sh`](https://github.com/zeev5002/DevOps-Final-Project/blob/master/Script.sh)
- 📄 **Jenkinsfile**: [`Jenkinsfile`](https://github.com/zeev5002/DevOps-Final-Project/blob/master/Jenkinsfile)

## ✅ Features & Validations
✔ **Handles invalid inputs gracefully (warnings in HTML output).**  
✔ **Supports both VAT addition & removal.**  
✔ **Fully automated via Jenkins.**  
✔ **Archives & publishes HTML report for easy viewing.**  