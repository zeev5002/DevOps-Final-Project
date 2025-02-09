#!/bin/bash

ITEM_NAME=$1
ITEM_PRICE=$2
VAT_ACTION=$3

if [[ -z "$ITEM_NAME" ]]; then
    echo "Warning: Item name is missing." >> output.html
    ITEM_NAME="N/A"
fi

if ! [[ "$ITEM_PRICE" =~ ^[0-9]+(\\.[0-9]+)?$ ]]; then
    echo "Warning: Invalid item price. Price must be a number." >> output.html
    ITEM_PRICE="N/A"
fi

if [[ "$ITEM_PRICE" != "N/A" ]]; then
    if [[ "$VAT_ACTION" == "Add VAT" ]]; then
        FINAL_PRICE=$(echo "$ITEM_PRICE * 1.18" | bc)
    elif [[ "$VAT_ACTION" == "Remove VAT" ]]; then
        FINAL_PRICE=$(echo "$ITEM_PRICE / 1.18" | bc)
    else
        FINAL_PRICE="N/A"
    fi
else
    FINAL_PRICE="N/A"
fi

cat <<EOL > output.html
<h1>VAT Calculation Completed</h1>
<p>Item Name: $ITEM_NAME</p>
<p>Item Price: $ITEM_PRICE</p>
<p>VAT Action: $VAT_ACTION</p>
<p>Final Price: $FINAL_PRICE</p>
EOL
