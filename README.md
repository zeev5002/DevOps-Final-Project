# Price Calculation Pipeline

This Jenkins pipeline calculates the final price of an item including VAT (18%).  
It validates the user input to ensure correctness.

## Features:
✅ Accepts **item name** and **price before VAT** as user-defined parameters (via Jenkins UI).  
✅ **Validates input**:  
   - Item name must contain **only letters and spaces**.  
   - Price must be a **numeric value** (no letters or special characters).  
✅ **Automatically calculates VAT (18%) and total price**.  
✅ **Generates an HTML report** with the results.  

## Usage:
1. Go to **Jenkins > Build with Parameters**.
2. Enter **Item Name** (letters only, no numbers/special characters).
3. Enter **Price Before VAT** (numeric only).
4. Run the pipeline.
5. View the **Price Calculation Report** in Jenkins.