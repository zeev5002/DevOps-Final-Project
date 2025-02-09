#!/bin/bash

# Parameters
ITEM_NAME=$1       # Name of the item
ITEM_PRICE=$2      # Price of the item before VAT
VAT_ACTION=$3      # Add or remove VAT (true/false)

# Constants
VAT_RATE=0.18      # VAT rate (18%)

# Validate parameters
if [[ -z "$ITEM_NAME" || -z "$ITEM_PRICE" || -z "$VAT_ACTION" ]]; then
    echo "Error: Missing required parameters."
    echo "Usage: ./Script.sh <ITEM_NAME> <ITEM_PRICE> <VAT_ACTION>"
    exit 1
fi

if ! [[ "$ITEM_PRICE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: ITEM_PRICE must be a numeric value."
    exit 1
fi

if [[ "$VAT_ACTION" != "true" && "$VAT_ACTION" != "false" ]]; then
    echo "Error: VAT_ACTION must be 'true' (Add VAT) or 'false' (Remove VAT)."
    exit 1
fi

# Calculate final price
if [ "$VAT_ACTION" == "true" ]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
    ACTION="Added VAT"
else
    FINAL_PRICE=$(echo "$ITEM_PRICE / (1 + $VAT_RATE)" | bc)
    ACTION="Removed VAT"
fi

# Output result
echo "Item Name: $ITEM_NAME"
echo "Original Price: $ITEM_PRICE"
echo "Action: $ACTION"
echo "Final Price: $FINAL_PRICE"
