#!/bin/bash

ITEM_NAME=$1       # Name of the item
ITEM_PRICE=$2      # Price of the item before VAT
ADD_VAT=$3         # Add VAT (true/false)

VAT_RATE=0.18      # VAT rate (18%)

# Check if ADD_VAT is true or false
if [ "$ADD_VAT" == "true" ]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
    ACTION="Added VAT"
else
    FINAL_PRICE=$(echo "$ITEM_PRICE / (1 + $VAT_RATE)" | bc)
    ACTION="Removed VAT"
fi

# Output result in English
echo "Item Name: $ITEM_NAME"
echo "Original Price: $ITEM_PRICE"
echo "Action: $ACTION"
echo "Final Price: $FINAL_PRICE"
