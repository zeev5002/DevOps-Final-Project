#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <item_name> <item_price> <add_vat(true/false)>"
    exit 1
fi

ITEM_NAME=$1
ITEM_PRICE=$2
ADD_VAT=$3

VAT_RATE=0.18

# Convert boolean input to lowercase (to avoid issues)
ADD_VAT=$(echo "$ADD_VAT" | tr '[:upper:]' '[:lower:]')

if [ "$ADD_VAT" == "true" ]; then
    FINAL_PRICE=$(echo "scale=2; $ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
    ACTION="Added VAT"
elif [ "$ADD_VAT" == "false" ]; then
    FINAL_PRICE=$(echo "scale=2; $ITEM_PRICE / (1 + $VAT_RATE)" | bc)
    ACTION="Removed VAT"
else
    echo "Invalid boolean value for VAT operation. Use 'true' or 'false'."
    exit 1
fi

echo "Item Name: $ITEM_NAME"
echo "Initial Price: $ITEM_PRICE"
echo "Action: $ACTION"
echo "Final Price: $FINAL_PRICE"
