#!/bin/bash

curl "http://localhost:4741/examples/${ID}" \
  --include \
  --request PATCH \
  --header "Authorization: Token token=${TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "example": {
      "text": "'"${TEXT}"'"
    }
  }'

echo
