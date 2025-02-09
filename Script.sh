#!/bin/bash

ITEM_NAME=$1
ITEM_PRICE=$2
ADD_VAT=$3

# Validate parameters
if ! [[ "$ITEM_PRICE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  echo "Error: ITEM_PRICE must be a number."
  exit 1
fi

if [[ -z "$ITEM_NAME" ]]; then
  echo "Error: ITEM_NAME cannot be empty."
  exit 1
fi

VAT_RATE=0.18
if [ "$ADD_VAT" == "true" ]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
    ACTION="Added VAT"
else
    FINAL_PRICE=$(echo "$ITEM_PRICE / (1 + $VAT_RATE)" | bc)
    ACTION="Removed VAT"
fi

echo "Item Name: $ITEM_NAME"
echo "Initial Price: $ITEM_PRICE"
echo "Action: $ACTION"
echo "Final Price: $FINAL_PRICE"

# Generate HTML output
cat <<EOF > output.html
<html>
<head><title>VAT Calculation</title></head>
<body>
<h1>VAT Calculation Result</h1>
<p>Item Name: $ITEM_NAME</p>
<p>Initial Price: $ITEM_PRICE</p>
<p>Action: $ACTION</p>
<p>Final Price: $FINAL_PRICE</p>
</body>
</html>
EOF
