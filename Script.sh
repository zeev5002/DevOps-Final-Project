#!/bin/bash

ITEM_NAME=$1
ITEM_PRICE=$2
VAT_ACTION=$3

# Validation
if ! [[ "$ITEM_PRICE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: ITEM_PRICE must be a valid number." >&2
    exit 1
fi

if [[ "$VAT_ACTION" == "Add VAT" ]]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE * 1.18" | bc)
    ACTION="VAT Added"
elif [[ "$VAT_ACTION" == "Remove VAT" ]]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE / 1.18" | bc)
    ACTION="VAT Removed"
else
    echo "Error: Invalid VAT_ACTION. Use 'Add VAT' or 'Remove VAT'." >&2
    exit 1
fi

echo "Item Name: $ITEM_NAME"
echo "Initial Price: $ITEM_PRICE"
echo "Action: $ACTION"
echo "Final Price: $FINAL_PRICE"
