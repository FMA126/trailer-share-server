#!/bin/bash

curl "http://localhost:4741/trailers/" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "trailer": {
      "make": "'"${MAKE}"'",
      "model": "'"${MODEL}"'",
      "user_id": "'"${USER}"'"
    }
  }'

echo
