#!/bin/bash

# Parameters
ITEM_NAME=$1
ITEM_PRICE=$2
ADD_VAT=$3

VAT_RATE=0.18
HTML_FILE="output.html"
ERROR_MESSAGE=""

# Validation for ITEM_NAME (should not be a number)
if [[ "$ITEM_NAME" =~ ^[0-9]+$ ]]; then
    ERROR_MESSAGE="Error: Item name cannot be a number."
fi

# Validation for ITEM_PRICE (should be a number)
if ! [[ "$ITEM_PRICE" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    ERROR_MESSAGE="Error: Item price must be a valid number."
fi

# If validation fails, generate error HTML and exit
if [[ -n "$ERROR_MESSAGE" ]]; then
    echo "<h1>Validation Failed</h1>" > $HTML_FILE
    echo "<p>$ERROR_MESSAGE</p>" >> $HTML_FILE
    exit 0
fi

# Calculation
if [ "$ADD_VAT" == "true" ]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
    ACTION="Added VAT"
else
    FINAL_PRICE=$(echo "$ITEM_PRICE / (1 + $VAT_RATE)" | bc)
    ACTION="Removed VAT"
fi

# Generate HTML Output
echo "<h1>VAT Calculation</h1>" > $HTML_FILE
echo "<p>Item Name: $ITEM_NAME</p>" >> $HTML_FILE
echo "<p>Initial Price: $ITEM_PRICE</p>" >> $HTML_FILE
echo "<p>Action: $ACTION</p>" >> $HTML_FILE
echo "<p>Final Price: $FINAL_PRICE</p>" >> $HTML_FILE
