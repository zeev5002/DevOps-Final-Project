#!/bin/bash

ITEM_NAME=$1
ITEM_PRICE=$2
VAT_ACTION=$3

# Initialize validation errors
ERRORS=""

# Validate ITEM_NAME
if [[ -z "$ITEM_NAME" ]]; then
    ERRORS+="<p>Warning: Item name is missing.</p>"
    ITEM_NAME="N/A"
elif ! [[ "$ITEM_NAME" =~ ^[a-zA-Z\ ]+$ ]]; then
    ERRORS+="<p>Warning: Invalid item name. Name must contain only letters and spaces.</p>"
    ITEM_NAME="N/A"
fi

# Validate ITEM_PRICE
if ! [[ "$ITEM_PRICE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    ERRORS+="<p>Warning: Invalid item price. Price must be a number.</p>"
    ITEM_PRICE="N/A"
fi

# Calculate FINAL_PRICE
if [[ "$ITEM_PRICE" != "N/A" ]]; then
    if [[ "$VAT_ACTION" == "Add VAT" ]]; then
        FINAL_PRICE=$(echo "$ITEM_PRICE * 1.18" | bc -l)
    elif [[ "$VAT_ACTION" == "Remove VAT" ]]; then
        FINAL_PRICE=$(echo "$ITEM_PRICE / 1.18" | bc -l)
    else
        ERRORS+="<p>Warning: Invalid VAT action selected.</p>"
        FINAL_PRICE="N/A"
    fi
else
    FINAL_PRICE="N/A"
fi

# Format FINAL_PRICE to 2 decimal places if it's a number
if [[ "$FINAL_PRICE" != "N/A" ]]; then
    FINAL_PRICE=$(printf "%.2f" "$FINAL_PRICE")
fi

# Generate HTML output
cat <<EOL > output.html
<h1>VAT Calculation Completed</h1>
<p>Item Name: $ITEM_NAME</p>
<p>Item Price: $ITEM_PRICE</p>
<p>VAT Action: $VAT_ACTION</p>
<p>Final Price: $FINAL_PRICE</p>
$ERRORS
EOL
