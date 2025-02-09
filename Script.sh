#!/bin/bash

ITEM_NAME=$1
ITEM_PRICE=$2
ADD_VAT=$3

VAT_RATE=0.18

if [ "$ADD_VAT" == "true" ]; then
    FINAL_PRICE=$(echo "$ITEM_PRICE + ($ITEM_PRICE * $VAT_RATE)" | bc)
    ACTION="הוספת מע\"מ"
else
    FINAL_PRICE=$(echo "$ITEM_PRICE / (1 + $VAT_RATE)" | bc)
    ACTION="הורדת מע\"מ"
fi

echo "שם הפריט: $ITEM_NAME"
echo "מחיר התחלתי: $ITEM_PRICE"
echo "פעולה: $ACTION"
echo "מחיר סופי: $FINAL_PRICE"
