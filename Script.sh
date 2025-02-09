#!/bin/bash

ITEM_NAME=$1
ITEM_PRICE=$2
VAT_ACTION=$3

# ולידציות
if ! [[ "$ITEM_PRICE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: Item price must be a valid number."
    exit 1
fi

if [[ -z "$ITEM_NAME" ]]; then
    echo "Error: Item name cannot be empty."
    exit 1
fi

# חישוב מע"מ
VAT_RATE=0.18
if [[ "$VAT_ACTION" == "Add VAT" ]]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
elif [[ "$VAT_ACTION" == "Remove VAT" ]]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE / (1 + $VAT_RATE)" | bc)
else
    echo "Error: Invalid VAT action."
    exit 1
fi

# פלט
echo "Item Name: $ITEM_NAME"
echo "Initial Price: $ITEM_PRICE"
echo "Action: $VAT_ACTION"
echo "Final Price: $FINAL_PRICE"

# יצירת HTML
cat <<EOL > output.html
<h1>VAT Calculation Completed</h1>
<p>Item Name: $ITEM_NAME</p>
<p>Item Price: $ITEM_PRICE</p>
<p>VAT Action: $VAT_ACTION</p>
<p>Final Price: $FINAL_PRICE</p>
EOL
