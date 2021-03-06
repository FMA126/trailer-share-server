#!/bin/bash

curl "http://localhost:4741/trailers/${ID}" \
  --include \
  --request PATCH \
  --header "Authorization: Token token=${TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "trailer": {
      "make": "'"${MAKE}"'",
      "model": "'"${MODEL}"'",
      "year": "'"${YEAR}"'",
      "trailer_type": "'"${TRAILER_TYPE}"'",
      "hitch_type": "'"${HITCH_TYPE}"'",
      "length": "'"${LENGTH}"'",
      "gvwr": "'"${GVWR}"'",
      "axels": "'"${AXELS}"'",
      "picture": "'"${PICTURE}"'",
      "price": "'"${PRICE}"'"
    }
  }'

echo
